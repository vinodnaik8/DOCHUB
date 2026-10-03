package controller;

import java.io.IOException;

import dao.CommentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Comment;
import model.User;

@WebServlet("/DeleteCommentServlet")
public class DeleteCommentServlet extends HttpServlet {

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

        int commentId = Integer.parseInt(request.getParameter("id"));

        CommentDAO dao = new CommentDAO();

        // Get comment before deleting
        Comment comment = dao.getCommentById(commentId);

        if(comment != null){

            dao.deleteComment(commentId, user.getId());

            response.sendRedirect(
                    "PublicFeedServlet#doc" + comment.getDocId()
            );

        }else{

            response.sendRedirect("PublicFeedServlet");

        }

    }

}