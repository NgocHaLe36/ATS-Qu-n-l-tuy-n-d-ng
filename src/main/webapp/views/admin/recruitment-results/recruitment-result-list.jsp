<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Kết Quả Tuyển Dụng - ATS Admin</title>
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
        .admin-card { background: #fff; border: 1px solid #eee; border-radius: 15px; padding: 24px; box-shadow: 0 5px 15px rgba(0,0,0,0.02); }
        .table > :not(caption) > * > * { padding: 16px 12px; border-bottom-color: #f1f5f9; vertical-align: middle; }
        .badge-status { padding: 6px 12px; border-radius: 50px; font-size: 0.75rem; font-weight: 600; }
        .ai-score-high { color: #10b981; font-weight: 800; font-size: 1.1rem; }
        .ai-score-med { color: #f59e0b; font-weight: 800; font-size: 1.1rem; }
        .ai-score-low { color: #ef4444; font-weight: 800; font-size: 1.1rem; }
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
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/auth/change-password" class="sidebar-link"><i class="bi bi-shield-lock"></i> Quản lý tài khoản</a></li>

            <div class="sidebar-menu-title">Nghiệp vụ cốt lõi</div>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/admin/recruiters" class="sidebar-link"><i class="bi bi-buildings"></i> Quản lý nhà tuyển dụng</a></li>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/admin/candidates" class="sidebar-link"><i class="bi bi-people"></i> Quản lý ứng viên</a></li>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/admin/jobs" class="sidebar-link"><i class="bi bi-file-earmark-text"></i> Quản lý tin tuyển dụng</a></li>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/admin/recruitment-results" class="sidebar-link active"><i class="bi bi-clipboard2-check"></i> Quản lý kết quả tuyển dụng</a></li>

            <div class="sidebar-menu-title">Tài chính & Phân tích</div>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/admin/vip-plans" class="sidebar-link"><i class="bi bi-gem"></i> Quản lý gói VIP</a></li>
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
                <form action="${pageContext.request.contextPath}/admin/recruitment-results" method="GET" class="bg-light px-3 py-2 rounded-pill d-flex align-items-center border">
                    <i class="bi bi-search text-muted me-2"></i>
                    <input type="text" name="keyword" class="border-0 bg-transparent outline-none" placeholder="Tìm kiếm nhanh..." style="width: 250px;">
                </form>
            </div>
            <div class="d-flex align-items-center gap-3">
                <div class="dropdown">
                    <a href="#" class="text-dark text-decoration-none dropdown-toggle d-flex align-items-center" data-bs-toggle="dropdown">
                        <img src="https://ui-avatars.com/api/?name=${admin.fullName}&background=007bff&color=fff" class="rounded-circle me-2" width="40" alt="Admin">
                        <span class="fw-bold">${admin.fullName != null ? admin.fullName : 'Super Admin'}</span>
                    </a>
                </div>
            </div>
        </header>

        <div class="container-fluid p-4 flex-grow-1">
            <div class="mb-4">
                <h3 class="fw-bold mb-1">Kết Quả Tuyển Dụng & Ứng Tuyển</h3>
                <p class="text-muted small">Theo dõi hồ sơ nộp vào và điểm AI tự động đánh giá</p>
            </div>

            <div class="admin-card">
                <form action="${pageContext.request.contextPath}/admin/recruitment-results" method="GET" class="row mb-4 g-3">
                    <div class="col-md-5">
                        <div class="input-group border rounded-pill overflow-hidden bg-white">
                            <span class="input-group-text bg-transparent border-0"><i class="bi bi-search text-muted"></i></span>
                            <input type="text" name="keyword" class="form-control border-0 shadow-none" placeholder="Tên ứng viên hoặc vị trí..." value="${param.keyword}">
                        </div>
                    </div>
                    <div class="col-md-4">
                        <select name="status" class="form-select rounded-pill border shadow-none" onchange="this.form.submit()">
                            <option value="">Tất cả trạng thái</option>
                            <option value="PENDING" ${status == 'PENDING' ? 'selected' : ''}>Chờ xử lý</option>
                            <option value="INTERVIEWING" ${status == 'INTERVIEWING' ? 'selected' : ''}>Đang phỏng vấn</option>
                            <option value="ACCEPTED" ${status == 'ACCEPTED' ? 'selected' : ''}>Đã trúng tuyển</option>
                            <option value="REJECTED" ${status == 'REJECTED' ? 'selected' : ''}>Bị loại</option>
                        </select>
                    </div>
                    <div class="col-md-3 text-end">
                        <button type="submit" class="btn btn-primary rounded-pill w-100 fw-bold">Lọc dữ liệu</button>
                    </div>
                </form>

                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead class="bg-light text-muted small text-uppercase">
                            <tr>
                                <th class="border-0">Mã HS</th>
                                <th class="border-0">Ứng viên nộp</th>
                                <th class="border-0">Vị trí ứng tuyển</th>
                                <th class="border-0 text-center">Điểm AI</th>
                                <th class="border-0">Ngày nộp</th>
                                <th class="border-0">Trạng thái</th>
                                <th class="border-0 text-center">Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="app" items="${applications}">
                                <tr>
                                    <td class="fw-bold">#APP-${app.id}</td>
                                    
                                    <td>
                                        <c:catch var="candError">
                                            <div class="fw-bold text-dark">${app.candidate.user.fullName}</div>
                                        </c:catch>
                                        <c:if test="${not empty candError}">
                                            <div class="fw-bold text-dark text-danger" title="${candError}">ID Ứng viên: ${app.candidateId}</div>
                                        </c:if>
                                        <small class="text-primary"><i class="bi bi-file-earmark-pdf me-1"></i> ${app.cvFile != null ? app.cvFile : 'Chưa có CV'}</small>
                                    </td>

                                    <td>
                                        <c:catch var="jobError">
                                            <div class="fw-bold">${app.job.title}</div>
                                            <small class="text-muted">${app.job.recruiter.fullName}</small>
                                        </c:catch>
                                        <c:if test="${not empty jobError}">
                                            <div class="fw-bold text-danger" title="${jobError}">Mã Job: ${app.jobId}</div>
                                        </c:if>
                                    </td>

                                    <td class="text-center">
                                        <c:catch var="scoreError">
                                            <span class="fw-bold ${app.aiScore.totalScore >= 85 ? 'ai-score-high' : (app.aiScore.totalScore >= 60 ? 'ai-score-med' : 'ai-score-low')}">
                                                ${app.aiScore.totalScore}
                                            </span><span class="text-muted small">/100</span>
                                        </c:catch>
                                        <c:if test="${not empty scoreError}">
                                            <span class="text-muted small">Chưa chấm</span>
                                        </c:if>
                                    </td>

                                    <td class="text-muted">
                                        <c:catch var="dateError">
                                            ${app.applyDate.toLocalDate()}
                                        </c:catch>
                                        <c:if test="${not empty dateError}">
                                            ${app.applyDate}
                                        </c:if>
                                    </td>

                                    <td>
                                        <c:choose>
                                            <c:when test="${app.status == 'PENDING'}"><span class="badge-status bg-warning bg-opacity-10 text-warning">Chờ xử lý</span></c:when>
                                            <c:when test="${app.status == 'INTERVIEWING'}"><span class="badge-status bg-info bg-opacity-10 text-info">Đang phỏng vấn</span></c:when>
                                            <c:when test="${app.status == 'ACCEPTED'}"><span class="badge-status bg-success bg-opacity-10 text-success">Trúng tuyển</span></c:when>
                                            <c:when test="${app.status == 'REJECTED'}"><span class="badge-status bg-danger bg-opacity-10 text-danger">Bị loại</span></c:when>
                                            <c:otherwise><span class="badge-status bg-secondary bg-opacity-10 text-secondary">${app.status != null ? app.status : 'N/A'}</span></c:otherwise>
                                        </c:choose>
                                    </td>

                                    <td class="text-center">
                                        <a href="${pageContext.request.contextPath}/admin/recruitment-results/interview?applicationId=${app.id}" class="btn btn-sm btn-light text-primary rounded-circle" title="Xem chi tiết"><i class="bi bi-eye"></i></a>
                                        <a href="${pageContext.request.contextPath}/admin/recruitment-results/offer-letter?applicationId=${app.id}" class="btn btn-sm btn-light text-success rounded-circle ms-1" title="Duyệt Offer"><i class="bi bi-journal-check"></i></a>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty applications}">
                                <tr><td colspan="7" class="text-center py-5 text-muted">Chưa có hồ sơ ứng tuyển nào.</td></tr>
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