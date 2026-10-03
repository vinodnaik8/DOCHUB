package controller;

import java.io.IOException;
import java.util.List;

import dao.BookmarkDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Document;
import model.User;

@WebServlet("/MyBookmarksServlet")
public class MyBookmarksServlet extends HttpServlet {

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

        BookmarkDAO dao = new BookmarkDAO();

        List<Document> bookmarks =
                dao.getBookmarks(user.getId());

        request.setAttribute("bookmarks", bookmarks);

        request.getRequestDispatcher("bookmarks.jsp")
               .forward(request, response);

    }

}