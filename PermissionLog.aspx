<%@ Page Title="" Language="C#" MasterPageFile="~/YEEMAKHRMS.master" AutoEventWireup="true" CodeFile="PermissionLog.aspx.cs" Inherits="PermissionLog" %>

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


     <link href="assets/css/calender.css" rel="stylesheet" />
    <script src="assets/js/calender.js"></script>
    <style>
        label {
            align-content:center;
            line-height:30px;
            font-size:16px;
            color:#000;
        }
        .form-control {
            font-size:16px;
            height:41px;
            border:1px solid #525151;
        }
        button:focus {
            outline: none !important;
            background:none;
        }
        th {
            text-align:center;
        }
    </style>
     <script>
        $(document).ready(function() {
            $('.js-example-basic-single').select2();
            $('#table').hide();

            BindEmployeeName(0);


            $("#txtfrmdate").click(function () {
                var checkout = $(this).val();
                if (checkout > 0 || checkout != null || checkout != '') {
                    $("#lblFr").text("");

                }

            });
            
            $("#txtTodate").click(function () {
                var txtTodate = $(this).val();
                if (txtTodate > 0 || txtTodate != null || txtTodate != '') {
                    $("#lblE").text("");

                }

            });

          
        });
        

         var jq = jQuery.noConflict();
         jq(document).ready(function () {
             jq("#txtfrmdate").datepicker({
                 dateFormat: "dd/mm/yy",
                 changeMonth: true,
                 changeYear: true
             });
         });

         var jq = jQuery.noConflict();
         jq(document).ready(function () {
             jq("#txtTodate").datepicker({
                 dateFormat: "dd/mm/yy",
                 changeMonth: true,
                 changeYear: true
             });
         });
        
         function BindEmployeeName(Ename) {

             $.ajax({
                 type: "POST",
                 contentType: "application/json; charset=utf-8",
                 url: "PermissionLog.aspx/BindEmployeeName",
                 data: "{}",
                 dataType: "json",
                 success: function (data) {
                     $("#drpemployee").html("");
                     $("#drpemployee").append($("<option></option>").val('0').html('Select Employee Name'));
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

         function BindPermissionLog(stDate, EndDate, Employee) {
            
              $.ajax({
                  type: "POST",
                  contentType: "application/json; charset=utf-8",
                  url: "PermissionLog.aspx/BindPermissionLog",
                  data: "{stD:'" + stDate + "',endD: '" + EndDate + "',Employeeid: '" + Employee + "'}",
                  dataType: "json",
                  success: function (data) {
                      PermissionlogObj().PermisObj().constructor();
                      if ($.fn.dataTable.isDataTable('#tblpermissionlog')) {
                          $('#tblpermissionlog').DataTable().clear().destroy();
                      }

                      ko.mapping.fromJS(data.d, null, PermissionlogObj);

                      $('#tblpermissionlog').DataTable({
                          responsive: false,
                          "ordering": false,
                          "paging": true,
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

         function chkFrDates() {
             var fD = $('#txtfrmdate').val();
             var eD = $('#txtTodate').val();
             var Emp = $('#drpemployee').val();

             if (fD === "" && eD === "")
                 $('#lblFr')[0].innerText = "Choose the start date";
             else if (fD === "" && eD !== "")
                 $('#lblFr')[0].innerText = "Choose the start date";
             else
                 $('#lblFr')[0].innerText = "";
             if (fD !== "" && eD === "")
                 $('#lblE')[0].innerText = "Choose the end date";
             else
                 $('#lblE')[0].innerText = "";

             if (fD !== "" && eD !== "") {
                 if (fD < eD) {
                     $('#table').show();
                     $('#lblCr')[0].innerText = "";
                     BindPermissionLog(fD, eD, Emp);
                 } else {
                     $('#lblCr')[0].innerText = "Choose the valid dates";
                     $('#table').hide();
                     BindEmployeeName(0);
                 }
                 return true;
             } else {
                 $('#table').hide();
                 return false;
             }
         }

         function resetlist() {
             $('#txtfrmdate').val("");
             $('#txtTodate').val("");
             $('#lblFr')[0].innerText = "";
             $('#lblE')[0].innerText = "";
             $('#table').hide();
             $('#lblCr')[0].innerText = "";


             BindEmployeeName(0);

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
                        <li class="breadcrumb-item active" aria-current="page">Permission Log</li>
                    </ol>
                </nav>
            </div>
        </div>

        <div class="card" style="padding: 10px;">
            <div class="card-body">
                <div class="border p-3 rounded">

                    <div class="form-group row g-3" style="padding-bottom: 10px;">
                        <div class="col-sm-2">
                            <label class="form-label">From <sup><i class="fa fa-asterisk" aria-hidden="true" style="color: red; font-size: 10px !important;"></i></sup></label>
                            <input type="text" class="form-control" id="txtfrmdate" readonly autocomplete="off"/>
                            <span id="lblFr" style="color: red; font-weight: 400; font-size: 14px;"></span>
                        </div>
                        <div class="col-sm-2">
                            <label class="form-label">To <sup><i class="fa fa-asterisk" aria-hidden="true" style="color: red; font-size: 10px !important;"></i></sup></label>
                            <input type="text" class="form-control" id="txtTodate" readonly autocomplete="off"/>
                            <span id="lblE" style="color: red; font-weight: 400; font-size: 14px;"></span>

                        </div>
                        <div class="col-sm-3" style="line-height:30px;">
                            <label class="form-label">Employee Name</label>
                            <select class="js-example-basic-single" style="width:100%;" id="drpemployee">
                           
                            </select>
                        </div>
                        <div class="col-sm-1" style="line-height: 115px;"></div>
                        <div class="col-sm-2" style="line-height: 115px;">
                            <button type="button" class="btn btn-primary" onclick="return chkFrDates();">Submit</button>
                        </div>
                        <div class="col-sm-1" style="line-height: 115px;">
                            <button type="button" class="btn btn-dark" onclick="return resetlist();">Reset</button>
                        </div>
                         <span id="lblCr" style="color: red; font-weight: 400; font-size: 14px;"></span>
                    </div>


                </div>
            </div>
        </div>
        <div class="card" style="padding: 10px;" id="table">
            <div class="card-body">
                <div class="border p-3 rounded">
                    <div class="table-responsive">
                    <table id="tblpermissionlog" class="table table-striped table-bordered" data-bind="hidden: PermissionlogObj().PermisObj().length > 1" style="width: 100%">
                        <thead>
                            <tr role="row">
                                <th>Employee ID</th>
                                <th>Employee Name</th>
                                <th>Permission Hour</th>
                                <th>Reason</th>
                            </tr>
                        </thead>
                        <tbody  id="body" data-bind="foreach: PermissionlogObj().PermisObj()"> 
                            <tr>
                                <td><span data-bind="text: userId"></span></td>
                                <td><span data-bind="text: userName"></span></td>
                                <td><span data-bind="text: CheckIn"></span></td>
                                <td><span data-bind="text: Reason"></span></td>
                                
                            </tr>
                        </tbody>

                    </table>

                </div>
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
         var lstPermissionlogObj = function () {
                var self = this;
             this.PermisObj = ko.observableArray([{
                 userId: 0, CheckIn: '', Reason: '', createdDate: '', userName: ''
                }]);
            };
         PermissionlogObj = ko.observable(new lstPermissionlogObj());
         ko.applyBindings(new lstPermissionlogObj(), document.getElementById("tblpermissionlog"));

     </script>
</asp:Content>

