package controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

import dao.DocumentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import model.Document;
import model.User;

@WebServlet("/UploadServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 1024 * 1024 * 100,
    maxRequestSize = 1024 * 1024 * 100
)
public class UploadServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private static final String UPLOAD_PATH = "C:\\DOCHUB_UPLOADS";

    @Override
    protected void doPost(HttpServletRequest request,
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


        /* ================= FORM DATA ================= */

        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String category = request.getParameter("category");

        /*
         * IMPORTANT:
         *
         * No document visibility here.
         *
         * Account visibility is controlled from:
         *
         * users.visibility
         *
         * PUBLIC  -> everyone can see
         * PRIVATE -> followers can see
         */


        /* ================= FILE ================= */

        Part part = request.getPart("document");

        if (part == null ||
            part.getSubmittedFileName() == null ||
            part.getSubmittedFileName().trim().isEmpty()) {

            response.sendRedirect("upload.jsp?upload=failed");
            return;
        }

        String fileName =
            Paths.get(part.getSubmittedFileName())
                 .getFileName()
                 .toString();


        /* ================= UPLOAD FOLDER ================= */

        File folder = new File(UPLOAD_PATH);

        if (!folder.exists()) {
            folder.mkdirs();
        }


        /* ================= SAVE FILE ================= */

        part.write(
            UPLOAD_PATH + File.separator + fileName
        );


        /* ================= DOCUMENT OBJECT ================= */

        Document doc = new Document();

        doc.setUserId(user.getId());
        doc.setTitle(title);
        doc.setDescription(description);
        doc.setCategory(category);
        doc.setFileName(fileName);

        /*
         * DO NOT SET:
         *
         * doc.setVisibility(...)
         *
         * because visibility now belongs
         * to the USER ACCOUNT.
         */


        /* ================= DATABASE ================= */

        DocumentDAO dao = new DocumentDAO();

        boolean status = dao.uploadDocument(doc);


        /* ================= RESULT ================= */

        if (status) {

            response.sendRedirect(
                "dashboard.jsp?upload=success"
            );

        } else {

            response.sendRedirect(
                "upload.jsp?upload=failed"
            );
        }
    }
}