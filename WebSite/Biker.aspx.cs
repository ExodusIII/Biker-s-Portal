using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class Biker : System.Web.UI.Page
{

    int userID;
    int BikeID;
    string[] currencyArr = { "₺", "$", "€", "£" };
    string[] cityArr = { "", "Ankara", "İstanbul" };
    string[,] countyArr = { { "", "", "", "", "", "" }, 
        { "Altındağ", "Çankaya", "Etimesgut", "Keçiören", "Sincan", "Yenimahalle" }, 
        { "Avcılar", "Emirgan", "Pendik", "Tuzla", "Üsküdar", "Zeytinburnu" } };
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            
            BindBikes();
        }
    }
    private void BindBikes()
    {
        string conn = ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
        using (SqlConnection con = new SqlConnection(conn))
        {
            using (SqlCommand cmd = new SqlCommand("select * from Bike WHERE Availability='1' order by AddingDate DESC", con))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    RepBikes.DataSource = dt;
                    RepBikes.DataBind();
                }
            }
        }
    }
    public void BikeView_Click(object sender, EventArgs e)
    {
        Response.Redirect("BikeDescription.aspx");

    }

    protected void RepBikes_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        Response.Write("Girdi");
        if (e.CommandName == "ImageClick")
        {
            string[] commandArgs = e.CommandArgument.ToString().Split(new char[] { ',' });
            string OwnerID = commandArgs[0];
            string Bid = commandArgs[1];

            Response.Write("tikladin");
            userID = Convert.ToInt32(OwnerID);
            BikeID = Convert.ToInt32(Bid);
            //Response.Write(userID);
            //Do something
            //if (Session["Target"] != null)
            //{
            //    Session.Contents.RemoveAll();
            //}
            //else
            //{
            Session.Add("Target", userID);
            Session.Add("TargetBike", BikeID);
            //}
            Response.Write(Convert.ToInt32(Session["TargetBike"]));
            Response.Redirect("BikeDescription.aspx");
        }
    }
    public string makeShortDate(object oDate)
    {
        if (oDate is DBNull)
        {
            return "";
        }
        else
        {
            DateTime dDate = Convert.ToDateTime(oDate);
            string sDate = dDate.ToShortDateString();
            return sDate;
        }
    }
    public string changeCurrency(object cur)
    {
        int curInt;
        curInt = Convert.ToInt32(cur);
        return currencyArr[curInt];
    }
    public string changeLocation(object city, object county)
    {
        int cityInt, countyInt;
        cityInt = Convert.ToInt32(city); countyInt = Convert.ToInt32(county);
        return cityArr[cityInt] + "/" + countyArr[cityInt, countyInt-1];
    }
}