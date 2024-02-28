<%@ Page Title="" Language="C#" MasterPageFile="~/YEEMAKHRMS.master" AutoEventWireup="true" CodeFile="LeaveRequestList.aspx.cs" Inherits="LeaveRequestList" %>

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

     <script src="assets/js/jquery-3.6.0.min.js"></script>

    <!--PNotify-->
    <link rel="stylesheet" type="text/css" href="files/bower_components/pnotify/dist/pnotify.css" />
    <link rel="stylesheet" type="text/css" href="files/bower_components/pnotify/dist/pnotify.brighttheme.css" />
    <link rel="stylesheet" type="text/css" href="files/bower_components/pnotify/dist/pnotify.buttons.css" />
    <link rel="stylesheet" type="text/css" href="files/bower_components/pnotify/dist/pnotify.history.css" />
    <link rel="stylesheet" type="text/css" href="files/bower_components/pnotify/dist/pnotify.mobile.css" />
    <link rel="stylesheet" type="text/css" href="files/assets/pages/pnotify/notify.css" />
        <link rel="stylesheet" type="text/css" href="files/assets/pages/pnotify/notify.css" />

            <link href="files/assets/css/sweetalert.css" rel="stylesheet" />



    <style>
        button:focus 
        {
            outline: none !important;
            background:none;
        }
        th 
        {
            text-align:center;
        }

    </style>
     <script>
         $(document).ready(function () {

             var objUrlParams = new URLSearchParams(window.location.search);
             var flagId = objUrlParams.get('flagId');
             if (flagId == 1) {
                 new PNotify({
                     title: 'Registered',
                     text: 'LeaveRequest saved successfully...',
                     icon: 'icofont icofont-info-circle',
                     type: 'success'
                 });
             }
             else if (flagId == 2) {
                 new PNotify({
                     title: 'Updated',
                     text: 'LeaveRequest updated successfully...',
                     icon: 'icofont icofont-info-circle',
                     type: 'success'
                 });
             }
             else if (flagId == 3) {
                 new PNotify({
                     title: 'pre-exist',
                     text: 'LeaveRequest already exists...',
                     icon: 'icofont icofont-info-circle',
                     type: 'success'
                 });
             }

             GetLeaveRequestList();
         });

         function GetLeaveRequestList()
         {

             $.ajax({

                 type: "POST",
                 contentType: "application/json; charset=utf-8",
                 url: "LeaveRequestList.aspx/GetLeaveList",
                 data: "{}",
                 dataType: "json",
                 success: function (data) {

                     Leave_Gs().ObjLeave_Gs().constructor();
                     if ($.fn.dataTable.isDataTable('#tblLeave')) {
                         $('#tblLeave').DataTable().clear().destroy();
                     }
                     ko.mapping.fromJS(data.d, null, Leave_Gs);
                     $('#tblLeave').DataTable({
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

         function DeleteDate(itemI) {

             var LID = itemI.getAttribute('LID');
             var AttendanceID = itemI.getAttribute('AttendanceID');
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
                             url: "LeaveRequestList.aspx/Deleteleave",
                             data: "{LID : " + LID + ",AttendanceID : " + AttendanceID + "}",
                             dataType: "json",
                             success: function (data) {
                                 if (data.d != "") {
                                     var inserted = data.d;
                                     if (inserted > 0) {

                                         new PNotify({
                                             title: 'Deleted',
                                             text: 'Leave deleted successfully',
                                             icon: 'icofont icofont-info-circle',
                                             type: 'warning'
                                         });
                                         GetLeaveRequestList();


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

         function EditDate(itemI)
         {
             location.href = "LeaveRequest.aspx?LID=" + itemI.getAttribute('LID');
         }

          function AddToList() 
          {

            location.href = "LeaveRequest.aspx";

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
                        <li class="breadcrumb-item"><a href="dashboard.aspx">
                            <ion-icon name="home-outline" role="img" class="md hydrated" aria-label="home outline"></ion-icon>
                        </a>
                        </li>
                        <li class="breadcrumb-item active" aria-current="page">Leave Request</li>
                    </ol>
                </nav>
            </div>
        </div>

        <div class="card">
            <div class="card-body">
                <div class="button">
                    <button type="button" class="btn btn-success" onclick="AddToList()">Add</button>
                </div>
                <div class="table-responsive">
                    <table id="tblLeave" class="table table-striped table-bordered" style="width: 100%" data-bind="hidden: Leave_Gs().ObjLeave_Gs().length > 0">
                        <thead>
                            <tr role="row">
                                <th>Employee Name</th>
                                <th>Leave Days</th>
                                <th>Leave Type</th>
                                <th>Action</th>

                            </tr>
                        </thead>
                        <tbody data-bind="foreach: Leave_Gs().ObjLeave_Gs()">
                            <tr>
                                <td><span data-bind="text: EmployeeName"></span></td>
                                <td style="text-align: center;"><span data-bind="text: LeaveDays"></span></td>
                                <td><span data-bind="text: LeaveType"></span></td>
                                <td style="text-align: center;">
                                    <%--  <button type="button" class="btn btn-success" onclick="EditDate(this)" data-bind="attr: {title: '', 'LID': LID}"><i class="lni lni-pencil"></i>Edit</button>--%>
                                    <button type="button" class="btn btn-danger" data-bind="attr: {'AttendanceID': AttendanceID, 'LID': LID}" onclick="DeleteDate(this)"><i class="lni lni-trash"></i>Delete</button>
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
         var Leave_GsObj = function () {
             var self = this;


             this.ObjLeave_Gs = ko.observableArray([{
                 LID: 0, AttendanceID: 0, EmployeeName: '', LeaveDays: '', LeaveType: ''

             }]);
         };
         Leave_Gs = ko.observable(new Leave_GsObj());
         ko.applyBindings(new Leave_GsObj(), document.getElementById("tblLeave"));

     </script>
</asp:Content>

