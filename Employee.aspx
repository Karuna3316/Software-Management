<%@ Page Title="" Language="C#" MasterPageFile="~/YEEMAKHRMS.master" AutoEventWireup="true" CodeFile="Employee.aspx.cs" Inherits="Employee" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="assets/css/calender.css" rel="stylesheet" />
    <script src="assets/js/calender.js"></script>
    <style>
        label {
            align-content: center;
            line-height: 30px;
            font-size: 16px;
            color: #000;
        }

        

        .input-group-prepend {
            height: 34px;
            margin-right: 0px !important;
            padding: 5px;
        }

        .input-group-addon {
            color: #555353;
            padding: 8px 8px 0px 8px;
            background-color: #ccc;
            border: 1px solid;
            border-radius: 4px;
            border-color: #000;
            height: 38px;
        }
    </style>
    <script>
        $(document).ready(function () {
            var objUrlParams = new URLSearchParams(window.location.search);
            var userId = objUrlParams.get('userId');
            if (userId != null) {
                fnEditEmployee(userId);
            }
            else {
                RoleDRP(0);
                DepartmentDRP(0);
                DesignationDRP(0);
                BindEmpCard();
            }

            $(".btnCancel").on('click', function () {
                location.href = "EmployeeList.aspx";
            });
            $('#chkAddress').click(function () {
                if ($(this).is(':checked')) {
                    var PermanentAddress = $('#txtPermanentAddress').val();
                    $('#txtCommunicationAddress').val(PermanentAddress);
                } else {
                    $('#txtCommunicationAddress').val("");
                }
            });

            var max1 = 500;
            var elq = document.getElementById('txtUserName');

            $('#txtUserName').keypress(function (event) {
                var Length = $("#txtUserName").val().length;
                var AmountLeft = max1 - Length;
                $('#txtUserName-length-left').html(AmountLeft);
                if (Length >= max1) {
                    if (event.which != 8) {
                        $('#spantxtUserName1').text('Only 500 characters are allowed');

                        return false;
                    }
                } else {
                    $('#spantxtUserName1').text('');
                    elq.addEventListener('keydown', function (event) {
                        // Checking for Backspace.
                        if (event.keyCode == 8) {
                            $('#spantxtUserName1').html('');
                        }

                    });
                }


            });

            var max4 = 50;
            var eld = document.getElementById('txtEmailId');

            $('#txtEmailId').keypress(function (event) {
                var Length = $("#txtEmailId").val().length;
                var AmountLeft = max4 - Length;
                $('#txtEmailId-length-left').html(AmountLeft);
                if (Length >= max4) {
                    if (event.which != 8) {
                        $('#spanEmailId').text('Only 50 characters are allowed');

                        return false;
                    }
                } else {
                    $('#spanEmailId').text('');
                    eld.addEventListener('keydown', function (event) {
                        // Checking for Backspace.
                        if (event.keyCode == 8) {
                            $('#spanEmailId').html('');
                        }

                    });
                }


            });

            var max5 = 100;
            var ele = document.getElementById('txtFatherName');

            $('#txtFatherName').keypress(function (event) {
                var Length = $("#txtFatherName").val().length;
                var AmountLeft = max5 - Length;
                $('#txtFatherName-length-left').html(AmountLeft);
                if (Length >= max5) {
                    if (event.which != 8) {
                        $('#spantxtFatherName').text('Only 100 characters are allowed');

                        return false;
                    }
                } else {
                    $('#spantxtFatherName').text('');
                    ele.addEventListener('keydown', function (event) {
                        // Checking for Backspace.
                        if (event.keyCode == 8) {
                            $('#spantxtFatherName').html('');
                        }

                    });
                }

            });

            var max6 = 100;
            var elf = document.getElementById('txtEmergencyCName');

            $('#txtEmergencyCName').keypress(function (event) {
                var Length = $("#txtEmergencyCName").val().length;
                var AmountLeft = max6 - Length;
                $('#txtEmergencyCName-length-left').html(AmountLeft);
                if (Length >= max6) {
                    if (event.which != 8) {
                        $('#spantxtEmergencyCName').text('Only 100 characters are allowed');

                        return false;
                    }
                } else {
                    $('#spantxtEmergencyCName').text('');
                    elf.addEventListener('keydown', function (event) {
                        // Checking for Backspace.
                        if (event.keyCode == 8) {
                            $('#spantxtEmergencyCName').html('');
                        }

                    });
                }


            });

            var max7 = 100;
            var elg = document.getElementById('txtRelationship');

            $('#txtRelationship').keypress(function (event) {
                var Length = $("#txtRelationship").val().length;
                var AmountLeft = max7 - Length;
                $('#txtRelationship-length-left').html(AmountLeft);
                if (Length >= max7) {
                    if (event.which != 8) {
                        $('#spantxtRelationship').text('Only 100 characters are allowed');

                        return false;
                    }
                } else {
                    $('#spantxtRelationship').text('');
                    elg.addEventListener('keydown', function (event) {
                        // Checking for Backspace.
                        if (event.keyCode == 8) {
                            $('#spantxtRelationship').html('');
                        }

                    });
                }


            });

            var max8 = 100;
            var elh = document.getElementById('txtQualification');

            $('#txtQualification').keypress(function (event) {
                var Length = $("#txtQualification").val().length;
                var AmountLeft = max8 - Length;
                $('#txtQualification-length-left').html(AmountLeft);
                if (Length >= max8) {
                    if (event.which != 8) {
                        $('#spantxtQualification').text('Only 100 characters are allowed');

                        return false;
                    }
                } else {
                    $('#spantxtQualification').text('');
                    elh.addEventListener('keydown', function (event) {
                        // Checking for Backspace.
                        if (event.keyCode == 8) {
                            $('#spantxtQualification').html('');
                        }

                    });
                }


            });

            var max9 = 100;
            var eli = document.getElementById('txtNationality');

            $('#txtNationality').keypress(function (event) {
                var Length = $("#txtNationality").val().length;
                var AmountLeft = max9 - Length;
                $('#txtNationality-length-left').html(AmountLeft);
                if (Length >= max9) {
                    if (event.which != 8) {
                        $('#spantxtNationality').text('Only 100 characters are allowed');

                        return false;
                    }
                } else {
                    $('#spantxtNationality').text('');
                    eli.addEventListener('keydown', function (event) {
                        // Checking for Backspace.
                        if (event.keyCode == 8) {
                            $('#spantxtNationality').html('');
                        }

                    });
                }


            });


            var max10 = 100;
            var elj = document.getElementById('txtWages');

            $('#txtWages').keypress(function (event) {
                var Length = $("#txtWages").val().length;
                var AmountLeft = max10 - Length;
                $('#txtWages-length-left').html(AmountLeft);
                if (Length >= max10) {
                    if (event.which != 8) {
                        $('#spantxtWages').text('Only 100 characters are allowed');

                        return false;
                    }
                } else {
                    $('#spantxtWages').text('');
                    elj.addEventListener('keydown', function (event) {
                        // Checking for Backspace.
                        if (event.keyCode == 8) {
                            $('#spantxtWages').html('');
                        }

                    });
                }


            });

            var max11 = 100;
            var elk = document.getElementById('txtUAN');

            $('#txtUAN').keypress(function (event) {
                var Length = $("#txtUAN").val().length;
                var AmountLeft = max11 - Length;
                $('#txtUAN-length-left').html(AmountLeft);
                if (Length >= max11) {
                    if (event.which != 8) {
                        $('#spantxtUAN').text('Only 100 characters are allowed');

                        return false;
                    }
                } else {
                    $('#spantxtUAN').text('');
                    elk.addEventListener('keydown', function (event) {
                        // Checking for Backspace.
                        if (event.keyCode == 8) {
                            $('#spantxtUAN').html('');
                        }

                    });
                }


            });

            var max12 = 100;
            var ell = document.getElementById('txtESIC');

            $('#txtESIC').keypress(function (event) {
                var Length = $("#txtESIC").val().length;
                var AmountLeft = max12 - Length;
                $('#txtESIC-length-left').html(AmountLeft);
                if (Length >= max12) {
                    if (event.which != 8) {
                        $('#spantxtESIC').text('Only 100 characters are allowed');

                        return false;
                    }
                } else {
                    $('#spantxtESIC').text('');
                    ell.addEventListener('keydown', function (event) {
                        // Checking for Backspace.
                        if (event.keyCode == 8) {
                            $('#spantxtESIC').html('');
                        }

                    });
                }


            });

            var max13 = 100;
            var elm = document.getElementById('txtBankAccountNo');

            $('#txtBankAccountNo').keypress(function (event) {
                var Length = $("#txtBankAccountNo").val().length;
                var AmountLeft = max13 - Length;
                $('#txtBankAccountNo-length-left').html(AmountLeft);
                if (Length >= max13) {
                    if (event.which != 8) {
                        $('#spantxtBankAccountNo').text('Only 100 characters are allowed');

                        return false;
                    }
                } else {
                    $('#spantxtBankAccountNo').text('');
                    elm.addEventListener('keydown', function (event) {
                        // Checking for Backspace.
                        if (event.keyCode == 8) {
                            $('#spantxtBankAccountNo').html('');
                        }

                    });
                }


            });

            var max14 = 100;
            var eln = document.getElementById('txtBankIFSC');

            $('#txtBankIFSC').keypress(function (event) {
                var Length = $("#txtBankIFSC").val().length;
                var AmountLeft = max14 - Length;
                $('#txtBankIFSC-length-left').html(AmountLeft);
                if (Length >= max14) {
                    if (event.which != 8) {
                        $('#spantxtBankIFSC').text('Only 100 characters are allowed');

                        return false;
                    }
                } else {
                    $('#spantxtBankIFSC').text('');
                    eln.addEventListener('keydown', function (event) {
                        // Checking for Backspace.
                        if (event.keyCode == 8) {
                            $('#spantxtBankIFSC').html('');
                        }

                    });
                }


            });

            var max15 = 100;
            var elo = document.getElementById('txtAadharName');

            $('#txtAadharName').keypress(function (event) {
                var Length = $("#txtAadharName").val().length;
                var AmountLeft = max15 - Length;
                $('#txtAadharName-length-left').html(AmountLeft);
                if (Length >= max15) {
                    if (event.which != 8) {
                        $('#spantxtAadharName').text('Only  100 characters are allowed');

                        return false;
                    }
                } else {
                    $('#spantxtAadharName').text('');
                    elo.addEventListener('keydown', function (event) {
                        // Checking for Backspace.
                        if (event.keyCode == 8) {
                            $('#spantxtAadharName').html('');
                        }

                    });
                }


            });

            var max16 = 100;
            var elp = document.getElementById('txtPanName');

            $('#txtPanName').keypress(function (event) {
                var Length = $("#txtPanName").val().length;
                var AmountLeft = max16 - Length;
                $('#txtPanName-length-left').html(AmountLeft);
                if (Length >= max16) {
                    if (event.which != 8) {
                        $('#spantxtPanName').text('Only 100 characters are allowed');

                        return false;
                    }
                } else {
                    $('#spantxtPanName').text('');
                    elp.addEventListener('keydown', function (event) {
                        // Checking for Backspace.
                        if (event.keyCode == 8) {
                            $('#spantxtPanName').html('');
                        }

                    });
                }


            });


            $("#drpType").change(function () {
                var drpType = $(this).val();
                if (drpType > 0) {
                    $("#spandrpType").text("");

                }

            });

            $("#drpRoleId").change(function () {
                var drpRoleId = $(this).val();
                if (drpRoleId > 0) {
                    $("#spandrpRoleId").text("");

                }

            });


            $("#txtIDCARDNO").keyup(function () {
                var txtIDCARDNO = $(this).val();
                if (txtIDCARDNO != '') {
                    $("#spantxtIDCARDNO").text("");

                }

            });


            $("#txtDevicecode").keyup(function () {
                var txtDevicecode = $(this).val();
                if (txtDevicecode != '') {
                    $("#spantxtDevicecode").text("");

                }

            });


            $("#txtUserName").keyup(function () {
                var txtUserName = $(this).val();
                if (txtUserName != '') {
                    $("#spantxtUserName").text("");

                }

            })

            $("#dtDOJ").click(function () {
                var checkout = $(this).val();
                if (checkout > 0 || checkout != null || checkout != '') {
                    $("#spandtDOJ").text("");

                }

            });

            $("#drpDepartmentId").change(function () {
                var drpDepartmentId = $(this).val();
                if (drpDepartmentId > 0) {
                    $("#spandrpDepartmentId").text("");

                }

            });

            $("#drpDesignationId").change(function () {
                var drpDesignationId = $(this).val();
                if (drpDesignationId > 0) {
                    $("#spandrpDesignationId").text("");

                }

            });
        });

        var jq = jQuery.noConflict();

        jq(document).ready(function () {
            jq("#dtDOJ").datepicker({
                dateFormat: "dd/mm/yy",
                changeMonth: false,
                changeYear: false,
                yearRange: '1924:' + (new Date).getFullYear()

            });
            jq("#dtDOB").datepicker({
                dateFormat: "dd/mm/yy",
                changeMonth: true,
                changeYear: true,
                yearRange: '1924:' + (new Date).getFullYear()

            });
        });


        function RoleDRP(roleId) {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Employee.aspx/RoleDRP",
                data: "{}",
                dataType: "json",
                success: function (data) {
                    $("#drpRoleId").html("");
                    $("#drpRoleId").append($("<option></option>").val('0').html('- Select -'));
                    $.each(data.d, function (key, value) {
                        $("#drpRoleId").append($("<option></option>").val(value.roleId).html(value.roleName));
                    });
                    $("#drpRoleId").val(roleId);
                },
                error: function (result) {
                    alert("Failed to load Role");
                }
            });
        }

        function DepartmentDRP(DepartmentId) {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Employee.aspx/DepartmentDRP",
                data: "{}",
                dataType: "json",
                success: function (data) {
                    $("#drpDepartmentId").html("");
                    $("#drpDepartmentId").append($("<option></option>").val('0').html('- Select -'));
                    $.each(data.d, function (key, value) {
                        $("#drpDepartmentId").append($("<option></option>").val(value.DepartmentId).html(value.Department));
                    });
                    $("#drpDepartmentId").val(DepartmentId);
                },
                error: function (result) {
                    alert("Failed to load Department");
                }
            });
        }

        function DesignationDRP(DesignationId) {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Employee.aspx/DesignationDRP",
                data: "{}",
                dataType: "json",
                success: function (data) {
                    $("#drpDesignationId").html("");
                    $("#drpDesignationId").append($("<option></option>").val('0').html('- Select -'));
                    $.each(data.d, function (key, value) {
                        $("#drpDesignationId").append($("<option></option>").val(value.DesignationId).html(value.Designation));
                    });
                    $("#drpDesignationId").val(DesignationId);
                },
                error: function (result) {
                    alert("Failed to load Designation");
                }
            });
        }
        function BindEmpCard() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Employee.aspx/BindEmpCard",
                data: "{}",
                dataType: "json",
                success: function (data) {
                    if (data.d != null) {
                        if (data.d.IDCARDNO) {

                            $("#txtIDCARDNO").val(data.d.IDCARDNO);
                            $("#txtDevicecode").val(data.d.IDCARDNO);


                        }
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
        function SaveReq() {
            var isValid = true;
            isValid = isValid && hasddlValue("#drpType", "#spandrpType", "Select employee type");
            isValid = isValid && hasddlValue("#drpRoleId", "#spandrpRoleId", "Select role");
            isValid = isValid && hasValue("#txtIDCARDNO", "#spantxtIDCARDNO", "Enter the employee code");
            isValid = isValid && hasValue("#txtDevicecode", "#spantxtDevicecode", "Enter the device code");
            isValid = isValid && hasValue("#txtUserName", "#spantxtUserName", "Enter the employee name");
            isValid = isValid && hasValue("#dtDOJ", "#spandtDOJ", "Choose the date of joining");
            isValid = isValid && hasddlValue("#drpDepartmentId", "#spandrpDepartmentId", "Select departmant");
            isValid = isValid && hasddlValue("#drpDesignationId", "#spandrpDesignationId", "Select designation");
            if (isValid) {
                var objEMP = new SaveEmployee();
                //General Info
                objEMP.userId = $('#userId').val();
                objEMP.Type = $('#drpType').val();
                objEMP.RoleId = $('#drpRoleId').val();
                objEMP.IDCARDNO = $('#txtIDCARDNO').val().trim();
                objEMP.Devicecode = $('#txtDevicecode').val().trim();
                objEMP.UserName = $('#txtUserName').val().trim();
                objEMP.DOJ = $('#dtDOJ').val();
                objEMP.DepartmentId = $('#drpDepartmentId').val();
                objEMP.Department = $('#drpDepartmentId').find(":selected").text();
                objEMP.DesignationId = $('#drpDesignationId').val();
                objEMP.Designation = $('#drpDesignationId').find(":selected").text();

                //Personal Info
                objEMP.EmailId = $('#txtEmailId').val().trim();
                objEMP.DOB = $('#dtDOB').val();
                objEMP.Phone = $('#txtPhone').val().trim();
                objEMP.Gender = $('#drpGender').val();
                objEMP.MartialStatus = $('#drpMartialStatus').val();
                objEMP.FatherName = $('#txtFatherName').val().trim();
                objEMP.EmergencyCName = $('#txtEmergencyCName').val().trim();
                objEMP.EmergencyCNumber = $('#txtEmergencyCNumber').val().trim();
                objEMP.Relationship = $('#txtRelationship').val().trim();
                objEMP.Qualification = $('#txtQualification').val().trim();
                objEMP.PermanentAddress = $('#txtPermanentAddress').val().trim();
                objEMP.CommunicationAddress = $('#txtCommunicationAddress').val().trim();
                objEMP.Nationality = $('#txtNationality').val().trim();
                objEMP.Wages = $('#txtWages').val().trim();

                //Bank Info
                objEMP.UAN = $('#txtUAN').val().trim();
                objEMP.ESIC = $('#txtESIC').val().trim();
                objEMP.BankAccountNo = $('#txtBankAccountNo').val().trim();
                objEMP.BankIFSC = $('#txtBankIFSC').val().trim();
                objEMP.AadharNo = $('#txtAadharNo').val().trim();
                objEMP.AadharName = $('#txtAadharName').val().trim();
                objEMP.PanNo = $('#txtPanNo').val().trim();
                objEMP.PanName = $('#txtPanName').val().trim();
                $("#btnSubmit").attr("disabled", true);

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Employee.aspx/SaveorUpdateEmployee",
                    data: "{objEMP : " + ko.toJSON(objEMP) + "}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {
                            var inserted = data.d;
                            if (inserted != null) {

                                location.href = "EmployeeList.aspx?flagId=" + data.d;
                                ValidatetxtPersonalMobileNo(e);
                                ValidatetxtEmergencyMobileNo(e);
                                ValidateAADHARNO(e);

                            } else {
                                alert('failed to update');
                            }
                        }
                    },
                    error: function (response) {
                        alert(response.responseText);
                    },
                    failure: function (response) {
                        alert(response.responseText);
                    }
                });
            } else {
                // Show the first tab panel when isValid is false
                var firstTab = $('.nav-pills li:first-child a[data-bs-toggle="pill"]');
                firstTab.tab('show');
            }
            return isValid;
        }

        function ValidateNumber() {
            var PhoneNumber = document.getElementById("txtPhone").value;
            var spanphone = document.getElementById("spantxtPersonalMobileNo1");
            spanphone.innerHTML = "";
            var expr = /^[0-9]{10}$/;
            if (!expr.test(PhoneNumber)) {
                spanphone.innerHTML = "Enter the valid contact number"
                return false;
            }
            return true;
        }

        function ValidatetxtPersonalMobileNo(input) {
            var inputValue = input.value;
            var regex = /^[0-9]+$/;

            if (!regex.test(inputValue)) {
                $('#spantxtPersonalMobileNo2').text('Only numbers are allowed');
                input.value = inputValue.replace(/[^0-9]/g, ''); // Remove non-numeric characters
            } if (inputValue == 0 || regex.test(inputValue)) {
                $('#spantxtPersonalMobileNo2').text('');
            }
        }

        function ValidatetxtEmergencyCNumberNumber() {
            var PhoneNumber = document.getElementById("txtEmergencyCNumber").value;
            var spanphone = document.getElementById("spanttxtEmergencyCNumber");
            spanphone.innerHTML = "";
            var expr = /^[0-9]{10}$/;
            if (!expr.test(PhoneNumber)) {
                spanphone.innerHTML = "Enter the valid contact number"
                return false;
            }
            return true;
        }

        function ValidatetxtEmergencyMobileNo(input) {
            var inputValue = input.value;
            var regex = /^[0-9]+$/;

            if (!regex.test(inputValue)) {
                $('#spantxtPersonalMobileNo2').text('Only numbers are allowed');
                input.value = inputValue.replace(/[^0-9]/g, ''); // Remove non-numeric characters
            } if (inputValue == 0 || regex.test(inputValue)) {
                $('#spantxtEmergencyCNumber2').text('');
            }
        }

        function ValidateEmail() {
            var EmailId = document.getElementById("txtEmailId").value;
            var spanEmailId = document.getElementById("spanEmailId1");
            spanEmailId.innerHTML = "";
            var expr = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
            if (!expr.test(EmailId)) {
                spanEmailId.innerHTML = "Invalid email address"
                return false;
            }
            return true;
        }

        function ValidateAADHARNO(e) {
            var aadhaar = e.aadhaar || e.which;

            var lblError = document.getElementById("userId");
            lblError.aadhaar = "txtAadharNo";


            var regex = /^[0-9\s]*$/;


            var Phase2 = regex.test(String.fromCharCode(aadhaar));
            if (!Phase2) {

                $('#spanaadhar').text('Only numbers are allowed');
            }
            else {
                $('#spanaadhar').text("");

            }

            var inputElement = document.getElementById('txtAadharNo');


            var inputValue = inputElement.value.replace(/\D/g, '');


            if (inputValue.length > 0) {
                inputValue = inputValue.match(/.{1,4}/g).join(' ');
            }


            inputElement.value = inputValue;
            return Phase2;
        }


        function ValidatePAN() {
            var panInput = document.getElementById("txtPanNo");
            var PANNO = panInput.value;
            panInput.value = PANNO.toUpperCase();

            var spanPANNO = document.getElementById("spanpan");
            spanPANNO.innerHTML = "";

            var regex = /([A-Z]){5}([0-9]){4}([A-Z]){1}$/;
            if (!regex.test(PANNO)) {
                spanPANNO.innerHTML = "Enter the valid PAN number (e.g., ABCDE1234A)";
            }
        }




        function fnEditEmployee(userId) {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Employee.aspx/GetEmployeeEdit",
                data: "{userId : " + userId + "}",
                dataType: "json",
                success: function (data) {
                    if (data.d != null) {

                        //General Info
                        $('#userId').val(data.d.userId);
                        $('#drpType').val(data.d.Type).trigger('change.select2');
                        RoleDRP(data.d.RoleId);
                        $('#txtIDCARDNO').val(data.d.IDCARDNO);
                        $('#txtDevicecode').val(data.d.Devicecode);
                        $('#txtUserName').val(data.d.UserName);
                        $('#dtDOJ').val(data.d.DOJ);
                        DepartmentDRP(data.d.DepartmentId);
                        DesignationDRP(data.d.DesignationId);
                        $('#txtWages').val(data.d.Wages);

                        //Personal Info
                        $('#txtEmailId').val(data.d.EmailId);
                        $('#dtDOB').val(data.d.DOB);
                        $('#txtPhone').val(data.d.Phone);
                        $('#drpGender').val(data.d.Gender).trigger('change.select2');
                        $('#drpMartialStatus').val(data.d.MartialStatus).trigger('change.select2');
                        $('#txtFatherName').val(data.d.FatherName);
                        $('#txtEmergencyCName').val(data.d.EmergencyCName);
                        $('#txtEmergencyCNumber').val(data.d.EmergencyCNumber);
                        $('#txtRelationship').val(data.d.Relationship);
                        $('#txtQualification').val(data.d.Qualification);
                        $('#txtPermanentAddress').val(data.d.PermanentAddress);
                        $('#txtCommunicationAddress').val(data.d.CommunicationAddress);
                        if ((data.d.PermanentAddress == data.d.CommunicationAddress) && ((data.d.PermanentAddress != '') && (data.d.CommunicationAddress != ''))) {
                            $('#chkAddress').prop('checked', true);

                        } else {
                            $('#chkAddress').prop('checked', false);

                        }
                        $('#txtNationality').val(data.d.Nationality);

                        //Bank Info
                        $('#txtUAN').val(data.d.UAN);
                        $('#txtESIC').val(data.d.ESIC);
                        $('#txtBankAccountNo').val(data.d.BankAccountNo);
                        $('#txtBankIFSC').val(data.d.BankIFSC);
                        $('#txtAadharNo').val(data.d.AadharNo);
                        $('#txtAadharName').val(data.d.AadharName);
                        $('#txtPanNo').val(data.d.PanNo);
                        $('#txtPanName').val(data.d.PanName);
                    }
                    else {

                        alert('failed to load');
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
        function showNext() {
            var isValid = false;
            if (hasddlValue("#drpType", "#spandrpType", "Select employee type") &&
                hasddlValue("#drpRoleId", "#spandrpRoleId", "Select role") &&
                hasValue("#txtIDCARDNO", "#spantxtIDCARDNO", "Enter the employee code") &&
                hasValue("#txtDevicecode", "#spantxtDevicecode", "Enter the device code") &&
                hasValue("#txtUserName", "#spantxtUserName", "Enter the employee name") &&
                hasValue("#dtDOJ", "#spandtDOJ", "Choose the date of joining") &&
                hasddlValue("#drpDepartmentId", "#spandrpDepartmentId", "Select departmant") &&
                hasddlValue("#drpDesignationId", "#spandrpDesignationId", "Select designation")) {
                isValid = true;
            }

            if (isValid) {
                var activeTab = $('.nav-pills .nav-link.active');
                var nextTab = activeTab.parent().next('li').find('a[data-bs-toggle="pill"]');
                if (nextTab.length > 0) {
                    nextTab.tab('show');
                }
            } else {
                // Show the first tab panel when isValid is false
                var firstTab = $('.nav-pills li:first-child a[data-bs-toggle="pill"]');
                firstTab.tab('show');
            }
        }


        function showPrevious() {
            var activeTab = $('.nav-pills .nav-link.active');
            var prevTab = activeTab.parent().prev('li').find('a[data-bs-toggle="pill"]');
            if (prevTab.length > 0) {
                prevTab.tab('show');
            }
        }

        function hasValue(ctrlId, errDisplayCtrlId, errMsg) {

            var hasIt = true;
            if ($(ctrlId).val() == "") {
                hasIt = false;
                $(errDisplayCtrlId).text(errMsg);

            }
            else {
                $(errDisplayCtrlId).text('');

            }

            return hasIt;
        }

        function hasddlValue(ctrlId, errDisplayCtrlId, errMsg) {
            var hasIt = true;
            if ($(ctrlId).val() == "Select" || $(ctrlId).val() == 0) {
                hasIt = false;
                $(errDisplayCtrlId).text(errMsg);
                //$(ctrlId).focus();
            }
            else {
                $(errDisplayCtrlId).text('');

            }

            return hasIt;
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="page-content">
        <div class="page-breadcrumb d-none d-sm-flex align-items-center mb-3">
            <div class="ps-3">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-0 p-0 align-items-center">
                        <li class="breadcrumb-item">HRMS</li>
                        <li class="breadcrumb-item active" aria-current="page">Employee</li>
                    </ol>
                </nav>
            </div>
        </div>
        <div class="card">
            <div class="card-body">
                <ul class="nav nav-pills mb-3" role="tablist">
                    <li class="nav-item" role="presentation">
                        <a class="nav-link active" data-bs-toggle="pill" href="#primary-pills-home" role="tab" aria-selected="true">
                            <div class="d-flex align-items-center">
                                <div class="tab-icon">
                                    <i class="lni lni-home" style="padding-right: 3px;"></i>
                                </div>
                                <div class="tab-title">General Information</div>
                            </div>
                        </a>
                    </li>
                    <li class="nav-item" role="presentation">
                        <a class="nav-link" data-bs-toggle="pill" href="#primary-pills-profile" role="tab" aria-selected="false">
                            <div class="d-flex align-items-center">
                                <div class="tab-icon">
                                    <i class="fadeIn animated bx bx-user-circle" style="padding-right: 3px;"></i>
                                </div>
                                <div class="tab-title">Personal Information</div>
                            </div>
                        </a>
                    </li>
                    <li class="nav-item" role="presentation">
                        <a class="nav-link" data-bs-toggle="pill" href="#primary-pills-contact" role="tab" aria-selected="false">
                            <div class="d-flex align-items-center">
                                <div class="tab-icon">
                                    <i class="fadeIn animated bx bx-dollar"></i>
                                </div>
                                <div class="tab-title">Bank Details</div>
                            </div>
                        </a>
                    </li>
                </ul>
                <div class="tab-content" id="pills-tabContent">
                    <div class="tab-pane fade show active" id="primary-pills-home" role="tabpanel" style="border: 1px solid #000; border-radius: 3px; padding: 10px;">
                        <div class="row g-3" style="padding-bottom: 10px;">
                            <div class="col-sm-4">
                                <label class="form-label">Employee Type <sup><i class="fa fa-asterisk" aria-hidden="true" style="color: red; font-size: 10px;"></i></sup></label>

                                <select class="js-example-basic-single" id="drpType">
                                    <option value="0">- Select -</option>
                                    <option value="1">Worker</option>
                                    <option value="2">Staff</option>
                                </select>
                                <span class="messages" id="spandrpType" style="color: red; font-size: 15px"></span>

                            </div>
                            <div class="col-sm-4">
                                <label class="form-label">Role <sup><i class="fa fa-asterisk" aria-hidden="true" style="color: red; font-size: 10px;"></i></sup></label>

                                <select class="js-example-basic-single" id="drpRoleId"></select><span class="messages" id="spandrpRoleId" style="color: red; font-size: 15px"></span>

                            </div>
                            <div class="col-sm-4">
                                <label class="form-label">Employee Name <sup><i class="fa fa-asterisk" aria-hidden="true" style="color: red; font-size: 10px;"></i></sup></label>

                                <input type="text" autocomplete="off" class="form-control" id="txtUserName" placeholder="Employee Name" maxlength="500" />
                                <span class="messages" id="spantxtUserName" style="color: red; font-size: 15px"></span>
                                <span class="messages" id="spantxtUserName1" style="color: red; font-size: 15px"></span>
                            </div>
                        </div>
                        <div class="row g-3" style="padding-bottom: 10px;">
                            <div class="col-sm-4">
                                <label class="form-label">Employee Code <sup><i class="fa fa-asterisk" aria-hidden="true" style="color: red; font-size: 10px;"></i></sup></label>

                                <input type="text" autocomplete="off" class="form-control" id="txtIDCARDNO" disabled />
                                <span class="messages" id="spantxtIDCARDNO" style="color: red; font-size: 15px"></span>
                            </div>
                            <div class="col-sm-4">
                                <label class="form-label">Device Code <sup><i class="fa fa-asterisk" aria-hidden="true" style="color: red; font-size: 10px;"></i></sup></label>

                                <input type="text" autocomplete="off" class="form-control" id="txtDevicecode" disabled /><span class="messages" id="spantxtDevicecode" style="color: red; font-size: 15px"></span>

                            </div>


                            <div class="col-sm-4">
                                <label class="form-label">Date Of Joining <sup><i class="fa fa-asterisk" aria-hidden="true" style="color: red; font-size: 10px;"></i></sup></label>
                                <div class="input-group" id="datepicker">
                                    <input type="text" id="dtDOJ" class="form-control" style="background: #fff;" placeholder="dd/mm/yyyy" name="start" autocomplete="off" readonly>
                                    <div class="input-group-addon">
                                        <i class=" fa fa-calendar" aria-hidden="true"></i>
                                    </div>
                                </div>
                                <span class="messages" id="spandtDOJ" style="color: red; font-size: 15px"></span>

                            </div>
                        </div>
                        <div class="row g-3" style="padding-bottom: 10px;">
                            <div class="col-sm-4">
                                <label class="form-label">Department <sup><i class="fa fa-asterisk" aria-hidden="true" style="color: red; font-size: 10px;"></i></sup></label>

                                <select class="js-example-basic-single" id="drpDepartmentId"></select>
                                <span class="messages" id="spandrpDepartmentId" style="color: red; font-size: 15px"></span>
                            </div>
                            <div class="col-sm-4">
                                <label class="form-label">Designation <sup><i class="fa fa-asterisk" aria-hidden="true" style="color: red; font-size: 10px;"></i></sup></label>

                                <select class="js-example-basic-single" id="drpDesignationId"></select><span class="messages" id="spandrpDesignationId" style="color: red; font-size: 15px"></span>

                            </div>
                        </div>

                        <div class="row g-3" style="padding-bottom: 10px;">
                            <div class="col-6">
                                <div class="button">
                                    <button type="button" class="btn btn-dark btnCancel">Cancel</button>
                                </div>

                            </div>
                            <div class="col-6">

                                <div class="button" style="float: right;">
                                    <button type="button" class="btn btn-primary" onclick="showNext()">Next</button>
                                </div>
                            </div>

                        </div>

                    </div>
                    <div class="tab-pane fade" id="primary-pills-profile" role="tabpanel" style="border: 1px solid #000; border-radius: 3px; padding: 10px;">
                        <div class="row g-3" style="padding-bottom: 10px;">
                            <div class="col-sm-4">
                                <label class="form-label">Email Id</label>
                                <input type="text" autocomplete="off" class="form-control" id="txtEmailId" onkeyup="ValidateEmail()" maxlength="50" placeholder="Email Id" />
                                <span id="spanEmailId1" style="color: red; font-size: 15px;"></span><span id="spanEmailId" style="color: red; font-size: 15px;"></span>
                            </div>
                            <div class="col-sm-4">
                                <label class="form-label">Date Of Birth</label>
                                <div class="input-group" id="datepicker1">
                                    <input type="text" id="dtDOB" class="form-control" style="background: #fff;" placeholder="dd/mm/yyyy" name="start" autocomplete="off" readonly>
                                    <div class="input-group-addon">
                                        <i class=" fa fa-calendar" aria-hidden="true"></i>
                                    </div>
                                </div>

                            </div>

                            <div class="col-sm-4">
                                <label class="form-label">Phone Number</label>
                                <input type="text" class="form-control" style="height: 40px;" id="txtPhone" onkeyup="ValidateNumber();" oninput="ValidatetxtPersonalMobileNo(this);" maxlength="10" autocomplete="off" placeholder="Phone Number"/>
                                <span id="spantxtPersonalMobileNo1" style="color: red; font-size: 15px;"></span>
                            </div>
                        </div>
                        <div class="row g-3" style="padding-bottom: 10px;">
                            <div class="col-sm-4">
                                <label class="form-label">Gender</label><br />
                                <select class="js-example-basic-single" style="width: 100%;" id="drpGender">
                                    <option value="0">- Select -</option>
                                    <option value="1">Male</option>
                                    <option value="2">Female</option>
                                    <option value="3">Others</option>
                                </select>

                            </div>

                            <div class="col-sm-4">
                                <label class="form-label">Marital Status</label><br />
                                <select class="js-example-basic-single" style="width: 100%;" id="drpMartialStatus">
                                    <option value="0">- Select -</option>
                                    <option value="1">Single</option>
                                    <option value="2">Married</option>
                                    <option value="3">Widowed</option>
                                    <option value="4">Separated</option>
                                    <option value="5">Divorced</option>
                                </select>

                            </div>
                            <div class="col-sm-4">
                                <label class="form-label">Father Or Spouse Name</label>
                                <input type="text" autocomplete="off" class="form-control" style="height: 40px;" id="txtFatherName" maxlength="250" placeholder="Father Or Spouse Name" /><span id="spantxtFatherName" style="color: red; font-size: 15px"></span>
                            </div>

                        </div>
                        <div class="row g-3" style="padding-bottom: 10px;">
                            <div class="col-sm-4">
                                <label class="form-label">Emergency Contact Person</label>
                                <input type="text" autocomplete="off" class="form-control" id="txtEmergencyCName" placeholder="Emergency Contact Person" maxlength="250" /><span id="spantxtEmergencyCName" style="color: red; font-size: 15px"></span>

                            </div>
                            <div class="col-sm-4">
                                <label class="form-label">Emergency Contact Number</label>
                                <input type="text" autocomplete="off" class="form-control" id="txtEmergencyCNumber" onkeyup="ValidatetxtEmergencyCNumberNumber();" placeholder="Emergency Contact Number" oninput="ValidatetxtEmergencyMobileNo(this);" maxlength="10" />
                                <span id="spanttxtEmergencyCNumber" style="color: red; font-size: 15px;"></span>
                            </div>

                            <div class="col-sm-4">
                                <label class="form-label">Relationship</label>
                                <input type="text" autocomplete="off" class="form-control" id="txtRelationship" placeholder="Relationship" maxlength="250" /><span id="spantxtRelationship" style="color: red; font-size: 15px"></span>

                            </div>
                        </div>
                        <div class="row g-3" style="padding-bottom: 10px;">
                            <div class="col-sm-4">
                                <label class="form-label">Qualification</label>
                                <input type="text" autocomplete="off" class="form-control" id="txtQualification" placeholder="Qualification" maxlength="250" /><span id="spantxtQualification" style="color: red; font-size: 15px"></span>

                            </div>


                            <div class="col-sm-4">
                                <label class="form-label">Permanent Address </label>
                                <span class="messages" id="" style="color: red; font-size: 15px"></span>
                                <div style="float: right;">
                                    <input type="checkbox" style="width: 20px; height: 20px;" id="chkAddress"><span style="font-size: 15px;">&nbsp; &nbsp; Same for Communication Address</span>

                                </div>
                                <textarea autocomplete="off" class="form-control" placeholder="Permanent Address" id="txtPermanentAddress"></textarea>


                            </div>
                            <div class="col-sm-4">
                                <label class="form-label">Communication Address</label>
                                <textarea autocomplete="off" class="form-control" placeholder="Communication Address" id="txtCommunicationAddress" style="padding-top: 5px;"></textarea>

                            </div>
                        </div>
                        <div class="row g-3" style="padding-bottom: 10px;">
                            <div class="col-sm-4">
                                <label class="form-label">Nationality</label>
                                <input type="text" autocomplete="off" class="form-control" id="txtNationality" placeholder="Nationality" maxlength="250" /><span id="spantxtNationality" style="color: red; font-size: 15px"></span>

                            </div>
                            <div class="col-sm-4">
                                <label class="form-label">Wages</label>
                                <input type="text" autocomplete="off" class="form-control" id="txtWages" placeholder="Wages" maxlength="250" /><span id="spantxtWages" style="color: red; font-size: 15px"></span>

                            </div>

                        </div>

                        <div class="row g-3" style="padding-bottom: 10px;">
                            <div class="col-6">
                                <div class="button">
                                    <button type="button" class="btn btn-dark btnCancel">Cancel</button>
                                </div>

                            </div>
                            <div class="col-6">

                                <div class="button" style="float: right;">
                                    <button type="button" class="btn btn-dark" onclick="showPrevious()">Previous</button>
                                    <button type="button" class="btn btn-primary" onclick="showNext()">Next</button>
                                </div>
                            </div>

                        </div>
                    </div>
                    <div class="tab-pane fade" id="primary-pills-contact" role="tabpanel" style="border: 1px solid #000; border-radius: 3px; padding: 10px;">
                        <div class="row g-3" style="padding-bottom: 10px;">
                            <div class="col-sm-4">
                                <label class="form-label">UAN Number</label>
                                <input type="text" autocomplete="off" class="form-control" id="txtUAN" placeholder="UAN Number" maxlength="250" /><span id="spantxtUAN" style="color: red; font-size: 15px"></span>

                            </div>
                            <div class="col-sm-4">
                                <label class="form-label">ESIC Number</label>
                                <input type="text" autocomplete="off" class="form-control" id="txtESIC" placeholder="ESIC Number" maxlength="250" /><span id="spantxtESIC" style="color: red; font-size: 15px"></span>

                            </div>

                            <div class="col-sm-4">
                                <label class="form-label">Bank Account Number</label>
                                <input type="text" autocomplete="off" class="form-control" id="txtBankAccountNo" maxlength="250" placeholder="Bank Account Number" /><span id="spantxtBankAccountNo" style="color: red; font-size: 15px"></span>

                            </div>
                        </div>
                        <div class="row g-3" style="padding-bottom: 10px;">
                            <div class="col-sm-4">
                                <label class="form-label">IFSC Code</label>
                                <input type="text" autocomplete="off" class="form-control" id="txtBankIFSC" maxlength="250" placeholder="IFSC Code" /><span id="spantxtBankIFSC" style="color: red; font-size: 15px"></span>

                            </div>

                            <div class="col-sm-4">
                                <label class="form-label">Aadhar Number</label>
                                <input type="text" autocomplete="off" class="form-control" id="txtAadharNo" onkeypress="return ValidateAADHARNO(event);" maxlength="14" placeholder="Aadhar Number" /><span id="spanaadhar" style="color: red; font-size: 15px;"></span>

                            </div>
                            <div class="col-sm-4">
                                <label class="form-label">Name As Per Aadhar Card</label>
                                <input type="text" autocomplete="off" class="form-control" id="txtAadharName" placeholder="Name As Per Aadhar Card" maxlength="250" /><span id="spantxtAadharName" style="color: red; font-size: 15px"></span>

                            </div>
                        </div>
                        <div class="row g-3" style="padding-bottom: 10px;">
                            <div class="col-sm-4">
                                <label class="form-label">PAN Number</label>
                                <input type="text" autocomplete="off" class="form-control" id="txtPanNo" onkeyup="ValidatePAN()" maxlength="10" placeholder="PAN Number" /><span id="spanpan" style="color: red; font-size: 15px;"></span>

                            </div>
                            <div class="col-sm-4">
                                <label class="form-label">Name As Per PAN Card</label>
                                <input type="text" autocomplete="off" class="form-control" id="txtPanName" placeholder="Name As Per PAN Card" maxlength="250" /><span id="spantxtPanName" style="color: red; font-size: 15px"></span>

                            </div>
                        </div>
                        <div class="row g-3" style="padding-bottom: 10px;">
                            <div class="col-6">
                                <div class="button">
                                    <button type="button" class="btn btn-dark btnCancel">Cancel</button>
                                </div>

                            </div>
                            <div class="col-6">

                                <div class="button" style="float: right;">
                                    <button type="button" class="btn btn-dark" onclick="showPrevious()">Previous</button>
                                    <button type="button" class="btn btn-primary" id="btnSubmit" onclick="SaveReq()">Submit</button>

                                </div>
                            </div>
                            <input type="hidden" id="userId" value="0" />


                        </div>
                    </div>
                </div>
            </div>
        </div>



    </div>

    <!--Knockout Script-->
    <script src="js/knockout-3.5.1.js" type="text/javascript"></script>
    <script src="js/knockout.mapping-latest-2.4.1.js" type="text/javascript"></script>
    <script src="js/knockout.validation-2.0.4.js" type="text/javascript"></script>

    <script>

        var SaveEmployee = function () {
            //General Info
            this.userId = ko.observable(0);
            this.Type = ko.observable('');
            this.RoleId = ko.observable('');
            this.IDCARDNO = ko.observable('');
            this.Devicecode = ko.observable('');
            this.UserName = ko.observable('');
            this.DOJ = ko.observable('');
            this.DepartmentId = ko.observable('');
            this.Department = ko.observable('');
            this.DesignationId = ko.observable('');
            this.Designation = ko.observable('');
            this.Wages = ko.observable('');

            //Personal Info
            this.EmailId = ko.observable('');
            this.DOB = ko.observable('');
            this.Phone = ko.observable('');
            this.Gender = ko.observable('');
            this.MartialStatus = ko.observable('');
            this.FatherName = ko.observable('');
            this.EmergencyCName = ko.observable('');
            this.EmergencyCNumber = ko.observable('');
            this.Relationship = ko.observable('');
            this.Qualification = ko.observable('');
            this.PermanentAddress = ko.observable('');
            this.CommunicationAddress = ko.observable('');
            this.Nationality = ko.observable('');

            //Bank Info
            this.UAN = ko.observable('');
            this.ESIC = ko.observable('');
            this.BankAccountNo = ko.observable('');
            this.BankIFSC = ko.observable('');
            this.AadharNo = ko.observable('');
            this.AadharName = ko.observable('');
            this.PanNo = ko.observable('');
            this.PanName = ko.observable('');
        };
    </script>
</asp:Content>

