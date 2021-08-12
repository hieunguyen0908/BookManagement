<%-- 
    Document   : history
    Created on : 18 thg 6, 2021, 22:39:10
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.bundle.min.js">
        <script type='text/javascript' src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <title>Shopping History</title>
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
                                    <th scope="col" width="120">Date</th>
                                </tr>
                            </thead>
                            <tbody>


                            </tbody>

                        </table>
                        <c:if test="${empty sessionScope.HISTORY}">
                            <h2 style="text-align: center"><font color="red">No result</font></h2>
                        </c:if>
                    </div>
                </div>

                <form action="logout" method="POST">
                    <input type="submit" value="Logout"/>
                </form>
            </aside>

        </div>
    </div>

</body>
</html>
