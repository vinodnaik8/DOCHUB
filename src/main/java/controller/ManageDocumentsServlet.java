package controller;

import java.io.IOException;
import java.util.List;

import dao.DocumentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Admin;
import model.Document;

@WebServlet("/ManageDocumentsServlet")
public class ManageDocumentsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if(session == null){

            response.sendRedirect("adminLogin.jsp");
            return;

        }

        Admin admin = (Admin)session.getAttribute("admin");

        if(admin == null){

            response.sendRedirect("adminLogin.jsp");
            return;

        }

        DocumentDAO dao = new DocumentDAO();

        List<Document> documents = dao.getAllDocuments();

        request.setAttribute("documents", documents);

        request.getRequestDispatcher("manageDocuments.jsp")
               .forward(request, response);

    }

}
