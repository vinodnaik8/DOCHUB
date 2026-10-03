package controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.file.Files;

import dao.DocumentDAO;
import dao.FollowDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.Admin;
import model.Document;
import model.User;

@WebServlet("/DownloadServlet")
public class DownloadServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private static final String UPLOAD_PATH =
            "C:\\DOCHUB_UPLOADS";


    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {


        /* ================= DOCUMENT ID ================= */

        String idParam =
                request.getParameter("id");


        if (idParam == null ||
            idParam.trim().isEmpty()) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Document ID is missing."
            );

            return;
        }


        int docId;

        try {

            docId =
                    Integer.parseInt(
                            idParam.trim()
                    );

        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid document ID."
            );

            return;
        }


        /* ================= SESSION ================= */

        HttpSession session =
                request.getSession(false);


        if (session == null) {

            response.sendRedirect("login.jsp");

            return;
        }


        /* ================= USER / ADMIN ================= */

        User loginUser =
                (User) session.getAttribute("user");

        Admin admin =
                (Admin) session.getAttribute("admin");


        /*
         * Allow either:
         *
         * Normal User
         * OR
         * Admin
         */

        if (loginUser == null && admin == null) {

            response.sendRedirect("login.jsp");

            return;
        }


        /* ================= GET DOCUMENT ================= */

        DocumentDAO dao =
                new DocumentDAO();


        Document doc =
                dao.getDocumentById(docId);


        if (doc == null) {

            response.sendError(
                    HttpServletResponse.SC_NOT_FOUND,
                    "Document not found."
            );

            return;
        }


        /* ==================================================
         * ADMIN ACCESS
         * ==================================================
         *
         * Admin can download any document.
         *
         * Therefore no privacy/follower
         * check is required for admin.
         */

        if (admin != null) {

            System.out.println(
                    "ADMIN DOWNLOAD | Document ID: "
                    + docId
            );

        }


        /* ==================================================
         * NORMAL USER ACCESS
         * ================================================== */

        else if (loginUser != null) {

            int ownerId =
                    doc.getUserId();


            /*
             * Owner can always download
             * their own document.
             */

            if (ownerId != loginUser.getId()) {

                /*
                 * Get owner's account visibility.
                 */

                String ownerVisibility =
                        dao.getUserVisibility(ownerId);


                /*
                 * PUBLIC account:
                 *
                 * Allow download.
                 */

                if ("PUBLIC".equalsIgnoreCase(
                        ownerVisibility)) {

                    // Access allowed
                }


                /*
                 * PRIVATE account:
                 *
                 * User must follow owner.
                 */

                else if ("PRIVATE".equalsIgnoreCase(
                        ownerVisibility)) {


                    FollowDAO followDAO =
                            new FollowDAO();


                    boolean following =
                            followDAO.isFollowing(
                                    loginUser.getId(),
                                    ownerId
                            );


                    if (!following) {

                        response.sendError(
                                HttpServletResponse.SC_FORBIDDEN,
                                "This document belongs to a private "
                                + "account. You must follow the user "
                                + "to download this document."
                        );

                        return;
                    }
                }
            }
        }


        /* ================= FILE ================= */

        File file =
                new File(
                        UPLOAD_PATH
                        + File.separator
                        + doc.getFileName()
                );


        if (!file.exists() ||
            !file.isFile()) {

            response.sendError(
                    HttpServletResponse.SC_NOT_FOUND,
                    "Physical file not found."
            );

            return;
        }


        /* ================= CONTENT TYPE ================= */

        String contentType =
                Files.probeContentType(
                        file.toPath()
                );


        if (contentType == null) {

            contentType =
                    "application/octet-stream";
        }


        response.setContentType(
                contentType
        );


        response.setContentLengthLong(
                file.length()
        );


        /* ================= FILE NAME ================= */

        String fileName =
                file.getName();


        /*
         * Content-Disposition attachment
         * forces browser download.
         */

        response.setHeader(
                "Content-Disposition",
                "attachment; filename=\""
                + fileName
                + "\""
        );


        /* ================= DOWNLOAD ================= */

        try (
            FileInputStream fis =
                    new FileInputStream(file);

            OutputStream os =
                    response.getOutputStream()
        ) {


            byte[] buffer =
                    new byte[8192];


            int bytesRead;


            while (
                    (bytesRead =
                            fis.read(buffer)) != -1
            ) {

                os.write(
                        buffer,
                        0,
                        bytesRead
                );
            }


            os.flush();
        }
    }
}