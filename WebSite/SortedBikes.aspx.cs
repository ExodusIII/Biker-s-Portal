using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
public partial class SortedBikes : System.Web.UI.Page
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
            //İl- ilce first items
            ilBike.Items.Insert(0, new ListItem("İl Seçiniz..", "0"));
            ilBike.Items.Insert(1, new ListItem("Ankara", "1"));
            ilBike.Items.Insert(2, new ListItem("İstanbul", "2"));
            ilceBike.Items.Insert(0, new ListItem("İlçe Seçiniz..", "0"));
            tur_Vites();
            
            BindBikes();
        }
    }
    private void BindBikes()
    {
        string conn = ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
        string query = "SELECT * FROM Bike WHERE Availability = '1'";
        if (Session["category"].ToString() != "0")
        {
            query += " AND Category='" + Session["category"] + "' ";
        }
        //if (Session["searchItem"].ToString() != null)
        //{
        //    query += " AND AdsHeader='"+'%' + Session["searchItem"] + '%'+"' ";
        //    Session["searchItem"] = "";
        //}
        query += " order by AddingDate DESC ";
        using (SqlConnection con = new SqlConnection(conn))
        {
            using (SqlCommand cmd = new SqlCommand(query, con))
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
        if (e.CommandName == "ImageClick")
        {
            string[] commandArgs = e.CommandArgument.ToString().Split(new char[] { ',' });
            string OwnerID = commandArgs[0];
            string Bid = commandArgs[1];

            Response.Write("tikladin");
            userID = Convert.ToInt32(OwnerID);
            BikeID = Convert.ToInt32(Bid);
            
            Session.Add("Target", userID);
            Session.Add("TargetBike", BikeID);

            Response.Redirect("BikeDescription.aspx");
        }
    }
    protected void ilBike_SelectedIndexChanged(object sender, EventArgs e)
    {

        ilceBike.Items.Clear();
        ilceBike.Items.Insert(0, new ListItem("İlçe Seçiniz..", "0"));
        int il = Int32.Parse(ilBike.SelectedItem.Value);

        if (il == 1)
        {
            ilceBike.Items.Insert(1, new ListItem("Altındağ", "1"));
            ilceBike.Items.Insert(2, new ListItem("Çankaya", "2"));
            ilceBike.Items.Insert(3, new ListItem("Etimesgut", "3"));
            ilceBike.Items.Insert(4, new ListItem("Keçiören", "4"));
            ilceBike.Items.Insert(5, new ListItem("Sincan", "5"));
            ilceBike.Items.Insert(6, new ListItem("Yenimahalle", "6"));
        }
        if (il == 2)
        {
            ilceBike.Items.Insert(1, new ListItem("Avcılar", "1"));
            ilceBike.Items.Insert(2, new ListItem("Emirgan", "2"));
            ilceBike.Items.Insert(3, new ListItem("Pendik", "3"));
            ilceBike.Items.Insert(4, new ListItem("Tuzla", "4"));
            ilceBike.Items.Insert(5, new ListItem("Üsküdar", "5"));
            ilceBike.Items.Insert(6, new ListItem("Zeytinburnu", "6"));
        }
    }
    protected void tur_Vites()
    {
        vites.Items.Clear();
        vites.Items.Insert(0, new ListItem("Vites Seçiniz", "0"));
        //int turBike = Int32.Parse(tur.SelectedItem.Value);
        int turBike = Convert.ToInt32(Session["category"]);
        string[,] dagVites = new string[,]{ { "1", "1x11" }, { "2", "2x10" }, { "3", "2x11" }, { "4", "3x6" },
            { "5", "3x7" }, { "6", "3x8" }, { "7", "3x9" }, { "8", "3x10" }
        };
        string[,] normalBike = new string[,] { { "1", "1" }, { "2", "2" }, { "3", "3" }, { "4", "6" }, { "5", "7" }, { "6", "8" },
        { "7", "9" }, { "8", "10" }, { "9", "11" }, { "10", "12" }, { "11", "14" }, { "12", "16" }, { "13", "18" }, { "14", "20" }, { "15", "21" },
        { "16", "22" }, { "17", "24" }, { "18", "27" }, { "19", "30" } };


        if (turBike == 1)
        {
            for (int i = 0; i < (dagVites.Length / 2); i++)
            {
                vites.Items.Insert(i + 1, new ListItem(dagVites[i, 1], dagVites[i, 0]));
            }
        }
        else if (turBike == 2 || turBike == 3)
        {
            for (int j = 0; j < (normalBike.Length / 2); j++)
            {
                vites.Items.Insert(j + 1, new ListItem(normalBike[j, 1], normalBike[j, 0]));
            }
        }
        else
        {
            string[] transmissionArr = {"1", "2", "3", "6", "7", "8", "9", "10", "11", "12", "14", "16", "18",
        "20", "21", "22", "24", "27", "30", "1x11", "2x10", "2x11", "3x6", "3x7", "3x8", "3x9", "3x10", };
            for(int k = 0; k < transmissionArr.Length; k++)
            {
                vites.Items.Insert(k + 1, new ListItem(transmissionArr[k], (k + 1).ToString()));
            }
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
        return cityArr[cityInt] + "/" + countyArr[cityInt, countyInt - 1];
    }
    protected void sortBikes_Click(object sender, EventArgs e)
    {
        string empty = "0";
        string querySelect = "SELECT * FROM Bike";
        string queryWhere = " WHERE Availability=1";
        string query = querySelect + queryWhere;
        if (Session["category"].ToString() != empty)
        {
            query += " AND Category='" + Session["category"] + "' ";
        }
        if (ilBike.SelectedValue != empty)
        {
            query += " AND BikeCity='" + ilBike.SelectedValue + "' ";
        }
        if(ilceBike.SelectedValue != empty)
        {
            query += " AND BikeCounty='" + ilceBike.SelectedValue + "' ";
        }
        if(vites.SelectedValue != empty)
        {
            query += " AND Transmission='" + vites.SelectedValue + "' ";
        }
        if (minPrice.Text != "")
        {
            float minPriceInt = float.Parse(minPrice.Text, System.Globalization.CultureInfo.InvariantCulture);
            query += " AND Price>=" + minPriceInt + " ";
        }
        if (maxPrice.Text != "")
        {
            float maxPriceInt = float.Parse(maxPrice.Text, System.Globalization.CultureInfo.InvariantCulture);
            query += " AND Price<=" + maxPriceInt + " ";
        }
        query += " order by AddingDate DESC ";


        string conn = ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
        using (SqlConnection con = new SqlConnection(conn))
        {
            using (SqlCommand cmd = new SqlCommand(query, con))
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
}