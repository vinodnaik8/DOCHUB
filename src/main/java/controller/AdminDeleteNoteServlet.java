package controller;

import java.io.IOException;

import dao.NoteDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Admin;

@WebServlet("/AdminDeleteNoteServlet")
public class AdminDeleteNoteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if(session == null){

            response.sendRedirect("adminLogin.jsp");
            return;

        }

        Admin admin = (Admin) session.getAttribute("admin");

        if(admin == null){

            response.sendRedirect("adminLogin.jsp");
            return;

        }

        int noteId = Integer.parseInt(request.getParameter("id"));

        NoteDAO dao = new NoteDAO();

        dao.deleteNote(noteId);

        response.sendRedirect("ManageNotesServlet");

    }

}