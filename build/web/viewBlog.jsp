<%-- 
    Document   : viewBLog
    Created on : 27-Jun-2021, 11:06:24 AM
    Author     : chetan
--%>
<%@page import="com.detail.UserDetail"%>
<%@page import="com.dao.BlogDAO"%>
<%@page import="com.database.DBConnect"%>
<%@page import="com.detail.BlogDetail"%>
<%
    int id = 0;
    BlogDetail bd = null;
    try{
        id = Integer.parseInt(request.getParameter("id"));
        BlogDAO dao = new BlogDAO(DBConnect.getConn());
        bd = dao.getBlogDetail(id);
    } catch(Exception e) {}
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
        <title>Blog</title>
        <link href="css/blogStyle.css" rel="stylesheet" type="text/css"/>
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
            if(bd==null) {
        %>
        <div class="container-md">
            <div class="row">
                <div class="col-md-8 offset-md-2 col-sm-12 col-12 middle-card text-light">
                    <div class="text-center">
                        <h1>Blog not found</h1>
                        
                        <a class="top-nav-link" href="./createBlog.jsp">Create own blog</a>
                    </div>
                </div>
            </div>
        </div>
        <%
            } else {
        %>
        <div class="container-md">
            <div class="row">
                <div class="col-md-8 offset-md-2 col-sm-12 col-12 text-light">
                    <div class="middle-card-blog">
                        <div class="text-center">
                            <h1><%= bd.getTitle() %></h1>
                            <% 
                                if(bd.isEdit()) {
                            %>
                            <small class="text-danger">(Edited)</small> <br/>
                            <%
                                }
                            %>
                            <img class="img-fluid mt-2 mb-3" width="75%" src="./img/BlogThumbnail/<%= bd.getPhoto() %>" />
                        </div>
                        <div class="p-3 text-justify">
                            <pre><%= bd.getContent() %></pre>
                        </div>
                        <div class="text-center">
                            <a class="top-nav-link" href="./publicProfile.jsp?userId=<%= bd.getUserId() %>">View Author Profile</a> <br/>
                            <a class="top-nav-link" href="./createBlog.jsp">Create own blog</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%
            }
        %>
    </body>
</html>
