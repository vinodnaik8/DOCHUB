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

@WebServlet("/CreateNoteServlet")
public class CreateNoteServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        User user = (User) session.getAttribute("user");

        if (user == null) {

            response.sendRedirect("login.jsp");
            return;

        }

        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String color = request.getParameter("color");

        if(color == null || color.trim().isEmpty()){

            color = "#ffffff";

        }

        Note note = new Note();

        note.setUserId(user.getId());
        note.setTitle(title);
        note.setContent(content);
        note.setColor(color);

        NoteDAO dao = new NoteDAO();

        boolean status = dao.createNote(note);

        if(status){

            response.sendRedirect("NotesServlet?success=create");

        }else{

            response.sendRedirect("createNote.jsp?error=1");

        }

    }

}