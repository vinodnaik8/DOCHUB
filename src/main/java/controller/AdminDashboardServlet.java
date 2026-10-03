package controller;

import java.io.IOException;

import dao.DocumentDAO;
import dao.NoteDAO;
import dao.UserDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.Admin;

@WebServlet("/AdminDashboardServlet")
public class AdminDashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        /* ==============================
           GET EXISTING SESSION
           ============================== */

        HttpSession session = request.getSession(false);

        /*
         * If there is no session,
         * send user to the MAIN DOCHUB login page.
         */
        if (session == null) {

            response.sendRedirect("login.jsp");
            return;
        }


        /* ==============================
           GET ADMIN FROM SESSION
           ============================== */

        Admin admin =
                (Admin) session.getAttribute("admin");


        /*
         * Admin session not found.
         * Send to MAIN login page.
         */
        if (admin == null) {

            response.sendRedirect("login.jsp");
            return;
        }


        /* ==============================
           DAO
           ============================== */

        UserDAO userDAO =
                new UserDAO();

        DocumentDAO documentDAO =
                new DocumentDAO();

        NoteDAO noteDAO =
                new NoteDAO();


        /* ==============================
           DASHBOARD STATISTICS
           ============================== */

        int totalUsers =
                userDAO.getAllUsers().size();

        int totalDocuments =
                documentDAO.getAllDocuments().size();

        int totalNotes =
                noteDAO.getTotalNotes();


        /* ==============================
           SEND DATA TO JSP
           ============================== */

        request.setAttribute(
                "totalUsers",
                totalUsers
        );

        request.setAttribute(
                "totalDocuments",
                totalDocuments
        );

        request.setAttribute(
                "totalNotes",
                totalNotes
        );

        request.setAttribute(
                "admin",
                admin
        );


        /* ==============================
           OPEN ADMIN DASHBOARD
           ============================== */

        request.getRequestDispatcher(
                "adminDashboard.jsp"
        ).forward(request, response);

    }
}