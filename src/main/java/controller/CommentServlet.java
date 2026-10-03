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

@WebServlet("/CommentServlet")
public class CommentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        User user = (User) session.getAttribute("user");

        if(user == null){

            response.sendRedirect("login.jsp");
            return;

        }

        int docId = Integer.parseInt(request.getParameter("docId"));

        String commentText = request.getParameter("comment");

        if(commentText == null || commentText.trim().isEmpty()){

            response.sendRedirect("PublicFeedServlet");
            return;

        }

        Comment comment = new Comment();

        comment.setUserId(user.getId());
        comment.setDocId(docId);
        comment.setComment(commentText.trim());

        CommentDAO dao = new CommentDAO();

        dao.addComment(comment);

        response.sendRedirect(
        	    "PublicFeedServlet#doc"+docId
        	);

    }

}