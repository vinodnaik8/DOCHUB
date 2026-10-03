package controller;

import java.io.IOException;

import dao.AdminDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.Admin;

@WebServlet("/AdminChangePasswordServlet")
public class AdminChangePasswordServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        /* ==========================
           GET SESSION
           ========================== */

        HttpSession session =
                request.getSession(false);

        if (session == null) {

            response.sendRedirect("login.jsp");
            return;
        }


        /* ==========================
           GET ADMIN
           ========================== */

        Admin admin =
                (Admin) session.getAttribute("admin");

        if (admin == null) {

            response.sendRedirect("login.jsp");
            return;
        }


        /* ==========================
           GET FORM DATA
           ========================== */

        String oldPassword =
                request.getParameter("oldPassword");

        String newPassword =
                request.getParameter("newPassword");


        /* ==========================
           VALIDATION
           ========================== */

        if (oldPassword == null ||
            oldPassword.trim().isEmpty() ||
            newPassword == null ||
            newPassword.trim().isEmpty()) {

            response.sendRedirect(
                    "AdminSettingsServlet?error=empty"
            );

            return;
        }


        /* ==========================
           CHANGE PASSWORD
           ========================== */

        AdminDAO dao =
                new AdminDAO();

        boolean status =
                dao.changePassword(
                        admin.getAdminId(),
                        oldPassword,
                        newPassword
                );


        /* ==========================
           RESULT
           ========================== */

        if (status) {

            /*
             * Update password in the session
             * object also.
             */
            admin.setPassword(newPassword);

            session.setAttribute(
                    "admin",
                    admin
            );

            response.sendRedirect(
                    "AdminSettingsServlet?success=1"
            );

        } else {

            response.sendRedirect(
                    "AdminSettingsServlet?error=wrong"
            );
        }
    }
}