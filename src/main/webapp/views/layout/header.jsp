<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${title} | ATS Recruitment</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    
    <style>
        body { font-family: 'Inter', sans-serif; color: #333; overflow-x: hidden; }
        .text-blue { color: #007bff; }
        .bg-blue { background-color: #007bff; }
        .navbar-brand img { height: 40px; }
        .nav-link { font-weight: 500; color: #555; transition: 0.3s; }
        .nav-link:hover, .nav-link.active { color: #007bff; }
        .btn-primary { background-color: #007bff; border: none; padding: 10px 24px; }
        .btn-primary:hover { background-color: #0056b3; }
        /* Badge tags dùng chung */
        .badge-tag { background: #f0f2f5; color: #666; font-size: 0.8rem; border: none; margin-right: 5px; padding: 5px 12px; border-radius: 50px; }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-light bg-white sticky-top py-3 shadow-sm">
        <div class="container">
            <a class="navbar-brand d-flex align-items-center" href="${pageContext.request.contextPath}/home">
                <i class="bi bi-building-fill text-primary me-2 fs-3"></i>
                <span class="fw-bold fs-4 text-primary">ATS</span>
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav mx-auto">
                    <li class="nav-item"><a class="nav-link" href="home.jsp">Trang chủ</a></li>
                    <li class="nav-item"><a class="nav-link" href="job-list.jsp">Việc làm</a></li>
                    <li class="nav-item"><a class="nav-link" href="company.jsp">Công ty</a></li>
                    <li class="nav-item"><a class="nav-link" href="about.jsp">Giới thiệu</a></li>
                </ul>
                <div class="d-flex align-items-center">
                    <c:choose>
                        <c:when test="${empty sessionScope.user}">
                            <a href="auth/login.jsp" class="btn btn-link text-dark text-decoration-none me-3 fw-medium">Đăng nhập</a>
                            <a href="auth/register.jsp" class="btn btn-primary px-4 rounded-pill shadow-sm">Đăng ký ngay</a>
                        </c:when>
                        <c:otherwise>
                            <div class="dropdown">
                                <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" role="button" data-bs-toggle="dropdown">
                                    <i class="bi bi-person-circle fs-4 me-2"></i> Chào, ${sessionScope.user.name}
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end shadow border-0">
                                    <li><a class="dropdown-item" href="candidate/dashboard.jsp">Bảng điều khiển</a></li>
                                    <li><a class="dropdown-item" href="candidate/profile.jsp">Hồ sơ cá nhân</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item text-danger" href="logout">Đăng xuất</a></li>
                                </ul>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </nav>