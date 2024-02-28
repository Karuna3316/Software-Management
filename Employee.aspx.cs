using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Employee : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [WebMethod]
    public static DrpRole[] RoleDRP()
    {
        return EmployeeDAL.BindRole();
    } 
    [WebMethod]
    public static DrpDepartment[] DepartmentDRP()
    {
        return EmployeeDAL.BindDepartment();
    } 
    [WebMethod]
    public static DrpDesignation[] DesignationDRP()
    {
        return EmployeeDAL.BindDesignation();
    }
    [WebMethod]
    public static EmployeeGS BindEmpCard()
    {
        EmployeeGS objAT = new EmployeeGS();
        Hashtable objHT = new Hashtable();

        DataTable dtObj = EmployeeDAL.GetResultAsTable("BindEmpCard", objHT);
        if (dtObj != null && dtObj.Rows.Count > 0)
        {

            if (dtObj.Rows[0]["IDCARDNO"] != null && dtObj.Rows[0]["IDCARDNO"].ToString() != "")
                objAT.IDCARDNO = dtObj.Rows[0]["IDCARDNO"].ToString();
        }
        return objAT;

    }
    [WebMethod]
    public static int SaveorUpdateEmployee(EmployeeGS objEMP)
    {
        try
        {


            return EmployeeDAL.SaveorUpdateEmployee(objEMP);
        }
        catch (Exception ex)
        {
            Utilities.LogErrorToFile("Error in Employee_SaveorUpdateEmployee(): " + ex.Message);
            throw (ex);
        }
    }
    [WebMethod]
    public static EmployeeGS GetEmployeeEdit(int userId)
    {
        try
        {
            User oU = (User)HttpContext.Current.Session["objUser"];

            return EmployeeDAL.GetEmployeeEdit(userId);
        }
        catch (Exception ex)
        {
            Utilities.LogErrorToFile("Error in Employee_GetEmployeeEdit(): " + ex.Message);
            throw(ex);
        }
    }
}