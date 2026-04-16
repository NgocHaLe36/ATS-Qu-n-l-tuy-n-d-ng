<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<footer class="mt-5 border-top pt-5 pb-3">
        <div class="container">
            <div class="row">
                <div class="col-lg-3 mb-4">
                    <div class="d-flex align-items-center mb-3">
                        <i class="bi bi-building-fill text-primary me-2 fs-4"></i>
                        <span class="fw-bold fs-5 text-primary">ATS</span>
                    </div>
                    <p class="text-muted">Hệ thống quản trị tuyển dụng hiện đại, kết nối ứng viên tài năng với doanh nghiệp hàng đầu.</p>
                    <div class="d-flex gap-2">
                        <a href="#" class="btn btn-light btn-sm rounded-circle"><i class="bi bi-facebook text-primary"></i></a>
                        <a href="#" class="btn btn-light btn-sm rounded-circle"><i class="bi bi-linkedin text-primary"></i></a>
                        <a href="#" class="btn btn-light btn-sm rounded-circle"><i class="bi bi-youtube text-danger"></i></a>
                    </div>
                </div>
                <div class="col-6 col-lg-3 mb-4 ps-lg-5">
                    <h6 class="fw-bold mb-4">Dành cho ứng viên</h6>
                    <ul class="list-unstyled">
                        <li class="mb-2"><a href="#" class="text-muted text-decoration-none">Tìm kiếm việc làm</a></li>
                        <li class="mb-2"><a href="#" class="text-muted text-decoration-none">Cẩm nang nghề nghiệp</a></li>
                        <li class="mb-2"><a href="#" class="text-muted text-decoration-none">Tạo CV chuyên nghiệp</a></li>
                        <li class="mb-2"><a href="#" class="text-muted text-decoration-none">Việc làm theo ngành nghề</a></li>
                    </ul>
                </div>
                <div class="col-6 col-lg-3 mb-4">
                    <h6 class="fw-bold mb-4">Dành cho nhà tuyển dụng</h6>
                    <ul class="list-unstyled">
                        <li class="mb-2"><a href="#" class="text-muted text-decoration-none">Đăng tin tuyển dụng</a></li>
                        <li class="mb-2"><a href="#" class="text-muted text-decoration-none">Tìm kiếm hồ sơ</a></li>
                        <li class="mb-2"><a href="#" class="text-muted text-decoration-none">Giải pháp quản lý ATS</a></li>
                        <li class="mb-2"><a href="#" class="text-muted text-decoration-none">Bảng giá gói VIP</a></li>
                    </ul>
                </div>
                <div class="col-lg-3 mb-4">
                    <h6 class="fw-bold mb-4">Liên hệ với chúng tôi</h6>
                    <p class="text-muted small mb-2"><i class="bi bi-geo-alt-fill me-2 text-primary"></i> Tòa nhà Innovation, Công viên phần mềm Quang Trung, TP. HCM</p>
                    <p class="text-muted small mb-2"><i class="bi bi-telephone-fill me-2 text-primary"></i> Hotline: 1900 1234</p>
                    <p class="text-muted small"><i class="bi bi-envelope-fill me-2 text-primary"></i> Email: contact@ats.vn</p>
                </div>
            </div>
            <hr class="my-4 opacity-25">
            <div class="row align-items-center">
                <div class="col-md-6 text-center text-md-start">
                    <p class="small text-muted mb-0">© 2026 ATS Recruitment System. All rights reserved.</p>
                </div>
                <div class="col-md-6 text-center text-md-end mt-2 mt-md-0">
                    <a href="#" class="text-muted text-decoration-none small me-3">Điều khoản sử dụng</a>
                    <a href="#" class="text-muted text-decoration-none small">Chính sách bảo mật</a>
                </div>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Xử lý active menu tự động dựa trên URL
        document.addEventListener('DOMContentLoaded', function() {
            const currentUrl = window.location.pathname;
            document.querySelectorAll('.nav-link').forEach(link => {
                if(currentUrl.includes(link.getAttribute('href'))) {
                    link.classList.add('active');
                }
            });
        });
    </script>
</body>
</html>