<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false"%>
<%@taglib uri = "http://www.springframework.org/tags/form" prefix = "form"%>

<!DOCTYPE html>
<html lang="en" >
<head>
    <meta charset="UTF-8">
    <title>uPortal</title>

    <link rel="stylesheet" href="/vendors/jquery-ui-1.12.1/jquery-ui.min.css">
    <link rel="stylesheet" href="/vendors/bootstrap-4.3.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="/assets/css/style.css">
</head>
<body>
<!-- partial:index.partial.html -->
<div class="container">
    <div class="register-page">
        <img class="w-50 d-block" src="/assets/img/uportal_logo.png" alt="">
        <h5 class="form-title text-center">Registration Panel</h5>
        <form:form class="register-form card" action="registeruser" method='POST' modelAttribute="userFormData">
            <%--<form:errors path = "*" cssClass = "errorblock" element = "div" />--%>
            <%--${SPRING_SECURITY_LAST_EXCEPTION.message}--%>
                <div class="form-group row">
                    <label for="firstName" class="col-sm-4 col-form-label"> First Name </label>
                    <div class="col-sm-8">
                        <form:errors path = "firstName" cssClass = "error" />
                        <input class="form-control" type="text" placeholder="" id="firstName" name='firstName'/>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="lastName" class="col-sm-4 col-form-label">Last Name </label>
                    <div class="col-sm-8">
                        <form:errors path = "lastName" cssClass = "error" />
                        <input class="form-control" type="text" placeholder="" id="lastName" name='lastName'/>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="address" class="col-sm-4 col-form-label"> Address </label>
                    <div class="col-sm-8">
                        <form:errors path = "address" cssClass = "error" />
                        <input class="form-control" type="text" placeholder="" id="address" name='address'/>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="phone" class="col-sm-4 col-form-label"> Phone </label>
                    <div class="col-sm-8">
                        <form:errors path = "phone" cssClass = "error" />
                        <input class="form-control" type="text" placeholder="" id="phone" name='phone'/>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="birthDate" class="col-sm-4 col-form-label">Birth Date</label>
                    <div class="col-sm-8">
                        <form:errors path = "birthDate" cssClass = "error" />
                        <input class="form-control" type="text" placeholder="" id="birthDate" name='birthDate'>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="username" class="col-sm-4 col-form-label"> Email Address</label>
                    <div class="col-sm-8">
                        <form:errors path = "email" cssClass = "error"/>
                        <div id="emailError"></div>
                        <input class="form-control" type="email" placeholder="" id="username" name='email'/>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="password" class="col-sm-4 col-form-label"> Password </label>
                    <div class="col-sm-8">
                        <form:errors path = "password" cssClass = "error" />
                        <input class="form-control" type="password" placeholder="" id="password" name='password'/>
                    </div>
                </div>

            <div class="register-btns">
                <button class="btn btn-primary" name="submit" type="submit" id="register-btn">Register</button>
                <a class="btn btn-light u-clr-btn" href="/login">Cancel</a>
            </div>

            <%--<p class="message">Are you new here? <a href="#" class="mnemonic-underline">Register Now</a></p>--%>
        </form:form>
    </div>
</div>
<!-- partial -->
<style>
    .error {
        color: #ff0000;
    }

    .errorblock {
        color: #000;
        background-color: #ffEEEE;
        border: 3px solid #ff0000;
        padding: 8px;
        margin: 16px;
    }
    .register-page{
        max-width: 450px;
        margin: auto;
    }
    .register-page > *{
        margin: 20px auto;
    }
    .register-form{
        padding: 20px;
        /*text-align: center;*/
    }
    .register-btns{
        display: flex;
        margin: 35px auto 20px auto;
        width: 80%;
    }
    .register-btns > *{
        margin: 0 auto;
        width: 30%;
    }
    /*html, body {*/
        /*height:100%;*/
    /*}*/
    /*body{*/
        /*display:flex;*/
        /*align-items:center;*/
    /*}*/
</style>
<script src='/vendors/jquery-3.4.1.min.js'></script>
<script src='/vendors/jquery-ui-1.12.1/jquery-ui.min.js'></script>
<script src='/vendors/bootstrap-4.3.1/js/bootstrap.min.js'></script>
<script src="/assets/js/script.js"></script>
<script>
    $(document).ready(function() {
        $("#username").on("blur", function(e) {
            $('#emailError').hide();
            if ($('#username').val() == null || $('#username').val() == "") {
                $('#emailError').show();
                $("#emailError").html("Username is required field.").css("color", "red");
            } else {
                $.ajax({
                    type: "POST",
                    url: "/checkemail",
                    data: { email: $("#username").val() }, // parameters
                    success :
                        function(response) {

                            if(response == true){
                                $('#emailError').show();
                                $("#emailError").html("Email already exist!").css("color", "red");
                                $("#register-btn").attr("disabled", true);
                            }else {
                                $('#emailError').hide();
                                $("#register-btn").attr("disabled", false);
                            }

                        }
                    ,
                    error: function(jqXHR, textStatus, errorThrown) {
                        alert(textStatus + " " + errorThrown);
                    }
                })
            }

        });
        $( "#birthDate" ).datepicker();
    });

</script>
</body>
</html>