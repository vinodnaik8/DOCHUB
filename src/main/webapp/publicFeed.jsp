<%@page import="java.util.List"%>
<%@page import="model.Document"%>
<%@page import="model.Comment"%>
<%@page import="model.User"%>

<%
User user=(User)session.getAttribute("user");

if(user==null){

    response.sendRedirect("login.jsp");

    return;

}

List<Document> documents=(List<Document>)request.getAttribute("documents");

if(documents==null){

    documents=new java.util.ArrayList<Document>();

}
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
content="width=device-width, initial-scale=1.0">

<title>DOCHUB Community</title>

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
rel="stylesheet">

<style>

*{

margin:0;

padding:0;

box-sizing:border-box;

font-family:'Poppins',sans-serif;

}

body{

background:#eef2f7;

}

/* ================= HEADER ================= */

.header{

height:75px;

background:#fff;

display:flex;

justify-content:space-between;

align-items:center;

padding:0 40px;

box-shadow:0 5px 20px rgba(0,0,0,.08);

position:sticky;

top:0;

z-index:999;

}

.logo{

font-size:28px;

font-weight:700;

color:#2563eb;

}

.logo i{

margin-right:8px;

}

.dashboardBtn{

text-decoration:none;

background:#2563eb;

color:white;

padding:11px 22px;

border-radius:10px;

font-weight:600;

transition:.3s;

}

.dashboardBtn:hover{

background:#174fc9;

}

/* ================= CONTAINER ================= */

.container{

width:92%;

max-width:1200px;

margin:35px auto;

}

/* ================= SEARCH ================= */

.searchBox{

position:relative;

margin-bottom:35px;

}

.searchBox input{

width:100%;

padding:16px 60px 16px 22px;

border:none;

outline:none;

border-radius:40px;

font-size:15px;

box-shadow:0 8px 20px rgba(0,0,0,.08);

}

.searchBox button{

position:absolute;

right:8px;

top:7px;

width:48px;

height:48px;

border:none;

border-radius:50%;

background:#2563eb;

color:white;

cursor:pointer;

font-size:18px;

}

/* ================= FEED ================= */

.feed{

display:flex;

flex-direction:column;

gap:28px;

}

.feedCard{

background:white;

border-radius:20px;

box-shadow:0 10px 25px rgba(0,0,0,.08);

overflow:hidden;

transition:.3s;

}

.feedCard:hover{

transform:translateY(-5px);

}
/* ================= USER INFO ================= */

.userInfo{

display:flex;

align-items:center;

gap:15px;

padding:20px;

border-bottom:1px solid #eee;

}

.userInfo img{

width:60px;

height:60px;

border-radius:50%;

object-fit:cover;

border:3px solid #2563eb;

}

.defaultProfile{

width:60px;

height:60px;

border-radius:50%;

background:#2563eb;

color:white;

display:flex;

justify-content:center;

align-items:center;

font-size:28px;

}

.userText{

flex:1;

}

.userText h3{

font-size:19px;

margin-bottom:4px;

color:#222;

}

.userText p{

font-size:14px;

color:#777;

}

/* ================= DOCUMENT ================= */

.docBody{

padding:25px;

}

.docTitle{

font-size:24px;

font-weight:700;

margin-bottom:15px;

color:#222;

}

.docDescription{

line-height:1.8;

color:#555;

margin-bottom:18px;

white-space:pre-wrap;

}

.category{

display:inline-block;

background:#2563eb;

color:white;

padding:6px 14px;

border-radius:20px;

font-size:13px;

margin-bottom:18px;

}

.fileName{

background:#f5f7fb;

padding:15px;

border-radius:12px;

font-weight:600;

margin-bottom:20px;

color:#444;

}

.fileName i{

margin-right:8px;

color:#2563eb;

}

/* ================= STATS ================= */

.stats{

display:flex;

gap:30px;

margin-bottom:20px;

font-size:15px;

color:#666;

}

.stats span{

display:flex;

align-items:center;

gap:6px;

}

/* ================= ACTION BUTTONS ================= */

.actions{

display:grid;

grid-template-columns:repeat(5,1fr);

gap:12px;

margin-top:15px;

}

.actions a{

text-decoration:none;

padding:12px;

text-align:center;

border-radius:10px;

font-size:14px;

font-weight:600;

transition:.3s;

}

.preview{

background:#6b7280;

color:white;

}

.download{

background:#2563eb;

color:white;

}

.profile{

background:#10b981;

color:white;

}

.like{

background:white;

border:1px solid #ddd;

color:#444;

display:flex;

justify-content:center;

align-items:center;

gap:8px;

}

.like:hover{

background:#fff5f5;

border-color:#ff1744;

color:#ff1744;

}

.actions a:hover{

transform:scale(1.03);

}

/* ================= COMMENTS ================= */

.commentSection{

margin-top:25px;

padding-top:20px;

border-top:1px solid #eee;

}

.commentCard{

background:#f8f9fb;

padding:12px;

border-radius:12px;

margin-bottom:12px;

}

.commentHeader{

display:flex;

justify-content:space-between;

align-items:center;

margin-bottom:6px;

}

.commentName{

font-weight:600;

}

.commentDate{

font-size:12px;

color:#777;

}

.commentText{

color:#444;

line-height:1.6;

}

/* ================= COMMENT FORM ================= */

.commentForm{

display:flex;

gap:10px;

margin-top:20px;

}

.commentForm input{

flex:1;

padding:12px;

border:1px solid #ddd;

border-radius:25px;

outline:none;

}

.commentForm input:focus{

border-color:#2563eb;

}

.commentForm button{

border:none;

background:#2563eb;

color:white;

padding:0 18px;

border-radius:25px;

cursor:pointer;

font-size:18px;

}

/* ================= EMPTY ================= */

.empty{

background:white;

padding:80px;

border-radius:20px;

text-align:center;

box-shadow:0 10px 25px rgba(0,0,0,.08);

}

.empty h2{

margin:20px 0;

}

.empty p{

color:#666;

}

/* ================= RESPONSIVE ================= */

@media(max-width:900px){

.actions{

grid-template-columns:repeat(2,1fr);

}

}

@media(max-width:650px){

.header{

flex-direction:column;

height:auto;

padding:15px;

gap:15px;

}

.actions{

grid-template-columns:1fr;

}

.userInfo{

flex-direction:column;

text-align:center;

}

.stats{

flex-direction:column;

gap:10px;

}

.commentForm{

flex-direction:column;

}

.commentForm button{

padding:12px;

}

}
.bookmark{

background:#f59e0b;

color:white;

}

.bookmark:hover{

background:#d97706;

color:white;

}

</style>

</head>

<body>

<div class="header">

<div class="logo">

<i class="fa-solid fa-earth-americas"></i>

DOCHUB Community

</div>

<a href="dashboard.jsp" class="dashboardBtn">

Dashboard

</a>

</div>

<div class="container">

<form action="PublicFeedServlet" method="get">

<div class="searchBox">

<input
type="text"
name="search"
placeholder="Search public documents...">

<button type="submit">

<i class="fa-solid fa-magnifying-glass"></i>

</button>

</div>

</form>

<div class="feed">
<%

if(documents.isEmpty()){

%>

<div class="empty">

<i class="fa-solid fa-folder-open fa-5x"></i>

<h2>No Public Documents</h2>

<p>

No public documents are available.

</p>

</div>

<%

}else{

for(Document doc : documents){

%>

<div class="feedCard"
id="doc<%=doc.getDocId()%>">

<!-- ================= USER INFO ================= -->

<div class="userInfo">

<%
if(doc.getProfilePic()!=null &&
!doc.getProfilePic().trim().isEmpty()){
%>

<img src="ViewProfilePicServlet?file=<%=java.net.URLEncoder.encode(doc.getProfilePic(), "UTF-8")%>"
     alt="Profile">

<%
}else{
%>

<div class="defaultProfile">

<i class="fa-solid fa-user"></i>

</div>

<%

}

%>

<div class="userText">

<h3>

<%=doc.getFullName()%>

</h3>

<p>

@<%=doc.getUsername()%>

</p>

</div>

</div>

<!-- ================= DOCUMENT BODY ================= -->

<div class="docBody">

<div class="docTitle">

<%=doc.getTitle()%>

</div>

<div class="docDescription">

<%=doc.getDescription()%>

</div>

<div class="category">

<i class="fa-solid fa-tag"></i>

<%=doc.getCategory()%>

</div>

<div class="fileName">

<i class="fa-solid fa-file"></i>

<%=doc.getFileName()%>

</div>

<!-- ================= STATS ================= -->

<div class="stats">

<span>

<i class="fa-solid fa-heart"
style="color:#ff1744;"></i>

<%=doc.getLikeCount()%>

</span>

<span>

<i class="fa-solid fa-comments"
style="color:#2563eb;"></i>

<%=doc.getCommentCount()%>

</span>

</div>

<!-- ================= ACTIONS ================= -->

<div class="actions">

    <a href="PreviewServlet?id=<%=doc.getDocId()%>&source=community" class="preview">
    <i class="fa-solid fa-eye"></i> Preview
</a>

    <a href="DownloadServlet?id=<%=doc.getDocId()%>" class="download">
        <i class="fa-solid fa-download"></i> Download
    </a>

    <a href="LikeServlet?id=<%=doc.getDocId()%>" class="like">

        <% if(doc.isLiked()){ %>

            <i class="fa-solid fa-heart" style="color:#ff1744;"></i>

        <% } else { %>

            <i class="fa-regular fa-heart"></i>

        <% } %>

        <span><%=doc.getLikeCount()%></span>

    </a>

    <a href="UserProfileServlet?id=<%=doc.getUserId()%>" class="profile">
        <i class="fa-solid fa-user"></i> Profile
    </a>

    <a href="BookmarkServlet?id=<%=doc.getDocId()%>" class="bookmark">

        <% if(doc.isBookmarked()){ %>

            <i class="fa-solid fa-bookmark"></i>

        <% } else { %>

            <i class="fa-regular fa-bookmark"></i>

        <% } %>

    </a>

</div>
<!-- ================= COMMENTS ================= -->

<div class="commentSection">

<h4 style="margin-bottom:15px;">

<i class="fa-solid fa-comments"></i>

Comments

</h4>

<%

if(doc.getComments()!=null && !doc.getComments().isEmpty()){

for(Comment c : doc.getComments()){

%>

<div class="commentCard">

<div class="commentHeader">

<div>

<div class="commentName">

<%=c.getFullName()%>

</div>

<div class="commentDate">

<%=c.getCreatedAt()%>

</div>

</div>

<%

if(user.getId()==c.getUserId()){

%>

<a

href="DeleteCommentServlet?id=<%=c.getId()%>"

onclick="return confirm('Delete this comment?')"

style="color:#dc2626;
text-decoration:none;">

<i class="fa-solid fa-trash"></i>

</a>

<%

}

%>

</div>

<div class="commentText">

<%=c.getComment()%>

</div>

</div>

<%

}

}else{

%>

<p style="color:#888;">

No comments yet.

Be the first to comment.

</p>

<%

}

%>

<!-- ================= ADD COMMENT ================= -->

<form

action="CommentServlet"

method="post"

class="commentForm">

<input

type="hidden"

name="docId"

value="<%=doc.getDocId()%>">

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

</div>

<%

}

}

%>

</div>
<script>

//================ LIVE SEARCH =================//

const searchBox=document.querySelector("input[name='search']");

if(searchBox){

searchBox.addEventListener("keyup",function(){

let value=this.value.toLowerCase();

let cards=document.querySelectorAll(".feedCard");

cards.forEach(card=>{

let text=card.innerText.toLowerCase();

if(text.includes(value)){

card.style.display="block";

}else{

card.style.display="none";

}

});

});

}

//================ CARD ANIMATION =================//

document.querySelectorAll(".feedCard").forEach(card=>{

card.addEventListener("mouseenter",function(){

this.style.transform="translateY(-8px)";

this.style.boxShadow="0 18px 35px rgba(0,0,0,.18)";

});

card.addEventListener("mouseleave",function(){

this.style.transform="translateY(0)";

this.style.boxShadow="0 10px 25px rgba(0,0,0,.08)";

});

});

//================ BUTTON ANIMATION =================//

document.querySelectorAll(".actions a").forEach(btn=>{

btn.addEventListener("mouseenter",function(){

this.style.transform="scale(1.05)";

});

btn.addEventListener("mouseleave",function(){

this.style.transform="scale(1)";

});

});

</script>

</body>

</html>