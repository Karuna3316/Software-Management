using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class TicketList : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [WebMethod]
    public static lstTicketObj GetTicketList()
    {
        try
        {
            return TicketDAL.GetTicketList();
        }
        catch (Exception ex)
        {

            Utilities.LogErrorToFile("Error in Ticketlist_GetTicketList(): " + ex.Message);
            throw (ex);
        }
    }

}