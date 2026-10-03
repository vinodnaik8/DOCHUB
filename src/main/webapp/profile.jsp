<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="model.User" %>
<%@ page import="model.Document" %>

<%
/* =========================================================
   LOGGED-IN USER
========================================================= */

User loginUser = (User) session.getAttribute("user");

if (loginUser == null) {
    response.sendRedirect("login.jsp");
    return;
}

/* =========================================================
   PROFILE USER
========================================================= */

User profileUser = (User) request.getAttribute("profileUser");

if (profileUser == null) {
    profileUser = loginUser;
}

/* =========================================================
   CHECK WHETHER OWN PROFILE
========================================================= */

boolean ownProfile =
        loginUser.getId() == profileUser.getId();

/* =========================================================
   DOCUMENTS
========================================================= */

List<Document> documents =
        (List<Document>) request.getAttribute("documents");

if (documents == null) {
    documents = new ArrayList<Document>();
}

/* =========================================================
   STATISTICS
========================================================= */

Integer totalDocumentsObj =
        (Integer) request.getAttribute("totalDocuments");

Integer publicDocumentsObj =
        (Integer) request.getAttribute("publicDocuments");

Integer privateDocumentsObj =
        (Integer) request.getAttribute("privateDocuments");

Integer notesCountObj =
        (Integer) request.getAttribute("notesCount");

Integer likesReceivedObj =
        (Integer) request.getAttribute("likesReceived");

Integer downloadsObj =
        (Integer) request.getAttribute("downloads");

Integer followersObj =
        (Integer) request.getAttribute("followers");

Integer followingObj =
        (Integer) request.getAttribute("following");

Boolean isFollowingObj =
        (Boolean) request.getAttribute("isFollowing");

int totalDocuments =
        totalDocumentsObj != null ? totalDocumentsObj : 0;

int publicDocuments =
        publicDocumentsObj != null ? publicDocumentsObj : 0;

int privateDocuments =
        privateDocumentsObj != null ? privateDocumentsObj : 0;

int notesCount =
        notesCountObj != null ? notesCountObj : 0;

int likesReceived =
        likesReceivedObj != null ? likesReceivedObj : 0;

int downloads =
        downloadsObj != null ? downloadsObj : 0;

int followers =
        followersObj != null ? followersObj : 0;

int following =
        followingObj != null ? followingObj : 0;

boolean isFollowing =
        isFollowingObj != null ? isFollowingObj : false;

/* =========================================================
   PROFILE IMAGE
========================================================= */

String profilePic = profileUser.getProfilePic();

%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>
    <%= ownProfile
        ? "My Profile"
        : profileUser.getFullname() + " | Profile" %>
    | DOCHUB
</title>

<!-- FONT AWESOME -->

<link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">

<!-- POPPINS -->

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
      rel="stylesheet">

<style>

/* =========================================================
   GLOBAL
========================================================= */

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Poppins', sans-serif;
}

body {
    background: #eef3f8;
    color: #222;
    min-height: 100vh;
}

/* =========================================================
   HEADER
========================================================= */

.header {

    height: 75px;

    background: white;

    display: flex;

    justify-content: space-between;

    align-items: center;

    padding: 0 40px;

    box-shadow: 0 4px 20px rgba(0,0,0,.08);

    position: sticky;

    top: 0;

    z-index: 999;
}

.logo {

    font-size: 28px;

    font-weight: 700;

    color: #2563eb;

    display: flex;

    align-items: center;
}

.logo i {
    margin-right: 8px;
}

.headerRight {

    display: flex;

    gap: 15px;
}

.headerBtn {

    text-decoration: none;

    background: #2563eb;

    color: white;

    padding: 10px 22px;

    border-radius: 10px;

    font-weight: 600;

    transition: .3s;

    display: inline-flex;

    align-items: center;

    gap: 8px;
}

.headerBtn:hover {

    background: #1d4ed8;

    transform: translateY(-2px);
}

/* =========================================================
   CONTAINER
========================================================= */

.container {

    width: 92%;

    max-width: 1200px;

    margin: 35px auto;
}

/* =========================================================
   COVER
========================================================= */

.cover {

    height: 250px;

    border-radius: 25px;

    background:
        linear-gradient(
            135deg,
            #2563eb,
            #4f8cff,
            #7ab6ff
        );

    position: relative;

    overflow: hidden;

    box-shadow: 0 15px 35px rgba(0,0,0,.12);
}

.cover::before {

    content: "";

    position: absolute;

    width: 500px;

    height: 500px;

    border-radius: 50%;

    background: rgba(255,255,255,.08);

    top: -180px;

    right: -120px;
}

.cover::after {

    content: "";

    position: absolute;

    width: 320px;

    height: 320px;

    border-radius: 50%;

    background: rgba(255,255,255,.08);

    bottom: -140px;

    left: -100px;
}

/* =========================================================
   PROFILE CARD
========================================================= */

.profileCard {

    background: white;

    margin-top: -85px;

    border-radius: 25px;

    padding: 35px;

    position: relative;

    box-shadow: 0 12px 35px rgba(0,0,0,.12);

    display: flex;

    align-items: center;

    gap: 30px;
}

/* =========================================================
   PROFILE IMAGE
========================================================= */

.profileImage {

    width: 170px;

    height: 170px;

    border-radius: 50%;

    overflow: hidden;

    border: 6px solid white;

    background: #2563eb;

    display: flex;

    justify-content: center;

    align-items: center;

    box-shadow: 0 8px 20px rgba(0,0,0,.15);

    flex-shrink: 0;

    transition: .35s;
}

.profileImage:hover {

    transform: scale(1.05) rotate(2deg);
}

.profileImage img {

    width: 100%;

    height: 100%;

    object-fit: cover;

    display: block;
}

.defaultProfile {

    width: 100%;

    height: 100%;

    display: flex;

    justify-content: center;

    align-items: center;

    color: white;

    font-size: 70px;
}

/* =========================================================
   PROFILE INFORMATION
========================================================= */

.profileInfo {

    flex: 1;
}

.profileInfo h1 {

    font-size: 34px;

    font-weight: 700;

    color: #222;

    margin-bottom: 5px;
}

.username {

    font-size: 17px;

    color: #777;

    margin-bottom: 15px;
}

.profession {

    display: inline-block;

    background: #e8f1ff;

    color: #2563eb;

    padding: 8px 18px;

    border-radius: 30px;

    font-weight: 600;

    margin-bottom: 20px;
}

.bio {

    background: #f7f9fc;

    padding: 18px;

    border-radius: 15px;

    line-height: 1.8;

    color: #555;

    margin-bottom: 20px;

    word-break: break-word;
}

/* =========================================================
   BUTTONS
========================================================= */

.profileButtons {

    display: flex;

    gap: 15px;

    flex-wrap: wrap;
}

.btn {

    text-decoration: none;

    padding: 12px 22px;

    border-radius: 12px;

    font-weight: 600;

    transition: .3s;

    display: inline-flex;

    align-items: center;

    gap: 8px;
}

.btn:hover {

    transform: translateY(-2px);
}

.editBtn {

    background: #2563eb;

    color: white;
}

.editBtn:hover {

    background: #1d4ed8;
}

.settingBtn {

    background: #10b981;

    color: white;
}

.settingBtn:hover {

    background: #059669;
}

.passwordBtn {

    background: #f59e0b;

    color: white;
}

.passwordBtn:hover {

    background: #d97706;
}

.followBtn {

    background: #2563eb;

    color: white;
}

.unfollowBtn {

    background: #ef4444;

    color: white;
}

/* =========================================================
   INFO GRID
========================================================= */

.infoGrid {

    display: grid;

    grid-template-columns: repeat(2, 1fr);

    gap: 25px;

    margin-top: 35px;
}

.infoCard {

    background: white;

    padding: 28px;

    border-radius: 20px;

    box-shadow: 0 10px 25px rgba(0,0,0,.08);

    transition: .3s;
}

.infoCard:hover {

    transform: translateY(-6px);
}

.infoTitle {

    font-size: 22px;

    font-weight: 700;

    margin-bottom: 22px;

    color: #222;

    display: flex;

    align-items: center;

    gap: 10px;
}

.infoTitle i {

    color: #2563eb;
}

.infoItem {

    margin-bottom: 20px;
}

.infoLabel {

    font-weight: 600;

    color: #444;

    margin-bottom: 8px;
}

.infoValue {

    color: #666;

    line-height: 1.7;

    word-break: break-word;
}

/* =========================================================
   SKILLS
========================================================= */

.skillContainer {

    display: flex;

    flex-wrap: wrap;

    gap: 10px;

    margin-top: 8px;
}

.skill {

    background: #2563eb;

    color: white;

    padding: 8px 16px;

    border-radius: 25px;

    font-size: 14px;

    font-weight: 500;
}

.emptyText {

    color: #999;

    font-style: italic;
}

/* =========================================================
   SOCIAL LINKS
========================================================= */

.socialBtn {

    display: flex;

    align-items: center;

    gap: 12px;

    padding: 14px 18px;

    margin-bottom: 15px;

    border-radius: 14px;

    text-decoration: none;

    font-weight: 600;

    transition: .3s;
}

.socialBtn:hover {

    transform: translateY(-2px);
}

.github {

    background: #24292e;

    color: white;
}

.linkedin {

    background: #0a66c2;

    color: white;
}

/* =========================================================
   STATISTICS
========================================================= */

.statisticsTitle {

    margin-top: 45px;

    margin-bottom: 25px;
}

.statisticsTitle h2 {

    font-size: 30px;

    color: #222;
}

.statisticsTitle i {

    color: #2563eb;
}

.statsGrid {

    display: grid;

    grid-template-columns: repeat(4, 1fr);

    gap: 22px;

    margin-top: 20px;
}

.statCard {

    background: white;

    padding: 28px;

    border-radius: 20px;

    text-align: center;

    box-shadow: 0 10px 25px rgba(0,0,0,.08);

    transition: .3s;

    cursor: pointer;
}

.statCard:hover {

    transform: translateY(-8px);

    box-shadow: 0 18px 35px rgba(0,0,0,.15);
}

.statIcon {

    width: 70px;

    height: 70px;

    margin: auto;

    margin-bottom: 18px;

    border-radius: 50%;

    display: flex;

    justify-content: center;

    align-items: center;

    font-size: 30px;

    color: white;
}

.blue {
    background: #2563eb;
}

.green {
    background: #10b981;
}

.red {
    background: #ef4444;
}

.orange {
    background: #f59e0b;
}

.purple {
    background: #8b5cf6;
}

.cyan {
    background: #06b6d4;
}

.pink {
    background: #ec4899;
}

.dark {
    background: #374151;
}

.statNumber {

    font-size: 34px;

    font-weight: 700;

    color: #222;

    margin-bottom: 8px;
}

.statText {

    font-size: 15px;

    color: #666;

    font-weight: 500;
}

/* =========================================================
   DOCUMENTS
========================================================= */

.sectionHeading {

    display: flex;

    justify-content: space-between;

    align-items: center;

    margin-top: 55px;

    margin-bottom: 25px;
}

.sectionHeading h2 {

    font-size: 30px;

    color: #222;
}

.viewAll {

    text-decoration: none;

    background: #2563eb;

    color: white;

    padding: 10px 18px;

    border-radius: 10px;

    font-weight: 600;
}

.documentGrid {

    display: grid;

    grid-template-columns:
        repeat(auto-fill, minmax(340px, 1fr));

    gap: 25px;
}

.documentCard {

    background: white;

    border-radius: 20px;

    padding: 24px;

    box-shadow: 0 10px 25px rgba(0,0,0,.08);

    transition: .3s;

    position: relative;

    overflow: hidden;
}

.documentCard:hover {

    transform: translateY(-8px);

    box-shadow: 0 18px 35px rgba(0,0,0,.15);
}

.documentTitle {

    font-size: 22px;

    font-weight: 700;

    margin-bottom: 15px;

    color: #222;

    padding-right: 80px;

    word-break: break-word;
}

.documentDescription {

    color: #666;

    line-height: 1.7;

    min-height: 75px;

    max-height: 75px;

    overflow: hidden;

    margin-bottom: 18px;

    word-break: break-word;
}

.documentCategory {

    display: inline-block;

    background: #2563eb;

    color: white;

    padding: 6px 15px;

    border-radius: 25px;

    font-size: 13px;

    margin-bottom: 18px;
}

.documentFile {

    background: #f5f7fb;

    padding: 14px;

    border-radius: 12px;

    font-weight: 600;

    color: #555;

    margin-bottom: 20px;

    word-break: break-word;
}

.documentFile i {

    color: #2563eb;

    margin-right: 8px;
}

.documentVisibility {

    position: absolute;

    top: 20px;

    right: 20px;

    padding: 6px 14px;

    border-radius: 20px;

    font-size: 12px;

    font-weight: 600;
}

.public {

    background: #dcfce7;

    color: #15803d;
}

.private {

    background: #fee2e2;

    color: #dc2626;
}

/* =========================================================
   DOCUMENT BUTTONS
========================================================= */

.docButtons {

    display: grid;

    grid-template-columns: repeat(2, 1fr);

    gap: 12px;

    margin-top: 20px;
}

.docButtons a {

    text-decoration: none;

    text-align: center;

    padding: 12px;

    border-radius: 10px;

    font-weight: 600;

    color: white;
}

.previewBtn {

    background: #6b7280;
}

.downloadBtn {

    background: #2563eb;
}

.editDocBtn {

    background: #10b981;
}

.deleteBtn {

    background: #ef4444;
}

/* =========================================================
   LIKE & COMMENT COUNT
========================================================= */

.documentStats {

    display: flex;

    justify-content: space-between;

    align-items: center;

    margin-top: 18px;

    padding: 12px 5px 0;

    border-top: 1px solid #e5e7eb;

    color: #666;

    font-size: 14px;

    font-weight: 600;
}

.documentStats span {

    display: flex;

    align-items: center;

    gap: 6px;
}

.likeCount {

    color: #ef4444;
}

.commentCount {

    color: #2563eb;
}

/* =========================================================
   EMPTY DOCUMENTS
========================================================= */

.emptyDocuments {

    background: white;

    padding: 80px;

    border-radius: 20px;

    text-align: center;

    box-shadow: 0 10px 25px rgba(0,0,0,.08);

    grid-column: 1 / -1;
}

.emptyDocuments i {

    font-size: 70px;

    color: #2563eb;

    margin-bottom: 20px;
}

/* =========================================================
   FOOTER
========================================================= */

footer {

    margin-top: 60px;

    padding: 30px;

    text-align: center;

    color: #666;

    font-size: 15px;
}

footer hr {

    margin-bottom: 25px;

    border: 1px solid #e5e7eb;
}

footer h3 {

    color: #2563eb;

    margin-bottom: 8px;
}

/* =========================================================
   RESPONSIVE
========================================================= */

@media(max-width:1000px) {

    .statsGrid {

        grid-template-columns: repeat(2, 1fr);
    }
}

@media(max-width:900px) {

    .profileCard {

        flex-direction: column;

        text-align: center;
    }

    .profileButtons {

        justify-content: center;
    }

    .infoGrid {

        grid-template-columns: 1fr;
    }
}

@media(max-width:650px) {

    .header {

        padding: 0 18px;

        height: 65px;
    }

    .logo {

        font-size: 21px;
    }

    .headerBtn {

        padding: 8px 14px;

        font-size: 13px;
    }

    .container {

        width: 94%;

        margin-top: 20px;
    }

    .cover {

        height: 190px;

        border-radius: 20px;
    }

    .profileCard {

        margin-top: -55px;

        padding: 25px 18px;

        border-radius: 20px;
    }

    .profileImage {

        width: 140px;

        height: 140px;
    }

    .profileInfo h1 {

        font-size: 27px;
    }

    .bio {

        font-size: 14px;
    }

    .profileButtons {

        flex-direction: column;
    }

    .btn {

        justify-content: center;

        width: 100%;
    }

    .statsGrid {

        grid-template-columns: 1fr;
    }

    .documentGrid {

        grid-template-columns: 1fr;
    }

    .sectionHeading {

        align-items: flex-start;

        gap: 15px;

        flex-direction: column;
    }

    .sectionHeading h2 {

        font-size: 25px;
    }

    .statisticsTitle h2 {

        font-size: 25px;
    }

    .emptyDocuments {

        padding: 50px 20px;
    }

    .documentStats {

        font-size: 13px;
    }
}

</style>

</head>

<body>

<!-- =========================================================
     HEADER
========================================================= -->

<div class="header">

    <div class="logo">

        <i class="fa-solid fa-user"></i>

        <%= ownProfile
            ? "DOCHUB Profile"
            : "DOCHUB Community Profile" %>

    </div>

    <div class="headerRight">

        <a href="dashboard.jsp"
           class="headerBtn">

            <i class="fa-solid fa-gauge"></i>

            Dashboard

        </a>

    </div>

</div>


<!-- =========================================================
     MAIN
========================================================= -->

<div class="container">

<!-- =========================================================
     COVER
========================================================= -->

<div class="cover"></div>


<!-- =========================================================
     PROFILE CARD
========================================================= -->

<div class="profileCard">

    <!-- PROFILE IMAGE -->

    <div class="profileImage">

        <%
        if (profilePic != null &&
            !profilePic.trim().isEmpty()) {
        %>

            <img
                src="<%=request.getContextPath()%>/ProfileImageServlet?file=<%=URLEncoder.encode(profilePic, "UTF-8")%>"
                alt="Profile Picture">

        <%
        } else {
        %>

            <div class="defaultProfile">

                <i class="fa-solid fa-user"></i>

            </div>

        <%
        }
        %>

    </div>


    <!-- PROFILE INFORMATION -->

    <div class="profileInfo">

        <h1>

            <%=profileUser.getFullname()%>

        </h1>

        <div class="username">

            @<%=profileUser.getUsername()%>

        </div>

        <div class="profession">

            <%=profileUser.getProfession() == null ||
               profileUser.getProfession().trim().isEmpty()
               ? "MCA Student"
               : profileUser.getProfession()%>

        </div>

        <div class="bio">

            <%=profileUser.getBio() == null ||
               profileUser.getBio().trim().isEmpty()
               ? "No bio added yet."
               : profileUser.getBio()%>

        </div>


        <!-- PROFILE BUTTONS -->

        <div class="profileButtons">

        <%
        if (ownProfile) {
        %>

            <a href="editProfile.jsp"
               class="btn editBtn">

                <i class="fa-solid fa-pen"></i>

                Edit Profile

            </a>

            <a href="resetPassword.jsp"
               class="btn passwordBtn">

                <i class="fa-solid fa-lock"></i>

                Password

            </a>

            <a href="settings.jsp"
               class="btn settingBtn">

                <i class="fa-solid fa-gear"></i>

                Settings

            </a>

        <%
        } else {

            if (isFollowing) {
        %>

            <a href="UnfollowServlet?id=<%=profileUser.getId()%>"
               class="btn unfollowBtn">

                <i class="fa-solid fa-user-minus"></i>

                Unfollow

            </a>

        <%
            } else {
        %>

            <a href="FollowServlet?id=<%=profileUser.getId()%>"
               class="btn followBtn">

                <i class="fa-solid fa-user-plus"></i>

                Follow

            </a>

        <%
            }
        }
        %>

        </div>

    </div>

</div>


<!-- =========================================================
     PROFILE DETAILS
========================================================= -->

<div class="infoGrid">

    <!-- PROFESSIONAL INFORMATION -->

    <div class="infoCard">

        <div class="infoTitle">

            <i class="fa-solid fa-address-card"></i>

            Professional Information

        </div>


        <!-- PROFESSION -->

        <div class="infoItem">

            <div class="infoLabel">

                Profession

            </div>

            <div class="infoValue">

                <%
                if (profileUser.getProfession() != null &&
                    !profileUser.getProfession().trim().isEmpty()) {
                %>

                    <%=profileUser.getProfession()%>

                <%
                } else {
                %>

                    <span class="emptyText">

                        Not Added

                    </span>

                <%
                }
                %>

            </div>

        </div>


        <!-- SKILLS -->

        <div class="infoItem">

            <div class="infoLabel">

                Skills

            </div>

            <div class="skillContainer">

                <%
                if (profileUser.getSkills() != null &&
                    !profileUser.getSkills().trim().isEmpty()) {

                    String[] skills =
                            profileUser.getSkills().split(",");

                    for (String skill : skills) {

                        if (skill.trim().isEmpty()) {
                            continue;
                        }
                %>

                    <span class="skill">

                        <%=skill.trim()%>

                    </span>

                <%
                    }

                } else {
                %>

                    <span class="emptyText">

                        No Skills Added

                    </span>

                <%
                }
                %>

            </div>

        </div>

    </div>


    <!-- SOCIAL LINKS -->

    <div class="infoCard">

        <div class="infoTitle">

            <i class="fa-solid fa-link"></i>

            Social Links

        </div>


        <!-- GITHUB -->

        <%
        if (profileUser.getGithub() != null &&
            !profileUser.getGithub().trim().isEmpty()) {
        %>

            <a
                href="<%=profileUser.getGithub()%>"
                target="_blank"
                rel="noopener noreferrer"
                class="socialBtn github">

                <i class="fa-brands fa-github fa-xl"></i>

                GitHub Profile

            </a>

        <%
        } else {
        %>

            <div class="emptyText"
                 style="margin-bottom:18px;">

                GitHub Not Added

            </div>

        <%
        }
        %>


        <!-- LINKEDIN -->

        <%
        if (profileUser.getLinkedin() != null &&
            !profileUser.getLinkedin().trim().isEmpty()) {
        %>

            <a
                href="<%=profileUser.getLinkedin()%>"
                target="_blank"
                rel="noopener noreferrer"
                class="socialBtn linkedin">

                <i class="fa-brands fa-linkedin fa-xl"></i>

                LinkedIn Profile

            </a>

        <%
        } else {
        %>

            <div class="emptyText">

                LinkedIn Not Added

            </div>

        <%
        }
        %>

    </div>

</div>


<!-- =========================================================
     STATISTICS TITLE
========================================================= -->

<div class="statisticsTitle">

    <h2>

        <i class="fa-solid fa-chart-simple"></i>

        <%=ownProfile
            ? "My Statistics"
            : "Profile Statistics"%>

    </h2>

</div>


<!-- =========================================================
     STATISTICS
========================================================= -->

<div class="statsGrid">

    <!-- TOTAL DOCUMENTS -->

    <div class="statCard">

        <div class="statIcon blue">

            <i class="fa-solid fa-folder"></i>

        </div>

        <div class="statNumber">

            <%=totalDocuments%>

        </div>

        <div class="statText">

            Total Documents

        </div>

    </div>


    <!-- PUBLIC -->

    <div class="statCard">

        <div class="statIcon green">

            <i class="fa-solid fa-earth-americas"></i>

        </div>

        <div class="statNumber">

            <%=publicDocuments%>

        </div>

        <div class="statText">

            Public Documents

        </div>

    </div>


    <!-- PRIVATE -->

    <div class="statCard">

        <div class="statIcon dark">

            <i class="fa-solid fa-lock"></i>

        </div>

        <div class="statNumber">

            <%=privateDocuments%>

        </div>

        <div class="statText">

            Private Documents

        </div>

    </div>


    <!-- NOTES -->

    <div class="statCard">

        <div class="statIcon orange">

            <i class="fa-solid fa-note-sticky"></i>

        </div>

        <div class="statNumber">

            <%=notesCount%>

        </div>

        <div class="statText">

            Notes

        </div>

    </div>


    <!-- LIKES -->

    <div class="statCard">

        <div class="statIcon red">

            <i class="fa-solid fa-heart"></i>

        </div>

        <div class="statNumber">

            <%=likesReceived%>

        </div>

        <div class="statText">

            Likes Received

        </div>

    </div>


    <!-- DOWNLOADS -->

    <div class="statCard">

        <div class="statIcon cyan">

            <i class="fa-solid fa-download"></i>

        </div>

        <div class="statNumber">

            <%=downloads%>

        </div>

        <div class="statText">

            Downloads

        </div>

    </div>


    <!-- FOLLOWERS -->

    <div class="statCard">

        <div class="statIcon purple">

            <i class="fa-solid fa-users"></i>

        </div>

        <div class="statNumber">

            <%=followers%>

        </div>

        <div class="statText">

            Followers

        </div>

    </div>


    <!-- FOLLOWING -->

    <div class="statCard">

        <div class="statIcon pink">

            <i class="fa-solid fa-user-group"></i>

        </div>

        <div class="statNumber">

            <%=following%>

        </div>

        <div class="statText">

            Following

        </div>

    </div>

</div>


<!-- =========================================================
     DOCUMENTS
========================================================= -->

<div class="sectionHeading">

    <h2>

        <i class="fa-solid fa-folder-open"></i>

        <%=ownProfile
            ? "My Documents"
            : profileUser.getFullname() + "'s Documents"%>

    </h2>


    <%
    if (ownProfile) {
    %>

        <a href="MyFilesServlet"
           class="viewAll">

            View All

        </a>

    <%
    }
    %>

</div>


<div class="documentGrid">

<%
if (documents.isEmpty()) {
%>

    <div class="emptyDocuments">

        <i class="fa-solid fa-folder-open"></i>

        <h2>

            No Documents Uploaded

        </h2>

        <p style="margin-top:15px;color:#666;">

            <%=ownProfile
                ? "Upload your first document to start sharing."
                : "This user has not uploaded any documents yet."%>

        </p>

    </div>

<%
} else {

    for (Document doc : documents) {

        String visibility =
                doc.getVisibility();

        String visibilityClass =
                "PUBLIC".equalsIgnoreCase(visibility)
                ? "public"
                : "private";
%>


<!-- =========================================================
     DOCUMENT CARD
========================================================= -->

<div class="documentCard">


    <!-- VISIBILITY -->

    <div class="documentVisibility <%=visibilityClass%>">

        <%=visibility%>

    </div>


    <!-- TITLE -->

    <div class="documentTitle">

        <%=doc.getTitle()%>

    </div>


    <!-- DESCRIPTION -->

    <div class="documentDescription">

        <%=doc.getDescription() != null
            ? doc.getDescription()
            : "No description available."%>

    </div>


    <!-- CATEGORY -->

    <div class="documentCategory">

        <i class="fa-solid fa-tag"></i>

        <%=doc.getCategory()%>

    </div>


    <!-- FILE -->

    <div class="documentFile">

        <i class="fa-solid fa-file"></i>

        <%=doc.getFileName()%>

    </div>


    <!-- BUTTONS -->

    <div class="docButtons">


        <!-- PREVIEW -->

        <a
            href="PreviewServlet?id=<%=doc.getDocId()%>"
            class="previewBtn">

            <i class="fa-solid fa-eye"></i>

            Preview

        </a>


        <!-- DOWNLOAD -->

        <a
            href="DownloadServlet?id=<%=doc.getDocId()%>"
            class="downloadBtn">

            <i class="fa-solid fa-download"></i>

            Download

        </a>


        <%
        if (ownProfile) {
        %>


            <!-- EDIT -->

            <a
                href="EditDocumentServlet?id=<%=doc.getDocId()%>"
                class="editDocBtn">

                <i class="fa-solid fa-pen"></i>

                Edit

            </a>


            <!-- DELETE -->

            <a
                href="DeleteDocumentServlet?id=<%=doc.getDocId()%>"
                class="deleteBtn"
                onclick="return confirm('Delete this document?');">

                <i class="fa-solid fa-trash"></i>

                Delete

            </a>


        <%
        }
        %>

    </div>


    <!-- =====================================================
         LIKE & COMMENT COUNT
    ====================================================== -->

    <div class="documentStats">

        <span class="likeCount">

            <i class="fa-solid fa-heart"></i>

            <%=doc.getLikeCount()%> Likes

        </span>


        <span class="commentCount">

            <i class="fa-solid fa-comment"></i>

            <%=doc.getCommentCount()%> Comments

        </span>

    </div>


</div>


<%
    }
}
%>

</div>

</div>


<!-- =========================================================
     FOOTER
========================================================= -->

<footer>

    <hr>

    <h3>

        DOCHUB

    </h3>

    <p>

        Store Your Ideas • Share Your Knowledge

    </p>

    <p style="margin-top:10px;">

        © 2026 DOCHUB. All Rights Reserved.

    </p>

</footer>


<!-- =========================================================
     JAVASCRIPT
========================================================= -->

<script>

/* =========================================================
   PROFILE IMAGE
========================================================= */

const profile =
    document.querySelector(".profileImage");

if (profile) {

    profile.addEventListener(
        "mouseenter",
        function () {

            this.style.transform =
                "scale(1.05) rotate(2deg)";

        }
    );

    profile.addEventListener(
        "mouseleave",
        function () {

            this.style.transform =
                "scale(1) rotate(0deg)";

        }
    );
}


/* =========================================================
   BUTTON HOVER
========================================================= */

document
.querySelectorAll("a")
.forEach(function(btn) {

    btn.addEventListener(
        "mouseenter",
        function() {

            this.style.transform =
                "translateY(-2px)";

        }
    );

    btn.addEventListener(
        "mouseleave",
        function() {

            this.style.transform =
                "translateY(0px)";

        }
    );

});


/* =========================================================
   COUNTER ANIMATION
========================================================= */

document
.querySelectorAll(".statNumber")
.forEach(function(counter) {

    const target =
        parseInt(counter.innerText) || 0;

    let count = 0;

    if (target === 0) {

        counter.innerText = "0";

        return;
    }

    const speed =
        Math.max(
            1,
            Math.ceil(target / 40)
        );

    function updateCounter() {

        if (count < target) {

            count += speed;

            if (count > target) {

                count = target;

            }

            counter.innerText = count;

            requestAnimationFrame(
                updateCounter
            );
        }
    }

    updateCounter();

});


/* =========================================================
   SCROLL ANIMATION
========================================================= */

const cards =
    document.querySelectorAll(
        ".infoCard, .statCard, .documentCard"
    );

if ("IntersectionObserver" in window) {

    const observer =
        new IntersectionObserver(
            function(entries) {

                entries.forEach(
                    function(entry) {

                        if (entry.isIntersecting) {

                            entry.target.style.opacity =
                                "1";

                            entry.target.style.transform =
                                "translateY(0)";

                        }

                    }
                );

            },
            {
                threshold: 0.1
            }
        );

    cards.forEach(
        function(card) {

            card.style.opacity = "0";

            card.style.transform =
                "translateY(40px)";

            card.style.transition =
                "opacity .6s ease, transform .6s ease";

            observer.observe(card);

        }
    );
}


/* =========================================================
   SMOOTH SCROLL
========================================================= */

document.documentElement.style.scrollBehavior =
    "smooth";

</script>

</body>

</html>