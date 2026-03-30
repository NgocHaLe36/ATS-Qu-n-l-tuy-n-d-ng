<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý tin tuyển dụng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h3><i class="fas fa-list-alt me-2"></i>Danh sách tin tuyển dụng</h3>
            <a href="${pageContext.request.contextPath}/recruiter/jobs/create" class="btn btn-success">
                <i class="fas fa-plus"></i> Đăng tin mới
            </a>
        </div>

        <form action="${pageContext.request.contextPath}/recruiter/jobs" method="get" class="row g-3 mb-4 bg-light p-3 rounded">
            <div class="col-md-4">
                <input type="text" name="keyword" class="form-control" placeholder="Tìm theo tiêu đề..." value="${keyword}">
            </div>
            <div class="col-md-3">
                <select name="status" class="form-select">
                    <option value="">-- Tất cả trạng thái --</option>
                    <option value="OPEN" ${status == 'OPEN' ? 'selected' : ''}>Đang mở (OPEN)</option>
                    <option value="HIDDEN" ${status == 'HIDDEN' ? 'selected' : ''}>Đã ẩn (HIDDEN)</option>
                    <option value="CLOSED" ${status == 'CLOSED' ? 'selected' : ''}>Đã đóng (CLOSED)</option>
                </select>
            </div>
            <div class="col-md-3">
                <select name="vip" class="form-select">
                    <option value="">-- Loại tin --</option>
                    <option value="true" ${vip == 'true' ? 'selected' : ''}>Tin VIP</option>
                    <option value="false" ${vip == 'false' ? 'selected' : ''}>Tin thường</option>
                </select>
            </div>
            <div class="col-md-2">
                <button type="submit" class="btn btn-primary w-100">Lọc</button>
            </div>
        </form>

        <div class="card shadow-sm">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-dark">
                        <tr>
                            <th>Tiêu đề</th>
                            <th>Ngày đăng</th>
                            <th>Hạn chót</th>
                            <th>Trạng thái</th>
                            <th>VIP</th>
                            <th class="text-center">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="job" items="${jobs}">
                            <tr>
                                <td class="fw-bold text-primary">${job.title}</td>
                                <td><fmt:formatDate value="${job.createdDate}" pattern="dd/MM/yyyy"/></td>
                                <td><fmt:formatDate value="${job.deadline}" pattern="dd/MM/yyyy"/></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${job.status == 'OPEN'}"><span class="badge bg-success">Đang mở</span></c:when>
                                        <c:when test="${job.status == 'HIDDEN'}"><span class="badge bg-warning text-dark">Đã ẩn</span></c:when>
                                        <c:otherwise><span class="badge bg-danger">Đã đóng</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:if test="${job.isVip}"><i class="fas fa-crown text-warning"></i></c:if>
                                </td>
                                <td class="text-center">
                                    <div class="btn-group">
                                        <a href="detail?id=${job.id}" class="btn btn-sm btn-outline-info" title="Xem chi tiết"><i class="fas fa-eye"></i></a>
                                        <a href="edit?id=${job.id}" class="btn btn-sm btn-outline-warning" title="Sửa"><i class="fas fa-edit"></i></a>
                                        
                                        <c:if test="${job.status == 'OPEN'}">
                                            <form action="hide" method="post" style="display:inline;">
                                                <input type="hidden" name="id" value="${job.id}">
                                                <button type="submit" class="btn btn-sm btn-outline-secondary" title="Ẩn tin"><i class="fas fa-eye-slash"></i></button>
                                            </form>
                                        </c:if>
                                        <c:if test="${job.status == 'HIDDEN'}">
                                            <form action="publish" method="post" style="display:inline;">
                                                <input type="hidden" name="id" value="${job.id}">
                                                <button type="submit" class="btn btn-sm btn-outline-success" title="Mở lại"><i class="fas fa-check"></i></button>
                                            </form>
                                        </c:if>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty jobs}">
                            <tr><td colspan="6" class="text-center py-4">Không tìm thấy tin tuyển dụng nào.</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>