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
        body { font-family: 'Inter', sans-serif; background-color: var(--bg-light); color: #1e293b; margin: 0; overflow: hidden; }
        .admin-sidebar { width: var(--sidebar-width); height: 100vh; position: fixed; top: 0; left: 0; background: #fff; border-right: 1px solid #e2e8f0; z-index: 1000; overflow-y: auto; display: flex; flex-direction: column; }
        .sidebar-brand { padding: 1.5rem; border-bottom: 1px solid #f1f5f9; }
        .sidebar-menu { flex-grow: 1; padding-bottom: 2rem; }
        .sidebar-link { display: flex; align-items: center; padding: 0.8rem 1.5rem; color: var(--text-muted); text-decoration: none; font-weight: 500; border-radius: 8px; margin: 0.2rem 1rem; transition: 0.2s; }
        .sidebar-link:hover, .sidebar-link.active { background-color: rgba(0, 123, 255, 0.08); color: var(--primary-blue); font-weight: 700; }
        .sidebar-link i { margin-right: 12px; font-size: 1.2rem; }
        .menu-header { font-size: 0.7rem; color: #94a3b8; font-weight: 800; text-transform: uppercase; padding: 1.5rem 1.5rem 0.5rem; letter-spacing: 0.05rem; }
        .logout-area { padding: 1.5rem; border-top: 1px solid #f1f5f9; }
        .btn-logout { display: flex !important; align-items: center; padding: 12px 15px; border-radius: 10px; color: #dc3545 !important; background-color: rgba(220, 53, 69, 0.1); text-decoration: none !important; font-weight: 700; transition: 0.3s; border: none; width: 100%; }
        .admin-main { margin-left: var(--sidebar-width); height: 100vh; display: flex; flex-direction: column; }
        .admin-header { background: #fff; padding: 1rem 2rem; border-bottom: 1px solid #e2e8f0; flex-shrink: 0; }
        .cv-viewer-container { flex-grow: 1; display: flex; overflow: hidden; padding: 20px; gap: 20px; }
        .cv-sidebar-info { width: 320px; background: #fff; border-radius: 15px; border: 1px solid #e2e8f0; display: flex; flex-direction: column; flex-shrink: 0; box-shadow: 0 4px 12px rgba(0,0,0,0.03); }
        .info-header { padding: 24px; border-bottom: 1px solid #f1f5f9; text-align: center; }
        .info-body { padding: 24px; overflow-y: auto; flex-grow: 1; }
        .cv-display-area { flex-grow: 1; background: #fff; border-radius: 15px; border: 1px solid #e2e8f0; box-shadow: 0 4px 12px rgba(0,0,0,0.03); overflow: hidden; position: relative; }
        .candidate-avatar-lg { width: 80px; height: 80px; border-radius: 50%; object-fit: cover; margin-bottom: 15px; border: 3px solid #f8fafc; }
        .info-label { font-size: 0.7rem; color: var(--text-muted); font-weight: 800; text-transform: uppercase; margin-bottom: 5px; }
        .info-value { font-size: 0.9rem; font-weight: 600; margin-bottom: 20px; color: #1e293b; }
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
        <div class="sidebar-menu">
            <a href="${pageContext.request.contextPath}/recruiter/dashboard" class="sidebar-link"><i class="bi bi-grid-1x2-fill"></i> Tổng quan</a>
            <div class="menu-header">Tuyển dụng</div>
            <a href="${pageContext.request.contextPath}/recruiter/jobs/create" class="sidebar-link"><i class="bi bi-plus-circle"></i> Đăng tin mới</a>
            <a href="${pageContext.request.contextPath}/recruiter/jobs" class="sidebar-link"><i class="bi bi-file-earmark-text"></i> Quản lý tin đăng</a>
            <a href="${pageContext.request.contextPath}/recruiter/pipeline" class="sidebar-link active"><i class="bi bi-people"></i> Danh sách ứng viên</a>
        </div>
        <div class="logout-area">
            <a href="${pageContext.request.contextPath}/auth/logout" class="btn-logout"><i class="bi bi-box-arrow-right me-2"></i> Đăng xuất</a>
        </div>
    </aside>

    <main class="admin-main">
        <header class="admin-header d-flex justify-content-between align-items-center shadow-sm">
            <div class="d-flex align-items-center">
                <a href="javascript:history.back()" class="btn btn-light border rounded-circle me-3"><i class="bi bi-arrow-left"></i></a>
                <h5 class="fw-bold mb-0 text-dark">Hồ sơ CV: ${candidate.user.fullName}</h5>
            </div>
        </header>

        <div class="cv-viewer-container">
            <div class="cv-sidebar-info shadow-sm">
                <div class="info-header">
                    <img src="https://ui-avatars.com/api/?name=${candidate.user.fullName}&background=007bff&color=fff&size=128" class="candidate-avatar-lg">
                    <h5 class="fw-bold mb-1 text-dark">${candidate.user.fullName}</h5>
                    <span class="badge bg-primary bg-opacity-10 text-primary px-3 py-2 rounded-pill">${application.status}</span>
                </div>
                
                <div class="info-body">
                    <div class="info-label">Ứng tuyển vị trí</div>
                    <div class="info-value text-primary">${application.job.title}</div>
                    
                    <div class="info-label">Email liên hệ</div>
                    <div class="info-value">${candidate.user.email}</div>

                    <div class="d-grid mt-4">
                        <%-- QUAN TRỌNG: Đổi id thành applicationId để Servlet nhận diện được --%>
                        <a href="${pageContext.request.contextPath}/recruiter/candidates/detail?applicationId=${application.id}" 
						   class="btn btn-primary fw-bold rounded-pill shadow-sm py-2">
						    <i class="bi bi-check2-square me-1"></i> Đánh giá hồ sơ
						</a>
                    </div>
                </div>
            </div>

            <div class="cv-display-area shadow-sm">
                <c:choose>
                    <c:when test="${not empty cvFile}">
                        <iframe src="${pageContext.request.contextPath}/uploads/cv/${cvFile}#toolbar=0" type="application/pdf"></iframe>
                    </c:when>
                    <c:otherwise>
                        <div class="h-100 d-flex flex-column align-items-center justify-content-center text-muted">
                            <i class="bi bi-file-earmark-x fs-1 opacity-25"></i>
                            <p>Không tìm thấy file CV</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </main>
</body>
</html>