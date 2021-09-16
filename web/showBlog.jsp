<%-- 
    Document   : showBlog
    Created on : 17-Jun-2021, 4:01:18 PM
    Author     : chetan
--%>

<%@page import="com.detail.BlogDetail"%>
<%@page import="java.util.List"%>
<%@page import="com.dao.BlogDAO"%>
<%@page import="com.database.DBConnect"%>
<%@page import="com.detail.UserDetail"%>
<%
    if(session.getAttribute("userLogin")==null) {
        response.sendRedirect("./login.jsp");
    } else {
        UserDetail ud = (UserDetail)session.getAttribute("userLogin");
        BlogDAO bdao = new BlogDAO(DBConnect.getConn());
        List<BlogDetail> list = bdao.getShowBlog(ud.getId());
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
        <title>Show Blog | Blog</title>
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
        
        <div class="container-md text-light">
            <div class="row mt-3 mb-3">
                <div class="col-12 text-center">
                    <h3>Your Blog</h3>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <div class="table-responsive">
                        <table class="table text-center text-light">
                            <thead>
                                <tr>
                                    <td>Id</td>
                                    <td>Title</td>
                                    <td>Time</td>
                                    <td>Edit</td>
                                    <td>Action</td>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    int srNo = 0;
                                    for(BlogDetail bd : list) {
                                        srNo+=1;
                                %>
                                <tr>
                                    <td><%= srNo %></td>
                                    <td><%= bd.getTitle() %></td>
                                    <td><%= bd.getTime() %></td>
                                    <%
                                        if(bd.isEdit()) {
                                    %>
                                    <td>Edited</td>
                                    <%
                                        } else {
                                    %>
                                    <td>Not Edited</td>
                                    <%
                                        }
                                    %>
                                    <td>
                                        <div>
                                            <a href="./viewBlog.jsp?id=<%= bd.getId() %>" class="btn btn-sm btn-outline-success mr-2 mb-1">View</a>
                                            <a href="./editBlog.jsp?id=<%= bd.getId() %>" class="btn btn-sm btn-outline-primary mr-2 mb-1">Edit</a>
                                            <a href="./DeleteBlogServlet?id=<%= bd.getId() %>" class="btn btn-sm btn-outline-danger mb-1">Delete</a>
                                        </div>
                                    </td>
                                </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        
    </body>
</html>
<%
    }
%>