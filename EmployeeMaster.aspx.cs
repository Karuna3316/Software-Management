using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
public partial class EmployeeMaster : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [WebMethod]
    public static lstEmployeeObj GetEmployeeReport()
    {
        try
        {
            return EmployeeReportDAL.GetEmployeeReport();
        }
        catch (Exception ex)
        {
            Utilities.LogErrorToFile("Error in EmployeeMaster_GetEmployeeReport(): " + ex.Message);
            throw (ex);
        }
    }
}