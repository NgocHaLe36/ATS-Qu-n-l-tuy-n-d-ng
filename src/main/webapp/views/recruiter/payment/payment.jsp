<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh toán dịch vụ - ATS Recruiter</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    
    <style>
        :root { --primary-blue: #007bff; --bg-light: #f8fbff; --sidebar-width: 280px; }
        body { font-family: 'Inter', sans-serif; background-color: var(--bg-light); color: #333; margin: 0; }
        
        /* Sidebar layout đồng nhất Dashboard */
        .admin-sidebar { width: var(--sidebar-width); height: 100vh; position: fixed; top: 0; left: 0; background: #fff; border-right: 1px solid #eee; overflow-y: auto; z-index: 1000; display: flex; flex-direction: column; }
        .sidebar-brand { padding: 20px; border-bottom: 1px solid #eee; }
        .sidebar-brand a { text-decoration: none !important; }
        .sidebar-menu { padding: 15px 10px; list-style: none; margin: 0; flex-grow: 1; }
        .sidebar-menu-title { font-size: 0.75rem; text-transform: uppercase; font-weight: 700; color: #999; margin: 20px 0 10px 15px; letter-spacing: 0.5px; }
        .sidebar-link { display: flex; align-items: center; padding: 12px 15px; color: #555; text-decoration: none; font-weight: 500; border-radius: 10px; transition: 0.3s; margin-bottom: 5px; }
        .sidebar-link:hover, .sidebar-link.active { background-color: rgba(0, 123, 255, 0.08); color: var(--primary-blue); font-weight: 700; }
        .sidebar-link i { margin-right: 12px; font-size: 1.2rem; }
        
        .logout-area { padding: 20px; border-top: 1px solid #eee; margin-top: auto; }

        /* Main Content */
        .admin-main { margin-left: var(--sidebar-width); min-height: 100vh; }
        .admin-header { background: #fff; padding: 15px 30px; border-bottom: 1px solid #eee; display: flex; justify-content: space-between; align-items: center; }

        /* Checkout Box */
        .checkout-container { max-width: 1050px; margin: 30px auto; background: white; border-radius: 20px; overflow: hidden; box-shadow: 0 10px 30px rgba(0,0,0,0.05); border: 1px solid #e2e8f0; }
        .order-summary { background: #f8fafc; padding: 35px; border-right: 1px solid #e2e8f0; }
        .payment-methods { padding: 35px; }
        
        .method-item { border: 2px solid #f1f5f9; border-radius: 15px; padding: 15px; cursor: pointer; transition: 0.3s; margin-bottom: 12px; position: relative; }
        .method-item.active { border-color: var(--primary-blue); background: #f0f7ff; }
        
        .info-form { display: none; padding: 18px; background: #ffffff; border: 1px solid #dee2e6; border-radius: 12px; margin-bottom: 16px; border-left: 5px solid var(--primary-blue); }
        .info-form.active { display: block; }

        .bank-grid { display: grid; grid-template-columns: repeat(5, 1fr); gap: 8px; margin-bottom: 15px; }
        .bank-item { border: 1px solid #eee; padding: 8px; border-radius: 8px; text-align: center; cursor: pointer; font-size: 0.7rem; font-weight: bold; background: #fff; }
        .bank-item.selected { border-color: var(--primary-blue); background: #eef6ff; color: var(--primary-blue); }

        .company-bank-box { background: #fff9db; border: 1px dashed #f59f00; padding: 15px; border-radius: 10px; margin-bottom: 15px; }
    </style>
</head>
<body>
    <aside class="admin-sidebar shadow-sm">
        <div class="sidebar-brand">
            <%-- Logo quay lại Dashboard --%>
            <a href="${pageContext.request.contextPath}/recruiter/dashboard" class="d-flex align-items-center">
                <i class="bi bi-rocket-takeoff-fill text-primary me-2 fs-3"></i>
                <span class="fw-bold fs-4 text-primary">ATS Recruiter</span>
            </a>
        </div>
        <ul class="sidebar-menu">
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/dashboard" class="sidebar-link"><i class="bi bi-grid-1x2-fill"></i> Tổng quan</a></li>
            <div class="sidebar-menu-title">Tuyển dụng</div>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/jobs/create" class="sidebar-link"><i class="bi bi-plus-circle"></i> Đăng tin mới</a></li>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/jobs" class="sidebar-link"><i class="bi bi-file-earmark-text"></i> Quản lý tin đăng</a></li>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/pipeline" class="sidebar-link"><i class="bi bi-people"></i> Danh sách ứng viên</a></li>
            <div class="sidebar-menu-title">Tài khoản & Dịch vụ</div>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/vip/plans" class="sidebar-link active"><i class="bi bi-gem"></i> Gói dịch vụ VIP</a></li>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/payment/history" class="sidebar-link"><i class="bi bi-credit-card"></i> Lịch sử thanh toán</a></li>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/account/profile" class="sidebar-link"><i class="bi bi-person-gear"></i> Hồ sơ công ty</a></li>
            <div class="sidebar-menu-title">Cá nhân</div>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/account/change-password" class="sidebar-link"><i class="bi bi-key"></i> Đổi mật khẩu</a></li>
        </ul>
        <div class="logout-area">
            <a href="${pageContext.request.contextPath}/auth/logout" class="sidebar-link text-danger bg-danger bg-opacity-10 py-2">
                <i class="bi bi-box-arrow-right me-2"></i> Đăng xuất
            </a>
        </div>
    </aside>

    <main class="admin-main">
        <header class="admin-header sticky-top shadow-sm">
            <div class="d-flex align-items-center">
                <a href="javascript:history.back()" class="btn btn-link text-dark p-0 me-3"><i class="bi bi-arrow-left fs-4"></i></a>
                <h5 class="fw-bold mb-0">Thanh toán đơn hàng</h5>
            </div>
            <div class="d-flex align-items-center">
                <span class="fw-bold small me-2 text-muted">${currentUser.fullName}</span>
                <div class="bg-primary text-white rounded-circle d-flex align-items-center justify-content-center fw-bold" style="width: 35px; height: 35px; font-size: 0.8rem;">
                    ${currentUser.fullName.substring(0,2).toUpperCase()}
                </div>
            </div>
        </header>

        <div class="container-fluid p-4">
            <div class="checkout-container">
                <form action="${pageContext.request.contextPath}/recruiter/payment/process" method="POST" id="paymentForm">
                    <input type="hidden" name="subscriptionId" value="${subscription.id}">
                    <input type="hidden" name="selectedBank" id="selectedBank" value="">

                    <div class="row g-0">
                        <div class="col-lg-5 order-summary">
                            <h5 class="fw-bold mb-4 text-dark text-uppercase small letter-spacing-1">Chi tiết gói dịch vụ</h5>
                            <div class="p-4 bg-white rounded-4 border shadow-sm mb-4">
                                <h3 class="fw-bold text-primary mb-1">${subscription.plan.name}</h3>
                                <p class="text-muted small mb-3">Thời hạn: ${subscription.plan.durationDays} ngày</p>
                                <div class="fs-2 fw-bold text-dark">
                                    <fmt:formatNumber value="${subscription.plan.price}" type="number"/> ₫
                                </div>
                            </div>
                            <ul class="list-unstyled small text-muted">
                                <li class="mb-2"><i class="bi bi-patch-check-fill text-success me-2"></i>Đăng tin ưu tiên lên đầu trang</li>
                                <li class="mb-2"><i class="bi bi-patch-check-fill text-success me-2"></i>Mở khóa AI lọc hồ sơ thông minh</li>
                                <li class="mb-2"><i class="bi bi-patch-check-fill text-success me-2"></i>Hỗ trợ nhà tuyển dụng 24/7</li>
                            </ul>
                        </div>

                        <div class="col-lg-7 payment-methods">
                            <h5 class="fw-bold mb-4">Phương thức thanh toán</h5>

                            <label class="method-item d-flex align-items-center w-100" data-target="form-momo">
                                <input type="radio" name="paymentMethod" value="MOMO" class="d-none">
                                <img src="https://upload.wikimedia.org/wikipedia/vi/f/fe/MoMo_Logo.png" width="40" class="me-3 rounded">
                                <span class="fw-bold flex-grow-1">Ví điện tử MoMo</span>
                                <i class="bi bi-circle text-muted fs-4"></i>
                            </label>
                            <div id="form-momo" class="info-form">
                                <label class="small fw-bold mb-2">Số điện thoại đăng ký MoMo</label>
                                <input type="text" name="momo_phone" class="form-control" placeholder="09xx xxx xxx">
                            </div>

                            <label class="method-item d-flex align-items-center w-100" data-target="form-vnpay">
                                <input type="radio" name="paymentMethod" value="VNPAY" class="d-none">
                                <img src="https://vnpay.vn/wp-content/uploads/2020/07/vnpay-logo.png" width="40" class="me-3 rounded">
                                <span class="fw-bold flex-grow-1">Cổng VNPAY (ATM Nội địa)</span>
                                <i class="bi bi-circle text-muted fs-4"></i>
                            </label>
                            <div id="form-vnpay" class="info-form">
                                <label class="small fw-bold mb-2 text-primary">Chọn ngân hàng của bạn:</label>
                                <div class="bank-grid">
                                    <div class="bank-item" data-bank="Vietcombank">VCB</div>
                                    <div class="bank-item" data-bank="MBBank">MB</div>
                                    <div class="bank-item" data-bank="Techcombank">TCB</div>
                                    <div class="bank-item" data-bank="Vietinbank">VTB</div>
                                    <div class="bank-item" data-bank="BIDV">BIDV</div>
                                    <div class="bank-item" data-bank="Agribank">AGR</div>
                                    <div class="bank-item" data-bank="TPBank">TPB</div>
                                    <div class="bank-item" data-bank="VPBank">VPB</div>
                                    <div class="bank-item" data-bank="ACB">ACB</div>
                                    <div class="bank-item" data-bank="Sacombank">STB</div>
                                    <div class="bank-item" data-bank="HDBank">HDB</div>
                                    <div class="bank-item" data-bank="VIB">VIB</div>
                                    <div class="bank-item" data-bank="OCB">OCB</div>
                                    <div class="bank-item" data-bank="Eximbank">EIB</div>
                                    <div class="bank-item" data-bank="SHB">SHB</div>
                                </div>
                                <input type="text" name="vnpay_card" class="form-control mb-2" placeholder="Số thẻ: 9704 xxxx xxxx xxxx">
                                <input type="text" name="vnpay_name" class="form-control" placeholder="Tên chủ thẻ: NGUYEN PHUOC BAO">
                            </div>

                            <label class="method-item d-flex align-items-center w-100" data-target="form-bank">
                                <input type="radio" name="paymentMethod" value="BANK" class="d-none">
                                <div class="bg-light p-2 rounded me-3 shadow-sm"><i class="bi bi-bank2 text-primary"></i></div>
                                <span class="fw-bold flex-grow-1">Chuyển khoản trực tiếp</span>
                                <i class="bi bi-circle text-muted fs-4"></i>
                            </label>
                            <div id="form-bank" class="info-form">
                                <div class="company-bank-box text-center shadow-sm">
                                    <p class="mb-1 small fw-bold text-muted">TÀI KHOẢN THỤ HƯỞNG (ATS)</p>
                                    <h5 class="fw-bold text-dark mb-1">NGUYEN PHUOC BAO</h5>
                                    <h4 class="fw-bold text-primary mb-1">1234 5678 9999</h4>
                                    <p class="mb-0 small">Ngân hàng: <strong>MB BANK - Chi nhánh HCM</strong></p>
                                </div>
                                <label class="small fw-bold">Số tài khoản GỬI TIỀN của bạn (để đối soát)</label>
                                <input type="text" name="bank_sender_acc" class="form-control" placeholder="Nhập STK bạn dùng để chuyển">
                            </div>

                            <button type="submit" class="btn btn-primary w-100 py-3 rounded-pill fw-bold shadow mt-4 border-0">
                                <i class="bi bi-shield-lock-fill me-2"></i>XÁC NHẬN THANH TOÁN
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </main>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            $('.method-item').click(function() {
                $('.method-item').removeClass('active').find('i').attr('class', 'bi bi-circle text-muted fs-4');
                $('.info-form').removeClass('active');
                $(this).addClass('active').find('i').attr('class', 'bi bi-check-circle-fill text-primary fs-4');
                $(this).find('input').prop('checked', true);
                var target = $(this).data('target');
                $('#' + target).addClass('active');
                
                if(target !== 'form-vnpay') {
                    $('#selectedBank').val('');
                    $('.bank-item').removeClass('selected');
                }
            });

            $('.bank-item').click(function() {
                $('.bank-item').removeClass('selected');
                $(this).addClass('selected');
                $('#selectedBank').val($(this).data('bank'));
            });
        });
    </script>
</body>
</html>