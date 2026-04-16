<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xem CV - ${candidate.user.fullName} - ATS Recruiter</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">

    <style>
        :root { --primary-blue: #007bff; --bg-light: #f8fbff; --sidebar-width: 280px; --text-muted: #64748b; }
        body { font-family: 'Inter', sans-serif; background-color: var(--bg-light); color: #1e293b; margin: 0; }
        
        /* Sidebar Layout đồng bộ DASHBOARD */
        .admin-sidebar { width: var(--sidebar-width); height: 100vh; position: fixed; top: 0; left: 0; background: #fff; border-right: 1px solid #eee; overflow-y: auto; z-index: 1000; display: flex; flex-direction: column; }
        .sidebar-brand { padding: 20px; border-bottom: 1px solid #eee; }
        .sidebar-brand a { text-decoration: none !important; }
        .sidebar-menu { padding: 15px 10px; list-style: none; margin: 0; flex-grow: 1; }
        .sidebar-menu-title { font-size: 0.75rem; text-transform: uppercase; font-weight: 700; color: #999; margin: 20px 0 10px 15px; letter-spacing: 0.5px; }
        .sidebar-link { display: flex; align-items: center; padding: 12px 15px; color: #555; text-decoration: none; font-weight: 500; border-radius: 10px; transition: 0.3s; margin-bottom: 5px; }
        .sidebar-link:hover, .sidebar-link.active { background-color: rgba(0, 123, 255, 0.08); color: var(--primary-blue); font-weight: 700; }
        .sidebar-link i { margin-right: 12px; font-size: 1.2rem; }
        .logout-area { padding: 20px; border-top: 1px solid #eee; margin-top: auto; }

        /* Main Content */
        .admin-main { margin-left: var(--sidebar-width); min-height: 100vh; display: flex; flex-direction: column; }
        .admin-header { background: #fff; padding: 15px 30px; border-bottom: 1px solid #eee; display: flex; justify-content: space-between; align-items: center; sticky-top; z-index: 999; }
        
        /* CV Viewer Area */
        .cv-viewer-container { flex-grow: 1; display: flex; padding: 24px; gap: 24px; height: calc(100vh - 75px); overflow: hidden; }
        .cv-sidebar-info { width: 340px; background: #fff; border-radius: 15px; border: 1px solid #edf2f7; display: flex; flex-direction: column; flex-shrink: 0; box-shadow: 0 5px 20px rgba(0,0,0,0.02); }
        .info-header { padding: 30px; border-bottom: 1px solid #f1f5f9; text-align: center; }
        .info-body { padding: 30px; overflow-y: auto; flex-grow: 1; }
        .cv-display-area { flex-grow: 1; background: #fff; border-radius: 15px; border: 1px solid #edf2f7; box-shadow: 0 5px 20px rgba(0,0,0,0.02); overflow: hidden; }
        
        .candidate-avatar-lg { width: 90px; height: 90px; border-radius: 50%; object-fit: cover; margin-bottom: 15px; border: 4px solid #f8fbff; box-shadow: 0 4px 10px rgba(0,0,0,0.05); }
        .info-label { font-size: 0.7rem; color: #94a3b8; font-weight: 800; text-transform: uppercase; margin-bottom: 5px; letter-spacing: 0.5px; }
        .info-value { font-size: 0.95rem; font-weight: 600; margin-bottom: 20px; color: #1e293b; }
        iframe { width: 100%; height: 100%; border: none; }
    </style>
</head>
<body>

    <aside class="admin-sidebar shadow-sm">
        <div class="sidebar-brand">
            <a href="${pageContext.request.contextPath}/recruiter/dashboard" class="d-flex align-items-center">
                <i class="bi bi-rocket-takeoff-fill text-primary me-2 fs-3"></i>
                <span class="fw-bold fs-4 text-primary">ATS Recruiter</span>
            </a>
        </div>
        <ul class="sidebar-menu">
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/dashboard" class="sidebar-link"><i class="bi bi-grid-1x2-fill"></i> Tổng quan</a></li>
            
            <div class="sidebar-menu-title">Tuyển dụng</div>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/jobs/create" class="sidebar-link"><i class="bi bi-plus-circle"></i> Đăng tin mới</a></li>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/jobs" class="sidebar-link"><i class="bi bi-file-earmark-text"></i> Quản lý tin đăng</a></li>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/pipeline" class="sidebar-link active"><i class="bi bi-people"></i> Danh sách ứng viên</a></li>
            
            <div class="sidebar-menu-title">Tài khoản & Dịch vụ</div>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/vip/plans" class="sidebar-link"><i class="bi bi-gem"></i> Gói dịch vụ VIP</a></li>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/payment/history" class="sidebar-link"><i class="bi bi-credit-card"></i> Lịch sử thanh toán</a></li>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/account/profile" class="sidebar-link"><i class="bi bi-person-gear"></i> Hồ sơ công ty</a></li>
            
            <div class="sidebar-menu-title">Cá nhân</div>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/account/change-password" class="sidebar-link"><i class="bi bi-key"></i> Đổi mật khẩu</a></li>
        </ul>
        <div class="logout-area">
            <a href="${pageContext.request.contextPath}/auth/logout" class="sidebar-link text-danger bg-danger bg-opacity-10 py-2">
                <i class="bi bi-box-arrow-right me-2"></i> Đăng xuất
            </a>
        </div>
    </aside>

    <main class="admin-main">
        <header class="admin-header sticky-top shadow-sm">
            <div class="d-flex align-items-center">
                <a href="javascript:history.back()" class="btn btn-light border rounded-circle me-3"><i class="bi bi-arrow-left"></i></a>
                <h5 class="fw-bold mb-0 text-dark">Hồ sơ ứng viên: ${candidate.user.fullName}</h5>
            </div>
            
            <div class="dropdown">
                <button class="btn btn-link text-dark text-decoration-none dropdown-toggle d-flex align-items-center p-0 border-0 shadow-none" data-bs-toggle="dropdown">
                    <div class="bg-primary text-white rounded-circle me-2 d-flex align-items-center justify-content-center fw-bold" style="width: 40px; height: 40px;">
                        ${currentUser.fullName.substring(0,2).toUpperCase()}
                    </div>
                    <span class="fw-bold">${currentUser.fullName}</span>
                </button>
                <ul class="dropdown-menu dropdown-menu-end shadow border-0 mt-2">
                    <li><a class="dropdown-item py-2" href="${pageContext.request.contextPath}/recruiter/account/profile"><i class="bi bi-person me-2"></i> Hồ sơ</a></li>
                    <li><hr class="dropdown-divider"></li>
                    <li><a class="dropdown-item text-danger py-2" href="${pageContext.request.contextPath}/auth/logout"><i class="bi bi-box-arrow-right me-2"></i> Đăng xuất</a></li>
                </ul>
            </div>
        </header>

        <div class="cv-viewer-container">
            <div class="cv-sidebar-info">
                <div class="info-header">
                    <img src="https://ui-avatars.com/api/?name=${candidate.user.fullName}&background=007bff&color=fff&size=128" class="candidate-avatar-lg">
                    <h5 class="fw-bold mb-1 text-dark">${candidate.user.fullName}</h5>
                    <span class="badge bg-primary bg-opacity-10 text-primary px-3 py-2 rounded-pill small fw-bold">${application.status}</span>
                </div>
                
                <div class="info-body">
                    <div class="info-label">Vị trí ứng tuyển</div>
                    <div class="info-value text-primary">${application.job.title}</div>
                    
                    <div class="info-label">Email ứng viên</div>
                    <div class="info-value">${candidate.user.email}</div>

                    <div class="info-label">Số điện thoại</div>
                    <div class="info-value">${candidate.user.phone != null ? candidate.user.phone : 'Chưa cập nhật'}</div>

					<div class="d-grid mt-4 gap-2">
					    <%-- Nút Đánh giá cũ của Hà --%>
					    <a href="${pageContext.request.contextPath}/recruiter/candidates/detail?applicationId=${application.id}" 
					       class="btn btn-primary fw-bold rounded-pill shadow-sm py-2">
					        <i class="bi bi-check2-square me-1"></i> Đánh giá & Phỏng vấn
					    </a>
					
					    <%-- NÚT DOWNLOAD CV THÊM MỚI --%>
					    <c:if test="${not empty cvFile}">
					        <a href="${pageContext.request.contextPath}/uploads/cv/${cvFile}" 
					           download="${candidate.user.fullName}_CV.pdf"
					           class="btn btn-outline-success fw-bold rounded-pill shadow-sm py-2">
					            <i class="bi bi-download me-1"></i> Tải hồ sơ CV
					        </a>
					    </c:if>
					</div>
                </div>
            </div>

            <div class="cv-display-area">
			    <c:choose>
			        <%-- Kiểm tra nếu biến cvFile không rỗng --%>
			        <c:when test="${not empty cvFile}">
			            <%-- 
			                SỬA TẠI ĐÂY: 
			                Hà phải đảm bảo file PDF nằm trong thư mục webapp/uploads/cv/
			                Nếu Hà lưu CV ở folder khác, hãy đổi lại đường dẫn bên dưới.
			            --%>
			            <iframe 
			                src="${pageContext.request.contextPath}/uploads/cv/${cvFile}" 
			                type="application/pdf"
			                width="100%"
			                height="100%">
			            </iframe>
			        </c:when>
			        <c:otherwise>
			            <div class="h-100 d-flex flex-column align-items-center justify-content-center text-muted bg-light">
			                <i class="bi bi-file-earmark-x fs-1 opacity-25 mb-3"></i>
			                <p class="fw-bold">Ứng viên chưa tải lên file CV (PDF)</p>
			                <small>Hệ thống không tìm thấy dữ liệu file trong Database.</small>
			            </div>
			        </c:otherwise>
			    </c:choose>
			</div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>