package controller;

import java.io.IOException;

import dao.DocumentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Document;
import model.User;

@WebServlet("/EditDocumentServlet")
public class EditDocumentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
                          throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String id = request.getParameter("id");

        if (id == null || id.trim().isEmpty()) {
            response.sendRedirect("MyFilesServlet");
            return;
        }

        int docId;

        try {
            docId = Integer.parseInt(id);
        } catch (NumberFormatException e) {
            response.sendRedirect("MyFilesServlet");
            return;
        }

        DocumentDAO dao = new DocumentDAO();

        Document document = dao.getDocumentById(docId);

        // Security check
        if (document == null ||
            document.getUserId() != user.getId()) {

            response.sendRedirect("MyFilesServlet");
            return;
        }

        request.setAttribute("document", document);

        request.getRequestDispatcher("editDocument.jsp")
               .forward(request, response);
    }
}