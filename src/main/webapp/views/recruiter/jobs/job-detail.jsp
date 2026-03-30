<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chi tiết công việc: ${job.title}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container py-4">
        <div class="d-flex justify-content-between mb-3">
            <a href="${pageContext.request.contextPath}/recruiter/jobs" class="btn btn-outline-secondary">
                <i class="fas fa-arrow-left"></i> Quay lại danh sách
            </a>
            <div>
                <a href="edit?id=${job.id}" class="btn btn-warning">Sửa tin</a>
            </div>
        </div>

        <div class="row">
            <div class="col-md-8">
                <div class="card shadow-sm mb-4">
                    <div class="card-body">
                        <h2 class="text-primary">${job.title}</h2>
                        <p class="text-muted"><i class="fas fa-map-marker-alt"></i> ${job.location} | <i class="fas fa-money-bill-wave"></i> ${job.salary} VNĐ</p>
                        <hr>
                        <h5>Mô tả công việc</h5>
                        <p>${job.description}</p>
                        <h5>Yêu cầu</h5>
                        <p>${job.requirement}</p>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card shadow-sm border-primary">
                    <div class="card-body text-center">
                        <h6 class="text-uppercase text-muted">Tổng số ứng tuyển</h6>
                        <h1 class="display-4 fw-bold text-primary">${applicationCount}</h1>
                        <p>Hạn chót: <fmt:formatDate value="${job.deadline}" pattern="dd/MM/yyyy"/></p>
                        <hr>
                        <a href="#candidate-list" class="btn btn-primary w-100">Xem danh sách ứng viên</a>
                    </div>
                </div>
            </div>
        </div>

        <div id="candidate-list" class="mt-4">
            <h4>Danh sách ứng viên cho vị trí này</h4>
            <table class="table table-hover bg-white shadow-sm">
                <thead>
                    <tr>
                        <th>Tên ứng viên</th>
                        <th>Ngày nộp</th>
                        <th>Trạng thái</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="app" items="${applications}">
                        <tr>
                            <td>${app.candidate.fullName}</td>
                            <td><fmt:formatDate value="${app.appliedDate}" pattern="dd/MM/yyyy"/></td>
                            <td><span class="badge bg-info">${app.status}</span></td>
                            <td>
                                <a href="${pageContext.request.contextPath}/recruiter/candidates/detail?applicationId=${app.id}" class="btn btn-sm btn-dark">Xem hồ sơ</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>