<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>
<%@ page import="model.Document"%>
<%@ page import="model.Comment"%>

<%
List<Document> feed=(List<Document>)request.getAttribute("feed");

if(feed==null){
    response.sendRedirect("dashboard.jsp");
    return;
}
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
content="width=device-width, initial-scale=1.0">

<title>Community Feed | DOCHUB</title>

<link rel="stylesheet"
href="css/feed.css">

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
rel="stylesheet">

</head>

<body>

<!-- ================= NAVBAR ================= -->

<nav class="navbar">

<div class="logo">

<i class="fa-solid fa-book-open"></i>

<span>DOCHUB</span>

</div>

<div class="searchBox">

<input
type="text"
placeholder="Search documents...">

<i class="fa-solid fa-magnifying-glass"></i>

</div>

<div class="navMenu">

<a href="dashboard.jsp">

<i class="fa-solid fa-house"></i>

Home

</a>

<a href="upload.jsp">

<i class="fa-solid fa-upload"></i>

Upload

</a>

<a href="ProfileServlet">

<i class="fa-solid fa-user"></i>

Profile

</a>

</div>

</nav>

<!-- ================= FEED ================= -->

<div class="feedContainer">

<h1>

🌍 Community Feed

</h1>

<%

if(feed.isEmpty()){

%>

<div class="emptyCard">

<i class="fa-solid fa-folder-open fa-5x"></i>

<h2>No Public Documents Available</h2>

<p>

Upload a public document to share with everyone.

</p>

<a
href="upload.jsp"
class="uploadBtn">

Upload Now

</a>

</div>

<%

}else{

for(Document d:feed){

String photo=d.getProfilePic();

if(photo==null || photo.trim().equals("")){

photo="default.png";

}

%>

<!-- ================= POST ================= -->

<div class="feedCard">

<div class="feedHeader">

<img
src="profile-image?file=<%=photo%>"
class="profilePic">

<div class="userInfo">

<h3>

<%=d.getFullName()%>

</h3>

<p>

@<%=d.getUsername()%>

</p>

</div>

<div class="menu">

<i class="fa-solid fa-ellipsis"></i>

</div>

</div>

<div class="feedBody">

<h2>

<%=d.getTitle()%>

</h2>

<span class="badge">

<%=d.getCategory()%>

</span>

<p class="description">

<%=d.getDescription()%>

</p>

<div class="filePreview">

<i class="fa-solid fa-file-lines fa-5x"></i>

<h4>

<%=d.getFileName()%>

</h4>

</div>

</div>
<!-- ================= ACTION BAR ================= -->

<div class="feedFooter">

<div class="stats">

<span>

<i class="fa-solid fa-heart text-danger"></i>

<%=d.getLikeCount()%> Likes

</span>

<span>

<i class="fa-solid fa-comment text-primary"></i>

<%=d.getCommentCount()%> Comments

</span>

</div>

<div class="actionButtons">

<a href="LikeServlet?id=<%=d.getDocId()%>" class="actionBtn">

<i class="fa-solid fa-heart"></i>

Like

</a>

<a
href="#commentBox<%=d.getDocId()%>"
class="actionBtn">

<i class="fa-solid fa-comment"></i>

Comment

</a>

<a href="SaveDocumentServlet?id=<%=d.getDocId()%>"
class="actionBtn">

<i class="fa-solid fa-bookmark"></i>

Save

</a>
<a
href="PreviewServlet?id=<%=d.getDocId()%>"
class="actionBtn">

<i class="fa-solid fa-eye"></i>

Preview

</a>

<a
href="uploads/<%=d.getFileName()%>"
download
class="actionBtn">

<i class="fa-solid fa-download"></i>

Download

</a>

</div>

</div>

<!-- ================= COMMENTS ================= -->

<div class="commentSection">

<h4>

Comments

</h4>

<%

if(d.getComments()!=null && d.getComments().size()>0){

for(Comment c : d.getComments()){

String img=c.getProfilePic();

if(img==null || img.trim().equals("")){

img="default.png";

}

%>

<div class="commentCard">

<img
src="profile-image?file=<%=img%>"
class="commentPic">

<div class="commentBody">

<h5>

<%=c.getFullName()%>

<span>

@<%=c.getUsername()%>

</span>

</h5>

<p>

<%=c.getComment()%>

</p>

</div>

</div>

<%

}

}else{

%>

<div class="noComment">

No comments yet.

</div>

<%

}

%>

<form
action="CommentServlet"
method="post"
class="commentForm"
id="commentBox<%=d.getDocId()%>">

<input
type="hidden"
name="docId"
value="<%=d.getDocId()%>">

<input
type="text"
name="comment"
placeholder="Write a comment..."
required>

<button type="submit">

<i class="fa-solid fa-paper-plane"></i>

</button>

</form>

</div>

</div>

<%

}

}

%>

</div>
<!-- ================= FLOATING UPLOAD ================= -->

<a href="upload.jsp" class="floatingUpload">

<i class="fa-solid fa-plus"></i>

</a>

<!-- ================= SCROLL TOP ================= -->

<button id="topBtn">

<i class="fa-solid fa-arrow-up"></i>

</button>

<script>

const topBtn=document.getElementById("topBtn");

window.onscroll=function(){

if(document.body.scrollTop>300 ||

document.documentElement.scrollTop>300){

topBtn.style.display="flex";

}else{

topBtn.style.display="none";

}

}

topBtn.onclick=function(){

window.scrollTo({

top:0,

behavior:"smooth"

});

}

</script>

</body>

</html>