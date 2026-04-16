<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gói dịch vụ VIP - ATS Recruiter</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        :root { --primary-blue: #007bff; --bg-light: #f8fbff; --sidebar-width: 280px; }
        body { font-family: 'Inter', sans-serif; background-color: var(--bg-light); color: #333; margin: 0; }
        
        /* Sidebar đồng bộ Dashboard */
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
        
        /* Pricing Cards */
        .plan-card { background: #fff; border: 1px solid #edf2f7; border-radius: 20px; padding: 40px 30px; transition: 0.3s; position: relative; overflow: hidden; height: 100%; display: flex; flex-direction: column; }
        .plan-card:hover { transform: translateY(-10px); box-shadow: 0 15px 30px rgba(0,123,255,0.1); border-color: var(--primary-blue); }
        .plan-card.popular { border: 2px solid var(--primary-blue); }
        .popular-badge { position: absolute; top: 20px; right: -35px; background: var(--primary-blue); color: #fff; padding: 5px 40px; transform: rotate(45deg); font-size: 0.7rem; font-weight: 800; text-transform: uppercase; }
        
        .price-tag { font-size: 2.5rem; font-weight: 800; color: #1e293b; margin-bottom: 10px; }
        .price-tag span { font-size: 1rem; color: #64748b; font-weight: 500; }
        
        .feature-list { list-style: none; padding: 0; margin: 30px 0; flex-grow: 1; }
        .feature-list li { margin-bottom: 15px; display: flex; align-items: center; color: #475569; font-size: 0.95rem; }
        .feature-list li i { color: #10b981; margin-right: 12px; font-size: 1.2rem; }
    </style>
</head>
<body>
    <aside class="admin-sidebar shadow-sm">
        <%-- 1. Cập nhật link Logo quay về Dashboard --%>
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
            <%-- 2. Điền đầy đủ link Sidebar --%>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/jobs/create" class="sidebar-link"><i class="bi bi-plus-circle"></i> Đăng tin mới</a></li>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/jobs" class="sidebar-link"><i class="bi bi-file-earmark-text"></i> Quản lý tin đăng</a></li>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/pipeline" class="sidebar-link"><i class="bi bi-people"></i> Danh sách ứng viên</a></li>
            
            <div class="sidebar-menu-title">Tài khoản & Dịch vụ</div>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/vip/plans" class="sidebar-link active"><i class="bi bi-gem"></i> Gói dịch vụ VIP</a></li>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/payment/history" class="sidebar-link"><i class="bi bi-credit-card"></i> Lịch sử thanh toán</a></li>
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
            <h5 class="fw-bold mb-0 text-dark">Nâng cấp tài khoản VIP</h5>
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

        <div class="container-fluid p-5">
            <div class="text-center mb-5">
                <h2 class="fw-bold text-dark">Chọn gói dịch vụ phù hợp</h2>
                <p class="text-muted">Đẩy mạnh hiệu quả tuyển dụng và tiếp cận ứng viên tiềm năng nhanh hơn.</p>
                
                <c:if test="${not empty warningMessage}">
                    <div class="alert alert-warning border-0 shadow-sm d-inline-block px-4 mt-3 rounded-pill">
                        <i class="bi bi-exclamation-circle-fill me-2"></i> ${warningMessage}
                        <% session.removeAttribute("warningMessage"); %>
                    </div>
                </c:if>
            </div>

            <div class="row g-4 justify-content-center">
                <c:forEach var="plan" items="${plans}">
                    <div class="col-md-4">
                        <div class="plan-card ${plan.durationDays >= 30 ? 'popular' : ''} shadow-sm">
                            <c:if test="${plan.durationDays >= 30}">
                                <div class="popular-badge">Phổ biến</div>
                            </c:if>
                            
                            <h5 class="fw-bold text-muted text-uppercase mb-3" style="font-size: 0.8rem; letter-spacing: 1px;">${plan.name}</h5>
                            <div class="price-tag">
                                <fmt:formatNumber value="${plan.price}" type="number"/>₫
                                <span>/${plan.durationDays} ngày</span>
                            </div>
                            
                            <ul class="feature-list">
                                <li><i class="bi bi-check-circle-fill"></i> Đăng tin tuyển dụng VIP</li>
                                <li><i class="bi bi-check-circle-fill"></i> Hiển thị ưu tiên đầu trang</li>
                                <li><i class="bi bi-check-circle-fill"></i> Xem thông tin liên hệ ứng viên</li>
                                <li><i class="bi bi-check-circle-fill"></i> Huy hiệu xác thực đối tác</li>
                                <c:if test="${plan.durationDays > 7}">
                                    <li><i class="bi bi-check-circle-fill"></i> Hỗ trợ kỹ thuật 24/7</li>
                                </c:if>
                            </ul>

                            <form action="${pageContext.request.contextPath}/recruiter/vip/register" method="post">
                                <input type="hidden" name="planId" value="${plan.id}">
                                <button type="submit" class="btn ${plan.durationDays >= 30 ? 'btn-primary' : 'btn-outline-primary'} w-100 py-3 rounded-pill fw-bold shadow-sm">
                                    Đăng ký gói ngay
                                </button>
                            </form>
                        </div>
                    </div>
                </c:forEach>
                
                <c:if test="${empty plans}">
                    <div class="col-12 text-center py-5">
                        <div class="opacity-25 mb-3">
                            <i class="bi bi-search fs-1"></i>
                        </div>
                        <p class="text-muted">Hiện tại chưa có gói dịch vụ nào được cấu hình.</p>
                    </div>
                </c:if>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>