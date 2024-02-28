<%@ Page Title="" Language="C#" MasterPageFile="~/YEEMAKHRMS.master" AutoEventWireup="true" CodeFile="Holiday.aspx.cs" Inherits="Holiday" %>

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

        .modal-body {
            position: relative;
            flex: 1 1 auto;
            padding: 0px !important;
        }
    </style>

    <script type="text/javascript">

        $(document).ready(function () {

            BindHolidayList();



            $("#txtdate").click(function () {
                var checkout = $(this).val();
                if (checkout > 0 || checkout != null || checkout != '') {
                    $("#spantxtdate").text("");

                }

            });

            $("#txtDescription").keyup(function () {
                var txtDescription = $(this).val();
                if (txtDescription != '') {
                    $("#spantxtDescription").text("");

                }
            });

            var maxLength = 500;
            var elaz = document.getElementById('txtDescription');

            $('#txtDescription').keypress(function (event) {
                var Length = $("#txtDescription").val().length;
                var AmountLeft = maxLength - Length;
                $('#txtDescription-length-left').html(AmountLeft);
                if (Length >= maxLength) {
                    if (event.which != 8) {
                        $('#spantxtDescription1').text('Only 500 characters are allowed');

                        return false;
                    }
                } else {
                    $('#spantxtDescription1').text('');
                    elaz.addEventListener('keydown', function (event) {

                        if (event.keyCode == 8) {

                            $('#spantxtDescription1').html('');
                        }

                    });
                }


            });

        });

        var jq = jQuery.noConflict();
        jq(document).ready(function () {
            jq("#txtdate").datepicker({
                dateFormat: "dd/mm/yy",
                changeMonth: true,
                changeYear: false,
                yearRange: '1924:' + (new Date).getFullYear()
            });
        });


        function BindHolidayList() {

            $.ajax({

                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Holiday.aspx/GetHolidayList",
                data: "{}",
                dataType: "json",
                success: function (data) {
                    console.log(data);
                    Holiday_Gs().ObjHoliday_Gs().constructor();
                    if ($.fn.dataTable.isDataTable('#tblholiday')) {
                        $('#tblholiday').DataTable().clear().destroy();
                    }
                    ko.mapping.fromJS(data.d, null, Holiday_Gs);
                    $('#tblholiday').DataTable({
                        "paging": true,
                        "ordering": false,
                        responsive: false,
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

        function BindHolidayEdit(HolidayId) {
            $("#HolidayAppy").modal("show");
            $("#spantxtdate").text('');
            $("#spantxtDescription").text('');
            $("#spantxtDescription1").text('');


            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Holiday.aspx/BindHolidayEdit",
                data: "{HolidayId : " + HolidayId.getAttribute('HolidayId') + "}",
                dataType: "json",
                success: function (data) {
                    if (data.d != null) {
                        $('#HolidayId').val(data.d.HolidayId);
                        $('#txtdate').val(data.d.Holidaydate);
                        $('#txtDescription').val(data.d.Holidaydiscription);

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




        function SaveReq() {
            var isValid = false;
            if (hasValue("#txtdate", "#spantxtdate", "Choose the holiday date") &&
                hasValue("#txtDescription", "#spantxtDescription", "Enter the holiday description"))
                isValid = true;
            if (isValid) {
                var objHoliday = new holidaysave();
                objHoliday.HolidayId = $('#HolidayId').val();
                objHoliday.Holidaydate = $('#txtdate').val().trim();
                objHoliday.Holidaydiscription = $('#txtDescription').val().trim();
                $("#btnSubmit").attr("disabled", true);

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Holiday.aspx/SaveorUpdateholiday",
                    data: "{objHoliday : " + ko.toJSON(objHoliday) + "}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {
                            var inserted = data.d;
                            if (inserted != null) {

                                $("#HolidayAppy").modal("hide");
                                $("#btnSubmit").attr("disabled", false);

                                BindHolidayList();

                                if (inserted == 1) {
                                    new PNotify({
                                        title: 'Registered',
                                        text: 'Saved successfully...',
                                        icon: 'icofont icofont-info-circle',
                                        type: 'success'
                                    });


                                }

                                else if (inserted == 2) {
                                    $("#HolidayAppy").modal("hide");
                                    BindHolidayList();
                                    $("#btnSubmit").attr("disabled", false);



                                    new PNotify({
                                        title: 'Updated',
                                        text: 'Updated successfully...',
                                        icon: 'icofont icofont-info-circle',
                                        type: 'success'
                                    });
                                }

                                else if (inserted == 3) {
                                    $("#HolidayAppy").modal("hide");
                                    BindHolidayList();
                                    $("#btnSubmit").attr("disabled", false);

                                    new PNotify({
                                        title: 'pre-exist',
                                        text: 'Holiday Date already exists...',
                                        icon: 'icofont icofont-info-circle',
                                        type: 'success'
                                    });
                                }

                                else {

                                    $("#HolidayAppy").modal("hide");
                                    $("#btnSubmit").attr("disabled", false);


                                    BindHolidayList();
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

        function DeleteDate(itemI) {

            var iInd = itemI.getAttribute('HolidayId');

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
                            url: "Holiday.aspx/DeleteHoliday",
                            data: "{lReqId : " + iInd + "}",
                            dataType: "json",
                            success: function (data) {
                                if (data.d != "") {
                                    var inserted = data.d;
                                    if (inserted > 0) {

                                        new PNotify({
                                            title: 'Deleted',
                                            text: 'Deleted successfully...',
                                            icon: 'icofont icofont-info-circle',
                                            type: 'warning'
                                        });
                                        BindHolidayList();
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

    </script>


</asp:Content>



<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="page-content">
        <div class="page-breadcrumb d-none d-sm-flex align-items-center mb-3">
            <div class="ps-3">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-0 p-0 align-items-center">
                        <li class="breadcrumb-item">MASTER</li>
                        <li class="breadcrumb-item active" aria-current="page">Holiday</li>
                    </ol>
                </nav>
            </div>
        </div>

        <div class="card">
            <div class="access" style="padding: 20px 10px 10px 10px;">
                <button type="button" class="btn btn-primary" onclick="Holiday()" style="float: right;">Add</button>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table id="tblholiday" class="table table-striped table-bordered" style="width: 100%" data-bind="visible: Holiday_Gs().ObjHoliday_Gs().length> 0">
                        <thead>
                            <tr role="row">
                                <th style="width: 25%">Holiday Date</th>
                                <th style="width: 65%">Holiday Description</th>
                                <th style="width: 10%">Action</th>

                            </tr>
                        </thead>
                        <tbody data-bind="foreach: Holiday_Gs().ObjHoliday_Gs()">
                            <tr>
                                <td style="text-align: center;"><span data-bind="text:Holidaydate"></span></td>
                                <td style=" word-break: break-word; white-space: pre-line; word-wrap: normal;"><span data-bind="text:Holidaydiscription"></span></td>
                                <td style="text-align: center;">
                                    <button type="button" class="btn btn-success" data-bind="attr: {title: '', 'HolidayId': HolidayId}" onclick="BindHolidayEdit(this)"><i class="lni lni-pencil"></i></button>
                                    <button type="button" class="btn btn-danger" data-bind="attr: {title: '', 'HolidayId': HolidayId}" onclick="DeleteDate(this)"><i class="lni lni-trash"></i></button>
                                </td>
                            </tr>
                        </tbody>

                    </table>

                </div>

            </div>
        </div>

        <div class="modal fade" id="HolidayAppy" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content" style="width: 85%;">
                    <div class="modal-header" style="align-content: center;">
                        <h5 class="modal-title" id="exampleModalLabel" style="padding-left: 135px;">Holiday</h5>
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
                                        <input type="text" class="form-control" style="background: #fff !important;" placeholder="dd/mm/yyyy" id="txtdate" autocomplete="off" readonly />
                                        <div class="input-group-addon">
                                            <i class=" fa fa-calendar" aria-hidden="true"></i>
                                        </div>
                                    </div>
                                    <span id="spantxtdate" style="color: red; font-size: 15px"></span></div>
                                    <div class="col-lg-12" style="color: #000 !important; line-height: 35px;">
                                        Description <sup><i class="fa fa-asterisk" aria-hidden="true" style="color: red; font-size: 10px;"></i></sup>

                                        <textarea class="form-control" placeholder="Description" id="txtDescription" autocomplete="off"></textarea>
                                    
                                    <span id="spantxtDescription" style="color: red; font-size: 15px"></span>
                                    <span id="spantxtDescription1" style="color: red; font-size: 15px"></span></div>
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
                        <input type="hidden" id="HolidayId" value="0" />

                    </div>
                </div>
            </div>




        </div>
       
        </div>
        <script>
            function Holiday() {
                $("#HolidayAppy").modal("show");
                $("#HolidayId").val(0);
                $("#txtdate").val('');
                $("#txtDescription").val('');
                $("#spantxtdate").text('');
                $("#spantxtDescription").text('');
                $("#spantxtDescription1").text('');
            }
            function modalCancel() {
                $("#HolidayAppy").modal("hide");
            }
        </script>

        <!--Knockout Script-->
        <script src="js/knockout-3.5.1.js" type="text/javascript"></script>
        <script src="js/knockout.mapping-latest-2.4.1.js" type="text/javascript"></script>
        <script src="js/knockout.validation-2.0.4.js" type="text/javascript"></script>

        <script type="text/javascript"> 
            var Holiday_GsObj = function () {
                var self = this;
                this.ObjHoliday_Gs = ko.observableArray([{
                    HolidayId: 0, Holidaydate: '', Holidaydiscription: ''
                }]);
            };
            Holiday_Gs = ko.observable(new Holiday_GsObj());
            ko.applyBindings(new Holiday_GsObj(), document.getElementById("tblholiday"));
        </script>

        <script>

            var holidaysave = function () {
                var self = this;
                self.HolidayId = ko.observable(0);
                self.Holidaydate = ko.observable('');
                self.Holidaydiscription = ko.observable('');

            };
        </script>
</asp:Content>

