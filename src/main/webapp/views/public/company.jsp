<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Công Ty Nổi Bật | ATS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">

    <style>
        body { font-family: 'Inter', sans-serif; color: #333; background-color: #f8fbff; }
        .navbar-brand img { height: 40px; }
        .nav-link { font-weight: 500; color: #555; }
        footer { padding: 60px 0 20px; border-top: 1px solid #eee; font-size: 0.9rem; background: #fff; margin-top: 60px;}
        
        .hero-section { padding: 60px 0; background: linear-gradient(135deg, #007bff 0%, #00b4db 100%); color: white; border-radius: 0 0 30px 30px; margin-bottom: 40px;}
        .company-card { background: #fff; border: 1px solid #eee; border-radius: 15px; padding: 30px; text-align: center; transition: 0.3s; box-shadow: 0 5px 15px rgba(0,0,0,0.02); height: 100%; }
        .company-card:hover { transform: translateY(-5px); box-shadow: 0 10px 25px rgba(0,123,255,0.1); border-color: #007bff; }
        .company-logo { width: 80px; height: 80px; border-radius: 15px; object-fit: cover; margin-bottom: 15px; border: 1px solid #f1f5f9; }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-light bg-white sticky-top py-3 shadow-sm">
        <div class="container">
            <a class="navbar-brand d-flex align-items-center" href="${pageContext.request.contextPath}/home"><i class="bi bi-building-fill text-primary me-2 fs-3"></i><span class="fw-bold fs-4 text-primary">ATS</span></a>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav mx-auto">
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/jobs">Việc làm</a></li>
                    <li class="nav-item"><a class="nav-link text-primary fw-bold" href="${pageContext.request.contextPath}/company">Công ty</a></li>
                                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/about">Giới thiệu</a></li>
                    
                </ul>
                <div class="d-flex align-items-center">
                    <c:choose>
                        <%-- Đã sửa thành currentUser --%>
                        <c:when test="${not empty sessionScope.currentUser}">
                            <div class="dropdown">
                                <a class="btn btn-outline-primary rounded-pill px-4 dropdown-toggle d-flex align-items-center" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    <i class="bi bi-person-circle me-2"></i> ${sessionScope.currentUser.fullName}
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end shadow-sm mt-2">
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/candidate/dashboard"><i class="bi bi-grid-fill me-2 text-muted"></i> Quản lý hồ sơ</a></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/candidate/applied-jobs"><i class="bi bi-briefcase-fill me-2 text-muted"></i> Việc làm đã nộp</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/auth/logout"><i class="bi bi-box-arrow-right me-2"></i> Đăng xuất</a></li>
                                </ul>
                            </div>
                        </c:when>
                        <%-- Đã sửa đường dẫn thành /auth/... --%>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/auth/login" class="btn btn-link text-dark text-decoration-none me-3">Đăng nhập</a>
                            <a href="${pageContext.request.contextPath}/auth/register" class="btn btn-primary px-4 rounded-pill">Đăng ký ngay</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </nav>

    <section class="hero-section text-center">
        <div class="container">
            <h1 class="fw-bold mb-3 display-5 text-white">Khám phá ${totalRecruiters} Công ty hàng đầu</h1>
            <p class="fs-5 opacity-75 mb-4">Tìm hiểu văn hóa doanh nghiệp và cơ hội việc làm hấp dẫn nhất.</p>
            <div class="bg-white p-2 rounded-pill mx-auto d-flex" style="max-width: 600px;">
                <form action="${pageContext.request.contextPath}/recruiters" method="GET" class="w-100 d-flex">
                    <input type="text" name="keyword" class="form-control border-0 shadow-none bg-transparent px-4" placeholder="Nhập tên công ty...">
                    <button type="submit" class="btn btn-primary rounded-pill px-4 fw-bold">Tìm kiếm</button>
                </form>
            </div>
        </div>
    </section>

    <div class="container py-4">
        <div class="d-flex justify-content-between align-items-end mb-4">
            <h3 class="fw-bold mb-0 border-start border-4 border-primary ps-3">Top Nhà Tuyển Dụng</h3>
            <a href="${pageContext.request.contextPath}/recruiters" class="btn btn-outline-primary rounded-pill px-4">Xem tất cả <i class="bi bi-arrow-right"></i></a>
        </div>

        <div class="row g-4">
            <c:forEach var="recruiter" items="${featuredRecruiters}">
                <div class="col-md-4 col-lg-3">
                    <div class="company-card">
                        <img src="https://ui-avatars.com/api/?name=${recruiter.fullName}&background=random&size=150" class="company-logo" alt="Logo">
                        <h5 class="fw-bold text-dark text-truncate" title="${recruiter.fullName}">${recruiter.fullName}</h5>
                        <p class="text-muted small mb-3"><i class="bi bi-geo-alt me-1"></i>Việt Nam</p>
                        <a href="${pageContext.request.contextPath}/recruiter-detail?id=${recruiter.id}" class="btn btn-light text-primary w-100 rounded-pill fw-bold">Xem hồ sơ</a>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <footer><div class="container text-center small text-muted">© 2026 ATS Recruitment System.</div></footer>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>