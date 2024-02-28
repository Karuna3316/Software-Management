using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        {
            if (!IsPostBack)
            {
                Session["menuT"] = null;
                Session["objUser"] = null;
            }
        }
    }

    [WebMethod]
    public static LoginS BindAccessTimeValue(string username, string password)
    {


        LoginS urlO = new LoginS();
        bool isExists = LoginDAL.chkUser(username, password);
        if (isExists)
        {
            urlO.url = "Dashboard.aspx";
        }

        return urlO;
    }

    [WebMethod]
    public static User BindEmailId()
    {

        User urlO = (User)HttpContext.Current.Session["objUser"];

        return urlO;
    }



    ////forgot password request
    [WebMethod]
    public static int SendRequest(ForgotPassword1 SupportObj)
    {

        return PassWordDAL.SendRequestForgotPwd(SupportObj);
    }
}