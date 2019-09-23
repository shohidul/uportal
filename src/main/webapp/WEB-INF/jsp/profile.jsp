<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en" >
<head>
    <meta charset="UTF-8">
    <title>uPortal</title>
    <link rel="stylesheet" href="/vendors/bootstrap-4.3.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="/assets/css/style.css">
</head>
<body>
<!-- partial:index.partial.html -->
<nav class="navbar navbar-toggleable-md navbar-light bg-light border-bottom">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">
            <img src="/assets/img/uportal_logo.png" width = "150" alt="">
        </a>

        <div class="dropdown">
            <button class="btn btn-link dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                ${user.email}
            </button>
            <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                <a class="dropdown-item" href="/change-password">Change Password</a>
                <a class="dropdown-item" href="/logout">Logout</a>
            </div>
        </div>
    </div>
</nav>
<div class="container-fluid">
    <div class="row">
        <div class="col-sm-4 col-md-4 col-lg-2 col-xl-2 border-right p-0">
            <nav class="nav flex-column">
                <a class="nav-link active border text-center" href="/profile">Profile Page</a>
                <a class="nav-link border text-center" href="/change-password">Change Password</a>
            </nav>
        </div>
        <div class="col py-2 p-0 vh-100">
            <div class="border-bottom h-75px">
                <h2 class="m-auto">User Profile</h2>
            </div>
            <div class="u-body-content p-5">
                <form>
                    <div class="form-group row">
                        <label class="col-sm-4 col-form-label">First Name</label>
                        <div class="col-sm-8">
                            <input type="text" readonly class="form-control-plaintext" value="${user.firstName}">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-4 col-form-label">Last Name</label>
                        <div class="col-sm-8">
                            <input type="text" readonly class="form-control-plaintext" value="${user.lastName}">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-4 col-form-label">Address</label>
                        <div class="col-sm-8">
                            <input type="text" readonly class="form-control-plaintext" value="${user.address}">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-4 col-form-label">Phone</label>
                        <div class="col-sm-8">
                            <input type="text" readonly class="form-control-plaintext" value="${user.phone}">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-4 col-form-label">Email</label>
                        <div class="col-sm-8">
                            <input type="text" readonly class="form-control-plaintext" value="${user.email}">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-4 col-form-label">Birthdate</label>
                        <div class="col-sm-8">
                            <fmt:formatDate value="${user.birthDate}" pattern="yyyy-MM-dd" var="bdate"/>
                            <input type="text" readonly class="form-control-plaintext" value="${bdate}">
                        </div>
                    </div>

                </form>
            </div>

        </div>
    </div>
</div>
<!-- partial -->
<style>
    html, body {
        height:100%;
    }
    .h-75px{
        height: 75px;
        display:flex;
        align-items:center;
    }
    .u-body-content form{
        max-width: 500px;
        margin: 50px auto;
    }
</style>
<script src='/vendors/jquery-3.4.1.min.js'></script>
<script src='/vendors/bootstrap-4.3.1/js/bootstrap.min.js'></script>
<script  src="/assets/js/script.js"></script>
<script>


</script>
</body>
</html>