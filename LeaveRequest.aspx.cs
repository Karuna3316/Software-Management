using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class LeaveRequest : System.Web.UI.Page
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
    public static Leave_Gs[] BindLeaveType()
    {
        return LeaveDAL.BindLeaveType();
    }

    [WebMethod]
    public static Leave_Gs[] GetLeaveDate(int userid, int LID)
    {
        return LeaveDAL.GetLeaveDate(userid, LID);
    }

    [WebMethod]
    public static int SaveorupdateLeave(Leave_Gs EMPObj)
    {
        try
        {
            return LeaveDAL.SaveorupdateLeave(EMPObj);
        }
        catch (Exception ex)
        {
            Utilities.LogErrorToFile("Error in LeaveRequest_SaveorupdateLeave(): " + ex.Message);
            return 0;
        }
    }

    [WebMethod]
    public static Leave_Gs GetEmployeeEdit(int LID)
    {
        try
        {
            User oU = (User)HttpContext.Current.Session["objUser"];

            return LeaveDAL.GetLeaveedit(LID);
        }
        catch (Exception ex)
        {
            Utilities.LogErrorToFile("Error in LeaveRequest_GetEmployeeEdit(): " + ex.Message);
            throw;
        }
    }

    [WebMethod]
    public static Leave_Gs Bindhiddenfields(int userid)
    {
        try
        {

            return LeaveDAL.Bindhiddenfields(userid);
        }
        catch (Exception ex)
        {
            Utilities.LogErrorToFile("Error in LeaveRequest_Bindhiddenfields(): " + ex.Message);
            throw (ex);
        }
    }
    
}