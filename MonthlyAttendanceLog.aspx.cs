using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MonthlyAttendanceLog : System.Web.UI.Page
{
   
        protected void Page_Load(object sender, EventArgs e)
        {
            if (grdMonth.Rows != null && grdMonth.Rows.Count > 0)
            {
                btnExport.Visible = true;
                tblData.Visible = true;
                smart.Visible = true;


            }
            else
            {
                btnExport.Visible = false;
                tblData.Visible = false;
                smart.Visible = false;


            }
        
         }



    protected void btnShow_Click(object sender, EventArgs e)
    {
        Hashtable tblParams = new Hashtable();
        tblParams.Add("@mon", drpMonth.Items[drpMonth.SelectedIndex].Value);
        tblParams.Add("@year", drpYear.Items[drpYear.SelectedIndex].Value);
        grdMonth.DataSource = MonthlyAttendanceLogDAL.GetResultAsTable("GetmonthlyAttendence", tblParams);
        //grdMonth.DataSource = GetReportData.GetResultAsTable("GetAttendenceDailyFrMonthEditingFeb03", drpMonth.Items[drpMonth.SelectedIndex].Value);
        grdMonth.DataBind();
        //}
        if (grdMonth.Rows != null && grdMonth.Rows.Count > 1)
        {
            btnExport.Visible = true;
            tblData.Visible = true;
            smart.Visible = true;

            lblResponse.InnerText = "";
            StringBuilder value = new StringBuilder();
            for (int i = 0; i < grdMonth.Rows.Count; i++)
            {
                for (int j = 0; j < grdMonth.Rows[i].Cells.Count; j++)
                {



                    if (value.Length == 0)
                    {
                        value.Append(grdMonth.Rows[i].Cells[j].Text.ToString());
                    }
                    else
                    {
                        value.Clear();
                        value.Append(grdMonth.Rows[i].Cells[j].Text.ToString());
                    }

                    if (value.Length > 4)
                    {

                        if (j == 0)
                        {
                            continue;
                        }
                        else if (j == 1)
                        {

                            continue;

                        }
                        else
                        {
                            grdMonth.Rows[i].Cells[j].BackColor = System.Drawing.Color.Red;
                            grdMonth.Rows[i].Cells[j].ForeColor = System.Drawing.Color.White;
                        }




                    }
                }
            }
        }
        else
        {
            btnExport.Visible = false;
            tblData.Visible = false;
            lblResponse.InnerText = "No Data Available";
            smart.Visible = false;
        }
    }

    protected void btnExport_Click(object sender, EventArgs e)
    {
        Response.Clear();
        string month = drpMonth.Items[drpMonth.SelectedIndex].Text;
        Response.AddHeader("content-disposition", "attachment;    filename=Attendance" + month + ".xls");
        Response.ContentType = "application/vnd.xls";
        System.IO.StringWriter stringWrite = new System.IO.StringWriter();

        System.Web.UI.HtmlTextWriter htmlWrite =
        new HtmlTextWriter(stringWrite);

        grdMonth.RenderControl(htmlWrite);

        Response.Write(stringWrite.ToString());

        Response.End();

    }

    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Confirms that an HtmlForm control is rendered for the specified ASP.NET
           server control at run time. */
    }
    protected void btnReset_Click(object sender, EventArgs e)
    {

        smart.Visible = false;
        drpMonth.SelectedIndex = 0;
        drpYear.SelectedIndex = 0;
        lblResponse.InnerText = "";


    }

}