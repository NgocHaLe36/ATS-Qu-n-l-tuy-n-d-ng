<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%-- THÊM THƯ VIỆN NÀY ĐỂ XỬ LÝ CHUỖI ROLE AN TOÀN --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ATS - Tìm Công Việc Mơ Ước</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">

    <style>
        body { font-family: 'Inter', sans-serif; color: #333; }
        .text-blue { color: #007bff; }
        .bg-blue { background-color: #007bff; }
        .navbar-brand img { height: 40px; }
        .nav-link { font-weight: 500; color: #555; }
        .hero-section { padding: 80px 0; background: linear-gradient(135deg, #f8fbff 0%, #ffffff 100%); }
        .hero-title { font-size: 3.5rem; font-weight: 800; line-height: 1.2; }
        .search-box { background: #fff; padding: 15px; border-radius: 50px; box-shadow: 0 10px 30px rgba(0,0,0,0.05); }
        .hero-img { border-radius: 20px; width: 100%; box-shadow: 20px 20px 60px rgba(0,0,0,0.1); }
        .stats-bar { background-color: #007bff; color: white; padding: 40px 0; }
        .stat-item h2 { font-weight: 700; margin-bottom: 0; }
        .job-card { border: 1px solid #eee; border-radius: 15px; padding: 20px; transition: all 0.3s ease; height: 100%; }
        .job-card:hover { transform: translateY(-5px); box-shadow: 0 10px 20px rgba(0,0,0,0.05); }
        .badge-tag { background: #f0f2f5; color: #666; font-size: 0.8rem; border: none; margin-right: 5px; }
        .cta-blue-box { background: #007bff; border-radius: 20px; padding: 60px; color: white; background-image: radial-gradient(circle at top right, #1e90ff, #007bff); }
        footer { padding: 60px 0 20px; border-top: 1px solid #eee; font-size: 0.9rem; }
        footer h6 { font-weight: 700; margin-bottom: 20px; }
        footer ul { list-style: none; padding: 0; }
        footer ul li { margin-bottom: 10px; }
        footer ul li a { text-decoration: none; color: #666; }
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
                    <li class="nav-item"><a class="nav-link text-primary fw-bold" href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/jobs">Việc làm</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/company">Công ty</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/about">Giới thiệu</a></li>
                </ul>
                <div class="d-flex align-items-center">
                    <c:choose>
                        <c:when test="${not empty sessionScope.currentUser}">
                            <div class="dropdown">
                                <a class="btn btn-primary rounded-pill px-4 dropdown-toggle d-flex align-items-center" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    <i class="bi bi-person-circle me-2"></i> ${sessionScope.currentUser.fullName}
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end shadow border-0 mt-2">
                                    
							<%-- Trong file home.jsp --%>
							<c:if test="${fn:toLowerCase(sessionScope.currentUser.role) == 'admin'}">
							    <li>
							        <a class="dropdown-item fw-bold text-primary" 
							           href="${pageContext.request.contextPath}/admin/dashboard">
							            <i class="bi bi-speedometer2 me-2"></i> Quản trị hệ thống
							        </a>
							    </li>
							    <li><hr class="dropdown-divider"></li>
							</c:if>

                                    <c:if test="${fn:toLowerCase(sessionScope.currentUser.role) == 'candidate'}">
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/candidate/dashboard"><i class="bi bi-grid-fill me-2 text-muted"></i> Quản lý hồ sơ</a></li>
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/candidate/applied-jobs"><i class="bi bi-briefcase-fill me-2 text-muted"></i> Việc làm đã nộp</a></li>
                                    </c:if>
                                    
                                    <c:if test="${fn:toLowerCase(sessionScope.currentUser.role) == 'recruiter'}">
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/recruiter/dashboard"><i class="bi bi-speedometer2 me-2 text-muted"></i> Bảng điều khiển HR</a></li>
                                    </c:if>

                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile"><i class="bi bi-person-gear me-2 text-muted"></i> Hồ sơ cá nhân</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/auth/logout"><i class="bi bi-box-arrow-right me-2"></i> Đăng xuất</a></li>
                                </ul>
                            </div>
                        </c:when>
                        
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/auth/login" class="btn btn-link text-dark text-decoration-none me-3">Đăng nhập</a>
                            <a href="${pageContext.request.contextPath}/auth/register" class="btn btn-primary px-4 rounded-pill shadow-sm">Đăng ký ngay</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </nav>

    <section class="hero-section">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6">
                    <span class="badge bg-light text-primary mb-3 px-3 py-2 rounded-pill shadow-sm">
                        <i class="bi bi-graph-up-arrow me-2"></i>XU HƯỚNG TUYỂN DỤNG 2026
                    </span>
                    <h1 class="hero-title mb-4">
                        Tìm Công Việc<br>
                        <span class="text-blue text-decoration-underline">Mơ Ước</span> Của Bạn
                    </h1>
                    <p class="text-muted mb-5 fs-5">Kết nối với hơn <fmt:formatNumber value="${totalRecruiters}" type="number"/>+ công ty hàng đầu và khám phá hàng ngàn cơ hội nghề nghiệp phù hợp với đam mê và kỹ năng của bạn.</p>
                    
                    <form action="${pageContext.request.contextPath}/jobs" method="GET" class="search-box d-flex align-items-center">
                        <div class="flex-grow-1 border-end px-3">
                            <i class="bi bi-search me-2 text-muted"></i>
                            <input type="text" name="keyword" class="border-0 w-75 shadow-none outline-0" placeholder="Vị trí, kỹ năng...">
                        </div>
                        <div class="flex-grow-1 px-3">
                            <i class="bi bi-geo-alt me-2 text-muted"></i>
                            <input type="text" name="location" class="border-0 w-75 shadow-none outline-0" placeholder="Khu vực làm việc...">
                        </div>
                        <button type="submit" class="btn btn-primary px-4 py-2 rounded-pill fw-bold shadow-sm">Tìm kiếm</button>
                    </form>

                    <div class="mt-3">
                        <small class="text-muted">Từ khóa phổ biến: </small>
                        <a href="${pageContext.request.contextPath}/jobs?keyword=React" class="badge badge-tag text-decoration-none">React</a>
                        <a href="${pageContext.request.contextPath}/jobs?keyword=Java" class="badge badge-tag text-decoration-none">Java</a>
                        <a href="${pageContext.request.contextPath}/jobs?keyword=Design" class="badge badge-tag text-decoration-none">Design</a>
                        <a href="${pageContext.request.contextPath}/jobs?keyword=Marketing" class="badge badge-tag text-decoration-none">Marketing</a>
                    </div>
                </div>
                <div class="col-lg-6 mt-5 mt-lg-0 text-center position-relative">
                    <img src="https://images.unsplash.com/photo-1522071820081-009f0129c71c?auto=format&fit=crop&w=800&q=80" alt="Team work" class="hero-img">
                </div>
            </div>
        </div>
    </section>

    <div class="stats-bar shadow-sm">
        <div class="container">
            <div class="row text-center">
                <div class="col-md-3 stat-item">
                    <h2><fmt:formatNumber value="${totalJobs}" type="number"/>+</h2>
                    <p class="mb-0">Việc làm mở tuyển</p>
                </div>
                <div class="col-md-3 stat-item border-start border-white border-opacity-25">
                    <h2><fmt:formatNumber value="${totalRecruiters}" type="number"/>+</h2>
                    <p class="mb-0">Công ty uy tín</p>
                </div>
                <div class="col-md-3 stat-item border-start border-white border-opacity-25">
                    <h2>1.2M+</h2>
                    <p class="mb-0">Hồ sơ ứng viên</p>
                </div>
                <div class="col-md-3 stat-item border-start border-white border-opacity-25">
                    <h2><fmt:formatNumber value="${totalVipJobs}" type="number"/>+</h2>
                    <p class="mb-0">Việc làm VIP (Lương cao)</p>
                </div>
            </div>
        </div>
    </div>

    <section class="py-5">
        <div class="container">
            <div class="d-flex justify-content-between align-items-end mb-4">
                <div>
                    <h6 class="text-primary fw-bold">— Việc làm mới cập nhật</h6>
                    <h2 class="fw-bold">Cơ Hội Nghề Nghiệp <span class="text-primary">Mới Nhất</span></h2>
                </div>
                <a href="${pageContext.request.contextPath}/jobs" class="btn btn-outline-primary rounded-pill">Xem tất cả công việc <i class="bi bi-arrow-right"></i></a>
            </div>

            <div class="row g-4">
                <c:forEach var="job" items="${latestJobs}">
                    <div class="col-md-4">
                        <div class="job-card bg-white">
                            <div class="d-flex justify-content-between mb-3">
                                <div class="bg-light p-1 rounded">
                                    <img src="https://ui-avatars.com/api/?name=${job.recruiter.fullName}&background=random" width="35" class="rounded">
                                </div>
                                <c:if test="${job.isVip}">
                                    <span class="badge bg-warning bg-opacity-10 text-warning rounded-pill align-self-start px-3 py-2"><i class="bi bi-star-fill me-1"></i>VIP</span>
                                </c:if>
                            </div>
                            <h5 class="fw-bold text-truncate" title="${job.title}">
                                <a href="${pageContext.request.contextPath}/job-detail?id=${job.id}" class="text-dark text-decoration-none">${job.title}</a>
                            </h5>
                            <p class="text-muted mb-2 text-truncate"><i class="bi bi-building me-2"></i>${job.recruiter.fullName}</p>
                            <p class="small text-muted mb-3"><i class="bi bi-geo-alt me-1"></i> ${job.location}</p>
                            <p class="fw-bold text-primary mb-3">
                                <i class="bi bi-currency-dollar me-1"></i><fmt:formatNumber value="${job.salary}" type="number" maxFractionDigits="0"/> VNĐ
                            </p>
                            
                            <div class="d-flex justify-content-between align-items-center border-top pt-3">
                                <small class="text-danger fw-medium"><i class="bi bi-calendar-x me-1"></i>Hạn: ${job.deadline}</small>
                                <a href="${pageContext.request.contextPath}/job-detail?id=${job.id}" class="text-primary text-decoration-none fw-bold small">Ứng tuyển <i class="bi bi-arrow-right"></i></a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
                
                <c:if test="${empty latestJobs}">
                     <div class="col-12 text-center py-5">
                        <i class="bi bi-inbox text-muted fs-1 d-block mb-3"></i>
                        <p class="text-muted">Hiện tại chưa có việc làm nào mới.</p>
                     </div>
                </c:if>
            </div>
        </div>
    </section>

    <section class="py-5">
        <div class="container">
            <div class="cta-blue-box position-relative overflow-hidden shadow">
                <div class="row align-items-center">
                    <div class="col-lg-7">
                        <h2 class="display-5 fw-bold mb-4">Bắt Đầu Hành Trình Sự Nghiệp Tuyệt Vời Ngay Hôm Nay</h2>
                        <p class="mb-4 opacity-75">Đừng bỏ lỡ những cơ hội tốt nhất. Đăng ký tài khoản để nhận thông báo việc làm và quản lý hồ sơ chuyên nghiệp.</p>
                        <div class="d-flex gap-3">
                            <a href="${pageContext.request.contextPath}/auth/register" class="btn btn-white bg-white text-primary px-4 py-2 fw-bold shadow-sm">Đăng ký ứng viên</a>
                            <a href="${pageContext.request.contextPath}/contact" class="btn btn-outline-light px-4 py-2">Liên hệ tuyển dụng</a>
                        </div>
                    </div>
                    <div class="col-lg-5">
                        <div class="bg-white bg-opacity-10 p-4 rounded-4 mb-3 border border-white border-opacity-25">
                            <h6><i class="bi bi-check-circle-fill me-2"></i> Tìm việc nhanh chóng</h6>
                            <small>Sử dụng AI để gợi ý việc làm phù hợp nhất với kỹ năng của bạn.</small>
                        </div>
                        <div class="bg-white bg-opacity-10 p-4 rounded-4 border border-white border-opacity-25">
                            <h6><i class="bi bi-people-fill me-2"></i> Quản lý hồ sơ thông minh</h6>
                            <small>Hệ thống hỗ trợ lưu trữ CV và theo dõi kết quả ứng tuyển tự động.</small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <footer>
        <div class="container">
            <div class="row">
                <div class="col-lg-3 mb-4">
                    <div class="d-flex align-items-center mb-3">
                        <i class="bi bi-building-fill text-primary me-2 fs-4"></i>
                        <span class="fw-bold fs-5 text-primary">ATS</span>
                    </div>
                    <p class="text-muted">Hệ thống quản trị tuyển dụng hiện đại, kết nối ứng viên tài năng với những doanh nghiệp hàng đầu Việt Nam.</p>
                </div>
                <div class="col-6 col-lg-3 mb-4">
                    <h6>Dành cho ứng viên</h6>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/jobs">Tìm kiếm việc làm</a></li>
                        <li><a href="${pageContext.request.contextPath}/advanced-search">Tìm việc nâng cao</a></li>
                        <li><a href="${pageContext.request.contextPath}/recruiters">Danh sách công ty</a></li>
                    </ul>
                </div>
                <div class="col-6 col-lg-3 mb-4">
                    <h6>Dành cho nhà tuyển dụng</h6>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/auth/login">Đăng tin tuyển dụng</a></li>
                        <li><a href="${pageContext.request.contextPath}/auth/login">Quản lý hồ sơ AI</a></li>
                        <li><a href="${pageContext.request.contextPath}/faq">Giải pháp ATS (FAQ)</a></li>
                    </ul>
                </div>
                <div class="col-lg-3 mb-4">
                    <h6>Liên hệ</h6>
                    <p class="text-muted small mb-2"><i class="bi bi-geo-alt me-2 text-primary"></i> Tòa nhà Innovation, TP. HCM</p>
                    <p class="text-muted small mb-2"><i class="bi bi-telephone me-2 text-primary"></i> 1900 1234</p>
                    <p class="text-muted small"><i class="bi bi-envelope me-2 text-primary"></i> contact@ats.vn</p>
                </div>
            </div>
            <hr>
            <div class="d-flex justify-content-between small text-muted">
                <p>© 2026 ATS Recruitment System. Bảo lưu mọi quyền.</p>
                <div class="d-flex gap-3">
                    <a href="#" class="text-muted">Chính sách bảo mật</a>
                    <a href="#" class="text-muted">Điều khoản sử dụng</a>
                </div>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>