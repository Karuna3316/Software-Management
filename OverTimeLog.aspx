<%@ Page Title="" Language="C#" MasterPageFile="~/YEEMAKHRMS.master" AutoEventWireup="true" CodeFile="OverTimeLog.aspx.cs" Inherits="OverTimeLog" %>

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
    <script>
        $(document).ready(function () {
            $('.js-example-basic-single').select2();
            MonthDrp(0);
            YearDrp(0);
            $('#table1').attr('hidden', true);

            OverTimeLogList(0, 0);

            $("#drpmon").change(function () {
                var fD = $(this).val();
                if (fD >= 0) {
                    $("#lblFr").text("");
                } else {
                    $("#lblFr").text(fD);
                }
            });

            $("#drpyr").change(function () {
                var fD = $(this).val();
                if (fD >= 0) {
                    $("#lblE").text("");
                } else {
                    $("#lblE").text(fD);
                }
            });



        });

        function chkFrDates() {
            var isV = true;
            var fD = $('#drpmon');
            var eD = $('#drpyr');

            if (fD.val() == "0" && eD.val() == "0") {
                $('#lblFr')[0].innerText = "Select Month";
                $('#table1').attr('hidden', true);
            }
            else if (fD.val() == "0" && eD.val() != "0") {
                $('#lblFr')[0].innerText = "Select Month";
                $('#table1').attr('hidden', true);
            }
            else {
                $('#lblFr')[0].innerText = "";
            }
            if (fD.val() != "0" && eD.val() == "0") {
                $('#lblE')[0].innerText = "Select Year";
                $('#table1').attr('hidden', true);
            }
            else {
                $('#lblE')[0].innerText = "";
            }

            if ((fD.val() != "0" && eD.val() != "0")) {
                OverTimeLogList(fD.val(), eD.val());
                $('#table1').attr('hidden', false);
            } else {
                $('#table1').attr('hidden', true);
                isV = false;
                return isV;
            }
        }


        function MonthDrp(DMId) {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "OverTimeLog.aspx/Getmonthdrp",
                data: "{}",
                dataType: "json",
                success: function (data) {
                    $("#drpmon").html("");
                    $("#drpmon").append($("<option></option>").val('0').html('- Select -'));
                    $.each(data.d, function (key, value) {
                        $("#drpmon").append($("<option></option>").val(value.DMId).html(value.Month));
                    });
                    $("#drpmon").val(DMId);
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
                url: "OverTimeLog.aspx/Getyeardrp",
                data: "{}",
                dataType: "json",
                success: function (data) {
                    $("#drpyr").html("");
                    $("#drpyr").append($("<option></option>").val('0').html('- Select -'));
                    $.each(data.d, function (key, value) {
                        $("#drpyr").append($("<option></option>").val(value.YearValue).html(value.YearValue));
                    });
                    $("#drpyr").val(YearID);
                },
                error: function (result) {
                    alert("Failed to load Year Name");
                }
            });
        }

        function OverTimeLogList(Month, Year) {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "OverTimeLog.aspx/getOvertimeloglist",
                data: "{Month:'" + Month + "',Year: '" + Year + "'}",
                dataType: "json",
                success: function (data) {
                    formDocument().lstOverTimelog().constructor();
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
            OverTimeLogList(0, 0);
            $("#lblFr").text("");
            $("#lblE").text("");
            $('#table1').attr('hidden', true);
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
                        <li class="breadcrumb-item active" aria-current="page">Overtime Log</li>
                    </ol>
                </nav>
            </div>
        </div>

        <div class="card" style="padding: 10px;">
            <div class="card-body">
                <div class="border p-3 rounded">

                    <div class="form-group row g-3" style="padding-bottom: 10px;">

                        <div class="col-sm-3" style="line-height: 30px;">
                            <label class="form-label">Month <sup><i class="fa fa-asterisk" aria-hidden="true" style="color: red; font-size: 10px !important;"></i></sup></label>
                            <select id="drpmon" class="js-example-basic-single" style="width: 100%;">
                            </select><span id="lblFr" style="color: red; font-size: 15px"></span>
                        </div>
                        <div class="col-sm-3" style="line-height: 30px;">
                            <label class="form-label">Year <sup><i class="fa fa-asterisk" aria-hidden="true" style="color: red; font-size: 10px !important;"></i></sup></label>
                            <select id="drpyr" class="js-example-basic-single" style="width: 100%;">
                            </select><span id="lblE" style="color: red; font-size: 15px"></span>
                        </div>
                        <div class="col-sm-1" style="line-height: 115px;text-align: center">
                            <button type="button" class="btn btn-primary" onclick="chkFrDates();">Submit</button>
                        </div>
                        <div class="col-sm-1" style="line-height: 115px;">
                            <button type="button" class="btn btn-dark" onclick="resetlist();">Reset</button>
                        </div>

                    </div>


                </div>
            </div>
        </div>
        <div class="card" style="padding: 10px;" id="table1">
            <div class="card-body">
                <div class="border p-3 rounded">
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered" style="width: 100%" id="basic-btn" data-bind="visible: formDocument().lstOverTimelog().length > 0">
                            <thead>
                                <tr role="row">
                                    <th>Employee ID</th>
                                    <th>Employee Name</th>
                                    <th>Overtime (Hours) </th>

                                </tr>
                            </thead>
                            <tbody data-bind="foreach: formDocument().lstOverTimelog()">
                                <tr>
                                    <td><span data-bind="text: EmployeeID"></span></td>
                                    <td><span data-bind="text: EmployeeName"></span></td>
                                    <td style="text-align: center;"><span data-bind="text: TotalExtraMinutes"></span></td>


                                </tr>
                            </tbody>

                        </table>

                    </div>
                    <input type="hidden" id="AttendanceID" value="0">
                </div>
            </div>
        </div>
    </div>

    <!--Knockout Script-->
    <script src="js/knockout-3.5.1.js" type="text/javascript"></script>
    <script src="js/knockout.mapping-latest-2.4.1.js" type="text/javascript"></script>
    <script src="js/knockout.validation-2.0.4.js" type="text/javascript"></script>

    <script type="text/javascript">
        var OverTimeLogObj = function () {

            this.lstOverTimelog = ko.observableArray([{
                EmployeeID: '', EmployeeName: '', TotalExtraMinutes: ''
            }]);
        };
        formDocument = ko.observable(new OverTimeLogObj());
        ko.applyBindings(new OverTimeLogObj(), document.getElementById("basic-btn"));
    </script>

</asp:Content>

