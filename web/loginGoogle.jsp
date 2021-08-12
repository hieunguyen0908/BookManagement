<%-- 
    Document   : index
    Created on : 25 thg 4, 2021, 23:28:30
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" language="java"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Login</title>
    </head>
    <body>
        <font color="red"><h1>Ban da dang nhap thanh cong bang tai khoan Google!</h1></font> 
        <%
            String id = request.getAttribute("id").toString();
            String email = request.getAttribute("email").toString();
//            out.print("Id: " + id);
//            out.print("<br/>Email: " + email);

        %>
        <a href="login.jsp">Back</a>
    </body>
</html>