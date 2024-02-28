using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class LeaveBenefits : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod]
    public static LeaveBenefit_obj getleavebenefitlist()
    {
        try
        {
            return LeaveBenefitDAL.GetLeaveBenefitList();
        }
        catch (Exception ex)
        {

            Utilities.LogErrorToFile("Error in LeaveBenefits_getleavebenefitlistt(): " + ex.Message);
            throw (ex);
        }
    }

    [WebMethod]
    public static Employee_Dropdown[] GetLeaveBenefitDropdown()
    {
        try
        {

            return LeaveBenefitDAL.GetLeaveBenefitdrp();
        }
        catch (Exception ex)
        {
            Utilities.LogErrorToFile("Error in LeaveBenefits_GetLeaveBenefitDropdown(): " + ex.Message);
            throw (ex);
        }
    }

    [WebMethod]
    public static LeaveBenefit_App Bindleavebenefit(int DOJ)
    {
        try
        {

            return LeaveBenefitDAL.BindLeaveBenefit(DOJ);
        }
        catch (Exception ex)
        {
            Utilities.LogErrorToFile("Error in LeaveBenefits_Bindleavebenefit(): " + ex.Message);
            throw (ex);
        }
    }

    [WebMethod]
    public static int SaveorupdateLeaveBenefit(LeaveBenefit_App objleave)
    {
        try
        {
            return LeaveBenefitDAL.SaveorUpdateLeaveBenefit(objleave);
        }
        catch (Exception ex)
        {
            Utilities.LogErrorToFile("Error in  LeaveBenefits_SaveorupdateLeaveBenefit(): " + ex.Message);
            throw (ex);
        }
    }


    [WebMethod]
    public static int Deleteleavebenefit(int lReqId)
    {
        try
        {

            int affectedRows = 0;

            affectedRows = LeaveBenefitDAL.DeleteLeaveBenefit(lReqId);
            return affectedRows;
        }
        catch (Exception ex)
        {

            Utilities.LogErrorToFile("Error in LeaveBenefits_Deleteleavebenefit(): " + ex.Message);
            throw (ex);
        }
    }
}