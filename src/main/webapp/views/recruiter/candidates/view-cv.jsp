<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Xem CV: ${candidate.fullName}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        #cv-frame { width: 100%; height: 85vh; border: none; }
    </style>
</head>
<body>
    <div class="container-fluid py-3">
        <div class="d-flex justify-content-between align-items-center mb-2 px-3">
            <h5>CV của ứng viên: <span class="text-primary">${candidate.fullName}</span></h5>
            <button onclick="window.close()" class="btn btn-sm btn-secondary">Đóng cửa sổ</button>
        </div>
        
        <div class="row">
            <div class="col-12 text-center">
                <iframe id="cv-frame" src="${pageContext.request.contextPath}/uploads/cv/${cvFile}" type="application/pdf">
                    <p>Trình duyệt của bạn không hỗ trợ xem PDF trực tiếp. 
                       <a href="${pageContext.request.contextPath}/uploads/cv/${cvFile}">Tải xuống tại đây</a>.
                    </p>
                </iframe>
            </div>
        </div>
    </div>
</body>
</html>