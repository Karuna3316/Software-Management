using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class LeaveLog : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [WebMethod]
    public static Changeshifttime_Gs[] BindEmployeeName()
    {
        return ChangeShifttimeDAL.BindEmployeeName();
    }

    [WebMethod]
    public static lstLeavelogObj GetLeavelog(string stD, string endD, int Employeeid)
    {
        try
        {
            User objCurUser = (User)HttpContext.Current.Session["objUser"];

            return Leavelog_DAL.GetLeavelog(stD, endD, Employeeid);
        }
        catch (Exception ex)
        {

            Utilities.LogErrorToFile("Error in LeaveLog_GetLeavelog: " + ex.Message);
            throw (ex);
        }
    }
}