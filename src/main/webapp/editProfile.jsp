<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%@ page import="model.User"%>

<%
User user=(User)session.getAttribute("user");

if(user==null){
response.sendRedirect("login.jsp");
return;
}

String pic=user.getProfilePic();

if(pic==null || pic.equals("")){
pic="default.png";
}
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
content="width=device-width, initial-scale=1">

<title>Edit Profile | DOCHUB</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">

<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" rel="stylesheet">

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

<style>

body{

background:#f5f7fb;

font-family:'Poppins',sans-serif;

}

.card{

max-width:900px;

margin:40px auto;

padding:35px;

border:none;

border-radius:20px;

box-shadow:0 10px 30px rgba(0,0,0,.08);

}

.profileImage{

text-align:center;

margin-bottom:30px;

}

.profileImage img{

width:170px;

height:170px;

border-radius:50%;

object-fit:cover;

border:5px solid #2563eb;

cursor:pointer;

}

.btn-primary{

background:#2563eb;

border:none;

}

.btn-primary:hover{

background:#1d4ed8;

}

</style>

</head>

<body>

<div class="card">

<h2 class="mb-4">

Edit Profile

</h2>

<form
action="UpdateProfileServlet"
method="post"
enctype="multipart/form-data">

<div class="profileImage">

<img
src="profilePics/<%=pic%>"
id="preview">

<br><br>

<input
type="file"
name="profilePic"
id="profilePic"
accept="image/*">

</div>

<div class="row">

<div class="col-md-6 mb-3">

<label>

Full Name

</label>

<input
type="text"
class="form-control"
name="fullname"
value="<%=user.getFullname()%>"
required>

</div>

<div class="col-md-6 mb-3">

<label>

Username

</label>

<input
type="text"
class="form-control"
name="username"
value="<%=user.getUsername()%>"
required>

</div>

<div class="col-md-6 mb-3">

<label>

Email

</label>

<input
type="email"
class="form-control"
value="<%=user.getEmail()%>"
readonly>

</div>

<div class="col-md-6 mb-3">

<label>

Profession

</label>

<input
type="text"
class="form-control"
name="profession"
value="<%=user.getProfession()%>">

</div>

<div class="col-12 mb-3">

<label>

Bio

</label>

<textarea
class="form-control"
rows="4"
name="bio"><%=user.getBio()%></textarea>

</div>

<div class="col-md-6 mb-3">

<label>

Skills

</label>

<input
type="text"
class="form-control"
name="skills"
placeholder="Java,JSP,MySQL"
value="<%=user.getSkills()%>">

</div>

<div class="col-md-6 mb-3">

<label>

Visibility

</label>

<select
class="form-control"
name="visibility">

<option
value="PUBLIC"
<%=user.getVisibility().equals("PUBLIC")?"selected":""%>>

Public

</option>

<option
value="PRIVATE"
<%=user.getVisibility().equals("PRIVATE")?"selected":""%>>

Private

</option>

</select>

</div>

<div class="col-md-6 mb-3">

<label>

GitHub

</label>

<input
type="text"
class="form-control"
name="github"
value="<%=user.getGithub()%>">

</div>

<div class="col-md-6 mb-3">

<label>

LinkedIn

</label>

<input
type="text"
class="form-control"
name="linkedin"
value="<%=user.getLinkedin()%>">

</div>

</div>

<div class="mt-4">

<button
class="btn btn-primary">

<i class="fa-solid fa-floppy-disk"></i>

Save Changes

</button>

<a
href="ProfileServlet"
class="btn btn-secondary">

Cancel

</a>

</div>

</form>

</div>

<script>

document.getElementById("profilePic").onchange=function(e){

const reader=new FileReader();

reader.onload=function(){

document.getElementById("preview").src=reader.result;

}

reader.readAsDataURL(e.target.files[0]);

}

</script>

</body>

</html>