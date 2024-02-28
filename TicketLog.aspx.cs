using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class TicketLog : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [WebMethod]
    public static Employee_Drp[] BindEmployeeName()
    {
        return TicketLogDAL.GetEmployeeName();
    }

    [WebMethod]
    public static lstTicketlogObj BindTicketLogList(string stD, string endD, int Eid)
    {
        try
        {

            return TicketLogDAL.GetTicketLog(stD, endD, Eid);
        }
        catch (Exception ex)
        {

            Utilities.LogErrorToFile("Error in TicketLog_BindTicketLogList(): " + ex.Message);
            throw (ex);
        }
    }
}