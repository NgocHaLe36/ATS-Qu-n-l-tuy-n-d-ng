<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giới thiệu về ATS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">

    <style>
        body { font-family: 'Inter', sans-serif; color: #333; background-color: #f8fbff; }
        .nav-link { font-weight: 500; color: #555; }
        footer { padding: 40px 0; border-top: 1px solid #eee; background: #fff; margin-top: 60px;}
        
        .hero-about { background: linear-gradient(135deg, #007bff 0%, #00b4db 100%); padding: 100px 0; color: white; border-radius: 0 0 40px 40px; margin-bottom: 50px; }
        .about-card { background: #fff; border-radius: 20px; padding: 40px; border: 1px solid #edf2f7; box-shadow: 0 10px 30px rgba(0,0,0,0.03); height: 100%; }
        .icon-box-lg { width: 80px; height: 80px; border-radius: 20px; background: rgba(0, 123, 255, 0.1); color: #007bff; display: flex; align-items: center; justify-content: center; font-size: 2rem; margin-bottom: 20px; }
        
        .stats-box { background: white; border-radius: 20px; padding: 30px; text-align: center; border: 1px solid #eee; box-shadow: 0 5px 20px rgba(0,0,0,0.02); }
        .stats-box h2 { color: #007bff; font-weight: 800; font-size: 2.5rem; mb-2; }
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
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/company">Công ty</a></li>
                    <li class="nav-item"><a class="nav-link text-primary fw-bold" href="${pageContext.request.contextPath}/about">Giới thiệu</a></li>
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

    <section class="hero-about text-center">
        <div class="container">
            <h1 class="display-4 fw-bold mb-3">Về Hệ thống ATS</h1>
            <p class="fs-5 opacity-75 mx-auto" style="max-width: 700px;">Nền tảng tuyển dụng thông minh, kết nối hàng triệu ứng viên tài năng với các doanh nghiệp hàng đầu thông qua sức mạnh của Trí tuệ nhân tạo (AI).</p>
        </div>
    </section>

    <div class="container mb-5 mt-n5 position-relative">
        <div class="row g-4">
            <div class="col-md-4"><div class="stats-box"><h2>1.2M+</h2><p class="text-muted fw-bold mb-0">Ứng viên tin dùng</p></div></div>
            <div class="col-md-4"><div class="stats-box"><h2>8,500+</h2><p class="text-muted fw-bold mb-0">Doanh nghiệp đối tác</p></div></div>
            <div class="col-md-4"><div class="stats-box"><h2>25K+</h2><p class="text-muted fw-bold mb-0">Cơ hội việc làm mỗi ngày</p></div></div>
        </div>
    </div>

    <div class="container py-5">
        <div class="row g-5 align-items-center mb-5">
            <div class="col-lg-6">
                <h2 class="fw-bold mb-4">Sứ mệnh của chúng tôi</h2>
                <p class="text-muted fs-5" style="line-height: 1.8;">Chúng tôi xây dựng ATS với một mục tiêu duy nhất: Xóa bỏ rào cản giữa ứng viên và nhà tuyển dụng.</p>
                <p class="text-muted" style="line-height: 1.8;">Nhờ việc ứng dụng AI Score để tự động phân tích và đánh giá CV, ATS giúp rút ngắn 70% thời gian sàng lọc hồ sơ, đảm bảo các tài năng thực sự không bao giờ bị bỏ lỡ.</p>
                <a href="${pageContext.request.contextPath}/jobs" class="btn btn-primary rounded-pill px-4 py-3 fw-bold mt-3">Khám phá việc làm <i class="bi bi-arrow-right ms-2"></i></a>
            </div>
            <div class="col-lg-6">
                <img src="https://images.unsplash.com/photo-1522071820081-009f0129c71c?auto=format&fit=crop&w=800&q=80" class="img-fluid rounded-4 shadow" alt="Team">
            </div>
        </div>

        <h3 class="fw-bold text-center mb-5 mt-5">Giá trị cốt lõi</h3>
        <div class="row g-4">
            <div class="col-md-4">
                <div class="about-card">
                    <div class="icon-box-lg"><i class="bi bi-lightning-charge-fill"></i></div>
                    <h5 class="fw-bold">Tốc độ & Hiệu quả</h5>
                    <p class="text-muted mb-0">Hệ thống xử lý hàng ngàn hồ sơ chỉ trong vài giây, trả kết quả chính xác tuyệt đối.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="about-card">
                    <div class="icon-box-lg bg-success bg-opacity-10 text-success"><i class="bi bi-shield-check"></i></div>
                    <h5 class="fw-bold">Bảo mật tối đa</h5>
                    <p class="text-muted mb-0">Thông tin ứng viên và doanh nghiệp được mã hóa và bảo vệ theo chuẩn quốc tế.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="about-card">
                    <div class="icon-box-lg bg-warning bg-opacity-10 text-warning"><i class="bi bi-robot"></i></div>
                    <h5 class="fw-bold">Công nghệ AI</h5>
                    <p class="text-muted mb-0">Sử dụng Machine Learning để phân tích kỹ năng, chấm điểm và gợi ý mức độ phù hợp.</p>
                </div>
            </div>
        </div>
    </div>

    <footer><div class="container text-center small text-muted">© 2026 ATS Recruitment System.</div></footer>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>