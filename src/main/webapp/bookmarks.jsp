<%@page import="java.util.List"%>
<%@page import="model.Document"%>
<%@page import="model.User"%>

<%
User user=(User)session.getAttribute("user");

if(user==null){

    response.sendRedirect("login.jsp");
    return;

}

List<Document> bookmarks=(List<Document>)request.getAttribute("bookmarks");

if(bookmarks==null){

    bookmarks=new java.util.ArrayList<Document>();

}
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
content="width=device-width, initial-scale=1.0">

<title>My Bookmarks | DOCHUB</title>

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

background:white;

display:flex;

justify-content:space-between;

align-items:center;

padding:0 40px;

box-shadow:0 5px 20px rgba(0,0,0,.08);

}

.logo{

font-size:28px;

font-weight:700;

color:#2563eb;

}

.dashboardBtn{

text-decoration:none;

background:#2563eb;

color:white;

padding:10px 22px;

border-radius:10px;

font-weight:600;

}

.container{

width:92%;

max-width:1200px;

margin:35px auto;

}

/* ================= SEARCH ================= */

.searchBox{

position:relative;

margin-bottom:30px;

}

.searchBox input{

width:100%;

padding:15px 60px 15px 20px;

border:none;

outline:none;

border-radius:30px;

font-size:15px;

box-shadow:0 10px 25px rgba(0,0,0,.08);

}

.searchBox i{

position:absolute;

right:22px;

top:18px;

font-size:18px;

color:#666;

}

/* ================= GRID ================= */

.bookmarkGrid{

display:grid;

grid-template-columns:repeat(auto-fill,minmax(350px,1fr));

gap:25px;

}
/* ================= CARD ================= */

.bookmarkCard{

background:white;

border-radius:20px;

padding:22px;

box-shadow:0 10px 25px rgba(0,0,0,.08);

transition:.3s;

display:flex;

flex-direction:column;

justify-content:space-between;

}

.bookmarkCard:hover{

transform:translateY(-6px);

}

/* ================= USER ================= */

.userInfo{

display:flex;

align-items:center;

gap:15px;

margin-bottom:20px;

}

.userInfo img{

width:55px;

height:55px;

border-radius:50%;

object-fit:cover;

border:3px solid #2563eb;

}

.defaultProfile{

width:55px;

height:55px;

border-radius:50%;

background:#2563eb;

color:white;

display:flex;

justify-content:center;

align-items:center;

font-size:24px;

}

.userText h3{

font-size:18px;

margin-bottom:4px;

color:#222;

}

.userText p{

font-size:13px;

color:#777;

}

/* ================= DOCUMENT ================= */

.docTitle{

font-size:22px;

font-weight:700;

margin-bottom:12px;

color:#222;

}

.docDescription{

line-height:1.7;

color:#555;

margin-bottom:15px;

max-height:120px;

overflow:hidden;

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

padding:14px;

border-radius:10px;

font-weight:600;

margin-bottom:20px;

color:#444;

}

/* ================= ACTIONS ================= */

.actions{

display:grid;

grid-template-columns:repeat(3,1fr);

gap:10px;

}

.actions a{

text-decoration:none;

text-align:center;

padding:12px;

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

.remove{

background:#dc2626;

color:white;

}

.actions a:hover{

transform:scale(1.03);

}

/* ================= EMPTY ================= */

.empty{

grid-column:1/-1;

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

@media(max-width:768px){

.bookmarkGrid{

grid-template-columns:1fr;

}

.header{

flex-direction:column;

height:auto;

padding:15px;

gap:15px;

}

.actions{

grid-template-columns:1fr;

}

}

</style>

</head>

<body>

<div class="header">

<div class="logo">

<i class="fa-solid fa-bookmark"></i>

My Bookmarks

</div>

<a href="dashboard.jsp" class="dashboardBtn">

Dashboard

</a>

</div>

<div class="container">

<div class="searchBox">

<input
type="text"
id="searchInput"
placeholder="Search bookmarked documents...">

<i class="fa-solid fa-magnifying-glass"></i>

</div>

<div class="bookmarkGrid">
<%

if(bookmarks.isEmpty()){

%>

<div class="empty">

<i class="fa-regular fa-bookmark fa-5x"></i>

<h2>No Bookmarked Documents</h2>

<p>

Save documents from the Community page to see them here.

</p>

</div>

<%

}else{

for(Document doc : bookmarks){

%>

<div class="bookmarkCard">

<!-- ================= USER INFO ================= -->

<div class="userInfo">

<%

if(doc.getProfilePic()!=null &&
!doc.getProfilePic().trim().isEmpty()){

%>


<img src="ViewProfilePicServlet?file=<%=doc.getProfilePic()%>"
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

<!-- ================= DOCUMENT ================= -->

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

<!-- ================= ACTION BUTTONS ================= -->

<div class="actions">


<a href="PreviewServlet?id=<%=doc.getDocId()%>&source=bookmark"

class="preview">

<i class="fa-solid fa-eye"></i>

Preview

</a>

<a

href="DownloadServlet?id=<%=doc.getDocId()%>"

class="download">

<i class="fa-solid fa-download"></i>

Download

</a>

<a

href="BookmarkServlet?id=<%=doc.getDocId()%>"

class="remove"

onclick="return confirm('Remove this bookmark?')">

<i class="fa-solid fa-bookmark"></i>

Remove

</a>

</div>

</div>

<%

}

}

%>

</div>
<script>

//================ SEARCH =================//

const search=document.getElementById("searchInput");

search.addEventListener("keyup",function(){

    let value=this.value.toLowerCase();

    let cards=document.querySelectorAll(".bookmarkCard");

    cards.forEach(card=>{

        let text=card.innerText.toLowerCase();

        if(text.includes(value)){

            card.style.display="flex";

        }else{

            card.style.display="none";

        }

    });

});

//================ CARD ANIMATION =================//

document.querySelectorAll(".bookmarkCard").forEach(card=>{

    card.addEventListener("mouseenter",function(){

        card.style.transform="translateY(-8px)";

        card.style.boxShadow="0 18px 35px rgba(0,0,0,.18)";

    });

    card.addEventListener("mouseleave",function(){

        card.style.transform="translateY(0)";

        card.style.boxShadow="0 10px 25px rgba(0,0,0,.08)";

    });

});

//================ BUTTON EFFECT =================//

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