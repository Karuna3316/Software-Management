<%@ Page Title="" Language="C#" MasterPageFile="~/YEEMAKHRMS.master" AutoEventWireup="true" CodeFile="PermissionList.aspx.cs" Inherits="PermissionList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <!--plugins-->
    <link href="assets/plugins/perfect-scrollbar/css/perfect-scrollbar.css" rel="stylesheet" />
    <link href="assets/plugins/simplebar/css/simplebar.css" rel="stylesheet" />
    <link href="assets/plugins/metismenu/css/metisMenu.min.css" rel="stylesheet" />
    <link href="assets/plugins/datatable/css/dataTables.bootstrap5.min.css" rel="stylesheet" />


    <!-- CSS Files -->
    <link href="assets/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/css/bootstrap-extended.css" rel="stylesheet">
    <link href="assets/css/style.css" rel="stylesheet">
    <link href="assets/css/icons.css" rel="stylesheet">

     <!--PNotify-->
    <link rel="stylesheet" type="text/css" href="files/bower_components/pnotify/dist/pnotify.css" />
    <link rel="stylesheet" type="text/css" href="files/bower_components/pnotify/dist/pnotify.brighttheme.css" />
    <link rel="stylesheet" type="text/css" href="files/bower_components/pnotify/dist/pnotify.buttons.css" />
    <link rel="stylesheet" type="text/css" href="files/bower_components/pnotify/dist/pnotify.history.css" />
    <link rel="stylesheet" type="text/css" href="files/bower_components/pnotify/dist/pnotify.mobile.css" />
    <link rel="stylesheet" type="text/css" href="files/assets/pages/pnotify/notify.css" />
    <link href="files/assets/css/sweetalert.css" rel="stylesheet" />

    <script src="assets/js/jquery-3.6.0.min.js"></script>


    <style>
        button:focus {
            outline: none !important;
            background:none;
        }
        th {
            text-align:center;
        }
    </style>

    <script type="text/javascript">
        $(document).ready(function () {
            var objUrlParams = new URLSearchParams(window.location.search);
            var flagId = objUrlParams.get('flagId');
            if (flagId == 1) {
                new PNotify({
                    title: 'Updated',
                    text: 'Permission applied successfully...',
                    icon: 'icofont icofont-info-circle',
                    type: 'success'
                });
            }
            GetPermissionList();
        });

        function GetPermissionList() {

            $.ajax({

                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "PermissionList.aspx/GetPermissionList",
                dataType: "json",
                success: function (data) {
                    formDocument().objPermission().constructor();
                    if ($.fn.dataTable.isDataTable('#basic-btn')) {
                        $('#basic-btn').DataTable().clear().destroy();
                    }
                    ko.mapping.fromJS(data.d, null, formDocument);
                    $('#basic-btn').DataTable({
                        "paging": true,
                        "ordering": false,
                        responsive: true,
                        destroy: true,
                        "language": {
                            "search": "",
                        }
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
        function DeletePermission(itemI) {

            var PId = itemI.getAttribute('PId');

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
                            url: "PermissionList.aspx/DeletePermission",
                            data: "{PId : " + PId + "}",
                            dataType: "json",
                            success: function (data) {
                                if (data.d != "") {
                                    var inserted = data.d;
                                    if (inserted > 0) {

                                        new PNotify({
                                            title: 'Deleted',
                                            text: 'Permission deleted successfully...',
                                            icon: 'icofont icofont-info-circle',
                                            type: 'warning'
                                        });
                                        GetPermissionList();
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
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="page-content">
        <div class="page-breadcrumb d-none d-sm-flex align-items-center mb-3">
            <%--<div class="breadcrumb-title pe-3">Tables</div>--%>
            <div class="ps-3">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-0 p-0 align-items-center">
                        <li class="breadcrumb-item"><a  href="dashboard.aspx">
                            <ion-icon name="home-outline" role="img" class="md hydrated" aria-label="home outline"></ion-icon>
                        </a>
                        </li>
                        <li class="breadcrumb-item active" aria-current="page">Permission</li>
                    </ol>
                </nav>
            </div>
        </div>

        <div class="card">
            <div class="card-body">
                <div class="button">
                    <button type="button" class="btn btn-success" onclick="location.href = 'Permission.aspx'">Add</button>
                </div>
                <div class="table-responsive">
                    <table id="basic-btn" class="table table-striped table-bordered" style="width: 100%" data-bind="hidden: formDocument().objPermission().length > 0">
                        <thead>
                            <tr role="row">
                                <th>Employee Name</th>
                                <th>Permission date(hours)</th>
                                <th>Reason</th>
                                <th>Action</th>
                                
                            </tr>
                        </thead>
                        <tbody data-bind="foreach: formDocument().objPermission()" id="body">
                            <tr>
                                <td ><span data-bind="text: userId"></span></td>
                                <td style="text-align:center;"><span data-bind="text: PDatewithhour"></span></td>
                                <td><span data-bind="text: Reason"></span></td>
                                <td style="text-align:center;">
                                    <button type="button" class="btn btn-danger" onclick="DeletePermission(this)" data-bind="attr: { 'PId': PId}"><i class="lni lni-trash"></i>Delete</button>
                                </td>
                            </tr>
                        </tbody>

                    </table>

                </div>

            </div>
        </div>
        </div>

    <!--Knockout Script-->
    <script src="js/knockout-3.3.0.js" type="text/javascript"></script>
    <script src="js/knockout.mapping-latest.js" type="text/javascript"></script>
    <script src="js/knockout.validation.js" type="text/javascript"></script>
    <script src="assets/js/jquery-3.6.0.min.js"></script>


    <!-- pnotify js -->
    <script type="text/javascript" src="files/bower_components/pnotify/dist/pnotify.js"></script>
    <script type="text/javascript" src="files/bower_components/pnotify/dist/pnotify.desktop.js"></script>
    <script type="text/javascript" src="files/bower_components/pnotify/dist/pnotify.buttons.js"></script>
    <script type="text/javascript" src="files/bower_components/pnotify/dist/pnotify.confirm.js"></script>
    <script type="text/javascript" src="files/bower_components/pnotify/dist/pnotify.callbacks.js"></script>
    <script type="text/javascript" src="files/bower_components/pnotify/dist/pnotify.animate.js"></script>
    <script type="text/javascript" src="files/bower_components/pnotify/dist/pnotify.history.js"></script>
    <script type="text/javascript" src="files/bower_components/pnotify/dist/pnotify.mobile.js"></script>
    <script type="text/javascript" src="files/bower_components/pnotify/dist/pnotify.nonblock.js"></script>
    <script type="text/javascript" src="files/assets/pages/pnotify/notify.js"></script>
    <script src="files/bower_components/jquery.steps/build/jquery.steps.js"></script>

     <script src="css1/dist/js/sweetalert-data.js"></script>
    <script src="files/assets/js/sweetalert.js"></script>
     <script type="text/javascript">
         var lstPermissionObj = function () {
            
             this.objPermission = ko.observableArray([{
                 PId: 0, userId: '', PDatewithhour: '', Reason: ''
             }]);
         };
         formDocument = ko.observable(new lstPermissionObj());
         ko.applyBindings(new lstPermissionObj(), document.getElementById("basic-btn"));
     </script>
</asp:Content>

