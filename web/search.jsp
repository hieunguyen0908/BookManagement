<%-- 
Document   : search
Created on : Aug 29, 2020, 4:20:11 PM
Author     : tuyet
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home Page</title>
    </head>
    <body>
        <h1>Book Store</h1>
        <c:if test="${empty sessionScope.USER}">
            <a href="login.jsp" style="text-decoration : none">Login</a>
        </c:if>
        <c:if test="${not empty sessionScope.USER}">
            <font color="red">
            <h2>Welcome, ${sessionScope.USER.fullname}</h2>
            </font><br/>
            <form action="logout" method="POST">
                <input type="submit" value="Logout"/>
            </form><br/>
            <c:if test="${sessionScope.USER.role.name eq 'admin'}">
                <a href="loadInsert" style="text-decoration : none">Insert</a><br/>
            </c:if>
            <c:if test="${sessionScope.USER.role.name eq 'user' and not empty sessionScope.CART}">
                <a href="viewCart.jsp" style="text-decoration : none">Your Cart</a><br/>
            </c:if>
        </c:if>
        <br/>
        <form action="search" method="POST">
            <p>Search</p>
            Title: <input type="text" name="txtTitle" value="${param.txtTitle}" /><br/>
            Category: <select name="categorys">
                <option value="all">All</option>
                <c:forEach var="cateDto" items="${requestScope.CATE_LIST}" >
                    <option value="${cateDto.name}" <c:if test="${param.categorys eq cateDto.name}">selected</c:if>>${cateDto.name}</option>
                </c:forEach>    
            </select><br/>
            Range Money: 
            Min: <input type="number" min="0" max="9999999" name="txtMin" value="${param.txtMin}" />
            Max: <input type="number" min="0" max="9999999" name="txtMax" value="${param.txtMax}" />
            <br/>
            <input type="submit" value="Search" />
        </form>
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
        <c:if test="${not empty requestScope.SEARCH_RESULT}">
            <table border='1'>
                <thead>
                    <tr>
                        <th>No.</th>
                        <th>Title</th>
                        <th>Image</th>
                        <th>Describe</th>
                        <th>Price</th>
                        <th>Author</th>
                        <th>Category Name</th>
                        <th>Import Date</th>
                        <th>Quantity</th>
                            <c:if test="${sessionScope.USER.role.name eq 'admin'}"> 
                            <th>Update</th>
                            <th>Delete</th>
                            </c:if>
                            <c:if test="${sessionScope.USER.role.name eq 'user'}"> 
                            <th>Add To Cart</th>
                            </c:if>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="dto" items="${requestScope.SEARCH_RESULT}" varStatus="Counter">
                        <c:if test="${empty sessionScope.USER or sessionScope.USER.role.name ne 'admin'}">
                            <tr>
                                <td>
                                    ${Counter.count}
                                </td>
                                <td>
                                    <input type="text" name="txtTitle" value="${dto.title}" readonly/>
                                </td>
                                <td>
                                    <input type="text" name="txtImage" value="${dto.image} " readonly/>
                                </td>
                                <td>
                                    <input type="text" name="txtDescribe" value="${dto.describe}" readonly/>
                                </td>
                                <td>
                                    <input type="number" name="txtPrice" value="${dto.price}" readonly />
                                </td>
                                <td>
                                    <input type="text" name="txtAuthor" value=" ${dto.author}" readonly />
                                </td>
                                <td>
                                    <input type="text" name="txtCategory" value="${dto.category.name}" readonly />
                                </td>
                                <td>
                                    <input type="date" name="txtImportDate" value="${dto.importDate}" readonly/>
                                </td>
                                <td>
                                    <input type="text" name="txtQuantity" value="${dto.quantity}" readonly/>
                                </td>
                                <c:if test="${sessionScope.USER.role.name eq 'user'}"> 
                            <form action="addToCart" method="POST">
                                <input type="hidden" name="id" value="${dto.id}"/>
                                <input type="hidden" name="title" value="${dto.title}"/>
                                <input type="hidden" name="price" value="${dto.price}"/>

                                <input type="hidden" name="txtTitle" value="${param.txtTitle}" />
                                <input type="hidden" name="txtMin" value="${param.txtMin}" />
                                <input type="hidden" name="txtMax" value="${param.txtMax}" />
                                <input type="hidden" name="categorys" value="${param.categorys}" />
                                <td><input type="submit" value="Add To Cart"/></td>
                            </form>
                        </c:if>
                    </tr>
                </c:if>
                <c:if test="${not empty sessionScope.USER and sessionScope.USER.role.name eq 'admin'}">
                    <tr>
                    <form action="update" method="POST">
                        <td>
                            ${Counter.count}
                        </td>
                        <td>
                            <input type="text" name="txtTitleUpdate" value="${dto.title}" />
                        </td>
                        <td>
                            <input type="text" name="txtImage" value="${dto.image}" />
                        </td>
                        <td>
                            <input type="text" name="txtDescribe" value="${dto.describe}" />
                        </td>
                        <td>
                            <input type="text" name="txtPrice" value="${dto.price}" />
                        </td>
                        <td>
                            <input type="text" name="txtAuthor" value=" ${dto.author}" />
                        </td>
                        <td>
                            <select name="categoryUpdate">
                                <c:forEach var="cateDto" items="${requestScope.CATE_LIST}" >
                                    <option value="${cateDto.id}">${cateDto.name}</option>
                                </c:forEach>    
                            </select><br/>
                        </td>
                        <td>
                            <input type="date" name="txtImportDate" value="${dto.importDate}" />
                        </td>
                        <td>
                            <input type="text" name="txtQuantity" value="${dto.quantity}" />
                        </td>
                        <td>
                            <input type="hidden" name="txtId" value="${dto.id}" />
                            <input type="hidden" name="txtTitle" value="${param.txtTitle}" />
                            <input type="hidden" name="txtMin" value="${param.txtMin}" />
                            <input type="hidden" name="txtMax" value="${param.txtMax}" />
                            <input type="hidden" name="categorys" value="${param.categorys}" />
                            <input type="submit" value="Update" />
                        </td>
                    </form>
                    <td>
                        <form action="delete" method="POST">
                            <input type="hidden" name="txtId" value="${dto.id}" />
                            <input type="hidden" name="txtTitle" value="${param.txtTitle}" />
                            <input type="hidden" name="txtMin" value="${param.txtMin}" />
                            <input type="hidden" name="txtMax" value="${param.txtMax}" />
                            <input type="hidden" name="categorys" value="${param.categorys}" />
                            <input type="submit" value="Delete" />
                        </form>
                    </td> 
                </tr>
            </c:if>
        </c:forEach>
    </tbody>
</table>

</c:if>  
<c:if test="${empty requestScope.SEARCH_RESULT}">
    <font color="red">
    <h2>No Result</h2>
    </font>
</c:if>
</body>
</html>
