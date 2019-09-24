<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en" >
<head>
    <meta charset="UTF-8">
    <title>uPortal</title>
    <link rel="stylesheet" href="/vendors/bootstrap-4.3.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="/vendors/datatable/datatables.min.css">
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
                <%--<a class="dropdown-item" href="/change-password">User List/a>--%>
                <a class="dropdown-item" href="/logout">Logout</a>
            </div>
        </div>
    </div>
</nav>
<div class="container-fluid">
    <div class="row">
        <div class="col-sm-4 col-md-4 col-lg-2 col-xl-2 border-right p-0">
            <nav class="nav flex-column">
                <a class="nav-link active border text-center" href="/admin">User List</a>
            </nav>
        </div>
        <div class="col py-2 p-0 vh-100">
            <div class="border-bottom h-60px">
                <h2 class="m-auto">User List</h2>
            </div>
            <div class="u-body-content p-5">

                <table id="userListTable" class="table-striped">
                    <thead>
                    <tr class="tr1">
                        <th>Name</th>
                        <th>Age</th>
                        <th>Email</th>
                        <th>Phone</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="u" items="${users}" varStatus="i">
                        <tr>
                            <td>${u.firstName}&nbsp;${u.lastName}</td>
                            <td>
                                <jsp:useBean id="now" class="java.util.Date" />
                                <fmt:parseNumber
                                        value="${(now.time - u.birthDate.time) / (1000*60*60*24*365) }"
                                        integerOnly="true" />
                            </td>
                            <td>${u.email}</td>
                            <td>${u.phone}</td>
                        </tr>
                    </c:forEach>
                    </tbody>


                </table>

            </div>

        </div>
    </div>
</div>
<!-- partial -->
<style>
    html, body {
        height:100%;
    }
    .h-60px{
        height: 60px;
        padding: 5px 0 5px 15px;
    }

    #userListTable {
        width: 100%;
    }
    #userListTable td{
        padding: 5px;
    }
</style>
<script src='/vendors/jquery-3.4.1.min.js'></script>
<script src='/vendors/datatable/datatables.min.js'></script>
<script src='/vendors/bootstrap-4.3.1/js/bootstrap.min.js'></script>
<script  src="/assets/js/script.js"></script>
<script>
    $(document).ready( function () {
        var table = $('#userListTable').DataTable({"bAutoWidth": false ,
            aoColumns : [
                { "sWidth": "35%"},
                { "sWidth": "15%"},
                { "sWidth": "35%"},
                { "sWidth": "15%"},
            ]
        });

        table
            .rows( function ( idx, data, node ) {
                return data[2] === "admin@localhost.local";
            } )
            .remove()
            .draw();
    } );


</script>
</body>
</html>