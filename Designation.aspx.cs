using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Designation : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

[WebMethod]
public static lstDesignationObj GetDesignationList()
{
    try
    {
            lstDesignationObj objDesig = DesignationDAL.GetDesignationList();
        return objDesig;
    }
    catch (Exception ex)
    {

        Utilities.LogErrorToFile("Error in Designation_GetDesignationList(): " + ex.Message);
        throw (ex);
    }
}
    [WebMethod]
    public static int SaveorUpdateDesignation(DesignationObj objDesig)
    {
        try
        {


            return DesignationDAL.SaveorUpdateDesignation(objDesig);
        }
        catch (Exception ex)
        {
            Utilities.LogErrorToFile("Error in Designation_SaveorUpdateDesignation(): " + ex.Message);
            throw (ex);
        }
    }
    [WebMethod]
    public static DesignationObj BindDesignationForEdit(int DesignationId)
    {
        try
        {


            return DesignationDAL.BindDesignationForEdit(DesignationId);
        }
        catch (Exception ex)
        {
            Utilities.LogErrorToFile("Error in Designation_BindDesignationForEdit(): " + ex.Message);
            throw (ex);

        }
    }


    [WebMethod]
    public static int DeleteDesignation(int lReqId)
    {
        try
        {

            int affectedRows = 0;

            affectedRows = DesignationDAL.DeleteDesignation(lReqId);
            return affectedRows;
        }
        catch (Exception ex)
        {

            Utilities.LogErrorToFile("Error in  Designation_DeleteDesignation(): " + ex.Message);
            throw (ex);
        }
    }

}
