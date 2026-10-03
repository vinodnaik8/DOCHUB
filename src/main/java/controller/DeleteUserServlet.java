package controller;

import java.io.IOException;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/DeleteUserServlet")
public class DeleteUserServlet extends HttpServlet{

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException,IOException{

        int id=Integer.parseInt(request.getParameter("id"));

        UserDAO dao=new UserDAO();

        dao.deleteUser(id);

        response.sendRedirect("ManageUsersServlet");

    }

}