package controller;

import java.io.IOException;

import dao.NoteDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Note;
import model.User;

@WebServlet("/ArchiveNoteServlet")
public class ArchiveNoteServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        User user = (User) session.getAttribute("user");

        if(user == null){

            response.sendRedirect("login.jsp");
            return;

        }

        int noteId = Integer.parseInt(request.getParameter("id"));

        NoteDAO dao = new NoteDAO();

        // Get note before updating (to know if it is archived or active)
        Note note = dao.getNoteById(noteId);

        if(note == null){

            response.sendRedirect("NotesServlet");
            return;

        }

        boolean status = dao.archiveNote(noteId, user.getId());

        if(status){

            if(note.isArchived()){

                // It was archived, now restored
                response.sendRedirect("NotesServlet?success=restore");

            }else{

                // It was active, now archived
                response.sendRedirect("ArchivedNotesServlet?success=archive");

            }

        }else{

            response.sendRedirect("NotesServlet?error=archive");

        }

    }

}