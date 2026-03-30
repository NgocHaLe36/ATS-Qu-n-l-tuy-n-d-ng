<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Kết Quả Tuyển Dụng - ATS Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">

    <style>
        /* Kế thừa phong cách */
        :root { --primary-blue: #007bff; --bg-light: #f8fbff; --sidebar-width: 280px; }
        body { font-family: 'Inter', sans-serif; background-color: var(--bg-light); color: #333; overflow-x: hidden; }
        .text-blue { color: var(--primary-blue); }

        /* Sidebar Styling */
        .admin-sidebar { width: var(--sidebar-width); height: 100vh; position: fixed; top: 0; left: 0; background: #fff; border-right: 1px solid #eee; overflow-y: auto; z-index: 1000; }
        .sidebar-brand { padding: 20px; border-bottom: 1px solid #eee; }
        .sidebar-menu { padding: 15px 10px; list-style: none; margin: 0; }
        .sidebar-menu-title { font-size: 0.75rem; text-transform: uppercase; font-weight: 700; color: #999; margin: 20px 0 10px 15px; letter-spacing: 0.5px; }
        .sidebar-item { margin-bottom: 5px; }
        .sidebar-link { display: flex; align-items: center; padding: 12px 15px; color: #555; text-decoration: none; font-weight: 500; border-radius: 10px; transition: all 0.3s ease; }
        .sidebar-link:hover, .sidebar-link.active { background-color: rgba(0, 123, 255, 0.08); color: var(--primary-blue); }
        .sidebar-link i { margin-right: 12px; font-size: 1.2rem; }

        /* Main Content Styling */
        .admin-main { margin-left: var(--sidebar-width); min-height: 100vh; display: flex; flex-direction: column; }
        .admin-header { background: #fff; padding: 15px 30px; border-bottom: 1px solid #eee; display: flex; justify-content: space-between; align-items: center; }
        .admin-card { background: #fff; border: 1px solid #eee; border-radius: 15px; padding: 24px; transition: all 0.3s ease; box-shadow: 0 5px 15px rgba(0,0,0,0.02); }
        
        .table > :not(caption) > * > * { padding: 16px 12px; border-bottom-color: #f1f5f9; vertical-align: middle; }
        .badge-status { padding: 6px 12px; border-radius: 50px; font-size: 0.75rem; font-weight: 600; }
        .ai-score-high { color: #10b981; font-weight: 800; font-size: 1.1rem; }
        .ai-score-med { color: #f59e0b; font-weight: 800; font-size: 1.1rem; }
    </style>
</head>
<body>

    <aside class="admin-sidebar shadow-sm">
        <div class="sidebar-brand d-flex align-items-center">
            <i class="bi bi-building-fill text-primary me-2 fs-3"></i>
            <span class="fw-bold fs-4 text-primary">ATS Admin</span>
        </div>

        <ul class="sidebar-menu">
            <li class="sidebar-item"><a href="admin-dashboard.jsp" class="sidebar-link"><i class="bi bi-grid-1x2-fill"></i> Tổng quan</a></li>

            <div class="sidebar-menu-title">Quản trị hệ thống</div>
            <li class="sidebar-item"><a href="#" class="sidebar-link"><i class="bi bi-person-badge"></i> Quản lý nhân viên</a></li>
            <li class="sidebar-item"><a href="#" class="sidebar-link"><i class="bi bi-shield-lock"></i> Quản lý tài khoản</a></li>

            <div class="sidebar-menu-title">Nghiệp vụ cốt lõi</div>
            <li class="sidebar-item"><a href="recruiter-list.jsp" class="sidebar-link"><i class="bi bi-buildings"></i> Quản lý nhà tuyển dụng</a></li>
            <li class="sidebar-item"><a href="#" class="sidebar-link"><i class="bi bi-people"></i> Quản lý ứng viên</a></li>
            <li class="sidebar-item"><a href="#" class="sidebar-link"><i class="bi bi-file-earmark-text"></i> Quản lý tin tuyển dụng</a></li>
            <li class="sidebar-item">
                <a href="recruitment-result-list.jsp" class="sidebar-link active"><i class="bi bi-clipboard2-check"></i> Quản lý kết quả tuyển dụng</a>
            </li>

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
            <div class="d-flex align-items-center gap-3">
                <div class="dropdown">
                    <a href="#" class="text-dark text-decoration-none dropdown-toggle d-flex align-items-center" data-bs-toggle="dropdown">
                        <img src="https://ui-avatars.com/api/?name=Admin&background=007bff&color=fff" class="rounded-circle me-2" width="40" alt="Admin">
                        <span class="fw-bold">Super Admin</span>
                    </a>
                </div>
            </div>
        </header>

        <div class="container-fluid p-4 flex-grow-1">
            <div class="mb-4">
                <h3 class="fw-bold mb-1">Kết Quả Tuyển Dụng & Ứng Tuyển</h3>
                <p class="text-muted small">Theo dõi hồ sơ nộp vào và điểm AI tự động đánh giá</p>
            </div>

            <div class="admin-card">
                <div class="row mb-4 g-3">
                    <div class="col-md-4">
                        <div class="input-group border rounded-pill overflow-hidden bg-white">
                            <span class="input-group-text bg-transparent border-0"><i class="bi bi-search text-muted"></i></span>
                            <input type="text" class="form-control border-0 shadow-none" placeholder="Tên ứng viên hoặc vị trí công việc...">
                        </div>
                    </div>
                    <div class="col-md-3">
                        <select class="form-select rounded-pill border shadow-none">
                            <option value="">Lọc theo điểm AI</option>
                            <option value="high">Rất phù hợp (>85 điểm)</option>
                            <option value="med">Phù hợp (60 - 85 điểm)</option>
                            <option value="low">Chưa phù hợp (<60 điểm)</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <select class="form-select rounded-pill border shadow-none">
                            <option value="">Trạng thái hồ sơ</option>
                            <option value="pending">Chờ xử lý</option>
                            <option value="interviewing">Đang phỏng vấn</option>
                            <option value="hired">Đã trúng tuyển</option>
                            <option value="rejected">Bị loại</option>
                        </select>
                    </div>
                    <div class="col-md-2 text-end">
                        <button class="btn btn-primary rounded-pill w-100 fw-bold">Lọc</button>
                    </div>
                </div>

                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead class="bg-light text-muted small text-uppercase">
                            <tr>
                                <th class="border-0 rounded-start">Mã HS</th>
                                <th class="border-0">Ứng viên nộp</th>
                                <th class="border-0">Vị trí ứng tuyển</th>
                                <th class="border-0 text-center">Điểm AI</th>
                                <th class="border-0">Ngày nộp</th>
                                <th class="border-0">Trạng thái</th>
                                <th class="border-0 rounded-end text-center">Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="fw-bold">#APP-102</td>
                                <td>
                                    <div class="fw-bold text-dark">Nguyễn Ngọc Hà</div>
                                    <small class="text-primary"><i class="bi bi-file-earmark-pdf me-1"></i> CV_Ngocha.pdf</small>
                                </td>
                                <td>
                                    <div class="fw-bold">Senior Backend Developer</div>
                                    <small class="text-muted">FPT Software</small>
                                </td>
                                <td class="text-center">
                                    <span class="ai-score-high">92</span><span class="text-muted small">/100</span>
                                </td>
                                <td class="text-muted">19/03/2026</td>
                                <td><span class="badge-status bg-info bg-opacity-10 text-info">Đang phỏng vấn</span></td>
                                <td class="text-center">
                                    <button class="btn btn-sm btn-light text-primary rounded-circle" title="Xem chi tiết điểm AI và CV"><i class="bi bi-eye"></i></button>
                                    <button class="btn btn-sm btn-light text-success rounded-circle ms-1" title="Đánh giá kết quả (Scorecard)"><i class="bi bi-journal-check"></i></button>
                                </td>
                            </tr>
                            <tr>
                                <td class="fw-bold">#APP-103</td>
                                <td>
                                    <div class="fw-bold text-dark">Trần Đình Bảo</div>
                                    <small class="text-primary"><i class="bi bi-file-earmark-pdf me-1"></i> Bao_Marketing.pdf</small>
                                </td>
                                <td>
                                    <div class="fw-bold">Marketing Manager</div>
                                    <small class="text-muted">Shopee VN</small>
                                </td>
                                <td class="text-center">
                                    <span class="ai-score-med">65</span><span class="text-muted small">/100</span>
                                </td>
                                <td class="text-muted">18/03/2026</td>
                                <td><span class="badge-status bg-warning bg-opacity-10 text-warning">Chờ xử lý</span></td>
                                <td class="text-center">
                                    <button class="btn btn-sm btn-light text-primary rounded-circle"><i class="bi bi-eye"></i></button>
                                    <button class="btn btn-sm btn-light text-success rounded-circle ms-1"><i class="bi bi-journal-check"></i></button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>

            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>