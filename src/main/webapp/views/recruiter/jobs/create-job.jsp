<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng tin tuyển dụng mới</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card shadow border-0">
                    <div class="card-header bg-primary text-white">
                        <h4 class="mb-0">Tạo tin tuyển dụng</h4>
                    </div>
                    <div class="card-body p-4">
                        <form action="${pageContext.request.contextPath}/recruiter/jobs/store" method="post">
                            <div class="mb-3">
                                <label class="form-label fw-bold">Tiêu đề công việc</label>
                                <input type="text" name="title" class="form-control" placeholder="Ví dụ: Java Backend Developer" required>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-bold">Địa điểm làm việc</label>
                                    <input type="text" name="location" class="form-control" placeholder="Hồ Chí Minh, Hà Nội..." required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-bold">Mức lương (VNĐ)</label>
                                    <input type="number" name="salary" class="form-control" placeholder="Để trống nếu thỏa thuận">
                                </div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-bold">Mô tả công việc</label>
                                <textarea name="description" class="form-control" rows="4" required></textarea>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-bold">Yêu cầu ứng viên</label>
                                <textarea name="requirement" class="form-control" rows="4" required></textarea>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-bold">Hạn chót ứng tuyển</label>
                                    <input type="datetime-local" name="deadline" class="form-local" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-bold">Trạng thái tin đăng</label>
                                    <select name="status" class="form-select">
                                        <option value="OPEN">Công khai ngay (OPEN)</option>
                                        <option value="HIDDEN">Lưu nháp (HIDDEN)</option>
                                    </select>
                                </div>
                            </div>

                            <c:if test="${not empty activeSubscription}">
                                <div class="alert alert-info">
                                    Gói dịch vụ hiện tại: <strong>${activeSubscription.plan.name}</strong> 
                                    (Hết hạn: ${activeSubscription.endDate})
                                </div>
                            </c:if>

                            <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-4">
                                <a href="${pageContext.request.contextPath}/recruiter/jobs" class="btn btn-secondary me-md-2">Hủy bỏ</a>
                                <button type="submit" class="btn btn-primary px-5">Đăng tin</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>