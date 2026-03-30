<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Cập nhật CV - ATS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
</head>
<body class="bg-light">
    <div class="container py-5 text-center">
        <div class="card p-5 mx-auto border-0 shadow-sm" style="max-width: 500px; border-radius: 20px;">
            <i class="bi bi-cloud-arrow-up text-primary display-3 mb-3"></i>
            <h4 class="fw-bold mb-4">Cập nhật CV của bạn</h4>
            <p class="text-muted small mb-4">Chúng tôi khuyên dùng định dạng .PDF để AI đánh giá tốt nhất.</p>
            <form action="${pageContext.request.contextPath}/candidate/save-cv" method="POST" enctype="multipart/form-data">
                <input type="file" name="cvFile" class="form-control mb-4" accept=".pdf,.doc,.docx" required>
                <button type="submit" class="btn btn-primary w-100 py-2 rounded-pill fw-bold">Tải CV lên hệ thống</button>
                <a href="${pageContext.request.contextPath}/candidate/profile" class="btn btn-link mt-2 text-muted text-decoration-none">Hủy bỏ</a>
            </form>
        </div>
    </div>
</body>
</html>