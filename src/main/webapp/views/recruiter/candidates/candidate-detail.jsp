<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Hồ sơ ứng viên: ${candidate.fullName}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-light">
    <div class="container py-4">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/recruiter/candidates">Ứng viên</a></li>
                <li class="breadcrumb-item active">Chi tiết hồ sơ</li>
            </ol>
        </nav>

        <div class="row">
            <div class="col-md-4">
                <div class="card shadow-sm border-0 mb-4">
                    <div class="card-body text-center">
                        <img src="${pageContext.request.contextPath}/assets/img/default-avatar.png" class="rounded-circle mb-3" width="100">
                        <h4 class="fw-bold">${candidate.fullName}</h4>
                        <p class="text-muted">${candidate.email}</p>
                        <hr>
                        <div class="text-start">
                            <p><strong><i class="fas fa-phone me-2"></i></strong> ${candidate.phone}</p>
                            <p><strong><i class="fas fa-map-marker-alt me-2"></i></strong> ${candidate.address}</p>
                        </div>
                        <a href="${pageContext.request.contextPath}/recruiter/candidates/view-cv?applicationId=${application.id}" class="btn btn-outline-danger w-100" target="_blank">
                            <i class="fas fa-file-pdf me-2"></i> Xem CV (PDF)
                        </a>
                    </div>
                </div>

                <c:if test="${not empty aiScore}">
                    <div class="card shadow-sm border-0 bg-dark text-white p-3 mb-4">
                        <h5><i class="fas fa-robot me-2"></i>AI Đánh giá</h5>
                        <div class="display-4 text-center text-warning fw-bold">${aiScore.score}/100</div>
                        <p class="small mt-2 mb-0 italic">"${aiScore.summary}"</p>
                    </div>
                </c:if>
            </div>

            <div class="col-md-8">
                <div class="card shadow-sm border-0 mb-4">
                    <div class="card-header bg-white d-flex justify-content-between align-items-center py-3">
                        <h5 class="mb-0 fw-bold">Vị trí: ${job.title}</h5>
                        <span class="badge bg-info p-2">${application.status}</span>
                    </div>
                    <div class="card-body">
                        <h6><strong>Ngày nộp:</strong> <fmt:formatDate value="${application.appliedDate}" pattern="dd/MM/yyyy HH:mm"/></h6>
                        
                        <div class="mt-4">
                            <h6 class="fw-bold border-bottom pb-2">Hành động nhanh</h6>
                            <div class="d-flex gap-2">
                                <a href="${pageContext.request.contextPath}/recruiter/interviews/schedule?applicationId=${application.id}" class="btn btn-primary">
                                    <i class="fas fa-calendar-alt me-1"></i> Lập lịch phỏng vấn
                                </a>
                                <a href="${pageContext.request.contextPath}/recruiter/evaluation/scorecard?applicationId=${application.id}" class="btn btn-success">
                                    <i class="fas fa-star me-1"></i> Chấm điểm (Scorecard)
                                </a>
                            </div>
                        </div>
                    </div>
                </div>

                <c:if test="${not empty latestInterview}">
                    <div class="card shadow-sm border-0">
                        <div class="card-header bg-white py-3"><h5 class="mb-0">Lịch phỏng vấn gần nhất</h5></div>
                        <div class="card-body">
                            <p><strong>Thời gian:</strong> <fmt:formatDate value="${latestInterview.interviewDate}" pattern="dd/MM/yyyy HH:mm"/></p>
                            <p><strong>Hình thức:</strong> ${latestInterview.location}</p>
                            <p><strong>Ghi chú:</strong> ${latestInterview.notes}</p>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</body>
</html>