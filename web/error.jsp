<%-- 
    Document   : error
    Created on : Aug 29, 2020, 5:49:02 PM
    Author     : tuyet
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Error Page</title>
    </head>
    <body>
        <font color="red">
        ${requestScope.ERROR}
        </font>
    </body>
</html>
