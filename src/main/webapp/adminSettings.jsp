<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ page import="model.Admin"%>

<%
    Admin admin = (Admin) request.getAttribute("admin");

    if (admin == null) {

        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Admin Settings - DOCHUB</title>

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            background: #eef2f7;
            min-height: 100vh;
            padding: 40px;
        }

        .container {
            max-width: 700px;
            margin: auto;
        }

        .header {
            margin-bottom: 25px;
        }

        .header h1 {
            color: #222;
            font-size: 30px;
            margin-bottom: 8px;
        }

        .header p {
            color: #666;
        }

        .settingsCard {
            background: white;
            padding: 35px;
            border-radius: 20px;
            box-shadow: 0 10px 25px rgba(0,0,0,.08);
            margin-bottom: 30px;
        }

        .settingsCard h2 {
            color: #222;
            margin-bottom: 25px;
        }

        .usernameBox {
            background: #f3f6fb;
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 25px;
        }

        .usernameBox strong {
            color: #555;
        }

        .usernameBox span {
            color: #2563eb;
            font-weight: 600;
        }

        label {
            display: block;
            margin-top: 15px;
            margin-bottom: 7px;
            font-weight: 600;
            color: #444;
        }

        input {
            width: 100%;
            padding: 14px;
            border: 1px solid #ddd;
            border-radius: 10px;
            font-size: 15px;
            outline: none;
        }

        input:focus {
            border-color: #2563eb;
            box-shadow: 0 0 0 3px rgba(37,99,235,.10);
        }

        button {
            background: #2563eb;
            color: white;
            border: none;
            padding: 14px 25px;
            border-radius: 10px;
            cursor: pointer;
            font-size: 15px;
            font-weight: 600;
            margin-top: 25px;
        }

        button:hover {
            background: #1d4ed8;
        }

        .logout {
            display: inline-block;
            background: #ef4444;
            color: white;
            padding: 14px 25px;
            text-decoration: none;
            border-radius: 10px;
        }

        .logout:hover {
            background: #dc2626;
        }

        .back {
            display: inline-block;
            margin-right: 10px;
            background: #64748b;
            color: white;
            padding: 14px 25px;
            text-decoration: none;
            border-radius: 10px;
        }

        .back:hover {
            background: #475569;
        }

        @media(max-width:600px) {

            body {
                padding: 20px;
            }

            .settingsCard {
                padding: 25px;
            }

        }

    </style>

</head>

<body>

<div class="container">

    <div class="header">

        <h1>Admin Settings</h1>

        <p>
            Manage your administrator account.
        </p>

    </div>


    <div class="settingsCard">

        <h2>Account Settings</h2>


        <div class="usernameBox">

            <strong>Username:</strong>

            <span>
                <%=admin.getUsername()%>
            </span>

        </div>


        <form action="AdminChangePasswordServlet"
              method="post">

            <label>
                Old Password
            </label>

            <input
                type="password"
                name="oldPassword"
                placeholder="Enter old password"
                required>


            <label>
                New Password
            </label>

            <input
                type="password"
                name="newPassword"
                placeholder="Enter new password"
                required>


            <button type="submit">
                Change Password
            </button>

        </form>

    </div>


    <a href="AdminDashboardServlet"
       class="back">

        ← Dashboard

    </a>


    <a href="AdminLogoutServlet"
       class="logout">

        Logout

    </a>

</div>

</body>

</html>