<%-- 
    Document   : viewcart.jsp
    Created on : Aug 30, 2020, 10:50:26 PM
    Author     : tuyet
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cart Page</title>
    </head>
    <body>
        <c:if test="${not empty sessionScope.USER}">
            <font color="red">
            <h2>Welcome, ${sessionScope.USER.fullname}</h2>
            </font><br/>
            <form action="logout" method="POST">
                <input type="submit" value="Logout"/>
            </form><br/>
        </c:if> 
        <c:if test="${empty sessionScope.USER or sessionScope.USER.role.name ne 'user'}">
            <c:redirect url="search"/>
        </c:if>
        <a href="search">Back to Home page</a><br>
        <c:if test="${not empty MSG_ERROR}">
            <font color="red">
            ${MSG_ERROR}
            </font>
        </c:if>
        <c:if test="${not empty MSG_SUCCESS}">
            <font color="green">
            ${MSG_SUCCESS}
            </font>
        </c:if>
        <br>
        <c:if test="${not empty sessionScope.CART}">
            <table border="1">
                <thead>
                    <tr>
                        <th>No</th>
                        <th>Title</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th>Update</th>
                        <th>Delete</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${sessionScope.CART}" varStatus="Counter">
                        <tr>
                            <td>${Counter.count}</td>
                            <td>${item.value.title}</td>
                            <td>${item.value.price}</td>
                    <form action="updateCart" method="POST">
                        <td><input type="number" name="quantity" value="${item.value.quantity}"/> </td>
                        <input type="hidden" name="id" value="${item.key}"/>
                        <td><input type="submit" value="Update"/></td>
                    </form>
                    <form action="deleteCart" method="POST">
                        <input type="hidden" name="id" value="${item.key}"/>
                        <td><input type="submit" value="Delete"/></td>
                    </form>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <p>Total: ${sessionScope.CART.getTotalPrice()}</p>
    <form action="confirmCart" method="POST">
        <input type="submit" value="Confirm"/>
    </form>
</c:if>
<c:if test="${empty sessionScope.CART}">
    <font color="red">No result</font>
</c:if>
</body>
</html>
