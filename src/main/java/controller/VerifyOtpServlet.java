package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/VerifyOtpServlet")
public class VerifyOtpServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        String userOtp = request.getParameter("otp");

        String sessionOtp = (String) session.getAttribute("otp");

        Long otpTime = (Long) session.getAttribute("otpTime");

        Integer attempts = (Integer) session.getAttribute("attempts");

        // If attempts is null, initialize it
        if (attempts == null) {
            attempts = 0;
        }

        // Check if OTP session exists
        if (sessionOtp == null || otpTime == null) {

            response.sendRedirect("forgotPassword.jsp?sessionExpired=1");
            return;

        }

        // Check OTP expiry (5 Minutes = 300000 milliseconds)

        long currentTime = System.currentTimeMillis();

        if ((currentTime - otpTime) > 300000) {

            session.removeAttribute("otp");
            session.removeAttribute("otpTime");
            session.removeAttribute("attempts");

            response.sendRedirect("forgotPassword.jsp?expired=1");
            return;

        }

        // Verify OTP

        if (sessionOtp.equals(userOtp)) {

            // OTP Verified Successfully

        	// OTP Verified Successfully

        	session.removeAttribute("otp");
        	session.removeAttribute("otpTime");
        	session.removeAttribute("attempts");

        	// Allow access to Reset Password page
        	session.setAttribute("otpVerified", true);

        	response.sendRedirect("resetPassword.jsp");

        } else {

            // Wrong OTP

            attempts++;

            session.setAttribute("attempts", attempts);

            if (attempts >= 3) {

                session.removeAttribute("otp");
                session.removeAttribute("otpTime");
                session.removeAttribute("attempts");

                response.sendRedirect("forgotPassword.jsp?newotp=1");

            } else {

                response.sendRedirect("verifyOtp.jsp?error=1&attempts=" + attempts);

            }

        }

    }

}