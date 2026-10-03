<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
Boolean verified = (Boolean) session.getAttribute("otpVerified");

if (verified == null || !verified) {
    response.sendRedirect("forgotPassword.jsp");
    return;
}

String error = request.getParameter("error");
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>Reset Password | DOCHUB</title>

<!-- Google Font -->
<link rel="preconnect"
      href="https://fonts.googleapis.com">

<link rel="preconnect"
      href="https://fonts.gstatic.com"
      crossorigin>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
      rel="stylesheet">

<!-- Font Awesome -->
<link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">

<style>

/* =========================
   RESET
========================= */

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}


/* =========================
   BODY
========================= */

body {

    min-height: 100vh;

    display: flex;

    justify-content: center;

    align-items: center;

    padding: 20px;

    font-family: 'Poppins', sans-serif;

    background:
        radial-gradient(
            circle at top left,
            #4f46e5 0%,
            transparent 35%
        ),
        radial-gradient(
            circle at bottom right,
            #7c3aed 0%,
            transparent 35%
        ),
        linear-gradient(
            135deg,
            #0f172a,
            #111827
        );

    position: relative;

    overflow: hidden;
}


/* =========================
   BACKGROUND EFFECTS
========================= */

body::before {

    content: "";

    position: absolute;

    width: 300px;

    height: 300px;

    border-radius: 50%;

    background: rgba(99,102,241,0.18);

    top: -120px;

    left: -100px;

    filter: blur(2px);
}


body::after {

    content: "";

    position: absolute;

    width: 350px;

    height: 350px;

    border-radius: 50%;

    background: rgba(139,92,246,0.15);

    bottom: -150px;

    right: -120px;

    filter: blur(2px);
}


/* =========================
   MAIN CARD
========================= */

.container {

    width: 100%;

    max-width: 450px;

    padding: 40px;

    background: rgba(255,255,255,0.08);

    border: 1px solid rgba(255,255,255,0.15);

    border-radius: 24px;

    backdrop-filter: blur(18px);

    -webkit-backdrop-filter: blur(18px);

    box-shadow:
        0 25px 60px rgba(0,0,0,0.35);

    position: relative;

    z-index: 2;

    animation: cardAppear 0.6s ease;
}


/* =========================
   CARD ANIMATION
========================= */

@keyframes cardAppear {

    from {

        opacity: 0;

        transform:
            translateY(30px)
            scale(.97);
    }

    to {

        opacity: 1;

        transform:
            translateY(0)
            scale(1);
    }
}


/* =========================
   LOGO
========================= */

.logo {

    width: 70px;

    height: 70px;

    margin: 0 auto 20px;

    display: flex;

    justify-content: center;

    align-items: center;

    border-radius: 20px;

    background:
        linear-gradient(
            135deg,
            #4f46e5,
            #7c3aed
        );

    color: white;

    font-size: 29px;

    box-shadow:
        0 12px 30px
        rgba(79,70,229,.4);

    animation: logoPulse 2.5s infinite;
}


@keyframes logoPulse {

    0%,100% {

        box-shadow:
            0 12px 30px
            rgba(79,70,229,.35);
    }

    50% {

        box-shadow:
            0 12px 40px
            rgba(124,58,237,.55);
    }
}


/* =========================
   TITLE
========================= */

h2 {

    color: white;

    text-align: center;

    font-size: 26px;

    font-weight: 600;

    margin-bottom: 8px;
}


.subtitle {

    text-align: center;

    color: #b7c0d0;

    font-size: 13px;

    line-height: 1.6;

    margin-bottom: 25px;
}


.subtitle strong {

    color: #c4b5fd;

    font-weight: 600;
}


/* =========================
   ERROR MESSAGE
========================= */

.error {

    display: flex;

    align-items: center;

    gap: 10px;

    background:
        rgba(239,68,68,.12);

    border:
        1px solid
        rgba(239,68,68,.30);

    color: #fecaca;

    padding: 13px 15px;

    margin-bottom: 20px;

    border-radius: 12px;

    font-size: 12px;

    line-height: 1.5;

    animation: messageIn .4s ease;
}


.error i {

    color: #f87171;

    font-size: 15px;
}


@keyframes messageIn {

    from {

        opacity: 0;

        transform: translateY(-8px);
    }

    to {

        opacity: 1;

        transform: translateY(0);
    }
}


/* =========================
   PASSWORD REQUIREMENTS
========================= */

.requirements {

    background:
        rgba(99,102,241,.08);

    border:
        1px solid
        rgba(99,102,241,.18);

    border-radius: 12px;

    padding: 14px 15px;

    margin-bottom: 22px;
}


.requirementsTitle {

    color: #c7d2fe;

    font-size: 12px;

    font-weight: 500;

    margin-bottom: 9px;
}


.requirementsTitle i {

    color: #818cf8;

    margin-right: 5px;
}


.requirements ul {

    list-style: none;

    display: grid;

    grid-template-columns: 1fr 1fr;

    gap: 6px;
}


.requirements li {

    color: #8b95a7;

    font-size: 10px;
}


.requirements li i {

    color: #6366f1;

    font-size: 9px;

    margin-right: 5px;
}


/* =========================
   FORM GROUP
========================= */

.formGroup {

    margin-bottom: 20px;
}


.formGroup label {

    display: block;

    color: #e5e7eb;

    font-size: 13px;

    font-weight: 500;

    margin-bottom: 8px;
}


/* =========================
   INPUT
========================= */

.inputBox {

    position: relative;
}


.inputBox > .inputIcon {

    position: absolute;

    left: 16px;

    top: 50%;

    transform: translateY(-50%);

    color: #8b95a7;

    font-size: 15px;

    pointer-events: none;

    transition: .25s;
}


input {

    width: 100%;

    height: 52px;

    padding:
        0 48px 0 45px;

    border-radius: 12px;

    border:
        1px solid #374151;

    outline: none;

    background:
        rgba(15,23,42,.75);

    color: white;

    font-family:
        'Poppins', sans-serif;

    font-size: 14px;

    transition: .25s;
}


input::placeholder {

    color: #7d8798;
}


input:focus {

    border-color: #6366f1;

    background:
        rgba(15,23,42,.95);

    box-shadow:
        0 0 0 4px
        rgba(99,102,241,.12);
}


.inputBox:focus-within .inputIcon {

    color: #818cf8;
}


/* =========================
   EYE BUTTON
========================= */

.togglePassword {

    position: absolute;

    right: 16px;

    top: 50%;

    transform: translateY(-50%);

    color: #8b95a7;

    cursor: pointer;

    transition: .2s;
}


.togglePassword:hover {

    color: #a5b4fc;
}


/* =========================
   PASSWORD STRENGTH
========================= */

.strength {

    display: flex;

    gap: 5px;

    margin-top: 8px;
}


.strength span {

    height: 4px;

    flex: 1;

    background: #374151;

    border-radius: 10px;

    transition: .3s;
}


.strengthText {

    color: #8b95a7;

    font-size: 10px;

    margin-top: 5px;
}


/* =========================
   BUTTON
========================= */

button {

    width: 100%;

    height: 52px;

    border: none;

    border-radius: 12px;

    background:
        linear-gradient(
            135deg,
            #4f46e5,
            #7c3aed
        );

    color: white;

    font-family:
        'Poppins', sans-serif;

    font-size: 15px;

    font-weight: 600;

    cursor: pointer;

    transition: .25s;

    box-shadow:
        0 10px 25px
        rgba(79,70,229,.30);

    margin-top: 5px;
}


button i {

    margin-right: 7px;
}


button:hover {

    transform: translateY(-2px);

    box-shadow:
        0 15px 30px
        rgba(79,70,229,.42);
}


button:active {

    transform: translateY(0);
}


/* =========================
   FOOTER
========================= */

.footer {

    display: flex;

    justify-content: center;

    align-items: center;

    gap: 6px;

    text-align: center;

    margin-top: 22px;

    padding-top: 18px;

    border-top:
        1px solid
        rgba(255,255,255,.08);

    color: #687386;

    font-size: 10px;
}


.footer i {

    color: #6366f1;

    font-size: 11px;
}


/* =========================
   RESPONSIVE
========================= */

@media(max-width:500px) {

    body {

        padding: 15px;
    }

    .container {

        padding: 30px 22px;

        border-radius: 20px;
    }

    h2 {

        font-size: 23px;
    }

    .logo {

        width: 60px;

        height: 60px;

        font-size: 25px;
    }

    .requirements ul {

        grid-template-columns: 1fr;
    }
}

</style>


<script>

/* =========================
   TOGGLE PASSWORD
========================= */

function togglePassword(inputId, icon) {

    const input =
        document.getElementById(inputId);

    if (input.type === "password") {

        input.type = "text";

        icon.classList.remove("fa-eye");

        icon.classList.add("fa-eye-slash");

    } else {

        input.type = "password";

        icon.classList.remove("fa-eye-slash");

        icon.classList.add("fa-eye");
    }
}


/* =========================
   PASSWORD STRENGTH
========================= */

function checkStrength() {

    const password =
        document.getElementById("password").value;

    const bars =
        document.querySelectorAll(".strength span");

    const text =
        document.getElementById("strengthText");

    bars.forEach(function(bar) {

        bar.style.background = "#374151";

    });

    if (password.length === 0) {

        text.innerText =
            "Enter a new password";

        return;
    }

    let strength = 0;

    if (password.length >= 6)
        strength++;

    if (password.length >= 8)
        strength++;

    if (/[A-Z]/.test(password) &&
        /[a-z]/.test(password))
        strength++;

    if (/[0-9]/.test(password))
        strength++;

    if (/[^A-Za-z0-9]/.test(password))
        strength++;


    if (strength <= 1) {

        bars[0].style.background =
            "#ef4444";

        text.innerText =
            "Weak password";

    } else if (strength <= 3) {

        bars[0].style.background =
            "#f59e0b";

        bars[1].style.background =
            "#f59e0b";

        bars[2].style.background =
            "#f59e0b";

        text.innerText =
            "Medium password";

    } else {

        bars.forEach(function(bar) {

            bar.style.background =
                "#22c55e";

        });

        text.innerText =
            "Strong password";
    }
}


/* =========================
   VALIDATE PASSWORD
========================= */

function validatePassword() {

    const pass =
        document.getElementById("password").value;

    const confirm =
        document.getElementById("confirm").value;


    if (pass.length < 6) {

        alert(
            "Password should be at least 6 characters."
        );

        return false;
    }


    if (pass !== confirm) {

        alert(
            "Passwords do not match."
        );

        return false;
    }


    return true;
}

</script>

</head>


<body>


<div class="container">


    <!-- LOGO -->

    <div class="logo">

        <i class="fa-solid fa-key"></i>

    </div>


    <!-- TITLE -->

    <h2>
        Reset Password
    </h2>


    <p class="subtitle">

        Create a new password for your
        <strong>DOCHUB</strong> account.

    </p>


    <!-- ERROR -->

    <%
    if (error != null) {
    %>

        <div class="error">

            <i class="fa-solid fa-circle-exclamation"></i>

            <span>
                Password reset failed.
                Please try again.
            </span>

        </div>

    <%
    }
    %>


    <!-- PASSWORD REQUIREMENTS -->

    <div class="requirements">

        <div class="requirementsTitle">

            <i class="fa-solid fa-shield-halved"></i>

            Password requirements

        </div>


        <ul>

            <li>
                <i class="fa-solid fa-check"></i>
                Minimum 6 characters
            </li>

            <li>
                <i class="fa-solid fa-check"></i>
                Use uppercase letters
            </li>

            <li>
                <i class="fa-solid fa-check"></i>
                Include numbers
            </li>

            <li>
                <i class="fa-solid fa-check"></i>
                Use special characters
            </li>

        </ul>

    </div>


    <!-- FORM -->

    <form
        action="ResetPasswordServlet"
        method="post"
        onsubmit="return validatePassword();">


        <!-- NEW PASSWORD -->

        <div class="formGroup">

            <label for="password">

                New Password

            </label>


            <div class="inputBox">

                <i class="fa-solid fa-lock inputIcon"></i>

                <input
                    type="password"
                    id="password"
                    name="password"
                    placeholder="Enter new password"
                    autocomplete="new-password"
                    required
                    oninput="checkStrength();">


                <i
                    class="fa-solid fa-eye togglePassword"
                    onclick="togglePassword('password', this)">
                </i>

            </div>


            <!-- STRENGTH -->

            <div class="strength">

                <span></span>
                <span></span>
                <span></span>
                <span></span>
                <span></span>

            </div>


            <div
                class="strengthText"
                id="strengthText">

                Enter a new password

            </div>

        </div>


        <!-- CONFIRM PASSWORD -->

        <div class="formGroup">

            <label for="confirm">

                Confirm Password

            </label>


            <div class="inputBox">

                <i class="fa-solid fa-lock inputIcon"></i>

                <input
                    type="password"
                    id="confirm"
                    name="confirmPassword"
                    placeholder="Confirm your password"
                    autocomplete="new-password"
                    required>


                <i
                    class="fa-solid fa-eye togglePassword"
                    onclick="togglePassword('confirm', this)">
                </i>

            </div>

        </div>


        <!-- BUTTON -->

        <button type="submit">

            <i class="fa-solid fa-key"></i>

            Reset Password

        </button>


    </form>


    <!-- FOOTER -->

    <div class="footer">

        <i class="fa-solid fa-shield-halved"></i>

        Your password is securely protected by DOCHUB

    </div>


</div>


</body>

</html>