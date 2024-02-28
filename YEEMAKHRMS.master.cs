using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class MasterPage :  System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["objUser"] == null)
        {
            Response.Redirect("~/Login.aspx?refUrl=" + Request.Url.AbsolutePath);
        }


        GenerateMenuItems();
    }
    private void GenerateMenuItems()
    {
        try
        {

            User oU = (User)Session["objUser"];
            lblUserName.Text = oU.userName;
            DataTable dtMenus = null;
            if (Session["menuT"] == null)
            {
                dtMenus = MenuDAL.GetMenus(oU.userId);
                Session["menuT"] = dtMenus;
            }
            else
            {
                dtMenus = (DataTable)Session["menuT"];
            }


            DataView dvMenus = dtMenus.DefaultView;
            foreach (DataRow dr in dtMenus.Rows)
            {
                int MenuID = Convert.ToInt32(dr["menuId"]);
                dvMenus.RowFilter = "ParentID=" + MenuID;
                if (dvMenus.Count > 0)
                {
                    DataTable dt = dvMenus.ToTable();

                    HtmlGenericControl liMain = new HtmlGenericControl("li");
                    HtmlGenericControl ulSubmenu = new HtmlGenericControl("ul");
                    foreach (DataRow drMi in dt.Rows)
                    {
                        if (drMi["parentId"].ToString() == Convert.ToString(drMi["menuId"]))
                        {
                            LinkButton lnk = new LinkButton();
                            lnk.Text = drMi["menu"].ToString();
                            lnk.CommandArgument = drMi["menuId"].ToString();
                            lnk.CommandName = drMi["url"].ToString();
                            lnk.Click += new EventHandler(lnkMenu_Click);
                            liMain.Controls.Add(lnk);
                        }
                        else
                        {
                            var dQry2 = from dr2 in dtMenus.AsEnumerable()
                                        where dr2.Field<string>("menu") != drMi["menu"].ToString()
                                        && dr2.Field<int>("parentId") == Convert.ToInt32(drMi["menuId"].ToString())
                                        select dr2;
                            //if (dQry2 == null)
                            ulSubmenu.Attributes["class"] = "submenu";
                            HtmlGenericControl liSub = new HtmlGenericControl("li");
                            LinkButton lnkSub = new LinkButton();
                            lnkSub.Text = drMi["menu"].ToString();
                            lnkSub.CommandArgument = drMi["menuId"].ToString();
                            lnkSub.CommandName = drMi["url"].ToString();
                            lnkSub.Click += new EventHandler(lnkMenu_Click);
                            liSub.Controls.Add(lnkSub);
                            ulSubmenu.Controls.Add(liSub);
                            liMain.Controls.Add(ulSubmenu);



                            if (dQry2 != null && dQry2.Count() > 0)
                            {
                                HtmlGenericControl ulSub2menu = new HtmlGenericControl("ul");
                                ulSub2menu.Attributes["class"] = "submenu";
                                foreach (DataRow dr2 in dQry2)
                                {
                                    HtmlGenericControl lstSub2 = new HtmlGenericControl("li");
                                    LinkButton lnkSub2 = new LinkButton();
                                    lnkSub2.Text = dr2["menu"].ToString();
                                    lnkSub2.CommandArgument = dr2["menuId"].ToString();
                                    lnkSub2.CommandName = dr2["url"].ToString();
                                    lnkSub2.Click += new EventHandler(lnkMenu_Click);
                                    lstSub2.Controls.Add(lnkSub2);
                                    ulSub2menu.Controls.Add(lstSub2);
                                }

                                liSub.Controls.Add(ulSub2menu);
                            }
                        }
                    }

                    menu.Controls.Add(liMain);
                }
            }
        }
        catch (Exception ex)
        {
            throw (ex);
        }
    }

    protected void lnkMenu_Click(object sender, EventArgs e)
    {
        try
        {
            LinkButton btn = sender as LinkButton;
            string cmdURL = btn.CommandName;
            if (!string.IsNullOrEmpty(cmdURL) && cmdURL != "#")
            { Response.Redirect(cmdURL, true); }
        }
        catch (Exception)
        {
        }
    }
}
