<%@ Page Title="" Language="C#" MasterPageFile="~/YEEMAKHRMS.master" AutoEventWireup="true" CodeFile="Department.aspx.cs" Inherits="Department" %>

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
            DepartmentList();

            $("#txtdept").keyup(function () {
                var txtdept = $(this).val();
                if (txtdept != '') {
                    $("#spandept").text("");

                }

            });

            var maxLength = 50;
            var elaz = document.getElementById('txtdept');

            $('#txtdept').keypress(function (event) {
                var Length = $("#txtdept").val().length;
                var AmountLeft = maxLength - Length;
                $('#txtdept-length-left').html(AmountLeft);
                if (Length >= maxLength) {
                    if (event.which != 8) {
                        $('#spandept1').text('Only 50 characters are allowed');

                        return false;
                    }
                } else {
                    $('#spandept1').text('');
                    elaz.addEventListener('keydown', function (event) {

                        if (event.keyCode == 8) {

                            $('#spandept1').html('');
                        }

                    });
                }


            });



        });

        function DepartmentList() {
            $.ajax({
               type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Department.aspx/getdepartmentList",
                data: "{}",
                dataType: "json",
                success: function (data) {

                    Departmentmaster().Dept_Master().constructor();
                    if ($.fn.dataTable.isDataTable('#department')) {
                        $('#department').DataTable().clear().destroy();
                    }
                    ko.mapping.fromJS(data.d, null, Departmentmaster);
                    $('#department').DataTable({
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
            if (hasValue("#txtdept", "#spandept", "Enter the Department"))

                isValid = true;
            if (isValid) {
                var deptobj = new Departmentlist();
                deptobj.DepartmentId = $('#DepartmentId').val();
                deptobj.Department = $('#txtdept').val();
                $("#btnSubmit").attr("disabled", true);
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Department.aspx/savedepartment",
                    data: "{deptobj : " + ko.toJSON(deptobj) + "}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {

                            var inserted = data.d;
                            if (inserted != null) {

                                $("#DepartmentApply").modal("hide");
                                $("#btnSubmit").attr("disabled", false);
                                DepartmentList();
                                if (inserted == 1) {
                                    new PNotify({
                                        title: 'Registered',
                                        text: 'Saved successfully...',
                                        icon: 'icofont icofont-info-circle',
                                        type: 'success'
                                    });
                                }

                                else if (inserted == 2) {
                                    $("#DepartmentApply").modal("hide");
                                    DepartmentList();
                                    new PNotify({
                                        title: 'Updated',
                                        text: 'Updated successfully...',
                                        icon: 'icofont icofont-info-circle',
                                        type: 'success'
                                    });
                                }
                                else if (inserted == 3) {
                                    $("#DepartmentApply").modal("hide");
                                    DepartmentList();
                                    new PNotify({
                                        title: 'pre-exist',
                                        text: 'Department already exists...',
                                        icon: 'icofont icofont-info-circle',
                                        type: 'success'
                                    });
                                }
                                else {
                                    $("#DepartmentApply").modal("hide");
                                    DepartmentList();

                                }

                            }
                            else
                                alert('failed to update');
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

        function EditDepartment(DepartmentId) {
            $("#DepartmentApply").modal("show");
            $('#spandept').text('');
            $('#spandept1').text('');

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Department.aspx/Editdepartment",
                data: "{DepartmentId : " + DepartmentId + "}",
                dataType: "json",
                success: function (data) {

                    if (data.d != null) {

                        $('#DepartmentId').val(data.d.DepartmentId);
                        $('#txtdept').val(data.d.Department);

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

            EditDepartment(itemI.getAttribute('DepartmentId'));

        }

        function DeleteDate(itemI) {

            var iInd = itemI.getAttribute('DepartmentId');

            swal({
                title: "Are you sure?",
                text: "You will not be able to recover again!",
                type: "warning",
                showCancelButton: true,
                confirmButtonClass: "btn-danger",
                cancelButtonText: "No",
                confirmButtonText: "Yes",
                closeOnConfirm: false,
                closeOnCancel: false
            },
                function (isConfirm) {
                    if (isConfirm) {


                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "Department.aspx/Deletedepartment",
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
                                        DepartmentList();


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
                        <li class="breadcrumb-item active" aria-current="page">Department</li>
                    </ol>
                </nav>
            </div>
        </div>

        <div class="card">
            <div class="access" style="padding: 20px 10px 10px 10px;">
                <button type="button" class="btn btn-primary" onclick="Designation()" style="float: right;">Add</button>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table id="department" class="table table-striped table-bordered" style="width: 100%;" data_bind="visible: Departmentmaster().Dept_Master().length> 0 ">
                        <thead>
                            <tr role="row">
                                <th style="width: 80%;">Department</th>
                                <th style="width: 20%;">Action</th>

                            </tr>
                        </thead>
                        <tbody data-bind="foreach:Departmentmaster().Dept_Master()">
                            <tr>

                                <td><span data-bind="text:Department"></span></td>
                                <td style="text-align: center;">
                                    <button type="button" class="btn btn-success" onclick="EditDate(this)" data-bind="attr: {title: '', 'DepartmentId': DepartmentId}"><i class="lni lni-pencil"></i></button>
                                    <button type="button" class="btn btn-danger" onclick="DeleteDate(this)" data-bind="attr: {title: '', 'DepartmentId': DepartmentId}"><i class="lni lni-trash"></i></button>
                                </td>
                            </tr>
                        </tbody>

                    </table>

                </div>

            </div>
        </div>

        <div class="modal fade" id="DepartmentApply" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content" style="width: 85%;">
                    <div class="modal-header" style="align-content: center;">
                        <h5 class="modal-title" id="exampleModalLabel" style="padding-left: 135px;">Department</h5>
                        <button type="button" class="button" data-bs-dismiss="modal" aria-label="Close" onclick="modalCancel()" style="color: #fff !important;">
                            <span aria-hidden="true" style="color: white; text-align: left; font-size: 27px;">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="container p-4">
                            <div class="form-group row">
                                <div class="col-lg-12" style="color: #000 !important; line-height: 35px;">
                                    Department <sup><i class="fa fa-asterisk" aria-hidden="true" style="color: red; font-size: 10px;"></i></sup>

                                    <input type="text" id="txtdept" class="form-control"  placeholder="Department" autocomplete="off" maxlength="50" />
                                </div>
                                <span id="spandept" style="color: red; font-size: 15px"></span>
                                <span id="spandept1" style="color: red; font-size: 15px"></span>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <div class="col-lg-12" style="margin-top: -10px;">
                            <center>
                                <button type="button" class="btn btn-primary" onclick="SaveReq();" id="btnSubmit">Submit</button>
                                <button type="button" class="btn btn-dark" data-bs-dismiss="modal" onclick="modalCancel();">Cancel</button>
                            </center>
                        </div>
                    </div>
                </div>
                <input type="hidden" id="DepartmentId" value="0" />
            </div>
        </div>




    </div>
    <script>
        function Designation() {
            $("#DepartmentApply").modal("show");
            $('#DepartmentId').val(0);
            $('#txtdept').val('');
            $('#spandept').text('');
            $('#spandept1').text('');

        }
        function modalCancel() {
            $("#DepartmentApply").modal("hide");
        }
    </script>

    <!--Knockout Script-->
    <script src="js/knockout-3.5.1.js" type="text/javascript"></script>
    <script src="js/knockout.mapping-latest-2.4.1.js" type="text/javascript"></script>
    <script src="js/knockout.validation-2.0.4.js" type="text/javascript"></script>


    <script type="text/javascript"> 
        var Department_obj = function () {
            var self = this;


            this.Dept_Master = ko.observableArray([{
                DepartmentId: 0, Department: '',
            }]);
        };
        Departmentmaster = ko.observable(new Department_obj());
        ko.applyBindings(new Department_obj(), document.getElementById("department"));
    </script>

    <script type="text/javascript">
        var Departmentlist = function () {
            var self = this;
            self.DepartmentId = ko.observable(0);
            self.Department = ko.observable('');


        };
    </script>

</asp:Content>

