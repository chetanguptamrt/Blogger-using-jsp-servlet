<%-- 
    Document   : profile
    Created on : 17-Jun-2021, 4:03:43 PM
    Author     : chetan
--%>

<%@page import="com.detail.UserDetail"%>
<%
    if(session.getAttribute("userLogin")==null) {
        response.sendRedirect("./login.jsp");
    } else {
        UserDetail ud = (UserDetail)session.getAttribute("userLogin");
    
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
        <title>Home | Blog</title>
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>
    </head>
    <body>
        <nav class="navbar navbar-expand-md navbar-dark bg-dark">
            <a class="navbar-brand" href="./home.jsp">Blog</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="./createBlog.jsp">Create Blog</a>
                    </li>
                    <li class="nav-item active">
                        <a class="nav-link" href="./showBlog.jsp">Show blog</a>
                    </li>
                </ul>
                <a class="btn btn-outline-light mr-2" href="./profile.jsp"><%= ud.getName() %></a>
                <a class="btn btn-outline-light" href="./logout.jsp">Logout</a>
            </div>
        </nav>
        
        <div class="container-md mt-3 mb-5 text-light">
            <div class="row">
                <div class="col-12 text-center">
                    <h2>Profile</h2>
                </div>
            </div>
            <div class="row">
                <div class="col-12 text-right">
                    <a href="./publicProfile.jsp?userId=<%= ud.getId() %>" target="_blank" class="btn btn-outline-success">View Public Profile</a>
                </div>
            </div>
            <div class="row mt-4">
                <div class="col-xl-6 offset-xl-3 col-lg-6 offset-lg-3 col-md-8 offset-md-2 col-sm-10 offset-sm-1 col-12">
                    <form id="updateName">
                        <label>
                            <span class="font-weight-bold">Name: </span>
                        </label>
                        <input class="ml-2" type="text" style="border: none; border-radius: 4px" size="30" value="<%= ud.getName() %>" id="userName" name="userName" maxlength="30" required />
                        <button type="submit" class="ml-2 btn btn-sm btn-outline-primary" >Update</button>
                    </form>
                    <br/>
                    <label>
                        <span class="font-weight-bold">Email: </span><%= ud.getEmail() %>
                    </label>
                </div>
            </div>
            <div class="row mt-4">
                <div class="col-12 text-center">
                    <h4>Change Password</h4>
                    <small style="display: none" id="status"></small>
                </div>
            </div>
            <form id="changePassword">
                <div class="col-xl-6 offset-xl-3 col-lg-6 offset-lg-3 col-md-8 offset-md-2 col-sm-10 offset-sm-1 col-12">
                    <label class="mt-2" for="oPassword">Old Password</label>
                    <input type="password" class="form-control" id="oPassword" name="oPassword" minlength="6" placeholder="Old Password" required />
                    <label class="mt-2" for="nPassword">New Password</label>
                    <input type="password" class="form-control" id="nPassword" name="nPassword" minlength="6" placeholder="New Password" required />
                    <label class="mt-2" for="cPassword">Confirm Password</label>
                    <input type="password" class="form-control" id="cPassword" name="cPassword" minlength="6" placeholder="Confirm Password" required />
                    <div class="text-center mt-3">
                        <button type="submit" class="btn btn-outline-primary">
                            Update Password
                        </button>
                    </div>
                </div>
            </form>
            <div class="row mt-4">
                <div class="col-12 text-center">
                    <h4 class="text-danger">Danger Zone</h4>
                    <button id="deleteButton" class="btn btn-outline-danger mt-2 mb-3">
                        Delete Account
                    </button>
                </div>
            </div>
        </div>
        <script src="./js/profile.js" type="text/javascript"></script>
    </body>
</html>
<%
    }
%>
