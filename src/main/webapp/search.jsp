<%@page import="java.util.List"%>
<%@page import="model.Document"%>

<%

List<Document> results=(List<Document>)request.getAttribute("results");

%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Search</title>

<link rel="stylesheet" href="css/dashboard.css">

</head>

<body>

<div class="main">

<h1>Search Documents</h1>

<form action="SearchServlet">

<input
type="text"
name="keyword"
placeholder="Search by title or category">

<button>

Search

</button>

</form>

<br>

<%

if(results!=null){

for(Document d:results){

%>

<div class="post">

<div class="postHeader">

<img src="images/default.png">

<div>

<h3>

<a href="ViewProfileServlet?id=<%=d.getUserId()%>">

<%=d.getFullName()%>

</a>

</h3>

<p>

@<%=d.getUsername()%>

</p>

</div>

</div>

<div class="postBody">

<h2>

<%=d.getTitle()%>

</h2>

<p>

<%=d.getDescription()%>

</p>

<p>

Category :

<%=d.getCategory()%>

</p>

</div>

<div class="postFooter">

<a href="uploads/<%=d.getFileName()%>" download>

<button>

Download

</button>

</a>

</div>

</div>

<%

}

}

%>

</div>

</body>

</html>