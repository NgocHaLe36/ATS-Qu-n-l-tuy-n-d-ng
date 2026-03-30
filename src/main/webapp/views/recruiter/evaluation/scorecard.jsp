<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chỉnh sửa tin: ${job.title}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container py-5">
        <div class="card shadow border-0 mx-auto" style="max-width: 800px;">
            <div class="card-header bg-warning text-dark fw-bold">
                Cập nhật thông tin tuyển dụng
            </div>
            <div class="card-body">
                <form action="${pageContext.request.contextPath}/recruiter/jobs/update" method="post">
                    <input type="hidden" name="id" value="${job.id}">
                    
                    <div class="mb-3">
                        <label class="form-label fw-bold">Tiêu đề</label>
                        <input type="text" name="title" class="form-control" value="${job.title}" required>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label class="form-label">Địa điểm</label>
                            <input type="text" name="location" class="form-control" value="${job.location}">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Mức lương</label>
                            <input type="number" name="salary" class="form-control" value="${job.salary}">
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Mô tả công việc</label>
                        <textarea name="description" class="form-control" rows="5">${job.description}</textarea>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Yêu cầu</label>
                        <textarea name="requirement" class="form-control" rows="5">${job.requirement}</textarea>
                    </div>

                    <div class="mb-3">
                        <label class="form-label text-danger fw-bold">Hạn chót hiện tại: ${job.deadline}</label>
                        <input type="datetime-local" name="deadline" class="form-control">
                        <small class="text-muted">Để trống nếu không muốn thay đổi ngày</small>
                    </div>

                    <div class="text-end">
                        <a href="../jobs" class="btn btn-secondary">Quay lại</a>
                        <button type="submit" class="btn btn-warning">Lưu thay đổi</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>