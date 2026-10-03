<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%
String error = request.getParameter("error");
String reset = request.getParameter("reset");
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>DOCHUB Login</title>

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:'Poppins',sans-serif;
}

body{

background:#eef2f7;

display:flex;

justify-content:center;

align-items:center;

min-height:100vh;

overflow:hidden;

position:relative;

}

/* Background */

body::before{

content:"";

position:absolute;

width:450px;

height:450px;

background:#2563eb;

border-radius:50%;

filter:blur(180px);

top:-170px;

right:-170px;

opacity:.18;

z-index:-1;

}

body::after{

content:"";

position:absolute;

width:350px;

height:350px;

background:#60a5fa;

border-radius:50%;

filter:blur(170px);

bottom:-120px;

left:-120px;

opacity:.15;

z-index:-1;

}

/* Login Card */

.container{

width:450px;

background:white;

padding:40px;

border-radius:22px;

box-shadow:0 12px 35px rgba(0,0,0,.12);

border:1px solid #dbe4f0;

transition:.3s;

}

.container:hover{

transform:translateY(-3px);

}

/* Logo */

.logo{

text-align:center;

font-size:34px;

font-weight:700;

color:#2563eb;

margin-bottom:10px;

}

.title{

text-align:center;

font-size:28px;

font-weight:600;

color:#222;

margin-bottom:30px;

}

/* Switch */

.switchBox{

display:flex;

border-radius:12px;

overflow:hidden;

background:#f3f4f6;

margin-bottom:25px;

}

.switchBox button{

width:50%;

padding:15px;

border:none;

background:transparent;

cursor:pointer;

font-size:15px;

font-weight:600;

transition:.3s;

color:#555;

}

.switchBox button.active{

background:#2563eb;

color:white;

}

/* Inputs */

input{

width:100%;

padding:15px;

margin:12px 0;

border:1px solid #d1d5db;

border-radius:12px;

font-size:15px;

background:#f8fafc;

transition:.3s;

}

input:focus{

outline:none;

border-color:#2563eb;

background:white;

box-shadow:0 0 0 4px rgba(37,99,235,.12);

}

/* Button */

.loginBtn{

width:100%;

padding:15px;

margin-top:10px;

background:#2563eb;

border:none;

border-radius:12px;

color:white;

font-size:17px;

font-weight:600;

cursor:pointer;

transition:.3s;

}

.loginBtn:hover{

background:#1d4ed8;

transform:translateY(-2px);

}

/* Links */

.links{

display:flex;

justify-content:space-between;

margin-top:22px;

}

.links a{

color:#2563eb;

text-decoration:none;

font-weight:600;

transition:.3s;

}

.links a:hover{

text-decoration:underline;

}

/* Home */

.home{

margin-top:25px;

text-align:center;

}

.home a{

color:#2563eb;

text-decoration:none;

font-weight:600;

}

.home a:hover{

text-decoration:underline;

}

/* Success */

.success{

background:#dcfce7;

color:#166534;

padding:14px;

border-radius:10px;

margin-bottom:18px;

text-align:center;

font-weight:500;

}

/* Error */

.error{

background:#fee2e2;

color:#b91c1c;

padding:14px;

border-radius:10px;

margin-bottom:18px;

text-align:center;

font-weight:500;

}

/* Admin Note */

.adminNote{

display:none;

margin-top:18px;

background:#eff6ff;

border-left:5px solid #2563eb;

padding:15px;

border-radius:10px;

color:#2563eb;

font-weight:500;

text-align:center;

}

/* Responsive */

@media(max-width:550px){

.container{

width:95%;

padding:30px 25px;

}

.title{

font-size:24px;

}

.logo{

font-size:30px;

}

}

</style>

</head>

<body>

<div class="container">

<div class="logo">

DOCHUB

</div>

<h2 class="title" id="loginTitle">

User Login

</h2>

<div class="switchBox">

<button
type="button"
id="userBtn"
class="active">

User

</button>

<button
type="button"
id="adminBtn">

Admin

</button>

</div>

<%
if("success".equals(reset)){
%>

<div class="success">

Password reset successfully.<br>

Please login using your new password.

</div>

<%
}
%>

<%
if(error!=null){
%>

<div class="error">

Invalid Username or Password

</div>

<%
}
%>

<form id="loginForm" action="LoginServlet" method="post">

<input

type="email"

name="email"

placeholder="Enter Email"

required>

<input

type="password"

name="password"

placeholder="Enter Password"

required>

<button

type="submit"

class="loginBtn"

id="loginButton">

Login

</button>

</form>

<div class="adminNote" id="adminNote">

Administrator access only.

</div>

<div class="links">

<a href="register.jsp">

Create Account

</a>

<a href="forgotPassword.jsp">

Forgot Password?

</a>

</div>

<div class="home">

<a href="index.jsp">

⬅ Back to Home

</a>

</div>

</div>

<script>

const userBtn = document.getElementById("userBtn");
const adminBtn = document.getElementById("adminBtn");

const title = document.getElementById("loginTitle");
const form = document.getElementById("loginForm");
const note = document.getElementById("adminNote");
const links = document.querySelector(".links");

const input = document.querySelector("input[name='email']");


/* ==========================
   USER LOGIN
   ========================== */

userBtn.addEventListener("click", function () {

    title.innerHTML = "User Login";

    form.action = "LoginServlet";

    input.type = "email";
    input.name = "email";
    input.placeholder = "Enter your Email";

    userBtn.classList.add("active");
    adminBtn.classList.remove("active");

    note.style.display = "none";
    links.style.display = "flex";

});


/* ==========================
   ADMIN LOGIN
   ========================== */

adminBtn.addEventListener("click", function () {

    title.innerHTML = "Admin Login";

    form.action = "AdminLoginServlet";

    input.type = "text";
    input.name = "username";
    input.placeholder = "Enter Username";

    adminBtn.classList.add("active");
    userBtn.classList.remove("active");

    note.style.display = "block";
    links.style.display = "none";

});

</script>

</body>

</html>