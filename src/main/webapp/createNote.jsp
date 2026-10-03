<%@page import="model.User"%>

<%
User user=(User)session.getAttribute("user");

if(user==null){

    response.sendRedirect("login.jsp");

    return;

}
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
content="width=device-width, initial-scale=1.0">

<title>Create Note | DOCHUB</title>

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

height:70px;

background:white;

display:flex;

justify-content:space-between;

align-items:center;

padding:0 35px;

box-shadow:0 5px 20px rgba(0,0,0,.08);

}

.logo{

font-size:28px;

font-weight:700;

color:#2563eb;

}

.backBtn{

background:#2563eb;

color:white;

padding:10px 22px;

border-radius:10px;

text-decoration:none;

font-weight:600;

}

.container{

width:90%;

max-width:850px;

margin:40px auto;

background:white;

padding:35px;

border-radius:20px;

box-shadow:0 10px 25px rgba(0,0,0,.08);

}

.container h2{

margin-bottom:30px;

color:#2563eb;

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

font-size:15px;

outline:none;

}

textarea{

width:100%;

height:260px;

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

.counter{

text-align:right;

margin-top:8px;

color:#777;

font-size:14px;

}

.buttons{

display:flex;

gap:15px;

margin-top:30px;

}

.save{

flex:1;

background:#2563eb;

color:white;

padding:14px;

border:none;

border-radius:12px;

cursor:pointer;

font-size:15px;

}

.cancel{

flex:1;

background:#6c757d;

color:white;

padding:14px;

border-radius:12px;

text-align:center;

text-decoration:none;

}

.save:hover{

background:#174fc9;

}

.cancel:hover{

background:#555;

}

</style>

</head>

<body>

<div class="header">

<div class="logo">

<i class="fa-solid fa-note-sticky"></i>

DOCHUB Notes

</div>

<a href="NotesServlet" class="backBtn">

<i class="fa-solid fa-arrow-left"></i>

Back

</a>

</div>

<div class="container">

<h2>

<i class="fa-solid fa-pen"></i>

Create New Note

</h2>

<form action="CreateNoteServlet" method="post">
<div class="form-group">

<label>

Note Title

</label>

<input
type="text"
name="title"
id="title"
maxlength="200"
placeholder="Enter note title..."
required>

</div>

<div class="form-group">

<label>

Write Your Note

</label>

<textarea
name="content"
id="content"
maxlength="5000"
placeholder="Start writing your note here..."
required></textarea>

<div class="counter">

<span id="count">

0

</span>

/5000 Characters

</div>

</div>

<div class="form-group">

<label>

Choose Note Color

</label>

<div class="colorBox">

<input
type="color"
name="color"
id="color"
value="#fff8b3">

<span>

Select your preferred note color

</span>

</div>

</div>

<div class="buttons">

<button
type="submit"
class="save">

<i class="fa-solid fa-floppy-disk"></i>

Save Note

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

//================ Character Counter =================//

const textarea=document.getElementById("content");

const count=document.getElementById("count");

textarea.addEventListener("input",function(){

count.innerHTML=this.value.length;

});

//================ Auto Focus =================//

document.getElementById("title").focus();

</script>

</body>

</html>