package controller;

import java.io.IOException;

import dao.DocumentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/DeleteDocumentServlet")
public class DeleteDocumentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        int docId = Integer.parseInt(request.getParameter("id"));

        DocumentDAO dao = new DocumentDAO();

        dao.deleteDocument(docId);

        response.sendRedirect("ManageDocumentsServlet");

    }

}