<%@ Page Title="" Language="C#" MasterPageFile="~/YEEMAKHRMS.master" AutoEventWireup="true" CodeFile="Designation.aspx.cs" Inherits="Designation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        button:focus {
            outline: none !important;
            background: none;
        }

        th {
            text-align: center;
        }

        .modal-body {
            position: relative;
            flex: 1 1 auto;
            padding: 0px !important;
        }
    </style>

    <script type="text/javascript">
        $(document).ready(function () {
            BinDesignation();
            modalCancel(0);

            $("#txtDesignation").keyup(function () {
                var txtDesignation = $(this).val();
                if (txtDesignation != '') {
                    $("#spanDesignation").text("");

                }
            });

            var maxLength = 50;
            var elaz = document.getElementById('txtDesignation');

            $('#txtDesignation').keypress(function (event) {
                var Length = $("#txtDesignation").val().length;
                var AmountLeft = maxLength - Length;
                $('#txtDesignation-length-left').html(AmountLeft);
                if (Length >= maxLength) {
                    if (event.which != 8) {
                        $('#spanDesignation1').text('Only 50 characters are allowed');

                        return false;
                    }
                } else {
                    $('#spanDesignation1').text('');
                    elaz.addEventListener('keydown', function (event) {

                        if (event.keyCode == 8) {

                            $('#spanDesignation1').html('');
                        }

                    });
                }


            });


        });

        function BinDesignation() {
            $.ajax({

                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Designation.aspx/GetDesignationList",
                data: "{}",
                dataType: "json",
                success: function (data) {

                    formDocument().DesignationBindObj().constructor();
                    if ($.fn.dataTable.isDataTable('#smarttable')) {
                        $('#smarttable').DataTable().clear().destroy();
                    }
                    ko.mapping.fromJS(data.d, null, formDocument);
                    $('#smarttable').DataTable({
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

        function SaveReq() {

            var isValid = false;
            if (hasValue("#txtDesignation", "#spanDesignation", "Enter the Designation"))
                isValid = true;
            if (isValid) {
                var objDesig = new Designationlist();
                objDesig.DesignationId = $('#DesignationId').val();
                objDesig.Designation = $('#txtDesignation').val().trim();
                $("#btnSubmit").attr("disabled", true);
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Designation.aspx/SaveorUpdateDesignation",
                    data: "{objDesig : " + ko.toJSON(objDesig) + "}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {
                            var inserted = data.d;
                            if (inserted != null) {

                                $("#DesignationApply").modal("hide");

                                $("#btnSubmit").attr("disabled", false);

                                BinDesignation();

                                if (inserted == 1) {
                                    new PNotify({
                                        title: 'Registered',
                                        text: 'Saved successfully...',
                                        icon: 'icofont icofont-info-circle',
                                        type: 'success'
                                    });


                                }

                                else if (inserted == 2) {
                                    $("#DesignationApply").modal("hide");
                                    BinDesignation();
                                    new PNotify({
                                        title: 'Updated',
                                        text: 'Updated successfully...',
                                        icon: 'icofont icofont-info-circle',
                                        type: 'success'
                                    });
                                }

                                else if (inserted == 3) {
                                    $("#DesignationApply").modal("hide");
                                    BinDesignation();
                                    new PNotify({
                                        title: 'pre-exist',
                                        text: 'Designation already exists...',
                                        icon: 'icofont icofont-info-circle',
                                        type: 'success'
                                    });
                                }

                                else {

                                    $("#DesignationApply").modal("hide");

                                    BinDesignation();
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


        function BindDesignationEdit(DesignationId) {
            $("#DesignationApply").modal("show");
            $('#spanDesignation').text('');
            $("#spanDesignation1").text('');

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Designation.aspx/BindDesignationForEdit",
                data: "{DesignationId : " + DesignationId + "}",
                dataType: "json",
                success: function (data) {

                    if (data.d != null) {

                        $('#DesignationId').val(data.d.DesignationId);
                        $('#txtDesignation').val(data.d.Designation);
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

        function EditDate(itemI) {

            BindDesignationEdit(itemI.getAttribute('DesignationId'));
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

            var iInd = itemI.getAttribute('DesignationId');

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
                            url: "Designation.aspx/DeleteDesignation",
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
                                        BinDesignation();


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
                        <li class="breadcrumb-item active" aria-current="page">Designation</li>
                    </ol>
                </nav>
            </div>
        </div>

        <div class="card">
            <div class="access" style="padding: 20px 10px 10px 10px;">
                <button type="button" class="btn btn-primary" onclick="Designation()" style="float:right;">Add</button>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table id="smarttable" class="table table-striped table-bordered" style="width: 100%" data-bind="visible: formDocument().DesignationBindObj().length> 0">
                        <thead>
                            <tr role="row">
                                <th style="width:80%;">Designation</th>
                                <th style="width:20%;">Action</th>
                            </tr>
                        </thead>
                        <tbody data-bind="foreach: formDocument().DesignationBindObj()">
                            <tr>

                                <td><span data-bind="text:Designation"></span></td>
                                <td style="text-align: center;">
                                    <button type="button" class="btn btn-success" onclick="EditDate(this)" data-bind="attr: {title: '', 'DesignationId': DesignationId}"><i class="lni lni-pencil"></i></button>
                                    <button type="button" class="btn btn-danger" onclick="DeleteDate(this)" data-bind="attr: {title: '', 'DesignationId': DesignationId}"><i class="lni lni-trash"></i></button>

                                </td>
                            </tr>
                        </tbody>

                    </table>

                </div>

            </div>
        </div>

        <div class="modal fade" id="DesignationApply" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content" style="width:85%;">
                    <div class="modal-header" style="align-content: center;">
                        <h5 class="modal-title" id="exampleModalLabel" style="padding-left: 135px;">Designation</h5>
                       <button type="button" class="button" data-bs-dismiss="modal" aria-label="Close" onclick="modalCancel()" style="color: #fff !important;">
                        <span aria-hidden="true" style="color: white; text-align: left; font-size: 27px;">×</span>
                    </button>
                    </div>
                    <div class="modal-body">
                        <div class="container p-4">
                            <div class="form-group row">
                                <div class="col-lg-12" style="color: #000 !important; line-height: 35px;">
                                    Designation

                                            <input type="text" class="form-control" placeholder="Designation" id="txtDesignation" autocomplete="off" maxlength="50"  />
                                    <span id="spanDesignation" style="color: red; font-size: 15px"></span>
                                    <span id="spanDesignation1" style="color: red; font-size: 15px"></span>
                                </div>

                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <div class="col-lg-12" style="margin-top: -10px;">
                            <center>
                                <button type="button" class="btn btn-primary" onclick="SaveReq()" id="btnSubmit">Sumbit</button>
                                <button type="button" class="btn btn-dark" data-bs-dismiss="modal" onclick="modalCancel()">Cancel</button>
                            </center>
                        </div>
                    </div>
                    <input type="hidden" id="DesignationId" value="0" />
                </div>
            </div>
        </div>




    </div>

    <script type="text/javascript">

        function Designation() {
            $("#DesignationApply").modal("show");
            $("#DesignationId").val(0);
            $("#txtDesignation").val('');
            $("#spanDesignation").text('');
            $("#spanDesignation1").text('');
        }
        function modalCancel() {
            $("#DesignationApply").modal("hide");
        }

    </script>

    <!--Knockout Script-->
    <script src="js/knockout-3.5.1.js" type="text/javascript"></script>
    <script src="js/knockout.mapping-latest-2.4.1.js" type="text/javascript"></script>
    <script src="js/knockout.validation-2.0.4.js" type="text/javascript"></script>

    <script type="text/javascript"> 
        var lstDesignationObj = function () {
            var self = this;
            this.DesignationBindObj = ko.observableArray([{
                DesignationId: 0, Designation: ''
            }]);
        };
        formDocument = ko.observable(new lstDesignationObj());
        ko.applyBindings(new lstDesignationObj(), document.getElementById("smarttable"));
    </script>

    <script>
        var Designationlist = function () {
            var self = this;
            self.DesignationId = ko.observable(0);
            self.Designation = ko.observable('');

        };
    </script>


</asp:Content>

