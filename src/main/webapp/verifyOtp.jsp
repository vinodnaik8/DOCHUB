<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String error = request.getParameter("error");
String resent = request.getParameter("resent");
String attempts = request.getParameter("attempts");
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>Verify OTP | DOCHUB</title>

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
            #f8faff 45%,
            #eef2ff 100%
        );

}


/* =========================
   CARD
========================= */

.container{

    width:100%;

    max-width:430px;

    padding:40px 38px;

    background:#ffffff;

    border:1px solid #e6ebf5;

    border-radius:20px;

    box-shadow:
        0 18px 45px rgba(37,99,235,.14);

    animation:cardAppear .5s ease;

}


@keyframes cardAppear{

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

    justify-content:center;

    align-items:center;

    border-radius:18px;

    background:
        linear-gradient(
            135deg,
            #2563eb,
            #4f46e5
        );

    color:#ffffff;

    font-size:28px;

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

    margin-bottom:24px;

}


.subtitle strong{

    color:#4f46e5;

}


/* =========================
   OTP INFO
========================= */

.otpInfo{

    display:flex;

    align-items:center;

    gap:12px;

    padding:13px 15px;

    margin-bottom:18px;

    border-radius:10px;

    background:#eff6ff;

    border:1px solid #dbeafe;

    color:#475569;

    font-size:11px;

    line-height:1.5;

}


.otpInfo i{

    color:#2563eb;

    font-size:18px;

}


/* =========================
   MESSAGE
========================= */

.message{

    display:flex;

    align-items:flex-start;

    gap:9px;

    padding:12px 14px;

    border-radius:10px;

    margin-bottom:18px;

    font-size:12px;

    line-height:1.5;

}


.message i{

    margin-top:2px;

}


.success{

    background:#f0fdf4;

    border:1px solid #bbf7d0;

    color:#15803d;

}


.error{

    background:#fff1f2;

    border:1px solid #fecdd3;

    color:#be123c;

}


/* =========================
   OTP INPUT
========================= */

.inputGroup{

    position:relative;

    margin-bottom:20px;

}


.inputGroup i{

    position:absolute;

    left:16px;

    top:50%;

    transform:translateY(-50%);

    color:#8a94a6;

    font-size:16px;

    z-index:2;

}


input{

    width:100%;

    height:58px;

    padding:0 45px;

    background:#f9fbff;

    border:1px solid #d9dfeb;

    border-radius:10px;

    outline:none;

    color:#172033;

    font-size:20px;

    font-weight:600;

    letter-spacing:8px;

    text-align:center;

    transition:.25s;

}


input::placeholder{

    color:#9aa4b2;

    font-size:12px;

    font-weight:400;

    letter-spacing:0;

}


input:focus{

    border-color:#4f7df3;

    background:#ffffff;

    box-shadow:
        0 0 0 3px rgba(79,125,243,.10);

}


.inputGroup:focus-within i{

    color:#2563eb;

}


/* =========================
   VERIFY BUTTON
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
        0 8px 20px rgba(37,99,235,.22);

}


button i{

    margin-right:7px;

}


button:hover{

    transform:translateY(-2px);

    box-shadow:
        0 12px 26px rgba(37,99,235,.30);

}


button:active{

    transform:translateY(0);

}


/* =========================
   BOTTOM
========================= */

.bottom{

    margin-top:23px;

    text-align:center;

}


.bottom p{

    color:#8a94a6;

    font-size:12px;

    margin-bottom:8px;

}


.bottom a{

    color:#4f46e5;

    text-decoration:none;

    font-size:13px;

    font-weight:500;

    transition:.2s;

}


.bottom a:hover{

    color:#2563eb;

}


.divider{

    display:flex;

    align-items:center;

    gap:10px;

    margin:17px 0;

}


.divider span{

    flex:1;

    height:1px;

    background:#e5e7eb;

}


.divider small{

    color:#9ca3af;

    font-size:10px;

}


/* =========================
   SECURITY
========================= */

.security{

    display:flex;

    justify-content:center;

    align-items:center;

    gap:6px;

    margin-top:22px;

    padding-top:17px;

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

        border-radius:17px;

    }

    h2{

        font-size:22px;

    }

    .logo{

        width:60px;

        height:60px;

        font-size:24px;

    }

    input{

        font-size:18px;

        letter-spacing:6px;

    }

}

</style>


<script>

/* =========================
   ONLY NUMBERS
========================= */

function onlyNumbers(input){

    input.value =
        input.value
        .replace(/[^0-9]/g,'')
        .substring(0,6);

}


/* =========================
   AUTO SUBMIT
========================= */

function checkOTP(input){

    onlyNumbers(input);

    if(input.value.length === 6){

        document
            .getElementById("verifyForm")
            .submit();

    }

}

</script>

</head>


<body>


<div class="container">


    <!-- =========================
         LOGO
    ========================== -->

    <div class="logo">

        <i class="fa-solid fa-shield-halved"></i>

    </div>


    <!-- =========================
         TITLE
    ========================== -->

    <h2>

        Verify OTP

    </h2>


    <p class="subtitle">

        Enter the 6-digit verification code
        sent to your <strong>DOCHUB</strong> account.

    </p>


    <!-- =========================
         OTP INFORMATION
    ========================== -->

    <div class="otpInfo">

        <i class="fa-solid fa-envelope-circle-check"></i>

        <span>

            Check your registered email for the
            verification code. The OTP is valid
            for a limited time.

        </span>

    </div>


    <!-- =========================
         ERROR
    ========================== -->

    <%
    if(error != null){
    %>

        <div class="message error">

            <i class="fa-solid fa-circle-xmark"></i>

            <div>

                <strong>Incorrect OTP</strong>

                <%
                if(attempts != null){
                %>

                    <br>

                    Attempt
                    <strong><%=attempts%></strong>
                    of 3

                <%
                }
                %>

            </div>

        </div>

    <%
    }
    %>


    <!-- =========================
         RESENT SUCCESS
    ========================== -->

    <%
    if(resent != null){
    %>

        <div class="message success">

            <i class="fa-solid fa-circle-check"></i>

            <span>

                New OTP sent successfully.
                Please check your email.

            </span>

        </div>

    <%
    }
    %>


    <!-- =========================
         VERIFY FORM
    ========================== -->

    <form
        id="verifyForm"
        action="VerifyOtpServlet"
        method="post">


        <div class="inputGroup">

            <i class="fa-solid fa-key"></i>

            <input

                type="text"

                name="otp"

                maxlength="6"

                inputmode="numeric"

                autocomplete="one-time-code"

                placeholder="Enter 6 Digit OTP"

                required

                autofocus

                oninput="checkOTP(this);">

        </div>


        <button type="submit">

            <i class="fa-solid fa-circle-check"></i>

            Verify OTP

        </button>


    </form>


    <!-- =========================
         LINKS
    ========================== -->

    <div class="bottom">

        <p>

            Didn't receive the code?

        </p>


        <a href="ResendOtpServlet">

            <i class="fa-solid fa-rotate-right"></i>

            Resend OTP

        </a>


        <div class="divider">

            <span></span>

            <small>OR</small>

            <span></span>

        </div>


        <a href="login.jsp">

            <i class="fa-solid fa-arrow-left"></i>

            Back to Login

        </a>

    </div>


    <!-- =========================
         SECURITY
    ========================== -->

    <div class="security">

        <i class="fa-solid fa-shield-halved"></i>

        Secure OTP verification by DOCHUB

    </div>


</div>


</body>

</html>