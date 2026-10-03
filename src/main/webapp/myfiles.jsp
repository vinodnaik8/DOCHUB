<%@page import="java.util.List"%>
<%@page import="model.Document"%>
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

int totalDocuments=documents.size();

int publicCount=0;
int privateCount=0;

for(Document d:documents){

    if("PUBLIC".equalsIgnoreCase(d.getVisibility())){

        publicCount++;

    }else{

        privateCount++;

    }

}
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
content="width=device-width, initial-scale=1.0">

<title>My Files | DOCHUB</title>

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

.header{

height:75px;

background:#ffffff;

display:flex;

justify-content:space-between;

align-items:center;

padding:0 40px;

box-shadow:0 5px 20px rgba(0,0,0,.08);

position:sticky;

top:0;

z-index:1000;

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

background:#2563eb;

color:white;

padding:10px 22px;

border-radius:10px;

text-decoration:none;

font-weight:600;

transition:.3s;

}

.dashboardBtn:hover{

background:#174fc9;

}

.container{

width:92%;

margin:35px auto;

}

.success{

background:#d1fae5;

color:#065f46;

padding:15px;

border-left:5px solid #10b981;

border-radius:10px;

margin-bottom:25px;

font-weight:600;

display:flex;

align-items:center;

gap:10px;

}

.error{

background:#fee2e2;

color:#b91c1c;

padding:15px;

border-left:5px solid #ef4444;

border-radius:10px;

margin-bottom:25px;

font-weight:600;

display:flex;

align-items:center;

gap:10px;

}

.stats{

display:grid;

grid-template-columns:repeat(3,1fr);

gap:25px;

margin-bottom:30px;

}

.statCard{

background:white;

padding:25px;

border-radius:18px;

text-align:center;

box-shadow:0 8px 25px rgba(0,0,0,.08);

transition:.3s;

}

.statCard:hover{

transform:translateY(-5px);

}

.statCard i{

font-size:40px;

color:#2563eb;

margin-bottom:15px;

}

.statCard h2{

margin-bottom:8px;

font-size:32px;

}

.statCard p{

color:#666;

}

.searchBar{

margin-bottom:30px;

position:relative;

}

.searchBar input{

width:100%;

padding:15px 55px 15px 20px;

border:none;

outline:none;

border-radius:40px;

font-size:15px;

box-shadow:0 8px 25px rgba(0,0,0,.08);

}

.searchBar i{

position:absolute;

right:20px;

top:16px;

color:#666;

font-size:18px;

}

.fileGrid{

display:grid;

grid-template-columns:repeat(auto-fill,minmax(350px,1fr));

gap:25px;

}

.fileCard{

background:white;

border-radius:20px;

padding:25px;

box-shadow:0 10px 25px rgba(0,0,0,.08);

transition:.3s;

}

.fileCard:hover{

transform:translateY(-6px);

}

.fileIcon{

text-align:center;

margin-bottom:20px;

}

.fileIcon i{

font-size:70px;

}

.fileInfo h3{

margin-bottom:10px;

word-break:break-word;

}

.fileInfo p{

margin:7px 0;

font-size:14px;

color:#666;

}

.fileActions{

display:grid;

grid-template-columns:repeat(2,1fr);

gap:12px;

margin-top:20px;

}

.fileActions a{

text-decoration:none;

padding:12px;

text-align:center;

border-radius:10px;

font-size:14px;

font-weight:600;

transition:.3s;

}

.previewBtn{

background:#6b7280;

color:white;

}

.download{

background:#2563eb;

color:white;

}

.edit{

background:#f59e0b;

color:black;

}

.delete{

background:#dc2626;

color:white;

}

.fileActions a:hover{

opacity:.9;

transform:scale(1.03);

}

.empty{

grid-column:1/-1;

background:white;

padding:80px;

text-align:center;

border-radius:20px;

box-shadow:0 10px 25px rgba(0,0,0,.08);

}

.empty h2{

margin:20px 0;

}

.empty p{

color:#666;

margin-bottom:25px;

}

@media(max-width:900px){

.stats{

grid-template-columns:1fr;

}

.fileGrid{

grid-template-columns:1fr;

}

}

@media(max-width:600px){

.header{

padding:15px;

flex-direction:column;

height:auto;

gap:15px;

}

.container{

width:96%;

}

.fileActions{

grid-template-columns:1fr;

}

}

</style>

</head>
<body>

<!-- ================= HEADER ================= -->

<div class="header">

    <div class="logo">

        <i class="fa-solid fa-folder-open"></i>

        DOCHUB

    </div>

    <a href="dashboard.jsp" class="dashboardBtn">

        <i class="fa-solid fa-house"></i>

        Dashboard

    </a>

</div>

<!-- ================= CONTAINER ================= -->

<div class="container">

<%

if("success".equals(request.getParameter("delete"))){

%>

<div class="success">

<i class="fa-solid fa-circle-check"></i>

Document deleted successfully.

</div>

<%

}

if("failed".equals(request.getParameter("delete"))){

%>

<div class="error">

<i class="fa-solid fa-circle-xmark"></i>

You are not allowed to delete this document.

</div>

<%

}

%>

<!-- ================= PAGE TITLE ================= -->

<h1 style="margin-bottom:25px;">

<i class="fa-solid fa-folder"></i>

My Documents

</h1>

<!-- ================= STATISTICS ================= -->

<div class="stats">

<div class="statCard">

<i class="fa-solid fa-file-lines"></i>

<h2>

<%=totalDocuments%>

</h2>

<p>

Total Documents

</p>

</div>

<div class="statCard">

<i class="fa-solid fa-globe"></i>

<h2>

<%=publicCount%>

</h2>

<p>

Public Documents

</p>

</div>

<div class="statCard">

<i class="fa-solid fa-lock"></i>

<h2>

<%=privateCount%>

</h2>

<p>

Private Documents

</p>

</div>

</div>

<!-- ================= SEARCH ================= -->

<div class="searchBar">

<input

type="text"

id="searchInput"

placeholder="Search by title, category or filename...">

<i class="fa-solid fa-magnifying-glass"></i>

</div>

<!-- ================= UPLOAD BUTTON ================= -->

<div style="margin-bottom:30px;">

<a

href="upload.jsp"

class="dashboardBtn">

<i class="fa-solid fa-upload"></i>

Upload New Document

</a>

</div>

<!-- ================= DOCUMENT GRID ================= -->

<div class="fileGrid">
<%

if(documents.isEmpty()){

%>

<div class="empty">

<i class="fa-solid fa-folder-open fa-5x"></i>

<h2>

No Documents Uploaded

</h2>

<p>

Upload your first document to get started.

</p>

<a href="upload.jsp" class="dashboardBtn">

<i class="fa-solid fa-upload"></i>

Upload Document

</a>

</div>

<%

}else{

for(Document d : documents){

String fileName=d.getFileName().toLowerCase();

String icon="fa-file";
String color="#2563eb";

if(fileName.endsWith(".pdf")){

icon="fa-file-pdf";
color="#dc3545";

}
else if(fileName.endsWith(".doc") || fileName.endsWith(".docx")){

icon="fa-file-word";
color="#0d6efd";

}
else if(fileName.endsWith(".ppt") || fileName.endsWith(".pptx")){

icon="fa-file-powerpoint";
color="#fd7e14";

}
else if(fileName.endsWith(".xls") || fileName.endsWith(".xlsx")){

icon="fa-file-excel";
color="#198754";

}
else if(fileName.endsWith(".zip")){

icon="fa-file-zipper";
color="#6f42c1";

}
else if(fileName.endsWith(".png")
|| fileName.endsWith(".jpg")
|| fileName.endsWith(".jpeg")
|| fileName.endsWith(".gif")){

icon="fa-file-image";
color="#20c997";

}

%>

<div class="fileCard">

<div class="fileIcon">

<i class="fa-solid <%=icon%>"

style="color:<%=color%>;"></i>

</div>

<div class="fileInfo">

<h3>

<%=d.getTitle()%>

</h3>

<p>

<b>File :</b>

<%=d.getFileName()%>

</p>

<p>

<b>Category :</b>

<%=d.getCategory()%>

</p>

<p>

<b>Description :</b>

<%=d.getDescription()%>

</p>

<p>

<b>Visibility :</b>

<%

if("PUBLIC".equalsIgnoreCase(d.getVisibility())){

%>

<span style="color:#16a34a;font-weight:bold;">

 Public

</span>

<%

}else{

%>

<span style="color:#dc2626;font-weight:bold;">

 Private

</span>

<%

}

%>

</p>

</div>

<div class="fileActions">


<a href="PreviewServlet?id=<%=d.getDocId()%>&source=myfiles" class="preview">

<i class="fa-solid fa-eye"></i>

Preview

</a>

<a
href="DownloadServlet?id=<%=d.getDocId()%>"
class="download">

<i class="fa-solid fa-download"></i>

Download

</a>

<a
href="EditDocumentServlet?id=<%=d.getDocId()%>"
class="edit">

<i class="fa-solid fa-pen"></i>

Edit

</a>

<a
href="DeleteMyDocumentServlet?id=<%=d.getDocId()%>"
class="delete"

onclick="return confirm('Delete this document permanently?')">

<i class="fa-solid fa-trash"></i>

Delete

</a>

</div>

</div>

<%

}

}

%>

</div>
</div>

<!-- ================= JAVASCRIPT ================= -->

<script>

//==================== SEARCH ====================//

const searchInput = document.getElementById("searchInput");

searchInput.addEventListener("keyup", function () {

    let value = this.value.toLowerCase();

    let cards = document.querySelectorAll(".fileCard");

    cards.forEach(function(card){

        let text = card.innerText.toLowerCase();

        if(text.includes(value)){

            card.style.display = "block";

        }else{

            card.style.display = "none";

        }

    });

});

//==================== CARD HOVER EFFECT ====================//

const cards = document.querySelectorAll(".fileCard");

cards.forEach(function(card){

    card.addEventListener("mouseenter",function(){

        card.style.boxShadow="0 18px 40px rgba(37,99,235,.25)";

    });

    card.addEventListener("mouseleave",function(){

        card.style.boxShadow="0 10px 25px rgba(0,0,0,.08)";

    });

});

//==================== DELETE CONFIRM ====================//

document.querySelectorAll(".delete").forEach(function(btn){

    btn.addEventListener("click",function(e){

        if(!confirm("Are you sure you want to delete this document permanently?")){

            e.preventDefault();

        }

    });

});

</script>

</body>

</html>