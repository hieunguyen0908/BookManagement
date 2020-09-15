<%-- 
    Document   : insert
    Created on : Aug 30, 2020, 6:14:58 PM
    Author     : tuyet
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Book</title>
    </head>
    <body>
        <h1>Create New Book</h1>
        <c:if test="${not empty sessionScope.USER}">
            <font color="red">
            <h2>Welcome, ${sessionScope.USER.fullname}</h2>
            </font>
            <form action="logout" method="POST">
                <input type="submit" value="Logout"/>
            </form>
        </c:if>

        <c:if test="${empty sessionScope.USER or sessionScope.USER.role.name ne 'admin'}">
            <c:redirect url="login.jsp"/>
        </c:if>

        <c:if test="${not empty requestScope.MSG_ERROR}">
            <font color="red">
            ${requestScope.MSG_ERROR}
            </font>
        </c:if>

        <c:if test="${not empty requestScope.MSG_SUCCESS}">
            <font color="green">
            ${requestScope.MSG_SUCCESS}
            </font>
        </c:if>
        <form action="insert" method="POST">
            Book ID :  <input type="text" name="txtId" value="" /><br/>
            Title :  <input type="text" name="txtTitle" value="" /><br/>
            Image :  <input type="text" name="txtImage" value="" /><br/>
            Describe : <input type="text-area" name="txtDescribe" value="" /><br/>
            Price : <input type="number" name="txtPrice" value="" /><br/>
            Author : <input type="text" name="txtAuthor" value="" /><br/>
            Category : <select name="categorys">
                <c:forEach var="cateDto" items="${requestScope.CATE_LIST}">
                    <option value="${cateDto.id}">${cateDto.name}</option>
                </c:forEach>
            </select><br/>
            Quantity : <input type="number" name="txtQuantity" value="" /><br/>
            <input type="submit" value="Insert" />
            <input type="reset" value="Reset" />
        </form>
        <a href="search" style="text-decoration : none">Back to home</a>
    </body>
</html>
