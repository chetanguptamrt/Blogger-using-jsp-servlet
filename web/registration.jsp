<%-- 
    Document   : registration
    Created on : 15-Jun-2021, 12:30:21 PM
    Author     : chetan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
        <title>Sign up | Blog</title>
        <link href="css/login.css" rel="stylesheet" type="text/css"/>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
    </head>
    <body>
        <nav class="navbar navbar-dark bg-dark">
            <h2 style="float: left;" class="text-light ">
                <a href="./index.jsp" class="top-nav-link">Blog</a>
            </h2>
            <div style="float: right;">
                <a class="btn btn-outline-light" href="./login.jsp">Login</a>
            </div>
        </nav>
        <div class="container-md mt-5 mb-5">
            <div class="row">
                <div class="col-12 text-center">
                    <h2 class="text-light">Sign up</h2>
                    <small id="status" style="display: none;" ></small>
                </div>
            </div>
            <div class="row mt-3">
                <div class="col-xl-6 offset-xl-3 col-lg-6 offset-lg-3 col-md-8 offset-md-2 col-sm-10 offset-sm-1 col-12 text-light">
                    <form id="otpForm">
                        <label for="email">Email Address</label>
                        <input id="email" maxlength="50" name="email" type="email" class="form-control" placeholder="chetan@gupta.com" required /> 
                        <div class="text-center mt-3">
                            <button id="bOTP" type="submit" class="btn btn-outline-primary">
                                Send OTP
                            </button> 
                        </div>
                    </form>
                    <form id="registerForm">
                        <input type="text" id='rEmail' name="rEmail" value="" hidden />
                        <label id="otp" class="mt-2">OTP</label>
                        <input type="number" class="form-control" id="otp" name="otp" placeholder="OTP" required />
                        <label id="name" class="mt-2">Name</label>
                        <input type="text" maxlength="30" class="form-control" id="name" name="name" placeholder="Chetan Gupta"/>
                        <label class="mt-2" for="password">Password</label>
                        <input type="password" class="form-control" minlength="6" id="password" name="password" placeholder="password" required />
                        <div class="text-center mt-3">
                            <button id="bSave" type="submit" class="btn btn-outline-success" disabled>
                                Save
                            </button> 
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <script src="js/registration.js" type="text/javascript"></script>
    </body>
</html>
