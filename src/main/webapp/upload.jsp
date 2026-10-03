<%@ page import="model.User"%>

<%
User user=(User)session.getAttribute("user");

if(user==null){
    response.sendRedirect("login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
content="width=device-width, initial-scale=1.0">

<title>Upload Document | DOCHUB</title>

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
    display:flex;
    justify-content:center;
    align-items:center;
    padding:40px;
}

.container{
    width:750px;
    background:white;
    padding:35px;
    border-radius:20px;
    box-shadow:0 10px 30px rgba(0,0,0,.1);
}

h2{
    text-align:center;
    margin-bottom:25px;
    color:#2563eb;
}

.form-group{
    margin-bottom:20px;
}

label{
    display:block;
    margin-bottom:8px;
    font-weight:600;
    color:#333;
}

input[type=text],
textarea,
select{
    width:100%;
    padding:14px;
    border:1px solid #dcdcdc;
    border-radius:12px;
    font-size:15px;
    outline:none;
    transition:.3s;
}

input[type=text]:focus,
textarea:focus,
select:focus{
    border-color:#2563eb;
}

textarea{
    height:120px;
    resize:none;
}

input[type=file]{
    width:100%;
    padding:12px;
    border:2px dashed #2563eb;
    border-radius:12px;
    cursor:pointer;
    background:#f8fbff;
}

.preview{
    display:none;
    align-items:center;
    gap:20px;
    margin-top:20px;
    padding:20px;
    background:#f5f7fb;
    border-radius:15px;
    border:1px solid #ddd;
}

.preview i{
    font-size:60px;
    color:#2563eb;
}

.preview h4{
    margin-bottom:8px;
}

.preview p{
    margin:3px 0;
    color:#666;
}

.btn{
    width:100%;
    padding:15px;
    background:#2563eb;
    border:none;
    border-radius:12px;
    color:white;
    font-size:17px;
    font-weight:600;
    cursor:pointer;
    transition:.3s;
}

.btn:hover{
    background:#174fc9;
}

.back{
    display:block;
    text-align:center;
    margin-top:15px;
    text-decoration:none;
    color:#555;
}

.back:hover{
    color:#2563eb;
}

</style>

</head>

<body>

<div class="container">

<h2>
    <i class="fa-solid fa-cloud-arrow-up"></i>
    Upload Document
</h2>

<form
    action="UploadServlet"
    method="post"
    enctype="multipart/form-data">

<!-- ================= TITLE ================= -->

<div class="form-group">

<label>
    Document Title
</label>

<input
    type="text"
    name="title"
    placeholder="Enter document title"
    required>

</div>


<!-- ================= DESCRIPTION ================= -->

<div class="form-group">

<label>
    Description
</label>

<textarea
    name="description"
    placeholder="Enter document description"></textarea>

</div>


<!-- ================= CATEGORY ================= -->

<div class="form-group">

<label>
    Category
</label>

<select name="category">

<option value="Programming">Programming</option>
<option value="Research">Research</option>
<option value="Lecture Notes">Lecture Notes</option>
<option value="Project">Project</option>
<option value="Assignment">Assignment</option>
<option value="Resume">Resume</option>
<option value="Other">Other</option>

</select>

</div>


<!-- ================= FILE ================= -->

<div class="form-group">

<label>
    Choose File
</label>

<input
    type="file"
    id="document"
    name="document"
    required>

</div>


<!-- ================= FILE PREVIEW ================= -->

<div class="preview" id="preview">

<i id="icon"
class="fa-solid fa-file"></i>

<div>

<h4 id="name"></h4>

<p id="type"></p>

<p id="size"></p>

</div>

</div>

<br>


<!-- ================= UPLOAD ================= -->

<button type="submit" class="btn">

<i class="fa-solid fa-upload"></i>

Publish Document

</button>

</form>


<a
href="dashboard.jsp"
class="back">

Back to Dashboard

</a>

</div>


<script>

const input=document.getElementById("document");

input.addEventListener("change",function(){

    const file=this.files[0];

    if(!file)return;

    document.getElementById("preview").style.display="flex";

    document.getElementById("name").innerHTML=file.name;

    document.getElementById("type").innerHTML=
        "Type : "+file.type;

    document.getElementById("size").innerHTML=
        "Size : "+(file.size/1024/1024).toFixed(2)+" MB";


    let icon="fa-file";

    const name=file.name.toLowerCase();


    if(name.endsWith(".pdf"))

        icon="fa-file-pdf";

    else if(name.endsWith(".doc") || name.endsWith(".docx"))

        icon="fa-file-word";

    else if(name.endsWith(".ppt") || name.endsWith(".pptx"))

        icon="fa-file-powerpoint";

    else if(name.endsWith(".xls") || name.endsWith(".xlsx"))

        icon="fa-file-excel";

    else if(name.endsWith(".zip"))

        icon="fa-file-zipper";

    else if(file.type.startsWith("image"))

        icon="fa-image";


    document.getElementById("icon").className=
        "fa-solid "+icon;

});

</script>

</body>

</html>