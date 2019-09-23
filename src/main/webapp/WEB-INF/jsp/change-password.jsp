<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false"%>
<%@taglib uri = "http://www.springframework.org/tags/form" prefix = "form"%>
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
                <h2 class="m-auto">Change Password</h2>
            </div>
            <div class="u-body-content p-5">
                <form>
                <%--<form:form action="updatepassword" method='POST' modelAttribute="passFormData">--%>
                    <%--<form:errors path = "*" cssClass = "errorblock" element = "div" />--%>
                    <div class="form-group row">
                        <label class="col-sm-4 col-form-label">Previous Password</label>
                        <div class="col-sm-8">
                                <%--<form:errors path = "password" cssClass = "error" />--%>
                            <%--<div id="passwordError"></div>--%>
                            <input type="password" class="form-control" placeholder="" id="password" name="password">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-4 col-form-label">New Password</label>
                        <div class="col-sm-8">
                            <%--<form:errors path = "newPassword" cssClass = "error" />--%>
                            <%--<div id="newPasswordError"></div>--%>
                            <input type="password" class="form-control" placeholder="" id="newPassword" name="newPassword">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-4 col-form-label">Confirm Password</label>
                        <div class="col-sm-8">
                            <%--<form:errors path = "confirmPassword" cssClass = "error" />--%>
                            <%--<div id="confirmPasswordError"></div>--%>
                            <input type="password" class="form-control" placeholder="" id="confirmPassword" name="confirmPassword">
                        </div>
                    </div>

                    <div class="login-btns">
                        <button class="btn btn-primary" name="button" type="button" id="submitBtn">Change Password</button>
                        <button class="btn btn-light u-clr-btn" type="reset" id="clrBtn">Clear</button>

                    </div>
                    <div class="text-center msg">
                    </div>
                </form>

            </div>

        </div>
    </div>
</div>
<!-- partial -->
<style>
    .error {
        color: #ff0000;
    }
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
    .login-btns{
        display: flex;
        margin: 35px auto 20px auto;
        width: 80%;
    }
    .login-btns > *{
        margin: 0 auto;
        /*width: 30%;*/
    }
</style>
<script src='/vendors/jquery-3.4.1.min.js'></script>
<script src='/vendors/bootstrap-4.3.1/js/bootstrap.min.js'></script>
<script  src="/assets/js/script.js"></script>
<script>
    $(document).ready(function() {

        $("#submitBtn").on("click", function(e) {
            $(".msg").hide();
            if ($("#password").val() == null || $('#password').val() == "" || $("#newPassword").val() == null || $('#newPassword').val() == "" ||
                $("#confirmPassword").val() == null || $('#confirmPassword').val() == "") {
                $('.msg').show();
                $('.msg').html("All fields is required.").css("color", "red");
            }else if ($('#password').val().length < 5 || $('#newPassword').val().length < 5 || $('#confirmPassword').val().length < 5){
                $('.msg').show();
                $('.msg').html("Your password must have at least 5 characters.").css("color", "red");
            } else if ($('#newPassword').val() != $('#confirmPassword').val()){
                $('.msg').show();
                $('.msg').html("New password does not match with confirm password!").css("color", "red");
            }
            else {
                $.ajax({
                    type: "POST",
                    url: "/updatepassword",
                    data: { password: $("#password").val(), newPassword: $("#newPassword").val() }, // parameters
                    success :
                        function(response) {

                            if(response == true){
                                $('.msg').show();
                                $(".msg").html("Password has changed successfully!").css("color", "green");
                                $("#clrBtn").trigger("click");
                            }else {
                                $('.msg').show();
                                $(".msg").html("Previous password does not match!").css("color", "red");
                            }

                        }
                    ,
                    error: function(jqXHR, textStatus, errorThrown) {
                        alert(textStatus + " " + errorThrown);
                    }
                })
            }

        });
    })

</script>
</body>
</html>