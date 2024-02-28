<%@ Page Title="" Language="C#" MasterPageFile="~/YEEMAKHRMS.master" AutoEventWireup="true" CodeFile="ManualAttendance.aspx.cs" Inherits="ManualAttendance" %>

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

        button:focus {
            outline: none !important;
            background: none;
        }

        th {
            text-align: center;
        }

        .input-group-text {
            display: flex;
            align-items: center;
            padding: 0.375rem 0.75rem;
            font-size: 1rem;
            font-weight: 400;
            line-height: 1.5;
            color: #212529;
            text-align: center;
            white-space: nowrap;
            background-color: #e9ecef;
            border: 1px solid #000000 !important;
            border-radius: 0.25rem;
        }
        .input-group-addon {
            color: #555353;
            padding: 8px 8px;
            background-color: #ccc;
            border: 1px solid;
            border-radius: 4px;
            border-color: #000;
        }
    </style>

    <script>
        $(document).ready(function () {
            $('.js-example-basic-single').select2();
            $('#AUCheck').hide();

            var objUrlParams = new URLSearchParams(window.location.search);
            var AttendanceID = objUrlParams.get('AttendanceID');
            if (AttendanceID != null) {
                AddOrUpdate(AttendanceID)

            }
            else {
                Employee_Drp(0);
                AddOrUpdateDrp(0);
                $('#attendancetable').hide();
            }


            $("#drpaction").change(function () {
                var BindUpdate = $("#drpaction").val();
                if (BindUpdate == 2) {
                    // Get the table element
                    var table = document.getElementById("basic-btn");

                    // Get the first row in the table body
                    var row = table.getElementsByTagName("tbody")[0].getElementsByTagName("tr")[0];

                    // Get the first cell in the row
                    var cell = row.getElementsByTagName("td")[0];

                    // Get the AttendanceID span element in the cell
                    var span = cell.getElementsByTagName("span")[0];

                    // Get the value of the AttendanceID attribute
                    var AttendanceId = span.getAttribute("value");

                    // Store the attendanceId value in a variable for later use
                    AddOrUpdate(AttendanceId);
                }
                else {
                    document.getElementById('txtCheckIn').value = "";
                    document.getElementById('txtCheckOut').value = "";
                    $('#txtreason').val('');
                    AddOrUpdate(0);
                }


            });


            var max7 = 50;
            var elg = document.getElementById('txtreason');

            $('#txtreason').keypress(function (event) {
                var Length = $("#txtreason").val().length;
                var AmountLeft = max7 - Length;
                $('#txtreason-length-left').html(AmountLeft);
                if (Length >= max7) {
                    if (event.which != 8) {
                        $('#spantxtreason').text('Only 50 characters are allowed');

                        return false;
                    }
                } else {
                    $('#spantxtreason').text('');
                    elg.addEventListener('keydown', function (event) {
                        // Checking for Backspace.
                        if (event.keyCode == 8) {
                            $('#spantxtreason').html('');
                        }

                    });
                }


            });

            $("#drp_emp").change(function () {
                var drp_emp = $(this).val();
                if (drp_emp != '') {
                    $("#spanEmployee").text("");

                }

            });

            $("#txtdate").click(function () {
                var checkout = $(this).val();
                if (checkout > 0 || checkout != null || checkout != '') {
                    $("#spanDate").text("");

                }
            });

            $("#txtCheckIn").click(function () {
                var checkout = $(this).val();
                if (checkout > 0 || checkout != null || checkout != '') {
                    $("#spanCheckIn").text("");

                }
            });

            $("#drpaction").change(function () {
                var drpaction = $(this).val();
                if (drpaction != '') {
                    $("#spandraction").text("");

                }

            });



        });

        var jq = jQuery.noConflict();
        jq(document).ready(function () {
            jq("#txtdate").datepicker({
                dateFormat: "dd/mm/yy",
                changeMonth: false,
                changeYear: false,
                yearRange: '1924:' + (new Date).getFullYear(),
                maxDate: '0'
            });
        });


        function Employee_Drp(userId) {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "ManualAttendance.aspx/getManualAttendancedrp",
                data: "{}",
                dataType: "json",
                success: function (data) {
                    $("#drp_emp").html("");
                    $("#drp_emp").append($("<option></option>").val('0').html('- Select -'));
                    $.each(data.d, function (key, value) {
                        $("#drp_emp").append($("<option></option>").val(value.userId).html(value.UserName));
                    });
                    $("#drp_emp").val(userId);
                },
                error: function (result) {
                    alert("Failed to load Employee Name");
                }
            });
        }

        function AddOrUpdateDrp(ActionId) {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "ManualAttendance.aspx/DrpAddOrUpdate",
                data: "{}",
                dataType: "json",
                success: function (data) {
                    $("#drpaction").html("");
                    $("#drpaction").append($("<option></option>").val('0').html('- Select -'));
                    $.each(data.d, function (key, value) {
                        $("#drpaction").append($("<option></option>").val(value.ActionId).html(value.ActionName));
                    });
                    $("#drpaction").val(ActionId);
                },
                error: function (result) {
                    alert("Failed to load Action Name");
                }
            });

        }

        function ManualAttendanceList(EmployeeId, Date) {
            $.ajax({

                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "ManualAttendance.aspx/getManualAttendancelist",
                data: "{EmployeeId: '" + EmployeeId + "',Date: '" + Date + "'}",
                dataType: "json",
                success: function (data) {
                    formDocument().lstManualAtt().constructor();
                    ko.mapping.fromJS(data.d, null, formDocument);
                },

                error: function (response) {
                    alert(response.responseText);
                },
                failure: function (response) {
                    alert(response.responseText);
                }
            });

        }

        function chkFrDates() {
            var isV = false;
            AddOrUpdateDrp(0);
            $('#attendancetable').hide();
            var EmployeeId = $('#drp_emp');
            var Date = $('#txtdate');

            if (EmployeeId.val() == 0 && Date.val() == "")
                $('#spanEmployee')[0].innerText = "Select employee name";
            else if (EmployeeId.val() == 0 && Date.val() != "")
                $('#spanEmployee')[0].innerText = "Select employee name";
            else
                $('#spanEmployee')[0].innerText = "";
            if (EmployeeId.val() != 0 && Date.val() == "")
                $('#spanDate')[0].innerText = "Choose the date";
            else
                $('#spanDate')[0].innerText = "";

            if (EmployeeId.val() != 0 && Date.val() != "")
                isV = true;
            if (isV) {
                $('#attendancetable').show();
                $('#AUCheck').show();
                ManualAttendanceList(EmployeeId.val(), Date.val());
                document.getElementById('txtCheckIn').value = "";
                document.getElementById('txtCheckOut').value = "";
                $('#txtreason').val('');
            }
            else {
                $('#attendancetable').hide();
            }
            return isV;
        }

        function resetlist() {
            document.getElementById('txtdate').value = "";
            Employee_Drp(0);
            AddOrUpdateDrp(0);
            $('#spanCheckIn')[0].innerText = "";
            $('#spanEmployee')[0].innerText = "";
            $('#spanDate')[0].innerText = "";

            $('#attendancetable').hide();
            $('#AUCheck').hide();

        }

        function InsertOrUpdate() {
            if (hasddlValue("#drpaction", "#spandraction", "Select Add or Update")) {
                var IU = $("#drpaction").val();

                if (IU == 1) {
                    Insert();
                }
                if (IU == 2) {
                    Update();
                }
            }
        }

        function Insert() {
            var isValid = false;
            if
                (hasddlValue("#drpaction", "#spandraction", "Select Add or Update") &&
                hasValue("#txtCheckIn", "#spanCheckIn", "Choose the checkIn time"))

                isValid = true;

            if (isValid) {


                var EmployeeId = $('#drp_emp');
                var Date = $('#txtdate');

                var objManAtt = new ManualAttendance_obj();
                objManAtt.AttendanceID = $('#AttendanceID').val();
                objManAtt.userId = $('#drp_emp').val();

                var txtdate = $('#txtdate').val();
                var formattedDate = txtdate.split("/").reverse().join("-");

                objManAtt.CheckInDate = formattedDate + 'T' + $('#txtCheckIn').val() + ':00';
                if ($('#txtCheckOut').val() == "") {
                    objManAtt.CheckOutDate = "";
                } else {
                    objManAtt.CheckOutDate = formattedDate + 'T' + $('#txtCheckOut').val() + ':00';
                }
                objManAtt.ActionType = $('#drpaction').val();
                objManAtt.Reason = $('#txtreason').val();
                $("#btnSubmit").attr("disabled", true);
                swal({
                    title: "Are you sure?",
                    text: "Do You Want to Add Attendance ?",
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonClass: "btn-danger",
                    confirmButtonText: "Yes",
                    cancelButtonText: "No",
                    closeOnConfirm: true,
                    closeOnCancel: false
                },
                    function (isConfirm) {
                        if (isConfirm) {
                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "ManualAttendance.aspx/saveManualAttendance",
                                data: "{objManAtt : " + ko.toJSON(objManAtt) + "}",
                                dataType: "json",
                                success: function (data) {
                                    if (data.d != "") {

                                        var inserted = data.d;
                                        if (inserted != null) {
                                            if (data.d == 3) {
                                                new PNotify({
                                                    title: 'Notification',
                                                    text: 'Data already exists...',
                                                    icon: 'icofont icofont-info-circle',
                                                    type: 'warning'
                                                });
                                            }
                                            else if (data.d == 1) {
                                                new PNotify({
                                                    title: 'Registered',
                                                    text: 'Submited Successfully...',
                                                    icon: 'icofont icofont-info-circle',
                                                    type: 'success'
                                                });
                                            }
                                            $('#AUCheck').hide();
                                            ManualAttendanceList(EmployeeId.val(), Date.val());
                                            document.getElementById('txtCheckIn').value = "";
                                            document.getElementById('txtCheckOut').value = "";
                                            $('#txtreason').val('');


                                            AddOrUpdateDrp(0);

                                        }
                                    }
                                    $('#AUCheck').hide();
                                    ManualAttendanceList(EmployeeId.val(), Date.val());
                                    document.getElementById('txtCheckIn').value = "";
                                    document.getElementById('txtCheckOut').value = "";
                                    $('#txtreason').val('');



                                    AddOrUpdateDrp(0);
                                },
                                error: function (response) {
                                    alert(response.responseText);
                                },
                                failure: function (response) {
                                    alert(response.responseText);
                                }
                            });

                        } else {
                            swal.close();
                        }
                    });

            }
            return isValid;
        }

        function Update() {

            var isValid = false;
            if
                (hasddlValue("#drpaction", "#spandraction", "Select Add or Update") &&
                hasValue("#txtCheckIn", "#spanCheckIn", "Choose the checkIn time"))

                isValid = true;

            if (isValid) {
                var EmployeeId = $('#drp_emp');
                var Date = $('#txtdate');


                var txtdate = $('#txtdate').val();
                var formattedDate = txtdate.split("/").reverse().join("-");

                var objManAtt = new ManualAttendance_obj();
                objManAtt.AttendanceID = $('#AttendanceID').val();
                objManAtt.userId = $('#drp_emp').val();
                objManAtt.CheckInDate = formattedDate + 'T' + $('#txtCheckIn').val() + ':00';
                if ($('#txtCheckOut').val() == "") {
                    objManAtt.CheckOutDate = "";
                } else {
                    objManAtt.CheckOutDate = formattedDate + 'T' + $('#txtCheckOut').val() + ':00';
                }
                objManAtt.ActionType = $('#drpaction').val();
                objManAtt.Reason = $('#txtreason').val();
                $("#btnSubmit").attr("disabled", true);
                swal({
                    title: "Are you sure?",
                    text: "Do You Want to Update Attendance ?",
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonClass: "btn-danger",
                    confirmButtonText: "Yes",
                    cancelButtonText: "No",
                    closeOnConfirm: true,
                    closeOnCancel: false
                },
                    function (isConfirm) {
                        if (isConfirm) {
                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "ManualAttendance.aspx/saveManualAttendance",
                                data: "{objManAtt : " + ko.toJSON(objManAtt) + "}",
                                dataType: "json",
                                success: function (data) {
                                    if (data.d != "") {

                                        var inserted = data.d;
                                        if (inserted != null) {
                                            if (data.d == 4) {
                                                new PNotify({
                                                    title: 'Notification',
                                                    text: 'Data doesn\'t exist...',
                                                    icon: 'icofont icofont-info-circle',
                                                    type: 'warning'
                                                });

                                            }

                                            else if (data.d == 2) {
                                                new PNotify({
                                                    title: 'Updated',
                                                    text: 'Updated Successfully...',
                                                    icon: 'icofont icofont-info-circle',
                                                    type: 'success'
                                                });
                                            }
                                            $('#AUCheck').hide();
                                            document.getElementById('txtCheckIn').value = "";
                                            document.getElementById('txtCheckOut').value = "";
                                            $('#txtreason').val('');

                                            AddOrUpdateDrp(0);
                                        }
                                    }

                                    ManualAttendanceList(EmployeeId.val(), Date.val());
                                    $('#AUCheck').hide();
                                    document.getElementById('txtCheckIn').value = "";
                                    document.getElementById('txtCheckOut').value = "";
                                    $('#txtreason').val('');

                                    AddOrUpdateDrp(0);
                                },
                                error: function (response) {
                                    alert(response.responseText);
                                },
                                failure: function (response) {
                                    alert(response.responseText);
                                }
                            });
                        } else {
                            swal.close();
                        }
                    });

            }
            return isValid;
        }

        function AddOrUpdate(AttendanceID) {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "ManualAttendance.aspx/BindUpdate",
                data: "{AttendanceID : " + AttendanceID + "}",
                dataType: "json",
                success: function (data) {

                    if (data.d != null) {
                        var CheckInDate = data.d.CheckInDate;
                        var CheckOutDate = data.d.CheckOutDate;
                        var [CIdate, CItime] = CheckInDate.split(' ');
                        var [COdate, COtime] = CheckOutDate.split(' ');

                        $('#AttendanceID').val(data.d.AttendanceID);
                        $('#txtCheckIn').val(CItime);
                        $('#txtCheckOut').val(COtime);
                        $('#txtreason').val(data.d.Reason);
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

    </script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="page-content">
        <div class="page-breadcrumb d-none d-sm-flex align-items-center mb-3">
            <div class="ps-3">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-0 p-0 align-items-center">
                        <li class="breadcrumb-item">TICKETS</li>
                        <li class="breadcrumb-item active" aria-current="page">Manual Attendance</li>
                    </ol>
                </nav>
            </div>
        </div>

        <div class="card" style="padding: 10px;">
            <div class="card-body">
                <div class="border p-3 rounded">

                    <div class="row g-3" style="padding-bottom: 10px;">
                        <div class="col-sm-3">
                            <label class="form-label">Employee Name <sup><i class="fa fa-asterisk" aria-hidden="true" style="color: red; font-size: 10px;"></i></sup></label>
                            <select class="js-example-basic-single" id="drp_emp">
                            </select>
                            <span id="spanEmployee" style="color: red; font-size: 15px"></span>
                        </div>
                        <div class="col-sm-3">
                            <label class="form-label">Date <sup><i class="fa fa-asterisk" aria-hidden="true" style="color: red; font-size: 10px;"></i></sup></label>
                            <div class="input-group">
                                <input type="text" class="form-control" autocomplete="off" id="txtdate" style="background: #fff !important;" placeholder="dd/mm/yyyy" readonly />
                                <div class="input-group-addon">
                                    <i class=" fa fa-calendar" aria-hidden="true"></i>
                                </div>
                            </div>
                            <span id="spanDate" style="color: red; font-size: 15px"></span>
                        </div>

                        <div class="col-sm-1" style="line-height: 115px; text-align: center;">
                            <button type="button" class="btn btn-primary" onclick="chkFrDates()">Submit</button>
                        </div>
                        <div class="col-sm-1" style="line-height: 115px;">
                            <button type="button" class="btn btn-dark" onclick="resetlist()">Reset</button>
                        </div>

                    </div>
                </div>

            </div>
        </div>

        <div class="card" style="padding: 10px;" id="attendancetable">
            <div class="card-body">
                <div class="border p-3 rounded">
                    <div class="table-responsive">
                        <table id="basic-btn" class="table table-striped table-bordered" style="width: 100%" data-bind="visible: formDocument().lstManualAtt().length > 0">
                            <thead>
                                <tr role="row">
                                    <th style="background-color: #525b88; color: #ffffff; text-align: center; width: 20%; display: none;">ATTENDANCE ID</th>
                                    <th>Employee Id</th>
                                    <th>Employee Name</th>
                                    <th>Check In</th>
                                    <th>Check Out</th>

                                </tr>
                            </thead>
                            <tbody data-bind="foreach: formDocument().lstManualAtt()">
                                <tr>
                                    <td style="text-align: center; width: 20%; display: none;"><span id="AttId" data-bind="attr: { value: AttendanceID,title:userId}"></span></td>
                                    <td><span data-bind="text:IDCARDNO"></span></td>
                                    <td><span data-bind="text:UserName"></span></td>
                                    <td style="text-align: center;"><span data-bind="text:CheckInDate"></span></td>
                                    <td style="text-align: center;"><span data-bind="text:CheckOutDate"></span></td>
                                </tr>
                            </tbody>


                        </table>

                    </div>
                    <input type="hidden" id="AttendanceID" value="0">
                </div>
            </div>
        </div>

        <div class="card" style="padding: 10px;" id="AUCheck">
            <div class="card-body">
                <div class="border p-3 rounded">

                    <div class="row g-3" style="padding-bottom: 10px;">
                        <div class="col-sm-4">
                            <label class="form-label">Add Or Update</label>
                        </div>
                        <div class="col-sm-2">
                            <select class="js-example-basic-single col-sm-12" id="drpaction">
                            </select>

                            <span id="spandraction" style="color: red; font-size: 15px;"></span>
                        </div>



                    </div>

                    <div class="row g-3" style="padding-bottom: 10px;">
                        <div class="col-sm-4" style="line-height: 40px">
                            <label times="form-label">Check In</label>
                            <input type="time" class="form-control" id="txtCheckIn" />
                            <span id="spanCheckIn" style="color: red; font-size: 15px;"></span>
                        </div>
                        <div class="col-sm-4">
                            <label class="form-label">Check Out</label>
                            <input type="time" class="form-control" id="txtCheckOut" />

                        </div>
                        <div class="col-sm-4">
                            <label class="form-label">Reason</label>
                            <textarea class="form-control" id="txtreason" placeholder="Reason"></textarea>
                            <span id="spantxtreason" style="color: red; font-size: 15px;"></span>
                        </div>
                    </div>

                    <div class="row g-3" style="padding-bottom: 10px;">
                        <div class="col-sm-12">
                            <center>
                                <button type="button" class="btn btn-primary" id="btnsubmit" onclick="InsertOrUpdate()">Submit</button>
                            </center>
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

    <script type="text/javascript">
        var ManualAttendance_obj = function () {
            var self = this;
            this.AttendanceID = ko.observable(0);
            this.userId = ko.observable(0);
            this.UserName = ko.observable('');
            this.CheckInDate = ko.observable('');
            this.CheckOutDate = ko.observable('');
            this.Reason = ko.observable('');
            this.ActionType = ko.observable(0);


            this.lstManualAtt = ko.observableArray([{
                AttendanceID: 0, userId: 0, IDCARDNO: '', UserName: '', CheckInDate: '', CheckOutDate: ''
            }]);
        };
        formDocument = ko.observable(new ManualAttendance_obj());
        ko.applyBindings(new ManualAttendance_obj());
    </script>

</asp:Content>

