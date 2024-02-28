<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <!-- Required meta tags -->
    <title>Login | Yeemak HRMS</title>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" type="image/png" href="Yeemakfav.png" />

    <!--plugins-->
    <link href="assets/plugins/perfect-scrollbar/css/perfect-scrollbar.css" rel="stylesheet" />
    <!--plugins-->
    <link href="assets/plugins/perfect-scrollbar/css/perfect-scrollbar.css" rel="stylesheet" />
    <link href="assets/plugins/simplebar/css/simplebar.css" rel="stylesheet" />
    <link href="assets/plugins/metismenu/css/metisMenu.min.css" rel="stylesheet" />
    <link href="assets/plugins/datatable/css/dataTables.bootstrap5.min.css" rel="stylesheet" />


    <!-- CSS Files -->
    <link href="assets/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/css/bootstrap-extended.css" rel="stylesheet">
    <link href="assets/css/style.css" rel="stylesheet">
    <link href="assets/css/icons.css" rel="stylesheet">



    <!--PNotify-->
    <link rel="stylesheet" type="text/css" href="files/bower_components/pnotify/dist/pnotify.css" />
    <link rel="stylesheet" type="text/css" href="files/bower_components/pnotify/dist/pnotify.brighttheme.css" />
    <link rel="stylesheet" type="text/css" href="files/bower_components/pnotify/dist/pnotify.buttons.css" />
    <link rel="stylesheet" type="text/css" href="files/bower_components/pnotify/dist/pnotify.history.css" />
    <link rel="stylesheet" type="text/css" href="files/bower_components/pnotify/dist/pnotify.mobile.css" />
    <link rel="stylesheet" type="text/css" href="files/assets/pages/pnotify/notify.css" />

    <link href="files/assets/css/sweetalert.css" rel="stylesheet" />

    <script src="assets/js/jquery-3.6.0.min.js"></script>
    <link href="assets/css/calender.css" rel="stylesheet" />
    <script src="assets/js/calender.js"></script>
    <!-- CSS Files -->
    <link href="assets/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/css/bootstrap-extended.css" rel="stylesheet">
    <link href="assets/css/style.css" rel="stylesheet">
    <link href="assets/css/icons.css" rel="stylesheet">
    <script src="assets/js/jquery.min.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>


    <script type="text/javascript">
        $(document).ready(function () {
            var objUrlParams = new URLSearchParams(window.location.search);
            var flagId = objUrlParams.get('flagId');
            if (flagId == 2) {
                new PNotify({
                    title: 'Updated',
                    text: 'Password Updated Successfully...',
                    icon: 'icofont icofont-info-circle',
                    type: 'success'
                });
            }
            if (flagId == 1) {
                new PNotify({
                    title: 'Password Changed',
                    text: 'Password Changed Successfully...',
                    icon: 'icofont icofont-info-circle',
                    type: 'success'
                });
            }

            $("#Text1").keyup(function () {
                var txtUN = $(this).val();
                if (txtUN != '') {
                    $("#error").text("");

                }

            });

            $("#password1").keyup(function () {
                var txtPwd = $(this).val();
                if (txtPwd != '') {
                    $("#error1").text("");

                }

            });

            $('#password1').on("cut copy paste", function (e) {
                e.preventDefault();
            });

            $('#password1').bind("contextmenu", function (e) {
                return false;
            });

            $('.toggle-password').click(function () {
                $(this).toggleClass("fa-eye fa-eye-slash");
                // Find the password input field
                var passwordField = $('#password1');

                // Toggle the password visibility
                if (passwordField.attr('type') === 'password') {
                    passwordField.attr('type', 'text');
                } else {
                    passwordField.attr('type', 'password');
                }
            });

        });

        function chkFrDates() {
            var isV = false;
            var fD = $('#Text1');
            var eD = $('#password1');
            if (fD.val() == "" && eD.val() == "") {
                $('#error')[0].innerText = "Enter the  Email Id";
                $('#error2')[0].innerText = "";
            }
            else if (fD.val() == "" && eD.val() != "") {
                $('#error')[0].innerText = "Enter the  Email Id";
                $('#error2')[0].innerText = "";
            }
            else
                $('#error')[0].innerText = "";
            if (fD.val() != "" && eD.val() == "") {
                $('#error1')[0].innerText = "Enter the Password";
                $('#error2')[0].innerText = "";
            }
            else
                $('#error1')[0].innerText = "";
            if (fD.val() != "" && eD.val() != "")
                isV = true;
            if (isV)

                BindAccessTimings(fD.val(), eD.val());

            return isV;
        }

        function sendRequest(event) {
            event.preventDefault();
            var isValid = true;
            isValid = isValid && hasValue("#txtForgotEmail", "#spanForgotEmail", "Enter the Email ID");
            isValid = isValid && ValidateEmail();
            if (isValid) {
                var lsupObj = new ForgetPassword();
                lsupObj.EmailId = $('#txtForgotEmail').val();
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Login.aspx/SendRequest",
                    data: "{SupportObj : " + ko.toJSON(lsupObj) + "}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d >= 0) {
                            var inserted = data.d;
                            if (inserted != null) {
                                if (inserted == 1) {

                                    new PNotify({
                                        title: 'Notification',
                                        text: 'Please check your Email',
                                        icon: 'icofont icofont-info-circle',
                                        type: 'success'
                                    });
                                    $("#Forgetpassword").modal("hide");

                                }
                                if (inserted == 0) {
                                    $('#spanForgotEmail')[0].innerText = "You are not an authorized User";
                                }
                            }
                            else
                                alert('failed to update');
                        }
                    },

                    error: function (response) {
                        alert(response.responseText);
                    },
                    failure: function (response) {
                        alert(response.responseText);
                    }
                });
            }
            return isValid;
        }

        function hasValue(ctrlId, errDisplayCtrlId, errMsg) {
            var hasIt = true;
            if ($(ctrlId).val() == "") {
                hasIt = false;
                $(errDisplayCtrlId).text(errMsg);
                //$(ctrlId).focus();
            }
            else {
                $(errDisplayCtrlId).text('');

            }

            return hasIt;
        }

        function ValidateEmail() {
            var EmailId = document.getElementById("txtForgotEmail").value;
            var spanForgot = document.getElementById("spanForgotEmail");
            spanForgot.innerHTML = "";
            var expr = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
            if (!expr.test(EmailId)) {
                spanForgot.innerHTML = "Invalid Email Address"
                return false;
            }
            return true;

        }

        function BindAccessTimings(username, password) {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Login.aspx/BindAccessTimeValue",
                data: "{'username':'" + username + "','password':'" + password + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d.url != null) {

                        window.location.href = data.d.url;
                    }
                    else {

                        $('#error2')[0].innerText = "Enter the Correct Email ID and Password";

                    }
                },

                error: function (response) {
                    alert(response.responseText);
                },
                failure: function (response) {
                    alert(response.responseText);
                }
            });
        }

        function Forgetpassword() {
            $("#Forgetpassword").modal("show");
            $('#txtForgotEmail').val('');
            $('#spanForgotEmail').text('');

        }
        function modalCancel() {
            $("#Forgetpassword").modal("hide");
            $('#txtForgotEmail').val('');
            $('#spanForgotEmail').text('');
        }

    </script>
    <script>
        function handleButtonClick() {
            chkFrDates();
        }

        document.addEventListener('DOMContentLoaded', function () {
            document.addEventListener('keydown', function (event) {
                if (event.key === 'Enter') {
                    event.preventDefault();
                    handleButtonClick();
                }
            });

            document.querySelector('.btn-primary').addEventListener('click', handleButtonClick);
        });
    </script>
    <style>
        .card {
            border: 0;
            background: #ffffffad;
            margin-bottom: 1.5rem;
            box-shadow: 0 0.125rem 1.25rem rgba(220, 220, 220, 1.075) !important;
        }

        .card-body {
            flex: 1 1 auto;
            padding: 3rem 3rem !important;
        }

        .login-cover-wrapper {
            width: 24rem;
            height: 46rem;
            margin: auto;
            display: flex;
            padding-top: 150px;
            align-items: center;
            justify-content: center;
        }
    </style>
</head>
<body style="background-image: url(bg.jpg); background-repeat: no-repeat; background-size: cover;">

    <!--start wrapper-->
    <div class="wrapper">
        <div class="">
            <div class="row g-0 m-0">

                <div class="col-xl-6 col-lg-12">
                    <div class="login-cover-wrapper">
                        <div class="card shadow-none">
                            <div class="card-body">
                                <div class="text-center">
                                    <h4>Login</h4>

                                </div>
                                <form class="form-body row g-3">

                                    <div class="col-12">
                                        <label for="inputEmail" class="form-label">Email Id</label>
                                        <input type="email" class="form-control" id="Text1" name="Email" placeholder="Email Id" autocomplete="off"/>
                                        <span id="error" class="form-bar" style="color: red;"></span>
                                    </div>
                                    <div class="col-12">
                                        <label for="inputPassword" class="form-label">Password</label>
                                        <input type="password" id="password1" name="Password" class="form-control" placeholder="Password" autocomplete="off"/>
                                        <span id="error1" class="form-bar" style="color: red;"></span>
                                    </div>
                                    <span id="error2" class="form-bar" style="color: red;"></span>
                                    <div class="col-12 col-lg-12">
                                        <p onclick="Forgetpassword()"><a href="#">Forgot Password ?</a></p>
                                    </div>
                                    <div class="col-12 col-lg-12">
                                        <div class="d-grid">
                                            <form onsubmit="return chkFrDates();">
                                                <button type="submit" class="btn btn-primary" value="signin">Login</button>
                                            </form>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-xl-6 col-lg-12"></div>

            </div>
            <!--end row-->
        </div>
    </div>

    <div class="modal fade" id="Forgetpassword" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content" style="width: 85%;">
                <div class="modal-header">
                    <h5 class="modal-title" style="width: 100%; text-align: center; padding-left: 60px; font-size: 14px;">Forgot Password</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" onclick="modalCancel()"></button>
                </div>
                <div class="modal-body">
                    <div class="container p-4">
                        <div class="form-group row" style="padding-bottom: 15px;">
                            <div class="col-lg-12">
                                <label for="txtForgotEmail" style="color: #000 !important; line-height: 35px;">
                                    Email Id <sup><i class="fa fa-asterisk" aria-hidden="true" style="color: red; font-size: 10px;"></i></sup>
                                </label>
                                <input type="email" class="form-control" style="border-radius: 0px; border: 1px solid #000;" id="txtForgotEmail" placeholder="Email Id" autocomplete="off" maxlength="50" onkeyup="ValidateEmail()" <%--oninput="RemoveVal(this)" --%>/>
                            </div>
                            <span id="spanForgotEmail" style="color: red; font-size: 15px; margin-left: 20px;"></span>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-success" id="btnSubmit" onclick="sendRequest(event)">Submit</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>

            </div>
        </div>
    </div>





    <!--Knockout Script-->
    <script src="js/knockout-3.3.0.js" type="text/javascript"></script>
    <script src="js/knockout.mapping-latest.js" type="text/javascript"></script>
    <script src="js/knockout.validation.js" type="text/javascript"></script>
    <script src="assets/js/jquery-3.6.0.min.js"></script>


    <!-- pnotify js -->
<script type="text/javascript" src="files/bower_components/pnotify/dist/pnotify.js"></script>
<script type="text/javascript" src="files/bower_components/pnotify/dist/pnotify.desktop.js"></script>
<script type="text/javascript" src="files/bower_components/pnotify/dist/pnotify.buttons.js"></script>
<script type="text/javascript" src="files/bower_components/pnotify/dist/pnotify.confirm.js"></script>
<script type="text/javascript" src="files/bower_components/pnotify/dist/pnotify.callbacks.js"></script>
<script type="text/javascript" src="files/bower_components/pnotify/dist/pnotify.animate.js"></script>
<script type="text/javascript" src="files/bower_components/pnotify/dist/pnotify.history.js"></script>
<script type="text/javascript" src="files/bower_components/pnotify/dist/pnotify.mobile.js"></script>
<script type="text/javascript" src="files/bower_components/pnotify/dist/pnotify.nonblock.js"></script>
<script type="text/javascript" src="files/assets/pages/pnotify/notify.js"></script>
<script src="files/bower_components/jquery.steps/build/jquery.steps.js"></script>

<script src="css1/dist/js/sweetalert-data.js"></script>
<script src="files/assets/js/sweetalert.js"></script>

    <script src="assets/js/jquery.min.js"></script>

    <script type="text/javascript">
        var ForgetPassword = function () {
            var self = this;
            self.EmailId = ko.observable('');

        };
    </script>

</body>

</html>
