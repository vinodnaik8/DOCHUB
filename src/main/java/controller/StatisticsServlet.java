package controller;

import java.io.IOException;

import dao.StatisticsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/StatisticsServlet")
public class StatisticsServlet extends HttpServlet{

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException,IOException{

        HttpSession session = request.getSession();

        if(session.getAttribute("admin")==null){

            response.sendRedirect("adminLogin.jsp");

            return;

        }

        StatisticsDAO dao = new StatisticsDAO();

        request.setAttribute("users", dao.totalUsers());
        request.setAttribute("documents", dao.totalDocuments());
        request.setAttribute("notes", dao.totalNotes());
        request.setAttribute("publicDocs", dao.publicDocuments());
        request.setAttribute("privateDocs", dao.privateDocuments());

        request.getRequestDispatcher("statistics.jsp")
                .forward(request,response);

    }

}