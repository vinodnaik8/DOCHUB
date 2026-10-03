package controller;

import java.io.IOException;

import dao.DocumentDAO;
import dao.NoteDAO;
import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.Admin;

@WebServlet("/AnalyticsServlet")
public class AnalyticsServlet extends HttpServlet{

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException,IOException{

        HttpSession session=request.getSession(false);

        if(session==null){

            response.sendRedirect("adminLogin.jsp");

            return;

        }

        Admin admin=(Admin)session.getAttribute("admin");

        if(admin==null){

            response.sendRedirect("adminLogin.jsp");

            return;

        }

        UserDAO userDAO=new UserDAO();
        DocumentDAO documentDAO=new DocumentDAO();
        NoteDAO noteDAO=new NoteDAO();

        request.setAttribute("users",
                userDAO.getAllUsers().size());

        request.setAttribute("documents",
                documentDAO.getAllDocuments().size());

        request.setAttribute("notes",
                noteDAO.getTotalNotes());

        request.setAttribute("publicDocs",
                documentDAO.getPublicDocumentCount());

        request.setAttribute("privateDocs",
                documentDAO.getPrivateDocumentCount());

        request.getRequestDispatcher("analytics.jsp")
        .forward(request,response);

    }

}