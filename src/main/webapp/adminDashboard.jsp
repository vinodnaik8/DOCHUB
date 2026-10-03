<%@page import="model.Admin"%>

<%
Admin admin=(Admin)session.getAttribute("admin");

if(admin==null){

response.sendRedirect("adminLogin.jsp");

return;

}

Integer totalUsers=(Integer)request.getAttribute("totalUsers");
Integer totalDocuments=(Integer)request.getAttribute("totalDocuments");
Integer totalNotes=(Integer)request.getAttribute("totalNotes");

if(totalUsers==null) totalUsers=0;
if(totalDocuments==null) totalDocuments=0;
if(totalNotes==null) totalNotes=0;
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>DOCHUB Admin</title>

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

display:flex;

}

/* Sidebar */

.sidebar{

width:260px;

height:100vh;

background:#2563eb;

color:white;

position:fixed;

left:0;

top:0;

padding:30px 20px;

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

.sidebar a:hover{

background:white;

color:#2563eb;

}

/* Main */

.main{

margin-left:260px;

padding:35px;

width:100%;

}

.header{

display:flex;

justify-content:space-between;

align-items:center;

margin-bottom:30px;

}

.cards{

display:grid;

grid-template-columns:repeat(3,1fr);

gap:25px;

}

.card{

background:white;

padding:30px;

border-radius:20px;

box-shadow:0 10px 25px rgba(0,0,0,.08);

text-align:center;

transition:.3s;

}

.card:hover{

transform:translateY(-8px);

}

.card i{

font-size:40px;

color:#2563eb;

margin-bottom:15px;

}

.card h1{

font-size:42px;

margin-bottom:10px;

}

.card p{

color:#777;

font-size:17px;

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

Users

</a>

<a href="ManageDocumentsServlet">

<i class="fa-solid fa-file"></i>

Documents

</a>

<a href="ManageNotesServlet">

<i class="fa-solid fa-note-sticky"></i>

Notes

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

Welcome,

<%=admin.getUsername()%>

</h1>

</div>

<div class="cards">
<div class="card">

<i class="fa-solid fa-users"></i>

<h1>

<%=totalUsers%>

</h1>

<p>Total Users</p>

</div>

<div class="card">

<i class="fa-solid fa-file-lines"></i>

<h1>

<%=totalDocuments%>

</h1>

<p>Total Documents</p>

</div>

<div class="card">

<i class="fa-solid fa-note-sticky"></i>

<h1>

<%=totalNotes%>

</h1>

<p>Total Notes</p>

</div>
</div>

</div>

</body>

</html>