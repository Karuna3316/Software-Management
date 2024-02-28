using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ChangeShiftTime : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod]
    public static Changeshifttime_GsObj GetChangeshifttimeList()
    {
        try
        {
            return ChangeShifttimeDAL.GetChangeshifttimeList();
        }
        catch (Exception ex)
        {

            Utilities.LogErrorToFile("Error in ChangeShiftTime_GetChangeshifttimeList(): " + ex.Message);
            throw (ex);
        }
    }

    [WebMethod]
    public static Changeshifttime_Gs[] BindEmployeeName()
    {
        return ChangeShifttimeDAL.BindEmployeeName();
    }


    [WebMethod]
    public static Changeshifttime_Gs[] BindShifttype()
    {
        return ChangeShifttimeDAL.BindShifttype();
    }

    [WebMethod]
    public static Changeshifttime_Gs BindShifttime(int Timeid)
    {
        try
        {

            return ChangeShifttimeDAL.BindShifttime(Timeid);
        }
        catch (Exception ex)
        {
            Utilities.LogErrorToFile("Error in ChangeShiftTime_BindShifttime(): " + ex.Message);
            throw (ex);
        }
    }

    [WebMethod]
    public static int SaveorUpdateShifttime(Changeshifttime_Gs Sfobj)
    {
        try
        {
            return ChangeShifttimeDAL.SaveorUpdateShifttime(Sfobj);
        }
        catch (Exception ex)
        {
            Utilities.LogErrorToFile("Error in  ChangeShiftTime_SaveorUpdateShifttime(): " + ex.Message);
            throw (ex);
        }
    }

    [WebMethod]
    public static Changeshifttime_Gs BindChangeshifttimeEdit(int shiftchangeid)
    {
        try
        {

            return ChangeShifttimeDAL.BindChangeshifttimeEdit(shiftchangeid);
        }

        catch (Exception ex)
        {
            Utilities.LogErrorToFile("Error in  ChangeShiftTime_BindChangeshifttimeEdit(): " + ex.Message);
            throw (ex);
        }
    }

    [WebMethod]
    public static int DeleteChangeshifttime(int lReqId)
    {
        try
        {
            int affectedRows = 0;
            affectedRows = ChangeShifttimeDAL.DeleteChangeshifttime(lReqId);
            return affectedRows;
        }
        catch (Exception ex)
        {
            Utilities.LogErrorToFile("Error in  ChangeShiftTime_DeleteChangeshifttime(): " + ex.Message);
            throw (ex);

        }
    }
}