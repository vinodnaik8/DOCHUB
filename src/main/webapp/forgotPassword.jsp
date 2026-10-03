<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String error = request.getParameter("error");
String expired = request.getParameter("expired");
String newotp = request.getParameter("newotp");
String sessionExpired = request.getParameter("sessionExpired");
String mailerror = request.getParameter("mailerror");
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>Forgot Password | DOCHUB</title>

<link rel="preconnect"
      href="https://fonts.googleapis.com">

<link rel="preconnect"
      href="https://fonts.gstatic.com"
      crossorigin>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap"
      rel="stylesheet">

<link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">


<style>

/* =========================
   RESET
========================= */

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'Poppins',sans-serif;
}


/* =========================
   BODY
========================= */

body{

    min-height:100vh;

    display:flex;

    justify-content:center;

    align-items:center;

    padding:20px;

    background:
        linear-gradient(
            135deg,
            #eef4ff 0%,
            #f7f9ff 45%,
            #eef2ff 100%
        );

}


/* =========================
   MAIN CONTAINER
========================= */

.container{

    width:100%;

    max-width:430px;

    background:#ffffff;

    padding:40px 38px;

    border-radius:20px;

    box-shadow:
        0 15px 45px rgba(37,99,235,.15);

    border:1px solid #e8edfa;

    animation:slideUp .5s ease;

}


@keyframes slideUp{

    from{

        opacity:0;

        transform:translateY(25px);

    }

    to{

        opacity:1;

        transform:translateY(0);

    }

}


/* =========================
   LOGO
========================= */

.logo{

    width:68px;

    height:68px;

    margin:0 auto 18px;

    display:flex;

    align-items:center;

    justify-content:center;

    border-radius:18px;

    background:
        linear-gradient(
            135deg,
            #2563eb,
            #6366f1
        );

    color:#ffffff;

    font-size:27px;

    box-shadow:
        0 10px 25px rgba(37,99,235,.25);

}


/* =========================
   TITLE
========================= */

h2{

    text-align:center;

    color:#172033;

    font-size:25px;

    font-weight:600;

    margin-bottom:8px;

}


.subtitle{

    text-align:center;

    color:#718096;

    font-size:13px;

    line-height:1.6;

    margin-bottom:26px;

}


/* =========================
   MESSAGES
========================= */

.msg{

    padding:12px 14px;

    border-radius:10px;

    margin-bottom:18px;

    text-align:center;

    font-size:13px;

    line-height:1.5;

}


.error{

    background:#fff1f2;

    border:1px solid #fecdd3;

    color:#be123c;

}


.info{

    background:#eff6ff;

    border:1px solid #bfdbfe;

    color:#1d4ed8;

}


/* =========================
   FORM GROUP
========================= */

.formGroup{

    margin-bottom:20px;

}


label{

    display:block;

    margin-bottom:8px;

    color:#374151;

    font-size:13px;

    font-weight:500;

}


/* =========================
   INPUT
========================= */

.inputBox{

    position:relative;

}


.inputBox i{

    position:absolute;

    left:15px;

    top:50%;

    transform:translateY(-50%);

    color:#8a94a6;

    font-size:14px;

    transition:.3s;

}


input{

    width:100%;

    height:52px;

    padding:0 15px 0 44px;

    border:1px solid #d9dfeb;

    border-radius:10px;

    background:#f9fbff;

    color:#1f2937;

    font-size:13px;

    outline:none;

    transition:.3s;

}


input::placeholder{

    color:#9aa4b2;

}


input:focus{

    border-color:#4f7df3;

    background:#ffffff;

    box-shadow:
        0 0 0 3px rgba(79,125,243,.10);

}


.inputBox:focus-within i{

    color:#3567e8;

}


/* =========================
   SEND OTP BUTTON
========================= */

button{

    width:100%;

    height:52px;

    border:none;

    border-radius:10px;

    background:
        linear-gradient(
            135deg,
            #2563eb,
            #4f46e5
        );

    color:#ffffff;

    font-size:14px;

    font-weight:600;

    cursor:pointer;

    transition:.3s;

    box-shadow:
        0 8px 20px rgba(37,99,235,.20);

}


button i{

    margin-right:7px;

}


button:hover{

    transform:translateY(-2px);

    box-shadow:
        0 12px 25px rgba(37,99,235,.28);

}


button:active{

    transform:translateY(0);

}


/* =========================
   BACK TO LOGIN
========================= */

.backLogin{

    display:flex;

    justify-content:center;

    align-items:center;

    gap:7px;

    margin-top:22px;

    color:#4f46e5;

    font-size:13px;

    font-weight:500;

    text-decoration:none;

    transition:.3s;

}


.backLogin:hover{

    color:#2563eb;

}


.backLogin i{

    font-size:11px;

}


/* =========================
   SECURITY
========================= */

.security{

    display:flex;

    justify-content:center;

    align-items:center;

    gap:6px;

    margin-top:24px;

    padding-top:18px;

    border-top:1px solid #edf0f5;

    color:#9aa4b2;

    font-size:10px;

}


.security i{

    color:#22c55e;

}


/* =========================
   RESPONSIVE
========================= */

@media(max-width:500px){

    body{

        padding:15px;

    }

    .container{

        padding:32px 24px;

        border-radius:16px;

    }

    h2{

        font-size:22px;

    }

    .logo{

        width:60px;

        height:60px;

        font-size:24px;

    }

}

</style>

</head>


<body>


<div class="container">


    <!-- =========================
         LOGO
    ========================== -->

    <div class="logo">

        <i class="fa-solid fa-lock"></i>

    </div>


    <!-- =========================
         TITLE
    ========================== -->

    <h2>

        Forgot Password?

    </h2>


    <p class="subtitle">

        Enter your registered email address and
        we'll send you a verification OTP.

    </p>


    <!-- =========================
         EMAIL ERROR
    ========================== -->

    <%
    if(error != null){
    %>

        <div class="msg error">

            <i class="fa-solid fa-circle-exclamation"></i>

            &nbsp;

            Email is not registered.

        </div>

    <%
    }
    %>


    <!-- =========================
         OTP EXPIRED
    ========================== -->

    <%
    if(expired != null){
    %>

        <div class="msg error">

            <i class="fa-solid fa-clock"></i>

            &nbsp;

            OTP expired.

            <br>

            Please request a new OTP.

        </div>

    <%
    }
    %>


    <!-- =========================
         MAX ATTEMPTS
    ========================== -->

    <%
    if(newotp != null){
    %>

        <div class="msg info">

            <i class="fa-solid fa-rotate"></i>

            &nbsp;

            Maximum attempts reached.

            <br>

            Generate a new OTP.

        </div>

    <%
    }
    %>


    <!-- =========================
         SESSION EXPIRED
    ========================== -->

    <%
    if(sessionExpired != null){
    %>

        <div class="msg error">

            <i class="fa-solid fa-hourglass-end"></i>

            &nbsp;

            Session expired.

            <br>

            Please try again.

        </div>

    <%
    }
    %>


    <!-- =========================
         MAIL ERROR
    ========================== -->

    <%
    if(mailerror != null){
    %>

        <div class="msg error">

            <i class="fa-solid fa-envelope-circle-check"></i>

            &nbsp;

            Unable to send OTP.

            <br>

            Please try again later.

        </div>

    <%
    }
    %>


    <!-- =========================
         FORM
    ========================== -->

    <form
        action="ForgotPasswordServlet"
        method="post">


        <div class="formGroup">

            <label for="email">

                Registered Email

            </label>


            <div class="inputBox">

                <i class="fa-solid fa-envelope"></i>

                <input

                    type="email"

                    id="email"

                    name="email"

                    placeholder="Enter your registered email"

                    autocomplete="email"

                    required>

            </div>

        </div>


        <button type="submit">

            <i class="fa-solid fa-paper-plane"></i>

            Send OTP

        </button>


    </form>


    <!-- =========================
         BACK TO LOGIN
    ========================== -->

    <a
        href="login.jsp"
        class="backLogin">

        <i class="fa-solid fa-arrow-left"></i>

        Back to Login

    </a>


    <!-- =========================
         SECURITY
    ========================== -->

    <div class="security">

        <i class="fa-solid fa-shield-halved"></i>

        Your account information is securely protected.

    </div>


</div>


</body>

</html>