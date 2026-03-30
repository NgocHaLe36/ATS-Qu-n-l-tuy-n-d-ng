<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Liên hệ với chúng tôi | ATS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        body { font-family: 'Inter', sans-serif; color: #333; background-color: #f8fbff; }
        .navbar-brand img { height: 40px; }
        .nav-link { font-weight: 500; color: #555; }
        footer { padding: 60px 0 20px; border-top: 1px solid #eee; background: #fff; margin-top: 60px;}
        
        .contact-card { background: #fff; border-radius: 20px; padding: 40px; border: 1px solid #edf2f7; box-shadow: 0 10px 30px rgba(0,0,0,0.03); }
        .info-box { background: #007bff; color: white; border-radius: 20px; padding: 40px; height: 100%; background-image: radial-gradient(circle at top right, #1e90ff, #007bff); }
        .form-control { border-radius: 10px; padding: 12px 15px; border-color: #dee2e6; }
        .form-control:focus { box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.15); border-color: #007bff; }
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
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/contact">Liên hệ</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container py-5">
        <div class="contact-card">
            <div class="row g-0">
                <div class="col-lg-5">
                    <div class="info-box d-flex flex-column justify-content-center">
                        <h3 class="fw-bold text-white mb-4">Kết nối với ATS</h3>
                        <p class="opacity-75 mb-5">Chúng tôi luôn sẵn sàng hỗ trợ bạn 24/7. Hãy gửi lại lời nhắn hoặc liên hệ trực tiếp qua thông tin dưới đây.</p>
                        
                        <div class="d-flex align-items-center mb-4">
                            <i class="bi bi-geo-alt fs-3 me-3 opacity-75"></i>
                            <div><h6 class="fw-bold mb-1">Văn phòng chính</h6><p class="mb-0 opacity-75 small">Tòa nhà Innovation, QTSC, Quận 12, TP.HCM</p></div>
                        </div>
                        <div class="d-flex align-items-center mb-4">
                            <i class="bi bi-telephone fs-3 me-3 opacity-75"></i>
                            <div><h6 class="fw-bold mb-1">Hotline Hỗ Trợ</h6><p class="mb-0 opacity-75 small">1900 1234 (Nhánh 1: ƯV, Nhánh 2: NTD)</p></div>
                        </div>
                        <div class="d-flex align-items-center">
                            <i class="bi bi-envelope fs-3 me-3 opacity-75"></i>
                            <div><h6 class="fw-bold mb-1">Email</h6><p class="mb-0 opacity-75 small">contact@ats.vn</p></div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-7 px-lg-5 py-4 py-lg-0">
                    <h3 class="fw-bold mb-1">Gửi lời nhắn</h3>
                    <p class="text-muted small mb-4">Chúng tôi sẽ phản hồi lại email của bạn trong vòng 24h làm việc.</p>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger rounded-3"><i class="bi bi-exclamation-circle me-2"></i>${error}</div>
                    </c:if>
                    <c:if test="${not empty success}">
                        <div class="alert alert-success rounded-3"><i class="bi bi-check-circle me-2"></i>${success}</div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/contact" method="POST">
                        <div class="mb-3">
                            <label class="form-label fw-bold small text-muted">Họ và tên *</label>
                            <input type="text" name="fullName" value="${fullName}" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold small text-muted">Email *</label>
                            <input type="email" name="email" value="${email}" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold small text-muted">Tiêu đề *</label>
                            <input type="text" name="subject" value="${subject}" class="form-control" required>
                        </div>
                        <div class="mb-4">
                            <label class="form-label fw-bold small text-muted">Nội dung *</label>
                            <textarea name="message" class="form-control" rows="5" required>${message}</textarea>
                        </div>
                        <button type="submit" class="btn btn-primary w-100 rounded-pill py-3 fw-bold shadow-sm">Gửi tin nhắn</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <footer><div class="container text-center small text-muted">© 2026 ATS Recruitment System.</div></footer>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>