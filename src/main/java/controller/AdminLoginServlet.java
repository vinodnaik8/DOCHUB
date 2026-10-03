package controller;

import java.io.IOException;

import dao.AdminDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.Admin;

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        AdminDAO dao = new AdminDAO();

        Admin admin = dao.loginAdmin(username, password);

        if (admin != null) {

            HttpSession session = request.getSession(true);

            session.setAttribute("admin", admin);

            response.sendRedirect("AdminDashboardServlet");

        } else {

            // IMPORTANT:
            // Return to the SAME login.jsp,
            // not adminLogin.jsp
            response.sendRedirect("login.jsp?adminError=1");
        }
    }
}