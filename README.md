# 📚 DOCHUB — Document & Note Sharing Platform

DOCHUB is a full-stack Java web application that allows users to upload, manage, share, preview, download, and organize documents and notes.

The platform also includes social features such as following users, liking and commenting on content, bookmarking documents, and maintaining public/private profiles. An admin module provides user, document, note, and platform management.

---

## 🚀 Features

### 👤 User Management
- User registration and login
- Secure logout
- Profile management
- Profile picture upload
- Change password
- Account deletion
- Public/private profile visibility
- View other user profiles

### 🔐 Authentication & Security
- Login authentication
- OTP-based forgot password
- OTP verification
- Password reset
- Resend OTP functionality
- Session-based authentication
- Access control for protected resources

### 📄 Document Management
- Upload documents
- View documents
- Preview documents
- Download documents
- Edit document details
- Delete documents
- Manage personal documents
- Save/bookmark documents
- Public/private document access

### 📝 Notes Management
- Create notes
- Edit notes
- Delete notes
- Archive notes
- Restore archived notes
- Pin notes
- Favorite notes
- Export notes as PDF

### ❤️ Social Features
- Follow users
- Like documents/notes
- Comment on content
- Delete comments
- Bookmark/save documents
- Public feed
- Search functionality

### 👨‍💼 Admin Panel
- Admin authentication
- Admin dashboard
- Manage users
- View user profiles
- Delete users
- Manage documents
- Delete documents
- Manage notes
- Change admin password
- Platform analytics
- Statistics dashboard

---

## 🛠️ Technologies Used

### Backend
- Java
- Jakarta Servlets
- JDBC
- Apache Tomcat

### Frontend
- JSP
- HTML5
- CSS3
- JavaScript

### Database
- MySQL

### Libraries
- Jakarta Mail
- MySQL Connector/J
- OpenPDF
- Jakarta Activation

### Development Tools
- Eclipse IDE
- Apache Tomcat
- Git
- GitHub

---

## 🏗️ Project Architecture

The project follows a layered architecture using Controllers, DAOs, Models, and JSP views.

DOCHUB
│
├── Controller Layer
│   └── Handles HTTP requests and application flow
│
├── DAO Layer
│   └── Handles database operations using JDBC
│
├── Model Layer
│   └── Represents application entities
│
├── Utility Layer
│   ├── Database connection
│   └── Email/OTP services
│
└── View Layer
    └── JSP, HTML, CSS and JavaScript

--Project Structure
src/
└── main/
    ├── java/
    │   ├── controller/
    │   ├── dao/
    │   ├── model/
    │   └── util/
    │
    └── webapp/
        ├── WEB-INF/
        ├── css/
        ├── js/
        └── *.jsp
