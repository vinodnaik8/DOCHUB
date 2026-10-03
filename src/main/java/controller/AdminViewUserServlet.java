package controller;

import java.io.IOException;
import java.util.List;

import dao.DocumentDAO;
import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Admin;
import model.Document;
import model.User;

@WebServlet("/AdminViewUserServlet")
public class AdminViewUserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if(session == null){

            response.sendRedirect("adminLogin.jsp");
            return;

        }

        Admin admin = (Admin) session.getAttribute("admin");

        if(admin == null){

            response.sendRedirect("adminLogin.jsp");
            return;

        }

        int userId =
        Integer.parseInt(request.getParameter("id"));

        UserDAO userDAO = new UserDAO();

        DocumentDAO documentDAO = new DocumentDAO();

        User user = userDAO.getUserById(userId);

        List<Document> documents =
        documentDAO.getPublicDocumentsByUser(userId);

        request.setAttribute("profileUser", user);

        request.setAttribute("documents", documents);

        request.getRequestDispatcher("adminUserProfile.jsp")
        .forward(request, response);

    }

}