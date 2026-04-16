<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Tìm kiếm nâng cao | ATS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        body { font-family: 'Inter', sans-serif; color: #333; background-color: #f8fbff; }
        .navbar-brand img { height: 40px; }
        .nav-link { font-weight: 500; color: #555; }
        footer { padding: 60px 0 20px; border-top: 1px solid #eee; background: #fff; margin-top: 60px;}
        .search-sidebar { background: #fff; border-radius: 15px; padding: 25px; border: 1px solid #eee; position: sticky; top: 100px; box-shadow: 0 5px 15px rgba(0,0,0,0.02);}
        .job-card { background: #fff; border: 1px solid #eee; border-radius: 15px; padding: 20px; transition: 0.3s; margin-bottom: 15px; }
        .job-card:hover { transform: translateY(-3px); box-shadow: 0 10px 20px rgba(0,123,255,0.1); border-color: #007bff; }
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
                </ul>
                <div class="d-flex align-items-center">
                    <c:choose>
                        <c:when test="${empty sessionScope.user}"><a href="${pageContext.request.contextPath}/login" class="btn btn-link text-dark text-decoration-none me-3">Đăng nhập</a><a href="${pageContext.request.contextPath}/register" class="btn btn-primary px-4 rounded-pill">Đăng ký ngay</a></c:when>
                        <c:otherwise><a href="${pageContext.request.contextPath}/dashboard" class="btn btn-outline-primary rounded-pill px-4">Dashboard</a></c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </nav>

    <div class="container py-5">
        <div class="row">
            <div class="col-lg-3 mb-4">
                <form action="${pageContext.request.contextPath}/advanced-search" method="GET" class="search-sidebar">
                    <h5 class="fw-bold mb-4 border-bottom pb-2">Bộ lọc tìm kiếm</h5>
                    
                    <div class="mb-3">
                        <label class="form-label fw-bold small text-muted">Từ khóa</label>
                        <div class="input-group"><span class="input-group-text bg-light"><i class="bi bi-search"></i></span><input type="text" name="keyword" value="${keyword}" class="form-control" placeholder="Java, Marketing..."></div>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label fw-bold small text-muted">Địa điểm</label>
                        <div class="input-group"><span class="input-group-text bg-light"><i class="bi bi-geo-alt"></i></span><input type="text" name="location" value="${location}" class="form-control" placeholder="Hà Nội, TP.HCM..."></div>
                    </div>

                    <div class="mb-4">
                        <label class="form-label fw-bold small text-muted">Loại tin</label>
                        <select name="vip" class="form-select">
                            <option value="">Tất cả</option>
                            <option value="true" ${vip == 'true' ? 'selected' : ''}>Tin VIP (Ưu tiên)</option>
                            <option value="false" ${vip == 'false' ? 'selected' : ''}>Tin thường</option>
                        </select>
                    </div>

                    <button type="submit" class="btn btn-primary w-100 rounded-pill fw-bold py-2">Áp dụng lọc</button>
                    <a href="${pageContext.request.contextPath}/advanced-search" class="btn btn-light text-muted w-100 rounded-pill mt-2">Xóa bộ lọc</a>
                </form>
            </div>

            <div class="col-lg-9">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h4 class="fw-bold mb-0">Kết quả: ${totalItems} việc làm</h4>
                </div>

                <div class="row">
                    <c:forEach var="job" items="${results}">
                        <div class="col-12">
                            <div class="job-card d-flex flex-column flex-md-row align-items-md-center justify-content-between">
                                <div class="d-flex align-items-center mb-3 mb-md-0">
                                    <img src="https://ui-avatars.com/api/?name=${job.recruiter.fullName}&background=random" width="60" class="rounded-3 me-3 border" alt="Logo">
                                    <div>
                                        <a href="${pageContext.request.contextPath}/job-detail?id=${job.id}" class="h5 fw-bold text-dark text-decoration-none mb-1 d-block">${job.title} <c:if test="${job.isVip}"><span class="badge bg-warning bg-opacity-10 text-warning ms-1"><i class="bi bi-star-fill"></i> VIP</span></c:if></a>
                                        <p class="text-muted small mb-0"><i class="bi bi-building me-1"></i>${job.recruiter.fullName} &nbsp;|&nbsp; <i class="bi bi-geo-alt me-1"></i>${job.location}</p>
                                    </div>
                                </div>
                                <div class="text-md-end">
                                    <div class="text-success fw-bold mb-2"><fmt:formatNumber value="${job.salary}" type="number"/> VNĐ</div>
                                    <a href="${pageContext.request.contextPath}/job-detail?id=${job.id}" class="btn btn-outline-primary btn-sm rounded-pill px-4 fw-bold">Ứng tuyển</a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    
                    <c:if test="${empty results}">
                        <div class="col-12 text-center py-5 bg-white rounded-4 border">
                            <i class="bi bi-search text-muted opacity-50" style="font-size: 3rem;"></i>
                            <h5 class="text-muted fw-bold mt-3">Không có kết quả khớp với bộ lọc!</h5>
                        </div>
                    </c:if>
                </div>

                <c:if test="${totalPages > 1}">
                    <nav class="mt-4">
                        <ul class="pagination justify-content-center">
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <li class="page-item ${currentPage == i ? 'active' : ''}"><a class="page-link rounded-circle mx-1" href="?keyword=${keyword}&location=${location}&vip=${vip}&page=${i}">${i}</a></li>
                            </c:forEach>
                        </ul>
                    </nav>
                </c:if>
            </div>
        </div>
    </div>

    <footer><div class="container text-center small text-muted">© 2026 ATS Recruitment System.</div></footer>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>