<%@page import="java.util.List"%>
<%@page import="model.Note"%>
<%@page import="model.User"%>

<%
User user=(User)session.getAttribute("user");

if(user==null){

    response.sendRedirect("login.jsp");

    return;

}

List<Note> notes=(List<Note>)request.getAttribute("notes");

if(notes==null){

    notes=new java.util.ArrayList<Note>();

}

int totalNotes = notes.size();

int pinned = 0;
int favorite = 0;
Integer archivedObj = (Integer)request.getAttribute("archivedCount");

int archived = (archivedObj != null) ? archivedObj : 0;

for(Note n : notes){

    if(n.isPinned()){
        pinned++;
    }

    if(n.isFavorite()){
        favorite++;
    }


}
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
content="width=device-width, initial-scale=1.0">

<title>My Notes | DOCHUB</title>

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

padding:10px 20px;

border-radius:10px;

font-weight:600;

}

.container{

width:92%;

margin:35px auto;

}

.stats{
display:grid;

grid-template-columns:repeat(4,1fr);

gap:20px;

margin-bottom:30px;

}

.statCard{

background:white;

padding:25px;

border-radius:18px;

text-align:center;

box-shadow:0 10px 25px rgba(0,0,0,.08);

transition:.3s;

}

.statCard:hover{

transform:translateY(-5px);

}

.statCard i{

font-size:38px;

color:#2563eb;

margin-bottom:15px;

}

.statCard h2{

margin-bottom:8px;

}

.searchBar{

margin-bottom:25px;

position:relative;

}

.searchBar input{

width:100%;

padding:15px 55px 15px 20px;

border:none;

border-radius:30px;

outline:none;

font-size:15px;

box-shadow:0 10px 25px rgba(0,0,0,.08);

}

.searchBar i{

position:absolute;

right:20px;

top:17px;

color:#666;

}

.topActions{

display:flex;

justify-content:space-between;

align-items:center;

margin-bottom:25px;

}

.newBtn{

background:#2563eb;

color:white;

padding:12px 22px;

border-radius:10px;

text-decoration:none;

font-weight:600;

}

.newBtn:hover{

background:#174fc9;

}
.noteGrid{

display:grid;

grid-template-columns:repeat(auto-fill,minmax(320px,1fr));

gap:25px;

}

.noteCard{

padding:22px;

border-radius:18px;

box-shadow:0 10px 25px rgba(0,0,0,.08);

transition:.3s;

position:relative;

min-height:240px;

display:flex;

flex-direction:column;

justify-content:space-between;

}

.noteCard:hover{

transform:translateY(-6px);

}

.noteTitle{

font-size:22px;

font-weight:600;

margin-bottom:15px;

word-break:break-word;

}

.noteContent{

color:#333;

line-height:1.7;

white-space:pre-wrap;

word-break:break-word;

margin-bottom:20px;

max-height:180px;

overflow:hidden;

}

.noteDate{

font-size:13px;

color:#555;

margin-top:12px;

}

.badges{

margin-bottom:12px;

}

.badge{

display:inline-block;

padding:5px 10px;

border-radius:20px;

font-size:12px;

font-weight:600;

margin-right:8px;

}

.pin{

background:#2563eb;

color:white;

}

.favorite{

background:#facc15;

color:#222;

}

.noteActions{

display:grid;

grid-template-columns:repeat(3,1fr);

gap:10px;

margin-top:20px;

}

.noteActions a{

text-decoration:none;

text-align:center;

padding:10px;

border-radius:10px;

font-size:14px;

font-weight:600;

transition:.3s;

}

.edit{

background:#2563eb;

color:white;

}

.archive{

background:#6b7280;

color:white;

transition:.3s;

}

.archive:hover{

background:#495057;

}

.delete{

background:#dc2626;

color:white;

}

.noteActions a:hover{

opacity:.9;

transform:scale(1.03);

}

.bottomActions{

display:grid;

grid-template-columns:repeat(3,1fr);

gap:10px;

margin-top:12px;

}

.bottomActions a{

text-decoration:none;

padding:10px;

text-align:center;

border-radius:10px;

font-size:14px;

font-weight:600;

transition:.3s;

}

.favoriteBtn{

background:#facc15;

color:#222;

transition:.3s;

}

.favoriteBtn:hover{

background:#eab308;

}

.pinBtn{

background:#2563eb;

color:white;

}

.pdfBtn{

background:#198754;

color:white;

}

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

margin-bottom:25px;

}

@media(max-width:900px){

.stats{

grid-template-columns:1fr;

}

.topActions{

flex-direction:column;

align-items:stretch;

gap:15px;

}

.noteGrid{

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

.noteActions{

grid-template-columns:1fr;

}

.bottomActions{

grid-template-columns:1fr;

}

}
.successMessage{

background:#d1fae5;

color:#065f46;

padding:15px;

margin-bottom:20px;

border-left:5px solid #10b981;

border-radius:10px;

font-weight:600;

display:flex;

align-items:center;

gap:10px;

}

</style>

</head>

<body>

<div class="header">

<div class="logo">

<i class="fa-solid fa-note-sticky"></i>

DOCHUB Notes

</div>

<a href="dashboard.jsp" class="dashboardBtn">

Dashboard

</a>

</div>

<div class="container">

<div class="stats">

<div class="statCard">

<i class="fa-solid fa-note-sticky"></i>

<h2><%=totalNotes%></h2>

<p>Total Notes</p>

</div>

<div class="statCard">

<i class="fa-solid fa-thumbtack"></i>

<h2><%=pinned%></h2>

<p>Pinned Notes</p>

</div>

<div class="statCard">

<i class="fa-solid fa-star"></i>

<h2><%=favorite%></h2>

<p>Favorite Notes</p>

</div>
<div class="statCard">

<i class="fa-solid fa-box-archive"></i>

<h2><%=archived%></h2>

<p>Archived Notes</p>

</div>

</div>

<div class="topActions">

<div style="display:flex;gap:15px;flex-wrap:wrap;">

<a href="createNote.jsp" class="newBtn">

<i class="fa-solid fa-plus"></i>

New Note

</a>

<a href="FavoriteNotesServlet"
class="newBtn"
style="background:#f59e0b;">

<i class="fa-solid fa-star"></i>

Favorite Notes

</a>

<a href="ArchivedNotesServlet"
class="newBtn"
style="background:#6b7280;">

<i class="fa-solid fa-box-archive"></i>

Archived Notes

</a>

</div>

</div>

<div class="searchBar">

<input

type="text"

id="searchInput"

placeholder="Search notes...">

<i class="fa-solid fa-magnifying-glass"></i>

</div>

<div class="noteGrid">
<%

if(notes.isEmpty()){

%>

<div class="empty">

<i class="fa-solid fa-note-sticky fa-5x"></i>

<h2>

No Notes Found

</h2>

<p>

Create your first note to get started.

</p>

<a href="createNote.jsp" class="newBtn">

<i class="fa-solid fa-plus"></i>

Create Note

</a>

</div>

<%

}else{

for(Note note : notes){

%>

<div class="noteCard"

style="background:<%=note.getColor()%>;">

<div>

<div class="badges">

<%

if(note.isPinned()){

%>

<span class="badge pin">

<i class="fa-solid fa-thumbtack"></i>

Pinned

</span>

<%

}

%>

<%

if(note.isFavorite()){

%>

<span class="badge favorite">

<i class="fa-solid fa-star"></i>

Favorite

</span>

<%

}

%>

</div>

<div class="noteTitle">

<%=note.getTitle()%>

</div>

<div class="noteContent">

<%=note.getContent()%>

</div>

<div class="noteDate">

<i class="fa-solid fa-calendar-days"></i>

Created :

<%=note.getCreatedAt()%>

</div>

<%

if(note.getUpdatedAt()!=null){

%>

<div class="noteDate">

<i class="fa-solid fa-clock-rotate-left"></i>

Updated :

<%=note.getUpdatedAt()%>

</div>

<%

}

%>

</div>

<!-- ================= TOP ACTIONS ================= -->

<div class="noteActions">

<a

href="EditNoteServlet?id=<%=note.getNoteId()%>"

class="edit">

<i class="fa-solid fa-pen"></i>

Edit

</a>

<a
href="ArchiveNoteServlet?id=<%=note.getNoteId()%>"
class="archive">

<%
if(note.isArchived()){
%>

<i class="fa-solid fa-box-open"></i>

Restore

<%
}else{
%>

<i class="fa-solid fa-box-archive"></i>

Archive

<%
}
%>

</a>

<a

href="DeleteNoteServlet?id=<%=note.getNoteId()%>"

class="delete"

onclick="return confirm('Delete this note?')">

<i class="fa-solid fa-trash"></i>

Delete

</a>

</div>

<!-- ================= BOTTOM ACTIONS ================= -->

<div class="bottomActions">

<a
href="FavoriteNoteServlet?id=<%=note.getNoteId()%>"
class="favoriteBtn">

<%
if(note.isFavorite()){
%>

<i class="fa-solid fa-star"></i>

Remove Favorite

<%
}else{
%>

<i class="fa-regular fa-star"></i>

Add Favorite

<%
}
%>

</a>

<a

href="PinNoteServlet?id=<%=note.getNoteId()%>"

class="pinBtn">

<%

if(note.isPinned()){

%>

<i class="fa-solid fa-thumbtack"></i>

Unpin

<%

}else{

%>

<i class="fa-solid fa-thumbtack"></i>

Pin

<%

}

%>

</a>

<a

href="ExportPDFServlet?id=<%=note.getNoteId()%>"

class="pdfBtn">

<i class="fa-solid fa-file-pdf"></i>

PDF

</a>

</div>

</div>

<%

}

}

%>

</div>
<!-- ================= SUCCESS / ERROR MESSAGE ================= -->

<%

if("create".equals(request.getParameter("success"))){

%>

<script>

window.onload=function(){

alert("Note created successfully.");

}

</script>

<%

}

%>

<%

if("update".equals(request.getParameter("success"))){

%>

<script>

<%
if("create".equals(request.getParameter("success"))){
%>

<div class="successMessage">

<i class="fa-solid fa-circle-check"></i>

Note created successfully.

</div>

<%
}
%>

</script>

<%

}

%>

<%

if("delete".equals(request.getParameter("success"))){

%>

<script>

window.onload=function(){

alert("Note deleted successfully.");

}

</script>

<%

}

%>

<script>

//================ SEARCH =================//

const search=document.getElementById("searchInput");

search.addEventListener("keyup",function(){

let value=this.value.toLowerCase();

let cards=document.querySelectorAll(".noteCard");

cards.forEach(card=>{

let text=card.innerText.toLowerCase();

if(text.includes(value)){

card.style.display="flex";

}else{

card.style.display="none";

}

});

});

//================ DELETE CONFIRM =================//

document.querySelectorAll(".delete").forEach(btn=>{

btn.addEventListener("click",function(e){

if(!confirm("Delete this note permanently?")){

e.preventDefault();

}

});

});

//================ CARD HOVER =================//

document.querySelectorAll(".noteCard").forEach(card=>{

card.addEventListener("mouseenter",function(){

card.style.transform="translateY(-8px)";

card.style.boxShadow="0 18px 35px rgba(0,0,0,.18)";

});

card.addEventListener("mouseleave",function(){

card.style.transform="translateY(0px)";

card.style.boxShadow="0 10px 25px rgba(0,0,0,.08)";

});

});

//================ AUTO HIDE ALERT =================//

setTimeout(function(){

const alert=document.querySelector(".successMessage");

if(alert){

alert.style.display="none";

}

},3000);

</script>
</body>

</html>