package controller;

import java.io.IOException;

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

@WebServlet("/PreviewServlet")
public class PreviewServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        /* ================= DOCUMENT ID ================= */

        String idParam = request.getParameter("id");

        if (idParam == null || idParam.trim().isEmpty()) {

            response.sendError(
                HttpServletResponse.SC_BAD_REQUEST,
                "Document ID is missing."
            );

            return;
        }

        int docId;

        try {

            docId = Integer.parseInt(idParam.trim());

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


        /* ================= CHECK USER / ADMIN ================= */

        User loginUser =
            (User) session.getAttribute("user");

        Admin admin =
            (Admin) session.getAttribute("admin");


        /*
         * Allow either:
         *
         * 1. Normal User
         * 2. Admin
         *
         * If neither exists, redirect to login.
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
         * Admin can preview any document.
         *
         * Therefore we SKIP:
         *
         * - Owner check
         * - Public/private check
         * - Follower check
         */

        if (admin != null) {

            System.out.println(
                "ADMIN PREVIEW: " +
                admin +
                " | Document ID: " +
                docId
            );

        }

        /* ==================================================
         * NORMAL USER ACCESS
         * ================================================== */

        else if (loginUser != null) {

            int ownerId =
                doc.getUserId();


            /*
             * Owner can always preview
             * his/her own document.
             */

            if (ownerId != loginUser.getId()) {

                /*
                 * Get document owner's
                 * account visibility.
                 */

                String ownerVisibility =
                    dao.getUserVisibility(ownerId);


                /*
                 * PUBLIC account
                 *
                 * Anyone logged in can preview.
                 */

                if ("PUBLIC".equalsIgnoreCase(
                        ownerVisibility)) {

                    // Allow access

                }


                /*
                 * PRIVATE account
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
                            "This document belongs to a private " +
                            "account. You must follow the user " +
                            "to view this document."
                        );

                        return;
                    }
                }
            }
        }


        /* ================= SEND DOCUMENT ================= */

        request.setAttribute(
            "document",
            doc
        );


        /* ================= SOURCE ================= */

        String source =
            request.getParameter("source");


        if (source == null ||
            source.trim().isEmpty()) {

            /*
             * If admin is opening it from
             * Manage Documents, use admin source.
             */

            if (admin != null) {

                source = "admin";

            } else {

                source = "community";
            }
        }


        request.setAttribute(
            "previewSource",
            source
        );


        /* ================= OPEN PREVIEW ================= */

        request.getRequestDispatcher(
            "preview.jsp"
        ).forward(
            request,
            response
        );
    }
}