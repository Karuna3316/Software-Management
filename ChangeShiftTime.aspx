<%@ Page Title="" Language="C#" MasterPageFile="~/YEEMAKHRMS.master" AutoEventWireup="true" CodeFile="ChangeShiftTime.aspx.cs" Inherits="ChangeShiftTime" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="assets/css/calender.css" rel="stylesheet" />
    <script src="assets/js/calender.js"></script>
    <style>
        button:focus {
            outline: none !important;
            background: none;
        }

        th {
            text-align: center;
        }

        .select2-container {
            min-width: 100% !important;
            width: auto !important;
            z-index: 9999 !important;
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
    </style>

    <script>
        $(document).ready(function () {
            GetChangeshifttimeList();

            $("#drpshifttype").change(function () {

                var feCount = $("#drpshifttype").val();

                if (feCount != '0' && feCount != '') {
                    Bindshifttime(feCount);
                }
                else {
                    $("#txttime").val('');
                }

            });

            $("#drpemployee").change(function () {
                var drpemployee = $(this).val();
                if (drpemployee > 0) {
                    $("#spandrpemployee").text("");

                }

            });

            $("#drpshifttype").change(function () {
                var drpshifttype = $(this).val();
                if (drpshifttype > 0) {
                    $("#spandrpshifttype").text("");

                }

            });

            $("#txttime").keyup(function () {
                var txttime = $(this).val();
                if (txttime != '') {
                    $("#spantxttime").text("");

                }
            });

            $("#txtdate").click(function () {
                var checkout = $(this).val();
                if (checkout > 0 || checkout != null || checkout != '') {
                    $("#spantxtdate").text("");

                }

            });

            $('#CShifttime').on('shown.bs.modal', function () {
                $('.js-example-basic-single').select2({
                    dropdownParent: $('#CShifttime') // Make sure Select2 is aware of the modal
                });
            });

        });

        var jq = jQuery.noConflict();
        jq(document).ready(function () {
            jq("#txtdate").datepicker({
                dateFormat: "dd/mm/yy",
                changeMonth: false,
                changeYear: false,
                yearRange: '1924:' + (new Date).getFullYear()
            });
        });

        function GetChangeshifttimeList() {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "ChangeShiftTime.aspx/GetChangeshifttimeList",
                data: "{}",
                dataType: "json",
                success: function (data) {

                    Changeshifttime_Gs().ObjChangeshifttime_Gs().constructor();
                    if ($.fn.dataTable.isDataTable('#tblchangeshifttime')) {
                        $('#tblchangeshifttime').DataTable().clear().destroy();
                    }
                    ko.mapping.fromJS(data.d, null, Changeshifttime_Gs);
                    $('#tblchangeshifttime').DataTable({
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

        function BindEmployeeName(Ename) {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "ChangeShiftTime.aspx/BindEmployeeName",
                data: "{}",
                dataType: "json",
                success: function (data) {
                    $("#drpemployee").html("");
                    $("#drpemployee").append($("<option></option>").val('0').html('- Select -'));
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


        function BindShifttype(Sname) {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "ChangeShiftTime.aspx/BindShifttype",
                data: "{}",
                dataType: "json",
                success: function (data) {
                    $("#drpshifttype").html("");
                    $("#drpshifttype").append($("<option></option>").val('0').html('- Select -'));
                    $.each(data.d, function (key, value) {
                        $("#drpshifttype").append($("<option></option>").val(value.SId).html(value.SName));
                    });
                    $("#drpshifttype").val(Sname);
                },
                error: function (result) {
                    alert("Failed to load Shift Type");
                }
            });
        }


        function Bindshifttime(Timeid) {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "ChangeShiftTime.aspx/BindShifttime",
                data: "{Timeid : " + Timeid + "}",
                dataType: "json",
                success: function (data) {
                    if (data.d != null) {
                        if (data.d.drpshifttime) {

                            $("#txttime").val(data.d.drpshifttime);


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

        function BindChangeshifttimeEdit(shiftchangeid) {
            $("#CShifttime").modal("show");
            $("#drpemployee").val('');
            $("#drpshifttype").val('');
            $("#txttime").val('');
            $("#txtdate").val('');
            $("#spandrpemployee").text('');
            $("#spandrpshifttype").text('');
            $("#spantxttime").text('');
            $("#spantxtdate").text('');
            $("#drpemployee").attr("disabled", true);
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "ChangeShiftTime.aspx/BindChangeshifttimeEdit",
                data: "{shiftchangeid : " + shiftchangeid.getAttribute('shiftchangeid') + "}",
                dataType: "json",
                success: function (data) {

                    if (data.d != null) {

                        $('#shiftchangeid').val(data.d.shiftchangeid);
                        $('#txttime').val(data.d.Shifttime);
                        $('#txtdate').val(data.d.changedate);


                        BindEmployeeName(data.d.Semployee);
                        BindShifttype(data.d.Shifttype);

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

        function SaveReqP() {

            var isValid = false;
            if
                (hasddlValue("#drpemployee", "#spandrpemployee", "Select employee name") &&
                hasddlValue("#drpshifttype", "#spandrpshifttype", "Select shift type") &&
                hasValue("#txttime", "#spantxttime", "Enter the time") &&
                hasValue("#txtdate", "#spantxtdate", "Choose the date"))
                isValid = true;

            if (isValid) {
                var Sfobj = new changeshifttimesave();
                Sfobj.shiftchangeid = $('#shiftchangeid').val();
                Sfobj.Semployee = $('#drpemployee').val();
                Sfobj.Shifttype = $('#drpshifttype').val();
                Sfobj.Shifttime = $('#txttime').val();
                Sfobj.changedate = $('#txtdate').val();
                $("#btnSubmit").attr("disabled", true);
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "ChangeShiftTime.aspx/SaveorUpdateShifttime",
                    data: "{Sfobj : " + ko.toJSON(Sfobj) + "}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {
                            var inserted = data.d;
                            if (inserted != null) {

                                $("#CShifttime").modal("hide");
                                $("#btnSubmit").attr("disabled", false);

                                GetChangeshifttimeList();

                                if (inserted == 1) {
                                    new PNotify({
                                        title: 'Registered',
                                        text: 'Saved successfully...',
                                        icon: 'icofont icofont-info-circle',
                                        type: 'success'
                                    });


                                }

                                else if (inserted == 2) {
                                    $("#CShifttime").modal("hide");
                                    GetChangeshifttimeList();
                                    $("#btnSubmit").attr("disabled", false);
                                    new PNotify({
                                        title: 'Updated',
                                        text: 'Updated successfully...',
                                        icon: 'icofont icofont-info-circle',
                                        type: 'success'
                                    });
                                }

                                else if (inserted == 3) {
                                    $("#CShifttime").modal("hide");
                                    GetChangeshifttimeList();
                                    $("#btnSubmit").attr("disabled", false);
                                    new PNotify({
                                        title: 'pre-exist',
                                        text: 'It already exists...',
                                        icon: 'icofont icofont-info-circle',
                                        type: 'success'
                                    });
                                }

                                else {

                                    $("#CShifttime").modal("hide");
                                    $("#btnSubmit").attr("disabled", false);
                                    GetChangeshifttimeList();
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

        function DeleteDateP(itemI) {
            var iInd = itemI.getAttribute('shiftchangeid');
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
                            url: "ChangeShiftTime.aspx/DeleteChangeshifttime",
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
                                        GetChangeshifttimeList();


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
                        <li class="breadcrumb-item active" aria-current="page">Shift Time Change</li>
                    </ol>
                </nav>
            </div>
        </div>

        <div class="card">
            <div class="access" style="padding: 20px 10px 10px 10px;">
                <button type="button" class="btn btn-primary" onclick="ShifttimeC()" style="float: right;">Add</button>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table id="tblchangeshifttime" class="table table-striped table-bordered" style="width: 100%" data-bind="visible: Changeshifttime_Gs().ObjChangeshifttime_Gs().length > 0">
                        <thead>
                            <tr role="row">
                                <th>Employee Name</th>
                                <th>Shift Type</th>
                                <th>Shift Time</th>
                                <th>Date</th>
                                <th style="width: 10%;">Action</th>

                            </tr>
                        </thead>
                        <tbody data-bind="foreach: Changeshifttime_Gs().ObjChangeshifttime_Gs()">
                            <tr>

                                <td><span data-bind="text: Semployee"></span></td>
                                <td><span data-bind="text: Shifttype"></span></td>
                                <td><span data-bind="text: Shifttime"></span></td>
                                <td><span data-bind="text: changedate"></span></td>
                                <td style="text-align: center;">
                                    <button type="button" class="btn btn-success" onclick="BindChangeshifttimeEdit(this)" data-bind="attr: {title: '', 'shiftchangeid': shiftchangeid}"><i class="lni lni-pencil"></i></button>
                                    <button type="button" class="btn btn-danger" onclick="DeleteDateP(this)" data-bind="attr: {title: '', 'shiftchangeid': shiftchangeid}"><i class="lni lni-trash"></i></button>
                                </td>
                            </tr>
                        </tbody>

                    </table>

                </div>

            </div>
        </div>

        <div class="modal fade" id="CShifttime" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content" style="width: 85%;">
                    <div class="modal-header" style="align-content: center;">
                        <h5 class="modal-title" id="exampleModalLabel" style="padding-left: 120px;">Change Shift Time</h5>
                        <button type="button" class="button" data-bs-dismiss="modal" aria-label="Close" onclick="modalCancel()" style="color: #fff !important;">
                            <span aria-hidden="true" style="color: white; text-align: left; font-size: 27px;">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="container p-4">
                            <div class="form-group row">
                                <div class="col-lg-12" style="color: #000 !important; line-height: 35px;">
                                    Employee Name  <sup><i class="fa fa-asterisk" aria-hidden="true" style="color: red; font-size: 10px;"></i></sup>
                                    <select class="js-example-basic-single" id="drpemployee">
                                    </select><span id="spandrpemployee" style="color: red; font-size: 15px"></span>
                                </div>
                                <div class="col-lg-12" style="color: #000 !important; line-height: 35px;">
                                    Shift Type <sup><i class="fa fa-asterisk" aria-hidden="true" style="color: red; font-size: 10px;"></i></sup>

                                    <select class="js-example-basic-single" id="drpshifttype">
                                    </select><span id="spandrpshifttype" style="color: red; font-size: 15px"></span>
                                </div>
                                <div class="col-lg-12" style="color: #000 !important; line-height: 35px;">
                                    Shift Time <sup><i class="fa fa-asterisk" aria-hidden="true" style="color: red; font-size: 10px;"></i></sup>

                                    <input type="text" class="form-control" id="txttime" autocomplete="off" placeholder="Shift Time" disabled><span id="spantxttime" style="color: red; font-size: 15px"></span>
                                </div>
                                <div class="col-lg-12" style="color: #000 !important; line-height: 35px;">
                                    Date <sup><i class="fa fa-asterisk" aria-hidden="true" style="color: red; font-size: 10px;"></i></sup>
                                   
                                    <div class="input-group" id="datepicker">
                                         <input type="text" class="form-control" id="txtdate" autocomplete="off" placeholder="dd/mm/yyyy" style="background: #fff !important;" readonly >
                                        <div class="input-group-addon">
                                            <i class=" fa fa-calendar" aria-hidden="true"></i>
                                        </div>
                                    </div><span id="spantxtdate" style="color: red; font-size: 15px"></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <div class="col-lg-12" style="margin-top: -10px;">
                            <center>
                                <button type="button" class="btn btn-primary" id="btnSubmit" onclick="SaveReqP();">Submit</button>
                                <button type="button" class="btn btn-dark" data-bs-dismiss="modal">Cancel</button>
                            </center>
                        </div>
                    </div>
                    <input type="hidden" id="shiftchangeid" value="0" />

                </div>
            </div>
        </div>

    </div>

    <script>
        function ShifttimeC() {
            $("#CShifttime").modal("show");
            $("#shiftchangeid").val(0);
            $("#drpemployee").val('');
            $("#drpshifttype").val('');
            $("#txttime").val('');
            $("#txtdate").val('');
            $("#spandrpemployee").text('');
            $("#spandrpshifttype").text('');
            $("#spantxttime").text('');
            $("#spantxtdate").text('');
            BindEmployeeName(0);
            BindShifttype(0);
            $("#drpemployee").attr("disabled", false);
        }
        function modalCancel() {
            $("#CShifttime").modal("hide");
        }
    </script>

    <!--Knockout Script-->
    <script src="js/knockout-3.5.1.js" type="text/javascript"></script>
    <script src="js/knockout.mapping-latest-2.4.1.js" type="text/javascript"></script>
    <script src="js/knockout.validation-2.0.4.js" type="text/javascript"></script>

    <script type="text/javascript">
        var Changeshifttime_GsObj = function () {
            var self = this;
            this.ObjChangeshifttime_Gs = ko.observableArray([{
                shiftchangeid: 0, Semployee: '', Shifttype: '', Shifttime: '', changedate: ''

            }]);
        };
        Changeshifttime_Gs = ko.observable(new Changeshifttime_GsObj());
        ko.applyBindings(new Changeshifttime_GsObj(), document.getElementById("tblchangeshifttime"));

    </script>

    <script type="text/javascript">
        var changeshifttimesave = function () {
            var self = this;
            self.shiftchangeid = ko.observable(0);
            self.Semployee = ko.observable('');
            self.Shifttype = ko.observable('');
            self.Shifttime = ko.observable('');
            self.changedate = ko.observable('');
        };

    </script>
</asp:Content>

