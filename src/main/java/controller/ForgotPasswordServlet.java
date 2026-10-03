package controller;

import java.io.IOException;
import java.util.Random;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import util.EmailUtility;

@WebServlet("/ForgotPasswordServlet")
public class ForgotPasswordServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");

        UserDAO dao = new UserDAO();

        User user = dao.getUserByEmail(email);

        // Check if email exists
        if (user == null) {

            response.sendRedirect("forgotPassword.jsp?error=email");
            return;

        }

        // Generate 6-digit OTP
        Random random = new Random();
        int otp = 100000 + random.nextInt(900000);

        HttpSession session = request.getSession();

        // Store OTP details in session
        session.setAttribute("otp", String.valueOf(otp));
        session.setAttribute("email", email);
        session.setAttribute("otpTime", System.currentTimeMillis());
        session.setAttribute("attempts", 0);

        // Send OTP email
        boolean status = EmailUtility.sendOTP(email, String.valueOf(otp));

        if (status) {

            response.sendRedirect("verifyOtp.jsp");

        } else {

            response.sendRedirect("forgotPassword.jsp?mailerror=1");

        }

    }

}