<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ page import="model.Document"%>

<%
    Document doc = (Document) request.getAttribute("document");

    if (doc == null) {
        response.sendRedirect("MyFilesServlet");
        return;
    }
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Edit Document - DOCHUB</title>

    <link rel="stylesheet"
          href="css/dashboard.css">

    <link rel="preconnect"
          href="https://fonts.googleapis.com">

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
          rel="stylesheet">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">

    <style>

    /* ==============================
       PAGE SCROLL FIX
       ============================== */

    html {
        height: auto !important;
        min-height: 100%;
        overflow-y: auto !important;
        overflow-x: hidden;
    }

    body {
        height: auto !important;
        min-height: 100vh;
        overflow-y: auto !important;
        overflow-x: hidden;
    }

    .editContainer {
        max-width: 700px;
        margin: 50px auto;
        margin-bottom: 80px;
        background: white;
        padding: 35px;
        border-radius: 20px;
        box-shadow: 0 10px 30px rgba(0,0,0,0.08);
    }

    .editContainer h1 {
        margin-bottom: 30px;
        color: #172b4d;
    }

    .formGroup {
        margin-bottom: 22px;
    }

    .formGroup label {
        display: block;
        margin-bottom: 8px;
        font-weight: 600;
        color: #172b4d;
    }

    .formGroup input,
    .formGroup textarea,
    .formGroup select {
        width: 100%;
        padding: 13px 15px;
        border: 1px solid #ddd;
        border-radius: 10px;
        font-family: 'Poppins', sans-serif;
        font-size: 14px;
        box-sizing: border-box;
    }

    .formGroup textarea {
        min-height: 130px;
        resize: vertical;
    }

    .fileInfo {
        background: #f5f7fb;
        padding: 15px;
        border-radius: 10px;
        color: #555;
    }

    .buttonRow {
        display: flex;
        gap: 15px;
        margin-top: 30px;
        padding-bottom: 20px;
    }

    .updateBtn,
    .cancelBtn {
        padding: 13px 25px;
        border: none;
        border-radius: 10px;
        font-family: 'Poppins', sans-serif;
        font-weight: 600;
        cursor: pointer;
        text-decoration: none;
        display: inline-block;
    }

    .updateBtn {
        background: #2864e8;
        color: white;
    }

    .cancelBtn {
        background: #e9ecef;
        color: #333;
    }

    .visibilityInfo {
        background: #eef5ff;
        padding: 15px;
        border-radius: 10px;
        margin-bottom: 22px;
        color: #315b9b;
        font-size: 14px;
    }

    /* ==============================
       MOBILE
       ============================== */

    @media (max-width: 700px) {

        .editContainer {
            width: 92%;
            margin: 25px auto 60px auto;
            padding: 25px 20px;
        }

        .editContainer h1 {
            font-size: 25px;
        }

        .buttonRow {
            flex-direction: column;
        }

        .updateBtn,
        .cancelBtn {
            width: 100%;
            text-align: center;
        }
    }

</style>

</head>

<body>

<div class="editContainer">

    <h1>
        <i class="fa-solid fa-pen-to-square"></i>
        Edit Document
    </h1>

    <!-- UPDATE FORM -->

    <form action="UpdateDocumentServlet"
          method="post">

        <!-- DOCUMENT ID -->

        <input type="hidden"
               name="docId"
               value="<%= doc.getDocId() %>">


        <!-- TITLE -->

        <div class="formGroup">

            <label for="title">
                Document Title
            </label>

            <input type="text"
                   id="title"
                   name="title"
                   value="<%= doc.getTitle() %>"
                   required>

        </div>


        <!-- DESCRIPTION -->

        <div class="formGroup">

            <label for="description">
                Description
            </label>

            <textarea id="description"
                      name="description"
                      required><%= doc.getDescription() %></textarea>

        </div>


        <!-- CATEGORY -->

        <div class="formGroup">

            <label for="category">
                Category
            </label>

            <select id="category"
                    name="category"
                    required>

                <option value="Programming"
                    <%= "Programming".equals(doc.getCategory()) ? "selected" : "" %>>
                    Programming
                </option>

                <option value="Research"
                    <%= "Research".equals(doc.getCategory()) ? "selected" : "" %>>
                    Research
                </option>

                <option value="Lecture Notes"
                    <%= "Lecture Notes".equals(doc.getCategory()) ? "selected" : "" %>>
                    Lecture Notes
                </option>

                <option value="Project"
                    <%= "Project".equals(doc.getCategory()) ? "selected" : "" %>>
                    Project
                </option>

                <option value="Other"
                    <%= "Other".equals(doc.getCategory()) ? "selected" : "" %>>
                    Other
                </option>

            </select>

        </div>


        <!-- ACCOUNT VISIBILITY -->

        <div class="visibilityInfo">

            <i class="fa-solid fa-circle-info"></i>

            <strong>Account Visibility:</strong>

            <%= doc.getVisibility() %>

            <br>

            <small>
                Visibility is controlled from your account settings
                and cannot be changed while editing a document.
            </small>

        </div>


        <!-- FILE -->

        <div class="formGroup">

            <label>
                File Name
            </label>

            <div class="fileInfo">

                <i class="fa-solid fa-file"></i>

                <%= doc.getFileName() %>

                <br>

                <small>
                    The uploaded file cannot be changed.
                </small>

            </div>

        </div>


        <!-- BUTTONS -->

        <div class="buttonRow">

            <button type="submit"
                    class="updateBtn">

                <i class="fa-solid fa-check"></i>

                Update Document

            </button>

            <a href="MyFilesServlet"
               class="cancelBtn">

                <i class="fa-solid fa-xmark"></i>

                Cancel

            </a>

        </div>

    </form>

</div>

</body>

</html>