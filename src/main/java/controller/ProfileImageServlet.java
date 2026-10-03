package controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ProfileImageServlet")
public class ProfileImageServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private static final String UPLOAD_PATH =
            "C:\\DOCHUB_DATA\\profilePics";

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String fileName = request.getParameter("file");

        System.out.println("=================================");
        System.out.println("ProfileImageServlet called");
        System.out.println("Requested file = " + fileName);

        if (fileName == null || fileName.trim().isEmpty()) {

            response.sendError(
                    HttpServletResponse.SC_NOT_FOUND
            );

            return;
        }

        // Prevent folder traversal
        fileName = new File(fileName).getName();

        File imageFile =
                new File(UPLOAD_PATH, fileName);

        System.out.println(
                "Looking for = "
                + imageFile.getAbsolutePath()
        );

        System.out.println(
                "Exists = "
                + imageFile.exists()
        );

        if (!imageFile.exists() || !imageFile.isFile()) {

            System.out.println(
                    "IMAGE NOT FOUND!"
            );

            response.sendError(
                    HttpServletResponse.SC_NOT_FOUND
            );

            return;
        }

        String contentType =
                Files.probeContentType(
                        imageFile.toPath()
                );

        if (contentType == null) {

            contentType = "image/jpeg";

        }

        response.setContentType(contentType);
        response.setContentLengthLong(imageFile.length());

        // Prevent browser caching old/broken image
        response.setHeader(
                "Cache-Control",
                "no-cache, no-store, must-revalidate"
        );

        Files.copy(
                imageFile.toPath(),
                response.getOutputStream()
        );

        System.out.println(
                "IMAGE SENT SUCCESSFULLY"
        );

        System.out.println("=================================");
    }
}