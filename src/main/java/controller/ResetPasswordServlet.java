package controller;

import java.io.IOException;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/ResetPasswordServlet")
public class ResetPasswordServlet extends HttpServlet{

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException,IOException{

        String password=request.getParameter("password");
        String confirm=request.getParameter("confirmPassword");

        if(!password.equals(confirm)){

            response.sendRedirect("resetPassword.jsp?error=password");

            return;

        }

        HttpSession session=request.getSession();

        String email=(String)session.getAttribute("email");

        UserDAO dao=new UserDAO();

        boolean status=dao.resetPassword(email,password);

        if(status){

            // Remove all session data
            session.removeAttribute("otp");
            session.removeAttribute("email");
            session.removeAttribute("otpTime");
            session.removeAttribute("attempts");
            session.removeAttribute("otpVerified");

            response.sendRedirect("login.jsp?reset=success");

        }else{

            response.sendRedirect("resetPassword.jsp?error=1");

        }

    }

}