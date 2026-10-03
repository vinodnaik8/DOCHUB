package controller;

import java.io.IOException;
import java.util.List;

import dao.DocumentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Document;
import model.User;

@WebServlet("/MyFilesServlet")
public class MyFilesServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        User user = (User) session.getAttribute("user");

        if (user == null) {

            response.sendRedirect("login.jsp");

            return;

        }

        DocumentDAO dao = new DocumentDAO();

        List<Document> documents = dao.getDocumentsByUser(user.getId());

        request.setAttribute("documents", documents);

        request.getRequestDispatcher("myfiles.jsp")
                .forward(request, response);

    }

}