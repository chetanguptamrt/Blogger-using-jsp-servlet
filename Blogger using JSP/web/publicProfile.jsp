<%-- 
    Document   : publicProfile
    Created on : 16-Jul-2021, 4:33:05 PM
    Author     : chetan
--%>
<%@page import="com.detail.UserDetail"%>
<%@page import="com.detail.BlogDetail"%>
<%@page import="com.detail.PublicProfileDetail"%>
<%@page import="com.dao.PublicProfileDAO"%>
<%@page import="com.database.DBConnect"%>
<%
    int id = 0;
    try{
        id = Integer.parseInt(request.getParameter("userId"));
    } catch(Exception e) {}
    PublicProfileDAO dao = new PublicProfileDAO(DBConnect.getConn());
    PublicProfileDetail ppd = dao.getPublicProfile(id);
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
        <title>Profile | Blog</title>
        <link href="css/publicProfile.css" rel="stylesheet" type="text/css"/>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>
    </head>
    <body>
        <%
            UserDetail ud = (UserDetail)session.getAttribute("userLogin");
            if(ud==null){
        %>
        <nav class="navbar navbar-dark bg-dark">
            <h2 style="float: left;" class="text-light ">
                <a href="./index.jsp" class="top-nav-link">Blog</a>
            </h2>
            <div style="float: right;">
                <a class="btn btn-outline-light mr-2" href="./registration.jsp">Sign Up</a>
                <a class="btn btn-outline-light" href="./login.jsp">Login</a>
            </div>
        </nav>
        <%
            } else {
        %>
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
        <%
            }
            if(ppd==null) {
        %>
        <div class="container-md">
            <div class="row">
                <div class="col-md-8 offset-md-2 col-sm-12 col-12 middle-card text-light">
                    <div class="text-center">
                        <h1>Public profile not found</h1>
                        <a class="top-nav-link" href="./createBlog.jsp">Create own blog</a>
                    </div>
                </div>
            </div>
        </div>
        <%
            } else {
        %>
        <<div class="container-md">
            <div class="row">
                <div class="col-12 text-center text-light mt-1 mb-2">
                    <h3><%= ppd.getName() %></h3>
                </div>
            </div>
            <div class="row">
                <%
                    for(BlogDetail bd : ppd.getList()) {
                %>
                <div class="col-xl-4 col-lg-4 col-md-6 col-sm-6 col-12 mb-2">
                    <div class="p-3 blog-content text-light">
                        <div class="text-center mb-1">
                            <img class="img-fluid" src="./img/BlogThumbnail/<%= bd.getPhoto() %>" alt="blog" />
                        </div>
                        <label><%= bd.getTitle() %></label>
                        <a class="btn btn-sm btn-outline-primary blog-content-btn text-light" href="./viewBlog.jsp?id=<%= bd.getId() %>" >View Blog</a>
                    </div>
                </div>
                <%
                    }
                %>
            </div>
        </div>
        <%
            }
        %>
        
    </body>
</html>
