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

@WebServlet("/ResendOtpServlet")
public class ResendOtpServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        String email = (String) session.getAttribute("email");

        if (email == null) {

            response.sendRedirect("forgotPassword.jsp");
            return;

        }

        UserDAO dao = new UserDAO();

        User user = dao.getUserByEmail(email);

        if (user == null) {

            response.sendRedirect("forgotPassword.jsp?error=email");
            return;

        }

        // Generate New OTP
        Random random = new Random();

        int otp = 100000 + random.nextInt(900000);

        // Store New OTP
        session.setAttribute("otp", String.valueOf(otp));
        session.setAttribute("otpTime", System.currentTimeMillis());
        session.setAttribute("attempts", 0);

        boolean status = EmailUtility.sendOTP(email, String.valueOf(otp));

        if (status) {

            response.sendRedirect("verifyOtp.jsp?resent=1");

        } else {

            response.sendRedirect("verifyOtp.jsp?error=mail");

        }

    }

}