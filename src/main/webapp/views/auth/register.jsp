<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng ký | ATS System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">

    <style>
        body { font-family: 'Inter', sans-serif; background-color: #f8fbff; color: #333; }
        .auth-wrapper { min-height: 100vh; display: flex; align-items: center; justify-content: center; padding: 40px 15px; }
        .auth-card { background: #fff; border-radius: 20px; box-shadow: 0 10px 40px rgba(0,123,255,0.08); padding: 40px; width: 100%; max-width: 500px; border: 1px solid #edf2f7; }
        
        /* Custom Radio Buttons / Cards */
        .role-card { border: 2px solid #edf2f7; border-radius: 15px; padding: 20px; cursor: pointer; transition: 0.3s; position: relative; }
        .role-card:hover { border-color: #cbe0f8; background-color: #f8fbff; }
        .role-input:checked + .role-card { border-color: #007bff; background-color: rgba(0, 123, 255, 0.05); }
        .role-input:checked + .role-card::after { content: '\F26A'; font-family: 'Bootstrap-icons'; position: absolute; top: 15px; right: 15px; color: #007bff; font-size: 1.2rem; }
        .role-input { display: none; }
        
        .role-icon { width: 50px; height: 50px; border-radius: 12px; display: flex; align-items: center; justify-content: center; font-size: 1.5rem; margin-bottom: 15px; }
    </style>
</head>
<body>

    <a href="${pageContext.request.contextPath}/home" class="position-absolute top-0 start-0 m-4 text-decoration-none text-muted fw-bold"><i class="bi bi-arrow-left me-2"></i>Về trang chủ</a>

    <div class="auth-wrapper">
        <div class="auth-card text-center">
            <h3 class="fw-bold mb-1">Tạo tài khoản ATS</h3>
            <p class="text-muted small mb-4">Bạn muốn tham gia hệ thống với vai trò gì?</p>

            <c:if test="${not empty error}">
                <div class="alert alert-danger rounded-3 py-2 small text-start"><i class="bi bi-exclamation-circle me-2"></i>${error}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/auth/register" method="POST" class="text-start">
                
                <label class="d-block mb-3">
                    <input type="radio" name="role" value="candidate" class="role-input" checked>
                    <div class="role-card d-flex align-items-center">
                        <div class="role-icon bg-primary bg-opacity-10 text-primary me-3 mb-0"><i class="bi bi-person-badge"></i></div>
                        <div>
                            <h6 class="fw-bold mb-1">Ứng viên tìm việc</h6>
                            <p class="small text-muted mb-0">Tạo CV và ứng tuyển việc làm</p>
                        </div>
                    </div>
                </label>

                <label class="d-block mb-4">
                    <input type="radio" name="role" value="recruiter" class="role-input">
                    <div class="role-card d-flex align-items-center">
                        <div class="role-icon bg-warning bg-opacity-10 text-warning me-3 mb-0"><i class="bi bi-buildings"></i></div>
                        <div>
                            <h6 class="fw-bold mb-1">Nhà Tuyển Dụng</h6>
                            <p class="small text-muted mb-0">Đăng tin và tìm kiếm nhân tài</p>
                        </div>
                    </div>
                </label>
                
                <button type="submit" class="btn btn-primary w-100 rounded-3 py-3 fw-bold shadow-sm">Tiếp tục <i class="bi bi-arrow-right ms-2"></i></button>
            </form>

            <div class="text-center mt-4">
                <span class="text-muted small">Đã có tài khoản? </span>
                <a href="${pageContext.request.contextPath}/auth/login" class="fw-bold text-decoration-none text-primary small">Đăng nhập</a>
            </div>
        </div>
    </div>

</body>
</html>