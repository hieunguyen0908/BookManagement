<%-- 
    Document   : createDiscountCodeSuccessful
    Created on : 15 thg 6, 2021, 19:07:14
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
        <link href='https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-alpha1/dist/css/bootstrap.min.css' rel='stylesheet'>
        <link href='' rel='stylesheet'>
        <script type='text/javascript' src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>
        <style>body {
                background-color: #eee
            }

            .card {
                border: none;
                position: relative
            }

            .off {
                font-size: 60px;
                margin-top: -16px !important;
                color: blue
            }

            .flat {
                font-size: 20px
            }

            .star {
                margin-top: 25px !important;
                font-size: 28px
            }

            .line {
                padding-right: 8rem !important;
                padding-left: 8rem !important
            }

            .line hr {
                height: 2px
            }

        </style>
    </head>

    <body oncontextmenu='return false' class='snippet-body'>
        <div class="container mt-5">
            <div class="row d-flex justify-content-center">
                <div class="col-md-5">
                    <div class="card">
                        <div class="text-right p-2"> <img src="http://www.thienvuongeducation.com/upload/images/website(1).jpg" width="120"> </div>
                        <div class="text-center"> <small class="text-uppercase flat">Book</small> </div>
                        <div class="d-flex justify-content-center px-2">
                            <div class="d-flex flex-row">
                                <h1 class="mt-0 off">-${requestScope.PERCENT_DISCOUNT}% OFF</h1> <sup class="mt-2 text-primary star">*</sup>
                            </div>
                        </div>
                        <div class="line">
                            <hr>
                        </div>
                        <div class="text-center mb-5"> <span class="text-uppercase">USE CODE: <font color="red"> ${requestScope.CODE}</font> (-${requestScope.PERCENT_DISCOUNT}%)</span> 
                            <c:if test="${not empty MSG_SUCCESS}">
                                <font color="green">
                                <br/>
                                ${MSG_SUCCESS}
                                </font>
                            </c:if>
                        </div>

                        <div class="text-right p-1"> <small>*Not expire</small> </div>
                    </div>
                    <div class="text-left p-1"> <small><input type="button" value="Back" onclick="history.back(-1)" /> </small></div>

                </div>
            </div>
        </div>


        <script type='text/javascript' src='https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-alpha1/dist/js/bootstrap.bundle.min.js'></script>
        <script type='text/javascript'></script>
    </body>
</html>
