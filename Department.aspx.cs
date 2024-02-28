using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Department : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [WebMethod]
    public static Department_obj getdepartmentList()
    {
        try
        {
            Department_obj objLstLR = DepartmentDAL.GetDepartmentList();
            return objLstLR;
        }
        catch (Exception ex)
        {
            Utilities.LogErrorToFile("Error in Department_GetDepartmentList(): " + ex.Message);
            throw (ex);
        }
    }

    [WebMethod]
    public static int savedepartment(Departmentmaster deptobj)
    {
        try
        {
            return DepartmentDAL.SaveDepartment(deptobj);
        }
        catch (Exception ex)
        {
            Utilities.LogErrorToFile("Error in Department_savedepartment(): " + ex.Message);
            throw (ex);
        }
    }

    [WebMethod]
    public static Departmentmaster Editdepartment(int DepartmentId)
    {
        try
        {

            return DepartmentDAL.EditDepartment(DepartmentId);
        }

        catch (Exception ex)
        {
            Utilities.LogErrorToFile("Error in  Department_Editdepartment(): " + ex.Message);
            throw (ex);
        }
    }

    [WebMethod]
    public static int Deletedepartment(int lReqId)
    {
        try
        {

            int affectedRows = 0;

            affectedRows = DepartmentDAL.DeleteDepartment(lReqId);
            return affectedRows;
        }
        catch (Exception ex)
        {

            Utilities.LogErrorToFile("Error in Department_Deletedepartment(): " + ex.Message);
            throw (ex);
        }
    }
}