<%@page import="model.Admin"%>

<%
Admin admin=(Admin)session.getAttribute("admin");

if(admin==null){

    response.sendRedirect("adminLogin.jsp");

    return;

}

Integer users=(Integer)request.getAttribute("users");
Integer documents=(Integer)request.getAttribute("documents");
Integer notes=(Integer)request.getAttribute("notes");
Integer publicDocs=(Integer)request.getAttribute("publicDocs");
Integer privateDocs=(Integer)request.getAttribute("privateDocs");

if(users==null) users=0;
if(documents==null) documents=0;
if(notes==null) notes=0;
if(publicDocs==null) publicDocs=0;
if(privateDocs==null) privateDocs=0;
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
content="width=device-width,initial-scale=1">

<title>Analytics | DOCHUB Admin</title>

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
rel="stylesheet">

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:Poppins,sans-serif;
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

.header{

display:flex;
justify-content:space-between;
align-items:center;
margin-bottom:30px;

}

.header h1{

font-size:34px;
color:#222;

}

.cardGrid{

display:grid;
grid-template-columns:repeat(auto-fit,minmax(220px,1fr));
gap:20px;

}

.card{

background:white;
padding:25px;
border-radius:20px;
box-shadow:0 10px 25px rgba(0,0,0,.08);
transition:.3s;
text-align:center;

}

.card:hover{

transform:translateY(-6px);

}

.card i{

font-size:38px;
color:#2563eb;
margin-bottom:15px;

}

.card h2{

font-size:38px;

}

.card p{

margin-top:10px;
color:#777;

}

.chartBox{

background:white;
margin-top:30px;
padding:25px;
border-radius:20px;
box-shadow:0 10px 25px rgba(0,0,0,.08);

}

canvas{

max-height:400px;

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

<a href="ManageNotesServlet">

<i class="fa-solid fa-note-sticky"></i>

Manage Notes

</a>

<a href="AnalyticsServlet"
class="active">

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

Analytics Dashboard

</h1>

</div>

<div class="cardGrid">

<div class="card">

<i class="fa-solid fa-users"></i>

<h2><%=users%></h2>

<p>Total Users</p>

</div>

<div class="card">

<i class="fa-solid fa-file-lines"></i>

<h2><%=documents%></h2>

<p>Total Documents</p>

</div>

<div class="card">

<i class="fa-solid fa-note-sticky"></i>

<h2><%=notes%></h2>

<p>Total Notes</p>
</div>

<div class="card">

<i class="fa-solid fa-earth-americas"></i>

<h2><%=publicDocs%></h2>

<p>Public Documents</p>

</div>

<div class="card">

<i class="fa-solid fa-lock"></i>

<h2><%=privateDocs%></h2>

<p>Private Documents</p>

</div>

</div>

<div class="chartBox">

<h2 style="margin-bottom:20px;">

Documents Overview

</h2>

<canvas id="docChart"></canvas>

</div>
<div class="chartBox">

<h2 style="margin-bottom:20px;">

Content Distribution

</h2>

<canvas id="contentChart"></canvas>

</div>

</div>

<script>

//==============================
// DOCUMENT CHART
//==============================

const docChart=new Chart(

document.getElementById("docChart"),

{

type:"pie",

data:{

labels:["Public","Private"],

datasets:[{

data:[

<%=publicDocs%>,

<%=privateDocs%>

],

backgroundColor:[

"#10b981",

"#ef4444"

]

}]

},

options:{

responsive:true,

plugins:{

legend:{

position:"bottom"

}

}

}

});

//==============================
// CONTENT CHART
//==============================

const contentChart=new Chart(

document.getElementById("contentChart"),

{

type:"bar",

data:{

labels:[

"Documents",

"Notes",

"Users"

],

datasets:[{

label:"Statistics",

data:[

<%=documents%>,

<%=notes%>,

<%=users%>

],

backgroundColor:[

"#2563eb",

"#f59e0b",

"#10b981"

]

}]

},

options:{

responsive:true,

plugins:{

legend:{

display:false

}

},

scales:{

y:{

beginAtZero:true

}

}

}

});

//==============================
// CARD ANIMATION
//==============================

document.querySelectorAll(".card").forEach((card,index)=>{

card.style.opacity="0";

card.style.transform="translateY(20px)";

setTimeout(()=>{

card.style.transition=".5s";

card.style.opacity="1";

card.style.transform="translateY(0)";

},index*100);

});

</script>

<style>

/* ==============================
Responsive
============================== */

@media(max-width:1200px){

.cardGrid{

grid-template-columns:repeat(2,1fr);

}

}

@media(max-width:900px){

.sidebar{

width:220px;

}

.main{

margin-left:220px;

padding:20px;

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

.cardGrid{

grid-template-columns:1fr;

}

.chartBox{

overflow-x:auto;

}

}

</style>

</body>

</html>