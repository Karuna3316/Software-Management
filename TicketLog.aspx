<%@ Page Title="" Language="C#" MasterPageFile="~/YEEMAKHRMS.master" AutoEventWireup="true" CodeFile="TicketLog.aspx.cs" Inherits="TicketLog" %>

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
            BindEmployeeName(0);

            $("#dtFrom").click(function () {
                $('#lblFr')[0].innerText = "";
            });

            $("#dtTo").click(function () {

                $('#lblE')[0].innerText = "";
            });
        });

        var jq = jQuery.noConflict();
        jq(document).ready(function () {

            jq("#dtFrom").datepicker({
                dateFormat: "dd/mm/yy",
                changeMonth: false,
                changeYear: false,
                yearRange: '1924:' + (new Date).getFullYear(),
                maxDate: '0'
            });

            jq("#dtTo").datepicker({
                dateFormat: "dd/mm/yy",
                changeMonth: false,
                changeYear: false,
                yearRange: '1924:' + (new Date).getFullYear(),
                maxDate: '0'
            });

        });

        function chkFrDates() {
            var fD = $('#dtFrom').val();
            var eD = $('#dtTo').val();
            var Eid = $('#drpEmployeeName');

            if (fD === "" && eD === "")
                $('#lblFr')[0].innerText = "Choose the start date";
            else if (fD === "" && eD !== "")
                $('#lblFr')[0].innerText = "Choose the start date";
            else
                $('#lblFr')[0].innerText = "";
            if (fD !== "" && eD === "")
                $('#lblE')[0].innerText = "Choose the end date";
            else
                $('#lblE')[0].innerText = "";

            if (fD !== "" && eD !== "") {

                if (fD < eD) {
                    $('#table').attr('hidden', false);
                    $('#lblCr')[0].innerText = "";
                    BindTicketLog(fD, eD, Eid.val());
                } else {
                    $('#lblCr')[0].innerText = "Choose the valid dates";
                    $('#table').attr('hidden', true);
                }
                return true;
            } else {
                $('#table').attr('hidden', true);
                return false;
            }
        }

        function BindTicketLog(stDate, EndDate, Employee) {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "TicketLog.aspx/BindTicketLogList",
                data: "{stD:'" + stDate + "',endD: '" + EndDate + "',Eid: '" + Employee + "'}",
                dataType: "json",
                success: function (data) {
                    formDocument().objTicketLog().constructor();
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
        function BindEmployeeName(Value) {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "TicketLog.aspx/BindEmployeeName",
                data: "{}",
                dataType: "json",
                success: function (data) {
                    $("#drpEmployeeName").html("");
                    $("#drpEmployeeName").append($("<option></option>").val('0').html('- Select -'));
                    $.each(data.d, function (key, value) {
                        $("#drpEmployeeName").append($("<option></option>").val(value.userId).html(value.UserName));
                    });
                    $("#drpEmployeeName").val(Value);

                },
                error: function (result) {
                    alert("Failed to load Employee Name");
                }
            });
        }

        function Reset() {
            $('#dtFrom').val("");
            $('#dtTo').val("");
            $('#lblFr')[0].innerText = "";
            $('#lblE')[0].innerText = "";
            $('#lblCr')[0].innerText = "";
            $('#table').attr('hidden', true);
            BindEmployeeName(0);
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
                        <li class="breadcrumb-item active" aria-current="page">Tickets Log</li>
                    </ol>
                </nav>
            </div>
        </div>

        <div class="card" style="padding: 10px;">
            <div class="card-body">
                <div class="border p-3 rounded">

                    <div class="form-group row g-3" style="padding-bottom: 10px;">
                        <div class="col-sm-3">
                            <label class="form-label">From <sup><i class="fa fa-asterisk" aria-hidden="true" style="color: red; font-size: 10px !important;"></i></sup></label>
                            <div class="input-group">
                                <input type="text" class="form-control" id="dtFrom" style="background: #fff !important;" placeholder="dd/mm/yyyy" autocomplete="off" readonly />
                                <div class="input-group-addon">
                                    <i class=" fa fa-calendar" aria-hidden="true"></i>
                                </div>
                            </div>
                            <span id="lblFr" style="color: red; font-size: 15px;"></span>
                        </div>
                        <div class="col-sm-3">

                            <label class="form-label">To <sup><i class="fa fa-asterisk" aria-hidden="true" style="color: red; font-size: 10px !important;"></i></sup></label>
                            <div class="input-group">
                                <input type="text" class="form-control" style="background: #fff !important;" placeholder="dd/mm/yyyy" id="dtTo" autocomplete="off" readonly />
                                <div class="input-group-addon">
                                    <i class=" fa fa-calendar" aria-hidden="true"></i>
                                </div>
                            </div>
                            <span id="lblE" style="color: red; font-size: 15px;"></span>


                        </div>
                        <div class="col-sm-3" style="line-height: 30px;">
                            <label class="form-label">Employee Name</label>
                            <select class="js-example-basic-single" style="width: 100%;" id="drpEmployeeName">
                            </select>
                        </div>
                        <div class="col-sm-1" style="line-height: 115px; text-align: center">
                            <button type="button" class="btn btn-primary" onclick="chkFrDates()">Submit</button>
                        </div>
                        <div class="col-sm-1" style="line-height: 115px;">
                            <button type="button" class="btn btn-dark" onclick="Reset()">Reset</button>
                        </div>

                    </div>

                    <span id="lblCr" style="color: red; font-size: 15px;"></span>
                </div>
            </div>
        </div>
        <div class="card" style="padding: 10px;" id="table" hidden="hidden">
            <div class="card-body">
                <div class="border p-3 rounded">
                    <div class="table-responsive">
                        <table id="basic-btn" class="table table-striped table-bordered" style="width: 100%" data-bind="visible: formDocument().objTicketLog().length > 0">
                            <thead>
                                <tr role="row">
                                    <th>Employee ID</th>
                                    <th>Employee Name</th>
                                    <th>Ticket Type</th>
                                    <th>Date </th>
                                    <th>Time</th>
                                    <th>Reason</th>

                                </tr>
                            </thead>
                            <tbody data-bind="foreach: formDocument().objTicketLog()">
                                <tr>
                                    <td><span data-bind="text: Eid"></span></td>
                                    <td><span data-bind="text: Employeename"></span></td>
                                    <td><span data-bind="text: SupportType"></span></td>
                                    <td style="text-align: center"><span data-bind="text: Date"></span></td>
                                    <td style="text-align: center"><span data-bind="text: Time"></span></td>
                                    <td><span data-bind="text: Reason"></span></td>
                                </tr>
                            </tbody>

                        </table>

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
        var lstTicketlogObj = function () {
            var self = this;
            this.objTicketLog = ko.observableArray([{
                Eid: '', SupportType: '', Employeename: '', Date: '', Time: '', Reason: '', SupportId: ''
            }]);
        };
        formDocument = ko.observable(new lstTicketlogObj());
        ko.applyBindings(new lstTicketlogObj(), document.getElementById("basic-btn"));
    </script>
</asp:Content>

