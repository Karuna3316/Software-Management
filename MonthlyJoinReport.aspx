<%@ Page Title="" Language="C#" MasterPageFile="~/YEEMAKHRMS.master" AutoEventWireup="true" CodeFile="MonthlyJoinReport.aspx.cs" Inherits="MonthlyJoinReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
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
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
            $('.js-example-basic-single').select2();
            MonthDrp(0);
            YearDrp(0);
            $('#table').attr('hidden', true);
            MonthJoinReportList(0, 0);

            $("#drpMonth").change(function () {
                var fD = $(this).val();
                if (fD >= 0) {
                    $("#spanMonth").text("");
                } else {
                    $("#spanMonth").text(fD);
                }
            });

            $("#drpYear").change(function () {
                var fD = $(this).val();
                if (fD >= 0) {
                    $("#spanYear").text("");
                } else {
                    $("#spanYear").text(fD);
                }
            });
        });

        function JoinReportFilter() {
            var isV = true;
            var eD = $('#drpMonth');
            var fD = $('#drpYear');

            if (eD.val() == "0" && fD.val() == "0") {
                $('#spanMonth')[0].innerText = "Select Month";
                $('#table').attr('hidden', true);
            }
            else if (eD.val() == "0" && fD.val() != "0") {
                $('#spanMonth')[0].innerText = "Select Month";
                $('#table').attr('hidden', true);
            }
            else {
                $('#spanMonth')[0].innerText = "";
            }
            if (eD.val() != "0" && fD.val() == "0") {
                $('#spanYear')[0].innerText = "Select Year";
                $('#table').attr('hidden', true);
            }
            else {
                $('#spanYear')[0].innerText = "";
            }

            if ((eD.val() != "0" && fD.val() != "0")) {
                MonthJoinReportList(fD.val(), eD.val());
                $('#table').attr('hidden', false);
            } else {
                $('#table').attr('hidden', true);
                isV = false;
                return isV;
            }
        }


        function MonthDrp(DMId) {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "MonthlyJoinReport.aspx/Getmonthdrp",
                data: "{}",
                dataType: "json",
                success: function (data) {
                    $("#drpMonth").html("");
                    $("#drpMonth").append($("<option></option>").val('0').html('- Select -'));
                    $.each(data.d, function (key, value) {
                        $("#drpMonth").append($("<option></option>").val(value.DMId).html(value.Month));
                    });
                    $("#drpMonth").val(DMId);
                },
                error: function (result) {
                    alert("Failed to load Month Name");
                }
            });
        }

        function YearDrp(YearID) {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "MonthlyJoinReport.aspx/Getyeardrp",
                data: "{}",
                dataType: "json",
                success: function (data) {
                    $("#drpYear").html("");
                    $("#drpYear").append($("<option></option>").val('0').html('- Select -'));
                    $.each(data.d, function (key, value) {
                        $("#drpYear").append($("<option></option>").val(value.YearValue).html(value.YearValue));
                    });
                    $("#drpYear").val(YearID);
                },
                error: function (result) {
                    alert("Failed to load Year Name");
                }
            });
        }

        function MonthJoinReportList(year, month) {
            $.ajax({

                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "MonthlyJoinReport.aspx/GetMonthJoinReportList",
                data: "{year:'" + year + "',month: '" + month + "'}",
                dataType: "json",
                success: function (data) {
                    formDocument().objEMP().constructor();
                    if ($.fn.dataTable.isDataTable('#basic-btn')) {
                        $('#basic-btn').DataTable().clear().destroy();
                    }
                    ko.mapping.fromJS(data.d, null, formDocument);
                    $('#basic-btn').DataTable({
                        "paging": true,
                        "ordering": false,
                        responsive: true,
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

        function resetlist() {
            MonthDrp(0);
            YearDrp(0);
            $('#spanMonth').text("");
            $('#spanYear').text("");
            MonthJoinReportList(0, 0);
            $('#table').attr('hidden', true);
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
                        <li class="breadcrumb-item active" aria-current="page">Monthly Joining Report</li>
                    </ol>
                </nav>
            </div>
        </div>

        <div class="card" id="table1" style="padding: 10px;">
            <div class="card-body">
                <div class="border p-3 rounded">

                    <div class="form-group row g-3" style="padding-bottom: 10px;">

                        <div class="col-sm-3" style="line-height: 30px;">
                            <label class="form-label">Month <sup><i class="fa fa-asterisk" aria-hidden="true" style="color: red; font-size: 10px !important;"></i></sup></label>
                            <select class="js-example-basic-single" style="width: 100%;" tabindex="-1" aria-hidden="true" id="drpMonth">
                            </select>
                            <span id="spanMonth" style="color: red; font-weight: 400; font-size: 15px;"></span>

                        </div>
                        <div class="col-sm-3" style="line-height: 30px;">
                            <label class="form-label">Year <sup><i class="fa fa-asterisk" aria-hidden="true" style="color: red; font-size: 10px !important;"></i></sup></label>
                            <select class="js-example-basic-single" style="width: 100%;" id="drpYear">
                            </select>
                            <span id="spanYear" style="color: red; font-weight: 400; font-size: 15px;"></span>
                        </div>
                        <div class="col-sm-1" style="line-height: 115px; text-align: center">
                            <button type="button" class="btn btn-primary" onclick="JoinReportFilter()">Submit</button>
                        </div>
                        <div class="col-sm-1" style="line-height: 115px;">
                            <button type="button" class="btn btn-dark" onclick="resetlist()">Reset</button>
                        </div>

                    </div>


                </div>
            </div>
        </div>
        <div class="card" id="table" style="padding: 10px;">
            <div class="card-body">
                <div class="border p-3 rounded">
                    <div class="table-responsive">
                        <table id="basic-btn" class="table table-striped table-bordered" style="width: 100%" data-bind="visible: formDocument().objEMP().length > 0">
                            <thead>
                                <tr role="row">
                                    <th>Employee ID</th>
                                    <th>Employee Name</th>
                                    <th>Role</th>
                                    <th>Department</th>
                                    <th>Designation</th>
                                    <th>Date Of Joining</th>

                                </tr>
                            </thead>
                            <tbody data-bind="foreach: formDocument().objEMP()">
                                <tr>
                                    <td><span data-bind="text: IDCARDNO"></span></td>
                                    <td><span data-bind="text: UserName"></span></td>
                                    <td><span data-bind="text: RoleId"></span></td>
                                    <td><span data-bind="text: Department"></span></td>
                                    <td><span data-bind="text: Designation"></span></td>
                                    <td style="text-align:center"><span data-bind="text: DOJ"></span></td>


                                </tr>
                            </tbody>

                        </table>

                    </div>
                    <input type="hidden" id="userId" value="0">
                </div>
            </div>
        </div>
    </div>

    <!--Knockout Script-->
    <script src="js/knockout-3.5.1.js" type="text/javascript"></script>
    <script src="js/knockout.mapping-latest-2.4.1.js" type="text/javascript"></script>
    <script src="js/knockout.validation-2.0.4.js" type="text/javascript"></script>

    <script type="text/javascript">
        var lstEmployeeObj = function () {

            this.objEMP = ko.observableArray([{
                userId: 0, IDCARDNO: '', UserName: '', RoleId: '', Designation: '', DOJ: '', Department: ''
            }]);
        };
        formDocument = ko.observable(new lstEmployeeObj());
        ko.applyBindings(new lstEmployeeObj());
    </script>
</asp:Content>

