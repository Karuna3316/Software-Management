using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Ticket : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [WebMethod]
    public static Changeshifttime_Gs[] BindEmployeeName()
    {
        return TicketDAL.BindEmployeeName();
    }

    [WebMethod]
    public static TicketObj[] BindTicketDates(int SupportTypeId,int drpemployee)
    {
        return TicketDAL.BindTicketDates(SupportTypeId, drpemployee);
    }

    [WebMethod]
    public static int SaveorUpdateTicket(TicketObj objSupport)
    {
        try
        {

            return TicketDAL.SaveorUpdateTicket(objSupport);
        }
        catch (Exception ex)
        {

            Utilities.LogErrorToFile("Error in  Ticket_SaveorUpdateTicket(): " + ex.Message);
            throw (ex);

        }
    }

}