<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>
<%@ page import="model.User"%>
<%@ page import="model.Document"%>
<%@ page import="dao.DocumentDAO"%>
<%@ page import="dao.NoteDAO"%>

<%
    // ==========================
    // CHECK LOGIN
    // ==========================

    User user = (User) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // ==========================
    // USER ID
    // ==========================

    int userId = user.getId();

    // ==========================
    // DAOs
    // ==========================

    DocumentDAO documentDAO = new DocumentDAO();
    NoteDAO noteDAO = new NoteDAO();

    // ==========================
    // DOCUMENTS
    // ==========================

    List<Document> docs =
        documentDAO.getDocumentsByUser(userId);

    int documentCount =
        documentDAO.getDocumentCount(userId);

    // ==========================
    // NOTES
    // ==========================

    int noteCount =
        noteDAO.getTotalNotes(userId);

    // ==========================
    // DOWNLOADS
    // ==========================

    int downloadCount =
        documentDAO.getTotalDownloads(userId);

    // ==========================
    // PROFILE IMAGE
    // ==========================

    String photo = user.getProfilePic();

    if (photo == null || photo.trim().equals("")) {
        photo = "default.png";
    }
%>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>DOCHUB Dashboard</title>

    <link rel="stylesheet"
          href="css/dashboard.css">

    <link rel="preconnect"
          href="https://fonts.googleapis.com">

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
          rel="stylesheet">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">

</head>


<body>


<%
    String upload = request.getParameter("upload");
%>


<%
    if ("success".equals(upload)) {
%>

<div class="successMessage">

    <i class="fa-solid fa-circle-check"></i>

    Document uploaded successfully.

</div>

<%
    }
%>


<div class="app">


    <!-- ==========================
         OVERLAY
    =========================== -->

    <div class="overlay"
         id="overlay">
    </div>


    <!-- ==========================
         SIDEBAR
    =========================== -->

    <aside class="sidebar"
           id="sidebar">


        <div class="sidebarTop">

            <h2>DOCHUB</h2>

            <i class="fa-solid fa-xmark closeMenu"
               id="closeMenu"></i>

        </div>


        <ul>


            <li class="active">

                <a href="dashboard.jsp">

                    <i class="fa-solid fa-house"></i>

                    Dashboard

                </a>

            </li>


            <li>

                <a href="upload.jsp">

                    <i class="fa-solid fa-cloud-arrow-up"></i>

                    Upload

                </a>

            </li>


            <li>

                <a href="MyFilesServlet">

                    <i class="fa-solid fa-folder"></i>

                    My Files

                </a>

            </li>


            <li>

                <a href="NotesServlet">

                    <i class="fa-solid fa-note-sticky"></i>

                    Notes

                </a>

            </li>


            <li>

                <a href="PublicFeedServlet">

                    <i class="fa-solid fa-globe"></i>

                    Community

                </a>

            </li>


            <li>

                <a href="MyBookmarksServlet">

                    <i class="fa-solid fa-bookmark"></i>

                    <span>Bookmarks</span>

                </a>

            </li>


            <li>

                <a href="ProfileServlet">

                    <i class="fa-solid fa-user"></i>

                    Profile

                </a>

            </li>


            <li>

                <a href="settings.jsp">

                    <i class="fa-solid fa-gear"></i>

                    Settings

                </a>

            </li>


            <li>

                <a href="LogoutServlet">

                    <i class="fa-solid fa-right-from-bracket"></i>

                    Logout

                </a>

            </li>


        </ul>


    </aside>


    <!-- ==========================
         MAIN
    =========================== -->

    <main class="main">


        <!-- ==========================
             NAVBAR
        =========================== -->

        <header class="navbar">


            <div class="leftNav">

                <i class="fa-solid fa-bars menuBtn"
                   id="menuBtn"></i>

                <h2>DOCHUB</h2>

            </div>


            <div class="searchBox">

                <i class="fa-solid fa-magnifying-glass"></i>

                <input
                    type="text"
                    placeholder="Search documents, notes, users...">

            </div>


            <div class="rightNav">


                <a href="upload.jsp"
                   class="uploadBtn">

                    <i class="fa-solid fa-plus"></i>

                    Upload

                </a>


                <div class="profileMini">


                    <img
                        src="ViewProfilePicServlet?file=<%= photo %>"
                        alt="Profile">


                    <span>

                        <%= user.getFullname() %>

                    </span>


                </div>


            </div>


        </header>


        <!-- ==========================
             HERO
        =========================== -->

        <section class="hero">


            <div>

                <h1>

                    Welcome back,

                    <%= user.getFullname() %>

                    👋

                </h1>


                <p>

                    Manage your documents, notes and projects
                    from one place.

                </p>

            </div>


            <a href="upload.jsp"
               class="uploadBtn">

                Create Workspace

            </a>


        </section>


        <!-- ==========================
             STATS
        =========================== -->

        <section class="stats">


            <!-- DOCUMENT COUNT -->

            <div class="statCard">


                <i class="fa-solid fa-file-lines"></i>


                <h2>

                    <%= documentCount %>

                </h2>


                <p>

                    Documents

                </p>


            </div>


            <!-- NOTE COUNT -->

            <div class="statCard">


                <i class="fa-solid fa-note-sticky"></i>


                <h2>

                    <%= noteCount %>

                </h2>


                <p>

                    Notes

                </p>


            </div>


            <!-- DOWNLOAD COUNT -->

            <div class="statCard">


                <i class="fa-solid fa-download"></i>


                <h2>

                    <%= downloadCount %>

                </h2>


                <p>

                    Downloads

                </p>


            </div>


        </section>


        <!-- ==========================
             QUICK ACTIONS
        =========================== -->

        <section class="quickActions">


            <a href="upload.jsp"
               class="actionCard">


                <i class="fa-solid fa-cloud-arrow-up"></i>


                <h3>

                    Upload File

                </h3>


                <p>

                    Store documents securely

                </p>


            </a>


           <a href="NotesServlet?action=create"
   class="actionCard">

    <i class="fa-solid fa-note-sticky"></i>

    <h3>Create Note</h3>

    <p>Write personal notes</p>

</a>


            <a href="MyFilesServlet"
               class="actionCard">


                <i class="fa-solid fa-folder"></i>


                <h3>

                    My Files

                </h3>


                <p>

                    Manage uploaded files

                </p>


            </a>


            <a href="PublicFeedServlet"
               class="actionCard">


                <i class="fa-solid fa-globe"></i>


                <h3>

                    Community

                </h3>


                <p>

                    Share knowledge

                </p>


            </a>


        </section>


        <!-- ==========================
             RECENT DOCUMENTS
        =========================== -->

        <section class="section">


            <div class="sectionHeader">


                <h2>

                    Recent Documents

                </h2>


                <a href="MyFilesServlet">

                    View All

                </a>


            </div>


            <div class="documentGrid">


            <%

                if (docs == null || docs.size() == 0) {

            %>


                <div class="emptyCard">


                    <i class="fa-solid fa-folder-open"></i>


                    <h3>

                        No Documents

                    </h3>


                    <p>

                        Upload your first document.

                    </p>


                </div>


            <%

                } else {


                    int count = 0;


                    for (Document d : docs) {


                        if (count == 6) {
                            break;
                        }

            %>


                <div class="docCard">


                    <!-- DOCUMENT ICON -->

                    <div class="docIcon">


                        <i class="fa-solid fa-file-pdf"></i>


                    </div>


                    <!-- DOCUMENT INFORMATION -->

                    <div class="docInfo">


                        <h3>

                            <%= d.getTitle() %>

                        </h3>


                        <p>

                            <%= d.getCategory() %>

                        </p>


                    </div>


                    <!-- VISIBILITY -->

                    <div class="docFooter">


                        <span>

                            <%= d.getVisibility() %>

                        </span>


                    </div>


                    <!-- BUTTONS -->

                    <div class="docButtons">


                        <!-- PREVIEW -->

                        <a href="PreviewServlet?id=<%= d.getDocId() %>&source=dashboard"
                           title="Preview">

                            <i class="fa-solid fa-eye"></i>

                        </a>


                        <!-- DOWNLOAD -->

                        <a href="DownloadServlet?id=<%= d.getDocId() %>"
                           title="Download">

                            <i class="fa-solid fa-download"></i>

                        </a>


                        <!-- BOOKMARK -->

                        <a href="BookmarkServlet?id=<%= d.getDocId() %>"
                           title="Bookmark">

                            <i class="fa-regular fa-star"></i>

                        </a>


                    </div>


                </div>


            <%

                        count++;

                    }

                }

            %>


            </div>


        </section>


        <!-- ==========================
             RECENT ACTIVITY
        =========================== -->

        <section class="section">


            <div class="sectionHeader">


                <h2>

                    Recent Activity

                </h2>


            </div>


            <div class="activity">


                <div class="activityItem">


                    <i class="fa-solid fa-upload"></i>


                    <div>


                        <h4>

                            Uploaded Documents

                        </h4>


                        <p>

                            You have uploaded

                            <%= documentCount %>

                            document(s).

                        </p>


                    </div>


                </div>


                <div class="activityItem">


                    <i class="fa-solid fa-note-sticky"></i>


                    <div>


                        <h4>

                            Notes

                        </h4>


                        <p>

                            You have

                            <%= noteCount %>

                            active note(s).

                        </p>


                    </div>


                </div>


                <div class="activityItem">


                    <i class="fa-solid fa-download"></i>


                    <div>


                        <h4>

                            Downloads

                        </h4>


                        <p>

                            Your documents have been downloaded

                            <%= downloadCount %>

                            time(s).

                        </p>


                    </div>


                </div>


                <div class="activityItem">


                    <i class="fa-solid fa-user"></i>


                    <div>


                        <h4>

                            Welcome

                        </h4>


                        <p>

                            Hello

                            <%= user.getFullname() %>,

                            have a productive day.

                        </p>


                    </div>


                </div>


            </div>


        </section>


    </main>


</div>


<!-- ==========================
     JAVASCRIPT
=========================== -->

<script src="js/dashboard.js"></script>


<script>

const msg = document.querySelector(".successMessage");

if (msg) {

    setTimeout(() => {

        msg.style.transition = "0.5s";

        msg.style.opacity = "0";


        setTimeout(() => {

            msg.remove();

        }, 500);


    }, 3000);

}

</script>


</body>

</html>