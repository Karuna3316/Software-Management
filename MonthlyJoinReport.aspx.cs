using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MonthlyJoinReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    [WebMethod]
    public static MonthDrp1[] Getmonthdrp()
    {
        try
        {

            return MonthJoinReportDAL.GetMonthdrp();
        }
        catch (Exception ex)
        {
            Utilities.LogErrorToFile("Error in MonthlyJoinReport_Getmonthdrp(): " + ex.Message);
            throw (ex);
        }
    }

    [WebMethod]
    public static YearDrp1[] Getyeardrp()
    {
        try
        {

            return MonthJoinReportDAL.GetYeardrp();
        }
        catch (Exception ex)
        {
            Utilities.LogErrorToFile("Error in MonthlyJoinReport_Getyeardrp(): " + ex.Message);
            throw (ex);
        }
    }

    [WebMethod]
    public static lstEmployeeObj GetMonthJoinReportList(int year, int month)
    {
        try
        {
            return MonthJoinReportDAL.GetMonthJoinReportList(year, month);
        }
        catch (Exception ex)
        {
            Utilities.LogErrorToFile("Error in MonthlyJoinReport_GetMonthJoinReportList(): " + ex.Message);
            throw (ex);
        }
    }
}