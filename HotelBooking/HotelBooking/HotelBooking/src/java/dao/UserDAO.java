package dao;

import model.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import constant.Roles;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

public class UserDAO {

    public int registerUser(User user) {
        String sql = "INSERT INTO Users (Username, FirstName, LastName, PasswordHash, StoredSalt, Email, RoleId, AvatarUrl, GoogleId) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = JDBC.getConnectionWithSqlJdbc(); PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getFirstName());
            ps.setString(3, user.getLastName());
            ps.setString(4, user.getPasswordHash());
            ps.setBytes(5, user.getStoredSalt());
            ps.setString(6, user.getEmail());
            ps.setInt(7, user.getRole().getRoleId());
            ps.setString(8, user.getAvatarUrl());
            ps.setString(9, user.getGoogleId());

            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        return generatedKeys.getInt(1);
                    }
                }
            }
        } catch (Exception e) {
            System.out.println(e);
            e.printStackTrace();
        }
        return -1;
    }

    public boolean isUsernameTaken(String username) {
        String sql = "SELECT * FROM users WHERE username = ?";
        try (Connection con = JDBC.getConnectionWithSqlJdbc(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean isEmailTaken(String email) {
        String sql = "SELECT * FROM users WHERE email = ?";
        try (Connection con = JDBC.getConnectionWithSqlJdbc(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public User getUserByUsername(String username) throws Exception {
        User user = null;
        String sql = "SELECT * FROM Users WHERE Username = ?";

        try (Connection con = JDBC.getConnectionWithSqlJdbc(); PreparedStatement st = con.prepareStatement(sql)) {
            st.setString(1, username);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    user = new User();
                    user.setUserId(rs.getInt("UserID"));
                    user.setUsername(rs.getString("Username"));
                    user.setPasswordHash(rs.getString("PasswordHash"));
                    user.setFirstName(rs.getString("FirstName"));
                    user.setLastName(rs.getString("LastName"));
                    user.setEmail(rs.getString("Email"));
                    user.setAvatarUrl(rs.getString("AvatarUrl"));
                    int roleID = rs.getInt("RoleID");
                    switch (roleID) {
                        case 1 ->
                            user.setRole(Roles.ADMIN);
                        case 3 ->
                            user.setRole(Roles.HOTEL_AGENT);
                        default ->
                            user.setRole(Roles.USER);
                    }
                    user.setStoredSalt(rs.getBytes("StoredSalt"));
                    user.setPhoneNumber(rs.getString("PhoneNumber"));
                    user.setCreatedAt(rs.getDate("CreatedAt"));
                    return user;
                }
            }

        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error! " + e.getMessage());
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return user;
    }

    public User getUserByEmail(String email) throws Exception {
        User user = null;
        String sql = "SELECT * FROM Users WHERE Email = ?";

        try (Connection con = JDBC.getConnectionWithSqlJdbc(); PreparedStatement st = con.prepareStatement(sql)) {
            st.setString(1, email);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    user = new User();
                    user.setUserId(rs.getInt("UserID"));
                    user.setUsername(rs.getString("Username"));
                    user.setPasswordHash(rs.getString("PasswordHash"));
                    user.setFirstName(rs.getString("FirstName"));
                    user.setLastName(rs.getString("LastName"));
                    user.setEmail(rs.getString("Email"));
                    user.setAvatarUrl(rs.getString("AvatarUrl"));
                    int roleID = rs.getInt("RoleID");
                    switch (roleID) {
                        case 1 ->
                            user.setRole(Roles.ADMIN);
                        case 3 ->
                            user.setRole(Roles.HOTEL_AGENT);
                        default ->
                            user.setRole(Roles.USER);
                    }
                    user.setStoredSalt(rs.getBytes("StoredSalt"));
                    user.setPhoneNumber(rs.getString("PhoneNumber"));
                    user.setCreatedAt(rs.getDate("CreatedAt"));
                    return user;
                }
            }

        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error! " + e.getMessage());
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return user;
    }

    public boolean updateUserGoogleId(User user) throws Exception {
        String sql = "UPDATE Users SET GoogleId = ? WHERE UserId = ?";

        try (Connection con = JDBC.getConnectionWithSqlJdbc(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, user.getGoogleId());
            ps.setInt(2, user.getUserId());

            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException | ClassNotFoundException e) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, "Error updating GoogleId", e);
        }
        return false;
    }

    public boolean updateUser(User user) throws Exception {
        String sql = "UPDATE Users SET FirstName=?, LastName=?, Email=?, PhoneNumber=? WHERE UserID=?";
        try (Connection con = JDBC.getConnectionWithSqlJdbc(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, user.getFirstName());
            ps.setString(2, user.getLastName());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getPhoneNumber());
            ps.setInt(5, user.getUserId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updatePasswordByEmail(String email, String newPasswordHash, byte[] newSalt) throws Exception {
        String sql = "UPDATE Users SET PasswordHash = ?, StoredSalt = ? WHERE Email = ?";
        try (Connection con = JDBC.getConnectionWithSqlJdbc(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, newPasswordHash);
            ps.setBytes(2, newSalt);
            ps.setString(3, email);

            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException | ClassNotFoundException e) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, "Error updating password by email", e);
        }
        return false;
    }
    
    public boolean updateUserAvatar(String avatarUrl, int userId) throws Exception {
        String sql = "UPDATE Users SET AvatarUrl = ? WHERE UserId = ?";
        try (Connection con = JDBC.getConnectionWithSqlJdbc(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, avatarUrl);
            ps.setInt(2, userId);

            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException | ClassNotFoundException e) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, "Error updating avatarUrl by userId", e);
        }
        return false;
    }
}
