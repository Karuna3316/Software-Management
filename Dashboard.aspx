<%@ Page Title="" Language="C#" MasterPageFile="~/YEEMAKHRMS.master" AutoEventWireup="true" CodeFile="Dashboard.aspx.cs" Inherits="Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
       .div {
  height: 200px;
  width: 220px;
}
      /* .col-sm-4{
           box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 29px 0px;
       }*/
      table, th, td,tr {
  border: 1px solid black;
  text-align:center;
  padding-top:25px;
}
        .page-content {
            height:auto !important;
            min-height:100%;
        }
        .canvasjs-chart-credit {
            display:none !important;
        }
    </style>
    <script type="text/javascript" src="https://cdn.canvasjs.com/canvasjs.min.js">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
    <script>
        $(document).ready(function () {
                var chart = new CanvasJS.Chart("chartContainer",
                    {
                        data: [
                            {
                                type: "pie",
                                showInLegend: true,
                                toolTipContent: "{y} - #percent %",
                                yValueFormatString: "#,##0,,.## Million",
                                legendText: "{indexLabel}",
                                dataPoints: [
                                    { y: 4181563, indexLabel: "Male 3" },
                                    { y: 2175498, indexLabel: "Female" },
                                ]
                            }
                        ]
                    });
                chart.render();
            

        });

        var chartData = {
            labels: ["January", "February", "March", "April", "May", "June", "July"],
            datasets: [
                {
                    type: "line",
                    label: "Dataset 1",
                    borderColor: 'rgb(54, 162, 235)',
                    borderWidth: 2,
                    fill: false,
                    data: [
                        10,
                        12,
                        8,
                        4,
                        3,
                        7,
                        24
                    ]
                },
                {
                    type: "bar",
                    label: "Dataset 2",
                    backgroundColor: 'rgb(255, 99, 132)',
                    data: [
                        21,
                        34,
                        12,
                        7,
                        90,
                        13,
                        78
                    ],
                    borderColor: "white",
                    borderWidth: 2
                }
            ]
        };
        window.onload = function () {
            var ctx = document.getElementById("canvas").getContext("2d");
            window.myMixedChart = new Chart(ctx, {
                type: "bar",
                data: chartData,
                options: {
                    responsive: true,
                    title: {
                        display: true,
                        text: "Chart.js Combo Bar Line Chart"
                    },
                    tooltips: {
                        mode: "index",
                        intersect: true
                    }
                }
            });
        };
           
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
                        <li class="breadcrumb-item active" aria-current="page">Dashboard</li>
                    </ol>
                </nav>
            </div>
        </div>
        <div class="row row-cols-1 row-cols-lg-2 row-cols-xxl-4">
          <div class="col-sm-3">
            <div class="card radius-10">
              <div class="card-body">
                  <div class="form-group row">
                      <div class="col-sm-8">
                          <div>
                              <p class="mb-0">Total Employees</p>
                          </div>
                          <div class="d-flex align-items-center mt-3" style="position: relative;">
                              <div>
                                  <h5 class="mb-0" style="margin-left: 25px;">237</h5>
                              </div>
                          </div>
                      </div>
                      <div class="col-sm-4" style="text-align:center;align-self:center">
                          <div class="fs-25">
                    <i class="fa fa-users" style="font-size:26px"></i>
                  </div>
                  </div>
                  </div>
                </div>
            </div>
          </div>
          <div class="col-sm-3">
            <div class="card radius-10">
              <div class="card-body">
                  <div class="form-group row">
                      <div class="col-sm-8">
                          <div>
                    <p class="mb-0">Present</p>
                  </div>
                          <div class="d-flex align-items-center mt-3" style="position: relative;">
                              <div>
                                  <h5 class="mb-0" style="margin-left: 25px;">237</h5>
                              </div>
                          </div>
                      </div>
                      <div class="col-sm-4" style="text-align:center;align-self:center">
                          <div class="fs-25">
                    <i class="icon-user-following" style="font-size:26px"></i>
                  </div>
                  </div>
                  </div>

                
                
              </div>
            </div>
          </div>
          <div class="col-sm-3">
            <div class="card radius-10">
              <div class="card-body">
                  <div class="form-group row">
                      <div class="col-sm-8">
                          <div>
                    <p class="mb-0">Absent</p>
                  </div>
                          <div class="d-flex align-items-center mt-3" style="position: relative;">
                              <div>
                                  <h5 class="mb-0" style="margin-left: 25px;">237</h5>
                              </div>
                          </div>
                      </div>
                      <div class="col-sm-4" style="text-align:center;align-self:center">
                          <div class="fs-25">
                    <i class="icon-user-unfollow" style="font-size:26px"></i>
                  </div>
                  </div>
                  </div>
              </div>
            </div>
          </div>
          <div class="col-sm-3">
            <div class="card radius-10">
              <div class="card-body">
                  <div class="form-group row">
                      <div class="col-sm-8">
                          <div>
                    <p class="mb-0">No of Holidays</p>
                  </div>
                          <div class="d-flex align-items-center mt-3" style="position: relative;">
                              <div>
                                  <h5 class="mb-0" style="margin-left: 25px;">237</h5>
                              </div>
                          </div>
                      </div>
                      <div class="col-sm-4" style="text-align:center;align-self:center">
                          <div class="fs-25">
                    <i class="fa fa-list-ol" style="font-size:26px"></i>
                  </div>
                  </div>
                  </div>
                
              </div>
            </div>
          </div>
        </div>

        <div class="row">
            <div class="col-sm-12">
            <div class="form-group row">
            <div class="col-sm-8">
                <div class="form-group row">
                    <div class="col-sm-6">
                <div class="card">
                    <div class="card-block" style="padding:10px;">
                        <div id="graph">
                    <canvas id="canvas"></canvas>
                </div>
                    </div>
                </div>
                
            </div>
                    <div class="col-sm-6">
                <div class="card">
                    <div class="card-block" style="padding:10px;">
                <div id="chartContainer" style="height: 240px; width: 100%;">

                </div>
</div>
                </div>
            </div>
                </div>
                <div class="form-group row">
                    <div class="col-sm-6">
                        <div class="card">
                    <div class="card-block" style="padding:10px;">
                <table class="table table-striped table-bordered" style="width: 100%;">
                    <thead>
                            <tr>
                                <th colspan="3">New Employee</th>
                            </tr>
                            <tr>
                                <th>Name</th>
                                <th>Date Of Joining</th>
                                <th>Type</th>
                            </tr>
                        </thead>
                    <tbody>
                            <tr>
                                <td>seri</td>
                                <td>1</td>
                                <td>sa</td>
                            </tr>
                            <tr>
                                <td>okay</td>
                                <td>5</td>
                                <td>df</td>
                            </tr>
                            <tr>
                                <td>Hmm</td>
                                <td>4</td>
                                <td>lko</td>
                            </tr>
                            </tbody>
                        </table>
                        </div>
                            </div>
            </div>
            <div class="col-sm-6">
                <div class="card">
                    <div class="card-block" style="padding:10px;">
                <table class="table table-striped table-bordered" style="width: 100%;">
                    <thead>
                            <tr>
                                <th colspan="3">New Employee</th>
                            </tr>
                            <tr>
                                <th>Name</th>
                                <th>Date Of Joining</th>
                                <th>Type</th>
                            </tr>
                        </thead>
                    <tbody>
                            <tr>
                                <td>seri</td>
                                <td>1</td>
                                <td>sa</td>
                            </tr>
                            <tr>
                                <td>okay</td>
                                <td>5</td>
                                <td>df</td>
                            </tr>
                            <tr>
                                <td>Hmm</td>
                                <td>4</td>
                                <td>lko</td>
                            </tr>
                            </tbody>
                        </table>
            </div>
                    </div>
                </div>
                </div>
            </div>
            <div class="col-sm-4">
                <div class="card">
                    <div class="card-block" style="padding:10px;">
                <div class="form-group row">

                    <div class="col-sm-12">
                <table class="table table-striped table-bordered" style="width: 100%">
                    <thead>
                        <tr>
                            <th colspan="2">Department</th>
                        </tr>
                        <tr>
                            <th>Name</th>
                            <th>Count</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>gfdd</td>
                            <td>dd</td>
                        </tr>
                        <tr>
                            <td>wd</td>
                            <td>wef</td>
                        </tr>
                        

                    </tbody>
                </table>
            </div>
                    </div>
                        </div>
                </div>
            </div>
            
            
           </div> 
        </div>
            </div>
        
        <div class="card">
            <div class="card-body">
                
                    <div class="row">
                <div class="col-sm-12">
                    <h4>Present Details Today</h4>
                    <table class="table table-striped table-bordered" style="width: 100%; margin-top:25px;">
                        <thead>
                            
                            <tr>
                                <th>Emp ID</th>
                                <th>Name</th>
                                <th>Department</th>
                                <th>Check In</th>
                                <th>Check Out</th>
                            </tr>
                            </thead>
                        <tbody>
                            <tr>
                                <td>hgjfg.</td>
                                <td></td>
                                <td>hgjfg.</td>
                                <td>hgjfg.</td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>hgjfg.</td>
                                <td></td>
                                <td>hgjfg.</td>
                                <td>hgjfg.</td>
                                <td></td>
                            </tr><tr>
                                <td>hgjfg.</td>
                                <td></td>
                                <td>hgjfg.</td>
                                <td>hgjfg.</td>
                                <td></td>
                            </tr>
                            </tbody>
                            
                        </table>
                </div>
                    </div>
                </div>
            </div>
    </div>

</asp:Content>

