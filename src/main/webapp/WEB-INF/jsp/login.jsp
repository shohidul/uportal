<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>

<!DOCTYPE html>
<html lang="en" >
<head>
    <%@taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
    <sec:authorize access="hasAnyAuthority('ADMIN')">
        <% response.sendRedirect("/admin"); %>
    </sec:authorize>
    <sec:authorize access="hasAnyAuthority('USER')">
        <% response.sendRedirect("/profile"); %>
    </sec:authorize>
    <meta charset="UTF-8">
    <title>uPortal</title>
    <link rel="stylesheet" href="/vendors/bootstrap-4.3.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="/assets/css/style.css">
</head>
<body>
<!-- partial:index.partial.html -->
<div class="container">
    <div class="login-page">
        <img class="w-50 d-block" src="/assets/img/uportal_logo.png" alt="">
        <h5 class="form-title text-center">Login Panel</h5>
        <form class="login-form card" action="login" method='POST'>
            <div class="error">${SPRING_SECURITY_LAST_EXCEPTION.message}</div>
                <div class="form-group">
                    <label for="username" class="text-center d-block"> Email Address</label>
                    <input class="form-control" type="text" placeholder="" id="username" name='username'/>
                </div>
                <div class="form-group">
                    <label for="password" class="text-center d-block"> Password</label>
                    <input class="form-control" type="password" placeholder="" id="password" name='password'/>
                </div>

            <div class="login-btns">
                <button class="btn btn-primary" name="submit" type="submit">Login</button>
                <button class="btn btn-light u-clr-btn" type="reset">Clear</button>
            </div>

            <p class="message">Are you new here? <a href="/registration" class="mnemonic-underline">Register Now</a></p>
        </form>
    </div>
</div>
<!-- partial -->
<style>
    .error {
        color: #ff0000;
    }
    .login-page{
        max-width: 450px;
        margin: auto;
    }
    .login-page > *{
        margin: 20px auto;
    }
    .login-form{
        padding: 20px;
        text-align: center;
    }
    .login-btns{
        display: flex;
        margin: 35px auto 20px auto;
        width: 80%;
    }
    .login-btns > *{
        margin: 0 auto;
        width: 30%;
    }
    html, body {
        height:100%;
    }
    body{
        display:flex;
        align-items:center;
    }
</style>
<script src='/vendors/jquery-3.4.1.min.js'></script>
<script src='/vendors/bootstrap-4.3.1/js/bootstrap.min.js'></script>
<script  src="/assets/js/script.js"></script>
<script>


</script>
</body>
</html>