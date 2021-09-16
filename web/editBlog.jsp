<%-- 
    Document   : editBlog
    Created on : 17-Jun-2021, 4:00:04 PM
    Author     : chetan
--%>

<%@page import="com.detail.BlogDetail"%>
<%@page import="com.dao.BlogDAO"%>
<%@page import="com.database.DBConnect"%>
<%@page import="com.detail.UserDetail"%>
<%
    if(session.getAttribute("userLogin")==null) {
        response.sendRedirect("./login.jsp");
    } else {
        UserDetail ud = (UserDetail)session.getAttribute("userLogin");
        int id = 0;
        BlogDetail bd = null;
        try{
            id = Integer.parseInt(request.getParameter("id"));
            BlogDAO dao = new BlogDAO(DBConnect.getConn());
            bd = dao.getEditBlogDetail(id, ud.getId());
            if(bd==null){
                response.sendRedirect("./home.jsp");
            }
        } catch(Exception e) {
            response.sendRedirect("./home.jsp");
        }
        if(bd!=null) {
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
        <title>Update Blog | Blog</title>
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
                <a class="btn btn-outline-light mr-2" href="./profile.jsp">
                    <%= ud.getName() %>
                </a>
                <a class="btn btn-outline-light" href="./logout.jsp">Logout</a>
            </div>
        </nav>
        <div class="container-md text-light">
            <div class="row mt-5 mb-3">
                <div class="col-12 text-center">
                    <h2>Update Blog</h2>
                    <small id="status" style="display: none;">d</small>
                </div>
            </div>
            <form id="createBlog" >
                <div class="row">
                    <div class="col-xl-8 offset-xl-2 col-lg-10 offset-lg-1 col-md-10 offset-md-1 col-12">
                        <input id="blogId" name="blogId" value="<%= bd.getId() %>" hidden required />
                        <label for="title">Title: </label>
                        <input class="form-control" type="text" id="title" value="<%= bd.getTitle() %>" name="title" placeholder="Title (Max-length: 100 character)" maxlength="100" required />
                        <label class="mt-3" for="content">Content:</label>
                        <textarea rows="12" id="content" name="content" class="form-control blog-textarea" placeholder="Enter your content..."><%= bd.getContent() %></textarea>
                        <div class="text-center mt-3 mb-5">
                            <button type="submit" class="btn btn-outline-success">Update Blog</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
        <script src="js/editBlog.js" type="text/javascript"></script>
    </body>
</html>
<%
        }
    }
%>