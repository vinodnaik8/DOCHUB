package controller;

import java.io.IOException;
import java.util.List;

import dao.DocumentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Document;
import model.User;

@WebServlet("/PublicFeedServlet")
public class PublicFeedServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
                          throws ServletException, IOException {

        /* ================= SESSION ================= */

        HttpSession session = request.getSession(false);

        if (session == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }


        /* ================= DAO ================= */

        DocumentDAO dao = new DocumentDAO();


        /* ================= SEARCH ================= */

        String keyword = request.getParameter("search");

        List<Document> documents;


        if (keyword != null && !keyword.trim().isEmpty()) {

            /*
             * Search must also respect account visibility.
             */
            documents = dao.searchDocuments(
                    keyword.trim(),
                    user.getId()
            );

        } else {

            /*
             * Community documents must respect:
             *
             * PUBLIC account  -> everyone
             * PRIVATE account -> followers only
             */
            documents = dao.getPublicDocuments(
                    user.getId()
            );
        }


        /* ================= SEND DATA ================= */

        request.setAttribute(
                "documents",
                documents
        );


        /* ================= OPEN COMMUNITY ================= */

        request.getRequestDispatcher("publicFeed.jsp")
               .forward(request, response);
    }
}