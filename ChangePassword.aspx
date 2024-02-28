<%@ Page Title="" Language="C#" MasterPageFile="~/YEEMAKHRMS.master" AutoEventWireup="true" CodeFile="ChangePassword.aspx.cs" Inherits="ChangePassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

        <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

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

        .input-group {
            height: 37px;
            margin-right: 0px !important;
            padding: 8px;
        }

        .input-group-addon {
            color: #555353;
            padding: 8px;
            background-color: #ccc;
            border: 1px solid #000;
            border-radius: 4px;
            height: 35px;
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
        });
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="pcoded-content">
        <div class="pcoded-inner-content">
            <div class="main-body">
                <div class="page-wrapper">
                    <div class="page-body">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="card">
                                    <div class="card-block">
                                        <h3 class="h-25">Change Password</h3>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="page-body">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="card">
                                    <div class="card-block">
                                        <div class="form-group row">
                                            <div class="col-sm-6">
                                                <label for="txtPassword">Password</label>
                                                <div class="input-group" id="Div1">
                                                    <input type="password" id="txtPassword" class="form-control" placeholder="Password" maxlength="16" autocomplete="off" />
                                                    <div class="input-group-addon" style="padding: 6px !important;">
                                                        <i class="toggle-password-first fa fa-eye-slash" aria-hidden="true"></i>
                                                    </div>
                                                </div>
                                                <p><span class="messages" id="passwordStrengthMsg" style="color: red; font-size: 16px; line-height: 30px;"></span></p>
                                                <span class="messages" id="spanPassword" style="color: red; font-size: 16px; line-height: 30px;"></span>
                                                <span id="passwordValidationMsg" style="color: red; font-size: 16px; line-height: 30px;"></span>
                                            </div>
                                            <div class="col-sm-6">
                                                <label for="txtConfirmPassword">Retype Password</label>
                                                <div class="input-group">
                                                    <input type="password" id="txtConfirmPassword" class="form-control" placeholder="Retype Password" maxlength="16" autocomplete="off" disabled/>
                                                    <div class="input-group-addon" style="padding: 6px !important;">
                                                        <i class="toggle-password-second fa fa-eye-slash" aria-hidden="true"></i>
                                                    </div>
                                                </div>
                                                <p class="help-block"></p>
                                                <span class="messages" id="spanRetypePassword" style="color: red; font-size: 16px; line-height: 30px;"></span>
                                                <br />
                                                <span class="messages" id="spanRetypePassword1" style="color: red; font-size: 16px; line-height: 30px;"></span>
                                            </div>

                                        </div>
                                        <div class="form-group row">
                                            <div class="col-sm-12">
                                                <center>
                                                    <button type="button" id="btnBack" class="btn btn-warning" onclick="sendRequest()">Submit</button>
                                                    <button type="button" id="btnChangePWD" class="btn btn-danger" onclick="BackToList()">Cancel</button>
                                                </center>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>

                    <asp:HiddenField ID="userIdHiddenField" runat="server" />
                    <asp:HiddenField ID="IsTeamLeadHiddenField" runat="server" />
                </div>
            </div>
        </div>
    </div>


    <script type="text/javascript">


        $(document).ready(function () {
            
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

            var passwordField = $('#txtPassword');
            var passwordValidationMsg = $('#passwordValidationMsg');
            var passwordStrengthMsg = $('#passwordStrengthMsg');
            var confirmPasswordField = $('#txtConfirmPassword');

            confirmPasswordField.prop('disabled', true);

            passwordField.on('input', function () {
                var password = passwordField.val().trim();

                if (password.length === 0) {
                    passwordStrengthMsg.empty(); // Clear password strength message when password is empty
                } else {
                    passwordValidationMsg.empty(); // Clear password required error message
                    validatePassword(password);
                }
            });

            // Attach the validation function to the input field's "keyup" event
            $("#txtPassword").on("keyup", function () {
                $("#txtPassword").css({ "border-color": "#000", "box-shadow": "none" });
                $("#spanRetypePassword").text("");
                $("#spanRetypePassword1").text("");
                $("#txtConfirmPassword").prop('disabled', false);
                validatePasswordOnKeyup();
            });

            // Attach the validation function to the input field's "keyup" event
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





        function validateRetypePasswordOnKeyup() {

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

 
  


        function sendRequest() {
            
            var isValid = false;

            var txtPassword = $('#txtPassword').val();
            var txtConfirmPassword = $('#txtConfirmPassword').val();


            if (hasValue("#txtPassword", "#spanPassword", "Enter the Password") && validatePassword(txtPassword) &&
                hasValue("#txtConfirmPassword", "#spanRetypePassword", "Enter the Retype Password") && (txtPassword == txtConfirmPassword) && validateRetypePasswordOnKeyup())
                isValid = true;
            {
                isValid = isValid && validatePassword(txtPassword);

                if (isValid) {
                   
                    var lsupObj = new ResetPassword();
                
                    lsupObj.newPwd = $('#txtConfirmPassword').val();
                    /*  lsupObj.EmailId = $('#EmailId').val();*/
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "ChangePassword.aspx/ChangeCurrentPassword",
                        data: "{newPwd : " + ko.toJSON(lsupObj) + "}",
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


        function hasValue(ctrlId, errDisplayCtrlId, errMsg) {
            var hasIt = true;
            var ctrlValue = $(ctrlId).val();

            if (ctrlValue === "") {
                hasIt = false;
                $(errDisplayCtrlId).text(errMsg);
            } else {
                $(errDisplayCtrlId).text('');
            }

            return hasIt;
        }

        function BackToList() {
            var roleId = $('#<%= userIdHiddenField.ClientID %>').val();
            var IsTeamLead = $('#<%= IsTeamLeadHiddenField.ClientID %>').val();

            if (roleId == 1) {
                window.location = 'Dashboard.aspx';
            }

            if (roleId != 1) {
                window.location = 'Dashboard.aspx';
            }
        }
    </script>

        <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="js/knockout-3.3.0.js" type="text/javascript"></script>
    <script src="js/knockout.mapping-latest.js" type="text/javascript"></script>
    <script src="js/knockout.validation.js" type="text/javascript"></script>



    <script type="text/javascript">
        var ResetPassword = function () {
            var self = this;
            self.newPwd = ko.observable('');
        };
    </script>


</asp:Content>

