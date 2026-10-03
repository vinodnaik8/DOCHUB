package controller;

import java.io.IOException;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.User;

@WebServlet("/DeleteAccountServlet")
public class DeleteAccountServlet extends HttpServlet{

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException,IOException{

        HttpSession session=request.getSession();

        User user=(User)session.getAttribute("user");

        if(user!=null){

            UserDAO dao=new UserDAO();

            dao.deleteAccount(user.getId());

            session.invalidate();

        }

        response.sendRedirect("index.jsp");

    }

}