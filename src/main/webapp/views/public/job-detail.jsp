<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${job.title} | ATS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">

    <style>
        body { font-family: 'Inter', sans-serif; color: #333; background-color: #f8fbff; }
        .navbar-brand img { height: 40px; }
        .nav-link { font-weight: 500; color: #555; }
        footer { padding: 60px 0 20px; border-top: 1px solid #eee; font-size: 0.9rem; background: #fff; margin-top: 60px;}
        footer h6 { font-weight: 700; margin-bottom: 20px; }
        footer ul { list-style: none; padding: 0; }
        footer ul li a { text-decoration: none; color: #666; }

        /* Job Detail Styles */
        .content-box { background: #fff; border-radius: 20px; padding: 35px; border: 1px solid #edf2f7; box-shadow: 0 5px 20px rgba(0,0,0,0.02); margin-bottom: 24px; }
        .company-logo-lg { width: 90px; height: 90px; border-radius: 16px; object-fit: cover; border: 1px solid #eee; box-shadow: 0 4px 10px rgba(0,0,0,0.05); }
        .section-title { font-weight: 700; font-size: 1.2rem; margin-bottom: 20px; padding-left: 15px; border-left: 4px solid #007bff; color: #1e293b;}
        .job-description { line-height: 1.8; color: #475569; }
        .related-job-card { padding: 15px; border-radius: 12px; border: 1px solid #eee; transition: 0.3s; background: #fff; }
        .related-job-card:hover { border-color: #007bff; transform: translateY(-2px); box-shadow: 0 5px 15px rgba(0,123,255,0.1); }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-light bg-white sticky-top py-3 shadow-sm">
        <div class="container">
            <a class="navbar-brand d-flex align-items-center" href="${pageContext.request.contextPath}/home"><i class="bi bi-building-fill text-primary me-2 fs-3"></i><span class="fw-bold fs-4 text-primary">ATS</span></a>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav mx-auto">
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
                    <li class="nav-item"><a class="nav-link text-primary fw-bold" href="${pageContext.request.contextPath}/jobs">Việc làm</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/company">Công ty</a></li>
                                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/about">Giới thiệu</a></li>
                    
                </ul>
<div class="d-flex align-items-center">
    <c:choose>
        <%-- Nếu đã đăng nhập (có currentUser trong session) --%>
        <c:when test="${not empty sessionScope.currentUser}">
            <div class="dropdown">
                <a class="btn btn-outline-primary rounded-pill px-4 dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                    <i class="bi bi-person-circle me-1"></i> ${sessionScope.currentUser.fullName}
                </a>
                <ul class="dropdown-menu dropdown-menu-end">
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/candidate/dashboard">Dashboard Ứng viên</a></li>
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/candidate/profile">Hồ sơ của tôi</a></li>
                    <li><hr class="dropdown-divider"></li>
                    <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/auth/logout">Đăng xuất</a></li>
                </ul>
            </div>
        </c:when>
        <%-- Nếu chưa đăng nhập --%>
        <c:otherwise>
            <a href="${pageContext.request.contextPath}/auth/login" class="btn btn-link text-dark text-decoration-none me-3">Đăng nhập</a>
            <a href="${pageContext.request.contextPath}/auth/register" class="btn btn-primary px-4 rounded-pill">Đăng ký ngay</a>
        </c:otherwise>
    </c:choose>
</div>            </div>
        </div>
    </nav>

    <div class="container py-5">
        <div class="content-box">
            <div class="row align-items-center">
                <div class="col-lg-8 d-flex align-items-center border-end">
                    <img src="https://ui-avatars.com/api/?name=${job.recruiter.fullName}&background=007bff&color=fff&size=200" class="company-logo-lg me-4" alt="Logo">
                    <div>
                        <div class="mb-2">
                            <span class="badge bg-primary bg-opacity-10 text-primary rounded-pill px-3 py-2 me-2">Full-time</span>
                            <c:if test="${job.isVip}"><span class="badge bg-warning bg-opacity-10 text-warning rounded-pill px-3 py-2"><i class="bi bi-star-fill me-1"></i>VIP</span></c:if>
                        </div>
                        <h2 class="fw-bold mb-2">${job.title}</h2>
                        <a href="${pageContext.request.contextPath}/recruiter-detail?id=${job.recruiter.id}" class="text-decoration-none h6 fw-bold text-muted"><i class="bi bi-building me-2"></i>${job.recruiter.fullName}</a>
                    </div>
                </div>
                <div class="col-lg-4 ps-lg-4 mt-4 mt-lg-0 text-center text-lg-start">
<a href="${pageContext.request.contextPath}/candidate/apply?jobId=${job.id}" class="btn btn-primary w-100 rounded-pill py-3 fw-bold fs-5 shadow-sm mb-3 d-block">Ứng tuyển ngay</a>                    <button class="btn btn-outline-secondary w-100 rounded-pill py-2 fw-bold"><i class="bi bi-heart me-2"></i>Lưu tin này</button>
                </div>
            </div>
            <hr class="my-4 opacity-10">
            <div class="row text-center text-md-start g-4">
                <div class="col-md-3"><p class="text-muted small fw-bold mb-1"><i class="bi bi-cash-stack me-1"></i> MỨC LƯƠNG</p><h5 class="fw-bold text-success"><fmt:formatNumber value="${job.salary}" type="number"/> VNĐ</h5></div>
                <div class="col-md-3"><p class="text-muted small fw-bold mb-1"><i class="bi bi-geo-alt me-1"></i> ĐỊA ĐIỂM</p><h5 class="fw-bold text-dark">${job.location}</h5></div>
                <div class="col-md-3"><p class="text-muted small fw-bold mb-1"><i class="bi bi-calendar-x me-1"></i> HẠN NỘP HỒ SƠ</p><h5 class="fw-bold text-danger">${job.deadline}</h5></div>
                <div class="col-md-3"><p class="text-muted small fw-bold mb-1"><i class="bi bi-clock-history me-1"></i> NGÀY ĐĂNG</p><h5 class="fw-bold text-dark"><fmt:parseDate value="${job.createdDate}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both"/><fmt:formatDate pattern="dd/MM/yyyy" value="${parsedDate}"/></h5></div>
            </div>
        </div>

        <div class="row g-4">
            <div class="col-lg-8">
                <div class="content-box job-description">
                    <h4 class="section-title">Mô tả công việc</h4>
                    <div class="mb-5">${job.description}</div>
                    
                    <h4 class="section-title">Yêu cầu công việc</h4>
                    <div class="mb-0">${job.requirement}</div>
                </div>
            </div>

            <div class="col-lg-4">
                <div class="content-box bg-primary bg-opacity-10 border-primary border-opacity-25 text-center">
                    <img src="https://ui-avatars.com/api/?name=${job.recruiter.fullName}&background=fff&color=007bff&size=150" class="company-logo-lg mx-auto mb-3" alt="Logo">
                    <h5 class="fw-bold text-dark">${job.recruiter.fullName}</h5>
                    <p class="text-muted small mb-3"><i class="bi bi-envelope me-1"></i> ${job.recruiter.email}</p>
                    <a href="${pageContext.request.contextPath}/recruiter-detail?id=${job.recruiter.id}" class="btn btn-outline-primary w-100 rounded-pill fw-bold bg-white">Xem trang công ty</a>
                </div>

                <h5 class="fw-bold mb-3 mt-4">Việc làm tương tự</h5>
                <c:forEach var="related" items="${relatedJobs}">
                    <div class="related-job-card mb-3">
                        <a href="${pageContext.request.contextPath}/job-detail?id=${related.id}" class="h6 fw-bold text-dark text-decoration-none d-block mb-1">${related.title}</a>
                        <p class="text-muted small mb-2">${related.recruiter.fullName}</p>
                        <div class="d-flex justify-content-between align-items-center">
                            <span class="text-success fw-bold small"><fmt:formatNumber value="${related.salary}" type="number"/> đ</span>
                            <span class="text-muted small"><i class="bi bi-geo-alt me-1"></i>${related.location}</span>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>

    <footer><div class="container"><div class="text-center small text-muted">© 2026 ATS Recruitment System.</div></div></footer>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>