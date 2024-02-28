<%@ Page Title="" Language="C#" MasterPageFile="~/YEEMAKHRMS.master" AutoEventWireup="true" CodeFile="EmployeeMaster.aspx.cs" Inherits="EmployeeMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        button:focus {
            outline: none !important;
            background: none;
        }

        th {
            text-align: center;
        }

        .table {
            padding: 0px;
            margin: 0px;
            width: 2040px;
        }

        .table-responsive {
            width: 99%;
            padding: 0px;
            margin: 0px;
            overflow-x: hidden;
            overflow-y: hidden;
            padding-left: 10px;
        }

        .dt-responsive table-responsive {
            height: auto;
            width: 10%;
            overflow-y: hidden;
            border-radius: 5px;
            margin: 0 auto;
        }

        tbody, td, tfoot, th, thead, tr {
            border-color: inherit;
            border-style: solid;
            border-width: 0;
            padding: 10px;
        }

            tr td:nth-child(2) {
                position: -webkit-sticky;
                position: sticky;
                width: 120px;
                left: 53px;
                right: 0px;
                z-index: 2;
                color: #000;
                background: #fff;
            }

            th:nth-child(2) {
                position: -webkit-sticky;
                position: sticky;
                width: 120px;
                left: 53px;
                right: 0px;
                z-index: 2;
                color: #fff;
                background: #fff;
            }

            tr td:nth-child(3) {
                position: -webkit-sticky;
                position: sticky;
                width: 120px;
                left: 135px;
                right: 0px;
                z-index: 2;
                color: #000;
                background: #fff;
            }

            th:nth-child(3) {
                position: -webkit-sticky;
                position: sticky;
                width: 120px;
                left: 135px;
                right: 0px;
                z-index: 2;
                color: #fff;
                background: #fff;
            }

            tr td:nth-child(4) {
                position: -webkit-sticky;
                position: sticky;
                width: 120px;
                left: 245px;
                right: 0px;
                z-index: 2;
                color: #000;
                background: #fff;
            }

            th:nth-child(4) {
                position: -webkit-sticky;
                position: sticky;
                width: 120px;
                left: 245px;
                right: 0px;
                z-index: 2;
                color: #fff;
                background: #fff;
            }

            tr td:nth-child(5) {
                position: -webkit-sticky;
                position: sticky;
                width: 120px;
                left: 380px;
                right: 0px;
                z-index: 2;
                color: #000;
                background: #fff;
            }

            th:nth-child(5) {
                position: -webkit-sticky;
                position: sticky;
                width: 120px;
                left: 380px;
                right: 0px;
                z-index: 2;
                color: #fff;
                background: #fff;
            }

            tr td:nth-child(1) {
                position: -webkit-sticky;
                position: sticky;
                width: 120px;
                left: -11px;
                right: 25px;
                z-index: 2;
                color: #000;
                background: #fff;
            }

            th:nth-child(1) {
                position: -webkit-sticky;
                position: sticky;
                width: 120px;
                left: -11px;
                right: 25px;
                z-index: 2;
                color: #fff;
                background: #fff;
            }

        .table-responsive {
            display: inline-block;
            width: 100%;
            overflow-x: hidden;
            overflow-y: hidden;
        }

        tbody tr th {
            position: sticky;
        }

        .table-striped > tbody > tr:nth-child(odd) > td, .table-striped > tbody > tr:nth-child(odd) > th {
            background-color: #f9f9f9;
        }
    </style>
    <script>

        (function (root, factory) {
            if (typeof define === 'function' && define.amd) {
                define(['exports'], factory);
            } else if (typeof exports !== 'undefined') {
                factory(exports);
            } else {
                factory((root.dragscroll = {}));
            }
        }(this, function (exports) {
            var _window = window;
            var _document = document;
            var mousemove = 'mousemove';
            var mouseup = 'mouseup';
            var mousedown = 'mousedown';
            var EventListener = 'EventListener';
            var addEventListener = 'add' + EventListener;
            var removeEventListener = 'remove' + EventListener;
            var newScrollX, newScrollY;

            var dragged = [];
            var reset = function (i, el) {
                for (i = 0; i < dragged.length;) {
                    el = dragged[i++];
                    el = el.container || el;
                    el[removeEventListener](mousedown, el.md, 0);
                    _window[removeEventListener](mouseup, el.mu, 0);
                    _window[removeEventListener](mousemove, el.mm, 0);
                }

                // cloning into array since HTMLCollection is updated dynamically
                dragged = [].slice.call(_document.getElementsByClassName('table-responsive'));
                for (i = 0; i < dragged.length;) {
                    (function (el, lastClientX, lastClientY, pushed, scroller, cont) {
                        (cont = el.container || el)[addEventListener](
                            mousedown,
                            cont.md = function (e) {
                                if (!el.hasAttribute('nochilddrag') ||
                                    _document.elementFromPoint(
                                        e.pageX, e.pageY
                                    ) == cont
                                ) {
                                    pushed = 1;
                                    lastClientX = e.clientX;
                                    lastClientY = e.clientY;

                                    e.preventDefault();
                                }
                            }, 0
                        );

                        _window[addEventListener](
                            mouseup, cont.mu = function () { pushed = 0; }, 0
                        );

                        _window[addEventListener](
                            mousemove,
                            cont.mm = function (e) {
                                if (pushed) {
                                    (scroller = el.scroller || el).scrollLeft -=
                                        newScrollX = (-lastClientX + (lastClientX = e.clientX));
                                    scroller.scrollTop -=
                                        newScrollY = (-lastClientY + (lastClientY = e.clientY));
                                    if (el == _document.body) {
                                        (scroller = _document.documentElement).scrollLeft -= newScrollX;
                                        scroller.scrollTop -= newScrollY;
                                    }
                                }
                            }, 0
                        );
                    })(dragged[i++]);
                }
            }


            if (_document.readyState == 'complete') {
                reset();
            } else {
                _window[addEventListener]('load', reset, 0);
            }

            exports.reset = reset;
        }));


    </script>
    <script type="text/javascript">

        $(document).ready(function () {

            GetEmployeeReport();
        });

        function GetEmployeeReport() {
            $.ajax({

                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "EmployeeMaster.aspx/GetEmployeeReport",
                dataType: "json",
                success: function (data) {
                    formDocument().objEMP().constructor();
                    if ($.fn.dataTable.isDataTable('#basic-btn')) {
                        $('#basic-btn').DataTable().clear().destroy();
                    }
                    ko.mapping.fromJS(data.d, null, formDocument);
                    $('#basic-btn').DataTable({
                        "paging": false,
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
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="page-content">
        <div class="page-breadcrumb d-none d-sm-flex align-items-center mb-3">
            <div class="ps-3">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-0 p-0 align-items-center">
                        <li class="breadcrumb-item">REPORTS</li>
                        <li class="breadcrumb-item active" aria-current="page">Employee Master</li>
                    </ol>
                </nav>
            </div>
        </div>


        <div class="card" style="padding: 10px;">
            <div class="card-body">
                <div class="border p-3 rounded">
                    <div class="dt-responsive table-responsive ">
                        <table id="basic-btn" class="table table-striped table-bordered" style="width: 100%" data-bind="visible: formDocument().objEMP().length > 0">
                            <thead>
                                <tr role="row">
                                    <th>Type</th>
                                    <th>Role</th>
                                    <th>Device Code</th>
                                    <th>Employee Code</th>
                                    <th>Employee Name</th>
                                    <th>Department</th>
                                    <th>Designation</th>
                                    <th>Date Of Birth</th>
                                    <th>Date Of Joining</th>
                                    <th>Email</th>
                                    <th>Phone No</th>
                                    <th>Gender</th>
                                    <th>Marital Status</th>
                                    <th>Father's Or Husband Name</th>
                                    <th>Emergency Contact Number</th>
                                    <th>Emergency Contact Person Name</th>
                                    <th>RelationShip</th>
                                    <th>Qualification</th>
                                    <th>Nationality</th>
                                    <th>Wages</th>
                                    <th>UAN Number</th>
                                    <th>ESIC Number</th>
                                    <th>Bank Account Number</th>
                                    <th>IFSC Code</th>
                                    <th>Aadhar Number</th>
                                    <th>Name as per Aadhar Card</th>
                                    <th>PAN Number</th>
                                    <th>Name as per PAN Card</th>
                                    <th>Permanent Address</th>
                                    <th>Communication Address</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody data-bind="foreach: formDocument().objEMP()" id="body">
                                <tr>
                                    <td><span data-bind="text: Type"></span></td>
                                    <td><span data-bind="text: RoleId"></span></td>
                                    <td><span data-bind="text: Devicecode"></span></td>
                                    <td><span data-bind="text: IDCARDNO"></span></td>
                                    <td><span data-bind="text: UserName"></span></td>
                                    <td><span data-bind="text: Department"></span></td>
                                    <td><span data-bind="text: Designation"></span></td>
                                    <td style="text-align: center;"><span data-bind="text: DOB"></span></td>
                                    <td style="text-align: center;"><span data-bind="text: DOJ"></span></td>
                                    <td><span data-bind="text: EmailId"></span></td>
                                    <td><span data-bind="text: Phone"></span></td>
                                    <td><span data-bind="text: Gender"></span></td>
                                    <td><span data-bind="text: MartialStatus"></span></td>
                                    <td><span data-bind="text: FatherName"></span></td>
                                    <td><span data-bind="text: EmergencyCNumber"></span></td>
                                    <td><span data-bind="text: EmergencyCName"></span></td>
                                    <td><span data-bind="text: Relationship"></span></td>
                                    <td><span data-bind="text: Qualification"></span></td>
                                    <td><span data-bind="text: Nationality"></span></td>
                                    <td style="text-align:right;"><span data-bind="text: Wages"></span></td>
                                    <td><span data-bind="text: UAN"></span></td>
                                    <td><span data-bind="text: ESIC"></span></td>
                                    <td><span data-bind="text: BankAccountNo"></span></td>
                                    <td><span data-bind="text: BankIFSC"></span></td>
                                    <td><span data-bind="text: AadharNo"></span></td>
                                    <td><span data-bind="text: AadharName"></span></td> 
                                    <td><span data-bind="text: PanNo"></span></td>
                                    <td><span data-bind="text: PanName"></span></td>
                                    <td><span data-bind="text: PermanentAddress"></span></td>
                                    <td><span data-bind="text: CommunicationAddress"></span></td>
                                    <td><span data-bind="text: Active"></span></td>
                                </tr>
                            </tbody>

                        </table>

                    </div>
                    <input type="hidden" id="userId" value="0">
                </div>
            </div>
        </div>
    </div>

    <!--Knockout Script-->
    <script src="js/knockout-3.5.1.js" type="text/javascript"></script>
    <script src="js/knockout.mapping-latest-2.4.1.js" type="text/javascript"></script>
    <script src="js/knockout.validation-2.0.4.js" type="text/javascript"></script>

    <script type="text/javascript">
        var lstEmployeeObj = function () {

            this.objEMP = ko.observableArray([{
                userId: 0, Type: '', RoleId: '', Devicecode: '', IDCARDNO: '', UserName: '', Department: '', Designation: '', DOB: '', DOJ: '', EmailId: '', Phone: '',
                Gender: '', MartialStatus: '', FatherName: '', EmergencyCNumber: '', EmergencyCName: '', Relationship: '', Qualification: '', Nationality: '', Wages: '',
                UAN: '', ESIC: '', BankAccountNo: '', BankIFSC: '', AadharNo: '', AadharName: '', PermanentAddress: '', CommunicationAddress: '', Active: '', PanName: '', PanNo:''
            }]);
        };
        formDocument = ko.observable(new lstEmployeeObj());
        ko.applyBindings(new lstEmployeeObj(), document.getElementById("basic-btn"));
    </script>
</asp:Content>

