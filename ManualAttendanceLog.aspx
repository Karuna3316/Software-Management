<%@ Page Title="" Language="C#" MasterPageFile="~/YEEMAKHRMS.master" AutoEventWireup="true" CodeFile="ManualAttendanceLog.aspx.cs" Inherits="ManualAttendanceLog" %>

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
            EmployeeLog_Drp(0);
            $('#Table').hide();

            $("#fromDate").change(function () {
                var fromDate = $(this).val();

                // Check if a valid date has been selected
                if (fromDate !== "") {
                    $("#Sdate1").text("");
                }
            });


            $("#ToDate").change(function () {
                var ToDate = $(this).val();

                // Check if a valid date has been selected
                if (ToDate !== "") {
                    $("#Sdate2").text("");
                }
            });

        });

        var jq = jQuery.noConflict();
        jq(document).ready(function () {
            jq("#fromDate").datepicker({
                dateFormat: "dd/mm/yy",
                changeMonth: false,
                changeYear: false,
                yearRange: '1924:' + (new Date).getFullYear(),
                maxDate: '0'
            });
        });

        var jq = jQuery.noConflict();
        jq(document).ready(function () {
            jq("#ToDate").datepicker({
                dateFormat: "dd/mm/yy",
                changeMonth: false,
                changeYear: false,
                yearRange: '1924:' + (new Date).getFullYear(),
                maxDate: '0'
            });

            $("#fromDate").click(function () {
                var checkout = $(this).val();
                if (checkout > 0 || checkout != null || checkout != '') {
                    $("#Sdate1").text("");

                }

            });

            $("#ToDate").click(function () {
                var checkout = $(this).val();
                if (checkout > 0 || checkout != null || checkout != '') {
                    $("#Sdate2").text("");

                }

            });
        });


        function EmployeeLog_Drp(userId) {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "ManualAttendanceLog.aspx/getManualAttendancedrp",
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

        function BindManualAttendanceLog(stDate, endDate, empId) {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "ManualAttendanceLog.aspx/getManualAttendancelog",
                data: "{stDate:'" + stDate + "',endDate: '" + endDate + "',empId: '" + empId + "'}",
                dataType: "json",
                success: function (data) {
                    formDocument().lstManualAttlog().constructor();
                    if ($.fn.dataTable.isDataTable('#basic-btn')) {
                        $('#basic-btn').DataTable().clear().destroy();
                    }
                    ko.mapping.fromJS(data.d, null, formDocument);
                    $('#basic-btn').DataTable({
                        responsive: false,
                        "ordering": false,
                        "paging": true,
                        destroy: true,
                    });

                },

                error: function (response) {
                    alert(response.responseText);
                },
                failure: function (response) {
                    alert(response.responseText);
                }
            });

        }

        function checkDates() {
            var SD = $('#fromDate').val();
            var ED = $('#ToDate').val();
            var Emp = $('#drp_emp');

            if (SD === "" && ED === "")
                $('#Sdate1')[0].innerText = "Choose the start date";
            else if (SD === "" && ED !== "")
                $('#Sdate1')[0].innerText = "Choose the start date";
            else
                $('#Sdate1')[0].innerText = "";
            if (SD !== "" && ED === "")
                $('#Sdate2')[0].innerText = "Choose the end date";
            else
                $('#Sdate2')[0].innerText = "";

            if (SD !== "" && ED !== "") {
                if (SD < ED) {
                    $('#Table').show();
                    $('#lblCr')[0].innerText = "";
                    BindManualAttendanceLog(SD, ED, Emp.val());
                } else {
                    $('#lblCr')[0].innerText = "Choose the valid dates";
                    $('#Table').hide();
                }
                return true;
            } else {
                $('#Table').hide();
                return false;
            }
        }

        function Reset() {
            $('#fromDate').val("");
            $('#ToDate').val("");
            $('#Sdate1')[0].innerText = "";
            $('#Sdate2')[0].innerText = "";
            $('#lblCr')[0].innerText = "";
            EmployeeLog_Drp(0);
            $('#Table').hide();
        }

    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="page-content">
        <div class="page-breadcrumb d-none d-sm-flex align-items-center mb-3">
            <div class="ps-3">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-0 p-0 align-items-center">
                        <li class="breadcrumb-item">REPORTS</li>
                        <li class="breadcrumb-item active" aria-current="page">Manual Attendance Log</li>
                    </ol>
                </nav>
            </div>
        </div>

        <div class="card" style="padding: 10px;">
            <div class="card-body">
                <div class="border p-3 rounded">

                    <div class="form-group row g-3" style="padding-bottom: 10px;">
                        <div class="col-sm-3">
                            <label class="form-label">From <sup><i class="fa fa-asterisk" aria-hidden="true" style="color: red; font-size: 10px;"></i></sup></label>
                            <div class="input-group">
                                <input type="text" style="background: #fff !important;" placeholder="dd/mm/yyyy" id="fromDate" class="form-control" autocomplete="off" readonly />
                                <div class="input-group-addon">
                                    <i class=" fa fa-calendar" aria-hidden="true"></i>
                                </div>
                            </div>
                            <span id="Sdate1" style="color: red; font-size: 15px"></span>

                        </div>
                        <div class="col-sm-3">
                            <label class="form-label">To <sup><i class="fa fa-asterisk" aria-hidden="true" style="color: red; font-size: 10px;"></i></sup></label>
                            <div class="input-group">
                                <input type="text" style="background: #fff !important;" placeholder="dd/mm/yyyy" id="ToDate" class="form-control" autocomplete="off" readonly />
                                <div class="input-group-addon">
                                    <i class=" fa fa-calendar" aria-hidden="true"></i>
                                </div>
                            </div>
                            <span id="Sdate2" style="color: red; font-size: 15px"></span>

                        </div>
                        <div class="col-sm-3" style="line-height: 30px;">
                            <label class="form-label">Employee Name</label>
                            <select class="js-example-basic-single" style="width: 100%;" id="drp_emp">
                            </select>
                        </div>
                        <div class="col-sm-1" style="line-height: 115px; text-align: center">
                            <button type="button" class="btn btn-primary" onclick="checkDates()">Submit</button>
                        </div>
                        <div class="col-sm-1" style="line-height: 115px;">
                            <button type="button" class="btn btn-dark" onclick="Reset()">Reset</button>
                        </div>
                        <div class="form-group row">
                            <div class="col-sm-3">
                                <span id="lblCr" style="color: red; font-size: 15px;"></span>
                            </div>
                        </div>
                    </div>


                </div>
            </div>
        </div>
        <div class="card" style="padding: 10px;" id="Table">
            <div class="card-body">
                <div class="border p-3 rounded">
                    <div class="table-responsive">
                        <table id="basic-btn" class="table table-striped table-bordered" style="width: 100%" data-bind="visible: formDocument().lstManualAttlog().length > 0">
                            <thead>
                                <tr role="row">
                                    <th>Employee ID</th>
                                    <th>Employee Name</th>
                                    <th>Designation</th>
                                    <th>Date</th>
                                    <th>Shift Time</th>
                                    <th>Check In</th>
                                    <th>Check Out</th>
                                    <th>Created Date</th>
                                    <th>Created By</th>

                                </tr>
                            </thead>
                            <tbody id="body" data-bind="foreach: formDocument().lstManualAttlog()">
                                <tr>
                                    <td><span data-bind="text:IDCARDNO"></span></td>
                                    <td><span data-bind="text:EmployeeName"></span></td>
                                    <td><span data-bind="text:Designation"></span></td>
                                    <td style="text-align: center;"><span data-bind="text:Date"></span></td>
                                    <td style="text-align: center;"><span data-bind="text:ShiftType"></span></td>
                                    <td style="text-align: center;"><span data-bind="text:CheckInDate"></span></td>
                                    <td style="text-align: center;"><span data-bind="text:CheckOutDate"></span></td>
                                    <td style="text-align: center;"><span data-bind="text:createddate"></span></td>
                                    <td><span data-bind="text:Createdby"></span></td>
                                </tr>
                            </tbody>

                        </table>

                    </div>
                </div>
                <input type="hidden" id="AttendanceID" value="0">
            </div>

        </div>
    </div>

    <!--Knockout Script-->
    <script src="js/knockout-3.5.1.js" type="text/javascript"></script>
    <script src="js/knockout.mapping-latest-2.4.1.js" type="text/javascript"></script>
    <script src="js/knockout.validation-2.0.4.js" type="text/javascript"></script>


    <script type="text/javascript">
        var ManualAttendanceLog_obj = function () {
            var self = this;
            this.lstManualAttlog = ko.observableArray([{
                AttendanceID: 0, IDCARDNO: '', EmployeeName: '', Designation: '', CheckInDate: '', CheckOutDate: '', stDate: '', endDate: '',
                Reason: '', Date: '', createddate: '', Createdby: '', ShiftType:''
            }]);
        };

        formDocument = ko.observable(new ManualAttendanceLog_obj());

        ko.applyBindings(new ManualAttendanceLog_obj());
    </script>
</asp:Content>