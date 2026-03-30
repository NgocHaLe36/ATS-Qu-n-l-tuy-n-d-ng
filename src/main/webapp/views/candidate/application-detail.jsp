<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết ứng tuyển - ATS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #f0f2f5; margin: 0; }
        /* Sidebar Menu Cố Định */
        .sidebar { background: #fff; min-height: 100vh; position: fixed; top: 0; left: 0; width: 260px; border-right: 1px solid #e5e5e5; z-index: 1000; }
        .main-content { margin-left: 260px; padding: 25px; min-height: 100vh; }
        .nav-link { color: #606770; font-weight: 500; padding: 12px 20px; border-radius: 8px; margin: 4px 15px; display: block; text-decoration: none; }
        .nav-link.active { background-color: #e7f3ff; color: #007bff; }
        .nav-link:hover { background-color: #f2f3f5; color: #007bff; }
        
        /* Card & UI Elements */
        .detail-card { background: #fff; border-radius: 12px; padding: 25px; box-shadow: 0 1px 2px rgba(0,0,0,0.1); margin-bottom: 20px; border: none; }
        .ai-score-box { background: #1a1a1a; color: #fff; border-radius: 15px; padding: 20px; text-align: center; }
        .top-nav { background: #fff; padding: 15px 30px; border-bottom: 1px solid #e5e5e5; border-radius: 10px; margin-bottom: 25px; }
        .itv-step { border-left: 3px solid #007bff; padding-left: 20px; position: relative; margin-bottom: 20px; }
        .itv-step::before { content: ''; position: absolute; left: -10px; top: 0; width: 17px; height: 17px; background: #007bff; border-radius: 50%; }
    </style>
</head>
<body>

    <div class="sidebar py-3 shadow-sm">
        <div class="px-4 mb-4 d-flex align-items-center">
            <i class="bi bi-building-fill text-primary fs-3 me-2"></i>
            <span class="fw-bold fs-4 text-primary">ATS System</span>
        </div>
        <nav class="nav flex-column">
            <a class="nav-link" href="${pageContext.request.contextPath}/home">
                <i class="bi bi-house-door-fill me-2"></i> Trang chủ
            </a>
            <a class="nav-link" href="${pageContext.request.contextPath}/candidate/dashboard">
                <i class="bi bi-grid-fill me-2"></i> Dashboard
            </a>
            <a class="nav-link active" href="${pageContext.request.contextPath}/candidate/applied-jobs">
                <i class="bi bi-briefcase-fill me-2"></i> Việc làm đã ứng tuyển
            </a>
            <a class="nav-link" href="${pageContext.request.contextPath}/candidate/profile">
                <i class="bi bi-person-fill me-2"></i> Hồ sơ cá nhân
            </a>
            <hr class="mx-3">
            <a class="nav-link text-danger" href="${pageContext.request.contextPath}/auth/logout">
                <i class="bi bi-box-arrow-right me-2"></i> Đăng xuất
            </a>
        </nav>
    </div>

    <div class="main-content">
        <div class="top-nav d-flex justify-content-between align-items-center shadow-sm">
            <h5 class="fw-bold mb-0">Chi tiết ứng tuyển #${application.id}</h5>
            <div class="d-flex align-items-center">
                <span class="fw-medium me-2">${sessionScope.currentUser.fullName}</span>
                <img src="${sessionScope.currentUser.avatar}" class="rounded-circle" width="35" height="35">
            </div>
        </div>

        <div class="row g-4">
            <div class="col-lg-8">
                <div class="detail-card">
                    <div class="d-flex justify-content-between align-items-start mb-3">
                        <div>
                            <h4 class="fw-bold text-primary mb-1">${application.job.title}</h4>
                            <p class="text-muted"><i class="bi bi-building me-1"></i>${application.job.recruiter.fullName}</p>
                        </div>
                        <span class="badge bg-primary px-3 py-2 rounded-pill">${application.status}</span>
                    </div>
                    <hr>
                    <h6 class="fw-bold mb-2">Ghi chú của bạn:</h6>
                    <div class="p-3 bg-light rounded small text-muted">${empty application.note ? 'Không có ghi chú.' : application.note}</div>
                </div>

                <div class="detail-card">
                    <h5 class="fw-bold mb-4">Lịch trình phỏng vấn</h5>
                    <c:forEach var="itv" items="${interviews}">
                        <div class="itv-step">
                            <h6 class="fw-bold mb-1 text-primary">${itv.title}</h6>
                            <p class="small mb-1 fw-medium"><i class="bi bi-calendar3 me-2"></i>${itv.interviewDate}</p>
                            <p class="small text-muted mb-0"><i class="bi bi-geo-alt me-1"></i>${itv.location}</p>
                        </div>
                    </c:forEach>
                    <c:if test="${empty interviews}">
                        <p class="text-muted small text-center py-4">Hiện chưa có lịch phỏng vấn mới.</p>
                    </c:if>
                </div>
            </div>

            <div class="col-lg-4">
                <div class="ai-score-box mb-4 shadow-sm">
                    <h6 class="text-info fw-bold mb-3 small text-uppercase">Phân tích hồ sơ AI</h6>
                    <div class="display-4 fw-bold mb-1">${aiScore.aiScore}%</div>
                    <p class="small opacity-75 mb-4">Độ tương thích với yêu cầu</p>
                    <div class="small text-start">
                        <div class="d-flex justify-content-between mb-1">
                            <span>Kỹ năng</span>
                            <span>${aiScore.skillScore}%</span>
                        </div>
                        <div class="progress mb-3" style="height: 5px;">
                            <div class="progress-bar bg-info" style="width: ${aiScore.skillScore}%"></div>
                        </div>

                        <div class="d-flex justify-content-between mb-1">
                            <span>Kinh nghiệm</span>
                            <span>${aiScore.experienceScore}%</span>
                        </div>
                        <div class="progress mb-3" style="height: 5px;">
                            <div class="progress-bar bg-info" style="width: ${aiScore.experienceScore}%"></div>
                        </div>
                    </div>
                </div>

                <c:if test="${application.status != 'REJECTED' && application.status != 'WITHDRAWN'}">
                    <form action="${pageContext.request.contextPath}/candidate/withdraw-application" method="POST" onsubmit="return confirm('Bạn chắc chắn muốn rút đơn ứng tuyển này?')">
                        <input type="hidden" name="id" value="${application.id}">
                        <button type="submit" class="btn btn-outline-danger w-100 py-2 rounded-pill fw-bold">Rút đơn ứng tuyển</button>
                    </form>
                </c:if>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>