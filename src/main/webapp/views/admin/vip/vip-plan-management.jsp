<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Gói VIP - ATS Admin</title>
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
        .admin-card { background: #fff; border: 1px solid #eee; border-radius: 15px; padding: 24px; transition: all 0.3s ease; height: 100%; box-shadow: 0 5px 15px rgba(0,0,0,0.02); }
        .plan-price { font-size: 2rem; font-weight: 800; color: var(--primary-blue); }
    </style>
</head>
<body>
    <aside class="admin-sidebar shadow-sm">
        <div class="sidebar-brand d-flex align-items-center">
            <i class="bi bi-building-fill text-primary me-2 fs-3"></i>
            <span class="fw-bold fs-4 text-primary">ATS Admin</span>
        </div>
        <ul class="sidebar-menu">
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/admin/dashboard" class="sidebar-link"><i class="bi bi-grid-1x2-fill"></i> Tổng quan</a></li>
            <div class="sidebar-menu-title">Quản trị hệ thống</div>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/admin/staff" class="sidebar-link"><i class="bi bi-person-badge"></i> Quản lý nhân viên</a></li>
            <li class="sidebar-item"><a href="#" class="sidebar-link"><i class="bi bi-shield-lock"></i> Quản lý tài khoản</a></li>
            <div class="sidebar-menu-title">Nghiệp vụ cốt lõi</div>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/admin/recruiters" class="sidebar-link"><i class="bi bi-buildings"></i> Quản lý nhà tuyển dụng</a></li>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/admin/candidates" class="sidebar-link"><i class="bi bi-people"></i> Quản lý ứng viên</a></li>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/admin/jobs" class="sidebar-link"><i class="bi bi-file-earmark-text"></i> Quản lý tin tuyển dụng</a></li>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/admin/recruitment-results" class="sidebar-link"><i class="bi bi-clipboard2-check"></i> Quản lý kết quả tuyển dụng</a></li>
            <div class="sidebar-menu-title">Tài chính & Phân tích</div>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/admin/vip/plans" class="sidebar-link active"><i class="bi bi-gem"></i> Quản lý gói VIP</a></li>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/admin/transactions" class="sidebar-link"><i class="bi bi-cash-stack"></i> Quản lý giao dịch</a></li>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/admin/reports" class="sidebar-link"><i class="bi bi-bar-chart-line"></i> Báo cáo tuyển dụng</a></li>
            <div class="sidebar-menu-title">Cá nhân</div>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/auth/change-password" class="sidebar-link"><i class="bi bi-key"></i> Đổi mật khẩu</a></li>
            <li class="sidebar-item mt-3"><a href="${pageContext.request.contextPath}/auth/logout" class="sidebar-link text-danger bg-danger bg-opacity-10"><i class="bi bi-box-arrow-right text-danger"></i> Đăng xuất</a></li>
        </ul>
    </aside>

    <main class="admin-main">
        <header class="admin-header sticky-top shadow-sm">
            <div class="d-flex align-items-center">
                <div class="bg-light px-3 py-2 rounded-pill d-flex align-items-center border">
                    <i class="bi bi-search text-muted me-2"></i>
                    <input type="text" class="border-0 bg-transparent outline-none" placeholder="Tìm kiếm gói VIP..." style="outline: none; width: 250px;">
                </div>
            </div>
            <div class="dropdown">
                <a href="#" class="text-dark text-decoration-none dropdown-toggle d-flex align-items-center" data-bs-toggle="dropdown">
                    <img src="https://ui-avatars.com/api/?name=${admin.fullName}&background=007bff&color=fff" class="rounded-circle me-2" width="40" alt="Admin">
                    <span class="fw-bold">${admin != null ? admin.fullName : 'Super Admin'}</span>
                </a>
            </div>
        </header>

        <div class="container-fluid p-4 flex-grow-1">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <h3 class="fw-bold mb-1">Quản lý Gói VIP (Plans)</h3>
                    <p class="text-muted small">Cấu hình thông tin bảng giá cho Nhà tuyển dụng</p>
                </div>
                <button class="btn btn-primary rounded-pill px-4 fw-bold shadow-sm" data-bs-toggle="modal" data-bs-target="#createPlanModal">
                    <i class="bi bi-plus-lg me-2"></i>Tạo gói mới
                </button>
            </div>

            <div class="row g-4">
                <c:forEach var="plan" items="${plans}">
                    <div class="col-md-4">
                        <div class="admin-card text-center position-relative border-primary border-opacity-25">
                            <h4 class="fw-bold mt-3">${plan.name}</h4>
                            <div class="plan-price my-3"><fmt:formatNumber value="${plan.price}" pattern="#,###" /> đ</div>
                            <p class="text-muted small">${plan.description != null ? plan.description : 'Giải pháp tuyển dụng hiệu quả'}</p>
                            <ul class="list-unstyled text-start mt-4 mb-4">
                                <li class="mb-2"><i class="bi bi-check-circle-fill text-success me-2"></i><strong>Thời hạn:</strong> ${plan.durationDays} ngày</li>
                                <li class="mb-2"><i class="bi bi-check-circle-fill text-success me-2"></i><strong>Giới hạn:</strong> ${plan.jobLimit} tin tuyển dụng</li>
                            </ul>
                            <div class="d-flex gap-2">
                                <button class="btn btn-outline-primary w-100 rounded-pill fw-bold" onclick="editPlan('${plan.id}', '${plan.name}', '${plan.price}', '${plan.durationDays}', '${plan.jobLimit}', '${plan.description}')">Chỉnh sửa</button>
                                <form action="${pageContext.request.contextPath}/admin/vip/plans/delete" method="POST" onsubmit="return confirm('Xóa gói này sẽ ảnh hưởng đến các đăng ký hiện tại. Bạn chắc chắn?')">
                                    <input type="hidden" name="id" value="${plan.id}">
                                    <button type="submit" class="btn btn-outline-danger rounded-circle"><i class="bi bi-trash"></i></button>
                                </form>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </main>

    <div class="modal fade" id="createPlanModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content border-0 shadow">
                <div class="modal-header border-bottom-0"><h5 class="fw-bold">Tạo Gói VIP Mới</h5><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div>
                <div class="modal-body">
                    <form action="${pageContext.request.contextPath}/admin/vip/plans/create" method="POST">
                        <div class="mb-3"><label class="form-label small fw-bold">Tên gói</label><input type="text" name="name" class="form-control" required></div>
                        <div class="mb-3"><label class="form-label small fw-bold">Giá (VNĐ)</label><input type="number" name="price" class="form-control" required></div>
                        <div class="row g-3">
                            <div class="col-6"><label class="form-label small fw-bold">Số ngày</label><input type="number" name="durationDays" class="form-control" required></div>
                            <div class="col-6"><label class="form-label small fw-bold">Giới hạn tin</label><input type="number" name="jobLimit" class="form-control" required></div>
                        </div>
                        <div class="mt-3 mb-4"><label class="form-label small fw-bold">Mô tả</label><textarea name="description" class="form-control" rows="2"></textarea></div>
                        <button type="submit" class="btn btn-primary w-100 rounded-pill py-2 fw-bold">Lưu gói VIP</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="updatePlanModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content border-0 shadow">
                <div class="modal-header border-bottom-0"><h5 class="fw-bold">Cập Nhật Gói VIP</h5><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div>
                <div class="modal-body">
                    <form action="${pageContext.request.contextPath}/admin/vip/plans/update" method="POST">
                        <input type="hidden" name="id" id="edit-id">
                        <div class="mb-3"><label class="form-label small fw-bold">Tên gói</label><input type="text" name="name" id="edit-name" class="form-control"></div>
                        <div class="mb-3"><label class="form-label small fw-bold">Giá (VNĐ)</label><input type="number" name="price" id="edit-price" class="form-control"></div>
                        <div class="row g-3">
                            <div class="col-6"><label class="form-label small fw-bold">Số ngày</label><input type="number" name="durationDays" id="edit-duration" class="form-control"></div>
                            <div class="col-6"><label class="form-label small fw-bold">Giới hạn tin</label><input type="number" name="jobLimit" id="edit-limit" class="form-control"></div>
                        </div>
                        <div class="mt-3 mb-4"><label class="form-label small fw-bold">Mô tả</label><textarea name="description" id="edit-desc" class="form-control" rows="2"></textarea></div>
                        <button type="submit" class="btn btn-primary w-100 rounded-pill py-2 fw-bold">Cập nhật ngay</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function editPlan(id, name, price, duration, limit, desc) {
            document.getElementById('edit-id').value = id;
            document.getElementById('edit-name').value = name;
            document.getElementById('edit-price').value = price;
            document.getElementById('edit-duration').value = duration;
            document.getElementById('edit-limit').value = limit;
            document.getElementById('edit-desc').value = desc;
            new bootstrap.Modal(document.getElementById('updatePlanModal')).show();
        }
    </script>
</body>
</html>