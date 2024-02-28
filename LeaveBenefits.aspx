<%@ Page Title="" Language="C#" MasterPageFile="~/YEEMAKHRMS.master" AutoEventWireup="true" CodeFile="LeaveBenefits.aspx.cs" Inherits="LeaveBenefits" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
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
            LeaveBenefitList();

            $('.js-example-basic-single').select2();

            $("#drp_emp").change(function () {

                var feCount = $("#drp_emp").val();


                if (feCount != '0' && feCount != '') {
                    $("#txtdate").val('');
                    $("#txtcasualLeaves").val('');
                    $("#txtSickLeaves").val('');
                    $("#txtearnedleave").val('');
                    BindLeavebenefit(feCount);
                }
                else {
                    $("#txtdate").val('');
                    $("#txtcasualLeaves").val('');
                    $("#txtSickLeaves").val('');
                    $("#txtearnedleave").val('');
                }

            });


            $("#drp_emp").change(function () {
                var EmployeeName = $(this).val();
                if (EmployeeName >= 0) {
                    $("#spandrpemployee").text("");

                }

            });

            $('#LeaveBenefitsL').on('shown.bs.modal', function () {
                $('.js-example-basic-single').select2({
                    dropdownParent: $('#LeaveBenefitsL') // Make sure Select2 is aware of the modal
                });
            });

        });


        function LeaveBenefitList() {

            $.ajax({

                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "LeaveBenefits.aspx/getleavebenefitlist",
                data: "{}",
                dataType: "json",
                success: function (data) {

                    LeaveBenefit_App().LeaveBft().constructor();
                    if ($.fn.dataTable.isDataTable('#Leavebenefit')) {
                        $('#Leavebenefit').DataTable().clear().destroy();
                    }
                    ko.mapping.fromJS(data.d, null, LeaveBenefit_App);
                    $('#Leavebenefit').DataTable({
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

        function Employee_Drp(userId) {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "LeaveBenefits.aspx/GetLeaveBenefitDropdown",
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


        function BindLeavebenefit(DOJ) {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "LeaveBenefits.aspx/Bindleavebenefit",
                data: "{DOJ : " + DOJ + "}",
                dataType: "json",
                success: function (data) {
                    if (data.d != null) {
                        if (data.d.drpDateofJoin) {

                            $("#txtdate").val(data.d.drpDateofJoin);
                            $("#txtcasualLeaves").val(data.d.CasualLeave);
                            $("#txtSickLeaves").val(data.d.SickLeave);
                            $("#txtearnedleave").val(data.d.ElDate);

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
            var isValid = false;
            if
                (hasddlValue("#drp_emp", "#spandrpemployee", "Select employee name"))
                isValid = true;

            if (isValid) {
                var objleave = new leavebenefitlist();
                objleave.LBID = $('#LBID').val();
                objleave.EmployeeName = $('#drp_emp').val();
                objleave.DOJ = $('#txtdate').val();
                objleave.CasualLeave = $('#txtcasualLeaves').val();
                objleave.SickLeave = $('#txtSickLeaves').val();
                objleave.ElDate = $('#txtearnedleave').val();
                $("#btnSubmit").attr("disabled", true);
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "LeaveBenefits.aspx/SaveorupdateLeaveBenefit",
                    data: "{objleave : " + ko.toJSON(objleave) + "}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {
                            var inserted = data.d;
                            if (inserted != null) {

                                $("#LeaveBenefitsL").modal("hide");
                                $("#btnSubmit").attr("disabled", false);

                                LeaveBenefitList();

                                if (inserted == 1) {
                                    new PNotify({
                                        title: 'Registered',
                                        text: 'Saved successfully...',
                                        icon: 'icofont icofont-info-circle',
                                        type: 'success'
                                    });


                                }

                                else if (inserted == 2) {
                                    $("#LeaveBenefitsL").modal("hide");
                                    LeaveBenefitList();
                                    $("#btnSubmit").attr("disabled", false);
                                    new PNotify({
                                        title: 'Updated',
                                        text: 'Updated successfully...',
                                        icon: 'icofont icofont-info-circle',
                                        type: 'success'
                                    });
                                }

                                else if (inserted == 3) {
                                    $("#LeaveBenefitsL").modal("hide");
                                    LeaveBenefitList();
                                    $("#btnSubmit").attr("disabled", false);
                                    new PNotify({
                                        title: 'pre-exist',
                                        text: 'Employee already exists...',
                                        icon: 'icofont icofont-info-circle',
                                        type: 'success'
                                    });
                                }

                                else {

                                    $("#LeaveBenefitsL").modal("hide");
                                    $("#btnSubmit").attr("disabled", false);
                                    LeaveBenefitList();
                                }


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
            }
            return isValid;
        }


        function DeleteDate(itemI) {

            var iInd = itemI.getAttribute('LBID');
            swal({
                title: "Are you sure?",
                text: "You will not be able to recover again!",
                type: "warning",
                showCancelButton: true,
                confirmButtonClass: "btn-danger",
                confirmButtonText: "Yes",
                cancelButtonText: "No",
                closeOnConfirm: false,
                closeOnCancel: false
            },
                function (isConfirm) {
                    if (isConfirm) {


                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "LeaveBenefits.aspx/Deleteleavebenefit",
                            data: "{lReqId : " + iInd + "}",
                            dataType: "json",
                            success: function (data) {
                                if (data.d != "") {
                                    var inserted = data.d;
                                    if (inserted > 0) {

                                        new PNotify({
                                            title: 'Deleted',
                                            text: 'Deleted successfully',
                                            icon: 'icofont icofont-info-circle',
                                            type: 'warning'
                                        });
                                        LeaveBenefitList();


                                        swal.close();
                                    }
                                    else
                                        alert('pls verify');
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
                        swal.close();
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
                        <li class="breadcrumb-item">MASTER</li>
                        <li class="breadcrumb-item active" aria-current="page">Leave Benefits</li>
                    </ol>
                </nav>
            </div>
        </div>

        <div class="card">
            <div class="access" style="padding: 20px 10px 10px 10px;">
                <button type="button" class="btn btn-primary" onclick="LeaveBenefit()" style="float: right;">Add</button>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table id="Leavebenefit" class="table table-striped table-bordered" style="width: 100%" data_bind="visible: LeaveBenefit_App().LeaveBft().length> 0 ">
                        <thead>
                            <tr role="row">
                                <th>Employee Name</th>
                                <th>DOJ</th>
                                <th>Causal Leave</th>
                                <th>Sick Leave</th>
                                <th>Earned Leave Date</th>
                                <th>Action</th>

                            </tr>
                        </thead>
                        <tbody data-bind="foreach:LeaveBenefit_App().LeaveBft()">
                            <tr>
                                <td><span data-bind="text:EmployeeName"></span></td>
                                <td style="text-align: center;"><span data-bind="text:DOJ"></span></td>
                                <td style="text-align: right;"><span data-bind="text:CasualLeave"></span></td>
                                <td style="text-align: right;"><span data-bind="text:SickLeave"></span></td>
                                <td style="text-align: center;"><span data-bind="text:ElDate"></span></td>
                                <td style="text-align: center;">
                                    <button type="button" class="btn btn-danger" onclick="DeleteDate(this)" data-bind="attr: {title: '', 'LBID': LBID}"><i class="lni lni-trash"></i></button>
                                </td>
                            </tr>
                        </tbody>

                    </table>

                </div>
            </div>
        </div>

        <div class="modal fade" id="LeaveBenefitsL" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content" style="width: 85%;">
                    <div class="modal-header" style="align-content: center;">
                        <h5 class="modal-title" id="exampleModalLabel" style="padding-left: 120px;">Leave Benefits</h5>
                        <button type="button" class="button" data-bs-dismiss="modal" aria-label="Close" onclick="modalCancel()" style="color: #fff !important;">
                            <span aria-hidden="true" style="color: white; text-align: left; font-size: 27px;">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="container p-4">
                            <div class="form-group row">
                                <div class="col-lg-12" style="color: #000 !important; line-height: 35px;">
                                    Employee Name  <sup><i class="fa fa-asterisk" aria-hidden="true" style="color: red; font-size: 10px;"></i></sup>
                                    <select class="js-example-basic-single" id="drp_emp">
                                    </select><span id="spandrpemployee" style="color: red; font-size: 15px"></span>
                                </div>
                                <div class="col-lg-12" style="color: #000 !important; line-height: 35px;">
                                    Date Of Joining
                                  <input type="text" class="form-control" placeholder="dd/mm/yyyy" id="txtdate" disabled />
                                </div>
                                <div class="col-lg-12" style="color: #000 !important; line-height: 35px;">
                                    Causal Leave
                                    <input type="text" class="form-control" id="txtcasualLeaves" placeholder="Causal Leave" autocomplete="off" disabled>
                                </div>
                                <div class="col-lg-12" style="color: #000 !important; line-height: 35px;">
                                    Sick Leave
                                    <input type="text" class="form-control" id="txtSickLeaves" placeholder="Sick Leave" autocomplete="off" disabled>
                                </div>
                                <div class="col-lg-12" style="color: #000 !important; line-height: 35px;">
                                    Earned Leave Date
                                    <input type="text" class="form-control" id="txtearnedleave" placeholder="dd/mm/yyyy" disabled>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <div class="col-lg-12" style="margin-top: -10px;">
                            <center>
                                <button type="button" class="btn btn-primary" id="btnSubmit" onclick="SaveReq();">Submit</button>
                                <button type="button" class="btn btn-dark" data-bs-dismiss="modal">Cancel</button>
                            </center>
                        </div>
                    </div>
                    <input type="hidden" id="LBID" value="0" />

                </div>
            </div>
        </div>
    </div>

    <script>
        function LeaveBenefit() {
            $("#LeaveBenefitsL").modal("show");
            $("#LBID").val(0);
            $("#drp_emp").val('');
            $("#txtdate").val('');
            $("#txtcasualLeaves").val('');
            $("#txtSickLeaves").val('');
            $("#txtearnedleave").val('');
            $("#spandrpemployee").text('');
            Employee_Drp(0);
        }
        function modalCancel() {
            $("#LeaveBenefitsL").modal("hide");
        }
    </script>

    <!--Knockout Script-->
    <script src="js/knockout-3.5.1.js" type="text/javascript"></script>
    <script src="js/knockout.mapping-latest-2.4.1.js" type="text/javascript"></script>
    <script src="js/knockout.validation-2.0.4.js" type="text/javascript"></script>

    <script type="text/javascript"> 
        var LeaveBenefit_obj = function () {
            var self = this;


            this.LeaveBft = ko.observableArray([{
                LBID: 0, EmployeeName: '', DOJ: '', CasualLeave: '', SickLeave: '', ElDate: ''
            }]);
        };
        LeaveBenefit_App = ko.observable(new LeaveBenefit_obj());
        ko.applyBindings(new LeaveBenefit_obj(), document.getElementById("Leavebenefit"));
    </script>

    <script type="text/javascript">
        var leavebenefitlist = function () {
            var self = this;
            self.LBID = ko.observable(0);
            self.EmployeeName = ko.observable('');
            self.DOJ = ko.observable('');
            self.CasualLeave = ko.observable('');
            self.SickLeave = ko.observable('');
            self.ElDate = ko.observable('');


        };

    </script>
</asp:Content>

