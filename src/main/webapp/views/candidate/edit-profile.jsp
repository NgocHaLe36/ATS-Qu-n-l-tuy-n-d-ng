<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Cập nhật thông tin - ATS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #f0f2f5; }
        .sidebar { background: #fff; min-height: 100vh; position: fixed; width: 260px; border-right: 1px solid #e5e5e5; }
        .main-content { margin-left: 260px; padding: 25px; }
        .form-card { background: #fff; border-radius: 12px; padding: 30px; box-shadow: 0 1px 2px rgba(0,0,0,0.1); max-width: 800px; margin: auto; }
    </style>
</head>
<body>
    <div class="sidebar py-3">
        <div class="px-4 mb-4 d-flex align-items-center"><i class="bi bi-building-fill text-primary fs-3 me-2"></i><span class="fw-bold fs-4 text-primary">ATS System</span></div>
        <nav class="nav flex-column">
            <a class="nav-link" href="${pageContext.request.contextPath}/candidate/dashboard"><i class="bi bi-grid-fill me-2"></i> Dashboard</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/candidate/applied-jobs"><i class="bi bi-briefcase-fill me-2"></i> Việc làm đã ứng tuyển</a>
            <a class="nav-link active" href="${pageContext.request.contextPath}/candidate/profile"><i class="bi bi-person-fill me-2"></i> Hồ sơ cá nhân</a>
        </nav>
    </div>

    <div class="main-content">
        <div class="form-card">
            <h4 class="fw-bold mb-4">Cập nhật thông tin chuyên môn</h4>
            <form action="${pageContext.request.contextPath}/candidate/profile/update" method="POST">
                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label small fw-bold">Họ và tên</label>
                        <input type="text" name="fullName" class="form-control" value="${user.fullName}" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label small fw-bold">Số điện thoại</label>
                        <input type="text" name="phone" class="form-control" value="${user.phone}">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label small fw-bold">Số năm kinh nghiệm</label>
                        <input type="number" name="experienceYear" class="form-control" value="${candidate.experienceYear}">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label small fw-bold">Trình độ học vấn</label>
                        <input type="text" name="education" class="form-control" value="${candidate.education}">
                    </div>
                    <div class="col-12">
                        <label class="form-label small fw-bold">Kỹ năng (Phân cách bằng dấu phẩy)</label>
                        <textarea name="skills" class="form-control" rows="3" placeholder="Ví dụ: Java, SQL, ReactJS...">${candidate.skills}</textarea>
                    </div>
                    <div class="col-12 mt-4 d-flex gap-2">
                        <button type="submit" class="btn btn-primary px-5 rounded-pill shadow-sm">Lưu thay đổi</button>
                        <a href="${pageContext.request.contextPath}/candidate/profile" class="btn btn-outline-secondary px-4 rounded-pill">Quay lại</a>
                    </div>
                </div>
            </form>
        </div>
    </div>
</body>
</html>