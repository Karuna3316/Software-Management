<%@ Page Title="" Language="C#" MasterPageFile="~/YEEMAKHRMS.master" AutoEventWireup="true" CodeFile="Permission.aspx.cs" Inherits="Permission" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <!--plugins-->
    <link href="assets/plugins/perfect-scrollbar/css/perfect-scrollbar.css" rel="stylesheet" />
    <link href="assets/plugins/simplebar/css/simplebar.css" rel="stylesheet" />
    <link href="assets/plugins/metismenu/css/metisMenu.min.css" rel="stylesheet" />
    <link href="assets/plugins/datatable/css/dataTables.bootstrap5.min.css" rel="stylesheet" />
    <script src="assets/js/jquery-3.6.0.min.js"></script>

    <!-- CSS Files -->
    <link href="assets/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/css/bootstrap-extended.css" rel="stylesheet">
    <link href="assets/css/style.css" rel="stylesheet">
    <style>
        label {
            align-content:center;
            line-height:30px;
            font-size:16px;
            color:#000;
        }
        .form-control {
            font-size:16px;
            border:1px solid #525151;
        }
    </style>
     <script>
        $(document).ready(function() {
            $('.js-example-basic-single').select2();
            BindEmployeeName(0);
            BindPDateWithHours(0);
            $("#drpemployee").change(function () {
                $("#spandrpemployee").text('');
                var UserID = $(this).val();               
                BindPDateWithHours(UserID);                
            });
            $("#drpPDate").change(function () {
                $("#spandrpPDate").text('');             
            });
        });
         function BindEmployeeName(Ename) {

             $.ajax({
                 type: "POST",
                 contentType: "application/json; charset=utf-8",
                 url: "Permission.aspx/DrpEmployeeName",
                 data: "{}",
                 dataType: "json",
                 success: function (data) {
                     $("#drpemployee").html("");
                     $("#drpemployee").append($("<option></option>").val('0').html('Select Employee Name'));
                     $.each(data.d, function (key, value) {
                         $("#drpemployee").append($("<option></option>").val(value.userId).html(value.UserName));
                     });
                     $("#drpemployee").val(Ename);
                 },
                 error: function (result) {
                     alert("Failed to load Employee Name");
                 }
             });
         }
         function BindPDateWithHours(UserID) {

             $.ajax({
                 type: "POST",
                 contentType: "application/json; charset=utf-8",
                 url: "Permission.aspx/DrpPermissionDate",
                 data: "{UserID : " + UserID + "}",
                 dataType: "json",
                 success: function (data) {
                     $("#drpPDate").html("");
                     $("#drpPDate").append($("<option></option>").val('0').html('Select Permission Date'));
                     $.each(data.d, function (key, value) {
                         $("#drpPDate").append($("<option></option>").val(value.AttendanceID).html(value.DateWithPermissionHours)
                             .attr('UserID', value.UserID).attr('CheckIn', value.CheckIn).attr('TotalPermissionMinutes', value.TotalPermissionMinutes));
                     });
                     //$("#drpPDate").val(UserID);
                 },
                 error: function (result) {
                     alert("Failed to load Permission Date");
                 }
             });
         }

         function SaveReq() {
             var isValid = false;
             if (hasddlValue("#drpemployee", "#spandrpemployee", "Select Employee Name") &&
                 hasddlValue("#drpPDate", "#spandrpPDate", "Select Permission Date"))
                 isValid = true;
             if (isValid) {
                 var objPDate = new SavePermission();
                 //objPDate.PId = $('#PId').val();
                 objPDate.userId = $('#drpemployee').val();
                 objPDate.PDatewithhour = $('#drpPDate').find(":selected").text();
                 objPDate.PMinutes = $('#drpPDate').find(":selected").attr("TotalPermissionMinutes");
                 objPDate.CheckIn = $('#drpPDate').find(":selected").attr("CheckIn");
                 objPDate.Reason = $('#txtReason').val().trim();
                 $("#btnSubmit").attr("disabled", true);
                 $.ajax({
                     type: "POST",
                     contentType: "application/json; charset=utf-8",
                     url: "Permission.aspx/SaveorUpdatePermission",
                     data: "{objPDate : " + ko.toJSON(objPDate) + "}",
                     dataType: "json",
                     success: function (data) {
                         if (data.d != "") {
                             var inserted = data.d;
                             if (inserted != null) {
                                 location.href = "PermissionList.aspx?flagId=" + data.d;

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

             }
             else {
                 $(errDisplayCtrlId).text('');

             }

             return hasIt;
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
                        <li class="breadcrumb-item active" aria-current="page">Permission</li>
                    </ol>
                </nav>
            </div>
        </div>

        <div class="card" style="padding:10px;">
            <div class="card-body">
                <div class="border p-3 rounded">
                  
                  <div class="row g-3" style="padding-bottom:10px;">
                    <div class="col-4">
                      <label class="form-label">Employee Name</label>
                        </div>
                      <div class="col-5">
                          <select class="js-example-basic-single" id="drpemployee"></select>
                          <span id="spandrpemployee" style="color:red;font-size:16px"></span>
                      
                    </div>
                      </div>
                    
                    <div class="row g-3" style="padding-bottom:10px;">
                      <div class="col-4">
                      <label class="form-label">Permission Time</label>
                          </div>
                      <div class="col-5">
                      <select class="js-example-basic-single" id="drpPDate"></select>
                          <span id="spandrpPDate" style="color:red;font-size:16px"></span>
                    </div>
                    
                  </div>
                    <div class="row g-3" style="padding-bottom:10px;">
                      <div class="col-4">
                      <label class="form-label">Reason</label>
                          </div>
                      <div class="col-5">
                      <textarea class="form-control" id="txtReason"></textarea>
                    </div>
                    
                  </div>
                    
                    <div class="row g-3"">
                      <div class="col-12">
                          <center>
                              <button type="button" class="btn btn-primary" onclick="SaveReq()" id="btnSubmit">Submit</button>
                              <button type="button" class="btn btn-dark" onclick="location.href = 'PermissionList.aspx'">Cancel</button>
                          </center>
                          </div>
                        </div>
                    <input type="hidden" id="PId" value="0" />

                </div>
                </div>
            </div>
        </div>
    <!--Knockout Script-->
    <script src="js/knockout-3.3.0.js" type="text/javascript"></script>
    <script src="js/knockout.mapping-latest.js" type="text/javascript"></script>
    <script src="js/knockout.validation.js" type="text/javascript"></script>
    <script src="assets/js/jquery-3.6.0.min.js"></script>

    <script>

        var SavePermission = function () {
            var self = this;
            self.PId = ko.observable(0);
            self.userId = ko.observable('');
            self.CheckIn = ko.observable('');
            self.PDatewithhour = ko.observable('');
            self.PMinutes = ko.observable('');
            self.Reason = ko.observable('');

        };
    </script>
</asp:Content>
