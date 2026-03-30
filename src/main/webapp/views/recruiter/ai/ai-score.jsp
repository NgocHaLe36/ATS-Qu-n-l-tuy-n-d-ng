<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý ứng viên</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container-fluid py-4">
        <h3 class="mb-4">Danh sách ứng tuyển</h3>
        
        <div class="card mb-4 border-0 shadow-sm">
            <div class="card-body">
                <form action="" method="get" class="row g-3">
                    <div class="col-md-4">
                        <input type="text" name="keyword" class="form-control" placeholder="Tìm tên ứng viên..." value="${keyword}">
                    </div>
                    <div class="col-md-3">
                        <select name="status" class="form-select">
                            <option value="">-- Tất cả trạng thái --</option>
                            <option value="PENDING" ${status == 'PENDING' ? 'selected' : ''}>Chờ duyệt</option>
                            <option value="INTERVIEWING" ${status == 'INTERVIEWING' ? 'selected' : ''}>Đang phỏng vấn</option>
                            <option value="ACCEPTED" ${status == 'ACCEPTED' ? 'selected' : ''}>Đã nhận</option>
                            <option value="REJECTED" ${status == 'REJECTED' ? 'selected' : ''}>Từ chối</option>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <button type="submit" class="btn btn-primary w-100">Lọc dữ liệu</button>
                    </div>
                </form>
            </div>
        </div>

        <div class="table-responsive bg-white rounded shadow-sm">
            <table class="table table-hover align-middle mb-0">
                <thead class="table-light">
                    <tr>
                        <th>Ứng viên</th>
                        <th>Vị trí ứng tuyển</th>
                        <th>Ngày nộp</th>
                        <th>Điểm AI</th>
                        <th>Trạng thái</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="app" items="${applications}">
                        <tr>
                            <td>
                                <div class="fw-bold">${app.candidate.fullName}</div>
                                <div class="small text-muted">${app.candidate.email}</div>
                            </td>
                            <td>${app.job.title}</td>
                            <td>${app.appliedDate}</td>
                            <td><span class="badge bg-dark">${app.aiScore != null ? app.aiScore : 'N/A'}</span></td>
                            <td><span class="badge rounded-pill bg-info text-dark">${app.status}</span></td>
                            <td>
                                <a href="candidates/detail?applicationId=${app.id}" class="btn btn-sm btn-outline-primary">Chi tiết</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>