<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Trạng thái hồ sơ - ATS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        .step-circle { width: 40px; height: 40px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: bold; background: #e9ecef; color: #6c757d; }
        .step-circle.active { background: #007bff; color: #fff; }
        .step-line { flex-grow: 1; height: 3px; background: #e9ecef; margin-top: 20px; }
        .step-line.active { background: #007bff; }
    </style>
</head>
<body class="bg-light">
    <div class="container py-5">
        <div class="card border-0 shadow-sm p-5 text-center" style="border-radius: 20px;">
            <h4 class="fw-bold mb-5">Tiến trình hồ sơ ứng tuyển</h4>
            <div class="d-flex align-items-start mb-4">
                <div class="text-center" style="width: 80px;">
                    <div class="step-circle active mx-auto"><i class="bi bi-check-lg"></i></div>
                    <small class="d-block mt-2">Đã nộp</small>
                </div>
                <div class="step-line active"></div>
                <div class="text-center" style="width: 80px;">
                    <div class="step-circle ${status != 'APPLIED' ? 'active' : ''} mx-auto">2</div>
                    <small class="d-block mt-2">Đang xét</small>
                </div>
                <div class="step-line ${status == 'INTERVIEW' || status == 'ACCEPTED' ? 'active' : ''}"></div>
                <div class="text-center" style="width: 80px;">
                    <div class="step-circle ${status == 'INTERVIEW' || status == 'ACCEPTED' ? 'active' : ''} mx-auto">3</div>
                    <small class="d-block mt-2">Phỏng vấn</small>
                </div>
            </div>
            <p class="mt-4 text-muted">Trạng thái hiện tại: <strong>${status}</strong></p>
            <a href="${pageContext.request.contextPath}/candidate/application-detail?id=${application.id}" class="btn btn-outline-primary mt-3">Quay lại chi tiết</a>
        </div>
    </div>
</body>
</html>