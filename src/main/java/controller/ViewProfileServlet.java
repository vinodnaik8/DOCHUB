package controller;

import java.io.IOException;
import java.util.List;

import dao.DocumentDAO;
import dao.ProfileDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.Document;
import model.User;

@WebServlet("/ViewProfileServlet")
public class ViewProfileServlet extends HttpServlet{

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException,IOException{

        int id = Integer.parseInt(request.getParameter("id"));

        ProfileDAO pdao = new ProfileDAO();

        User user = pdao.getPublicUser(id);

        if(user==null){

            response.sendRedirect("search.jsp");

            return;

        }

        DocumentDAO ddao = new DocumentDAO();

        List<Document> docs = ddao.getPublicDocumentsByUser(id);

        request.setAttribute("profile",user);

        request.setAttribute("documents",docs);

        request.getRequestDispatcher("viewProfile.jsp")
                .forward(request,response);

    }

}