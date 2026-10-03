package controller;

import java.io.IOException;
import java.util.List;

import dao.NoteDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.Admin;
import model.Note;

@WebServlet("/ManageNotesServlet")
public class ManageNotesServlet extends HttpServlet{

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

        NoteDAO dao=new NoteDAO();

        List<Note> notes=dao.getAllNotes();

        request.setAttribute("notes",notes);

        request.getRequestDispatcher("manageNotes.jsp")
        .forward(request,response);

    }

}