<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đổi mật khẩu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container py-5">
        <div class="card shadow-sm border-0 mx-auto" style="max-width: 450px;">
            <div class="card-body p-4">
                <h4 class="text-center mb-4">Đổi mật khẩu</h4>
                
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">${error}</div>
                </c:if>
                <c:if test="${not empty success}">
                    <div class="alert alert-success">${success}</div>
                </c:if>

                <form action="${pageContext.request.contextPath}/recruiter/account/change-password" method="post">
                    <div class="mb-3">
                        <label class="form-label">Mật khẩu cũ</label>
                        <input type="password" name="oldPassword" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Mật khẩu mới</label>
                        <input type="password" name="newPassword" class="form-control" required>
                    </div>
                    <div class="mb-4">
                        <label class="form-label">Xác nhận mật khẩu mới</label>
                        <input type="password" name="confirmPassword" class="form-control" required>
                    </div>
                    <button type="submit" class="btn btn-dark w-100 py-2">Cập nhật mật khẩu</button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>