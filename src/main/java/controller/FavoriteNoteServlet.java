package controller;

import java.io.IOException;

import dao.NoteDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

@WebServlet("/FavoriteNoteServlet")
public class FavoriteNoteServlet extends HttpServlet {

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

        boolean status = dao.favoriteNote(noteId, user.getId());

        if(status){

            response.sendRedirect("NotesServlet?success=favorite");

        }else{

            response.sendRedirect("NotesServlet?error=favorite");

        }

    }

}