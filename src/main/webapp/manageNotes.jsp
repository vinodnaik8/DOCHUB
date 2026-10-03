<%@page import="java.util.List"%>
<%@page import="model.Admin"%>
<%@page import="model.Note"%>

<%
Admin admin=(Admin)session.getAttribute("admin");

if(admin==null){

    response.sendRedirect("adminLogin.jsp");

    return;

}

List<Note> notes=(List<Note>)request.getAttribute("notes");

if(notes==null){

    notes=new java.util.ArrayList<Note>();

}
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
content="width=device-width, initial-scale=1.0">

<title>Manage Notes | DOCHUB Admin</title>

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
outline:none;
border-radius:12px;
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

.pin{

color:#f59e0b;
font-size:20px;

}

.favorite{

color:#ef4444;
font-size:20px;

}

.archive{

color:#6b7280;
font-size:20px;

}

.deleteBtn{

background:#ef4444;
color:white;
padding:10px 18px;
border-radius:8px;
text-decoration:none;
display:inline-block;
transition:.3s;

}

.deleteBtn:hover{

background:#dc2626;

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

<a href="ManageDocumentsServlet">

<i class="fa-solid fa-file-lines"></i>

Manage Documents

</a>

<a href="ManageNotesServlet"
class="active">

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

Manage Notes

</h1>

</div>

<div class="searchBox">

<i class="fa-solid fa-magnifying-glass"></i>

<input
type="text"
id="searchNote"
placeholder="Search notes by title, owner or content">

</div>

<div class="tableBox">

<table>

<thead>

<tr>

<th>Title</th>

<th>Owner</th>

<th>Pinned</th>

<th>Favorite</th>

<th>Archived</th>

<th>Action</th>

</tr>

</thead>

<tbody id="noteTable">
<%

if(notes.isEmpty()){

%>

<tr>

<td colspan="6" style="padding:50px;">

<i class="fa-solid fa-note-sticky"
style="font-size:60px;color:#2563eb;"></i>

<h2 style="margin-top:20px;">

No Notes Found

</h2>

<p style="margin-top:10px;color:#666;">

There are no notes available.

</p>

</td>

</tr>

<%

}else{

for(Note note : notes){

%>

<tr>

<td>

<b>

<%=note.getTitle()%>

</b>

</td>

<td>

<%=note.getFullName()%>

</td>

<td>

<%

if(note.isPinned()){

%>

<i class="fa-solid fa-thumbtack pin"
title="Pinned"></i>

<%

}else{

%>

-

<%

}

%>

</td>

<td>

<%

if(note.isFavorite()){

%>

<i class="fa-solid fa-heart favorite"
title="Favorite"></i>

<%

}else{

%>

-

<%

}

%>

</td>

<td>

<%

if(note.isArchived()){

%>

<i class="fa-solid fa-box-archive archive"
title="Archived"></i>

<%

}else{

%>

-

<%

}

%>

</td>

<td>

<a

href="AdminDeleteNoteServlet?id=<%=note.getNoteId()%>"

class="deleteBtn"

onclick="return confirm('Delete this note permanently?');">

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

//=================================
// LIVE SEARCH
//=================================

const search=document.getElementById("searchNote");

search.addEventListener("keyup",function(){

let value=this.value.toLowerCase();

let rows=document.querySelectorAll("#noteTable tr");

rows.forEach(row=>{

let text=row.innerText.toLowerCase();

if(text.includes(value)){

row.style.display="";

}else{

row.style.display="none";

}

});

});

//=================================
// ROW ANIMATION
//=================================

document.querySelectorAll("#noteTable tr").forEach((row,index)=>{

row.style.opacity="0";

row.style.transform="translateY(25px)";

setTimeout(()=>{

row.style.transition=".45s";

row.style.opacity="1";

row.style.transform="translateY(0)";

},index*70);

});

//=================================
// DELETE BUTTON ANIMATION
//=================================

document.querySelectorAll(".deleteBtn").forEach(btn=>{

btn.addEventListener("mouseenter",function(){

this.style.transform="scale(1.05)";

});

btn.addEventListener("mouseleave",function(){

this.style.transform="scale(1)";

});

});

</script>

<style>

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

min-width:900px;

}

}

</style>

</body>

</html>