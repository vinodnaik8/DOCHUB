package controller;

import java.io.IOException;

import dao.BookmarkDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

@WebServlet("/BookmarkServlet")
public class BookmarkServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        /* ================= SESSION USER ================= */

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

        /* ================= DOCUMENT ID ================= */

        String idParam = request.getParameter("id");

        if (idParam == null || idParam.trim().isEmpty()) {
            idParam = request.getParameter("docId");
        }

        /*
         * If no document ID was supplied,
         * do NOT execute BookmarkDAO.
         */
        if (idParam == null || idParam.trim().isEmpty()) {

            response.sendRedirect("PublicFeedServlet");
            return;
        }

        int docId;

        try {

            docId = Integer.parseInt(idParam.trim());

        } catch (NumberFormatException e) {

            response.sendRedirect("PublicFeedServlet");
            return;
        }

        /* ================= BOOKMARK ================= */

        BookmarkDAO dao = new BookmarkDAO();

        if (dao.isBookmarked(user.getId(), docId)) {

            dao.removeBookmark(user.getId(), docId);

        } else {

            dao.addBookmark(user.getId(), docId);
        }

        /* ================= RETURN LOCATION ================= */

        String source = request.getParameter("source");

        /*
         * Bookmark clicked from Community
         */
        if ("community".equalsIgnoreCase(source)) {

            response.sendRedirect("PublicFeedServlet");
            return;
        }

        /*
         * Bookmark clicked from Bookmarks page
         */
        if ("bookmark".equalsIgnoreCase(source)) {

            response.sendRedirect("BookmarksServlet");
            return;
        }

        /*
         * Default:
         * use the page from which the request came.
         */
        String referer = request.getHeader("Referer");

        if (referer != null && !referer.trim().isEmpty()) {

            response.sendRedirect(referer);

        } else {

            response.sendRedirect("PublicFeedServlet");
        }
    }
}