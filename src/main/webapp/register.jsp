<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>DOCHUB | Register</title>

<link rel="preconnect" href="https://fonts.googleapis.com">

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">

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

padding:30px;

overflow-x:hidden;

}

body::before{

content:"";

position:fixed;

width:450px;

height:450px;

background:#2563eb;

filter:blur(170px);

top:-150px;

right:-150px;

opacity:.18;

z-index:-1;

}

body::after{

content:"";

position:fixed;

width:350px;

height:350px;

background:#60a5fa;

filter:blur(160px);

bottom:-120px;

left:-120px;

opacity:.15;

z-index:-1;

}

.container{

width:500px;

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

.logo{

text-align:center;

font-size:34px;

font-weight:700;

color:#2563eb;

margin-bottom:10px;

}

.logo i{

margin-right:10px;

}

h2{

text-align:center;

color:#222;

margin-bottom:30px;

font-size:28px;

}

.inputBox{

margin-bottom:18px;

}

.inputBox label{

display:block;

margin-bottom:8px;

font-weight:600;

color:#374151;

}

.inputBox input{

width:100%;

padding:14px 15px;

border:1px solid #d1d5db;

border-radius:12px;

font-size:15px;

background:#f8fafc;

transition:.3s;

}

.inputBox input:focus{

outline:none;

border-color:#2563eb;

background:white;

box-shadow:0 0 0 4px rgba(37,99,235,.12);

}

.password-box{

position:relative;

}

.password-box i{

position:absolute;

right:15px;

top:17px;

cursor:pointer;

color:#6b7280;

}

.password-box i:hover{

color:#2563eb;

}

.strength{

font-size:13px;

margin-top:8px;

font-weight:600;

}

.form-group{

margin-top:18px;

}

.form-group label{

display:block;

margin-bottom:8px;

font-weight:600;

color:#374151;

}

.form-group input{

width:100%;

padding:12px;

border:1px solid #d1d5db;

border-radius:12px;

background:#f8fafc;

}

.registerBtn{

width:100%;

padding:15px;

background:#2563eb;

color:white;

border:none;

border-radius:12px;

font-size:17px;

font-weight:600;

cursor:pointer;

transition:.3s;

margin-top:25px;

}

.registerBtn:hover{

background:#1d4ed8;

transform:translateY(-2px);

}

.links{

margin-top:25px;

text-align:center;

line-height:30px;

}

.links p{

color:#555;

}

.links a{

color:#2563eb;

font-weight:600;

text-decoration:none;

transition:.3s;

}

.links a:hover{

text-decoration:underline;

}

.error{

color:#ef4444;

font-size:14px;

margin-top:5px;

display:none;

font-weight:500;

}

input[type="file"]{

background:white;

cursor:pointer;

}

input[type="file"]::file-selector-button{

background:#2563eb;

color:white;

border:none;

padding:10px 18px;

border-radius:8px;

cursor:pointer;

margin-right:12px;

transition:.3s;

}

input[type="file"]::file-selector-button:hover{

background:#1d4ed8;

}

@media(max-width:600px){

.container{

width:100%;

padding:30px 22px;

}

h2{

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

<i class="fa-solid fa-book-open"></i>

DOCHUB

</div>

<h2>Create Your Account</h2>

<form action="RegisterServlet"
      method="post"
      enctype="multipart/form-data">

<div class="inputBox">

<label>Full Name</label>

<input type="text" name="fullname" required>

</div>

<div class="inputBox">

<label>Username</label>

<input type="text" name="username" required>

</div>

<div class="inputBox">

<label>Email</label>

<input type="email" name="email" required>

</div>

<div class="inputBox">

<label>Password</label>

<div class="password-box">

<input type="password" id="password" name="password" required onkeyup="checkStrength()">

<i class="fa-solid fa-eye" onclick="togglePassword('password',this)"></i>

</div>

<div class="strength" id="strength"></div>

</div>

<div class="inputBox">

<label>Confirm Password</label>

<div class="password-box">

<input type="password" id="confirmPassword" required>

<i class="fa-solid fa-eye" onclick="togglePassword('confirmPassword',this)"></i>

</div>

<div class="error" id="error">

Passwords do not match!

</div>
<div class="form-group">

<label>Profile Picture</label>

<input
type="file"
name="profilePic"
accept="image/*"
required>

</div>

</div>

<button class="registerBtn">

Create Account

</button>

</form>

<div class="links">

<p>

Already have an account?

<a href="login.jsp">

Login

</a>

</p>

<br>

<a href="index.jsp">

← Back to Home

</a>

</div>

</div>

<script>

function togglePassword(id,icon){

const input=document.getElementById(id);

if(input.type==="password"){

input.type="text";

icon.classList.remove("fa-eye");

icon.classList.add("fa-eye-slash");

}else{

input.type="password";

icon.classList.remove("fa-eye-slash");

icon.classList.add("fa-eye");

}

}

function validateForm(){

let p=document.getElementById("password").value;

let c=document.getElementById("confirmPassword").value;

if(p!==c){

document.getElementById("error").style.display="block";

return false;

}

return true;

}

function checkStrength(){

let p=document.getElementById("password").value;

let s=document.getElementById("strength");

if(p.length<6){

s.innerHTML="Weak Password";

s.style.color="#ef4444";

}

else if(p.length<10){

s.innerHTML="Medium Password";

s.style.color="#f59e0b";

}

else{

s.innerHTML="Strong Password";

s.style.color="#22c55e";

}

}

</script>

</body>

</html>