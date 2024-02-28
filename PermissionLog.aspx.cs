using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class PermissionLog : System.Web.UI.Page
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
    public static lstPermissionlogObj BindPermissionLog(string stD, string endD, int Employeeid)
    {
        try
        {
            User objCurUser = (User)HttpContext.Current.Session["objUser"];

            return Permissionlog_DAL.GetPermissionLog(stD, endD, Employeeid);
        }
        catch (Exception ex)
        {

            Utilities.LogErrorToFile("Error in PermissionLog_BindPermissionLog: " + ex.Message);
            throw (ex);
        }
    }
}