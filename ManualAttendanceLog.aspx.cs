using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ManualAttendanceLog : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod]
    public static EmployeeLog_Drp[] getManualAttendancedrp()
    {
        try
        {

            return ManualAttendanceLogDAL.GetManualAttendancedrp();
        }
        catch (Exception ex)
        {
            Utilities.LogErrorToFile("Error in ManualAttendanceLog_GetLeaveBenefitDropdown(): " + ex.Message);
            throw (ex);
        }
    }


    [WebMethod]
    public static ManualAttendanceLog_obj getManualAttendancelog(string stDate, string endDate, int empId)
    {
        try
        {
            User oU = (User)HttpContext.Current.Session["objUser"];
            return ManualAttendanceLogDAL.GetManualattendanceLog(stDate, endDate, empId);
        }
        catch (Exception ex)
        {
            Utilities.LogErrorToFile("Error in ManualAttendanceLog_getManualAttendancelog(): " + ex.Message);
            throw (ex);
        }
    }
}
