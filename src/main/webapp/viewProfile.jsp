<%@page import="java.util.List"%>
<%@page import="model.Document"%>
<%@page import="model.User"%>

<%

User user=(User)request.getAttribute("profile");

List<Document> docs=(List<Document>)request.getAttribute("documents");

%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Public Profile</title>

<link rel="stylesheet" href="css/profile.css">

</head>

<body>

<section class="profile">

<div class="profileTop">

<div class="profileImage">

<img src="images/default.png">

</div>

<div class="profileInfo">

<h1>

<%=user.getFullname()%>

</h1>

<h3>

@<%=user.getUsername()%>

</h3>

<p>

<%=user.getBio()%>

</p>

<span class="public">

🌍 Public Profile

</span>

</div>

</div>

<div class="grid">

<%

for(Document d:docs){

%>

<div class="box">

<i class="fa-solid fa-file-pdf"></i>

<h4>

<%=d.getTitle()%>

</h4>

<br>

<a href="uploads/<%=d.getFileName()%>" download>

Download

</a>

</div>

<%

}

%>

</div>

</section>

</body>

</html>