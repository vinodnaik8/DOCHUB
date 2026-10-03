package controller;

import java.io.IOException;
import java.util.List;

import dao.NoteDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Note;
import model.User;

@WebServlet("/NotesServlet")
public class NotesServlet extends HttpServlet {

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

        NoteDAO dao = new NoteDAO();
        int archivedCount = dao.getArchivedCount(user.getId());

        request.setAttribute("archivedCount", archivedCount);

        List<Note> notes = dao.getNotesByUser(user.getId());

        request.setAttribute("notes", notes);

        request.getRequestDispatcher("notes.jsp")
               .forward(request, response);

    }

}