<%@ Page Title="" Language="C#" MasterPageFile="~/YEEMAKHRMS.master" AutoEventWireup="true" CodeFile="LeaveRequest.aspx.cs" Inherits="LeaveRequest" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="assets/plugins/perfect-scrollbar/css/perfect-scrollbar.css" rel="stylesheet" />
    <link href="assets/plugins/simplebar/css/simplebar.css" rel="stylesheet" />
    <link href="assets/plugins/metismenu/css/metisMenu.min.css" rel="stylesheet" />
    <link href="assets/plugins/datatable/css/dataTables.bootstrap5.min.css" rel="stylesheet" />




    <!-- CSS Files -->
    <link href="assets/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/css/bootstrap-extended.css" rel="stylesheet">
    <link href="assets/css/style.css" rel="stylesheet">
    <script src="assets/js/jquery-3.6.0.min.js"></script>

    <!--PNotify-->
    <link rel="stylesheet" type="text/css" href="files/bower_components/pnotify/dist/pnotify.css" />
    <link rel="stylesheet" type="text/css" href="files/bower_components/pnotify/dist/pnotify.brighttheme.css" />
    <link rel="stylesheet" type="text/css" href="files/bower_components/pnotify/dist/pnotify.buttons.css" />
    <link rel="stylesheet" type="text/css" href="files/bower_components/pnotify/dist/pnotify.history.css" />
    <link rel="stylesheet" type="text/css" href="files/bower_components/pnotify/dist/pnotify.mobile.css" />
    <link rel="stylesheet" type="text/css" href="files/assets/pages/pnotify/notify.css" />
    <link rel="stylesheet" type="text/css" href="files/assets/pages/pnotify/notify.css" />

    <link href="files/assets/css/sweetalert.css" rel="stylesheet" />


    <link href="assets/css/calender.css" rel="stylesheet" />
    <script src="assets/js/calender.js"></script>
    <style>
        label {
            align-content: center;
            line-height: 30px;
            font-size: 16px;
            color: #000;
        }

        .form-control {
            font-size: 16px;
            border: 1px solid #525151;
        }
    </style>
    <script>
        $(document).ready(function () {
            $('.js-example-basic-single').select2();


           var objUrlParams = new URLSearchParams(window.location.search);
            var LID = objUrlParams.get('LID');
            if (LID != null) {

                fnEditLeave(LID);
                $("#divshifttype").hide();

            }
            else {
            BindEmployeeName(0);
            BindLeaveType(0);
            fnBindleavedate(0, 0, 0);
            $("#divshifttype").hide();

            }


            $("#drpemployee").change(function () {

                var feCount = $("#drpemployee").val();
                var LID = $("#LID").val();


                if (feCount != '0' && feCount != '') {
                    fnBindleavedate(feCount, LID, 0);
                }
                else {
                    fnBindleavedate(0, 0, 0);
                }

            });

            $("#drpleavetype").change(function () {

                var feCount = $("#drpleavetype").val();
                var feempid = $("#drpemployee").val();
                var LID = $("#LID").val();
              


                if (feCount == 4) {
                    Bindhiddenfields(feempid);
                   // fnBindleavedate(feempid, LID, 0);

                }
                else {
                    //fnBindleavedate(feempid, LID, 0);
                }

            });

            $("#drpemployee").change(function () {
                var drpemployee = $(this).val();
                if (drpemployee > 0) {
                    $("#spandrpemployee").text("");
                    $("#spantxtcompoff").text("");
                    $("#txtcompoff").text("");


                }

            });

            $("#drpleavedate").change(function () {
                var drpleavedate = $(this).val();
                if (drpleavedate > 0 || drpleavedate != "") {
                    $("#spandrpleavedate").text("");

                }

            });

            $("#drpleavetype").change(function () {
                var drpleavetype = $(this).val();
                if (drpleavetype > 0) {
                    $("#spandrpleavetype").text("");
                    $("#spantxtcompoff").text("");
                    $("#txtcompoff").text("");



                }

            });

            $("#txtreason").keyup(function () {
                var txtreason = $(this).val();
                if (txtreason != '') {
                    $("#spantxtreason").text("");

                }

            });

            var max16 = 100;
            var elp = document.getElementById('txtreason');

            $('#txtreason').keypress(function (event) {
                var Length = $("#txtreason").val().length;
                var AmountLeft = max16 - Length;
                $('#txtreason-length-left').html(AmountLeft);
                if (Length >= max16) {
                    if (event.which != 8) {
                        $('#spantxtreason1').text('Only 100 characters are allowed');

                        return false;
                    }
                } else {
                    $('#spantxtreason1').text('');
                    elp.addEventListener('keydown', function (event) {
                        // Checking for Backspace.
                        if (event.keyCode == 8) {
                            $('#spantxtreason1').html('');
                        }

                    });
                }


            });

           


        });

        function BindEmployeeName(Ename) {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Leaverequest.aspx/BindEmployeeName",
                data: "{}",
                dataType: "json",
                success: function (data) {
                    $("#drpemployee").html("");
                    $("#drpemployee").append($("<option></option>").val('0').html('Select Employee Name'));
                    $.each(data.d, function (key, value) {
                        $("#drpemployee").append($("<option></option>").val(value.EId).html(value.EName));
                    });
                    $("#drpemployee").val(Ename);
                },
                error: function (result) {
                    alert("Failed to load Employee Name");
                }
            });
        }

        function BindLeaveType(LTname) {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Leaverequest.aspx/BindLeaveType",
                data: "{}",
                dataType: "json",
                success: function (data) {
                    $("#drpleavetype").html("");
                    $("#drpleavetype").append($("<option></option>").val('0').html('Select Leave Type'));
                    $.each(data.d, function (key, value) {
                        $("#drpleavetype").append($("<option></option>").val(value.LdId).html(value.Description));
                    });
                    $("#drpleavetype").val(LTname);
                },
                error: function (result) {
                    alert("Failed to load Leave Type");
                }
            });
        }

        function fnBindleavedate(userid, LID, leavedate) {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Leaverequest.aspx/GetLeaveDate",
                data: "{userid: '" + userid + "',LID: '" + LID + "'}",
                dataType: "json",
                success: function (data) {
                    $("#drpleavedate").html("");
                    $("#drpleavedate").append($("<option></option>").val(0).html('Select Leave Date'));
                    $.each(data.d, function (key, value) {
                        $("#drpleavedate").append($("<option></option>").val(value.AbsentDate).html(value.AbsentDate));
                    });
                    $("#drpleavedate").val(leavedate);
                },
                error: function (result) {
                    alert("Failed to load leave date");
                }
            });
        }

        function fnEditLeave(LID) {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Leaverequest.aspx/GetEmployeeEdit",
                data: "{LID : " + LID + "}",
                dataType: "json",
                success: function (data) {
                    if (data.d != null) {

                        //General Info
                        $('#LID').val(data.d.LID);
           
                        BindEmployeeName(data.d.UserID);
                        BindLeaveType(data.d.LeaveType);
                        fnBindleavedate(data.d.UserID, data.d.LID, data.d.LeaveDays);
                        $('#txtreason').val(data.d.LeaveReason);
                        


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

        function Bindhiddenfields(userid) {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Leaverequest.aspx/Bindhiddenfields",
                data: "{userid : " + userid + "}",
                dataType: "json",
                success: function (data) {
                    if (data.d != null) {

                            $("#txtcompoff").text(data.d.TotalExtraHours);
                            $("#txtshifttype").val(data.d.ShiftTime);
 
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
            isValid = isValid && hasddlValue("#drpemployee", "#spandrpemployee", "Select Employee Name");
            isValid = isValid && hasddlValue("#drpleavedate", "#spandrpleavedate", "Select Leave Date");
            isValid = isValid && hasddlValue("#drpleavetype", "#spandrpleavetype", "Select Leave Type");

            var txtcompoffValue = parseFloat($('#txtcompoff').text());
            if (txtcompoffValue <= 8.0000) {
                //alert('Warning: Compoff hours should be at least 8.0000 hours.');
                $("#spantxtcompoff").text(" Compoff hours should be at least 8.0000 hours.");
                isValid = false;
            }
            //isValid = isValid && hasValue("#txtreason", "#spantxtreason", "Enter the Reason");

            if (isValid) {
                var EMPObj = new LeaveBalance();
                EMPObj.LID = $('#LID').val();
                EMPObj.UserID = $('#drpemployee').val();
                EMPObj.LeaveDays = $('#drpleavedate').val();
                EMPObj.LeaveType = $('#drpleavetype').val();
                EMPObj.Reason = $('#txtreason').val();
                $("#divshifttype").hide();



                $("#btnSubmit").attr("disabled", true);

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Leaverequest.aspx/SaveorupdateLeave",
                    data: "{EMPObj : " + ko.toJSON(EMPObj) + "}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {
                            var inserted = data.d;
                            if (inserted != null) {

                                location.href = "LeaverequestList.aspx?flagId=" + data.d;

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


        function BackToList() {

            location.href = "LeaverequestList.aspx";

        }


    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="page-content">
        <div class="page-breadcrumb d-none d-sm-flex align-items-center mb-3">
            <%--<div class="breadcrumb-title pe-3">Tables</div>--%>
            <div class="ps-3">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-0 p-0 align-items-center">
                        <li class="breadcrumb-item"><a href="dashboard.aspx">
                            <ion-icon name="home-outline" role="img" class="md hydrated" aria-label="home outline"></ion-icon>
                        </a>
                        </li>
                        <li class="breadcrumb-item active" aria-current="page">Leave Request</li>
                    </ol>
                </nav>
            </div>
        </div>

        <div class="card" style="padding: 10px;">
            <div class="card-body">
                <div class="border p-3 rounded">

                    <div class="row g-3" style="padding-bottom: 10px;">
                        <div class="col-4">
                            <label class="form-label">Employee Name <sup><i class="fa fa-asterisk" aria-hidden="true" style="color: red; font-size: 10px;"></i></sup></label>
                        </div>
                        <div class="col-5">
                            <select class="js-example-basic-single" id="drpemployee">
                            </select><span id="spandrpemployee" style="color: red; font-size: 16px;"></span>

                        </div>
                    </div>
                    <div class="row g-3" style="padding-bottom: 10px;">
                        <div class="col-4">
                            <label class="form-label">Leave Days <sup><i class="fa fa-asterisk" aria-hidden="true" style="color: red; font-size: 10px;"></i></sup></label>
                        </div>
                        <div class="col-5">
                            <select class="js-example-basic-single" id="drpleavedate">
                            </select><span id="spandrpleavedate" style="color: red; font-size: 16px;"></span>
                        </div>
                    </div>
                    <div class="row g-3" style="padding-bottom: 10px;">
                        <div class="col-4">
                            <label class="form-label">Leave Type <sup><i class="fa fa-asterisk" aria-hidden="true" style="color: red; font-size: 10px;"></i></sup></label>
                        </div>
                        <div class="col-5">
                            <select class="js-example-basic-single" id="drpleavetype">
                            </select><span id="spandrpleavetype" style="color: red; font-size: 16px;"></span>
                        </div>

                    </div>

                    <div class="row g-3" style="padding-bottom: 10px;">
                        <div class="col-4">
                            <label class="form-label">Reason</label>
                        </div>
                        <div class="col-5">
                            <textarea class="form-control" id="txtreason"></textarea>
                            <span id="spantxtreason" style="color: red; font-size: 16px;"></span>
                            <span id="spantxtreason1" style="color: red; font-size: 16px;"></span>
                        </div>

                    </div>

                    <div class="row g-3" style="padding-bottom: 10px;">
                        <div class="col-4">
                            <label class="form-label">Compoff</label>
                        </div>
                        <div class="col-5">
                            <h5  class="form-label" id="txtcompoff" style="font-weight:600; " />
                            <span id="spantxtcompoff1" style="color: red; font-size: 16px;"></span>
                        </div>

                    </div>

                     <div class="row g-3" style="padding-bottom: 10px;" id="divshifttype">
                        <div class="col-4">
                            <label class="form-label">Shift Type</label>
                        </div>
                        <div class="col-5">
                            <input type="text" class="form-control" id="txtshifttype" />
                            <span id="spantxtshifttype" style="color: red; font-size: 16px;"></span>
                            <span id="spantxtshifttype1" style="color: red; font-size: 16px;"></span>
                        </div>

                    </div>

                    <div class="row g-3">
                        <div class="col-12">
                            <center>
                                <button type="button" class="btn btn-primary" onclick="SaveReq();">Submit</button>
                                <button type="button" class="btn btn-dark" id="btnSubmit" onclick="BackToList();">Cancel</button>
                            </center>
                        </div>
                    </div>                           
                    <span id="spantxtcompoff" style="color: red; font-size: 16px;"></span>

                </div>
            </div>
            <input type="hidden" id="LID" value="0" />

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

    <script type="text/javascript">
        var LeaveBalance = function () {
            var self = this;
            self.LID = ko.observable(0);
            self.UserID = ko.observable(0);
            self.LeaveDays = ko.observable('');
            self.LeaveType = ko.observable('');
            self.Reason = ko.observable('');
        };
    </script>
</asp:Content>

