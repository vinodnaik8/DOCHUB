package controller;

import java.io.File;
import java.io.IOException;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import model.User;

@WebServlet("/UpdateProfileServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 1024 * 1024 * 5,
    maxRequestSize = 1024 * 1024 * 10
)
public class UpdateProfileServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private static final String UPLOAD_PATH =
            "C:\\DOCHUB_DATA\\profilePics";

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // ==============================
        // Get Profile Details
        // ==============================

        String fullname = request.getParameter("fullname");
        String username = request.getParameter("username");
        String profession = request.getParameter("profession");
        String bio = request.getParameter("bio");
        String skills = request.getParameter("skills");
        String github = request.getParameter("github");
        String linkedin = request.getParameter("linkedin");
        String visibility = request.getParameter("visibility");

        // Keep existing picture
        String profilePic = user.getProfilePic();

        // ==============================
        // Profile Picture Upload
        // ==============================

        Part part = request.getPart("profilePic");

        if (part != null && part.getSize() > 0) {

            File folder = new File(UPLOAD_PATH);

            if (!folder.exists()) {
                folder.mkdirs();
            }

            String originalName =
                    new File(part.getSubmittedFileName()).getName();

            String fileName =
                    System.currentTimeMillis()
                    + "_"
                    + originalName;

            File imageFile =
                    new File(folder, fileName);

            part.write(imageFile.getAbsolutePath());

            profilePic = fileName;

            System.out.println("==============================");
            System.out.println("PROFILE UPDATED");
            System.out.println("Image = " + fileName);
            System.out.println(
                "Location = " + imageFile.getAbsolutePath()
            );
            System.out.println(
                "Exists = " + imageFile.exists()
            );
            System.out.println(
                "Size = " + imageFile.length()
            );
            System.out.println("==============================");
        }

        // ==============================
        // Update User Object
        // ==============================

        user.setFullname(fullname);
        user.setUsername(username);
        user.setProfession(profession);
        user.setBio(bio);
        user.setSkills(skills);
        user.setGithub(github);
        user.setLinkedin(linkedin);
        user.setVisibility(visibility);
        user.setProfilePic(profilePic);

        // ==============================
        // Update Database
        // ==============================

        UserDAO dao = new UserDAO();

        boolean status = dao.updateProfile(user);

        if (status) {

            // Update session with new user data
            session.setAttribute("user", user);

            response.sendRedirect(
                "ProfileServlet?success=1"
            );

        } else {

            response.sendRedirect(
                "editProfile.jsp?error=1"
            );
        }
    }
}