using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class LeaveRequestList : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [WebMethod]
    public static Leave_GsObj GetLeaveList()
    {
        try
        {
            return LeaveDAL.GetLeaveList();
        }
        catch (Exception ex)
        {

            Utilities.LogErrorToFile("Error in LeaveRequestlist_GetLeaveList(): " + ex.Message);
            throw (ex);
        }
    }

    [WebMethod]
    public static int Deleteleave(int LID, int AttendanceID)
    {
        try
        {
            int affectedRows = 0;

            affectedRows = LeaveDAL.DeleteLeave(LID, AttendanceID);
            return affectedRows;
        }
        catch (Exception ex)
        {

            Utilities.LogErrorToFile("Error in LeaveRequestlist_Deleteleave(): " + ex.Message);
            throw (ex);
        }
    }
}