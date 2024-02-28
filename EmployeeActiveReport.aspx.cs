using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class EmployeeActiveReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [WebMethod]
    public static lstEmployeeObj GetEmployeeActiveReport()
    {
        try
        {
            return EmployeeReportDAL.GetEmployeeActiveReport();
        }
        catch (Exception ex)
        {
            Utilities.LogErrorToFile("Error in EmployeeActiveReport_GetEmployeeActiveReport(): " + ex.Message);
            throw (ex);
        }
    }
}