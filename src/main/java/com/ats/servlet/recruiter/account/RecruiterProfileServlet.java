package com.ats.servlet.recruiter.account;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.ats.dao.impl.SubscriptionDAOImpl;
import com.ats.dao.impl.UserDAOImpl; // Nhớ import cái này
import com.ats.entity.Subscription;
import com.ats.entity.User;

@WebServlet("/recruiter/account/profile")
public class RecruiterProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final SubscriptionDAOImpl subscriptionDAO = new SubscriptionDAOImpl();
    private final UserDAOImpl userDAO = new UserDAOImpl(); // Thêm DAO để update user

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User recruiter = getCurrentRecruiter(request, response);
        if (recruiter == null) return;

        Subscription activeSubscription = subscriptionDAO.findActiveByUserId(recruiter.getId());

        // Đảm bảo lấy dữ liệu mới nhất từ DB
        recruiter = userDAO.findById(recruiter.getId());

        request.setAttribute("recruiter", recruiter);
        request.setAttribute("activeSubscription", activeSubscription);
        request.getRequestDispatcher("/views/recruiter/account/profile.jsp").forward(request, response);
    }

    // --- BỔ SUNG PHƯƠNG THỨC DOPOST DƯỚI ĐÂY ---
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 1. Set tiếng Việt
        request.setCharacterEncoding("UTF-8");

        // 2. Kiểm tra quyền
        User sessionUser = getCurrentRecruiter(request, response);
        if (sessionUser == null) return;

        // 3. Lấy dữ liệu từ form JSP gửi lên
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        // Bạn có thể lấy thêm số điện thoại, địa chỉ nếu form có

        // Validation cơ bản (ví dụ)
        if (fullName == null || fullName.trim().isEmpty()) {
            request.setAttribute("error", "Tên người đại diện không được để trống.");
            doGet(request, response); // Quay lại trang profile và hiển thị lỗi
            return;
        }

        // 4. Lấy đối tượng User từ DB, cập nhật thông tin mới
        User recruiter = userDAO.findById(sessionUser.getId());
        recruiter.setFullName(fullName);
        recruiter.setEmail(email);
        // recruiter.setPhone(phone); // nếu có

     // 5. Gọi DAO để lưu xuống database
        User updatedUser = userDAO.update(recruiter);

        if (updatedUser != null) {
            // Cập nhật lại user trong session với dữ liệu mới nhất
            request.getSession().setAttribute("currentUser", updatedUser);
            request.setAttribute("success", "Cập nhật hồ sơ thành công!");
        } else {
            request.setAttribute("error", "Có lỗi xảy ra khi cập nhật. Vui lòng thử lại.");
        }

        // 6. Chuyển hướng về trang GET để hiển thị thông tin mới và thông báo
        doGet(request, response);
    }

    private User getCurrentRecruiter(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return null;
        }

        User user = (User) session.getAttribute("currentUser");
        if (user == null || !"recruiter".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return null;
        }
        return user;
    }
}