package controller;

import java.io.IOException;
import java.util.List;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Admin;
import model.User;

@WebServlet("/ManageUsersServlet")
public class ManageUsersServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if(session==null){

            response.sendRedirect("adminLogin.jsp");
            return;

        }

        Admin admin=(Admin)session.getAttribute("admin");

        if(admin==null){

            response.sendRedirect("adminLogin.jsp");
            return;

        }

        UserDAO dao=new UserDAO();

        List<User> users=dao.getAllUsers();

        request.setAttribute("users",users);

        request.getRequestDispatcher("manageUsers.jsp")
        .forward(request,response);

    }

}