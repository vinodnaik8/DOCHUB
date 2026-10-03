<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Platform Statistics</title>

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:Poppins;
}

body{
background:#0d1117;
color:white;
padding:40px;
}

.container{
width:1200px;
margin:auto;
}

.grid{

display:grid;

grid-template-columns:repeat(auto-fit,minmax(250px,1fr));

gap:25px;

}

.card{

background:#161b22;

padding:35px;

border-radius:20px;

text-align:center;

transition:.3s;

}

.card:hover{

transform:translateY(-8px);

box-shadow:0 0 25px rgba(88,166,255,.25);

}

.number{

font-size:55px;

font-weight:bold;

color:#58a6ff;

margin:20px 0;

}

h1{

margin-bottom:40px;

}

</style>

</head>

<body>

<div class="container">

<h1>📊 DOCHUB Statistics</h1>

<div class="grid">

<div class="card">

<h2>👥 Users</h2>

<div class="number">

${users}

</div>

</div>

<div class="card">

<h2>📄 Documents</h2>

<div class="number">

${documents}

</div>

</div>

<div class="card">

<h2>📝 Notes</h2>

<div class="number">

${notes}

</div>

</div>

<div class="card">

<h2>🌍 Public Files</h2>

<div class="number">

${publicDocs}

</div>

</div>

<div class="card">

<h2>🔒 Private Files</h2>

<div class="number">

${privateDocs}

</div>

</div>

</div>

<br><br>

<a href="adminDashboard.jsp"
style="color:#58a6ff;text-decoration:none;font-size:18px;">

⬅ Back to Dashboard

</a>

</div>

</body>

</html>