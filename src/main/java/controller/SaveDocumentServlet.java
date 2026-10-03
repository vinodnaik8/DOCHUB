package controller;

import java.io.IOException;

import dao.SaveDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.User;

@WebServlet("/SaveDocumentServlet")
public class SaveDocumentServlet extends HttpServlet{

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException,IOException{

        HttpSession session=request.getSession();

        User user=(User)session.getAttribute("user");

        if(user==null){

            response.sendRedirect("login.jsp");

            return;

        }

        int docId=Integer.parseInt(request.getParameter("id"));

        SaveDAO dao=new SaveDAO();

        if(dao.isSaved(user.getId(),docId)){

            dao.removeSaved(user.getId(),docId);

        }else{

            dao.saveDocument(user.getId(),docId);

        }

        response.sendRedirect("PublicFeedServlet");

    }

}