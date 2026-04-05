<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${recruiter.fullName} - Tuyển Dụng | ATS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">

    <style>
        body { font-family: 'Inter', sans-serif; color: #333; background-color: #f8fbff; }
        .navbar-brand img { height: 40px; }
        .nav-link { font-weight: 500; color: #555; }
        footer { padding: 60px 0 20px; border-top: 1px solid #eee; font-size: 0.9rem; background: #fff; margin-top: 60px;}
        
        .cover-photo { width: 100%; height: 250px; object-fit: cover; border-radius: 20px 20px 0 0; background: linear-gradient(135deg, #007bff 0%, #00b4db 100%); }
        .company-profile-card { background: #fff; border-radius: 20px; border: 1px solid #edf2f7; box-shadow: 0 5px 20px rgba(0,0,0,0.02); margin-top: -100px; position: relative; padding: 40px; margin-bottom: 40px; }
        .company-logo-huge { width: 150px; height: 150px; border-radius: 20px; object-fit: cover; border: 5px solid #fff; box-shadow: 0 10px 25px rgba(0,0,0,0.1); margin-top: -100px; background: #fff;}
        
        .job-card { background: #fff; border: 1px solid #eee; border-radius: 15px; padding: 24px; transition: 0.3s; height: 100%; }
        .job-card:hover { border-color: #007bff; transform: translateY(-3px); box-shadow: 0 10px 20px rgba(0,123,255,0.1); }
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
                
                <%-- Bắt đầu phần thay đổi Menu Đăng nhập / User Profile --%>
                <div class="d-flex align-items-center">
                    <c:choose>
                        <%-- Nếu đã đăng nhập --%>
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
                        <%-- Nếu chưa đăng nhập --%>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/auth/login" class="btn btn-link text-dark text-decoration-none me-3">Đăng nhập</a>
                            <a href="${pageContext.request.contextPath}/auth/register" class="btn btn-primary px-4 rounded-pill">Đăng ký ngay</a>
                        </c:otherwise>
                    </c:choose>
                </div>
                <%-- Kết thúc phần thay đổi Menu --%>

            </div>
        </div>
    </nav>

    <div class="container py-4">
        <div class="cover-photo shadow-sm"></div>
        
        <div class="company-profile-card">
            <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-end mb-4">
                <div class="d-flex flex-column align-items-start">
                    <img src="https://ui-avatars.com/api/?name=${recruiter.fullName}&background=random&size=300" class="company-logo-huge mb-3" alt="Logo">
                    <h2 class="fw-bold text-dark mb-1">${recruiter.fullName}</h2>
                    <p class="text-muted fs-5 mb-0"><i class="bi bi-briefcase me-2"></i>Đang tuyển ${jobCount} vị trí</p>
                </div>
                <div class="mt-4 mt-md-0 d-flex gap-2">
                    <button class="btn btn-outline-primary rounded-pill px-4 fw-bold"><i class="bi bi-plus-lg me-2"></i>Theo dõi</button>
                    <a href="mailto:${recruiter.email}" class="btn btn-primary rounded-pill px-4 fw-bold shadow-sm"><i class="bi bi-envelope me-2"></i>Gửi Email</a>
                </div>
            </div>
            
            <div class="row bg-light rounded-4 p-4 mt-4">
                <div class="col-md-4 border-end-md">
                    <small class="text-muted text-uppercase fw-bold d-block mb-1">Mã Nhà Tuyển Dụng</small>
                    <span class="fw-bold fs-5 text-dark">#REC-${recruiter.id}</span>
                </div>
                <div class="col-md-4 border-end-md mt-3 mt-md-0">
                    <small class="text-muted text-uppercase fw-bold d-block mb-1">Email liên hệ</small>
                    <span class="fw-bold fs-5 text-dark">${recruiter.email}</span>
                </div>
                <div class="col-md-4 mt-3 mt-md-0">
                    <small class="text-muted text-uppercase fw-bold d-block mb-1">Hotline</small>
                    <span class="fw-bold fs-5 text-dark">${not empty recruiter.phone ? recruiter.phone : 'Chưa cập nhật'}</span>
                </div>
            </div>
        </div>

        <h4 class="fw-bold mb-4 border-start border-4 border-primary ps-3">Tuyển dụng từ ${recruiter.fullName}</h4>
        
        <div class="row g-4">
            <c:forEach var="job" items="${recruiterJobs}">
                <div class="col-md-6 col-lg-4">
                    <div class="job-card">
                        <div class="d-flex justify-content-between mb-3">
                            <span class="badge bg-primary bg-opacity-10 text-primary rounded-pill px-3 py-2">Mới đăng</span>
                            <c:if test="${job.isVip}"><span class="badge bg-warning bg-opacity-10 text-warning rounded-pill px-3 py-2"><i class="bi bi-star-fill"></i> VIP</span></c:if>
                        </div>
                        <a href="${pageContext.request.contextPath}/job-detail?id=${job.id}" class="h5 fw-bold text-dark text-decoration-none d-block mb-2">${job.title}</a>
                        
                        <div class="d-flex gap-3 mb-4 mt-3">
                            <span class="text-success fw-bold"><i class="bi bi-currency-dollar me-1"></i><fmt:formatNumber value="${job.salary}" type="number"/> đ</span>
                        </div>
                        <div class="d-flex align-items-center text-muted small mb-4 border-bottom pb-3">
                            <span class="me-3"><i class="bi bi-geo-alt me-1"></i>${job.location}</span>
                            <span class="text-danger"><i class="bi bi-calendar-x me-1"></i>Hạn: ${job.deadline}</span>
                        </div>
                        
                        <a href="${pageContext.request.contextPath}/job-detail?id=${job.id}" class="btn btn-outline-primary w-100 rounded-pill fw-bold">Xem chi tiết</a>
                    </div>
                </div>
            </c:forEach>
            
            <c:if test="${empty recruiterJobs}">
                <div class="col-12 text-center py-5 bg-white rounded-4 border">
                    <i class="bi bi-inbox text-muted" style="font-size: 4rem;"></i>
                    <h5 class="text-muted fw-bold mt-3">Công ty này hiện chưa có tin tuyển dụng nào mở!</h5>
                </div>
            </c:if>
        </div>
    </div>

    <footer><div class="container text-center small text-muted">© 2026 ATS Recruitment System.</div></footer>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>