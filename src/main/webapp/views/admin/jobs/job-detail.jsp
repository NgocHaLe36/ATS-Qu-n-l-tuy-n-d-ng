<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết Tin Tuyển Dụng - ATS Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">

    <style>
        :root { --primary-blue: #007bff; --bg-light: #f8fbff; --sidebar-width: 280px; }
        body { font-family: 'Inter', sans-serif; background-color: var(--bg-light); color: #333; overflow-x: hidden; }
        .admin-sidebar { width: var(--sidebar-width); height: 100vh; position: fixed; top: 0; left: 0; background: #fff; border-right: 1px solid #eee; overflow-y: auto; z-index: 1000; }
        .sidebar-brand { padding: 20px; border-bottom: 1px solid #eee; }
        .sidebar-menu { padding: 15px 10px; list-style: none; margin: 0; }
        .sidebar-menu-title { font-size: 0.75rem; text-transform: uppercase; font-weight: 700; color: #999; margin: 20px 0 10px 15px; letter-spacing: 0.5px; }
        .sidebar-item { margin-bottom: 5px; }
        .sidebar-link { display: flex; align-items: center; padding: 12px 15px; color: #555; text-decoration: none; font-weight: 500; border-radius: 10px; transition: all 0.3s ease; }
        .sidebar-link:hover, .sidebar-link.active { background-color: rgba(0, 123, 255, 0.08); color: var(--primary-blue); }
        .sidebar-link i { margin-right: 12px; font-size: 1.2rem; }

        .admin-main { margin-left: var(--sidebar-width); min-height: 100vh; display: flex; flex-direction: column; }
        .admin-header { background: #fff; padding: 15px 30px; border-bottom: 1px solid #eee; display: flex; justify-content: space-between; align-items: center; }
        
        .admin-card { background: #fff; border: 1px solid #edf2f7; border-radius: 15px; padding: 24px; margin-bottom: 24px; box-shadow: 0 5px 20px rgba(0,0,0,0.02); }
        .company-logo { width: 70px; height: 70px; border-radius: 12px; object-fit: cover; border: 1px solid #eee; }
        .badge-status { padding: 8px 16px; border-radius: 50px; font-weight: 600; font-size: 0.85rem; }
        .info-label { font-size: 0.85rem; color: #64748b; font-weight: 600; text-transform: uppercase; margin-bottom: 5px; }
        .info-value { font-size: 1rem; color: #0f172a; font-weight: 500; }
        .section-title { font-size: 1.1rem; font-weight: 700; color: #1e293b; border-left: 4px solid var(--primary-blue); padding-left: 12px; margin-bottom: 20px; }
    </style>
</head>
<body>

    <aside class="admin-sidebar shadow-sm">
        <div class="sidebar-brand d-flex align-items-center">
            <i class="bi bi-building-fill text-primary me-2 fs-3"></i>
            <span class="fw-bold fs-4 text-primary">ATS Admin</span>
        </div>

        <ul class="sidebar-menu">
            <li class="sidebar-item"><a href="dashboard.jsp" class="sidebar-link"><i class="bi bi-grid-1x2-fill"></i> Tổng quan</a></li>

            <div class="sidebar-menu-title">Quản trị hệ thống</div>
            <li class="sidebar-item"><a href="#" class="sidebar-link"><i class="bi bi-person-badge"></i> Quản lý nhân viên</a></li>
            <li class="sidebar-item"><a href="#" class="sidebar-link"><i class="bi bi-shield-lock"></i> Quản lý tài khoản</a></li>

            <div class="sidebar-menu-title">Nghiệp vụ cốt lõi</div>
            <li class="sidebar-item"><a href="recruiter-list.jsp" class="sidebar-link"><i class="bi bi-buildings"></i> Quản lý nhà tuyển dụng</a></li>
            <li class="sidebar-item"><a href="#" class="sidebar-link"><i class="bi bi-people"></i> Quản lý ứng viên</a></li>
            <li class="sidebar-item">
                <a href="job-list.jsp" class="sidebar-link active"><i class="bi bi-file-earmark-text"></i> Quản lý tin tuyển dụng</a>
            </li>
            <li class="sidebar-item"><a href="#" class="sidebar-link"><i class="bi bi-clipboard2-check"></i> Quản lý kết quả tuyển dụng</a></li>

            <div class="sidebar-menu-title">Tài chính & Phân tích</div>
            <li class="sidebar-item"><a href="#" class="sidebar-link"><i class="bi bi-gem"></i> Quản lý gói VIP</a></li>
            <li class="sidebar-item"><a href="#" class="sidebar-link"><i class="bi bi-cash-stack"></i> Quản lý giao dịch</a></li>
            <li class="sidebar-item"><a href="#" class="sidebar-link"><i class="bi bi-bar-chart-line"></i> Báo cáo tuyển dụng</a></li>

            <div class="sidebar-menu-title">Cá nhân</div>
            <li class="sidebar-item"><a href="#" class="sidebar-link"><i class="bi bi-key"></i> Đổi mật khẩu</a></li>
            <li class="sidebar-item mt-3">
                <a href="#" class="sidebar-link text-danger bg-danger bg-opacity-10"><i class="bi bi-box-arrow-right text-danger"></i> Đăng xuất</a>
            </li>
        </ul>
    </aside>

    <main class="admin-main">
        <header class="admin-header sticky-top shadow-sm">
            <div class="d-flex align-items-center">
                <div class="bg-light px-3 py-2 rounded-pill d-flex align-items-center border">
                    <i class="bi bi-search text-muted me-2"></i>
                    <input type="text" class="border-0 bg-transparent outline-none" placeholder="Tìm kiếm nhanh..." style="outline: none; width: 250px;">
                </div>
            </div>
            <div class="dropdown">
                <a href="#" class="text-dark text-decoration-none dropdown-toggle d-flex align-items-center" data-bs-toggle="dropdown">
                    <img src="https://ui-avatars.com/api/?name=Admin&background=007bff&color=fff" class="rounded-circle me-2" width="40" alt="Admin">
                    <span class="fw-bold">Super Admin</span>
                </a>
            </div>
        </header>

        <div class="container-fluid p-4 flex-grow-1">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div class="d-flex align-items-center">
                    <a href="job-list.jsp" class="btn btn-white bg-white shadow-sm border rounded-circle me-3 d-flex align-items-center justify-content-center" style="width: 45px; height: 45px;"><i class="bi bi-arrow-left fs-5"></i></a>
                    <div>
                        <h3 class="fw-bold mb-0">Chi tiết tin tuyển dụng</h3>
                        <p class="text-muted small mb-0">Mã tin: #JOB-2026</p>
                    </div>
                </div>
                <button class="btn btn-danger rounded-pill px-4 fw-bold"><i class="bi bi-eye-slash me-2"></i>Ẩn tin vi phạm</button>
            </div>

            <div class="admin-card">
                <div class="d-flex justify-content-between align-items-start">
                    <div>
                        <div class="d-flex align-items-center gap-2 mb-3">
                            <span class="badge-status bg-success bg-opacity-10 text-success">Đang hiển thị</span>
                            <span class="badge-status bg-warning bg-opacity-10 text-warning"><i class="bi bi-star-fill me-1"></i> Tin VIP</span>
                        </div>
                        <h2 class="fw-bold text-dark mb-2">Senior Backend Developer (Java/Spring Boot)</h2>
                        <p class="text-primary fw-semibold mb-0"><i class="bi bi-building me-2"></i>FPT Software JSC</p>
                    </div>
                    <img src="https://ui-avatars.com/api/?name=FPT+Software&background=007bff&color=fff&size=150" class="company-logo" alt="Logo">
                </div>
                <hr class="my-4 opacity-10">
                <div class="row g-4">
                    <div class="col-md-3 border-end">
                        <div class="info-label"><i class="bi bi-currency-dollar me-1"></i> Mức lương</div>
                        <div class="info-value text-success fw-bold">25M - 40M VNĐ</div>
                    </div>
                    <div class="col-md-3 border-end">
                        <div class="info-label"><i class="bi bi-geo-alt me-1"></i> Địa điểm</div>
                        <div class="info-value">Quận 1, TP.HCM</div>
                    </div>
                    <div class="col-md-3 border-end">
                        <div class="info-label"><i class="bi bi-calendar-x me-1"></i> Hạn nộp</div>
                        <div class="info-value text-danger fw-bold">30/06/2026</div>
                    </div>
                    <div class="col-md-3">
                        <div class="info-label"><i class="bi bi-clock-history me-1"></i> Ngày đăng</div>
                        <div class="info-value">15/03/2026</div>
                    </div>
                </div>
            </div>

            <div class="row g-4">
                <div class="col-lg-8">
                    <div class="admin-card h-100">
                        <h5 class="section-title">Mô tả công việc (Description)</h5>
                        <p class="text-muted" style="line-height: 1.8;">- Tham gia phân tích, thiết kế hệ thống Database và Microservices.<br>- Viết code backend sử dụng Java và framework Spring Boot.<br>- Tối ưu hóa các truy vấn SQL Server để đảm bảo hệ thống phản hồi nhanh.</p>
                        
                        <h5 class="section-title mt-5">Yêu cầu công việc (Requirement)</h5>
                        <p class="text-muted" style="line-height: 1.8;">- Tối thiểu 3 năm kinh nghiệm làm việc thực tế với Java.<br>- Thành thạo Spring Framework.<br>- Hiểu biết sâu sắc về SQL Server, thiết kế ERD.</p>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="admin-card bg-primary bg-opacity-10 border-primary border-opacity-25 mb-4">
                        <h5 class="fw-bold text-primary mb-4">Thống kê hiệu quả</h5>
                        <div class="d-flex justify-content-between mb-3"><span class="text-primary opacity-75">Lượt xem:</span><span class="fw-bold text-primary">1,245</span></div>
                        <div class="d-flex justify-content-between mb-3"><span class="text-primary opacity-75">Hồ sơ đã nộp:</span><span class="fw-bold text-primary">42</span></div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>