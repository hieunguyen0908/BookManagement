<%-- 
    Document   : viewcart.jsp
    Created on : 24 thg 4, 2021, 20:13:33
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.bundle.min.js">
        <script type='text/javascript' src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <title>Cart Page</title>
    </head>
    <body>
        <style>
            body {
                background-color: #eeeeee;
                font-family: 'Open Sans', serif;
                font-size: 14px
            }

            .container-fluid {
                margin-top: 70px
            }

            .card-body {
                -ms-flex: 1 1 auto;
                flex: 1 1 auto;
                padding: 1.40rem
            }

            .img-sm {
                width: 80px;
                height: 80px
            }

            .itemside .info {
                padding-left: 15px;
                padding-right: 7px
            }

            .table-shopping-cart .price-wrap {
                line-height: 1.2
            }

            .table-shopping-cart .price {
                font-weight: bold;
                margin-right: 5px;
                display: block
            }

            .text-muted {
                color: #969696 !important
            }

            a {
                text-decoration: none !important
            }

            .card {
                position: relative;
                display: -ms-flexbox;
                display: flex;
                -ms-flex-direction: column;
                flex-direction: column;
                min-width: 0;
                word-wrap: break-word;
                background-color: #fff;
                background-clip: border-box;
                border: 1px solid rgba(0, 0, 0, .125);
                border-radius: 0px
            }

            .itemside {
                position: relative;
                display: -webkit-box;
                display: -ms-flexbox;
                display: flex;
                width: 100%
            }

            .dlist-align {
                display: -webkit-box;
                display: -ms-flexbox;
                display: flex
            }

            [class*="dlist-"] {
                margin-bottom: 5px
            }

            .coupon {
                border-radius: 1px
            }

            .price {
                font-weight: 600;
                color: #212529
            }

            .btn.btn-out {
                outline: 1px solid #fff;
                outline-offset: -5px
            }

            .btn-main {
                border-radius: 2px;
                text-transform: capitalize;
                font-size: 15px;
                padding: 10px 19px;
                cursor: pointer;
                color: #fff;
                width: 100%
            }

            .btn-light {
                color: #ffffff;
                background-color: #F44336;
                border-color: #f8f9fa;
                font-size: 12px
            }

            .btn-light:hover {
                color: #ffffff;
                background-color: #F44336;
                border-color: #F44336
            }

            .btn-apply {
                font-size: 11px
            }
        </style>

        <c:if test="${not empty sessionScope.USER}">
            <h2>Welcome, <font color="red">${sessionScope.USER.fullname}</font></h2>
            </c:if> 
            <c:if test="${empty sessionScope.USER or sessionScope.USER.role.name ne 'user'}">
                <c:redirect url="search"/>
            </c:if>

        <div class="container-fluid">
            <div class="row">
                <aside class="col-lg-9">
                    <div class="card">
                        <div class="table-responsive">
                            <table class="table table-borderless table-shopping-cart">
                                <thead class="text-muted">
                                    <tr class="small text-uppercase">
                                        <th scope="col">Product</th>
                                        <th scope="col" width="120">Price</th>
                                        <th scope="col" width="120">Quantity</th>
                                        <th scope="col" class="text-right d-none d-md-block" width="200"></th>
                                    </tr>
                                </thead>

                                <tbody>

                                    <c:forEach var="item" items="${sessionScope.CART}" varStatus="Counter">
                                        <tr>
                                            <td> 
                                                <figure class="itemside align-items-center">
                                                    <div class="aside">${item.value.title}</div>
                                                </figure>
                                            </td>

                                            <td> <div class="price-wrap"> <var class="price">$${item.value.price * item.value.quantity}</var></div>
                                            </td>

                                    <form action="updateCart" method="POST">
                                        <td><input type="number" name="quantity" value="${item.value.quantity}" class="form-control"/> </td>
                                        <input type="hidden" name="id" value="${item.key}"/>
                                        <td class="">
                                            <input type="submit" value="Update" title="Update" class="btn btn-light" data-toggle="tooltip" data-abc="true" style="background-color: #33ccff;"/>
                                        </td>
                                    </form>
                                    <form action="deleteCart" method="POST" >
                                        <input type="hidden" name="id" value="${item.key}"/>
                                        <td class="text-right d-none d-md-block">
                                            <input type="submit" title="Remove"  class="btn btn-light" data-abc="true" value="Delete"  onclick="return confirm('Are you sure you want to delete this book?');"/>
                                        </td>
                                    </form>

                                    </tr>
                                </c:forEach>

                                </tbody>

                            </table>
                            <c:if test="${empty sessionScope.CART}">
                                <h2 style="text-align: center"><font color="red">No result</font></h2>
                                </c:if>
                        </div>
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
                    </div>

                    <form action="logout" method="POST">
                        <input type="submit" value="Logout"/>
                    </form>
                </aside>
                <aside class="col-lg-3">
                    <c:if test="${not empty sessionScope.CART}">
                        <div class="card mb-3">
                            <div class="card-body">
                                <form action="ApplyDiscountCode" method="POST">
                                    <div class="form-group"> <label>Have coupon?</label>
                                        <div class="input-group"> <input type="text" maxlength="20" class="form-control coupon" name="txtCode" oninput="this.value = this.value.toUpperCase()" placeholder="Coupon code"> <span class="input-group-append"> <button type="submit" class="btn btn-primary btn-apply coupon">Apply</button> </span> </div>
                                    </div>
                                </form>
                                <c:if test="${not empty MSG_CODE_ERROR}">
                                    <font color="red">
                                    ${MSG_CODE_ERROR}
                                    </font>
                                </c:if>
                                <c:if test="${not empty MSG_CODE_SUCCESS}">
                                    <font color="green">
                                    ${MSG_CODE_SUCCESS}
                                    </font>
                                </c:if>
                            </div>
                        </div>
                    </c:if>
                    <div class="card">
                        <div class="card-body">
                            <dl class="dlist-align">
                                <dt>Total price:</dt>
                                <dd class="text-right ml-3">$${sessionScope.CART.getTotalPrice()}</dd>
                            </dl>

                            <dl class="dlist-align">
                                <dt>Discount:</dt>
                                <dd class="text-right text-danger ml-3">- $${(0.0 * sessionScope.CART.getTotalPrice())}</dd>
                            </dl>
                            <dl class="dlist-align">
                                <dt>Total:</dt>
                                <dd class="text-right text-dark b ml-3"><strong>$${sessionScope.CART.getTotalPrice() - (0.0 * sessionScope.CART.getTotalPrice())}</strong></dd>
                            </dl>
                            <hr> 
                            <c:if test="${not empty sessionScope.CART}">
                                <form action="confirmCart" method="POST"> 
                                    <button type="submit" class="btn btn-out btn-primary btn-square btn-main" data-abc="true">
                                        Make Purchase 
                                    </button>
                                </c:if>
                            </form> 
                            <a href="search" class="btn btn-out btn-success btn-square btn-main mt-2" data-abc="true">
                                Continue Shopping
                            </a>
                        </div>
                    </div>
                </aside>
            </div>
        </div>




        <!--        <div class="container-fluid">
                    <div class="row">
                        <aside class="col-lg-9">
                            <div class="card">
                                <div class="table-responsive">
                                    <table class="table table-borderless table-shopping-cart">
                                        <thead class="text-muted">
                                            <tr class="small text-uppercase">
                                                <th scope="col">Product</th>
                                                <th scope="col" width="120">Price</th>
                                                <th scope="col" width="120">Quantity</th>
                                                <th scope="col" class="text-right d-none d-md-block" width="200"></th>
                                            </tr>
                                        </thead>
                
                                        <tbody>
                
        <c:forEach var="item" items="${sessionScope.CART}" varStatus="Counter">
            <tr>
                <td> 
                    <figure class="itemside align-items-center">
                        <div class="aside">${item.value.title}</div>
                    </figure>
                </td>

                <td> <div class="price-wrap"> <var class="price">$${item.value.price}</var></div>
                </td>

        <form action="updateCart" method="POST">
            <td><input type="number" name="quantity" value="${item.value.quantity}" class="form-control"/> </td>
            <input type="hidden" name="id" value="${item.key}"/>
            <td class="">
                <input type="submit" value="Update" title="Update" class="btn btn-light" data-toggle="tooltip" data-abc="true" style="background-color: #33ccff;"/>
            </td>
        </form>
        <form action="deleteCart" method="POST" >
            <input type="hidden" name="id" value="${item.key}"/>
            <td class="text-right d-none d-md-block">
                <input type="submit" title="Remove"  class="btn btn-light" data-abc="true" value="Delete"  onclick="return confirm('Are you sure you want to delete this book?');"/>
            </td>
        </form>

        </tr>
        </c:forEach>

        </tbody>

    </table>
        <c:if test="${empty sessionScope.CART}">
            <h2 style="text-align: center"><font color="red">No result</font></h2>
        </c:if>
</div>
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
    </div>
    
    <form action="logout" method="POST">
        <input type="submit" value="Logout" style="margin-top: "/>
    </form>
</aside>
<aside class="col-lg-3">
    <div class="card mb-3">
        <div class="card-body">
            <form action="ApplyDiscountCode" method="POST">
                <div class="form-group"> <label>Have coupon?</label>
                    <div class="input-group"> <input type="text" maxlength="20" class="form-control coupon" name="txtCode" oninput="this.value = this.value.toUpperCase()" placeholder="Coupon code"> <span class="input-group-append"> <button type="submit" class="btn btn-primary btn-apply coupon">Apply</button> </span> </div>
                </div>
            </form>

        </div>
    </div>
    <div class="card">
        <div class="card-body">
            <dl class="dlist-align">
                <dt>Total price:</dt>
                <dd class="text-right ml-3">$69.97</dd>
            </dl>
            <dl class="dlist-align">
                <dt>Discount:</dt>
                <dd class="text-right text-danger ml-3">- $10.00</dd>
            </dl>
            <dl class="dlist-align">
                <dt>Total:</dt>
                <dd class="text-right text-dark b ml-3"><strong>$59.97</strong></dd>
            </dl>
            <hr> 

            <form action="confirmCart" method="POST"> 
                <button type="submit" class="btn btn-out btn-primary btn-square btn-main" data-abc="true">
                    Make Purchase 
                </button>

            </form> 
            <a href="search" class="btn btn-out btn-success btn-square btn-main mt-2" data-abc="true">
                Continue Shopping
            </a>
        </div>
    </div>
</aside>
</div>
</div>-->

    </body>
</html>



