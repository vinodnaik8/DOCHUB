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

@WebServlet("/SearchServlet")
public class SearchServlet extends HttpServlet {

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

        String keyword = request.getParameter("keyword");

        DocumentDAO dao = new DocumentDAO();

        List<Document> list =
                dao.searchDocuments(keyword, user.getId());

        request.setAttribute("documents", list);

        request.getRequestDispatcher("publicFeed.jsp")
               .forward(request, response);

    }

}