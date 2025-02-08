<%@page import="model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <%@ include file="../layout/head.jsp" %>
    </head>

    <body>

        <%@ include file="../layout/loader.jsp" %>

        <!-- Header -->
        <%@ include file="../layout/header.jsp" %>
        
        <!-- Hero Section -->
        <%@ include file="../layout/hero-section.jsp" %>
        <!-- /Hero Section -->
        
        <div style="height: 200px"></div>

        <!-- Traveling Section -->
        <%@ include file="../layout/traveling-section.jsp" %>
        <!-- /Traveling Section -->

        <!-- Support Section -->
        <%@ include file="../layout/support-section.jsp" %>
        <!-- /Support Section -->

        <!-- Benefit Section -->
        <%@ include file="../layout/benefits-section.jsp" %>
        <!-- /Benefit Section -->

        <!-- Offer Section -->
        <%@ include file="../layout/offer-section.jsp" %>
        <!-- /Offer Section -->

        <!-- Travelers Section -->
        <%@ include file="../layout/travelers-section.jsp" %>
        <!-- /Travelers Section -->

        <!-- Experts Section -->
<!--        <section class="section adavantages-sec bg-light-200">
            <div class="adavantages-sec-bg">
                <img src="${pageContext.request.contextPath}/assets/img/bg/hotel-bg-01.svg" class="bg-1" alt="Img">
                <img src="${pageContext.request.contextPath}/assets/img/bg/hotel-bg-05.svg" class="bg-2" alt="Img">
                <img src="${pageContext.request.contextPath}/assets/img/bg/hotel-bg-06.svg" class="bg-3" alt="Img">
            </div>
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-lg-6">
                        <div>
                            <h2 class="mb-2">Where comfort meets elegance and every guest is treated like family.</h2>
                            <p>Our mission is to create memorable experiences for our guests. We believe that every stay should feel special, whether you’re here for business, leisure, or a special occasion.
                            </p>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="card border-0">
                                        <div class="card-body">
                                            <div class="d-flex align-items-center">
                                                <span class="avatar rounded-icon-md rounded-circle bg-primary flex-shrink-0"><i class="isax isax-map5 fs-24"></i></span>
                                                <div class="ms-3">
                                                    <h6 class="fs-16 mb-2">Exceptional Service</h6>
                                                    <p class="text-truncate line-clamb-3">Our dedicated team prioritizes your comfort and satisfaction,</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="card border-0">
                                        <div class="card-body">
                                            <div class="d-flex align-items-center">
                                                <span class="avatar rounded-icon-md rounded-circle bg-indigo flex-shrink-0">
                                                    <i class="isax isax-location-tick5 fs-24"></i>
                                                </span>
                                                <div class="ms-3">
                                                    <h6 class="fs-16 mb-2">Prime Locations</h6>
                                                    <p class="text-truncate line-clamb-3">Enjoy easy access to local attractions, dining, entertainment.</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="card border-0">
                                        <div class="card-body">
                                            <div class="d-flex align-items-center">
                                                <span class="avatar rounded-icon-md rounded-circle bg-cyan flex-shrink-0">
                                                    <i class="isax isax-ticket-star5 fs-24"></i>
                                                </span>
                                                <div class="ms-3">
                                                    <h6 class="fs-16 mb-2">Quality Accommodations</h6>
                                                    <p class="text-truncate line-clamb-3">Our rooms and facilities are designed with your needs in mind, blending </p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="card border-0">
                                        <div class="card-body">
                                            <div class="d-flex align-items-center">
                                                <span class="avatar rounded-icon-md rounded-circle bg-teal flex-shrink-0">
                                                    <i class="isax isax-ticket-star5 fs-24"></i>
                                                </span>
                                                <div class="ms-3">
                                                    <h6 class="fs-16 mb-2">Personalized Experience</h6>
                                                    <p class="text-truncate line-clamb-3">We tailor our services to meet your preferences, making your stay uniquely. </p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="d-flex align-items-center">
                                <a href="add-hotel.html" class="btn btn-dark me-3"><i class="isax isax-add-circle5 me-2"></i>Add Your Hotel</a>
                                <a href="hotel-grid.html" class="btn btn-primary"><i class="isax isax-calendar5 me-2"></i>Book a Hotel</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div>
                            <div class="section-right-img">
                                <img src="${pageContext.request.contextPath}/assets/img/section-img.png" alt="Img">
                                <div class="card review-rate-top border-0 mb-0">
                                    <div class="card-body d-flex align-items-center">
                                        <div class="avatar-list-stacked avatar-group-md me-2">
                                            <span class="avatar avatar-rounded">
                                                <img class="border border-white" src="${pageContext.request.contextPath}/assets/img/users/user-01.jpg" alt="img">
                                            </span>
                                            <span class="avatar avatar-rounded">
                                                <img class="border border-white" src="${pageContext.request.contextPath}/assets/img/users/user-04.jpg" alt="img">
                                            </span>
                                            <span class="avatar avatar-rounded">
                                                <img class="border border-white" src="${pageContext.request.contextPath}/assets/img/users/user-06.jpg" alt="img">
                                            </span>
                                            <span class="avatar avatar-rounded">
                                                <img class="border border-white" src="${pageContext.request.contextPath}/assets/img/users/user-07.jpg" alt="img">
                                            </span>
                                        </div>
                                        <div>
                                            <div class="d-flex align-items-center fs-12">
                                                <i class="ti ti-star-filled text-warning"></i>
                                                <i class="ti ti-star-filled text-warning"></i>
                                                <i class="ti ti-star-filled text-warning"></i>
                                                <i class="ti ti-star-filled text-warning"></i>
                                                <i class="ti ti-star-filled text-warning me-1"></i>
                                                <p class="fs-14 text-gray-9">5.0</p>
                                            </div>
                                            <p class="fs-14">2K+ Reviews</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>-->
        <!-- /Experts Section -->

        <!-- How It Work Section -->
        <%@ include file="../layout/guidance-section.jsp" %>
        <!-- /How It Work Section -->

        <!-- Testimonial Section -->
        <%@ include file="../layout/testimonial-section.jsp" %>
        <!-- /Testimonial Section -->

        <!-- Faq Section -->
        <%@ include file="../layout/faq-section.jsp" %>
        <!-- Faq Section -->

        <!-- Footer -->
        <%@ include file="../layout/footer.jsp" %>
        <!-- /Footer -->

        <!-- Login Modal -->
        <%@ include file="../layout/loginModal.jsp" %>
        <!-- /Login Modal -->

        <!-- Register Modal -->
        <%@ include file="../layout/registerModal.jsp" %>
        <!-- /Register Modal -->

        <!-- Forgot Password -->
        <%@ include file="../layout/forgot-password.jsp" %>
        <!-- /Forgot Password -->

        <!-- Cursor -->
        <%@ include file="../layout/cursor.jsp" %>
        <!-- /Cursor -->

        <!-- Back to top -->
        <%@ include file="../layout/back-to-top.jsp" %>

        <!-- Script -->
        <%@ include file="../layout/script.jsp" %>
</html>
