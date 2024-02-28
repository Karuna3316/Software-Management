<%@ Page Title="" Language="C#" MasterPageFile="~/YEEMAKHRMS.master" AutoEventWireup="true" CodeFile="TicketList.aspx.cs" Inherits="TicketList" %>

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
            var objUrlParams = new URLSearchParams(window.location.search);
            var flagId = objUrlParams.get('flagId');
            if (flagId == 1) {
                new PNotify({
                    title: 'Registered',
                    text: 'Saved successfully...',
                    icon: 'icofont icofont-info-circle',
                    type: 'success'
                });
            }
            GetTicketList();

        });

        function GetTicketList() {

            $.ajax({

                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "TicketList.aspx/GetTicketList",
                data: "{}",
                dataType: "json",
                success: function (data) {

                    TicketObj().Ticketlsobj().constructor();
                    if ($.fn.dataTable.isDataTable('#tblticket')) {
                        $('#tblticket').DataTable().clear().destroy();
                    }
                    ko.mapping.fromJS(data.d, null, TicketObj);
                    $('#tblticket').DataTable({
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

        function Add() {
            location.href = "Ticket.aspx";
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

        <div class="card">
            <div class="access" style="padding: 20px 10px 10px 10px;">
                <button type="button" class="btn btn-primary" onclick="Add()" style="float: right;">Add</button>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table id="tblticket" class="table table-striped table-bordered" style="width: 100%" data-bind="visible: TicketObj().Ticketlsobj().length > 0">
                        <thead>
                            <tr role="row">
                                <th>Employee Name</th>
                                <th>Ticket Type</th>
                                <th>Date</th>
                                <th>Time</th>
                                <th>Reason</th>

                            </tr>
                        </thead>
                        <tbody data-bind="foreach: TicketObj().Ticketlsobj()">
                            <tr>
                                <td><span data-bind="text: Employeename"></span></td>
                                <td><span data-bind="text: SupportType"></span></td>
                                <td style="text-align: center;"><span data-bind="text: Date"></span></td>
                                <td style="text-align: center;"><span data-bind="text: Time"></span></td>
                                <td><span data-bind="text: Reason"></span></td>

                            </tr>
                        </tbody>

                    </table>

                </div>

            </div>
        </div>
    </div>

    <!--Knockout Script-->
    <script src="js/knockout-3.5.1.js" type="text/javascript"></script>
    <script src="js/knockout.mapping-latest-2.4.1.js" type="text/javascript"></script>
    <script src="js/knockout.validation-2.0.4.js" type="text/javascript"></script>

    <script type="text/javascript">
        var lstTicketObj = function () {
            var self = this;


            this.Ticketlsobj = ko.observableArray([{
                SupportId: 0, Employeename: '', Date: '', Time: '', Reason: '', SupportType: ''

            }]);
        };
        TicketObj = ko.observable(new lstTicketObj());
        ko.applyBindings(new lstTicketObj(), document.getElementById("tblticket"));

    </script>
</asp:Content>

