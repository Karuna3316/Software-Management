using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ManualAttendance : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod]
    public static Employee_Drp[] getManualAttendancedrp()
    {
        try
        {

            return ManualAttendanceDAL.GetManualAttendancedrp();
        }
        catch (Exception ex)
        {
            Utilities.LogErrorToFile("Error in ManualAttendance_GetLeaveBenefitDropdown(): " + ex.Message);
            throw (ex);
        }
    }


    [WebMethod]
    public static Actions[] DrpAddOrUpdate()
    {
        return ManualAttendanceDAL.GetAddorupdatedrp();
    }


    [WebMethod]
    public static ManualAttendance_obj getManualAttendancelist(int EmployeeId, string Date)
    {
        try
        {
            ManualAttendance_obj objManual = ManualAttendanceDAL.GetManualAttendanceList(EmployeeId, Date);
            return objManual;
        }
        catch (Exception ex)
        {

            Utilities.LogErrorToFile("Error in ManualAttendance_getManualAttendance(): " + ex.Message);
            throw (ex);
        }
    }

    [WebMethod]
    public static int saveManualAttendance(ManualAttendance_App objManAtt)
    {
        try
        {
            return ManualAttendanceDAL.SaveOrUpdateManualAttendance(objManAtt);
        }
        catch (Exception ex)
        {

            Utilities.LogErrorToFile("Error in ManualAttendance_saveManualAttendance(): " + ex.Message);
            throw (ex);
        }
    }


    [WebMethod]
    public static ManualAttendance_App BindUpdate(int AttendanceID)
    {
        try
        {

            User oU = (User)HttpContext.Current.Session["objUser"];

            return ManualAttendanceDAL.GetUpdate(AttendanceID);
        }
        catch (Exception ex)
        {

            Utilities.LogErrorToFile("Error in ManualAttendance_BindUpdate(): " + ex.Message);
            throw (ex);
        }
    }

}