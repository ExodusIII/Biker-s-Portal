using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
public partial class BikeDescription : System.Web.UI.Page
{
    DateTime dateTime = DateTime.Today;
    int star1 = 0;
    int star2 = 0;
    int star3 = 0;
    int star4 = 0;
    int star5 = 0;
    string user = "";
    int user2;
    string id = "";
    int UserID = 0;
    string[] currencyArr = { "₺", "$", "€", "£" };
    string[] cityArr = { "", "Ankara", "İstanbul" };
    string[,] countyArr = { { "", "", "", "", "", "" },
        { "Altındağ", "Çankaya", "Etimesgut", "Keçiören", "Sincan", "Yenimahalle" },
        { "Avcılar", "Emirgan", "Pendik", "Tuzla", "Üsküdar", "Zeytinburnu" } };
    string[] transmissionArr = {"", "1", "2", "3", "6", "7", "8", "9", "10", "11", "12", "14", "16", "18",
        "20", "21", "22", "24", "27", "30", "1x11", "2x10", "2x11", "3x6", "3x7", "3x8", "3x9", "3x10", };
    string[] categoryArr = { "", "Dağ Bisikleti", "Şehir Bisikleti", "Yarış/Yol Bisikleti", "Çocuk Bisikleti" };
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) { BindUser(); BindFeedback(); BindBike(); }
    }

    private void BindUser()
    {
        string conn = ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
        using (SqlConnection con = new SqlConnection(conn))
        {
            con.Open();
            if (con.State == ConnectionState.Open)
            {
                SqlCommand cmd = new SqlCommand("select * from [User] WHERE UserID=" + Convert.ToInt32(Session["Target"]) + "", con);

                //SqlParameter param = new SqlParameter();
                //param.ParameterName = "@UserID";
                //param.Value = user2;
                //cmd.Parameters.Add(param);

                //cmd.Parameters.Add(new SqlParameter("@UserID", user2));
                //SqlCommand cmd = new SqlCommand("select * from [User] WHERE UserID = @ID", con);//where userid=3 veya session falan filan
                //cmd.Parameters.Add("@ID", SqlDbType.Int);
                //cmd.Parameters["@ID"].Value = user2;
                using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    RepUser.DataSource = dt;
                    RepUser.DataBind();
                    //sessionla user bigisi al

                }
            }

        }
    }

    public void SaveBtnPass_Click(object sender, EventArgs e)
    {
        int result = sendMessage();
        //if (result > 0)//popup cikar -> basariyla gonderildi
        //{
        //    lblStatus.Text = "TEMIZ";
        //    lblStatus.Visible = true;
        //}

    }
    private int sendMessage()//guncellencek
    {
        int result = 0;
        int SenderID = Convert.ToInt32(Session["kullaniciID"].ToString());
        int TargetID = Convert.ToInt32(Session["Target"].ToString());
        string connectionString = ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
        SqlConnection connection = new SqlConnection(connectionString);
        connection.Open();

        if (connection.State == ConnectionState.Open)
        {
            //guncelle
            SqlCommand cmd = new SqlCommand("insert into [Message](TargetID,SenderID,[Message],SendDate) values(" + TargetID + "," + SenderID + ",'"+ txtMessage.Text.Trim() + "','" + dateTime + "')", connection);//where target bilmem ne 
            result = cmd.ExecuteNonQuery();
        }
        connection.Close();
        return result;
    }
    private void BindFeedback()
    {

        int score = 0;
        string connectionString = ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
        SqlConnection connection = new SqlConnection(connectionString);
        connection.Open();

        DataTable userTable = new DataTable();
        if (connection.State == ConnectionState.Open)
        {
            //view yap username ekle feedbacki kim yapmis sonra usernmae alSELECT dbo.FeedbackScore.*, dbo.[User].* FROM dbo.FeedbackScore INNER JOIN dbo.[User] ON dbo.FeedbackScore.UserID = dbo.[User].UserID
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT dbo.FeedbackScore.*, dbo.[User].* FROM dbo.FeedbackScore INNER JOIN dbo.[User] ON dbo.FeedbackScore.UserID = dbo.[User].UserID WHERE BikeID ='" + Convert.ToInt32(Session["TargetBike"]) + "'", connection);
            adapter.Fill(userTable);
            RepFeedback.DataSource = userTable;
            RepFeedback.DataBind();
            if(userTable.Rows.Count > 0) {
                for (int i = 0; i < userTable.Rows.Count; i++)
                {
                    if (Convert.ToInt32(userTable.Rows[i]["Score"]) == 1) { star1++; star11.Text = star1.ToString(); }
                    if (Convert.ToInt32(userTable.Rows[i]["Score"]) == 2) { star2++; star22.Text = star2.ToString(); }
                    if (Convert.ToInt32(userTable.Rows[i]["Score"]) == 3) { star3++; star33.Text = star3.ToString(); }
                    if (Convert.ToInt32(userTable.Rows[i]["Score"]) == 4) { star4++; star44.Text = star4.ToString(); }
                    if (Convert.ToInt32(userTable.Rows[i]["Score"]) == 5) { star5++; star55.Text = star5.ToString(); }
                    score = score + Convert.ToInt32(userTable.Rows[i]["Score"]);

                }
                if (star1 == 0) { star11.Text = "0"; }
                if (star2 == 0) { star22.Text = "0"; }
                if (star3 == 0) { star33.Text = "0"; }
                if (star4 == 0) { star44.Text = "0"; }
                if (star5 == 0) { star55.Text = "0"; }
                score = score / Convert.ToInt32(userTable.Rows.Count);
                lblScore.Text = score.ToString();
               
                if (score == 1) { avgstar1.CssClass = "btn btn-warning btn-sm"; avgstar2.CssClass = "btn btn-default btn-grey btn-sm"; avgstar3.CssClass = "btn btn-default btn-grey btn-sm"; avgstar4.CssClass = "btn btn-default btn-grey btn-sm";/*avgstar5.CssClass = "btn btn-default btn-grey btn-sm";*/ }
                if (score == 2) { avgstar1.CssClass = "btn btn-warning btn-sm"; avgstar2.CssClass = "btn btn-warning btn-sm"; avgstar3.CssClass = "btn btn-default btn-grey btn-sm"; avgstar4.CssClass = "btn btn-default btn-grey btn-sm";/* avgstar5.CssClass = "btn btn-default btn-grey btn-sm";*/ }
                if (score == 3) { avgstar1.CssClass = "btn btn-warning btn-sm"; avgstar2.CssClass = "btn btn-warning btn-sm"; avgstar3.CssClass = "btn btn-warning btn-sm"; avgstar4.CssClass = "btn btn-default btn-grey btn-sm"; avgstar4.BackColor = System.Drawing.Color.Gray; /*avgstar5.CssClass = "btn btn-default btn-grey btn-sm";*/ }
                if (score == 4) { avgstar1.CssClass = "btn btn-warning btn-sm"; avgstar2.CssClass = "btn btn-warning btn-sm"; avgstar3.CssClass = "btn btn-warning btn-sm"; avgstar4.CssClass = "btn btn-warning btn-sm"; /*avgstar5.CssClass = "btn btn-default btn-grey btn-sm";*/ }
                if (score == 5) { avgstar1.CssClass = "btn btn-warning btn-sm"; avgstar2.CssClass = "btn btn-warning btn-sm"; avgstar3.CssClass = "btn btn-warning btn-sm"; avgstar4.CssClass = "btn btn-warning btn-sm"; /*avgstar5.CssClass = "btn btn-warning btn-sm"; */}  
            }
        }
        connection.Close();
    }
    private void BindBike()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
        SqlConnection connection = new SqlConnection(connectionString);
        connection.Open();

        DataTable userTable = new DataTable();
        if (connection.State == ConnectionState.Open)
        {

            SqlDataAdapter adapter = new SqlDataAdapter("SELECT * FROM Bike WHERE BikeID ='" + Convert.ToInt32(Session["TargetBike"]) + "'", connection);
            adapter.Fill(userTable);

            for (int i = 0; i < userTable.Rows.Count; i++)
            {
                lblPrice.Text = userTable.Rows[i]["Price"].ToString();
                lblCurr.Text = changeCurrency(userTable.Rows[i]["Currency"].ToString());
                lblAd.Text = userTable.Rows[i]["AdsHeader"].ToString();
                lblCityCounty.Text = changeLocation(userTable.Rows[i]["BikeCity"].ToString(), userTable.Rows[i]["BikeCounty"].ToString());
                lblTransmission.Text =changeTranmission(userTable.Rows[i]["Transmission"].ToString());
                lblBrand.Text = userTable.Rows[i]["Brand"].ToString();
                lblCategory.Text = changeCategory(userTable.Rows[i]["Category"].ToString());
                slideImage.ImageUrl = userTable.Rows[i]["Picture"].ToString();
                lblAnno.Text = userTable.Rows[i]["Description"].ToString();
                //currency ekle manipulaitondan sonra
            }

        }
        connection.Close();
    }
    public string ProcessDay(object oDate)
    {
        if (oDate is DBNull)
        {
            return "";
        }
        else
        {
            DateTime dDate = Convert.ToDateTime(oDate);
            string someDate = oDate.ToString();
            DateTime startDate = DateTime.Parse(someDate);
            DateTime now = DateTime.Now;
            TimeSpan elapsed = now.Subtract(startDate);
            double daysAgo = elapsed.TotalDays;
            string sDate = daysAgo.ToString("0");
            return (sDate + " days ago");
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
    public string changeTranmission(object transmission)
    {
        int transmissionInt;
        transmissionInt = Convert.ToInt32(transmission);
        return transmissionArr[transmissionInt];
    }
    public string changeCategory(object category)
    {
        int categoryInt;
        categoryInt = Convert.ToInt32(category);
        return categoryArr[categoryInt];
    }
    protected void btnMsg_Click(object sender, EventArgs e)
    {
        if (Session["kullaniciID"] != null)// && girili == true
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal1();", true);
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal2();", true);
        }
    }
}