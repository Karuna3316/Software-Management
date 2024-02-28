<%@ Page Title="" Language="C#" MasterPageFile="~/YEEMAKHRMS.master" AutoEventWireup="true" CodeFile="MonthlyAttendanceLog.aspx.cs" Inherits="MonthlyAttendanceLog" %>

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

    
      <!--PNotify-->
    <link rel="stylesheet" type="text/css" href="files/bower_components/pnotify/dist/pnotify.css" />
    <link rel="stylesheet" type="text/css" href="files/bower_components/pnotify/dist/pnotify.brighttheme.css" />
    <link rel="stylesheet" type="text/css" href="files/bower_components/pnotify/dist/pnotify.buttons.css" />
    <link rel="stylesheet" type="text/css" href="files/bower_components/pnotify/dist/pnotify.history.css" />
    <link rel="stylesheet" type="text/css" href="files/bower_components/pnotify/dist/pnotify.mobile.css" />
    <link rel="stylesheet" type="text/css" href="files/assets/pages/pnotify/notify.css" />
        <link rel="stylesheet" type="text/css" href="files/assets/pages/pnotify/notify.css" />


        <link href="files/assets/css/sweetalert.css" rel="stylesheet" />



        <script src="assets/js/jquery-3.6.0.min.js"></script>
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
            overflow-y: auto;
            border-radius: 5px;
            margin: 0 auto;
        }

        tbody, td, tfoot, th, thead, tr {
            border-color: inherit;
            border-style: solid;
            border-width: 0;
            padding:10px;
        }

        .table > thead > tr > th, .table > tbody > tr > th, .table > tfoot > tr > th, .table > thead > tr > td, .table > tbody > tr > td, .table > tfoot > tr > td {
            padding: 0px !important;
            line-height: 1.42857143;
            vertical-align: middle;
            border-top: 1px solid #ddd;
            font-size: 13px;
            text-align: left;
        }



        .table > thead > tr > th, .table > tbody > tr > th, .table > tfoot > tr > th, .table > thead > tr > td, .table > tbody > tr > td, .table > tfoot > tr > td {
            padding: 0px !important;
            line-height: 1.42857143;
            vertical-align: middle;
            border-top: 1px solid #ddd;
            font-size: 13px;
            text-align: left;
        }


        th:first-child {
            position: -webkit-sticky;
            position: sticky;
            left: -13px;
            z-index: 1;
            width: 120px;
            background: #923eb9;
            color: #fff;
        }

        td:first-child {
            position: -webkit-sticky;
            position: sticky;
            left: -13px;
            z-index: 1;
            background: #923eb9;
            color: #fff;
            width: 120px;
        }

        td:nth-child(2) {
            position: -webkit-sticky;
            position: sticky;
            left: 0;
            z-index: 1;
        }

        thead tr th {
            position: sticky;
            top: 0;
        }

        th {
            background: #923eb9;
            font-size: 16px;
            border: 1px solid #fff !important;
        }

        td {
            border: 1px solid #fff;
            color: black;
        }


        tr td:nth-child(2) {
            position: -webkit-sticky;
            position: sticky;
            width: 120px;
            left: 96px;
            right: 0px;
            z-index: 2;
            background: #923eb9;
            color: #fff;
        }

        th:nth-child(2) {
            position: -webkit-sticky;
            position: sticky;
            width: 120px;
            left: 96px;
            right: 0px;
            z-index: 2;
            background: #923eb9;
            color: #fff;
        }

        .table-bordered > thead > tr > th, .table-bordered > tbody > tr > th, .table-bordered > tfoot > tr > th, .table-bordered > thead > tr > td, .table-bordered > tbody > tr > td, .table-bordered > tfoot > tr > td {
            border: 1px solid #ddd;
            background: #fff;
        }

        .table-responsive {
            display: inline-block;
            width: 100%;
            overflow-x: auto;
            overflow-y: auto;
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
     <script>
        $(document).ready(function() {
            $('.js-example-basic-single').select2();

            $('#smart').hide();

            var drpC = $('#ContentPlaceHolder1_drpMonth');
            var drpY = $('#ContentPlaceHolder1_drpYear');
            if ((drpC[0].value != 0) && (drpY[0].value != 0)) {

                $('#smart').show();

            }

            
        });


         function isMonthExists() {
             var drpC = $('#ContentPlaceHolder1_drpMonth');
             var lblErr = $('#lblErrMsg');
             var lblErr1 = $('#lblErrMsg1');
             var drpY = $('#ContentPlaceHolder1_drpYear');


             if (drpC[0].value == 0) {
                 lblErr[0].style.display = "block";

                 lblErr[0].innerText = "Select Month";
                 $('#smart').hide();
                 $('#myInput').hide();

                 return false;
             }
             else {
                 lblErr[0].innerText = "";
                 $('#smart').show();
                 $('#myInput').show();
             }
             if (drpY[0].value == 0) {
                 lblErr1[0].style.display = "block";
                 $('#smart').hide();
                 $('#myInput').hide();

                 lblErr1[0].innerText = "Select Year";


                 return false;
             }
             else
                 lblErr1[0].innerText = "";
             $('#smart').Show();
             if ((drpC[0].value != 0) && (drpY[0].value != 0)) {

                 $('#smart').show();
                 $('#myInput').show();

             }


         }

         function hideSpan() {
             var selectElement = $('#ContentPlaceHolder1_drpMonth');
             var spanToHide = document.getElementById("lblErrMsg");

             if (selectElement.value != '0') {
                 spanToHide.style.display = "none";
             } else {
                 spanToHide.style.display = "block";
             }
         }

         function hideyearspan() {
             var selectElement = $('#ContentPlaceHolder1_drpYear');
             var spanToHide1 = document.getElementById("lblErrMsg1");

             if (selectElement.value != '0') {
                 spanToHide1.style.display = "none";
             } else {
                 spanToHide1.style.display = "block";
             }
         }

         function myFunction() {
             // Declare variables
             var input, filter, table, tr, td, i, txtValue;
             input = document.getElementById("myInput");
             filter = input.value.toUpperCase();
             table = document.getElementById("ContentPlaceHolder1_grdMonth");
             tr = table.getElementsByTagName("tr");

             // Loop through all table rows, and hide those who don't match the search query
             var rRes = [];
             var rDa = 0, rH = 0;
             for (j = 0; j < 5; j++) {
                 for (i = 0; i < tr.length; i++) {
                     td = tr[i].getElementsByTagName("td")[j];
                     if (td) {
                         txtValue = td.textContent || td.innerText;
                         if (j == 4 && $(td).find("#sSta") != null && $(td).find("#sSta").text() != "")
                             txtValue = $(td).find("#sSta").text()
                         if (txtValue.toUpperCase().indexOf(filter) > -1) {
                             rRes[rDa] = i;
                             rDa = rDa + 1;
                             //tr[i].style.display = "";
                         } else {

                             //tr[i].style.display = "none";
                         }
                     }
                 }
             }
             //for (s = 0; s < rRes.length; s++) {
             //    tr[rRes[s]].style.display = "";
             //}
             var rNoR = [];
             var rH = 0;

             for (i = 1; i < tr.length; i++) {
                 var rowPresent = false;
                 for (k = 0; k < rRes.length; k++) {
                     if (rRes[k] == i)
                         rowPresent = true;
                 }
                 if (!rowPresent) {
                     rNoR[rH] = i;
                     rH++;
                 }
             }
             //alert(rNoR.length);
             //alert(rRes.length);
             for (s = 0; s < rNoR.length; s++) {
                 tr[rNoR[s]].style.display = "none";
             }
             if (rNoR.length == 0) {
                 for (i = 1; i < tr.length; i++) {
                     tr[i].style.display = "";
                 }
             }
             //alert(rNoR.length);
             $("#myInput").on('mouseup', function (e) {
                 var $input = $(this),
                     oldValue = $input.val();
                 if (oldValue === '') {
                     return;
                 }
                 // When this event is fired after clicking on the clear button // the value is not cleared yet. We have to wait for it.
                 setTimeout(function () {
                     var newValue = $input.val();
                     if (newValue === '') {
                         if (rNoR.length == 0) {
                             for (i = 1; i < tr.length; i++) {
                                 tr[i].style.display = "";
                             }
                         }
                         //$input[0].typeahead('val', '');
                         e.preventDefault();
                     }
                 }, 1);
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
                        <li class="breadcrumb-item"><a href="dashboard.aspx">
                            <ion-icon name="home-outline" role="img" class="md hydrated" aria-label="home outline"></ion-icon>
                        </a>
                        </li>
                        <li class="breadcrumb-item active" aria-current="page">Monthly Attendance</li>
                    </ol>
                </nav>
            </div>
        </div>

        <div class="card" style="padding: 10px;">
            <div class="card-body">
                <div class="border p-3 rounded">

                    <div class="row g-3" style="padding-bottom: 10px;">
                        <div class="col-3">
                            <label class="form-label">Month</label>

                            <select runat="server" class="js-example-basic-single col-sm-12 select2-hidden-accessible" tabindex="-1" aria-hidden="true" style="font-size: initial;" id="drpMonth" onchange="hideSpan()">
                                <option value="0">Select Month</option>
                                <option value="1">January</option>
                                <option value="2">February</option>
                                <option value="3">March</option>
                                <option value="4">April</option>
                                <option value="5">May</option>
                                <option value="6">June</option>
                                <option value="7">July</option>
                                <option value="8">August</option>
                                <option value="9">September</option>
                                <option value="10">October</option>
                                <option value="11">November</option>
                                <option value="12">December</option>
                            </select>
                            <span id="lblErrMsg" style="color: red; font-size: 16px; line-height: 45px;"></span>
                        </div>

                    <div class="col-3">
                        <label class="form-label">Year</label>
                        <select runat="server" class="js-example-basic-single col-sm-12 select2-hidden-accessible" tabindex="-1" aria-hidden="true" style="font-size: initial;" id="drpYear" onchange="hideyearspan()">
                            <option value="0">Select Year</option>
                            <option value="2021">2021</option>
                            <option value="2022">2022</option>
                            <option value="2023">2023</option>
                            <option value="2024">2024</option>
                        </select>
                        <span id="lblErrMsg1" style="color: red; font-size: 16px; line-height: 45px;"></span>
                    </div>
                        <div class="col-1"></div>
                        <div class="col-2" style="line-height: 115px;">
                            <asp:Button type="button" class="btn btn-primary" Text="Submit" Style="font-size: 16px; height: 46px;" ID="btnShow" runat="server" OnClick="btnShow_Click" OnClientClick="return isMonthExists();" />

                        </div>
                        <div class="col-1" style="line-height: 115px;">
                            <asp:Button runat="server" ID="btnReset" type="button" Text="Reset" OnClick="btnReset_Click" class="btn btn-dark" Style="font-size: 16px; height: 46px;" />

                        </div>

                    </div>


                </div>
            </div>
             <p class="help-block">
                                    <label id="lblResponse" runat="server" style="color: red; height: 29px; width: 163px; font-size: 15px"></label>
                                </p>
 

              <div class="card-body" id="smart" runat="server">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="card">
                                    <div class="card-block"  >
                                        <div class="access" style="padding: 20px 14px 20px 12px;">
                                            <asp:Button ID="btnExport" type="button" class="btn mb-1 btn-flat btn-primary" runat="server" Text="Download" OnClick="btnExport_Click" />

                                            <span style="padding-left: 50px;">
                                                <input type="text" id="myInput" onkeyup="myFunction()" placeholder="Search.." autocomplete="off" title="type here to search" onchange="myFunction()" style="color: #434a54; height: 36px; float: right; font-size: 16px; border: 1px solid #923eb9; border-radius:6px;" /></span>
                                        </div>
                                        <div class="dt-responsive table-responsive">

                                            <table id="tblData" runat="server" class="table table-striped table-bordered nowrap" style="width: auto;">
                                                <thead>
                                                    <tr>
                                                        <td style="background: #fff;">
                                                            <asp:GridView ID="grdMonth" runat="server" HeaderStyle-CssClass="header"></asp:GridView>
                                                        </td>
                                                    </tr>
                                                </thead>
                                            </table>
                                        </div>

                                    </div>
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
</asp:Content>

