<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%@ page import="model.Document"%>

<%
Document doc = (Document) request.getAttribute("document");

if(doc == null){

    response.sendRedirect("MyFilesServlet");

    return;

}

String file = doc.getFileName().toLowerCase();
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
content="width=device-width, initial-scale=1">

<title>

<%=doc.getTitle()%>

</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css"
rel="stylesheet">

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

.previewBox{

width:95%;

max-width:1200px;

margin:35px auto;

background:white;

border-radius:20px;

padding:30px;

box-shadow:0 10px 25px rgba(0,0,0,.08);

}

.header{

display:flex;

justify-content:space-between;

align-items:center;

flex-wrap:wrap;

gap:20px;

margin-bottom:20px;

}

.info h2{

margin-bottom:10px;

}

.info p{

margin:6px 0;

color:#666;

}

.actionButtons{

display:flex;

gap:10px;

}

iframe{

width:100%;

height:800px;

border:none;

border-radius:12px;

background:#f5f5f5;

}

.imagePreview{

display:block;

max-width:100%;

max-height:750px;

margin:auto;

border-radius:12px;

box-shadow:0 5px 15px rgba(0,0,0,.1);

}

.notSupported{

text-align:center;

padding:80px;

}

.notSupported i{

font-size:80px;

color:#2563eb;

margin-bottom:20px;

}

.notSupported h3{

margin-bottom:15px;

}

.notSupported p{

color:#666;

margin-bottom:25px;

}

</style>

</head>

<body>

<div class="previewBox">

<div class="header">

<div class="info">

<h2>

<%=doc.getTitle()%>

</h2>

<p>

<b>Category :</b>

<%=doc.getCategory()%>

</p>

<p>

<b>Visibility :</b>

<%=doc.getVisibility()%>

</p>

<p>

<%=doc.getDescription()%>

</p>

</div>

<div class="actionButtons">

<%
    String previewSource =
            (String) request.getAttribute("previewSource");

    if (previewSource == null ||
        previewSource.trim().isEmpty()) {
        previewSource = "myfiles";
    }

    String backUrl;

    if ("community".equalsIgnoreCase(previewSource)) {

        backUrl = "PublicFeedServlet";

    } else if ("bookmark".equalsIgnoreCase(previewSource)) {

        backUrl = "BookmarkServlet";

    } else {

        backUrl = "MyFilesServlet";
    }
%>

<a href="<%=backUrl%>" class="backBtn">
    <i class="fa-solid fa-arrow-left"></i>
    Back
</a>

<a

href="DownloadServlet?id=<%=doc.getDocId()%>"

class="btn btn-primary">

<i class="fa-solid fa-download"></i>

Download

</a>

</div>

</div>

<hr>
<%

if(file.endsWith(".pdf")){

%>

<iframe
src="ViewDocumentServlet?id=<%=doc.getDocId()%>">
</iframe>

<%

}else if(

file.endsWith(".jpg") ||

file.endsWith(".jpeg") ||

file.endsWith(".png") ||

file.endsWith(".gif") ||

file.endsWith(".webp")){

%>

<div class="text-center">

<img

src="ViewDocumentServlet?id=<%=doc.getDocId()%>"

class="imagePreview">

</div>

<%

}else if(file.endsWith(".txt")){

%>

<iframe

src="ViewDocumentServlet?id=<%=doc.getDocId()%>">

</iframe>

<%

}else{

%>

<div class="notSupported">

<i class="fa-solid fa-file-circle-xmark"></i>

<h3>

Preview Not Available

</h3>

<p>

This file type cannot be previewed in the browser.

Please download it to view.

</p>

<a

href="DownloadServlet?id=<%=doc.getDocId()%>"

class="btn btn-success btn-lg">

<i class="fa-solid fa-download"></i>

Download File

</a>

</div>

<%

}

%>

</div>

</body>

</html>