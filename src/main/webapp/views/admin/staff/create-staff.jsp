<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${staff != null ? 'Cập nhật' : 'Thêm'} Nhân Viên - ATS Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card border-0 shadow-sm" style="border-radius: 15px;">
                    <div class="card-body p-5">
                        <h4 class="fw-bold mb-4">${staff != null ? 'Cập nhật thông tin' : 'Tạo tài khoản nhân viên'}</h4>
                        
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger">${error}</div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/admin/staff/${staff != null ? 'update' : 'store'}" method="POST">
                            <c:if test="${staff != null}">
                                <input type="hidden" name="id" value="${staff.id}">
                            </c:if>

                            <div class="mb-3">
                                <label class="form-label">Họ và tên <span class="text-danger">*</span></label>
                                <input type="text" name="fullName" class="form-control" value="${staff.fullName}" required>
                            </div>

                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label class="form-label">Email <span class="text-danger">*</span></label>
                                    <input type="email" name="email" class="form-control" value="${staff.email}" ${staff != null ? 'readonly' : ''} required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Số điện thoại</label>
                                    <input type="text" name="phone" class="form-control" value="${staff.phone}">
                                </div>
                            </div>

                            <c:if test="${staff == null}">
                                <div class="mb-3">
                                    <label class="form-label">Mật khẩu <span class="text-danger">*</span></label>
                                    <input type="password" name="password" class="form-control" required>
                                </div>
                            </c:if>

                            <div class="mb-4">
                                <label class="form-label">Vai trò</label>
                                <select name="role" class="form-select">
                                    <option value="admin" ${staff.role == 'admin' ? 'selected' : ''}>Quản trị viên (ADMIN)</option>
                                    <option value="staff" ${staff.role == 'staff' ? 'selected' : ''}>Nhân viên (STAFF)</option>
                                </select>
                            </div>

                            <div class="d-flex gap-2">
                                <button type="submit" class="btn btn-primary px-4">Lưu thông tin</button>
                                <a href="${pageContext.request.contextPath}/admin/staff" class="btn btn-light px-4">Quay lại</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>