<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết ứng viên - ATS Recruiter</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">

    <style>
        :root { --primary-blue: #007bff; --bg-light: #f8fbff; --sidebar-width: 280px; }
        body { font-family: 'Inter', sans-serif; background-color: var(--bg-light); color: #1e293b; margin: 0; }
        
        /* Sidebar Design - Đồng bộ Dashboard */
        .admin-sidebar { width: var(--sidebar-width); height: 100vh; position: fixed; top: 0; left: 0; background: #fff; border-right: 1px solid #eee; overflow-y: auto; z-index: 1000; display: flex; flex-direction: column; }
        .sidebar-brand { padding: 20px; border-bottom: 1px solid #eee; }
        .sidebar-brand a { text-decoration: none !important; }
        .sidebar-menu { padding: 15px 10px; list-style: none; margin: 0; flex-grow: 1; }
        .sidebar-menu-title { font-size: 0.75rem; text-transform: uppercase; font-weight: 700; color: #999; margin: 20px 0 10px 15px; letter-spacing: 0.5px; }
        .sidebar-link { display: flex; align-items: center; padding: 12px 15px; color: #555; text-decoration: none; font-weight: 500; border-radius: 10px; transition: 0.3s; margin-bottom: 5px; }
        .sidebar-link:hover, .sidebar-link.active { background-color: rgba(0, 123, 255, 0.08); color: var(--primary-blue); font-weight: 700; }
        .sidebar-link i { margin-right: 12px; font-size: 1.2rem; }
        
        /* Logout Area */
        .logout-area { padding: 20px; border-top: 1px solid #eee; margin-top: auto; }
        .btn-logout { display: flex !important; align-items: center; padding: 12px 15px; border-radius: 10px; color: #dc3545 !important; background-color: rgba(220, 53, 69, 0.1); text-decoration: none !important; font-weight: 700; transition: 0.3s; border: none; width: 100%; }

        /* Main Content */
        .admin-main { margin-left: var(--sidebar-width); min-height: 100vh; }
        .admin-header { background: #fff; padding: 15px 30px; border-bottom: 1px solid #e2e8f0; display: flex; justify-content: space-between; align-items: center; }
        
        .admin-card { background: #fff; border: 1px solid #e2e8f0; border-radius: 16px; padding: 1.5rem; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.02); margin-bottom: 1.5rem; }
        .ai-score-badge { width: 70px; height: 70px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: 800; font-size: 1.5rem; border: 5px solid #007bff; color: #007bff; }
        .status-pill { padding: 5px 14px; border-radius: 50px; font-weight: 700; font-size: 0.75rem; text-transform: uppercase; letter-spacing: 0.5px; }
        .info-label { font-size: 0.7rem; color: #94a3b8; font-weight: 800; text-transform: uppercase; margin-bottom: 8px; letter-spacing: 0.05em; }
        .highlight-box { background-color: #f8fafc; border-left: 4px solid var(--primary-blue); padding: 1rem; border-radius: 0 8px 8px 0; min-height: 50px; }
    </style>
</head>
<body>

    <aside class="admin-sidebar shadow-sm">
        <div class="sidebar-brand">
            <a href="${pageContext.request.contextPath}/recruiter/dashboard" class="d-flex align-items-center text-decoration-none">
                <i class="bi bi-rocket-takeoff-fill text-primary me-2 fs-3"></i>
                <span class="fw-bold fs-4 text-primary">ATS Recruiter</span>
            </a>
        </div>
        <ul class="sidebar-menu">
            <li><a href="${pageContext.request.contextPath}/recruiter/dashboard" class="sidebar-link"><i class="bi bi-grid-1x2-fill"></i> Tổng quan</a></li>
            
            <div class="sidebar-menu-title">Tuyển dụng</div>
            <li><a href="${pageContext.request.contextPath}/recruiter/jobs/create" class="sidebar-link"><i class="bi bi-plus-circle"></i> Đăng tin mới</a></li>
            <li><a href="${pageContext.request.contextPath}/recruiter/jobs" class="sidebar-link"><i class="bi bi-file-earmark-text"></i> Quản lý tin đăng</a></li>
            <li><a href="${pageContext.request.contextPath}/recruiter/pipeline" class="sidebar-link active"><i class="bi bi-people"></i> Danh sách ứng viên</a></li>
            
            <div class="sidebar-menu-title">Tài khoản & Dịch vụ</div>
            <li><a href="${pageContext.request.contextPath}/recruiter/vip/plans" class="sidebar-link"><i class="bi bi-gem"></i> Gói dịch vụ VIP</a></li>
            <li><a href="${pageContext.request.contextPath}/recruiter/payment/history" class="sidebar-link"><i class="bi bi-credit-card"></i> Lịch sử thanh toán</a></li>
            <li><a href="${pageContext.request.contextPath}/recruiter/account/profile" class="sidebar-link"><i class="bi bi-person-gear"></i> Hồ sơ công ty</a></li>
        </ul>
        <div class="logout-area">
            <a href="${pageContext.request.contextPath}/auth/logout" class="btn-logout">
                <i class="bi bi-box-arrow-right me-2"></i> Đăng xuất
            </a>
        </div>
    </aside>

    <main class="admin-main">
        <header class="admin-header sticky-top shadow-sm">
            <div class="d-flex align-items-center">
                <a href="${pageContext.request.contextPath}/recruiter/pipeline" class="btn btn-light rounded-circle me-3 border shadow-sm"><i class="bi bi-arrow-left"></i></a>
                <h5 class="fw-bold mb-0">Hồ sơ ứng viên</h5>
            </div>
            <div class="d-flex align-items-center">
                <span class="me-2 fw-bold small text-muted">${currentUser.fullName}</span>
                <div class="bg-primary text-white rounded-circle d-flex align-items-center justify-content-center fw-bold" style="width:35px; height:35px;">
                    ${currentUser.fullName.substring(0,2).toUpperCase()}
                </div>
            </div>
        </header>

        <div class="container-fluid p-4">
            <div class="admin-card">
                <div class="row align-items-center">
                    <div class="col-md-auto">
                        <div class="bg-primary text-white rounded-3 d-flex align-items-center justify-content-center fw-bold fs-2 shadow-sm" style="width: 85px; height: 85px;">
                            ${candidate.user.fullName.substring(0,1).toUpperCase()}
                        </div>
                    </div>
                    <div class="col-md ps-md-4 border-end">
                        <div class="d-flex align-items-center gap-3 mb-2">
                            <h3 class="fw-bold mb-0">${candidate.user.fullName}</h3>
                            <span class="status-pill bg-primary bg-opacity-10 text-primary">${application.status}</span>
                        </div>
                        <p class="text-muted mb-1"><i class="bi bi-envelope me-2"></i>${candidate.user.email}</p>
                        <p class="text-muted mb-0"><i class="bi bi-briefcase me-2"></i>Ứng tuyển: <span class="fw-bold text-dark">${job.title}</span></p>
                    </div>
                    <div class="col-md-3 text-center ps-md-4">
                        <div class="info-label">AI Matching Score</div>
                        <div class="d-flex justify-content-center">
                            <div class="ai-score-badge">
                                <c:out value="${aiScore.aiScore}" default="--" />
                            </div>
                        </div>
                        <a href="${pageContext.request.contextPath}/recruiter/ai/analyze?applicationId=${application.id}" class="text-primary small fw-bold text-decoration-none mt-2 d-block">
                            <i class="bi bi-cpu me-1"></i>Xem phân tích chi tiết
                        </a>
                    </div>
                </div>
            </div>

            <div class="row g-4">
                <div class="col-lg-8">
                    <div class="admin-card">
                        <h6 class="fw-bold mb-4 text-dark text-uppercase small"><i class="bi bi-calendar-check me-2 text-primary"></i>Phỏng vấn gần nhất</h6>
                        <c:choose>
                            <c:when test="${not empty latestInterview}">
                                <div class="row g-4">
                                    <div class="col-md-6">
                                        <div class="info-label">THỜI GIAN</div>
                                        <div class="fw-bold fs-5 text-dark">
                                            <fmt:parseDate value="${latestInterview.interviewDate}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both" />
                                            <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy HH:mm" />
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="info-label">HÌNH THỨC</div>
                                        <div class="fw-bold text-primary text-uppercase">${latestInterview.interviewType}</div>
                                    </div>
                                    <div class="col-12">
                                        <div class="info-label">ĐỊA ĐIỂM / LINK</div>
                                        <div class="highlight-box fw-medium text-dark">${latestInterview.location}</div>
                                    </div>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <p class="text-muted small text-center py-3">Chưa có lịch phỏng vấn được thiết lập.</p>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="admin-card">
                        <h6 class="fw-bold mb-4 text-dark text-uppercase small"><i class="bi bi-clipboard-data me-2 text-primary"></i>Đánh giá năng lực</h6>
                        <c:choose>
                            <c:when test="${not empty scorecard}">
                                <div class="p-3 bg-light rounded-3">
                                    <p class="mb-0 text-dark fw-bold"><i class="bi bi-check-circle-fill text-success me-2"></i>Đã có dữ liệu đánh giá.</p>
                                    <p class="small text-muted mt-2 mb-0">Hồ sơ này đã được nhà tuyển dụng chấm điểm chuyên môn và văn hóa.</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center py-4 border border-dashed rounded-3">
                                    <p class="text-muted small mb-3">Chưa có bảng đánh giá chi tiết cho ứng viên này.</p>
                                    <a href="${pageContext.request.contextPath}/recruiter/evaluation/scorecard?applicationId=${application.id}" class="btn btn-sm btn-primary rounded-pill px-4 fw-bold">Chấm điểm ngay</a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <div class="col-lg-4">
                    <div class="admin-card border-primary border-opacity-10 shadow-sm">
                        <h6 class="fw-bold mb-4 text-dark text-uppercase small">Thao tác hồ sơ</h6>
                        
                        <form action="${pageContext.request.contextPath}/recruiter/pipeline/update-status" method="POST">
                            <input type="hidden" name="applicationId" value="${application.id}">
                            <div class="d-grid gap-3">
                                <button type="submit" name="status" value="Accepted" class="btn btn-success fw-bold py-2 shadow-sm border-0" onclick="return confirm('Xác nhận CHẤP NHẬN ứng viên?')">
                                    <i class="bi bi-check-lg me-2"></i> Chấp nhận
                                </button>
                                <button type="submit" name="status" value="Rejected" class="btn btn-danger fw-bold py-2 shadow-sm border-0" onclick="return confirm('Xác nhận TỪ CHỐI hồ sơ?')">
                                    <i class="bi bi-x-lg me-2"></i> Từ chối
                                </button>
                                <a href="${pageContext.request.contextPath}/recruiter/interviews/schedule?applicationId=${application.id}" class="btn btn-outline-primary fw-bold py-2 border-2">
                                    <i class="bi bi-calendar-event me-2"></i> Đặt lịch phỏng vấn
                                </a>
                                <hr class="my-2">
                                <a href="${pageContext.request.contextPath}/recruiter/candidates/view-cv?applicationId=${application.id}" class="btn btn-light border fw-bold text-dark">
                                    <i class="bi bi-file-earmark-pdf me-2 text-danger"></i> Xem CV Gốc
                                </a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>