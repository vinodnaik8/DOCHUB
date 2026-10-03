package controller;

import java.io.IOException;
import java.util.List;

import dao.DocumentDAO;
import dao.NoteDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Document;
import model.User;

@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        User user = (User) session.getAttribute("user");

        if(user == null){

            response.sendRedirect("login.jsp");
            return;

        }

        DocumentDAO documentDAO = new DocumentDAO();
        NoteDAO noteDAO = new NoteDAO();

        List<Document> documents =
                documentDAO.getDocumentsByUser(user.getId());

        int totalDocuments = documents.size();

        // Until we create DAO methods
        int publicDocuments = 0;
        int privateDocuments = 0;

        for(Document d : documents){

            if("PUBLIC".equalsIgnoreCase(d.getVisibility())){

                publicDocuments++;

            }else{

                privateDocuments++;

            }

        }

        int notesCount =
                noteDAO.getNotesByUser(user.getId()).size();

        // Temporary values
        int likesReceived = 0;
        int downloads = 0;
        int followers = 0;
        int following = 0;

        request.setAttribute("profile", user);

        request.setAttribute("documents", documents);

        request.setAttribute("totalDocuments", totalDocuments);

        request.setAttribute("publicDocuments", publicDocuments);

        request.setAttribute("privateDocuments", privateDocuments);

        request.setAttribute("notesCount", notesCount);

        request.setAttribute("likesReceived", likesReceived);

        request.setAttribute("downloads", downloads);

        request.setAttribute("followers", followers);

        request.setAttribute("following", following);

        request.getRequestDispatcher("profile.jsp")
               .forward(request, response);

    }

}