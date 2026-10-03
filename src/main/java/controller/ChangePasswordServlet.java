package controller;

import java.io.IOException;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.User;

@WebServlet("/ChangePasswordServlet")
public class ChangePasswordServlet extends HttpServlet{

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException,IOException{

        HttpSession session=request.getSession();

        User user=(User)session.getAttribute("user");

        if(user==null){

            response.sendRedirect("login.jsp");

            return;

        }

        String oldPassword=request.getParameter("oldPassword");
        String newPassword=request.getParameter("newPassword");

        UserDAO dao=new UserDAO();

        boolean status=dao.changePassword(
                user.getId(),
                oldPassword,
                newPassword);

        if(status){

            response.sendRedirect("settings.jsp?success=1");

        }else{

            response.sendRedirect("settings.jsp?error=1");

        }

    }

}