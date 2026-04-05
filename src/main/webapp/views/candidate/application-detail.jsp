<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết ứng tuyển - ATS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #f0f2f5; color: #1c1e21; margin: 0; }
        
        /* Sidebar Navigation cố định */
        .sidebar { background: #fff; min-height: 100vh; position: fixed; top: 0; left: 0; width: 260px; border-right: 1px solid #e5e5e5; z-index: 1000; }
        .main-content { margin-left: 260px; padding: 20px; min-height: 100vh; }
        
        .nav-link { color: #606770; font-weight: 500; padding: 12px 20px; border-radius: 8px; margin: 4px 15px; transition: 0.2s; text-decoration: none; display: block; }
        .nav-link:hover { background-color: #f2f3f5; color: #007bff; }
        .nav-link.active { background-color: #e7f3ff; color: #007bff; }
        
        /* Top Nav & Cards */
        .top-nav { background: #fff; padding: 15px 30px; border-bottom: 1px solid #e5e5e5; margin-bottom: 25px; border-radius: 10px; }
        .avatar-small { width: 35px; height: 35px; border-radius: 50%; object-fit: cover; }
        
        /* Specific UI Elements */
        .detail-card { background: #fff; border-radius: 12px; padding: 25px; box-shadow: 0 1px 2px rgba(0,0,0,0.1); margin-bottom: 24px; border: none; }
        .ai-score-box { background: #1c1e21; color: #fff; border-radius: 12px; padding: 25px; text-align: center; }
        .itv-step { border-left: 3px solid #0d6efd; padding-left: 20px; position: relative; margin-bottom: 25px; }
        .itv-step::before { content: ''; position: absolute; left: -7px; top: 2px; width: 11px; height: 11px; background: #0d6efd; border-radius: 50%; border: 2px solid #fff; box-shadow: 0 0 0 3px #e7f3ff; }
        .itv-step:last-child { margin-bottom: 0; }
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
            <a class="nav-link" href="${pageContext.request.contextPath}/candidate/change-password">
                <i class="bi bi-shield-lock-fill me-2"></i> Đổi mật khẩu
            </a>
            <hr class="mx-3 my-3">
            <a class="nav-link text-danger" href="${pageContext.request.contextPath}/auth/logout">
                <i class="bi bi-box-arrow-right me-2"></i> Đăng xuất
            </a>
        </nav>
    </div>

    <div class="main-content">
        <%-- Top-nav đồng bộ --%>
        <div class="top-nav d-flex justify-content-between align-items-center shadow-sm">
            <div class="d-flex align-items-center">
                <a href="${pageContext.request.contextPath}/candidate/applied-jobs" class="btn btn-sm btn-light me-3"><i class="bi bi-arrow-left"></i> Quay lại</a>
                <h5 class="fw-bold mb-0">Chi tiết ứng tuyển #${application.id}</h5>
            </div>
            <div class="d-flex align-items-center">
                <span class="me-3 fw-medium">${sessionScope.currentUser.fullName}</span>
                <img src="${empty sessionScope.currentUser.avatar ? 'https://ui-avatars.com/api/?name='.concat(sessionScope.currentUser.fullName) : sessionScope.currentUser.avatar}" class="avatar-small">
            </div>
        </div>

        <div class="row g-4">
            <div class="col-lg-8">
                <div class="detail-card shadow-sm">
                    <div class="d-flex justify-content-between align-items-start mb-3">
                        <div>
                            <h4 class="fw-bold text-primary mb-1">
                                <a href="${pageContext.request.contextPath}/job-detail?id=${application.job.id}" class="text-primary text-decoration-none">${application.job.title}</a>
                            </h4>
                            <p class="text-muted"><i class="bi bi-building me-1"></i>${application.job.recruiter.fullName}</p>
                        </div>
                        
                        <%-- Format màu Status đồng bộ với Dashboard --%>
                        <c:choose>
                            <c:when test="${application.status == 'APPLIED'}"><span class="badge rounded-pill bg-primary-subtle text-primary px-3 py-2">Đã nộp</span></c:when>
                            <c:when test="${application.status == 'REVIEWING'}"><span class="badge rounded-pill bg-warning-subtle text-warning px-3 py-2">Đang xét duyệt</span></c:when>
                            <c:when test="${application.status == 'INTERVIEW'}"><span class="badge rounded-pill bg-info-subtle text-info px-3 py-2">Phỏng vấn</span></c:when>
                            <c:when test="${application.status == 'ACCEPTED'}"><span class="badge rounded-pill bg-success-subtle text-success px-3 py-2">Trúng tuyển</span></c:when>
                            <c:when test="${application.status == 'REJECTED'}"><span class="badge rounded-pill bg-danger-subtle text-danger px-3 py-2">Từ chối</span></c:when>
                            <c:when test="${application.status == 'WITHDRAWN'}"><span class="badge rounded-pill bg-secondary-subtle text-secondary px-3 py-2">Đã rút hồ sơ</span></c:when>
                            <c:otherwise><span class="badge rounded-pill bg-light text-dark px-3 py-2">${application.status}</span></c:otherwise>
                        </c:choose>
                    </div>
                    
                    <div class="d-flex gap-4 small text-muted mb-4 border-bottom pb-3">
                        <span><i class="bi bi-calendar-check me-1"></i> Ngày nộp: 
                            <fmt:parseDate value="${application.applyDate}" pattern="yyyy-MM-dd'T'HH:mm" var="appDate"/>
                            <fmt:formatDate value="${appDate}" pattern="dd/MM/yyyy HH:mm"/>
                        </span>
                        <span>
                            <i class="bi bi-file-earmark-pdf me-1"></i> CV đã dùng: 
                            <a href="${pageContext.request.contextPath}/${application.cvFile}" target="_blank" class="text-decoration-none fw-medium">Xem CV</a>
                        </span>
                    </div>

                    <h6 class="fw-bold mb-2">Thư giới thiệu / Ghi chú của bạn:</h6>
                    <div class="p-3 bg-light rounded small text-muted fst-italic border">${empty application.note ? 'Bạn không đính kèm thư giới thiệu nào.' : application.note}</div>
                </div>

                <div class="detail-card shadow-sm">
                    <h5 class="fw-bold mb-4">Lịch trình & Lịch sử phỏng vấn</h5>
                    <c:forEach var="itv" items="${interviews}">
                        <div class="itv-step">
                            <h6 class="fw-bold mb-1 text-primary">Vòng: ${itv.interviewType}</h6>
                            <p class="small mb-1 fw-medium text-dark"><i class="bi bi-calendar3 me-2 text-muted"></i>
                                <fmt:parseDate value="${itv.interviewDate}" pattern="yyyy-MM-dd'T'HH:mm" var="iDate"/>
                                <fmt:formatDate value="${iDate}" pattern="HH:mm - dd/MM/yyyy"/>
                            </p>
                            <p class="small text-muted mb-1"><i class="bi bi-geo-alt me-2"></i>Địa điểm/Link: ${itv.location}</p>
                            <p class="small text-muted mb-0"><i class="bi bi-person-badge me-2"></i>Người phỏng vấn: ${itv.interviewer}</p>
                        </div>
                    </c:forEach>
                    <c:if test="${empty interviews}">
                        <div class="text-center py-4">
                            <i class="bi bi-calendar-x fs-1 text-muted opacity-25"></i>
                            <p class="text-muted small mt-2 mb-0">Chưa có lịch phỏng vấn nào được sắp xếp.</p>
                        </div>
                    </c:if>
                </div>
            </div>

            <div class="col-lg-4">
                <div class="ai-score-box mb-4 shadow-sm">
                    <h6 class="text-info fw-bold mb-3 small text-uppercase"><i class="bi bi-robot me-2"></i>Phân tích AI</h6>
                    
                    <c:choose>
                        <c:when test="${not empty aiScore}">
                            <div class="display-4 fw-bold mb-1">${aiScore.totalScore}%</div>
                            <p class="small opacity-75 mb-4 border-bottom border-secondary pb-3">Độ tương thích với yêu cầu</p>
                            <div class="small text-start">
                                <div class="d-flex justify-content-between mb-1">
                                    <span>Kỹ năng (Skill)</span>
                                    <span class="fw-bold">${aiScore.skillScore}%</span>
                                </div>
                                <div class="progress mb-3 bg-dark" style="height: 6px;">
                                    <div class="progress-bar bg-info" style="width: ${aiScore.skillScore}%"></div>
                                </div>

                                <div class="d-flex justify-content-between mb-1">
                                    <span>Kinh nghiệm</span>
                                    <span class="fw-bold">${aiScore.experienceScore}%</span>
                                </div>
                                <div class="progress mb-3 bg-dark" style="height: 6px;">
                                    <div class="progress-bar bg-info" style="width: ${aiScore.experienceScore}%"></div>
                                </div>
                                
                                <div class="d-flex justify-content-between mb-1">
                                    <span>Học vấn/Ngôn ngữ</span>
                                    <span class="fw-bold">${aiScore.educationScore}%</span>
                                </div>
                                <div class="progress mb-3 bg-dark" style="height: 6px;">
                                    <div class="progress-bar bg-info" style="width: ${aiScore.educationScore}%"></div>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="py-4">
                                <div class="spinner-border text-info mb-3" role="status" style="width: 3rem; height: 3rem;"></div>
                                <p class="small opacity-75 mb-0">AI đang tiến hành phân tích hồ sơ của bạn.<br>Vui lòng quay lại sau ít phút.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <%-- Đã sửa name="id" thành name="applicationId" cho đúng với Servlet --%>
                <c:if test="${application.status != 'REJECTED' && application.status != 'WITHDRAWN' && application.status != 'ACCEPTED'}">
                    <form action="${pageContext.request.contextPath}/candidate/withdraw-application" method="POST" onsubmit="return confirm('Bạn chắc chắn muốn rút đơn ứng tuyển này? Hành động này không thể hoàn tác.')">
                        <input type="hidden" name="applicationId" value="${application.id}">
                        <button type="submit" class="btn btn-outline-danger w-100 py-2 rounded-pill fw-bold shadow-sm">
                            <i class="bi bi-x-circle me-1"></i> Rút đơn ứng tuyển
                        </button>
                    </form>
                </c:if>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>