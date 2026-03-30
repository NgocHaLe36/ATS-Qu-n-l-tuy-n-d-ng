<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách Công ty | ATS Recruitment</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">

    <style>
        body { font-family: 'Inter', sans-serif; color: #333; background-color: #f8fbff; }
        .text-blue { color: #007bff; }
        
        /* Navbar & Footer */
        .navbar-brand img { height: 40px; }
        .nav-link { font-weight: 500; color: #555; }
        footer { padding: 60px 0 20px; border-top: 1px solid #eee; font-size: 0.9rem; background: #fff; margin-top: 60px;}
        
        /* Search Section */
        .search-section { background: #fff; padding: 40px 0; border-bottom: 1px solid #eee; }
        .search-box { background: #fff; padding: 10px; border-radius: 50px; box-shadow: 0 5px 20px rgba(0,0,0,0.05); border: 1px solid #eef2f6; }
        
        /* Recruiter Cards */
        .recruiter-card { background: #fff; border: 1px solid #eee; border-radius: 20px; padding: 30px; text-align: center; transition: all 0.3s ease; height: 100%; box-shadow: 0 2px 10px rgba(0,0,0,0.02); }
        .recruiter-card:hover { transform: translateY(-5px); box-shadow: 0 10px 25px rgba(0,123,255,0.1); border-color: #007bff; }
        .company-logo { width: 90px; height: 90px; border-radius: 16px; object-fit: cover; margin-bottom: 15px; border: 1px solid #f1f5f9; box-shadow: 0 4px 10px rgba(0,0,0,0.05);}
        
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
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav mx-auto">
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/jobs">Việc làm</a></li>
                    <li class="nav-item"><a class="nav-link text-primary fw-bold" href="${pageContext.request.contextPath}/recruiters">Công ty</a></li>
                </ul>
                <div class="d-flex align-items-center">
                    <c:choose>
                        <c:when test="${empty sessionScope.user}">
                            <a href="${pageContext.request.contextPath}/login" class="btn btn-link text-dark text-decoration-none me-3">Đăng nhập</a>
                            <a href="${pageContext.request.contextPath}/register" class="btn btn-primary px-4 rounded-pill">Đăng ký ngay</a>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-outline-primary rounded-pill px-4">Dashboard</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </nav>

    <section class="search-section">
        <div class="container">
            <div class="text-center mb-4">
                <h2 class="fw-bold">Danh sách <span class="text-primary">Công ty nổi bật</span></h2>
                <p class="text-muted">Khám phá văn hóa và cơ hội việc làm từ các công ty hàng đầu</p>
            </div>
            <form action="${pageContext.request.contextPath}/recruiters" method="GET" class="search-box d-flex align-items-center mx-auto" style="max-width: 700px;">
                <div class="flex-grow-1 px-3 d-flex align-items-center">
                    <i class="bi bi-search me-2 text-muted"></i>
                    <input type="text" name="keyword" value="${keyword}" class="form-control border-0 shadow-none" placeholder="Tìm theo tên công ty, lĩnh vực...">
                </div>
                <button type="submit" class="btn btn-primary px-4 py-2 rounded-pill fw-bold">Tìm kiếm</button>
            </form>
        </div>
    </section>

    <div class="container py-5">
        <div class="d-flex justify-content-between align-items-end mb-4">
            <h5 class="fw-bold mb-0 border-start border-4 border-primary ps-3">Tìm thấy ${totalItems} công ty</h5>
        </div>

        <div class="row g-4">
            <c:forEach var="recruiter" items="${recruiters}">
                <div class="col-md-6 col-lg-4">
                    <div class="recruiter-card">
                        <img src="${not empty recruiter.avatar ? recruiter.avatar : 'https://ui-avatars.com/api/?name='.concat(recruiter.fullName).concat('&background=random&size=150')}" class="company-logo" alt="Logo">
                        <h5 class="fw-bold text-dark text-truncate mb-2" title="${recruiter.fullName}">${recruiter.fullName}</h5>
                        <p class="text-muted small mb-4"><i class="bi bi-geo-alt me-1 text-primary"></i>Việt Nam</p>
                        <div class="d-flex justify-content-between align-items-center mb-4 bg-light p-2 rounded-3">
                            <div class="text-center w-50 border-end">
                                <small class="text-muted d-block">Đang tuyển</small>
                                <span class="fw-bold text-primary">${recruiter.jobs.size()} vị trí</span>
                            </div>
                            <div class="text-center w-50">
                                <small class="text-muted d-block">Quy mô</small>
                                <span class="fw-bold text-dark">50+ NV</span>
                            </div>
                        </div>
                        <a href="${pageContext.request.contextPath}/recruiter-detail?id=${recruiter.id}" class="btn btn-outline-primary w-100 rounded-pill fw-bold">Xem hồ sơ & Việc làm</a>
                    </div>
                </div>
            </c:forEach>

            <c:if test="${empty recruiters}">
                <div class="col-12 text-center py-5">
                    <i class="bi bi-buildings text-muted opacity-50" style="font-size: 4rem;"></i>
                    <h5 class="text-muted fw-bold mt-3">Không tìm thấy công ty nào!</h5>
                    <p class="text-muted">Vui lòng thử lại với từ khóa khác.</p>
                </div>
            </c:if>
        </div>

        <c:if test="${totalPages > 1}">
            <nav class="mt-5">
                <ul class="pagination justify-content-center">
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                            <a class="page-link" href="?keyword=${keyword}&page=${i}">${i}</a>
                        </li>
                    </c:forEach>
                </ul>
            </nav>
        </c:if>
    </div>

    <footer>
        <div class="container text-center small text-muted">
            <p class="mb-0">© 2026 ATS Recruitment System. Bảo lưu mọi quyền.</p>
        </div>
    </footer>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>