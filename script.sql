USE hotel_booking;
GO

-- Roles
CREATE TABLE Roles (
    RoleId INT PRIMARY KEY IDENTITY(1,1),
    RoleName NVARCHAR(50) NOT NULL
);

-- Users
CREATE TABLE Users (
    UserId INT PRIMARY KEY IDENTITY(1,1),
    Username NVARCHAR(50) NOT NULL,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    IsActive BIT NOT NULL DEFAULT 0,
    IsBanned BIT NOT NULL DEFAULT 0,
    IsDeleted BIT NOT NULL DEFAULT 0,
    AvatarUrl NVARCHAR(150) NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(MAX) NULL,
    StoredSalt VARBINARY(MAX),
    GoogleId NVARCHAR(255) NULL UNIQUE,
    PhoneNumber NVARCHAR(15),
    RoleId INT NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (RoleId) REFERENCES Roles(RoleId),
    CONSTRAINT CK_Users_Password_GoogleId CHECK (
        (GoogleId IS NOT NULL AND PasswordHash IS NULL) 
        OR (GoogleId IS NULL OR PasswordHash IS NOT NULL)
    )
);

-- Hotels
CREATE TABLE Hotels (
    HotelId INT PRIMARY KEY IDENTITY(1,1),
    HotelName NVARCHAR(100) NOT NULL,
    Location NVARCHAR(200) NOT NULL,
    Description NVARCHAR(MAX),
    IsAccepted BIT NOT NULL DEFAULT 1,
    HotelImageURLs NVARCHAR(MAX),
    HotelAgentId INT NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (HotelAgentId) REFERENCES Users(UserId)
);

-- Room Types
CREATE TABLE RoomTypes (
    RoomTypeId INT PRIMARY KEY IDENTITY(1,1),
    RoomTypeName NVARCHAR(50) NOT NULL UNIQUE
);

-- Rooms
CREATE TABLE Rooms (
    RoomId INT PRIMARY KEY IDENTITY(1,1),
    HotelId INT NOT NULL,
    RoomNumber NVARCHAR(20) NOT NULL,
    RoomDescription NVARCHAR(MAX),
    RoomTypeId INT NOT NULL,
    PricePerNight DECIMAL(18,2) NOT NULL,
    Capacity INT NOT NULL,
    IsAvailable BIT NOT NULL DEFAULT 1,
    FOREIGN KEY (HotelId) REFERENCES Hotels(HotelId),
    FOREIGN KEY (RoomTypeId) REFERENCES RoomTypes(RoomTypeId)
);

-- Booking Transactions (To group multiple room bookings)
CREATE TABLE BookingTransactions (
    TransactionId INT PRIMARY KEY IDENTITY(1,1),
    UserId INT NOT NULL,
    TotalAmount DECIMAL(18,2) NOT NULL,
    PaymentStatus NVARCHAR(50) NOT NULL DEFAULT 'Pending', -- Pending, Completed, Failed, Refunded
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (UserId) REFERENCES Users(UserId)
);

-- Bookings (Each record links to a single room but belongs to a transaction)
CREATE TABLE Bookings (
    BookingId INT PRIMARY KEY IDENTITY(1,1),
    TransactionId INT NOT NULL,
    RoomId INT NOT NULL,
    CheckInDate DATETIME NOT NULL,
    CheckOutDate DATETIME NOT NULL,
    PricePerNight DECIMAL(18,2) NOT NULL,
    Quantity INT NOT NULL DEFAULT 1,
    TotalAmount AS (PricePerNight * Quantity + ISNULL(TotalServiceAmount, 0)) PERSISTED,
    BookingStatus NVARCHAR(50) NOT NULL DEFAULT 'Pending',
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    TotalServiceAmount DECIMAL(18,2) NOT NULL DEFAULT 0,  -- New column for total service amount
    FOREIGN KEY (TransactionId) REFERENCES BookingTransactions(TransactionId),
    FOREIGN KEY (RoomId) REFERENCES Rooms(RoomId)
);

-- Hotel Services (Predefined & Customizable)
CREATE TABLE HotelServices (
    ServiceId INT PRIMARY KEY IDENTITY(1,1),
    ServiceName NVARCHAR(100) NOT NULL UNIQUE,
    HotelServiceEstimatedPrice DECIMAL(18,2) NULL,
    HotelServiceDescription NVARCHAR(MAX) NULL
);

-- Linking Hotels with Services
CREATE TABLE Hotel_HotelService (
    HotelId INT NOT NULL,
    ServiceId INT NOT NULL,
    HotelServiceImageURLs NVARCHAR(MAX),
    HotelServicePrice DECIMAL(18,2) NOT NULL,
    PRIMARY KEY (HotelId, ServiceId),
    FOREIGN KEY (HotelId) REFERENCES Hotels(HotelId),
    FOREIGN KEY (ServiceId) REFERENCES HotelServices(ServiceId)
);

-- Room Facilities (Predefined & Customizable)
CREATE TABLE RoomFacilities (
    FacilityId INT PRIMARY KEY IDENTITY(1,1),
    FacilityName NVARCHAR(100) NOT NULL UNIQUE
);

-- Linking Rooms with Facilities
CREATE TABLE Room_RoomFacility (
    RoomId INT NOT NULL,
    FacilityId INT NOT NULL,
    Note NVARCHAR(MAX) NULL,
    PRIMARY KEY (RoomId, FacilityId),
    FOREIGN KEY (RoomId) REFERENCES Rooms(RoomId),
    FOREIGN KEY (FacilityId) REFERENCES RoomFacilities(FacilityId)
);

-- Feedback for Hotels
CREATE TABLE Feedback (
    FeedbackId INT PRIMARY KEY IDENTITY(1,1),
    UserId INT NOT NULL,
    HotelId INT NOT NULL,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comment NVARCHAR(MAX),
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (UserId) REFERENCES Users(UserId),
    FOREIGN KEY (HotelId) REFERENCES Hotels(HotelId)
);

-- Favorite Hotels
CREATE TABLE Favorites (
    UserId INT NOT NULL,
    HotelId INT NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    PRIMARY KEY (UserId, HotelId),
    FOREIGN KEY (UserId) REFERENCES Users(UserId),
    FOREIGN KEY (HotelId) REFERENCES Hotels(HotelId)
);

-- Insert Default Data
INSERT INTO Roles (RoleName)
VALUES ('Admin'), ('Customer'), ('Hotel Agent');

CREATE TABLE BookingServices (
    BookingServiceId INT PRIMARY KEY IDENTITY(1,1),
    BookingId INT NOT NULL,
    ServiceId INT NOT NULL,
    Quantity INT NOT NULL DEFAULT 1,
    ServicePrice DECIMAL(18,2) NOT NULL,
    TotalPrice AS (Quantity * ServicePrice) PERSISTED,
    FOREIGN KEY (BookingId) REFERENCES Bookings(BookingId) ON DELETE CASCADE,
    FOREIGN KEY (ServiceId) REFERENCES HotelServices(ServiceId)
);