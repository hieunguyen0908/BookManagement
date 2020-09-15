<%-- 
    Document   : login
    Created on : Aug 29, 2020, 4:18:49 PM
    Author     : tuyet
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
    </head>
    <body>
        <h1>Login</h1>
    <c:if test="${not empty MSG_ERROR}">
        <font color="red">
            ${MSG_ERROR}
        </font>
    </c:if>
        <form action="login" method="POST">
            Username: <input type="text" name="txtUsername" value="" /><br/>
            Password: <input type="password" name="txtPassword" value="" /><br/>
            <input type="submit" value="Login"/>
        </form>
        <a href="search" style="text-decoration : none">Back to home</a>
    </body>
</html>
