using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Permission : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod]
    public static DrpEmployee[] DrpEmployeeName()
    {
        return PermissionDAL.DrpEmployeeName();
    }
    [WebMethod]
    public static DrpPermissionDate[] DrpPermissionDate(int UserID)
    {
        return PermissionDAL.DrpPermissionDate(UserID);
    }

    [WebMethod]
    public static int SaveorUpdatePermission(PermissionGS objPDate)
    {
        try
        {


            return PermissionDAL.SaveorUpdatePermission(objPDate);
        }
        catch (Exception ex)
        {
            Utilities.LogErrorToFile("Error in Permission_SaveorUpdateholiday(): " + ex.Message);
            throw (ex);
        }
    }
}