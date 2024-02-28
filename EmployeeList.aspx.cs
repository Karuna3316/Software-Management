using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class EmployeeList : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [WebMethod]
    public static lstEmployeeObj GetEmployeeList()
    {
        try
        {
            lstEmployeeObj objLstLR = EmployeeDAL.GetEmployeeList();
            return objLstLR;
        }
        catch (Exception ex)
        {

            Utilities.LogErrorToFile("Error in  EmployeeList_GetEmployeeList(): " + ex.Message);
            throw (ex);

        }
    }

    [WebMethod]
    public static int DeleteEmployees(EmployeeGS EMPObjt)
    {
        try
        {

            return EmployeeDAL.DeleteEmployees(EMPObjt);
        }
        catch (Exception ex)
        {
            Utilities.LogErrorToFile("Error in  EmployeeList_DeleteEmployees(): " + ex.Message);
            throw (ex);
        }
    }
}