using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class PermissionList : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [WebMethod]
    public static lstPermissionObj GetPermissionList()
    {
        try
        {
            lstPermissionObj objLstLR = PermissionDAL.GetPermissionList();
            return objLstLR;
        }
        catch (Exception ex)
        {

            Utilities.LogErrorToFile("Error in  PermissionList_GetPermissionList(): " + ex.Message);
            throw (ex);

        }
    }
    [WebMethod]
    public static int DeletePermission(int PId)
    {
        try
        {

            int affectedRows = 0;

            affectedRows = PermissionDAL.DeletePermission(PId);
            return affectedRows;
        }
        catch (Exception ex)
        {

            Utilities.LogErrorToFile("Error in Permission_DeletePermission(): " + ex.Message);
            throw (ex);
        }
    }
}