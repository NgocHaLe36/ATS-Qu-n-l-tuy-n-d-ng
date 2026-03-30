<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách ứng viên</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-light">
    <div class="container mt-4">
        <h3 class="mb-4 text-uppercase fw-bold text-secondary">Quản lý hồ sơ ứng viên</h3>

        <form action="${pageContext.request.contextPath}/recruiter/candidates" method="get" class="card p-3 shadow-sm border-0 mb-4">
            <div class="row g-3">
                <div class="col-md-5">
                    <input type="text" name="keyword" class="form-control" placeholder="Tìm tên ứng viên..." value="${keyword}">
                </div>
                <div class="col-md-4">
                    <select name="status" class="form-select">
                        <option value="">-- Mọi trạng thái --</option>
                        <option value="PENDING" ${status == 'PENDING' ? 'selected' : ''}>Chờ duyệt</option>
                        <option value="INTERVIEW" ${status == 'INTERVIEW' ? 'selected' : ''}>Hẹn phỏng vấn</option>
                        <option value="ACCEPTED" ${status == 'ACCEPTED' ? 'selected' : ''}>Đã nhận</option>
                        <option value="REJECTED" ${status == 'REJECTED' ? 'selected' : ''}>Từ chối</option>
                    </select>
                </div>
                <div class="col-md-3">
                    <button type="submit" class="btn btn-dark w-100">Tìm kiếm ứng viên</button>
                </div>
            </div>
        </form>

        <div class="table-responsive bg-white rounded shadow-sm">
            <table class="table table-hover align-middle mb-0">
                <thead class="table-light">
                    <tr>
                        <th class="ps-3">Ứng viên</th>
                        <th>Vị trí ứng tuyển</th>
                        <th>Ngày nộp</th>
                        <th>Trạng thái</th>
                        <th class="text-center">Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="app" items="${applications}">
                        <tr>
                            <td class="ps-3">
                                <div class="d-flex align-items-center">
                                    <div class="avatar-sm bg-primary text-white rounded-circle p-2 me-2 text-center" style="width: 35px; height: 35px; line-height: 20px;">
                                        ${app.candidate.fullName.charAt(0)}
                                    </div>
                                    <div>
                                        <div class="fw-bold">${app.candidate.fullName}</div>
                                        <small class="text-muted">${app.candidate.email}</small>
                                    </div>
                                </div>
                            </td>
                            <td><span class="text-truncate" style="max-width: 150px; display: inline-block;">${app.job.title}</span></td>
                            <td><fmt:formatDate value="${app.appliedDate}" pattern="dd/MM/yyyy"/></td>
                            <td>
                                <span class="badge rounded-pill 
                                    ${app.status == 'PENDING' ? 'bg-secondary' : 
                                      app.status == 'INTERVIEW' ? 'bg-info' : 
                                      app.status == 'ACCEPTED' ? 'bg-success' : 'bg-danger'}">
                                    ${app.status}
                                </span>
                            </td>
                            <td class="text-center">
                                <a href="candidates/detail?applicationId=${app.id}" class="btn btn-sm btn-primary">
                                    Chi tiết & Đánh giá
                                </a>
                                <a href="candidates/view-cv?applicationId=${app.id}" class="btn btn-sm btn-outline-secondary" target="_blank">
                                    <i class="fas fa-file-pdf"></i> CV
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>