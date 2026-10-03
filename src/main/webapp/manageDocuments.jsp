<%@page import="java.util.List"%>
<%@page import="model.Admin"%>
<%@page import="model.Document"%>

<%
Admin admin=(Admin)session.getAttribute("admin");

if(admin==null){

    response.sendRedirect("adminLogin.jsp");

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

<title>Manage Documents | DOCHUB Admin</title>

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
display:flex;
background:#eef2f7;
}

/* Sidebar */

.sidebar{

width:260px;
height:100vh;
background:#2563eb;
position:fixed;
left:0;
top:0;
padding:30px 20px;
color:white;

}

.sidebar h2{

text-align:center;
margin-bottom:40px;

}

.sidebar a{

display:block;
padding:15px;
margin-bottom:10px;
color:white;
text-decoration:none;
border-radius:10px;
transition:.3s;

}

.sidebar a:hover,
.sidebar .active{

background:white;
color:#2563eb;

}

/* Main */

.main{

margin-left:260px;
width:100%;
padding:35px;

}

/* Header */

.header{

display:flex;
justify-content:space-between;
align-items:center;
margin-bottom:30px;

}

.header h1{

font-size:32px;
color:#222;

}

/* Search */

.searchBox{

position:relative;
margin-bottom:25px;

}

.searchBox input{

width:100%;
padding:15px 20px 15px 50px;
border:none;
border-radius:12px;
outline:none;
font-size:15px;
box-shadow:0 8px 20px rgba(0,0,0,.08);

}

.searchBox i{

position:absolute;
left:18px;
top:17px;
color:#777;

}

/* Table */

.tableBox{

background:white;
border-radius:20px;
overflow:hidden;
box-shadow:0 10px 25px rgba(0,0,0,.08);

}

table{

width:100%;
border-collapse:collapse;

}

thead{

background:#2563eb;
color:white;

}

th{

padding:18px;
font-size:15px;

}

td{

padding:18px;
text-align:center;
border-bottom:1px solid #eee;

}

tr:hover{

background:#f8fbff;

}

/* Buttons */

.previewBtn,
.downloadBtn,
.deleteBtn{

display:inline-block;
padding:10px 15px;
border-radius:8px;
text-decoration:none;
color:white;
margin:2px;
transition:.3s;

}

.previewBtn{

background:#6b7280;

}

.downloadBtn{

background:#2563eb;

}

.deleteBtn{

background:#ef4444;

}

.previewBtn:hover{

background:#4b5563;

}

.downloadBtn:hover{

background:#1d4ed8;

}

.deleteBtn:hover{

background:#dc2626;

}

.public{

color:#16a34a;
font-weight:600;

}

.private{

color:#dc2626;
font-weight:600;

}

</style>

</head>

<body>

<div class="sidebar">

<h2>

<i class="fa-solid fa-user-shield"></i>

DOCHUB

</h2>

<a href="AdminDashboardServlet">

<i class="fa-solid fa-house"></i>

Dashboard

</a>

<a href="ManageUsersServlet">

<i class="fa-solid fa-users"></i>

Manage Users

</a>

<a href="ManageDocumentsServlet"
class="active">

<i class="fa-solid fa-file-lines"></i>

Manage Documents

</a>

<a href="ManageNotesServlet">

<i class="fa-solid fa-note-sticky"></i>

Manage Notes

</a>

<a href="AnalyticsServlet">

<i class="fa-solid fa-chart-line"></i>

Analytics

</a>

<a href="AdminSettingsServlet">

<i class="fa-solid fa-gear"></i>

Settings

</a>

<a href="AdminLogoutServlet">

<i class="fa-solid fa-right-from-bracket"></i>

Logout

</a>

</div>

<div class="main">

<div class="header">

<h1>

Manage Documents

</h1>

</div>

<div class="searchBox">

<i class="fa-solid fa-magnifying-glass"></i>

<input
type="text"
id="searchDocument"
placeholder="Search documents by title, owner or category">

</div>

<div class="tableBox">

<table>

<thead>

<tr>

<th>Title</th>

<th>Owner</th>

<th>Category</th>

<th>Visibility</th>

<th>Actions</th>

</tr>

</thead>

<tbody id="documentTable">
<%

if(documents.isEmpty()){

%>

<tr>

<td colspan="5" style="padding:45px;">

<i class="fa-solid fa-folder-open"
style="font-size:60px;color:#2563eb;"></i>

<h2 style="margin-top:20px;">

No Documents Found

</h2>

<p style="margin-top:10px;color:#666;">

There are no uploaded documents.

</p>

</td>

</tr>

<%

}else{

for(Document doc : documents){

%>

<tr>

<td>

<b>

<%=doc.getTitle()%>

</b>

</td>

<td>

<%=doc.getFullName()%>

</td>

<td>

<%=doc.getCategory()%>

</td>

<td>

<%

if("PUBLIC".equalsIgnoreCase(doc.getVisibility())){

%>

<span class="public">

<i class="fa-solid fa-globe"></i>

PUBLIC

</span>

<%

}else{

%>

<span class="private">

<i class="fa-solid fa-lock"></i>

PRIVATE

</span>

<%

}

%>

</td>

<td>

<a
href="PreviewServlet?id=<%=doc.getDocId()%>"
class="previewBtn">

<i class="fa-solid fa-eye"></i>

Preview

</a>

<a
href="DownloadServlet?id=<%=doc.getDocId()%>"
class="downloadBtn">

<i class="fa-solid fa-download"></i>

Download

</a>

<a
href="DeleteDocumentServlet?id=<%=doc.getDocId()%>"
class="deleteBtn"

onclick="return confirm('Delete this document permanently?');">

<i class="fa-solid fa-trash"></i>

Delete

</a>

</td>

</tr>

<%

}

}

%>

</tbody>

</table>

</div>

</div>
<script>

//==============================
// LIVE SEARCH
//==============================

const search=document.getElementById("searchDocument");

search.addEventListener("keyup",function(){

let value=this.value.toLowerCase();

let rows=document.querySelectorAll("#documentTable tr");

rows.forEach(row=>{

let text=row.innerText.toLowerCase();

if(text.includes(value)){

row.style.display="";

}else{

row.style.display="none";

}

});

});

//==============================
// ROW ANIMATION
//==============================

document.querySelectorAll("#documentTable tr").forEach((row,index)=>{

row.style.opacity="0";

row.style.transform="translateY(25px)";

setTimeout(()=>{

row.style.transition=".45s";

row.style.opacity="1";

row.style.transform="translateY(0)";

},index*70);

});

//==============================
// BUTTON ANIMATION
//==============================

document.querySelectorAll(".previewBtn,.downloadBtn,.deleteBtn")
.forEach(btn=>{

btn.addEventListener("mouseenter",function(){

this.style.transform="scale(1.05)";

});

btn.addEventListener("mouseleave",function(){

this.style.transform="scale(1)";

});

});

</script>

<style>

.previewBtn,
.downloadBtn,
.deleteBtn{

transition:.25s;

}

/* ==============================
Responsive
============================== */

@media(max-width:1000px){

.sidebar{

width:220px;

}

.main{

margin-left:220px;

padding:20px;

}

}

@media(max-width:850px){

.sidebar{

position:relative;

width:100%;

height:auto;

}

.main{

margin-left:0;

}

.header{

flex-direction:column;

align-items:flex-start;

gap:15px;

}

.tableBox{

overflow-x:auto;

}

table{

min-width:950px;

}

}

</style>

</body>

</html>