<%@page import="model.Note"%>

<%
Note note=(Note)request.getAttribute("note");

if(note==null){

    response.sendRedirect("NotesServlet");

    return;

}
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
content="width=device-width, initial-scale=1.0">

<title>Edit Note | DOCHUB</title>

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

display:flex;

justify-content:center;

align-items:center;

min-height:100vh;

padding:30px;

}

.container{

width:800px;

background:white;

padding:35px;

border-radius:20px;

box-shadow:0 10px 25px rgba(0,0,0,.08);

}

h2{

margin-bottom:30px;

color:#2563eb;

text-align:center;

}

.form-group{

margin-bottom:22px;

}

label{

display:block;

margin-bottom:8px;

font-weight:600;

}

input[type=text]{

width:100%;

padding:15px;

border:1px solid #ddd;

border-radius:12px;

outline:none;

font-size:15px;

}

textarea{

width:100%;

height:250px;

padding:15px;

border:1px solid #ddd;

border-radius:12px;

resize:none;

outline:none;

font-size:15px;

}

input:focus,
textarea:focus{

border-color:#2563eb;

}

.colorBox{

display:flex;

align-items:center;

gap:15px;

}

input[type=color]{

width:60px;

height:45px;

border:none;

background:none;

cursor:pointer;

}

.info{

display:grid;

grid-template-columns:1fr 1fr;

gap:15px;

margin-top:20px;

}

.info div{

background:#f8fafc;

padding:15px;

border-radius:10px;

font-size:14px;

}

.buttons{

display:flex;

gap:15px;

margin-top:30px;

}

.update{

flex:1;

background:#2563eb;

color:white;

border:none;

padding:14px;

border-radius:10px;

cursor:pointer;

font-size:15px;

}

.update:hover{

background:#174fc9;

}

.cancel{

flex:1;

background:#6b7280;

color:white;

padding:14px;

text-align:center;

text-decoration:none;

border-radius:10px;

}

.cancel:hover{

background:#555;

}

</style>

</head>

<body>

<div class="container">

<h2>

<i class="fa-solid fa-pen"></i>

Edit Note

</h2>

<form
action="UpdateNoteServlet"
method="post">

<input
type="hidden"
name="noteId"
value="<%=note.getNoteId()%>">
<div class="form-group">

<label>

Note Title

</label>

<input
type="text"
name="title"
id="title"
maxlength="200"
value="<%=note.getTitle()%>"
required>

</div>

<div class="form-group">

<label>

Note Content

</label>

<textarea
name="content"
id="content"
maxlength="5000"
required><%=note.getContent()%></textarea>

<div style="text-align:right;margin-top:8px;color:#666;">

<span id="count">

<%=note.getContent().length()%>

</span>

/5000 Characters

</div>

</div>

<div class="form-group">

<label>

Note Color

</label>

<div class="colorBox">

<input
type="color"
name="color"
value="<%=note.getColor()%>">

<span>

Choose your note color

</span>

</div>

</div>

<div class="info">

<div>

<b>

Created At

</b>

<br><br>

<%=note.getCreatedAt()%>

</div>

<div>

<b>

Last Updated

</b>

<br><br>

<%=note.getUpdatedAt()%>

</div>

</div>

<div class="buttons">

<button
type="submit"
class="update">

<i class="fa-solid fa-floppy-disk"></i>

Update Note

</button>

<a
href="NotesServlet"
class="cancel">

<i class="fa-solid fa-xmark"></i>

Cancel

</a>

</div>

</form>

</div>

<script>

const textarea=document.getElementById("content");

const counter=document.getElementById("count");

textarea.addEventListener("input",function(){

counter.innerHTML=this.value.length;

});

document.getElementById("title").focus();

</script>

</body>

</html>