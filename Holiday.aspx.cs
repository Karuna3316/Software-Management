using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Holiday : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [WebMethod]
    public static Holiday_GsObj GetHolidayList()
    {
        try
        {
            Holiday_GsObj objJobRole = HolidayDAL.GetHolidayList();
            return objJobRole;
        }
        catch (Exception ex)
        {

            Utilities.LogErrorToFile("Error in  Holiday_GetHolidayList(): " + ex.Message);
            throw (ex);
        }
    }

    [WebMethod]
    public static int SaveorUpdateholiday(Holiday_Gs objHoliday)
    {
        try
        {


            return HolidayDAL.SaveorUpdateholiday(objHoliday);
        }
        catch (Exception ex)
        {
            Utilities.LogErrorToFile("Error in Holiday_SaveorUpdateholiday(): " + ex.Message);
            throw (ex);
        }
    }

    [WebMethod]
    public static Holiday_Gs BindHolidayEdit(int HolidayId)
    {
        try
        {


            return HolidayDAL.BindHolidayEdit(HolidayId);
        }
        catch (Exception ex)
        {
            Utilities.LogErrorToFile("Error in Holiday_BindHolidayEdit(): " + ex.Message);
            throw (ex);

        }
    }

    [WebMethod]
    public static int DeleteHoliday(int lReqId)
    {
        try
        {

            int affectedRows = 0;

            affectedRows = HolidayDAL.DeleteHoliday(lReqId);
            return affectedRows;
        }
        catch (Exception ex)
        {

            Utilities.LogErrorToFile("Error in Holiday_DeleteHoliday(): " + ex.Message);
            throw (ex);
        }
    }

}