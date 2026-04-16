<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Hồ sơ ứng viên | ATS Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        :root { --sidebar-width: 280px; --primary-blue: #007bff; --bg-light: #f8fbff; }
        body { font-family: 'Inter', sans-serif; background-color: var(--bg-light); }
        .admin-main { margin-left: var(--sidebar-width); padding: 30px; }
        .admin-card { background: #fff; border: 1px solid #eee; border-radius: 15px; padding: 24px; box-shadow: 0 5px 15px rgba(0,0,0,0.02); }
        .avatar-lg { width: 120px; height: 120px; border-radius: 50%; object-fit: cover; border: 4px solid #fff; box-shadow: 0 5px 15px rgba(0,0,0,0.1); }
    </style>
</head>
<body>

    <main class="admin-main">
        <div class="mb-4 d-flex align-items-center">
            <a href="${pageContext.request.contextPath}/admin/candidates" class="btn btn-light rounded-circle me-3"><i class="bi bi-arrow-left"></i></a>
            <h4 class="fw-bold mb-0">Hồ sơ ứng viên</h4>
        </div>

        <div class="row g-4">
            <div class="col-lg-4">
                <div class="admin-card text-center">
                    <img src="https://ui-avatars.com/api/?name=${candidate.user.fullName}&size=200&background=007bff&color=fff" class="avatar-lg mb-3">
                    <h5 class="fw-bold mb-1">${candidate.user.fullName}</h5>
                    <p class="text-muted small">${candidate.experienceYear} năm kinh nghiệm</p>
                    
                    <div class="text-start mt-4">
                        <small class="text-muted text-uppercase fw-bold" style="font-size: 0.7rem;">Liên hệ</small>
                        <p class="mb-1 small"><i class="bi bi-envelope text-primary me-2"></i>${candidate.user.email}</p>
                        <p class="mb-3 small"><i class="bi bi-telephone text-primary me-2"></i>${candidate.user.phone}</p>
                        
                        <small class="text-muted text-uppercase fw-bold" style="font-size: 0.7rem;">Kỹ năng</small>
                        <div class="mt-1">
                            <c:forEach var="skill" items="${candidate.skills.split(',')}">
                                <span class="badge bg-light text-dark border me-1">${skill.trim()}</span>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-8">
                <div class="admin-card p-0 overflow-hidden">
                    <ul class="nav nav-tabs px-4 pt-3 bg-light border-bottom">
                        <li class="nav-item"><a class="nav-link active" data-bs-toggle="tab" href="#overview">Học vấn & CV</a></li>
                        <li class="nav-item"><a class="nav-link" data-bs-toggle="tab" href="#history">Lịch sử ứng tuyển</a></li>
                    </ul>

                    <div class="tab-content p-4">
                        <div class="tab-pane fade show active" id="overview">
                            <h6 class="fw-bold">Học vấn</h6>
                            <p class="text-muted small">${candidate.education}</p>
                            <hr>
                            <h6 class="fw-bold">File CV</h6>
                            <div class="bg-light rounded p-3 d-flex align-items-center justify-content-between">
                                <span><i class="bi bi-file-earmark-pdf text-danger me-2"></i>${candidate.cvFile}</span>
                                <a href="${candidate.cvFile}" class="btn btn-sm btn-outline-primary rounded-pill">Tải về</a>
                            </div>
                        </div>

                        <div class="tab-pane fade" id="history">
                            <table class="table align-middle small">
                                <thead class="bg-light text-muted">
                                    <tr>
                                        <th>Vị trí</th>
                                        <th>Ngày nộp</th>
                                        <th>Trạng thái</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="app" items="${applications}">
                                        <tr>
                                            <td class="fw-bold">${app.jobId}</td> <td><fmt:formatDate value="${app.applyDate}" pattern="dd/MM/yyyy"/></td>
                                            <td><span class="badge bg-info bg-opacity-10 text-info">${app.status}</span></td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>