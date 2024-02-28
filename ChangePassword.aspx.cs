using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ChangePassword : System.Web.UI.Page
{



    


    protected void Page_Load(object sender, EventArgs e)
    {


        if (!IsPostBack)
        {
            if (HttpContext.Current.Session["objUser"] != null)
            {
                User oU = HttpContext.Current.Session["objUser"] as User;

                if (oU != null)
                {
                    int userId = oU.userId;
                    int roleId = oU.roleId;
                   //string IsTeamLead = oU.IsTeamLead;

                    userIdHiddenField.Value = roleId.ToString();
                    //IsTeamLeadHiddenField.Value = IsTeamLead.ToString();


                }
            }
        }

    }


    [WebMethod]
    public static int ChangeCurrentPassword(ResetPassword newPwd)
    {

        return PassWordDAL.CHNGPwd(newPwd);
    }
}