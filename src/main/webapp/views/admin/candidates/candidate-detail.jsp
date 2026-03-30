<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết Ứng viên | ATS Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        :root { --sidebar-width: 280px; --primary-blue: #007bff; --bg-light: #f8fbff; }
        body { font-family: 'Inter', sans-serif; background-color: var(--bg-light); overflow-x: hidden; }
        .admin-main { margin-left: var(--sidebar-width); padding: 30px; }
        .admin-card { background: #fff; border: 1px solid #eee; border-radius: 15px; padding: 24px; box-shadow: 0 5px 15px rgba(0,0,0,0.02); margin-bottom: 20px; }
        .avatar-lg { width: 120px; height: 120px; border-radius: 50%; object-fit: cover; border: 4px solid #fff; box-shadow: 0 5px 15px rgba(0,0,0,0.1); }
        .nav-tabs .nav-link { border: none; color: #666; font-weight: 500; padding: 10px 20px; border-bottom: 2px solid transparent; }
        .nav-tabs .nav-link.active { color: var(--primary-blue); border-bottom-color: var(--primary-blue); background: transparent; }
    </style>
</head>
<body>


    <main class="admin-main">
        <div class="mb-4 d-flex align-items-center">
            <a href="candidate-list.jsp" class="btn btn-light rounded-circle me-3"><i class="bi bi-arrow-left"></i></a>
            <h4 class="fw-bold mb-0">Hồ sơ ứng viên</h4>
        </div>

        <div class="row g-4">
            <div class="col-lg-4">
                <div class="admin-card text-center">
                    <img src="https://ui-avatars.com/api/?name=Ngoc+Ha&size=200&background=007bff&color=fff" class="avatar-lg mb-3" alt="Avatar">
                    <h5 class="fw-bold mb-1">Nguyễn Ngọc Hà</h5>
                    <p class="text-muted small mb-3">Backend Developer</p>
                    <div class="d-flex justify-content-center gap-2 mb-4">
                        <span class="badge bg-success bg-opacity-10 text-success rounded-pill px-3 py-2">Hoạt động</span>
                    </div>
                    
                    <hr class="opacity-25">
                    
                    <div class="text-start">
                        <div class="mb-3">
                            <small class="text-muted d-block text-uppercase fw-bold mb-1" style="font-size: 0.7rem;">Thông tin liên hệ</small>
                            <div class="d-flex align-items-center mb-2"><i class="bi bi-envelope text-primary me-2"></i> ngocha@gmail.com</div>
                            <div class="d-flex align-items-center mb-2"><i class="bi bi-telephone text-primary me-2"></i> 0901 234 567</div>
                            <div class="d-flex align-items-center"><i class="bi bi-geo-alt text-primary me-2"></i> TP. Hồ Chí Minh</div>
                        </div>
                        <div class="mb-3">
                            <small class="text-muted d-block text-uppercase fw-bold mb-1" style="font-size: 0.7rem;">Kỹ năng</small>
                            <span class="badge bg-light text-dark border me-1 mb-1">Java</span>
                            <span class="badge bg-light text-dark border me-1 mb-1">SQL Server</span>
                            <span class="badge bg-light text-dark border me-1 mb-1">ERD Design</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-8">
                <div class="admin-card p-0 overflow-hidden">
                    <ul class="nav nav-tabs px-4 pt-3 bg-light border-bottom" id="candidateTabs">
                        <li class="nav-item">
                            <a class="nav-link active" data-bs-toggle="tab" href="#overview">Tổng quan CV</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" data-bs-toggle="tab" href="#history">Lịch sử ứng tuyển</a>
                        </li>
                    </ul>

                    <div class="tab-content p-4">
                        <div class="tab-pane fade show active" id="overview">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <h6 class="fw-bold"><i class="bi bi-file-earmark-pdf text-danger me-2"></i> CV Đính kèm</h6>
                                <button class="btn btn-sm btn-outline-primary rounded-pill"><i class="bi bi-download me-1"></i> Tải xuống</button>
                            </div>
                            <div class="bg-light rounded p-4 text-center border">
                                <i class="bi bi-file-earmark-text text-muted" style="font-size: 3rem;"></i>
                                <p class="text-muted mt-2">Ngocha_Backend_CV.pdf</p>
                            </div>
                            
                            <h6 class="fw-bold mt-4 mb-3">Học vấn & Bằng cấp</h6>
                            <div class="d-flex mb-3">
                                <div class="me-3 text-primary"><i class="bi bi-mortarboard fs-5"></i></div>
                                <div>
                                    <h6 class="mb-1 fw-bold">Cử nhân Công nghệ Thông tin</h6>
                                    <p class="text-muted small mb-0">Đại học Khoa học Tự nhiên TP.HCM (2018 - 2022)</p>
                                </div>
                            </div>
                        </div>

                        <div class="tab-pane fade" id="history">
                            <div class="table-responsive">
                                <table class="table align-middle">
                                    <thead class="bg-light small text-muted">
                                        <tr>
                                            <th>Công việc</th>
                                            <th>Nhà tuyển dụng</th>
                                            <th>Ngày nộp</th>
                                            <th>Điểm AI</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td class="fw-bold">Senior Java Web Developer</td>
                                            <td>TechFlow Inc.</td>
                                            <td>18/03/2026</td>
                                            <td><span class="badge bg-success">92/100</span></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>