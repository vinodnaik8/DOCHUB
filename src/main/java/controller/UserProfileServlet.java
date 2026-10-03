package controller;

import java.io.IOException;
import java.util.List;

import dao.DocumentDAO;
import dao.FollowDAO;
import dao.LikeDAO;
import dao.NoteDAO;
import dao.UserDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.Document;
import model.User;

@WebServlet("/UserProfileServlet")
public class UserProfileServlet extends HttpServlet {

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

        User loginUser = (User) session.getAttribute("user");

        if (loginUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }


        /* ================= PROFILE USER ID ================= */

        String idParam = request.getParameter("id");

        if (idParam == null || idParam.trim().isEmpty()) {

            response.sendError(
                HttpServletResponse.SC_BAD_REQUEST,
                "User ID is missing."
            );

            return;
        }

        int profileUserId;

        try {

            profileUserId = Integer.parseInt(idParam.trim());

        } catch (NumberFormatException e) {

            response.sendError(
                HttpServletResponse.SC_BAD_REQUEST,
                "Invalid User ID."
            );

            return;
        }


        /* ================= GET PROFILE USER ================= */

        UserDAO userDAO = new UserDAO();

        User profileUser =
                userDAO.getUserById(profileUserId);

        if (profileUser == null) {

            response.sendRedirect("PublicFeedServlet");
            return;
        }


        /* ================= DAO ================= */

        DocumentDAO documentDAO = new DocumentDAO();
        NoteDAO noteDAO = new NoteDAO();
        LikeDAO likeDAO = new LikeDAO();
        FollowDAO followDAO = new FollowDAO();


        /* ================= FOLLOW STATUS ================= */

        boolean isOwnProfile =
                loginUser.getId() == profileUserId;

        boolean isFollowing =
                followDAO.isFollowing(
                    loginUser.getId(),
                    profileUserId
                );


        /* =====================================================
           ACCOUNT VISIBILITY
           ===================================================== */

        boolean canViewDocuments = false;

        if (isOwnProfile) {

            // Owner can always see own documents
            canViewDocuments = true;

        } else if ("PUBLIC".equalsIgnoreCase(
                        profileUser.getVisibility())) {

            // Public account → everyone can see
            canViewDocuments = true;

        } else if ("PRIVATE".equalsIgnoreCase(
                        profileUser.getVisibility())
                   && isFollowing) {

            // Private account → followers only
            canViewDocuments = true;
        }


        /* ================= DOCUMENTS ================= */

        List<Document> documents;

        if (canViewDocuments) {

            /*
             * Get ALL documents belonging to this user.
             * Document visibility is no longer used here.
             */
            documents =
                documentDAO.getDocumentsByUser(profileUserId);

        } else {

            /*
             * Private account and not following.
             * Don't expose documents.
             */
            documents =
                new java.util.ArrayList<Document>();
        }


        /* ================= FOLLOW INFORMATION ================= */

        int followers =
                followDAO.getFollowersCount(profileUserId);

        int following =
                followDAO.getFollowingCount(profileUserId);


        /* ================= STATISTICS ================= */

        int totalDocuments =
                documentDAO
                    .getDocumentsByUser(profileUserId)
                    .size();

        int publicDocuments =
                documentDAO
                    .getPublicDocumentsByUser(profileUserId)
                    .size();

        int privateDocuments =
                documentDAO
                    .getPrivateDocumentsByUser(profileUserId)
                    .size();

        int notesCount =
                noteDAO
                    .getNotesByUser(profileUserId)
                    .size();

        int likesReceived =
                likeDAO
                    .getLikesReceived(profileUserId);

        int downloads =
                documentDAO
                    .getTotalDownloads(profileUserId);


        /* ================= SEND DATA ================= */

        request.setAttribute(
            "profileUser",
            profileUser
        );

        request.setAttribute(
            "documents",
            documents
        );

        request.setAttribute(
            "followers",
            followers
        );

        request.setAttribute(
            "following",
            following
        );

        request.setAttribute(
            "isFollowing",
            isFollowing
        );

        request.setAttribute(
            "isOwnProfile",
            isOwnProfile
        );

        request.setAttribute(
            "canViewDocuments",
            canViewDocuments
        );

        request.setAttribute(
            "totalDocuments",
            totalDocuments
        );

        request.setAttribute(
            "publicDocuments",
            publicDocuments
        );

        request.setAttribute(
            "privateDocuments",
            privateDocuments
        );

        request.setAttribute(
            "notesCount",
            notesCount
        );

        request.setAttribute(
            "likesReceived",
            likesReceived
        );

        request.setAttribute(
            "downloads",
            downloads
        );


        /* ================= OPEN PROFILE ================= */

        request.getRequestDispatcher("profile.jsp")
               .forward(request, response);
    }
}