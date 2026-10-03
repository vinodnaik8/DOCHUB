package controller;

import java.io.IOException;

import dao.AdminDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.Admin;

@WebServlet("/ChangeAdminPasswordServlet")
public class ChangeAdminPasswordServlet extends HttpServlet{

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException,IOException{

        HttpSession session=request.getSession();

        Admin admin=(Admin)session.getAttribute("admin");

        if(admin==null){

            response.sendRedirect("adminLogin.jsp");

            return;

        }

        String oldPassword=request.getParameter("oldPassword");
        String newPassword=request.getParameter("newPassword");

        AdminDAO dao=new AdminDAO();

        boolean status=
                dao.changePassword(
                        admin.getAdminId(),
                        oldPassword,
                        newPassword
                );

        if(status){

            response.sendRedirect(
                    "AdminSettingsServlet?success=1"
            );

        }else{

            response.sendRedirect(
                    "AdminSettingsServlet?error=1"
            );

        }

    }

}