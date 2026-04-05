<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch sử thanh toán - ATS Recruiter</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        :root { --primary-blue: #007bff; --bg-light: #f8fbff; --sidebar-width: 280px; }
        body { font-family: 'Inter', sans-serif; background-color: var(--bg-light); color: #333; margin: 0; }
        
        /* Sidebar */
        .admin-sidebar { width: var(--sidebar-width); height: 100vh; position: fixed; top: 0; left: 0; background: #fff; border-right: 1px solid #eee; overflow-y: auto; z-index: 1000; display: flex; flex-direction: column; }
        .sidebar-brand { padding: 20px; border-bottom: 1px solid #eee; }
        .sidebar-brand a { text-decoration: none !important; }
        .sidebar-menu { padding: 15px 10px; list-style: none; margin: 0; flex-grow: 1; }
        .sidebar-menu-title { font-size: 0.75rem; text-transform: uppercase; font-weight: 700; color: #999; margin: 20px 0 10px 15px; letter-spacing: 0.5px; }
        .sidebar-link { display: flex; align-items: center; padding: 12px 15px; color: #555; text-decoration: none; font-weight: 500; border-radius: 10px; transition: 0.3s; margin-bottom: 5px; }
        .sidebar-link:hover, .sidebar-link.active { background-color: rgba(0, 123, 255, 0.08); color: var(--primary-blue); font-weight: 700; }
        .sidebar-link i { margin-right: 12px; font-size: 1.2rem; }
        
        /* Logout Area */
        .logout-area { padding: 20px; border-top: 1px solid #eee; }
        .btn-logout { display: flex !important; align-items: center; padding: 12px 15px; border-radius: 10px; color: #dc3545 !important; background-color: rgba(220, 53, 69, 0.1); text-decoration: none !important; font-weight: 700; transition: 0.3s; border: none; width: 100%; }
        .btn-logout:hover { background-color: #dc3545; color: #fff !important; }

        /* Main Content */
        .admin-main { margin-left: var(--sidebar-width); min-height: 100vh; }
        .admin-header { background: #fff; padding: 15px 30px; border-bottom: 1px solid #eee; display: flex; justify-content: space-between; align-items: center; }
        
        /* Table & Card */
        .admin-card { background: #fff; border: 1px solid #edf2f7; border-radius: 15px; padding: 24px; box-shadow: 0 5px 20px rgba(0,0,0,0.02); margin-bottom: 24px; }
        .table thead th { font-size: 0.75rem; text-transform: uppercase; letter-spacing: 1px; color: #888; border: none; padding: 15px 10px; }
        .table tbody td { padding: 18px 10px; vertical-align: middle; border-bottom: 1px solid #f8f9fa; }
        
        /* Trạng thái */
        .status-paid { background: #e8f5e9; color: #2e7d32; font-weight: 700; padding: 6px 14px; border-radius: 50px; font-size: 0.75rem; display: inline-block; }
        .status-failed { background: #ffebee; color: #c62828; font-weight: 700; padding: 6px 14px; border-radius: 50px; font-size: 0.75rem; display: inline-block; }
        
        .amount-text { font-weight: 800; color: #1e293b; font-size: 1rem; }
        .transaction-id { font-family: 'Monaco', 'Consolas', monospace; color: var(--primary-blue); font-weight: 600; background: #f0f7ff; padding: 2px 8px; border-radius: 4px; }
    </style>
</head>
<body>
    <aside class="admin-sidebar shadow-sm">
        <%-- 1. Thêm link Logo quay về Dashboard --%>
        <div class="sidebar-brand">
            <a href="${pageContext.request.contextPath}/recruiter/dashboard" class="d-flex align-items-center">
                <i class="bi bi-rocket-takeoff-fill text-primary me-2 fs-3"></i>
                <span class="fw-bold fs-4 text-primary">ATS Recruiter</span>
            </a>
        </div>
        
        <ul class="sidebar-menu">
            <li class="sidebar-item">
                <a href="${pageContext.request.contextPath}/recruiter/dashboard" class="sidebar-link">
                    <i class="bi bi-grid-1x2-fill"></i> Tổng quan
                </a>
            </li>
            <div class="sidebar-menu-title">Tuyển dụng</div>
            <%-- 2. Cấu hình đầy đủ link Sidebar --%>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/jobs/create" class="sidebar-link"><i class="bi bi-plus-circle"></i> Đăng tin mới</a></li>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/jobs" class="sidebar-link"><i class="bi bi-file-earmark-text"></i> Quản lý tin đăng</a></li>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/pipeline" class="sidebar-link"><i class="bi bi-people"></i> Danh sách ứng viên</a></li>
            
            <div class="sidebar-menu-title">Tài khoản & Dịch vụ</div>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/vip/plans" class="sidebar-link"><i class="bi bi-gem"></i> Gói dịch vụ VIP</a></li>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/payment/history" class="sidebar-link active"><i class="bi bi-credit-card"></i> Lịch sử thanh toán</a></li>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/account/profile" class="sidebar-link"><i class="bi bi-person-gear"></i> Hồ sơ công ty</a></li>
            
            <div class="sidebar-menu-title">Cá nhân</div>
            <li class="sidebar-item">
                <a href="${pageContext.request.contextPath}/recruiter/account/change-password" class="sidebar-link">
                    <i class="bi bi-key"></i> Đổi mật khẩu
                </a>
            </li>
        </ul>
        
        <%-- 3. Đồng bộ nút Đăng xuất Sidebar --%>
        <div class="logout-area">
            <a href="${pageContext.request.contextPath}/auth/logout" class="btn-logout">
                <i class="bi bi-box-arrow-right me-2"></i> <span>Đăng xuất</span>
            </a>
        </div>
    </aside>

    <main class="admin-main">
        <header class="admin-header sticky-top shadow-sm">
            <h5 class="fw-bold mb-0 text-dark">Lịch sử giao dịch</h5>
            <div class="dropdown">
                <button class="btn btn-link text-dark text-decoration-none dropdown-toggle d-flex align-items-center p-0 border-0 shadow-none" data-bs-toggle="dropdown">
                    <div class="bg-primary text-white rounded-circle me-2 d-flex align-items-center justify-content-center" style="width: 35px; height: 35px; font-weight: 700; font-size: 0.8rem;">
                        ${currentUser.fullName.substring(0,2).toUpperCase()}
                    </div>
                    <span class="fw-bold small">${currentUser.fullName}</span>
                </button>
                <ul class="dropdown-menu dropdown-menu-end shadow border-0 mt-2">
                    <li><a class="dropdown-item py-2" href="${pageContext.request.contextPath}/recruiter/account/profile"><i class="bi bi-person me-2"></i> Hồ sơ</a></li>
                    <li><hr class="dropdown-divider"></li>
                    <li><a class="dropdown-item text-danger py-2" href="${pageContext.request.contextPath}/auth/logout"><i class="bi bi-box-arrow-right me-2"></i> Đăng xuất</a></li>
                </ul>
            </div>
        </header>

        <div class="container-fluid p-4">
            <div class="admin-card overflow-hidden p-0 shadow-sm">
                <div class="px-4 pt-4 pb-2 d-flex justify-content-between align-items-center">
                    <div>
                        <h5 class="fw-bold mb-0 text-dark">Hóa đơn thanh toán</h5>
                        <p class="text-muted small">Chi tiết các giao dịch mua gói dịch vụ nâng cao</p>
                    </div>
                    <div class="bg-primary bg-opacity-10 p-3 rounded-circle text-primary">
                        <i class="bi bi-shield-check fs-3"></i>
                    </div>
                </div>
                
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="bg-light">
                            <tr>
                                <th class="ps-4">Mã giao dịch</th>
                                <th>Gói dịch vụ</th>
                                <th>Số tiền</th>
                                <th>Phương thức</th>
                                <th>Thời gian</th>
                                <th class="text-center pe-4">Trạng thái</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="pay" items="${payments}">
                                <tr>
                                    <td class="ps-4">
                                        <span class="transaction-id">${pay.transactionCode}</span>
                                    </td>
                                    <td>
                                        <div class="fw-bold text-dark">${pay.subscription.plan.name}</div>
                                        <small class="text-muted">Hạn dùng ${pay.subscription.plan.durationDays} ngày</small>
                                    </td>
                                    <td>
                                        <span class="amount-text text-primary">
                                            <fmt:formatNumber value="${pay.amount}" type="number" groupingUsed="true"/> ₫
                                        </span>
                                    </td>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <i class="bi bi-credit-card-2-back me-2 text-muted"></i>
                                            <span class="small fw-bold text-muted text-uppercase">${pay.paymentMethod}</span>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="small fw-bold text-dark">
                                            <%-- Cập nhật cách hiển thị ngày tháng an toàn hơn --%>
                                            <fmt:parseDate value="${pay.paymentDate}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both" />
                                            <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy" />
                                        </div>
                                        <div class="text-muted small">
                                            <fmt:formatDate value="${parsedDate}" pattern="HH:mm" />
                                        </div>
                                    </td>
                                    <td class="text-center pe-4">
                                        <c:choose>
                                            <c:when test="${pay.status == 'success' || pay.status == 'paid' || pay.status == 'active' || pay.status == 'SUCCESS'}">
                                                <span class="status-paid"><i class="bi bi-check2-circle me-1"></i> Thành công</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status-failed"><i class="bi bi-x-circle me-1"></i> Thất bại</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                            
                            <c:if test="${empty payments}">
                                <tr>
                                    <td colspan="6" class="text-center py-5">
                                        <div class="py-4">
                                            <i class="bi bi-receipt-cutoff fs-1 text-muted opacity-25"></i>
                                            <p class="mt-3 text-muted">Bạn chưa có lịch sử giao dịch nào.</p>
                                            <a href="${pageContext.request.contextPath}/recruiter/vip/plans" class="btn btn-sm btn-primary rounded-pill px-4 mt-2 fw-bold shadow-sm">Nâng cấp VIP ngay</a>
                                        </div>
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>