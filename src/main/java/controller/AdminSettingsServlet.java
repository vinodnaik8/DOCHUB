package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.Admin;

@WebServlet("/AdminSettingsServlet")
public class AdminSettingsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        /* ==========================
           CHECK SESSION
           ========================== */

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
           SEND ADMIN TO JSP
           ========================== */

        request.setAttribute(
                "admin",
                admin
        );


        /* ==========================
           OPEN SETTINGS
           ========================== */

        request.getRequestDispatcher(
                "adminSettings.jsp"
        ).forward(request, response);

    }
}