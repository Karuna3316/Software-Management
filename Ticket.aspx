<%@ Page Title="" Language="C#" MasterPageFile="~/YEEMAKHRMS.master" AutoEventWireup="true" CodeFile="Ticket.aspx.cs" Inherits="Ticket" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="assets/css/calender.css" rel="stylesheet" />
    <script src="assets/js/calender.js"></script>
    <style>
        label {
            align-content: center;
            line-height: 30px;
            font-size: 16px;
            color: #000;
        }
    </style>
    <script>
        $(document).ready(function () {
            $('.js-example-basic-single').select2();

            BindEmployeeName(0);

            fnBindDates('0', '0', '0');

            $("#drpemployee").change(function () {

                fnBindDates('0', '0', '0');
                $("#drptickettype").val("0");
                $("#txttime").val("");

                $("#drptickettype").change();
                $("#spandrpemployee").text("");
                $("#spandrptickettype").text("");
                $("#spandrpDates").text("");
                $("#spantxtreason").text("");
            });


            $("#drptickettype").change(function () {
                var valddlSupportType = $("#drptickettype").val();
                var drpemployee = $("#drpemployee").val();

                if (valddlSupportType != '0' && valddlSupportType != '') {
                    fnBindDates(drpemployee, valddlSupportType, 0);
                }

                else {
                    fnBindDates('0', '0', '0');

                }
            });

            $("#drpemployee").change(function () {
                var drpemployee = $(this).val();
                if (drpemployee > 0) {
                    $("#spandrpemployee").text("");

                }

            });

            $("#drptickettype").change(function () {
                var drptickettype = $(this).val();
                if (drptickettype > 0) {
                    $("#spandrptickettype").text("");

                }

            });

            $("#drpDates").change(function () {
                var drpDates = $(this).val();
                if (drpDates > "0") {
                    $("#spandrpDates").text("");

                }

            });

            $("#txttime").click(function () {
                var checkout = $(this).val();
                if (checkout > 0 || checkout != null || checkout != '') {
                    $("#spantxttime").text("");

                }

            });

            $("#txtreason").keyup(function () {
                var txtreason = $(this).val();
                if (txtreason != '') {
                    $("#spantxtreason").text("");

                }

            });


            var max7 = 50;
            var elg = document.getElementById('txtreason');

            $('#txtreason').keypress(function (event) {
                var Length = $("#txtreason").val().length;
                var AmountLeft = max7 - Length;
                $('#txtreason-length-left').html(AmountLeft);
                if (Length >= max7) {
                    if (event.which != 8) {
                        $('#spantxtreason1').text('Only 50 characters are allowed');

                        return false;
                    }
                } else {
                    $('#spantxtreason1').text('');
                    elg.addEventListener('keydown', function (event) {
                        // Checking for Backspace.
                        if (event.keyCode == 8) {
                            $('#spantxtreason1').html('');
                        }

                    });
                }


            });

        });

        function BindEmployeeName(Ename) {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Ticket.aspx/BindEmployeeName",
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

        function fnBindDates(drpemployee, SupportTypeId, Id) {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Ticket.aspx/BindTicketDates",
                data: "{'SupportTypeId' : '" + SupportTypeId + "','drpemployee' : '" + drpemployee + "'}",
                dataType: "json",
                success: function (data) {
                    $("#drpDates").html("");
                    $("#drpDates").append($("<option></option>").val('0').html('- Select -'));
                    $.each(data.d, function (key, value) {
                        $("#drpDates").append($("<option></option>").val(value.dText).html(value.dText));
                    });
                    $("#drpDates").val(Id);
                },
                error: function (result) {
                    alert("Failed to load Dates");
                }
            });
        }

        function SaveReq() {
            var isValid = true;

            isValid = isValid && hasddlValue("#drpemployee", "#spandrpemployee", "Select employee name");
            isValid = isValid && hasddlValue("#drptickettype", "#spandrptickettype", "Select ticket type");
            isValid = isValid && hasddlValue("#drpDates", "#spandrpDates", "Select date");
            isValid = isValid && hasValue("#txttime", "#spantxttime", "Choose the time");

            if (isValid) {
                var objSupport = new Ticketgs();
                objSupport.SupportId = $('#SupportId').val();
                objSupport.Eid = $('#drpemployee').val();
                objSupport.SupportTypeId = $('#drptickettype').val();

                objSupport.Date = $('#drpDates').val();
                objSupport.Time = $('#txttime').val();
                objSupport.reason = $('#txtreason').val();
                var value = $("#drptickettype option:selected");
                objSupport.SupportType = value.text();
                $("#btnSubmit").attr("disabled", true);
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Ticket.aspx/SaveorUpdateTicket",
                    data: "{objSupport : " + ko.toJSON(objSupport) + "}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {
                            var inserted = data.d;
                            if (inserted != null) {
                                location.href = "TicketList.aspx?flagId=" + data.d;
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

        function hasddlValue(ctrlId, errDisplayCtrlId, errMsg) {

            var hasIt = true;
            if ($(ctrlId).val() == "Select" || $(ctrlId).val() == "0") {
                hasIt = false;
                $(errDisplayCtrlId).text(errMsg);
                //$(ctrlId).focus();
            }
            else {
                $(errDisplayCtrlId).text('');

            }

            return hasIt;
        }
        function Cancel() {
            location.href = "TicketList.aspx";
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="page-content">
        <div class="page-breadcrumb d-none d-sm-flex align-items-center mb-3">
            <div class="ps-3">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-0 p-0 align-items-center">
                        <li class="breadcrumb-item">TICKETS</li>
                        <li class="breadcrumb-item active" aria-current="page">Ticket</li>
                    </ol>
                </nav>
            </div>
        </div>

        <div class="card" style="padding: 10px;">
            <div class="card-body">
                <div class="border p-3 rounded">

                    <div class="row g-3" style="padding-bottom: 10px;">
                        <div class="col-sm-4">
                            <label class="form-label">Employee Name <sup><i class="fa fa-asterisk" aria-hidden="true" style="color: red; font-size: 10px;"></i></sup></label>
                        
                            <select class="js-example-basic-single" id="drpemployee">
                            </select><span id="spandrpemployee" style="color: red; font-size: 15px"></span>

                        </div>
                    
                        <div class="col-sm-4">
                            <label class="form-label">Ticket Type <sup><i class="fa fa-asterisk" aria-hidden="true" style="color: red; font-size: 10px;"></i></sup></label>
                        
                            <select class="js-example-basic-single" id="drptickettype">
                                <option value="0">- Select -</option>
                                <option value="1">Change In Time</option>
                                <option value="2">Change Out Time</option>
                            </select><span id="spandrptickettype" style="color: red; font-size: 15px"></span>
                        </div>

                    
                        <div class="col-sm-4">
                            <label class="form-label">Date <sup><i class="fa fa-asterisk" aria-hidden="true" style="color: red; font-size: 10px;"></i></sup></label>
                        
                            <select class="js-example-basic-single" id="drpDates">
                            </select><span id="spandrpDates" style="color: red; font-size: 15px"></span>
                        </div>

                    </div>
                    <div class="row g-3" style="padding-bottom: 10px;">
                        <div class="col-sm-4">
                            <label class="form-label">Time <sup><i class="fa fa-asterisk" aria-hidden="true" style="color: red; font-size: 10px;"></i></sup></label>
                        
                            <input type="time" class="form-control" id="txttime" /><span id="spantxttime" style="color: red; font-size: 15px"></span>
                        </div>

                    
                        <div class="col-sm-4">
                            <label class="form-label">Reason</label>
                        
                            <textarea class="form-control" id="txtreason" placeholder="Reason"></textarea>
                            <span id="spantxtreason" style="color: red; font-size: 15px"></span><span id="spantxtreason1" style="color: red; font-size: 15px"></span>
                        </div>

                    </div>

                    <div class="row g-3">
                        <div class="col-sm-12">
                            <center>
                                <button type="button" class="btn btn-primary" onclick="SaveReq();" id="btnSubmit">Submit</button>
                                <button type="button" class="btn btn-dark" onclick="Cancel();">Cancel</button>
                            </center>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!--Knockout Script-->
    <script src="js/knockout-3.5.1.js" type="text/javascript"></script>
    <script src="js/knockout.mapping-latest-2.4.1.js" type="text/javascript"></script>
    <script src="js/knockout.validation-2.0.4.js" type="text/javascript"></script>

    <script type="text/javascript">

        var Ticketgs = function () {
            var self = this;
            self.SupportId = ko.observable(0);
            self.SupportTypeId = ko.observable(0);
            self.Eid = ko.observable(0);
            self.Date = ko.observable('');
            self.Time = ko.observable('');
            self.Reason = ko.observable('');
            self.SupportType = ko.observable('');

        };

    </script>
</asp:Content>

