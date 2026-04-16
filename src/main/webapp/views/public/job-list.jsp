<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tìm việc làm | ATS - Công Việc Mơ Ước</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">

    <style>
        body { font-family: 'Inter', sans-serif; color: #333; background-color: #f8fbff; }
        .text-blue { color: #007bff; }
        .bg-blue { background-color: #007bff; }
        
        /* Header & Footer */
        .navbar-brand img { height: 40px; }
        .nav-link { font-weight: 500; color: #555; }
        footer { padding: 60px 0 20px; border-top: 1px solid #eee; font-size: 0.9rem; background: #fff; margin-top: 60px;}
        footer h6 { font-weight: 700; margin-bottom: 20px; }
        footer ul { list-style: none; padding: 0; }
        footer ul li { margin-bottom: 10px; }
        footer ul li a { text-decoration: none; color: #666; }

        /* Search Section */
        .search-section { background: #fff; padding: 40px 0; border-bottom: 1px solid #eee; }
        .search-box { background: #fff; padding: 10px; border-radius: 50px; box-shadow: 0 5px 20px rgba(0,0,0,0.05); border: 1px solid #eef2f6; }
        
        /* Job Cards */
        .job-card { background: #fff; border: 1px solid #eee; border-radius: 15px; padding: 24px; transition: all 0.3s ease; height: 100%; box-shadow: 0 2px 10px rgba(0,0,0,0.02); }
        .job-card:hover { transform: translateY(-5px); box-shadow: 0 10px 25px rgba(0,123,255,0.1); border-color: #007bff; }
        .company-logo { width: 50px; height: 50px; border-radius: 10px; object-fit: cover; border: 1px solid #f1f5f9; }
        .badge-tag { background: #f1f5f9; color: #475569; font-size: 0.75rem; border: none; margin-right: 5px; padding: 5px 12px; border-radius: 6px; }
        
        .pagination .page-link { border-radius: 8px; margin: 0 4px; border: none; color: #555; font-weight: 500; }
        .pagination .page-item.active .page-link { background-color: #007bff; color: #fff; }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-light bg-white sticky-top py-3 shadow-sm">
        <div class="container">
            <a class="navbar-brand d-flex align-items-center" href="${pageContext.request.contextPath}/home">
                <i class="bi bi-building-fill text-primary me-2 fs-3"></i><span class="fw-bold fs-4 text-primary">ATS</span>
            </a>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav mx-auto">
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
                    <li class="nav-item"><a class="nav-link text-primary fw-bold" href="${pageContext.request.contextPath}/jobs">Việc làm</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/company">Công ty</a></li>
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
                        <%-- Đã sửa đường dẫn thành /auth/login --%>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/auth/login" class="btn btn-link text-dark text-decoration-none me-3">Đăng nhập</a>
                            <a href="${pageContext.request.contextPath}/auth/register" class="btn btn-primary px-4 rounded-pill">Đăng ký ngay</a>
                        </c:otherwise>
                    </c:choose>
                </div>
    </nav>

    <section class="search-section">
        <div class="container">
            <form action="${pageContext.request.contextPath}/jobs" method="GET" class="search-box d-flex align-items-center mx-auto" style="max-width: 900px;">
                <div class="flex-grow-1 border-end px-3 d-flex align-items-center">
                    <i class="bi bi-search me-2 text-muted"></i>
                    <input type="text" name="keyword" value="${keyword}" class="form-control border-0 shadow-none" placeholder="Tên công việc, kỹ năng...">
                </div>
                <div class="flex-grow-1 px-3 d-flex align-items-center">
                    <i class="bi bi-geo-alt me-2 text-muted"></i>
                    <input type="text" name="location" value="${location}" class="form-control border-0 shadow-none" placeholder="Địa điểm...">
                </div>
                <button type="submit" class="btn btn-primary px-5 py-2 rounded-pill fw-bold">Tìm kiếm</button>
            </form>
        </div>
    </section>

    <div class="container py-5">
        <div class="d-flex justify-content-between align-items-end mb-4">
            <div>
                <h3 class="fw-bold mb-1">Tìm thấy ${totalItems} việc làm phù hợp</h3>
                <p class="text-muted small mb-0">Khám phá cơ hội nghề nghiệp mới nhất dành cho bạn.</p>
            </div>
        </div>

        <div class="row g-4">
            <c:forEach var="job" items="${jobs}">
                <div class="col-lg-6">
                    <div class="job-card">
                        <div class="d-flex justify-content-between align-items-start mb-3">
                            <div class="d-flex gap-3">
                                <img src="https://ui-avatars.com/api/?name=${job.recruiter.fullName}&background=random" class="company-logo" alt="Logo">
                                <div>
                                    <a href="${pageContext.request.contextPath}/job-detail?id=${job.id}" class="h5 fw-bold text-dark text-decoration-none d-block mb-1">${job.title}</a>
                                    <p class="text-muted small mb-0"><i class="bi bi-building me-1"></i> ${job.recruiter.fullName}</p>
                                </div>
                            </div>
                            <c:if test="${job.isVip}">
                                <span class="badge bg-warning bg-opacity-10 text-warning rounded-pill px-3 py-2"><i class="bi bi-star-fill me-1"></i>VIP</span>
                            </c:if>
                        </div>
                        
                        <div class="d-flex gap-3 mb-3">
                            <span class="text-success fw-bold"><i class="bi bi-currency-dollar me-1"></i>
                                <fmt:formatNumber value="${job.salary}" type="number" maxFractionDigits="0"/> VNĐ
                            </span>
                            <span class="text-muted small"><i class="bi bi-geo-alt me-1"></i>${job.location}</span>
                            <span class="text-danger small"><i class="bi bi-calendar-x me-1"></i>Hạn: ${job.deadline}</span>
                        </div>
                        
                        <div class="d-flex justify-content-between align-items-center pt-3 border-top">
                            <div>
                                <span class="badge-tag">Full-time</span>
                                <span class="badge-tag">Hot</span>
                            </div>
                            <a href="${pageContext.request.contextPath}/job-detail?id=${job.id}" class="btn btn-outline-primary btn-sm rounded-pill px-4 fw-bold">Ứng tuyển</a>
                        </div>
                    </div>
                </div>
            </c:forEach>

            <c:if test="${empty jobs}">
                <div class="col-12 text-center py-5">
                    <img src="https://cdn-icons-png.flaticon.com/512/4076/4076432.png" width="120" class="mb-3 opacity-50">
                    <h5 class="text-muted fw-bold">Không tìm thấy công việc nào phù hợp!</h5>
                    <p class="text-muted">Thử thay đổi từ khóa hoặc địa điểm tìm kiếm.</p>
                </div>
            </c:if>
        </div>

        <c:if test="${totalPages > 1}">
            <nav class="mt-5">
                <ul class="pagination justify-content-center">
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                            <a class="page-link" href="?keyword=${keyword}&location=${location}&page=${i}">${i}</a>
                        </li>
                    </c:forEach>
                </ul>
            </nav>
        </c:if>
    </div>

    <footer>
        <div class="container">
            <div class="row">
                <div class="col-lg-4 mb-4">
                    <div class="d-flex align-items-center mb-3">
                        <i class="bi bi-building-fill text-primary me-2 fs-4"></i><span class="fw-bold fs-5 text-primary">ATS</span>
                    </div>
                    <p class="text-muted small">Hệ thống quản trị tuyển dụng hiện đại, kết nối ứng viên tài năng với doanh nghiệp hàng đầu.</p>
                </div>
                <div class="col-6 col-lg-4 mb-4">
                    <h6>Dành cho ứng viên</h6>
                    <ul>
                        <li><a href="#">Tìm kiếm việc làm</a></li>
                        <li><a href="#">Tạo CV chuyên nghiệp</a></li>
                    </ul>
                </div>
                <div class="col-6 col-lg-4 mb-4">
                    <h6>Liên hệ</h6>
                    <p class="text-muted small mb-2"><i class="bi bi-geo-alt me-2"></i> TP. HCM, Việt Nam</p>
                    <p class="text-muted small"><i class="bi bi-envelope me-2"></i> contact@ats.vn</p>
                </div>
            </div>
            <hr>
            <div class="text-center small text-muted">© 2026 ATS Recruitment System. Bảo lưu mọi quyền.</div>
        </div>
    </footer>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>