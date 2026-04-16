<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt lịch phỏng vấn - ATS Recruiter</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    
    <style>
        :root { --primary-blue: #007bff; --bg-light: #f8fbff; --sidebar-width: 280px; }
        body { font-family: 'Inter', sans-serif; background-color: var(--bg-light); color: #1e293b; margin: 0; }
        
        /* Sidebar Styling - Đồng bộ Dashboard */
        .admin-sidebar { width: var(--sidebar-width); height: 100vh; position: fixed; top: 0; left: 0; background: #fff; border-right: 1px solid #eee; overflow-y: auto; z-index: 1000; display: flex; flex-direction: column; }
        .sidebar-brand { padding: 20px; border-bottom: 1px solid #eee; }
        .sidebar-brand a { text-decoration: none !important; }
        .sidebar-menu { padding: 15px 10px; list-style: none; margin: 0; flex-grow: 1; }
        .sidebar-link { display: flex; align-items: center; padding: 12px 15px; color: #555; text-decoration: none; font-weight: 500; border-radius: 10px; transition: 0.3s; margin-bottom: 5px; }
        .sidebar-link:hover, .sidebar-link.active { background-color: rgba(0, 123, 255, 0.08); color: var(--primary-blue); font-weight: 700; }
        .sidebar-link i { margin-right: 12px; font-size: 1.2rem; }
        .sidebar-menu-title { font-size: 0.75rem; text-transform: uppercase; font-weight: 700; color: #999; margin: 20px 0 10px 15px; letter-spacing: 0.5px; }

        /* Logout Area */
        .logout-area { padding: 20px; border-top: 1px solid #eee; }
        .btn-logout { display: flex !important; align-items: center; padding: 12px 15px; border-radius: 10px; color: #dc3545 !important; background-color: rgba(220, 53, 69, 0.1); text-decoration: none !important; font-weight: 700; transition: 0.3s; border: none; width: 100%; }
        .btn-logout:hover { background-color: #dc3545; color: #fff !important; }

        /* Main Content */
        .admin-main { margin-left: var(--sidebar-width); min-height: 100vh; }
        .admin-header { background: #fff; padding: 15px 30px; border-bottom: 1px solid #eee; }
        
        /* Schedule Card Styling */
        .schedule-card { border-radius: 16px; border: 1px solid #e2e8f0; background: #fff; box-shadow: 0 10px 25px rgba(0,0,0,0.02); }
        .form-label { font-weight: 700; font-size: 0.75rem; color: #64748b; text-transform: uppercase; margin-bottom: 8px; letter-spacing: 0.5px; }
        .form-control, .form-select { border-radius: 10px; padding: 12px 15px; border: 1px solid #e2e8f0; font-size: 0.95rem; }
        .form-control:focus { border-color: var(--primary-blue); box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.1); }
        
        .candidate-mini-card { background: #f1f5f9; border-radius: 12px; padding: 20px; margin-bottom: 30px; border-left: 5px solid var(--primary-blue); }
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
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/dashboard" class="sidebar-link"><i class="bi bi-grid-1x2-fill"></i> Tổng quan</a></li>
            <div class="sidebar-menu-title">Tuyển dụng</div>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/jobs/create" class="sidebar-link"><i class="bi bi-plus-circle"></i> Đăng tin mới</a></li>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/jobs" class="sidebar-link"><i class="bi bi-file-earmark-text"></i> Quản lý tin đăng</a></li>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/pipeline" class="sidebar-link active"><i class="bi bi-people"></i> Danh sách ứng viên</a></li>
            <div class="sidebar-menu-title">Tài khoản</div>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/account/profile" class="sidebar-link"><i class="bi bi-person-gear"></i> Hồ sơ công ty</a></li>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/account/change-password" class="sidebar-link"><i class="bi bi-key"></i> Đổi mật khẩu</a></li>
        </ul>
        <%-- 2. Đồng bộ nút Đăng xuất Sidebar --%>
        <div class="logout-area">
            <a href="${pageContext.request.contextPath}/auth/logout" class="btn-logout">
                <i class="bi bi-box-arrow-right me-2"></i> Đăng xuất
            </a>
        </div>
    </aside>

    <main class="admin-main">
        <header class="admin-header sticky-top d-flex justify-content-between align-items-center">
            <div class="d-flex align-items-center">
                <a href="javascript:history.back()" class="btn btn-light rounded-circle me-3 border shadow-sm"><i class="bi bi-arrow-left"></i></a>
                <h5 class="fw-bold mb-0 text-dark">Thiết lập lịch phỏng vấn</h5>
            </div>
            <div class="d-flex align-items-center gap-2">
                <span class="fw-bold small text-muted">${currentUser.fullName}</span>
                <img src="https://ui-avatars.com/api/?name=${currentUser.fullName}&background=007bff&color=fff" class="rounded-circle border" width="35">
            </div>
        </header>

        <div class="container py-5">
            <div class="row justify-content-center">
                <div class="col-lg-9 col-xl-8">
                    
                    <div class="schedule-card p-4 p-md-5">
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger border-0 rounded-3 small fw-bold mb-4 shadow-sm">
                                <i class="bi bi-exclamation-circle me-2"></i> ${error}
                            </div>
                        </c:if>

                        <div class="candidate-mini-card shadow-sm">
                            <div class="row align-items-center">
                                <div class="col-auto">
                                    <img src="https://ui-avatars.com/api/?name=${application.candidate.user.fullName}&background=007bff&color=fff" class="rounded-circle border border-white border-2" width="60">
                                </div>
                                <div class="col">
                                    <div class="text-uppercase small fw-bold text-muted mb-1" style="font-size: 0.65rem; letter-spacing: 1px;">Ứng viên đang xử lý</div>
                                    <div class="fw-bold text-dark fs-5">${application.candidate.user.fullName}</div>
                                    <div class="text-muted small">Vị trí: <span class="fw-bold text-primary">${application.job.title}</span></div>
                                </div>
                                <div class="col-auto text-end border-start ps-4">
                                    <div class="text-uppercase small fw-bold text-muted mb-1" style="font-size: 0.65rem; letter-spacing: 1px;">Trạng thái</div>
                                    <span class="badge bg-warning text-dark rounded-pill px-3">${application.status}</span>
                                </div>
                            </div>
                        </div>

                        <form action="${pageContext.request.contextPath}/recruiter/interviews/save" method="post">
                            <input type="hidden" name="applicationId" value="${application.id}">
                            <input type="hidden" name="interviewId" value="${latestInterview.id}">

                            <div class="row g-4">
                                <div class="col-md-6">
                                    <label class="form-label">Ngày & Giờ phỏng vấn</label>
                                    <input type="datetime-local" name="interviewDate" class="form-control" 
                                           value="${latestInterview.interviewDate}" required>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label">Hình thức phỏng vấn</label>
                                    <select name="interviewType" class="form-select" required>
                                        <option value="Online" ${latestInterview.interviewType == 'Online' ? 'selected' : ''}>Trực tuyến (Meet/Zoom/Teams)</option>
                                        <option value="Offline" ${latestInterview.interviewType == 'Offline' ? 'selected' : ''}>Trực tiếp (Tại văn phòng)</option>
                                        <option value="Phone" ${latestInterview.interviewType == 'Phone' ? 'selected' : ''}>Phỏng vấn qua điện thoại</option>
                                    </select>
                                </div>

                                <div class="col-md-12">
                                    <label class="form-label">Người phỏng vấn / Hội đồng chuyên môn</label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light border-end-0"><i class="bi bi-person-check text-muted"></i></span>
                                        <input type="text" name="interviewer" class="form-control border-start-0" 
                                               placeholder="Ví dụ: Mr. Nguyễn Văn A - Tech Lead" 
                                               value="${not empty latestInterview.interviewer ? latestInterview.interviewer : currentUser.fullName}" required>
                                    </div>
                                </div>

                                <div class="col-12">
                                    <label class="form-label">Địa điểm hoặc Link họp trực tuyến</label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light border-end-0"><i class="bi bi-geo-alt text-muted"></i></span>
                                        <input type="text" name="location" class="form-control border-start-0" 
                                               placeholder="Nhập địa chỉ văn phòng hoặc dán link Google Meet" 
                                               value="${latestInterview.location}">
                                    </div>
                                </div>

                                <div class="col-12">
                                    <label class="form-label">Lời nhắn gửi ứng viên (Ghi chú)</label>
                                    <textarea name="note" class="form-control" rows="4" 
                                              placeholder="Nhắc nhở ứng viên mang theo laptop hoặc trang phục phù hợp...">${latestInterview.note}</textarea>
                                </div>

                                <div class="col-12 mt-5">
                                    <div class="row g-3">
                                        <div class="col-md-8">
                                            <button type="submit" class="btn btn-primary fw-bold px-5 py-3 rounded-pill w-100 shadow-sm border-0">
                                                <i class="bi bi-send-check me-2"></i> XÁC NHẬN & GỬI THÔNG BÁO
                                            </button>
                                        </div>
                                        <div class="col-md-4">
                                            <a href="${pageContext.request.contextPath}/recruiter/candidates/detail?id=${application.id}" 
                                               class="btn btn-white bg-white fw-bold py-3 rounded-pill w-100 border shadow-sm">HỦY BỎ</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                    
                    <div class="text-center mt-4">
                        <p class="small text-muted italic">
                            <i class="bi bi-info-circle me-1"></i> 
                            Khi lưu, hệ thống sẽ tự động cập nhật trạng thái hồ sơ sang <strong>INTERVIEWING</strong>.
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>