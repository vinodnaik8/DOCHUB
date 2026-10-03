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

int totalFavorite=notes.size();
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
content="width=device-width, initial-scale=1.0">

<title>Favorite Notes | DOCHUB</title>

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

color:#f59e0b;

}

.backBtn{

background:#2563eb;

color:white;

padding:10px 20px;

border-radius:10px;

text-decoration:none;

font-weight:600;

}

.container{

width:92%;

margin:35px auto;

}

.statCard{

background:white;

padding:25px;

border-radius:18px;

text-align:center;

box-shadow:0 10px 25px rgba(0,0,0,.08);

margin-bottom:30px;

}

.statCard i{

font-size:40px;

color:#f59e0b;

margin-bottom:15px;

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

display:flex;

flex-direction:column;

justify-content:space-between;

min-height:260px;

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

line-height:1.7;

color:#333;

white-space:pre-wrap;

word-break:break-word;

margin-bottom:20px;

max-height:180px;

overflow:hidden;

}

.noteDate{

font-size:13px;

color:#555;

margin-top:10px;

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

padding:10px;

border-radius:10px;

text-align:center;

font-size:14px;

font-weight:600;

transition:.3s;

}

.edit{

background:#2563eb;

color:white;

}

.delete{

background:#dc2626;

color:white;

}

.pdf{

background:#198754;

color:white;

}

.bottomActions{

display:grid;

grid-template-columns:repeat(2,1fr);

gap:10px;

margin-top:12px;

}

.bottomActions a{

text-decoration:none;

padding:10px;

border-radius:10px;

text-align:center;

font-size:14px;

font-weight:600;

transition:.3s;

}

.favoriteBtn{

background:#f59e0b;

color:white;

}

.pinBtn{

background:#6b7280;

color:white;

}

.noteActions a:hover,
.bottomActions a:hover{

opacity:.9;

transform:scale(1.03);

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

</style>

</head>

<body>

<div class="header">

<div class="logo">

<i class="fa-solid fa-star"></i>

Favorite Notes

</div>

<a href="NotesServlet" class="backBtn">

<i class="fa-solid fa-arrow-left"></i>

Back to Notes

</a>

</div>

<div class="container">

<div class="statCard">

<i class="fa-solid fa-star"></i>

<h2><%=totalFavorite%></h2>

<p>Favorite Notes</p>

</div>

<div class="searchBar">

<input
type="text"
id="searchInput"
placeholder="Search favorite notes...">

<i class="fa-solid fa-magnifying-glass"></i>

</div>

<div class="noteGrid">
<%

if(notes.isEmpty()){

%>

<div class="empty">

<i class="fa-solid fa-star fa-5x"></i>

<h2>

No Favorite Notes

</h2>

<p>

Your favorite notes will appear here.

</p>

<a href="NotesServlet" class="backBtn">

Back to Notes

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

<span class="badge favorite">

<i class="fa-solid fa-star"></i>

Favorite

</span>

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

<i class="fa-solid fa-clock"></i>

Updated :

<%=note.getUpdatedAt()%>

</div>

<%

}

%>

</div>

<div class="noteActions">

<a

href="EditNoteServlet?id=<%=note.getNoteId()%>"

class="edit">

<i class="fa-solid fa-pen"></i>

Edit

</a>

<a

href="DeleteNoteServlet?id=<%=note.getNoteId()%>"

class="delete"

onclick="return confirm('Delete this note permanently?')">

<i class="fa-solid fa-trash"></i>

Delete

</a>

<a

href="ExportPDFServlet?id=<%=note.getNoteId()%>"

class="pdf">

<i class="fa-solid fa-file-pdf"></i>

Export PDF

</a>

</div>

<div class="bottomActions">

<a

href="FavoriteNoteServlet?id=<%=note.getNoteId()%>"

class="favoriteBtn">

<i class="fa-solid fa-star"></i>

Remove Favorite

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

</div>

</div>

<%

}

}

%>

</div>
<%

if("favorite".equals(request.getParameter("success"))){
%>

<div class="successMessage">

<i class="fa-solid fa-circle-check"></i>

Favorite updated successfully.

</div>

<%
}

if("delete".equals(request.getParameter("success"))){
%>

<div class="successMessage">

<i class="fa-solid fa-circle-check"></i>

Note deleted successfully.

</div>

<%
}

if("pin".equals(request.getParameter("success"))){
%>

<div class="successMessage">

<i class="fa-solid fa-circle-check"></i>

Pin updated successfully.

</div>

<%
}
%>

<style>

.successMessage{

background:#d1fae5;

color:#065f46;

padding:15px;

border-left:5px solid #10b981;

border-radius:10px;

margin-bottom:20px;

font-weight:600;

display:flex;

align-items:center;

gap:10px;

}

</style>

<script>

//================ SEARCH =================//

const search=document.getElementById("searchInput");

search.addEventListener("keyup",function(){

let value=this.value.toLowerCase();

let cards=document.querySelectorAll(".noteCard");

cards.forEach(card=>{

let text=card.innerText.toLowerCase();

card.style.display=text.includes(value) ? "flex" : "none";

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

//================ CARD ANIMATION =================//

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

//================ AUTO HIDE MESSAGE =================//

setTimeout(function(){

const msg=document.querySelector(".successMessage");

if(msg){

msg.style.display="none";

}

},3000);

</script>

</body>

</html>