<%-- 
    Document   : search
    Created on : 24 thg 4, 2021, 15:35:04
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home Page</title>
        <link href='https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css' rel='stylesheet'>
        <link href='https://use.fontawesome.com/releases/v5.8.1/css/all.css' rel='stylesheet'>
        <script type='text/javascript' src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>
        <!--        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">-->
        <!--                        <link href='https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css' rel='stylesheet' type='text/css'>-->
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    </head>
    <body>
        <style>
            .panel{
                font-family: 'Raleway', sans-serif;
                padding: 0;
                border: none;
                width: 1100px;
                box-shadow: 0 0 10px rgba(0,0,0,0.08);
            }
            .panel .panel-heading{
                background: #535353;
                padding: 15px;

                border-radius: 0;
            }
            .panel .panel-heading .btn{
                color: #fff;
                background-color: #000;
                font-size: 14px;
                font-weight: 600;
                padding: 7px 15px;
                border: none;
                border-radius: 0;
                transition: all 0.3s ease 0s;
            }
            .panel .panel-heading .btn:hover{ box-shadow: 0 0 10px rgba(0, 0, 0, 0.5); }
            .panel .panel-heading .form-horizontal .form-group{ margin: 0; }
            .panel .panel-heading .form-horizontal label{
                color: #fff;
                margin-right: 10px;
            }
            .panel .panel-heading .form-horizontal .form-control{
                display: inline-block;
                width: 80px;
                border: none;
                border-radius: 0;
            }
            .panel .panel-heading .form-horizontal .form-control:focus{
                box-shadow: none;
                border: none;
            }
            .panel .panel-body{
                padding: 0;
                border-radius: 0;
            }
            .panel .panel-body .table thead tr th{
                color: #fff;
                background: #8D8D8D;
                font-size: 17px;
                font-weight: 700;
                padding: 12px;
                border-bottom: none;
            }
            .panel .panel-body .table thead tr th:nth-of-type(1){ width: 120px; }
            .panel .panel-body .table thead tr th:nth-of-type(3){ width: 50%; }
            .panel .panel-body .table tbody tr td{
                color: #555;
                background: #fff;
                font-size: 15px;
                font-weight: 500;
                padding: 13px;
                vertical-align: middle;
                border-color: #e7e7e7;
            }
            .panel .panel-body .table tbody tr:nth-child(odd) td{ background: #f5f5f5; }
            .panel .panel-body .table tbody .action-list{
                padding: 0;
                margin: 0;
                list-style: none;
            }
            .panel .panel-body .table tbody .action-list li{ display: inline-block; }
            .panel .panel-body .table tbody .action-list li a{
                color: #fff;
                font-size: 13px;
                line-height: 28px;
                height: 28px;
                width: 33px;
                padding: 0;
                border-radius: 0;
                transition: all 0.3s ease 0s;
            }
            .panel .panel-body .table tbody .action-list li a:hover{ box-shadow: 0 0 5px #ddd; }
            .panel .panel-footer{
                color: #fff;
                background: #535353;
                font-size: 16px;
                line-height: 33px;
                padding: 25px 15px;
                border-radius: 0;
            }
            .pagination{ margin: 0; }
            .pagination li a{
                color: #fff;
                background-color: rgba(0,0,0,0.3);
                font-size: 15px;
                font-weight: 700;
                margin: 0 2px;
                border: none;
                border-radius: 0;
                transition: all 0.3s ease 0s;
            }
            .pagination li a:hover,
            .pagination li a:focus,
            .pagination li.active a{
                color: #fff;
                background-color: #000;
                box-shadow: 0 0 5px rgba(0,0,0,0.4);
            }

            /*search box css start here*/
            .search-sec{
                padding: 2rem;
            }
            .search-slt{
                display: block;
                width: 100%;
                font-size: 0.875rem;
                line-height: 1.5;
                color: #55595c;
                background-color: #fff;
                background-image: none;
                border: 1px solid #ccc;
                height: calc(3rem + 2px) !important;
                border-radius:0;
            }
            .wrn-btn{
                width: 200%;
                margin-top: 10px;
                margin-left: 100%;
                font-size: 16px;
                font-weight: 400;
                text-transform: capitalize;
                height: calc(3rem + 2px) !important;
                border-radius:0;
            }
            @media (min-width: 992px){
                .search-sec{
                    position: relative;
                    top: -114px;
                    background: rgba(26, 70, 104, 0.51);
                }
            }

            @media (max-width: 992px){
                .search-sec{
                    background: #1A4668;
                }
            }
        </style>
        <!--        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" /> -->
        <c:if test="${not empty sessionScope.USER}">
            <h2>Welcome, <font color="red">${sessionScope.USER.fullname}
                </font>(${sessionScope.USER.role.name})
            </h2>
            <br/>
            <c:if test="${sessionScope.USER.role.name ne 'admin'}">
                <a href="history">History</a>
                <br/>
                <a href="onlinePayment">Payment via Vnpay</a>

            </c:if>
            
        </c:if>




        <div class="container">
            <div class="row pt-1 pb-1">
                <div class="col-lg-12">
                    <h1 class="text-center">Search</h1>
                </div>
            </div>
        </div>

        <div class="container">
            <form action="search" method="post" novalidate="novalidate">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="row">
                            <div class="col-lg-3 col-md-3 col-sm-12 p-0">
                                <input type="text" class="form-control search-slt" placeholder="Enter title" name="txtTitle" value="${param.txtTitle}">
                            </div>
                            <div class="col-lg-3 col-md-3 col-sm-12 p-0">
                                <input type="number" min="0" max="9999999" name="txtMin" value="${param.txtMin}" class="form-control search-slt" placeholder="Enter min price">
                            </div>
                            <div class="col-lg-3 col-md-3 col-sm-12 p-0">
                                <input type="number" min="0" max="9999999" name="txtMax" value="${param.txtMax}" class="form-control search-slt" placeholder="Enter max price">
                            </div>
                            <div class="col-lg-3 col-md-3 col-sm-12 p-0">
                                <select name="categorys" class="form-control search-slt" id="exampleFormControlSelect1">
                                    <option value="all">--- Select category ---</option>
                                    <c:forEach var="cateDto" items="${requestScope.CATE_LIST}" >
                                        <option value="${cateDto.name}" <c:if test="${param.categorys eq cateDto.name}">selected</c:if>>${cateDto.name}</option>
                                    </c:forEach>    
                                </select>
                            </div>

                            <div class="col-lg-3 col-md-3 col-sm-12 p-0" >
                                <input type="submit" value="Search" class="btn btn-danger wrn-btn" class="form-control search-slt"/>
                            </div>

                        </div>
                    </div>
                </div>
            </form>
        </div>

        <br/>
        <div class="container">
            <div class="row">
                <div class="col-md-offset-1 col-md-10">
                    <div class="panel">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-sm-12 col-xs-12">
                                    <c:if test="${not empty sessionScope.USER}">
                                        <c:if test="${sessionScope.USER.role.name eq 'admin'}">
                                            <a href="loadInsert" class="btn btn-sm btn-primary pull-left">
                                                <i class="fa fa-plus-circle"></i> Insert Book
                                            </a>
                                            <a href="createDiscountCode.jsp" class="btn btn-sm btn-primary pull-left">
                                                <i class="fa fa-plus-circle"></i> Create Discount Code
                                            </a>
                                        </c:if>
                                        <c:if test="${sessionScope.USER.role.name eq 'user' and not empty sessionScope.CART}">
                                            <a href="viewCart.jsp" class="btn btn-sm btn-primary pull-left">
                                                Your Cart</i> 
                                            </a>
                                        </c:if>
                                        <form action="logout" method="POST" class="btn btn-sm btn-primary pull-left">
                                            <input type="submit" value="Logout" class="btn btn-sm btn-primary pull-left" />
                                        </form>
                                    </c:if>

                                    <c:if test="${empty sessionScope.USER}">
                                        <a href="login.jsp" class="btn btn-sm btn-primary pull-left">
                                            Login
                                        </a>
                                    </c:if>

                                </div>

                            </div>
                        </div>
                        <div class="panel-body table-responsive">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Title</th>
                                        <th>Image</th>
                                        <th>Describe</th>
                                        <th>Price</th>
                                        <th>Author</th>
                                        <th>Category</th>
                                        <th>Date</th>
                                        <th>Quantity</th>
                                        <th>Details</th>
                                            <c:if test="${sessionScope.USER.role.name eq 'admin'}"> 
                                            <th>Action</th>
                                            </c:if>
                                            <c:if test="${sessionScope.USER.role.name eq 'user'}"> 
                                            <th>Action</th>
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
                                                    <input type="text" name="txtAuthor" value="${dto.author}" readonly />
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
                                                <td>
                                                    <a href="#" class="btn btn-sm btn-success">
                                                        <i class="fa fa-search"></i>
                                                    </a>
                                                </td>
                                                <c:if test="${sessionScope.USER.role.name eq 'user'}"> 
                                                    <td>
                                                        <ul class="action-list">
                                                            <li>
                                                                <form action="addToCart" method="POST">
                                                                    <input type="hidden" name="id" value="${dto.id}"/>
                                                                    <input type="hidden" name="title" value="${dto.title}"/>
                                                                    <input type="hidden" name="price" value="${dto.price}"/>
                                                                    <input type="hidden" name="txtTitle" value="${param.txtTitle}" />
                                                                    <input type="hidden" name="txtMin" value="${param.txtMin}" />
                                                                    <input type="hidden" name="txtMax" value="${param.txtMax}" />
                                                                    <input type="hidden" name="categorys" value="${param.categorys}" />
                                                                    <button type="submit" class="btn btn-primary"/><i class="fa fa-plus-circle"></i>
                                                                </form>
                                                            </li>
                                                        </ul>
                                                    </td>
                                                </c:if>
                                            </tr>
                                        </c:if>

                                        <c:if test="${not empty sessionScope.USER and sessionScope.USER.role.name eq 'admin'}">
                                            <tr>
                                               <form action="update" method="post">
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
                                                        <input type="text" name="txtAuthor" value="${dto.author}" />
                                                    </td>
                                                    <td>
                                                        <select name="categoryUpdate">
                                                            <c:forEach var="cateDto" items="${requestScope.CATE_LIST}">
                                                                <option value="${cateDto.id}">
                                                                    ${cateDto.name}
                                                                </option>
                                                            </c:forEach>  
                                                        </select><br/>
                                                    </td>
                                                    <td>
                                                        <input type="date" name="txtImportDate" value="${dto.importDate}" />
                                                    </td>
                                                    <td>
                                                        <input type="text" name="txtQuantity" value="${dto.quantity}" />
                                                    </td>
                                                    <td><a href="#" class="btn btn-sm btn-success"><i class="fa fa-search"></i></a></td>
                                                    <td>
                                                        <ul class="action-list">
                                                            <li>
                                                                <input type="hidden" name="txtId" value="${dto.id}" />
                                                                <input type="hidden" name="txtTitle" value="${param.txtTitle}" />
                                                                <input type="hidden" name="txtMin" value="${param.txtMin}" />
                                                                <input type="hidden" name="txtMax" value="${param.txtMax}" />
                                                                <input type="hidden" name="categorys" value="${param.categorys}" />
                                                                <button type="submit" class="btn btn-primary"/><i class="fa fa-pencil-alt"></i>
                                               </form>
                                        
                                                            </li>
                                                            <li>
                                                                <form action="delete" method="post">
                                                                    <input type="hidden" name="txtId" value="${dto.id}" />
                                                                    <input type="hidden" name="txtTitle" value="${param.txtTitle}" />
                                                                    <input type="hidden" name="txtMin" value="${param.txtMin}" />
                                                                    <input type="hidden" name="txtMax" value="${param.txtMax}" />
                                                                    <input type="hidden" name="categorys" value="${param.categorys}" />
                                                                    <button type="submit" class="btn btn-danger" onclick="return confirm('Are you sure you want to delete this book?');"/><i class="fa fa-times"></i>
                                                                </form>
                                                            </li>
                                                        </ul>
                                                    </td>
                                            </tr>
                                        </c:if>
                                    </c:forEach>

                                    </tbody>
                            </table>

                            <c:if test="${empty requestScope.SEARCH_RESULT}">
                                <font color="red" style="text-align: center">
                                <h2>No Result</h2>
                                </font>
                            </c:if>
                            <c:if test="${not empty MSG_ERROR}">
                                <font color="red" style="text-align: center">
                                <h2>${MSG_ERROR}</h2>
                                </font>
                            </c:if>
                            <c:if test="${not empty MSG_SUCCESS}">
                                <font color="green" style="text-align: center">
                                <h2>${MSG_SUCCESS}</h2>
                                </font>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </body>
</html>
