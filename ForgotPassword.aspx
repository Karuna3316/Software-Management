<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ForgotPassword.aspx.cs" Inherits="ForgotPassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Forgot Password</title>

    <link rel="stylesheet" type="text/css" href="files/bower_components/bootstrap/dist/css/bootstrap.min.css">

    <link rel="stylesheet" type="text/css" href="files/bower_components/pnotify/dist/pnotify.css" />
    <link rel="stylesheet" type="text/css" href="files/bower_components/pnotify/dist/pnotify.brighttheme.css" />
    <link rel="stylesheet" type="text/css" href="files/bower_components/pnotify/dist/pnotify.buttons.css" />
    <link rel="stylesheet" type="text/css" href="files/bower_components/pnotify/dist/pnotify.history.css" />
    <link rel="stylesheet" type="text/css" href="files/bower_components/pnotify/dist/pnotify.mobile.css" />
    <link rel="stylesheet" type="text/css" href="files/assets/pages/pnotify/notify.css" />
    <link href="files/assets/css/sweetalert.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">


    <!-- End fonts -->

    <!-- core:css -->
    <link rel="stylesheet" href="../assets/vendors/core/core.css" />
    <!-- endinject -->

    <!-- Plugin css for this page -->
    <link rel="stylesheet" href="../assets/vendors/flatpickr/flatpickr.min.css" />
    <!-- End plugin css for this page -->

    <!-- inject:css -->
    <link rel="stylesheet" href="../assets/fonts/feather-font/css/iconfont.css" />
    <link rel="stylesheet" href="../assets/vendors/flag-icon-css/css/flag-icon.min.css" />
    <!-- endinject -->

    <!-- Layout styles -->
    <link rel="stylesheet" href="../assets/css/demo1/style.css" />
    <link rel="stylesheet" href="../assets/css/demo1/external.css" />
    <!-- End layout styles -->

    <link rel="shortcut icon" href="../assets/images/favicon.png" />


    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>

    <style>
        .btn-warning:hover {
            background: #FF9800 !important;
            border: none !important;
            color: #fff !important;
        }

        .btn-danger:hover {
            background: #000 !important;
            border: none !important;
            color: #fff !important;
        }

        .btn-warning {
            color: #fff !important;
            border: none !important;
        }

        .btn-danger {
            color: #fff !important;
            border: none !important;
            background: #000 !important;
        }

        .btn:hover {
            color: #fff !important;
        }

        .select2-container--default .select2-selection--single .select2-selection__rendered {
            color: #444;
            border: 1px solid #000;
            border-radius: 3px;
        }

        .row-container {
            display: flex;
            justify-content: space-between;
        }

            .row-container span {
                margin-right: 10px;
            }

        .input-group {
            height: 37px;
            margin-right: 0px !important;
            padding: 0px;
        }

        .input-group-addon {
            color: #555353;
            padding: 6px;
            background-color: #ccc;
            border: 1px solid #000;
            border-radius: 4px;
            height: 35px;
        }
        .card-block {
            padding: 20px;
            box-shadow: 2px 2px 10px 2px rgba(206, 206, 206, 0.63);
            border: none;
        }
        .form-control:focus,
        .form-control:active {
            outline: none !important;
            box-shadow: none !important;
            border:1px solid #ccc !important;
        }
        .form-control {
            border:1px solid #000;
            
        }
        .form-group {
            padding-bottom:10px !important;
        }
        .input-group > :not(:first-child):not(.dropdown-menu):not(.tt-menu):not(.valid-tooltip):not(.valid-feedback):not(.invalid-tooltip):not(.invalid-feedback) {
            margin-left: 0px !important;
            border-top-left-radius: 0;
            border-bottom-left-radius: 0;
        }
    </style>

    <script>
        $(document).ready(function () {
            // Password toggle for the first div
            $('.toggle-password-first').click(function () {
                var passwordField = $('#txtPassword');
                var fieldType = passwordField.attr('type');
                passwordField.attr('type', fieldType === 'password' ? 'text' : 'password');
                $(this).toggleClass('fa-eye fa-eye-slash');
            });

            // Password toggle for the second div
            $('.toggle-password-second').click(function () {
                var confirmPasswordField = $('#txtConfirmPassword');
                var fieldType = confirmPasswordField.attr('type');
                confirmPasswordField.attr('type', fieldType === 'password' ? 'text' : 'password');
                $(this).toggleClass('fa-eye fa-eye-slash');
            });
       
            var objUrlParams = new URLSearchParams(window.location.search);
            var ToMailId = objUrlParams.get('ToMailId');

            $('#EmailId').prop('readonly', true);
            $('#txtPassword').prop('readonly', true);

            setTimeout(function () {
                $('#EmailId').prop('readonly', false);
                $('#txtPassword').prop('readonly', false);
            }, 1000);

            if (ToMailId != null) {
                var decodedData = atob(ToMailId);

                var byteArray = new Uint8Array(decodedData.length);
                for (var i = 0; i < decodedData.length; i++) {
                    byteArray[i] = decodedData.charCodeAt(i);
                }

                var decoder = new TextDecoder('utf-8');
                var result = decoder.decode(byteArray);

                $('#EmailId').val(result);
            } else {
                $('#EmailId').val('');
            }

            $(".toggle-password").click(function () {
                $(this).toggleClass("fa-eye fa-eye-slash");
                input = $(this).parent().find("input");
                if (input.attr("type") == "password") {
                    input.attr("type", "text");
                } else {
                    input.attr("type", "password");
                }
            });

            // Password input handling
            $('#txtPassword').on("cut copy paste", function (e) {
                e.preventDefault();
            });
            $('#txtConfirmPassword').on("cut copy paste", function (e) {
                e.preventDefault();
            });

            $('#txtPassword').bind("contextmenu", function (e) {
                return false;
            });

            $('#txtConfirmPassword').bind("contextmenu", function (e) {
                return false;
            });

            // Password strength validation
            var passwordField = $('#txtPassword');
            var passwordValidationMsg = $('#passwordValidationMsg');
            var passwordStrengthMsg = $('#passwordStrengthMsg');
            var confirmPasswordField = $('#txtConfirmPassword');

            confirmPasswordField.prop('disabled', true);

            passwordField.on('input', function () {
                var password = passwordField.val().trim();

                if (password.length === 0) {
                    passwordStrengthMsg.empty();
                } else {
                    passwordValidationMsg.empty();
                    validatePassword(password);
                }
            });

            $("#txtPassword").on("keyup", function () {
                $("#txtPassword").css({ "border-color": "#000", "box-shadow": "none" });
                $("#spanRetypePassword").text("");
                $("#spanRetypePassword1").text("");
                $("#txtConfirmPassword").prop('disabled', false);
                validatePasswordOnKeyup();
            });

            // Retype password handling
            $("#txtConfirmPassword").on("keyup", function () {
                $("#txtConfirmPassword").css({ "border-color": "#000", "box-shadow": "none" });
                $("#spanRetypePassword").text("");
                validateRetypePasswordOnKeyup();
            });
        });


        function validatePassword(password) {
            var passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@#$%^&*()!+=_\-])[A-Za-z\d@#$%^&*()!+=_\-]{8,}$/;
            var isValid = passwordRegex.test(password);
            var passwordStrengthMsg = $('#passwordStrengthMsg');
            if (isValid) {
                passwordStrengthMsg.text('Password strength: Strong').css('color', 'green');
            } else {
                passwordStrengthMsg.text('Password strength: Weak').css('color', 'red');
            }

            var txtPassword = $('#txtPassword').val();
            if (txtPassword == null || txtPassword.trim() === "") {
                passwordStrengthMsg.text('');
            }
            return isValid;
        }





        function validatePasswordOnKeyup() {
            var password = $("#txtPassword").val();
            var spanPassword = $("#spanPassword");
            var spanRetypePassword = $("#spanRetypePassword");
            var confirmPasswordField = $("#txtConfirmPassword");

            // Disable retype password by default
            confirmPasswordField.val("").prop('disabled', true);

            if (password.length === 0) {
                spanPassword.text("");
                $("#txtConfirmPassword").css({ "border-color": "#000", "box-shadow": "none" });
               /* hasText("#txtPassword");*/
                return;
            }

            spanPassword.text(password.length < 8 ? "Password must be at least 8 characters long" : "");

            if (!/[A-Z]/.test(password) || !/[a-z]/.test(password) || !/[^A-Za-z0-9]/.test(password) || !/\d/.test(password) || password.length < 8) {
                // Password does not meet the required criteria
                if (!/[A-Z]/.test(password)) {
                    spanPassword.append("<br>At least one uppercase letter");
                }
                if (!/[a-z]/.test(password)) {
                    spanPassword.append("<br>At least one lowercase letter");
                }
                if (!/[^A-Za-z0-9]/.test(password)) {
                    spanPassword.append("<br>At least one special character");
                }
                if (!/\d/.test(password)) {
                    spanPassword.append("<br>At least one digit");
                }
                return;
            }

            // Enable retype password when password meets the criteria
            spanRetypePassword.text("");
            confirmPasswordField.prop('disabled', false);
           
        }

        //function validateRetypePasswordOnKeyup() {
        //    debugger
        //    var password = $("#txtPassword").val();
        //    var confirmPassword = $("#txtConfirmPassword").val();
        //    var spanRetypePassword = $("#spanRetypePassword1");

        //    if (confirmPassword == "") {
        //        spanRetypePassword.text("");
        //        $("#spanRetypePassword").text("");
        //        return;
        //    }
        //    if (password !== confirmPassword) {
        //        spanRetypePassword.text("Retype Password not same as the Password");
        //        return false
        //    } else {
        //        spanRetypePassword.text("");
        //        return true
        //    }

        //}
       
        function sendRequest() {
            //console.log('sendRequest function called'); // Add this line for debugging
            var isValid = false;

            var txtPassword = $('#txtPassword').val();
            var txtConfirmPassword = $('#txtConfirmPassword').val();


            if (hasValue("#EmailId", "#spanForgotEmail", "Cannot Update without Email ID") &&
                hasValue("#txtPassword", "#spanPassword", "Enter the Password" ) && validatePassword(txtPassword) &&
                hasValue("#txtConfirmPassword", "#spanRetypePassword", "Enter the Retype Password") && (txtPassword == txtConfirmPassword) && validateRetypePasswordOnKeyup())
                isValid = true;
            {
                isValid = isValid && validatePassword(txtPassword);

                if (isValid) {
                    var lsupObj = new ResetPassword();
                    lsupObj.NewPassword = $('#txtConfirmPassword').val();
                    lsupObj.EmailId = $('#EmailId').val();
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "ForgotPassword.aspx/ResetPasswprd",
                        data: "{SupportObj : " + ko.toJSON(lsupObj) + "}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d >= 0) {
                                var inserted = data.d;
                                if (inserted != null) {
                                    location.href = "Login.aspx?flagId=" + data.d;
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
            }
            return isValid;
        }

        //function hasText(ctrlId) {

        //    var hasIt = true;
        //    if ($(ctrlId).val() == "") {
        //        hasIt = false;
        //        $(ctrlId).css({ "border-color": "red", "box-shadow": "0px 0px 3px 1px red" });
        //    }
        //    else {
        //        $(ctrlId).css({ "border-color": "#000", "box-shadow": "none" });

        //    }

        //    return hasIt;
        //}

        //function RemoveVal(ID) {
        //    $(ID).css({ "border-color": "#000", "box-shadow": "none" });
        //    $(ID).next('.select2-container').find('.select2-selection').css({ "border-color": "#000", "box-shadow": "none" });
        //}


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

        function BackToList() {
            window.location = 'Login.aspx';
        }


        function validateRetypePasswordOnKeyup() {
            debugger
            var password = $("#txtPassword").val();
            var confirmPassword = $("#txtConfirmPassword").val();
            var spanRetypePassword = $("#spanRetypePassword1");

            if (confirmPassword == "") {
                spanRetypePassword.text("");
                $("#spanRetypePassword").text("");
                return;
            }
            if (password !== confirmPassword) {
                spanRetypePassword.text("Retype Password not same as the Password");
                return false
            } else {
                spanRetypePassword.text("");
                return true
            }

        }





    </script>

</head>
<body>
    <form id="form1" runat="server">
        <div class="pcoded-content" style="width:99%;">
            <div class="pcoded-inner-content">
                <div class="main-body">
                    <div class="page-wrapper">
                        <div class="page-body" style="padding-top:100px;">
                            <div class="row">
                                <div class="col-sm-3"></div>
                                <div class="col-sm-6">
                                    <div class="card">
                                        <div class="card-block">
                                            <h3 class="h-25">Forgot Password</h3>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-3"></div>
                            </div>
                        </div>

                        <div class="page-body">
                            <div class="row">
                                <div class="col-sm-3"></div>
                                <div class="col-sm-6">
                                    <div class="card">
                                        <div class="card-block">
                                            <div class="form-group row">
                                                <div class="col-sm-3">
                                                    <label>Email Id</label>
                                                </div>
                                                <div class="col-sm-6">
                                                    <input type="text" id="EmailId" class="form-control" style="padding:6px;" disabled />
                                                </div>
                                            </div>
                                            <div class="form-group row" >
                                                <div class="col-sm-3">
                                                    <label for="txtPassword">Password</label>
                                                </div>
                                                <div class="col-sm-6">

                                                    <div class="input-group">
                                                        <input type="password" id="txtPassword" class="form-control" placeholder="Password" maxlength="16" autocomplete="off" />
                                                        <div class="input-group-addon" >
                                                            <i class="toggle-password-first fa fa-eye-slash" aria-hidden="true"></i>
                                                        </div>
                                                    </div>
                                                    <p><span class="messages" id="passwordStrengthMsg" style="color: red; font-size: 16px; line-height: 30px;"></span></p>
                                                    <span class="messages" id="spanPassword" style="color: red; font-size: 16px; line-height: 30px;"></span>
                                                    <span <%--class="help-block" --%>id="passwordValidationMsg" style="color: red; font-size: 16px; line-height: 30px;"></span>

                                                </div>
                                            </div>

                                            <div class="form-group row">
                                                <div class="col-sm-3">
                                                    <label for="txtConfirmPassword">Retype Password</label>
                                                </div>
                                                <div class="col-sm-6">
                                                    <div class="input-group">
                                                        <input type="password" id="txtConfirmPassword" class="form-control" placeholder="Retype Password" maxlength="16" autocomplete="off" />
                                                        <div class="input-group-addon" >
                                                            <i class="toggle-password-second fa fa-eye-slash" aria-hidden="true"></i>
                                                        </div>
                                                    </div>
                                                    <p class="help-block"></p>
                                                    <span class="messages" id="spanRetypePassword" style="color: red; font-size: 16px;line-height: 15px; "></span>
                                                    <br />
                                                    <span class="messages" id="spanRetypePassword1" style="color: red; font-size: 16px; line-height: 15px;"></span>

                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <div class="col-sm-12">
                                                    <center>
                                                        <button type="button" id="btnBack" class="btn btn-warning" onclick="sendRequest()">Submit</button>
                                                        <button type="button" id="btnChangePWD" class="btn btn-danger " onclick="BackToList()">Cancel</button>
                                                    </center>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-3"></div>
                            </div>
                        </div>


                    </div>
                </div>
            </div>
        </div>
    </form>

    



    <script src="js/knockout-3.3.0.js" type="text/javascript"></script>
    <script src="js/knockout.mapping-latest.js" type="text/javascript"></script>
    <script src="js/knockout.validation.js" type="text/javascript"></script>

    <script type="text/javascript">
        var ResetPassword = function () {
            var self = this;
            self.NewPassword = ko.observable('');
            self.EmailId = ko.observable('');
        };
    </script>

</body>
</html>
