package controller;

import java.io.IOException;

import dao.FollowDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

@WebServlet("/FollowServlet")
public class FollowServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
                          throws ServletException, IOException {

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

        String idParam = request.getParameter("id");

        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect("PublicFeedServlet");
            return;
        }

        int profileUserId;

        try {

            profileUserId = Integer.parseInt(idParam);

        } catch (NumberFormatException e) {

            response.sendRedirect("PublicFeedServlet");
            return;
        }

        // Cannot follow yourself
        if (user.getId() == profileUserId) {

            response.sendRedirect(
                "UserProfileServlet?id=" + profileUserId
            );

            return;
        }

        FollowDAO dao = new FollowDAO();

        // Toggle follow / unfollow
        if (dao.isFollowing(user.getId(), profileUserId)) {

            dao.unfollowUser(
                user.getId(),
                profileUserId
            );

        } else {

            dao.followUser(
                user.getId(),
                profileUserId
            );
        }

        response.sendRedirect(
            "UserProfileServlet?id=" + profileUserId
        );
    }
}