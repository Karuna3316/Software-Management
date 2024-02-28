<%@ Page Title="" Language="C#" MasterPageFile="~/YEEMAKHRMS.master" AutoEventWireup="true" CodeFile="EmployeeList.aspx.cs" Inherits="EmployeeList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="assets/css/calender.css" rel="stylesheet" />
    <script src="assets/js/calender.js"></script>

    <style>
        button:focus {
            outline: none !important;
        }

        th {
            text-align: center;
        }

        .modal-header .btn-close {
            padding: 0.5rem 0.5rem;
            margin: -0.5rem -0.5rem -0.5rem auto;
            color: #000 !important;
        }

        .input-group-prepend {
            height: 34px;
            margin-right: 0px !important;
            padding: 5px;
        }

        .input-group-addon {
            color: #555353;
            padding: 0px 8px;
            background-color: #ccc;
            border: 1px solid;
            border-radius: 4px;
            border-color: #000;
            height: 38px;
        }

        .modal-content {
            position: relative;
            display: flex;
            flex-direction: column;
            width: 85% !important;
            pointer-events: auto;
            background-color: #fff;
            background-clip: padding-box;
            border: 1px solid rgba(0, 0, 0, .2);
            border-radius: 0.3rem;
            outline: 0;
        }

        .modal-body {
            position: relative;
            flex: 1 1 auto;
            padding: 0px !important;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
            var objUrlParams = new URLSearchParams(window.location.search);
            var flagId = objUrlParams.get('flagId');
            if (flagId == 1) {
                new PNotify({
                    title: 'Registered',
                    text: 'Saved successfully...',
                    icon: 'icofont icofont-info-circle',
                    type: 'success'
                });
            }
            else if (flagId == 2) {
                new PNotify({
                    title: 'Updated',
                    text: 'Updated successfully...',
                    icon: 'icofont icofont-info-circle',
                    type: 'success'
                });
            }
            else if (flagId == 3) {
                new PNotify({
                    title: 'pre-exist',
                    text: 'User already exists...',
                    icon: 'icofont icofont-info-circle',
                    type: 'success'
                });
            }

            GetEmployeeList();

            var max1 = 250;
            var elq = document.getElementById('txtReason');

            $('#txtReason').keypress(function (event) {
                var Length = $("#txtReason").val().length;
                var AmountLeft = max1 - Length;
                $('#txtReason-length-left').html(AmountLeft);
                if (Length >= max1) {
                    if (event.which != 8) {
                        $('#spantxtReason1').text('Only 250 characters are allowed');

                        return false;
                    }
                } else {
                    $('#spantxtReason1').text('');
                    elq.addEventListener('keydown', function (event) {
                        // Checking for Backspace.
                        if (event.keyCode == 8) {
                            $('#spantxtReason1').html('');
                        }

                    });
                }


            });

            $("#txtRelievingDate").click(function () {
                var checkout = $(this).val();
                if (checkout > 0 || checkout != null || checkout != '') {
                    $("#spanRelievingDate").text("");

                }

            });

            $("#txtReason").keyup(function () {
                var txtDescription = $(this).val();
                if (txtDescription != '') {
                    $("#spantxtReason").text("");

                }
            });
        });


        var jq = jQuery.noConflict();
        jq(document).ready(function () {
            jq("#txtRelievingDate").datepicker({
                dateFormat: "dd/mm/yy",
                changeMonth: true,
                changeYear: true,
                yearRange: '1924:' + (new Date).getFullYear()

            });
        });

        function GetEmployeeList() {

            $.ajax({

                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "EmployeeList.aspx/GetEmployeeList",
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


        function DeleteEmployee() {

            var isValid = false;
            if (hasValue("#txtRelievingDate", "#spanRelievingDate", "Choose the relieving date ") &&
                hasValue("#txtReason", "#spantxtReason", "Enter the reason"))
                isValid = true;

            if (isValid) {
                var EMPObjt = new EmpDet();
                EMPObjt.userId = $("#userId").val();
                EMPObjt.ReliveingDate = $('#txtRelievingDate').val();
                EMPObjt.Reason = $('#txtReason').val();
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "EmployeeList.aspx/DeleteEmployees",
                    data: "{EMPObjt : " + ko.toJSON(EMPObjt) + "}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {
                            var inserted = data.d;
                            if (inserted != null) {

                                GetEmployeeList();
                                new PNotify({
                                    title: 'Deleted',
                                    text: 'Deleted Successfully...',
                                    icon: 'icofont icofont-info-circle',
                                    type: 'warning'
                                });
                                $("#Dpreveling").modal("hide");
                                $("#txtRelievingDate").val("")
                                $("#txtReason").val("")
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



        function fnRelieving(item) {
            var MRID = item.getAttribute('userId');
            $("#txtRelievingDate").val("");
            $("#txtReason").val("");
            $("#spanRelievingDate").text("");
            $("#spantxtReason").text("");
            $("#spantxtReason1").text("");
            var userId = MRID.title;
            $("#userId").val(MRID);
            $("#Dpreveling").modal("show");
        }

        function Cancel() {
            $("#Dpreveling").modal("hide");
        }


        function EditEmployee(itemI) {

            location.href = "Employee.aspx?userId=" + itemI.getAttribute('userId');

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
            <div class="access" style="float: right; padding: 20px 10px 10px 10px;">
                <button type="button" class="btn btn-primary" onclick="location.href='Employee.aspx'" style="float: right;">Add</button>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table id="basic-btn" class="table table-striped table-bordered" style="width: 100%" data-bind="visible: formDocument().objEMP().length > 0">
                        <thead>
                            <tr role="row">
                                <th>Employee Code</th>
                                <th>Employee Name</th>
                                <th>Employee Type</th>
                                <th>Role</th>
                                <th>Designation</th>
                                <th>Department</th>
                                <th>DOB</th>
                                <th>DOJ</th>
                                <th>Phone No</th>
                                <th>Device Code</th>
                                <th>Action</th>

                            </tr>
                        </thead>
                        <tbody data-bind="foreach: formDocument().objEMP()" id="body">
                            <tr>

                                <td><span data-bind="text: IDCARDNO"></span></td>
                                <td><span data-bind="text: UserName"></span></td>
                                <td><span data-bind="text: Type"></span></td>
                                <td><span data-bind="text: Role"></span></td>
                                <td><span data-bind="text: Designation"></span></td>
                                <td><span data-bind="text: Department"></span></td>
                                <td style="text-align: center;"><span data-bind="text: DOB"></span></td>
                                <td style="text-align: center;"><span data-bind="text: DOJ"></span></td>
                                <td><span data-bind="text: Phone"></span></td>
                                <td><span data-bind="text: Devicecode"></span></td>
                                <td style="text-align: center;">
                                    <button type="button" class="btn btn-success" onclick="EditEmployee(this)" data-bind="attr: { 'userId': userId}"><i class="lni lni-pencil"></i></button>
                                    <button type="button" class="btn btn-danger" onclick="fnRelieving(this)" data-bind="attr: { 'userId': userId}"><i class="lni lni-trash"></i></button>
                                </td>
                            </tr>
                        </tbody>

                    </table>

                </div>

            </div>
        </div>

    </div>
    <div class="modal fade" id="Dpreveling" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content" style="width:85%;">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel" style="padding-left: 125px;">Relieving Date</h5>
                    <button type="button" class="button" data-bs-dismiss="modal" aria-label="Close" onclick="modalCancel()" style="color: #fff !important;">
                        <span aria-hidden="true" style="color: white; text-align: left; font-size: 27px;">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="container p-4">
                        <div class="form-group row">
                            <div class="col-lg-12" style="color: #000 !important; line-height: 35px;">
                                Date <sup><i class="fa fa-asterisk" aria-hidden="true" style="color: red; font-size: 10px;"></i></sup>
                                <div class="input-group" id="datepicker">
                                    <input type="text" id="txtRelievingDate" class="form-control" style="background: #fff; width: 85%; border: 1px solid" placeholder="dd/mm/yyyy" name="start" autocomplete="off" readonly>
                                    <div class="input-group-addon">
                                        <i class=" fa fa-calendar" aria-hidden="true"></i>
                                    </div>
                                </div>
                            </div>
                            <span id="spanRelievingDate" style="color: red; font-size: 15px"></span>

                        </div>

                        <div class="form-group row">
                            <div class="col-lg-12" style="color: #000 !important; line-height: 35px;">
                                Reason   <sup><i class="fa fa-asterisk" aria-hidden="true" style="color: red; font-size: 10px;"></i></sup>
                                <textarea id="txtReason" class="form-control" style="border-radius: 0px; border: 1px solid #000;" placeholder="Reason" maxlength="250"></textarea>
                            </div>
                            <span id="spantxtReason" style="color: red; font-size: 15px"></span>
                            <span id="spantxtReason1" style="color: red; font-size: 15px"></span>

                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="col-lg-12" style="margin-top: -10px;">
                        <center>
                            <button type="button" class="btn btn-primary" onclick="DeleteEmployee()">Submit</button>
                            <button type="button" class="btn btn-dark" data-bs-dismiss="modal" onclick="Cancel();">Cancel</button>
                        </center>
                    </div>
                </div>
                <input type="hidden" id="userId" value="0">
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
                userId: 0, IDCARDNO: '', Type: '', UserName: '', Designation: '', Department: '', DOB: '', DOJ: '', Phone: '', Devicecode: '', Role:''
            }]);
        };
        formDocument = ko.observable(new lstEmployeeObj());
        ko.applyBindings(new lstEmployeeObj(), document.getElementById("basic-btn"));

        var EmpDet = function () {
            var self = this;
            self.userId = ko.observable(0);
            self.ReliveingDate = ko.observable('');
            self.Reason = ko.observable('');
        };
    </script>

</asp:Content>

