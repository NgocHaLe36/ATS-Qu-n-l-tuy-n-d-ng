<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hỏi đáp (FAQ) | ATS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">

    <style>
        body { font-family: 'Inter', sans-serif; color: #333; background-color: #f8fbff; }
        .nav-link { font-weight: 500; color: #555; }
        footer { padding: 40px 0; border-top: 1px solid #eee; background: #fff; margin-top: 60px;}
        
        .faq-header { text-align: center; padding: 60px 0 40px; }
        .faq-header h1 { font-weight: 800; color: #007bff; }
        
        /* Custom Accordion */
        .accordion-item { border: 1px solid #edf2f7; border-radius: 15px !important; margin-bottom: 15px; overflow: hidden; background: #fff; box-shadow: 0 2px 10px rgba(0,0,0,0.01);}
        .accordion-button { font-weight: 600; color: #1e293b; padding: 20px 25px; font-size: 1.05rem; }
        .accordion-button:not(.collapsed) { color: #007bff; background-color: rgba(0, 123, 255, 0.05); box-shadow: none; }
        .accordion-button:focus { box-shadow: none; border-color: transparent; }
        .accordion-body { color: #475569; line-height: 1.7; padding: 0 25px 25px; }
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
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/contact">Liên hệ</a></li>
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

    <div class="container py-4 mb-5" style="max-width: 800px;">
        <div class="faq-header">
            <h1>Câu hỏi thường gặp</h1>
            <p class="text-muted fs-5 mt-3">Mọi giải đáp thắc mắc về hệ thống ATS dành cho cả Ứng viên và Nhà tuyển dụng.</p>
        </div>

        <div class="accordion" id="faqAccordion">
            <h5 class="fw-bold text-primary mb-3 mt-4"><i class="bi bi-person-fill me-2"></i>Dành cho Ứng Viên</h5>
            
            <div class="accordion-item">
                <h2 class="accordion-header">
                    <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#faq1">Làm thế nào để ứng tuyển một công việc?</button>
                </h2>
                <div id="faq1" class="accordion-collapse collapse show" data-bs-parent="#faqAccordion">
                    <div class="accordion-body">
                        Để ứng tuyển, bạn cần tạo tài khoản Ứng viên miễn phí. Sau khi đăng nhập, hãy truy cập vào trang "Việc làm", chọn công việc phù hợp, tải CV của bạn lên (định dạng PDF) và nhấn nút "Ứng tuyển ngay". Hệ thống AI của chúng tôi sẽ phân tích CV và gửi ngay đến nhà tuyển dụng.
                    </div>
                </div>
            </div>
            
            <div class="accordion-item">
                <h2 class="accordion-header">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq2">Làm sao để biết hồ sơ của tôi đã được xem?</button>
                </h2>
                <div id="faq2" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                    <div class="accordion-body">
                        Bạn có thể kiểm tra trong mục <strong>Dashboard > Lịch sử ứng tuyển</strong>. Trạng thái hồ sơ của bạn sẽ được cập nhật liên tục: <em>Chờ xử lý</em>, <em>Đã xem</em>, <em>Đang phỏng vấn</em> hoặc <em>Đã có kết quả</em>.
                    </div>
                </div>
            </div>

            <h5 class="fw-bold text-primary mb-3 mt-5"><i class="bi bi-buildings-fill me-2"></i>Dành cho Nhà Tuyển Dụng</h5>

            <div class="accordion-item">
                <h2 class="accordion-header">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq3">Hệ thống AI chấm điểm (AI Score) hoạt động như thế nào?</button>
                </h2>
                <div id="faq3" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                    <div class="accordion-body">
                        Hệ thống tự động quét PDF CV của ứng viên, đối chiếu từ khóa (Kỹ năng, Kinh nghiệm, Học vấn) với Yêu cầu công việc (Job Requirement) mà bạn nhập. Sau đó, AI trả về một điểm số từ 1 - 100 giúp bạn lọc nhanh các hồ sơ phù hợp nhất mà không cần đọc thủ công.
                    </div>
                </div>
            </div>

            <div class="accordion-item">
                <h2 class="accordion-header">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq4">Tôi muốn mua gói VIP để đăng nhiều tin hơn thì làm sao?</button>
                </h2>
                <div id="faq4" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                    <div class="accordion-body">
                        Hãy truy cập vào <strong>Dashboard Nhà Tuyển Dụng > Nâng cấp VIP</strong>. Chúng tôi hỗ trợ thanh toán trực tuyến qua VNPay và MoMo. Gói VIP sẽ được tự động kích hoạt ngay sau khi thanh toán thành công.
                    </div>
                </div>
            </div>
        </div>
        
        <div class="text-center mt-5">
            <p class="text-muted">Bạn vẫn còn câu hỏi khác?</p>
            <a href="${pageContext.request.contextPath}/contact" class="btn btn-outline-primary rounded-pill px-4 fw-bold">Liên hệ hỗ trợ</a>
        </div>
    </div>

    <footer><div class="container text-center small text-muted">© 2026 ATS Recruitment System.</div></footer>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>