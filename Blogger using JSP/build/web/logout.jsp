<%-- 
    Document   : logout
    Created on : 17-Jun-2021, 3:34:05 PM
    Author     : chetan
--%>

<%
    session.invalidate();
    response.sendRedirect("./login.jsp");
%>
