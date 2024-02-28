using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AttendanceLog : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [WebMethod]
    public static lstAttendanceLogObj BindAttendanceLog(string stD, string endD, int Eid)
    {
        try
        {

            return AttendanceLogDAL.GetAttendanceLog(stD, endD, Eid);
        }
        catch (Exception ex)
        {

            Utilities.LogErrorToFile("Error in AttendanceLog_BindAttedancelog(): " + ex.Message);
            throw (ex);
        }
    }

    [WebMethod]
    public static Employee_Drp[] BindEmployeeName()
    {
        return AttendanceLogDAL.GetEmployeeName();
    }
}