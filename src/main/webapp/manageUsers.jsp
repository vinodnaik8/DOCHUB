<%@page import="java.util.List"%>
<%@page import="model.Admin"%>
<%@page import="model.User"%>

<%
Admin admin=(Admin)session.getAttribute("admin");

if(admin==null){

    response.sendRedirect("adminLogin.jsp");

    return;

}

List<User> users=(List<User>)request.getAttribute("users");

if(users==null){

    users=new java.util.ArrayList<User>();

}
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
content="width=device-width, initial-scale=1.0">

<title>Manage Users | DOCHUB Admin</title>

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

font-size:28px;

}

.sidebar a{

display:block;

padding:15px;

margin-bottom:10px;

text-decoration:none;

color:white;

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

.adminInfo{

font-size:16px;

color:#666;

}

/* Search */

.searchBox{

margin-bottom:25px;

position:relative;

}

.searchBox input{

width:100%;

padding:15px 20px 15px 50px;

border:none;

border-radius:12px;

font-size:15px;

box-shadow:0 8px 20px rgba(0,0,0,.08);

outline:none;

}

.searchBox i{

position:absolute;

left:18px;

top:17px;

color:#666;

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

.profileImg{

width:55px;

height:55px;

border-radius:50%;

object-fit:cover;

border:2px solid #2563eb;

}

.defaultProfile{

width:55px;

height:55px;

border-radius:50%;

background:#2563eb;

display:flex;

justify-content:center;

align-items:center;

color:white;

margin:auto;

}

.viewBtn{

background:#10b981;

color:white;

padding:10px 18px;

border-radius:8px;

text-decoration:none;

margin-right:8px;

}

.deleteBtn{

background:#ef4444;

color:white;

padding:10px 18px;

border-radius:8px;

text-decoration:none;

}

.viewBtn:hover{

background:#0d9f6e;

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

<a href="ManageUsersServlet" class="active">

<i class="fa-solid fa-users"></i>

Manage Users

</a>

<a href="ManageDocumentsServlet">

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

Manage Users

</h1>

<div class="adminInfo">

Welcome,

<b><%=admin.getUsername()%></b>

</div>

</div>

<div class="searchBox">

<i class="fa-solid fa-magnifying-glass"></i>

<input
type="text"
id="searchUser"
placeholder="Search by Name, Username or Email">

</div>

<div class="tableBox">

<table>

<thead>

<tr>

<th>Profile</th>

<th>Name</th>

<th>Username</th>

<th>Email</th>

<th>Action</th>

</tr>

</thead>

<tbody id="userTable">
<%

if(users.isEmpty()){

%>

<tr>

<td colspan="5" style="padding:40px;">

<i class="fa-solid fa-users"
style="font-size:55px;color:#2563eb;"></i>

<h2 style="margin-top:20px;">

No Users Found

</h2>

<p style="margin-top:10px;color:#666;">

There are no registered users.

</p>

</td>

</tr>

<%

}else{

for(User user : users){

%>

<tr>

<td>

<%

if(user.getProfilePic()!=null &&
!user.getProfilePic().trim().isEmpty()){

%>

<img
src="ViewProfilePicServlet?file=<%=user.getProfilePic()%>"
class="profileImg">

<%

}else{

%>

<div class="defaultProfile">

<i class="fa-solid fa-user"></i>

</div>

<%

}

%>

</td>

<td>

<%=user.getFullname()%>

</td>

<td>

@<%=user.getUsername()%>

</td>

<td>

<%=user.getEmail()%>

</td>

<td>

<a
href="AdminViewUserServlet?id=<%=user.getId()%>"
class="viewBtn">

<i class="fa-solid fa-eye"></i>

View

</a>

<a
href="DeleteUserServlet?id=<%=user.getId()%>"
class="deleteBtn"

onclick="return confirm('Delete this user?');">

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

//=============================
// LIVE SEARCH
//=============================

const search=document.getElementById("searchUser");

search.addEventListener("keyup",function(){

let value=this.value.toLowerCase();

let rows=document.querySelectorAll("#userTable tr");

rows.forEach(row=>{

let text=row.innerText.toLowerCase();

if(text.includes(value)){

row.style.display="";

}else{

row.style.display="none";

}

});

});

//=============================
// ROW ANIMATION
//=============================

document.querySelectorAll("#userTable tr").forEach((row,index)=>{

row.style.opacity="0";

row.style.transform="translateY(25px)";

setTimeout(()=>{

row.style.transition=".5s";

row.style.opacity="1";

row.style.transform="translateY(0)";

},index*80);

});

//=============================
// BUTTON HOVER
//=============================

document.querySelectorAll(".viewBtn,.deleteBtn").forEach(btn=>{

btn.addEventListener("mouseenter",function(){

this.style.transform="scale(1.05)";

});

btn.addEventListener("mouseleave",function(){

this.style.transform="scale(1)";

});

});

</script>

<style>

.viewBtn,
.deleteBtn{

display:inline-block;

transition:.25s;

}

/* ==============================
RESPONSIVE
============================== */

@media(max-width:900px){

.sidebar{

width:220px;

}

.main{

margin-left:220px;

padding:20px;

}

table{

font-size:14px;

}

}

@media(max-width:768px){

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

gap:15px;

align-items:flex-start;

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