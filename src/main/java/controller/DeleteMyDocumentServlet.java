package controller;

import java.io.File;
import java.io.IOException;

import dao.DocumentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Document;
import model.User;

@WebServlet("/DeleteMyDocumentServlet")
public class DeleteMyDocumentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private static final String UPLOAD_PATH = "C:\\DOCHUB_UPLOADS";

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        User user = (User) session.getAttribute("user");

        if (user == null) {

            response.sendRedirect("login.jsp");
            return;

        }

        int docId = Integer.parseInt(request.getParameter("id"));

        DocumentDAO dao = new DocumentDAO();

        Document doc = dao.getDocumentById(docId);

        if (doc != null && doc.getUserId() == user.getId()) {

            // Delete physical file
            File file = new File(UPLOAD_PATH + File.separator + doc.getFileName());

            if (file.exists()) {

                file.delete();

            }

            // Delete database record
            dao.deleteDocument(docId);

            response.sendRedirect("MyFilesServlet?delete=success");

        } else {

            response.sendRedirect("MyFilesServlet?delete=failed");

        }

    }

}