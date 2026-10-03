package controller;

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

@WebServlet("/UpdateDocumentServlet")
public class UpdateDocumentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
                           throws ServletException, IOException {

        // ==========================
        // SESSION
        // ==========================

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


        // ==========================
        // GET FORM DATA
        // ==========================

        try {

            int docId = Integer.parseInt(
                request.getParameter("docId")
            );

            String title =
                request.getParameter("title");

            String description =
                request.getParameter("description");

            String category =
                request.getParameter("category");


            // ==========================
            // DOCUMENT OBJECT
            // ==========================

            Document doc = new Document();

            doc.setDocId(docId);
            doc.setUserId(user.getId());

            doc.setTitle(title);
            doc.setDescription(description);
            doc.setCategory(category);


            // ==========================
            // UPDATE DATABASE
            // ==========================

            DocumentDAO dao = new DocumentDAO();

            boolean status =
                dao.updateDocument(doc);


            // ==========================
            // RESULT
            // ==========================

            if (status) {

                response.sendRedirect(
                    "MyFilesServlet?update=success"
                );

            } else {

                response.sendRedirect(
                    "EditDocumentServlet?id="
                    + docId
                    + "&update=failed"
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                "MyFilesServlet?update=failed"
            );
        }
    }
}