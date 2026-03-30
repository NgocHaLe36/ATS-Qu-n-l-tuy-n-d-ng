<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thêm Nhân Viên - ATS Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        :root { --primary-blue: #007bff; --bg-light: #f8fbff; --sidebar-width: 280px; }
        body { font-family: 'Inter', sans-serif; background-color: var(--bg-light); color: #333; overflow-x: hidden; }
        .text-blue { color: var(--primary-blue); }
        .bg-blue { background-color: var(--primary-blue); }
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
        .admin-card { background: #fff; border: 1px solid #eee; border-radius: 15px; padding: 30px; box-shadow: 0 5px 15px rgba(0,0,0,0.02); }
        .form-label { font-weight: 600; color: #444; font-size: 0.9rem; }
        .form-control, .form-select { padding: 12px 15px; border-radius: 10px; border-color: #dee2e6; }
        .form-control:focus, .form-select:focus { box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.15); border-color: var(--primary-blue); }
    </style>
</head>
<body>
    <aside class="admin-sidebar shadow-sm">
        <div class="sidebar-brand d-flex align-items-center"><i class="bi bi-building-fill text-primary me-2 fs-3"></i><span class="fw-bold fs-4 text-primary">ATS Admin</span></div>
        <ul class="sidebar-menu">
            <li class="sidebar-item"><a href="../dashboard.jsp" class="sidebar-link"><i class="bi bi-grid-1x2-fill"></i> Tổng quan</a></li>
            <div class="sidebar-menu-title">Quản trị hệ thống</div>
            <li class="sidebar-item"><a href="staff-management.jsp" class="sidebar-link active"><i class="bi bi-person-badge"></i> Quản lý nhân viên</a></li>
            <li class="sidebar-item"><a href="#" class="sidebar-link"><i class="bi bi-shield-lock"></i> Quản lý tài khoản</a></li>
            <div class="sidebar-menu-title">Nghiệp vụ cốt lõi</div>
            <li class="sidebar-item"><a href="../recruiters/recruiter-list.jsp" class="sidebar-link"><i class="bi bi-buildings"></i> Quản lý nhà tuyển dụng</a></li>
            <li class="sidebar-item"><a href="../candidates/candidate-list.jsp" class="sidebar-link"><i class="bi bi-people"></i> Quản lý ứng viên</a></li>
            <li class="sidebar-item"><a href="../jobs/job-list.jsp" class="sidebar-link"><i class="bi bi-file-earmark-text"></i> Quản lý tin tuyển dụng</a></li>
            <li class="sidebar-item"><a href="../recruitment-results/recruitment-result-list.jsp" class="sidebar-link"><i class="bi bi-clipboard2-check"></i> Quản lý kết quả tuyển dụng</a></li>
            <div class="sidebar-menu-title">Tài chính & Phân tích</div>
            <li class="sidebar-item"><a href="../vip/vip-plan-management.jsp" class="sidebar-link"><i class="bi bi-gem"></i> Quản lý gói VIP</a></li>
            <li class="sidebar-item"><a href="../transactions/transaction-list.jsp" class="sidebar-link"><i class="bi bi-cash-stack"></i> Quản lý giao dịch</a></li>
            <li class="sidebar-item"><a href="../reports/analytics.jsp" class="sidebar-link"><i class="bi bi-bar-chart-line"></i> Báo cáo tuyển dụng</a></li>
            <div class="sidebar-menu-title">Cá nhân</div>
            <li class="sidebar-item"><a href="../account/change-password.jsp" class="sidebar-link"><i class="bi bi-key"></i> Đổi mật khẩu</a></li>
            <li class="sidebar-item mt-3"><a href="../../logout" class="sidebar-link text-danger bg-danger bg-opacity-10"><i class="bi bi-box-arrow-right text-danger"></i> Đăng xuất</a></li>
        </ul>
    </aside>

    <main class="admin-main">
        <header class="admin-header sticky-top shadow-sm">
            <div class="d-flex align-items-center"><div class="bg-light px-3 py-2 rounded-pill d-flex align-items-center border"><i class="bi bi-search text-muted me-2"></i><input type="text" class="border-0 bg-transparent outline-none" placeholder="Tìm kiếm nhanh..." style="outline: none; width: 250px;"></div></div>
            <div class="dropdown"><a href="#" class="text-dark text-decoration-none dropdown-toggle d-flex align-items-center" data-bs-toggle="dropdown"><img src="https://ui-avatars.com/api/?name=Admin&background=007bff&color=fff" class="rounded-circle me-2" width="40" alt="Admin"><span class="fw-bold">Super Admin</span></a></div>
        </header>

        <div class="container-fluid p-4 flex-grow-1">
            <div class="d-flex align-items-center mb-4">
                <a href="staff-management.jsp" class="btn btn-white bg-white shadow-sm border rounded-circle me-3 d-flex align-items-center justify-content-center" style="width: 45px; height: 45px;"><i class="bi bi-arrow-left fs-5"></i></a>
                <div><h3 class="fw-bold mb-0">Tạo Tài Khoản Nội Bộ</h3><p class="text-muted small mb-0">Cấp quyền truy cập cho nhân viên ATS</p></div>
            </div>

            <div class="row">
                <div class="col-lg-8">
                    <div class="admin-card">
                        <form action="process-create-staff" method="POST">
                            <div class="row g-3 mb-4">
                                <div class="col-md-6">
                                    <label class="form-label">Họ và tên (Full Name) <span class="text-danger">*</span></label>
                                    <input type="text" name="full_name" class="form-control" placeholder="Nguyễn Văn A" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Số điện thoại (Phone) <span class="text-danger">*</span></label>
                                    <input type="text" name="phone" class="form-control" placeholder="09xx xxx xxx" required>
                                </div>
                            </div>
                            <div class="row g-3 mb-4">
                                <div class="col-md-12">
                                    <label class="form-label">Địa chỉ Email <span class="text-danger">*</span></label>
                                    <input type="email" name="email" class="form-control" placeholder="staff@ats.vn" required>
                                </div>
                            </div>
                            <div class="row g-3 mb-4">
                                <div class="col-md-6">
                                    <label class="form-label">Mật khẩu (Password) <span class="text-danger">*</span></label>
                                    <input type="password" name="password" class="form-control" placeholder="Tối thiểu 8 ký tự" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Vai trò (Role) <span class="text-danger">*</span></label>
                                    <select name="role" class="form-select">
                                        <option value="STAFF">Nhân viên hỗ trợ (STAFF)</option>
                                        <option value="ADMIN">Quản trị viên (ADMIN)</option>
                                    </select>
                                </div>
                            </div>
                            <hr class="my-4 opacity-10">
                            <button type="submit" class="btn btn-primary py-3 px-5 rounded-pill fw-bold shadow-sm"><i class="bi bi-save me-2"></i> Lưu tài khoản</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </main>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>