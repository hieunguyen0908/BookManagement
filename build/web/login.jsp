<%-- 
    Document   : login
    Created on : 18 thg 4, 2021, 12:26:27
    Author     : PC
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="google-signin-scope" content="profile email">
        <meta name="google-signin-client_id" content="140924803404-oup5d41ub6i3gteb8ihreh5d591tce7b.apps.googleusercontent.com">

        
        <link href='https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css' rel='stylesheet'>
        <link href='https://use.fontawesome.com/releases/v5.8.1/css/all.css' rel='stylesheet'>
        <script type='text/javascript' src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">
        <link href='https://fonts.googleapis.com/css?family=Lato|Roboto:400,900' rel='stylesheet' type='text/css'>
        <style>
            body {
                margin: 0;
                padding: 0;
                font-family: sans-serif;
                background: linear-gradient(to right, #b92b27, #1565c0)
            }

            .card {
                margin-bottom: 20px;
                border: none
            }

            .box {
                width: 500px;
                padding: 40px;
                position: absolute;
                top: 50%;
                left: 50%;
                background: #191919;
                ;
                text-align: center;
                transition: 0.25s;
                margin-top: 100px
            }

            .box input[type="text"],
            .box input[type="password"] {
                border: 0;
                background: none;
                display: block;
                margin: 20px auto;
                text-align: center;
                border: 2px solid #3498db;
                padding: 10px 10px;
                width: 250px;
                outline: none;
                color: white;
                border-radius: 24px;
                transition: 0.25s
            }

            .box h1 {
                color: white;
                text-transform: uppercase;
                font-weight: 500
            }

            .box input[type="text"]:focus,
            .box input[type="password"]:focus {
                width: 300px;
                border-color: #2ecc71
            }

            .box input[type="submit"] {
                border: 0;
                background: none;
                display: block;
                margin: 20px auto;
                text-align: center;
                border: 2px solid #2ecc71;
                padding: 14px 40px;
                outline: none;
                color: white;
                border-radius: 24px;
                transition: 0.25s;
                cursor: pointer
            }

            .box input[type="reset"] {
                border: 0;
                background: none;
                display: block;
                margin: 20px auto;
                text-align: center;
                border: 2px solid #eb1c1c;
                padding: 14px 40px;
                outline: none;
                color: white;
                border-radius: 24px;
                transition: 0.25s;
                cursor: pointer
            }

            .box input[type="submit"]:hover {
                background: #2ecc71
            }
            .box input[type="reset"]:hover {
                background: #2ecc71
            }

            .forgot {
                text-decoration: underline
            }

            ul.social-network {
                list-style: none;
                display: inline;
                margin-left: 0 !important;
                padding: 0
            }

            ul.social-network li {
                display: inline;
                margin: 0 5px
            }

            .social-network a.icoFacebook:hover {
                background-color: #3B5998
            }

            .social-network a.icoTwitter:hover {
                background-color: #33ccff
            }

            .social-network a.icoGoogle:hover {
                background-color: #BD3518
            }

            .social-network a.icoFacebook:hover i,
            .social-network a.icoTwitter:hover i,
            .social-network a.icoGoogle:hover i {
                color: #fff
            }

            a.socialIcon:hover,
            .socialHoverClass {
                color: #44BCDD
            }

            .social-circle li a {
                display: inline-block;
                position: relative;
                margin: 0 auto 0 auto;
                border-radius: 50%;
                text-align: center;
                width: 50px;
                height: 50px;
                font-size: 20px
            }

            .social-circle li i {
                margin: 0;
                line-height: 50px;
                text-align: center
            }

            .social-circle li a:hover i,
            .triggeredHover {
                transform: rotate(360deg);
                transition: all 0.2s
            }

            .social-circle i {
                color: #fff;
                transition: all 0.8s;
                transition: all 0.8s
            }




            .btn {
                margin-top: calc(5px + 10px);
                position: relative;
                display: inline-block;
                width: 277px;
                height: 50px;
                font-size: 1em;
                font-weight: bold;
                line-height: 50px;
                text-align: center;
                text-transform: uppercase;
                background-color: transparent;
                cursor: pointer;
                text-decoration:none;
                font-family: 'Roboto', sans-serif;
                font-weight:900;
                font-size:17px;
                letter-spacing: 0.045em;
            }

            .btn svg {
                position: absolute;
                top: 0;
                left: 0;
            }

            .btn svg rect {
                stroke: #EC0033;
                stroke-width: 4;
                stroke-dasharray: 353, 0;
                stroke-dashoffset: 0;
                -webkit-transition: all 600ms ease;
                transition: all 600ms ease;
            }

            .btn span{
                background: rgb(255,130,130);
                background: -moz-linear-gradient(left,  rgba(255,130,130,1) 0%, rgba(225,120,237,1) 100%);
                background: -webkit-linear-gradient(left,  rgba(255,130,130,1) 0%,rgba(225,120,237,1) 100%);
                background: linear-gradient(to right,  rgba(255,130,130,1) 0%,rgba(225,120,237,1) 100%);
                filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#ff8282', endColorstr='#e178ed',GradientType=1 );

                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
            }

            .btn:hover svg rect {
                stroke-width: 4;
                stroke-dasharray: 196, 543;
                stroke-dashoffset: 437;
            }

        </style>
    </head>
    <body>
        <c:if test="${not empty MSG_ERROR}">

        </c:if>

        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <div class="card">
                        <form action="login" method="POST" class="box">
                            <h1>Login</h1>

                            <p class="text-muted"> Please enter your username and password!</p> 

                            <input type="text" name="txtUsername" placeholder="Username" value=""> 
                            <input type="password" name="txtPassword" placeholder="Password"  value="">
                            <c:if test="${not empty MSG_ERROR}">
                                <font color="red">${MSG_ERROR}</font>
                                <br/>
                            </c:if>
                            <a class="forgot text-muted" href="#">Forgot password?</a> 
                            <input type="submit" name="" value="Login">
                            <input type="reset" name="" value="Reset"/>

                            <div class="col-md-12">
                                <ul class="social-network social-circle">
                                    <li><a href="#" class="icoFacebook" title="Facebook"><i class="fab fa-facebook-f"></i></a></li>
                                    <li><a href="#" class="icoTwitter" title="Twitter"><i class="fab fa-twitter"></i></a></li>
                                    <li><a href="#" class="icoGoogle" title="Google +"><i class="fab fa-google-plus"></i></a></li>
                                </ul>
                            </div>
                            <a href="search" class="btn" style="text-decoration : none;" onclick="history.back(-1)">
                                <svg width="277" height="60">
                                <defs>
                                <linearGradient id="grad1">
                                <stop offset="0%" stop-color="#FF8282"/>
                                <stop offset="100%" stop-color="#E178ED" />
                                </linearGradient>
                                </defs>
                                <rect x="5" y="5" rx="25" fill="none" stroke="url(#grad1)" width="266" height="50"></rect>
                                </svg>
                                <span>Back to home</span>
                            </a>
                            <br/>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <script type='text/javascript' src='https://stackpath.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.bundle.min.js'></script>
        <script type='text/javascript'></script>



    </body>
</html>
