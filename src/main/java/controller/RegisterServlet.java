package controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;

import dao.UserDAO;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/RegisterServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 1024 * 1024 * 5,
    maxRequestSize = 1024 * 1024 * 10
)
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // SAME folder used everywhere
    private static final String UPLOAD_PATH =
            "C:\\DOCHUB_DATA\\profilePics";

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        String fullname = request.getParameter("fullname");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // ==============================
        // PROFILE IMAGE
        // ==============================

        Part part = request.getPart("profilePic");

        String profilePic = null;

        if (part != null && part.getSize() > 0) {

            File uploadFolder = new File(UPLOAD_PATH);

            if (!uploadFolder.exists()) {
                uploadFolder.mkdirs();
            }

            // Get original filename
            String originalName = part.getSubmittedFileName();

            if (originalName != null) {

                originalName = new File(originalName).getName();

                // Generate unique filename
                profilePic =
                        System.currentTimeMillis()
                        + "_"
                        + originalName;

                File destination =
                        new File(uploadFolder, profilePic);

                // Save file
                Files.copy(
                        part.getInputStream(),
                        destination.toPath(),
                        StandardCopyOption.REPLACE_EXISTING
                );

                System.out.println("=================================");
                System.out.println("PROFILE IMAGE UPLOAD");
                System.out.println("Original Name : " + originalName);
                System.out.println("Saved Name    : " + profilePic);
                System.out.println("Saved Path    : " + destination.getAbsolutePath());
                System.out.println("File Exists   : " + destination.exists());
                System.out.println("File Size     : " + destination.length());
                System.out.println("=================================");
            }
        }

        // ==============================
        // CREATE USER
        // ==============================

        User user = new User();

        user.setFullname(fullname);
        user.setUsername(username);
        user.setEmail(email);
        user.setPassword(password);

        // IMPORTANT
        user.setProfilePic(profilePic);

        user.setBio("");
        user.setVisibility("PRIVATE");

        // ==============================
        // SAVE USER
        // ==============================

        UserDAO dao = new UserDAO();

        boolean status = dao.registerUser(user);

        System.out.println("Registration Status = " + status);
        System.out.println("Database Profile Pic = " + profilePic);

        if (status) {

            response.sendRedirect("login.jsp");

        } else {

            response.getWriter().println(
                    "Registration Failed!"
            );
        }
    }
}