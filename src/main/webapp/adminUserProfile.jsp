<%@page import="java.util.List"%>
<%@page import="model.User"%>
<%@page import="model.Document"%>

<%
User user=(User)request.getAttribute("profileUser");

List<Document> documents=
(List<Document>)request.getAttribute("documents");

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

<title>User Details</title>

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
rel="stylesheet">

<style>

*{

margin:0;

padding:0;

box-sizing:border-box;

font-family:Poppins,sans-serif;

}

body{

background:#eef2f7;

}

.container{

width:95%;

max-width:1200px;

margin:30px auto;

}

.profile{

background:white;

padding:35px;

border-radius:20px;

box-shadow:0 10px 25px rgba(0,0,0,.08);

display:flex;

gap:30px;

align-items:center;

margin-bottom:30px;

}

.profile img{

width:150px;

height:150px;

border-radius:50%;

object-fit:cover;

border:5px solid #2563eb;

}

.default{

width:150px;

height:150px;

border-radius:50%;

background:#2563eb;

display:flex;

justify-content:center;

align-items:center;

color:white;

font-size:60px;

}

.info{

flex:1;

}

.info h1{

margin-bottom:10px;

}

.info p{

margin:8px 0;

}

.back{

display:inline-block;

margin-bottom:20px;

background:#2563eb;

color:white;

padding:12px 25px;

border-radius:10px;

text-decoration:none;

}

.grid{

display:grid;

grid-template-columns:repeat(auto-fill,minmax(320px,1fr));

gap:20px;

}

.card{

background:white;

padding:20px;

border-radius:15px;

box-shadow:0 10px 25px rgba(0,0,0,.08);

}

.card h3{

margin-bottom:10px;

}

.file{

color:#666;

margin-top:10px;

}

</style>

</head>

<body>

<div class="container">

<a
href="ManageUsersServlet"
class="back">

<i class="fa-solid fa-arrow-left"></i>

Back

</a>

<div class="profile">
<%

if(user.getProfilePic()!=null &&
!user.getProfilePic().trim().isEmpty()){

%>

<img
src="ViewProfilePicServlet?file=<%=user.getProfilePic()%>">

<%

}else{

%>

<div class="default">

<i class="fa-solid fa-user"></i>

</div>

<%

}

%>

<div class="info">

<h1>

<%=user.getFullname()%>

</h1>

<p>

<b>Username :</b>

<%=user.getUsername()%>

</p>

<p>

<b>Email :</b>

<%=user.getEmail()%>

</p>

<p>

<b>Bio :</b>

<%=user.getBio()%>

</p>

<p>

<b>Profession :</b>

<%=user.getProfession()%>

</p>

<p>

<b>Skills :</b>

<%=user.getSkills()%>

</p>

<p>

<b>GitHub :</b>

<%=user.getGithub()%>

</p>

<p>

<b>LinkedIn :</b>

<%=user.getLinkedin()%>

</p>

<p>

<b>Total Public Documents :</b>

<%=documents.size()%>

</p>

</div>

<h2 style="margin-bottom:20px;">

Public Documents

</h2>

<div class="grid">

<%

if(documents.isEmpty()){

%>

<p>

No Public Documents

</p>

<%

}else{

for(Document doc:documents){

%>

<div class="card">

<h3>

<%=doc.getTitle()%>

</h3>

<p>

<%=doc.getDescription()%>

</p>

<div class="file">

<%=doc.getFileName()%>

</div>

</div>

<%

}

}

%>

</div>

</div>

</body>

</html>