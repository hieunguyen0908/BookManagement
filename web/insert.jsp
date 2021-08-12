<%-- 
    Document   : insert
    Created on : 20 thg 4, 2021, 22:24:17
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/simple-line-icons/2.4.1/css/simple-line-icons.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="assets/css/style.css">
        <title>Create Book</title>
    </head>
    <body>
        <style>
            body{
                background-color: #dee9ff;
            }

            .registration-form{
                padding: 50px 0;
            }

            .registration-form form{
                background-color: #fff;
                max-width: 600px;
                margin: auto;
                padding: 50px 70px;
                border-top-left-radius: 30px;
                border-top-right-radius: 30px;
                box-shadow: 0px 2px 10px rgba(0, 0, 0, 0.075);
            }

            .registration-form .form-icon{
                text-align: center;
                background-color: #5891ff;
                border-radius: 50%;
                font-size: 40px;
                color: white;
                width: 100px;
                height: 100px;
                margin: auto;
                margin-bottom: 50px;
                line-height: 100px;
            }

            .registration-form .item{
                border-radius: 20px;
                margin-bottom: 25px;
                padding: 10px 20px;
            }

            .registration-form .create-account{
                border-radius: 30px;
                padding: 10px 20px;
                font-size: 18px;
                font-weight: bold;
                background-color: #5791ff;
                border: none;
                color: white;
                margin-top: 20px;
            }
            .registration-form .reset-account{
                border-radius: 30px;
                padding: 10px 20px;
                font-size: 18px;
                font-weight: bold;
                background-color: red;
                border: none;
                color: white;
                margin-top: 20px;
            }

            .registration-form .social-media{
                max-width: 600px;
                background-color: #fff;
                margin: auto;
                padding: 35px 0;
                text-align: center;
                border-bottom-left-radius: 30px;
                border-bottom-right-radius: 30px;
                color: #9fadca;
                border-top: 1px solid #dee9ff;
                box-shadow: 0px 2px 10px rgba(0, 0, 0, 0.075);
            }

            .registration-form .social-icons{
                margin-top: 30px;
                margin-bottom: 16px;
            }

            .registration-form .social-icons a{
                font-size: 23px;
                margin: 0 3px;
                color: #5691ff;
                border: 1px solid;
                border-radius: 50%;
                width: 45px;
                display: inline-block;
                height: 45px;
                text-align: center;
                background-color: #fff;
                line-height: 45px;
            }

            .registration-form .social-icons a:hover{
                text-decoration: none;
                opacity: 0.6;
            }

            @media (max-width: 576px) {
                .registration-form form{
                    padding: 50px 20px;
                }

                .registration-form .form-icon{
                    width: 70px;
                    height: 70px;
                    font-size: 30px;
                    line-height: 70px;
                }
            }
        </style>
        <script>
            $(document).ready(function () {
                $('#birth-date').mask('00/00/0000');
                $('#phone-number').mask('0000-0000');
            })
        </script>
        <c:if test="${empty sessionScope.USER or sessionScope.USER.role.name ne 'admin'}">
            <c:redirect url="login.jsp"/>
        </c:if>


        <div class="registration-form">
            <form action="insert" method="POST">
                <div class="form-icon">
                    <span><i class="icon icon-user"></i></span>
                </div>
                <c:if test="${not empty requestScope.MSG_ERROR}">
                    <font color="red">
                    ${requestScope.MSG_ERROR}
                    <p></p>
                    </font>
                    
                </c:if>

                <c:if test="${not empty requestScope.MSG_SUCCESS}">
                    <font color="green">
                    ${requestScope.MSG_SUCCESS}
                    <p></p>
                    </font>
                    
                </c:if>
                <div class="form-group">
                    <input type="text" name="txtId" class="form-control item" placeholder="Book ID">
                </div>
                <div class="form-group">
                    <input type="text" name="txtTitle" class="form-control item" placeholder="Title">
                </div>
                <div class="form-group">
                    <input type="text" name="txtImage" class="form-control item" placeholder="Image">
                </div>
                <div class="form-group">
                    <input type="text-area" name="txtDescribe" class="form-control item" placeholder="Describe">
                </div>
                <div class="form-group">
                    <input type="number" name="txtPrice" class="form-control item" placeholder="Price">
                </div>
                <div class="form-group">
                    <input type="text" name="txtAuthor" class="form-control item" placeholder="Author">
                </div>
                <div class="form-group">
                    <input type="number" name="txtQuantity" class="form-control item" placeholder="Quantity">
                </div>

                <div class="form-group">
                    <select class="form-select" aria-label="Default select example" name="categorys" style="width: 100%">
                        <c:forEach var="cateDto" items="${requestScope.CATE_LIST}">
                            <option value="${cateDto.id}">${cateDto.name}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <button type="submit" class="btn btn-block create-account">Insert Book</button>

                </div>
                <div class="form-group">
                    <button type="reset" class="btn btn-block reset-account">Reset</button>
                </div>
                <a href="search" style="text-decoration : none">Back to home</a>
            </form>


        </div>
        <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.15/jquery.mask.min.js"></script>
        <script src="assets/js/script.js"></script>



    </body>
</html>
