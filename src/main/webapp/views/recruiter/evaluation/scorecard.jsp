<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đánh giá ứng viên: ${application.candidate.user.fullName}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    
    <style>
        :root { --primary-blue: #007bff; --bg-light: #f8fbff; --sidebar-width: 280px; }
        body { font-family: 'Inter', sans-serif; background-color: var(--bg-light); color: #333; margin: 0; }
        
        /* Sidebar Styling - Đồng bộ Dashboard */
        .admin-sidebar { width: var(--sidebar-width); height: 100vh; position: fixed; top: 0; left: 0; background: #fff; border-right: 1px solid #eee; overflow-y: auto; z-index: 1000; display: flex; flex-direction: column; }
        .sidebar-brand { padding: 20px; border-bottom: 1px solid #eee; }
        .sidebar-brand a { text-decoration: none !important; }
        .sidebar-menu { padding: 15px 10px; list-style: none; margin: 0; flex-grow: 1; }
        .sidebar-link { display: flex; align-items: center; padding: 12px 15px; color: #555; text-decoration: none; font-weight: 500; border-radius: 10px; transition: 0.3s; margin-bottom: 5px; }
        .sidebar-link:hover, .sidebar-link.active { background-color: rgba(0, 123, 255, 0.08); color: var(--primary-blue); font-weight: 700; }
        .sidebar-link i { margin-right: 12px; font-size: 1.2rem; }
        .sidebar-menu-title { font-size: 0.75rem; text-transform: uppercase; font-weight: 700; color: #999; margin: 20px 0 10px 15px; letter-spacing: 0.5px; }

        .logout-area { padding: 20px; border-top: 1px solid #eee; }
        .btn-logout { display: flex !important; align-items: center; padding: 12px 15px; border-radius: 10px; color: #dc3545 !important; background-color: rgba(220, 53, 69, 0.1); text-decoration: none !important; font-weight: 700; transition: 0.3s; border: none; width: 100%; }

        /* Main Content */
        .admin-main { margin-left: var(--sidebar-width); min-height: 100vh; }
        .admin-header { background: #fff; padding: 15px 30px; border-bottom: 1px solid #eee; }
        
        /* Scorecard Custom Styling */
        .score-card { border-radius: 15px; border: none; box-shadow: 0 10px 30px rgba(0,0,0,0.05); background: #fff; }
        .score-header { background: linear-gradient(135deg, #0d6efd, #0043a8); color: white; border-radius: 15px 15px 0 0 !important; padding: 1.5rem; }
        .form-label { font-weight: 600; color: #495057; font-size: 0.9rem; }
        .score-value { font-size: 1.2rem; font-weight: 800; color: #0d6efd; min-width: 35px; display: inline-block; text-align: right; }
        .avg-box { background-color: #e7f1ff; border: 2px dashed #0d6efd; border-radius: 10px; padding: 1.5rem; text-align: center; }
        .avg-score { font-size: 2.8rem; font-weight: 900; color: #0d6efd; }
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
            <div class="sidebar-menu-title">Tài khoản</div>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/account/profile" class="sidebar-link"><i class="bi bi-person-gear"></i> Hồ sơ công ty</a></li>
        </ul>
        <div class="logout-area">
            <a href="${pageContext.request.contextPath}/auth/logout" class="btn-logout">
                <i class="bi bi-box-arrow-right me-2"></i> Đăng xuất
            </a>
        </div>
    </aside>

    <main class="admin-main">
        <header class="admin-header sticky-top d-flex justify-content-between align-items-center">
            <h5 class="fw-bold mb-0 text-dark">Chấm điểm ứng viên</h5>
            <div class="d-flex align-items-center gap-2">
                <span class="fw-bold small text-muted">${currentUser.fullName}</span>
                <img src="https://ui-avatars.com/api/?name=${currentUser.fullName}&background=007bff&color=fff" class="rounded-circle" width="35">
            </div>
        </header>

        <div class="container-fluid py-4">
            <div class="card score-card mx-auto" style="max-width: 1000px;">
                <div class="card-header score-header border-0">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h4 class="mb-1 text-white fw-bold">Bảng điểm đánh giá (Scorecard)</h4>
                            <p class="mb-0 opacity-75 small">Ứng viên: <strong>${application.candidate.user.fullName}</strong> | Vị trí: ${application.job.title}</p>
                        </div>
                        <i class="bi bi-clipboard-check fs-1 text-white-50"></i>
                    </div>
                </div>
                
                <div class="card-body p-4 p-lg-5">
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger border-0 shadow-sm rounded-4 mb-4">
                            <i class="bi bi-exclamation-triangle-fill me-2"></i> ${error}
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/recruiter/evaluation/save-scorecard" method="post" id="scorecardForm">
                        <input type="hidden" name="applicationId" value="${application.id}">
                        
                        <div class="row g-5">
                            <div class="col-md-7 border-end pe-md-5">
                                <h6 class="text-uppercase text-muted fw-bold mb-4 small letter-spacing-1">Tiêu chí đánh giá</h6>
                                
                                <div class="mb-5">
                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                        <label class="form-label mb-0"><i class="bi bi-cpu me-2 text-primary"></i>Kỹ năng chuyên môn</label>
                                        <span class="score-value" id="val-tech">${not empty scorecard ? scorecard.technicalScore : '0'}</span>
                                    </div>
                                    <input type="range" name="technicalScore" class="form-range score-input" min="0" max="10" step="1" 
                                           value="${not empty scorecard ? scorecard.technicalScore : '0'}" oninput="updateScore('tech', this.value)">
                                </div>

                                <div class="mb-5">
                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                        <label class="form-label mb-0"><i class="bi bi-chat-dots me-2 text-primary"></i>Khả năng giao tiếp</label>
                                        <span class="score-value" id="val-comm">${not empty scorecard ? scorecard.communicationScore : '0'}</span>
                                    </div>
                                    <input type="range" name="communicationScore" class="form-range score-input" min="0" max="10" step="1" 
                                           value="${not empty scorecard ? scorecard.communicationScore : '0'}" oninput="updateScore('comm', this.value)">
                                </div>

                                <div class="mb-5">
                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                        <label class="form-label mb-0"><i class="bi bi-person-badge me-2 text-primary"></i>Thái độ & Tác phong</label>
                                        <span class="score-value" id="val-att">${not empty scorecard ? scorecard.attitudeScore : '0'}</span>
                                    </div>
                                    <input type="range" name="attitudeScore" class="form-range score-input" min="0" max="10" step="1" 
                                           value="${not empty scorecard ? scorecard.attitudeScore : '0'}" oninput="updateScore('att', this.value)">
                                </div>

                                <div class="mb-5">
                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                        <label class="form-label mb-0"><i class="bi bi-translate me-2 text-primary"></i>Trình độ ngoại ngữ</label>
                                        <span class="score-value" id="val-lang">${not empty scorecard ? scorecard.languageScore : '0'}</span>
                                    </div>
                                    <input type="range" name="languageScore" class="form-range score-input" min="0" max="10" step="1" 
                                           value="${not empty scorecard ? scorecard.languageScore : '0'}" oninput="updateScore('lang', this.value)">
                                </div>
                            </div>

                            <div class="col-md-5 ps-md-5">
                                <h6 class="text-uppercase text-muted fw-bold mb-4 small letter-spacing-1">Tổng hợp kết quả</h6>
                                
                                <div class="avg-box mb-5 shadow-sm">
                                    <div class="small fw-bold text-uppercase text-muted mb-2">Điểm trung bình</div>
                                    <div class="avg-score" id="avg-display">
                                        <c:choose>
                                            <c:when test="${not empty scorecard}">
                                                <fmt:formatNumber value="${scorecard.averageScore}" minFractionDigits="2" maxFractionDigits="2"/>
                                            </c:when>
                                            <c:otherwise>0.00</c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>

                                <div class="mb-4">
                                    <label class="form-label text-dark">Kết luận phỏng vấn</label>
                                    <select name="result" class="form-select fw-bold py-2 border-2">
                                        <option value="" ${empty scorecard.result ? 'selected' : ''}>-- Tự động đánh giá --</option>
                                        <option value="PASS" ${scorecard.result == 'PASS' ? 'selected' : ''} class="text-success">VƯỢT QUA (PASS)</option>
                                        <option value="FAIL" ${scorecard.result == 'FAIL' ? 'selected' : ''} class="text-danger">KHÔNG ĐẠT (FAIL)</option>
                                    </select>
                                    <p class="text-muted small fst-italic mt-2"><i class="bi bi-info-circle me-1"></i>Mặc định PASS nếu trung bình ≥ 7.0</p>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label text-dark">Nhận xét chi tiết</label>
                                    <textarea name="comment" class="form-control rounded-3" rows="5" placeholder="Điểm mạnh, điểm yếu của ứng viên...">${scorecard.comment}</textarea>
                                </div>
                            </div>
                        </div>

                        <hr class="my-5 opacity-10">

                        <div class="d-flex justify-content-end gap-3">
                            <a href="${pageContext.request.contextPath}/recruiter/candidates/detail?id=${application.id}" class="btn btn-white bg-white border rounded-pill px-4 fw-bold">
                                <i class="bi bi-x-circle me-2"></i>Hủy bỏ
                            </a>
                            <button type="submit" class="btn btn-primary rounded-pill px-5 fw-bold shadow-sm">
                                <i class="bi bi-save2 me-2"></i>Lưu kết quả
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function updateScore(id, val) {
            document.getElementById('val-' + id).innerText = val;
            calculateAverage();
        }

        function calculateAverage() {
            const scores = document.querySelectorAll('.score-input');
            let total = 0;
            scores.forEach(s => total += parseInt(s.value));
            const avg = total / scores.length;
            document.getElementById('avg-display').innerText = avg.toFixed(2);
        }
    </script>
</body>
</html>