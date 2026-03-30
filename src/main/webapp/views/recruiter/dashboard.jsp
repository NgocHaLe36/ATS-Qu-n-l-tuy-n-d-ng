<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ADMIN Dashboard | ATS System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #6366f1 0%, #a855f7 100%);
            --glass-bg: rgba(255, 255, 255, 0.95);
            --sidebar-width: 280px;
        }

        body { 
            font-family: 'Inter', sans-serif; 
            background: #f8fafc; 
            color: #1e293b;
            overflow-x: hidden;
        }

        /* Hiệu ứng di chuột độc lạ cho Card */
        .stat-card {
            border: none;
            border-radius: 24px;
            background: var(--glass-bg);
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            cursor: pointer;
            position: relative;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,0.03);
        }

        .stat-card:hover {
            transform: translateY(-10px) scale(1.02);
            box-shadow: 0 20px 40px rgba(99, 102, 241, 0.15);
        }

        .stat-card::after {
            content: '';
            position: absolute;
            top: -50%; left: -50%;
            width: 200%; height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.3) 0%, transparent 70%);
            transform: rotate(45deg);
            transition: 0.6s;
            opacity: 0;
        }

        .stat-card:hover::after {
            opacity: 1;
            left: 20%;
        }

        /* Sidebar & Navigation */
        .sidebar {
            width: var(--sidebar-width);
            height: 100vh;
            position: fixed;
            background: white;
            border-right: 1px solid #e2e8f0;
            padding: 2rem;
            z-index: 1000;
        }

        .nav-custom-link {
            display: flex;
            align-items: center;
            padding: 0.8rem 1.2rem;
            margin-bottom: 0.5rem;
            border-radius: 12px;
            color: #64748b;
            text-decoration: none;
            transition: all 0.3s;
        }

        .nav-custom-link:hover, .nav-custom-link.active {
            background: var(--primary-gradient);
            color: white !important;
            box-shadow: 0 4px 15px rgba(99, 102, 241, 0.3);
        }

        /* VIP Badge Animation */
        .vip-status-card {
            background: linear-gradient(45deg, #1e293b, #334155);
            color: #fbbf24;
            border-radius: 20px;
            border: 1px solid rgba(251, 191, 36, 0.3);
        }

        .pulse-orange {
            animation: pulse-orange 2s infinite;
        }

        @keyframes pulse-orange {
            0% { box-shadow: 0 0 0 0 rgba(251, 191, 36, 0.4); }
            70% { box-shadow: 0 0 0 10px rgba(251, 191, 36, 0); }
            100% { box-shadow: 0 0 0 0 rgba(251, 191, 36, 0); }
        }

        /* Glass Table */
        .custom-table-container {
            background: white;
            border-radius: 20px;
            padding: 1.5rem;
            box-shadow: 0 4px 20px rgba(0,0,0,0.02);
        }

        .main-content { margin-left: var(--sidebar-width); padding: 2rem; }
    </style>
</head>
<body>

    <div class="sidebar">
        <div class="d-flex align-items-center mb-5">
            <i class="bi bi-rocket-takeoff-fill fs-2 text-primary me-3"></i>
            <span class="fw-bold fs-4">ATS ADMIN</span>
        </div>
        
        <nav>
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-custom-link active">
                <i class="bi bi-grid-1x2-fill me-3"></i> Tổng quan
            </a>
            <a href="${pageContext.request.contextPath}/recruiter/jobs" class="nav-custom-link">
                <i class="bi bi-briefcase-fill me-3"></i> Quản lý tin đăng
            </a>
            <a href="${pageContext.request.contextPath}/recruiter/pipeline" class="nav-custom-link">
                <i class="bi bi-funnel-fill me-3"></i> Quy trình (Pipeline)
            </a>
            <a href="${pageContext.request.contextPath}/recruiter/candidates" class="nav-custom-link">
                <i class="bi bi-people-fill me-3"></i> Ứng viên
            </a>
            <a href="${pageContext.request.contextPath}/recruiter/vip/plans" class="nav-custom-link">
                <i class="bi bi-star-fill me-3"></i> Gói dịch vụ VIP
            </a>
            <hr>
            <a href="${pageContext.request.contextPath}/recruiter/account/profile" class="nav-custom-link">
                <i class="bi bi-person-circle me-3"></i> Hồ sơ công ty
            </a>
            <a href="${pageContext.request.contextPath}/auth/logout" class="nav-custom-link text-danger">
                <i class="bi bi-box-arrow-right me-3"></i> Đăng xuất
            </a>
        </nav>
    </div>

    <main class="main-content">
        <div class="d-flex justify-content-between align-items-center mb-5" data-aos="fade-down">
            <div>
                <h2 class="fw-bold mb-1">Chào buổi tối, ${sessionScope.currentUser.fullName}! 👋</h2>
                <p class="text-muted">Đây là những gì đang diễn ra với các tin tuyển dụng của bạn.</p>
            </div>
            <div class="d-flex align-items-center gap-3">
                <c:if test="${not empty activeSubscription}">
                    <div class="vip-status-card px-4 py-2 d-flex align-items-center pulse-orange">
                        <i class="bi bi-gem me-2"></i>
                        <span class="fw-bold">Gói VIP: ${activeSubscription.plan.name}</span>
                    </div>
                </c:if>
                <a href="${pageContext.request.contextPath}/recruiter/jobs/create" class="btn btn-primary px-4 py-2 rounded-pill shadow">
                    <i class="bi bi-plus-lg me-2"></i> Đăng tin mới
                </a>
            </div>
        </div>

        <div class="row g-4 mb-5">
            <div class="col-md-3" data-aos="zoom-in" data-aos-delay="100">
                <div class="stat-card p-4">
                    <div class="d-flex justify-content-between align-items-start">
                        <div>
                            <p class="text-muted small fw-bold text-uppercase mb-1">Tin đang tuyển</p>
                            <h3 class="fw-bold mb-0">${jobs.stream().filter(j -> "OPEN".equals(j.status)).count()}</h3>
                        </div>
                        <div class="bg-primary bg-opacity-10 p-3 rounded-4">
                            <i class="bi bi-megaphone text-primary fs-4"></i>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3" data-aos="zoom-in" data-aos-delay="200">
                <div class="stat-card p-4">
                    <div class="d-flex justify-content-between align-items-start">
                        <div>
                            <p class="text-muted small fw-bold text-uppercase mb-1">Tổng hồ sơ</p>
                            <h3 class="fw-bold mb-0">${totalApplications != null ? totalApplications : 0}</h3>
                        </div>
                        <div class="bg-success bg-opacity-10 p-3 rounded-4">
                            <i class="bi bi-file-earmark-person text-success fs-4"></i>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3" data-aos="zoom-in" data-aos-delay="300">
                <div class="stat-card p-4">
                    <div class="d-flex justify-content-between align-items-start">
                        <div>
                            <p class="text-muted small fw-bold text-uppercase mb-1">Chờ phỏng vấn</p>
                            <h3 class="fw-bold mb-0">${pendingInterviews != null ? pendingInterviews : 0}</h3>
                        </div>
                        <div class="bg-warning bg-opacity-10 p-3 rounded-4">
                            <i class="bi bi-calendar-event text-warning fs-4"></i>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3" data-aos="zoom-in" data-aos-delay="400">
                <div class="stat-card p-4">
                    <div class="d-flex justify-content-between align-items-start">
                        <div>
                            <p class="text-muted small fw-bold text-uppercase mb-1">Đã tuyển được</p>
                            <h3 class="fw-bold mb-0">${hiredCount != null ? hiredCount : 0}</h3>
                        </div>
                        <div class="bg-info bg-opacity-10 p-3 rounded-4">
                            <i class="bi bi-check-all text-info fs-4"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row g-4">
            <div class="col-lg-8" data-aos="fade-right">
                <div class="custom-table-container">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h5 class="fw-bold mb-0">Việc làm mới đăng gần đây</h5>
                        <a href="${pageContext.request.contextPath}/recruiter/jobs" class="text-primary text-decoration-none small fw-bold">Xem tất cả</a>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead class="table-light">
                                <tr>
                                    <th>Vị trí</th>
                                    <th>Trạng thái</th>
                                    <th>Hồ sơ</th>
                                    <th>Hạn chót</th>
                                    <th>Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="job" items="${jobs}" varStatus="status">
                                    <c:if test="${status.index < 5}">
                                        <tr>
                                            <td>
                                                <div class="fw-bold text-dark">${job.title}</div>
                                                <c:if test="${job.isVip}"><span class="badge bg-warning text-dark small"><i class="bi bi-star-fill"></i> VIP</span></c:if>
                                            </td>
                                            <td>
                                                <span class="badge ${job.status == 'OPEN' ? 'bg-success' : 'bg-secondary'} bg-opacity-10 ${job.status == 'OPEN' ? 'text-success' : 'text-secondary'} rounded-pill">
                                                    ${job.status}
                                                </span>
                                            </td>
                                            <td><span class="fw-bold text-primary">0</span> hồ sơ</td> <td class="small text-muted"><fmt:parseDate value="${job.deadline}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDeadline"/><fmt:formatDate value="${parsedDeadline}" pattern="dd/MM/yyyy"/></td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/recruiter/jobs/detail?id=${job.id}" class="btn btn-sm btn-light rounded-circle"><i class="bi bi-eye"></i></a>
                                            </td>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <div class="col-lg-4" data-aos="fade-left">
                <div class="custom-table-container h-100">
                    <h5 class="fw-bold mb-4">Tình trạng tài khoản</h5>
                    <div class="text-center p-4 rounded-4 bg-light mb-4">
                        <c:choose>
                            <c:when test="${not empty activeSubscription}">
                                <div class="mb-3 text-warning"><i class="bi bi-gem fs-1"></i></div>
                                <h6 class="fw-bold">${activeSubscription.plan.name}</h6>
                                <p class="small text-muted">Hết hạn: <fmt:parseDate value="${activeSubscription.endDate}" pattern="yyyy-MM-dd'T'HH:mm" var="pEnd"/><fmt:formatDate value="${pEnd}" pattern="dd/MM/yyyy"/></p>
                                <div class="progress mb-3" style="height: 8px;">
                                    <div class="progress-bar bg-warning" role="progressbar" style="width: 75%"></div>
                                </div>
                                <a href="${pageContext.request.contextPath}/recruiter/vip/plans" class="btn btn-outline-warning w-100 rounded-pill">Nâng cấp gói</a>
                            </c:when>
                            <c:otherwise>
                                <div class="mb-3 text-muted"><i class="bi bi-slash-circle fs-1"></i></div>
                                <h6 class="fw-bold">Gói Miễn phí</h6>
                                <p class="small text-muted">Đăng ký VIP để mở khóa tính năng lọc ứng viên bằng AI.</p>
                                <a href="${pageContext.request.contextPath}/recruiter/vip/plans" class="btn btn-primary w-100 rounded-pill">Nâng cấp ngay</a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    
                    <h6 class="fw-bold mb-3 small text-uppercase text-muted">Thanh toán gần đây</h6>
                    <div class="d-flex align-items-center gap-3 mb-3">
                        <div class="bg-success bg-opacity-10 p-2 rounded-3 text-success"><i class="bi bi-arrow-up-right"></i></div>
                        <div>
                            <div class="fw-bold small">Thanh toán thành công</div>
                            <div class="text-muted extra-small">23/03/2026</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <script>
        AOS.init({ duration: 800, once: true });
    </script>
</body>
</html>