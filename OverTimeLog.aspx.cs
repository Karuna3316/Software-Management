using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class OverTimeLog : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod]
    public static MonthDrp[] Getmonthdrp()
    {
        try
        {

            return OverTimeLogDAL.GetMonthdrp();
        }
        catch (Exception ex)
        {
            Utilities.LogErrorToFile("Error in OverTimeLog_Getmonthdrp(): " + ex.Message);
            throw (ex);
        }
    }

    [WebMethod]
    public static YearDrp[] Getyeardrp()
    {
        try
        {

            return OverTimeLogDAL.GetYeardrp();
        }
        catch (Exception ex)
        {
            Utilities.LogErrorToFile("Error in OverTimeLog_Getyeardrp(): " + ex.Message);
            throw (ex);
        }
    }

    [WebMethod]
    public static OverTimeLogObj getOvertimeloglist(int Month, int Year)
    {
        try
        {
            OverTimeLogObj objovertimelog = OverTimeLogDAL.GetOverTimeLogList(Month,Year);
            return objovertimelog;
        }
        catch (Exception ex)
        {

            Utilities.LogErrorToFile("Error in OverTimeLog_getOvertimeloglist(): " + ex.Message);
            throw (ex);
        }
    }
}