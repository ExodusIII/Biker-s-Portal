using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
public partial class Profil : System.Web.UI.Page
{
    int BikeID;
    int EndBikeID;
    int BikeRentID;
    bool btn;
    int BikeRentOutID;
    int senderID;
    int TargetID;
    int userID;
    string[] currencyArr = { "₺", "$", "€", "£" };
    string[] cityArr = { "", "Ankara", "İstanbul" };
    string[,] countyArr = { { "", "", "", "", "", "" },
        { "Altındağ", "Çankaya", "Etimesgut", "Keçiören", "Sincan", "Yenimahalle" },
        { "Avcılar", "Emirgan", "Pendik", "Tuzla", "Üsküdar", "Zeytinburnu" } };
    List<string> messages;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) { BindIlan(); BindMessage(); bindRent(); FillPlaceHolders(); }
    }
    private void BindIlan()
    {
        string conn = ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
        using (SqlConnection con = new SqlConnection(conn))
        {
            using (SqlCommand cmd = new SqlCommand("SELECT dbo.Bike.BikeID, dbo.Bike.OwnerID, dbo.Bike.Brand, dbo.Bike.Category, dbo.Bike.Picture, dbo.Bike.Description, dbo.Bike.Transmission, dbo.Bike.AdsHeader, dbo.Bike.Price, dbo.Bike.Currency, dbo.Bike.AddingDate, dbo.Bike.Availability, dbo.Bike.BikeCity, dbo.Bike.BikeCounty, dbo.OnRentBike.RenterCheckIn, dbo.OnRentBike.HirerCheckIn FROM dbo.Bike LEFT OUTER JOIN dbo.OnRentBike ON dbo.Bike.BikeID = dbo.OnRentBike.BikeID WHERE(dbo.Bike.OwnerID = '" + Convert.ToInt32(Session["KullaniciID"]) + "') AND(dbo.Bike.Availability = '1')", con))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    Session.Add("IlanSayisi", dt.Rows.Count.ToString());
                    RepIlan.DataSource = dt;
                    RepIlan.DataBind();
                    if (dt.Rows.Count == 0)
                    {
                        RepIlan.Visible = false;
                        zeroIlan.Visible = true;
                    }
                }
            }
        }
    }
    public string ProcessMyDataItem(object myValue)//eval +++
    {
        if (myValue == DBNull.Value)
        {
            return "0";
        }

        return myValue.ToString();
    }
    private void BindMessage()
    {
        string conn = ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
        using (SqlConnection con = new SqlConnection(conn))
        {
            using (SqlCommand cmd = new SqlCommand(" SELECT dbo.[User].*, dbo.Message.* FROM  dbo.Message INNER JOIN dbo.[User] ON dbo.Message.SenderID = dbo.[User].UserID  WHERE TargetID ='" + Convert.ToInt32(Session["KullaniciID"]) + "'", con))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    Session.Add("MesajSayisi", dt.Rows.Count.ToString());
                    //string[] msgArr = new string[dt.Rows.Count];
                    //for (int i = 0; i < dt.Rows.Count; i++)//bosuna ugrastin amk . 
                    //{ 
                    //    string someDate = dt.Rows[i]["SendDate"].ToString();
                    //    DateTime startDate = DateTime.Parse(someDate);
                    //    DateTime now = DateTime.Now;
                    //    TimeSpan elapsed = now.Subtract(startDate);
                    //    double daysAgo = elapsed.TotalDays;
                    //    msgArr[i]= daysAgo.ToString("0");
                    //    //Session.Add("DaysAgo", daysAgo.ToString("0"));//item databoundda yapman lazim 
                    //    //messages = Session["SeatNum"] as List<string>;
                    //}
                    //Session["Days"] = msgArr;
                    RepMessage.DataSource = dt;
                    RepMessage.DataBind();
                    if (dt.Rows.Count == 0)
                    {
                        RepMessage.Visible = false;
                        zeroMsg.Visible = true;
                    }
                }
            }
        }
    }
    private int updateUser()//will take userID as param
    {
        int res = 0;
        //File and attributes
        HttpPostedFile postedFile = resim_yukle.PostedFile;
        string fileName = Path.GetFileName(postedFile.FileName);
        string fileExtension = Path.GetExtension(fileName);
        int fileSize = postedFile.ContentLength;

        //Current Project path
        string projectPath = AppDomain.CurrentDomain.BaseDirectory;
        //Full path to upload
        string fileUploadPath = projectPath + "\\ProfilPic\\" + fileName;
        //Upload the file to project
        resim_yukle.SaveAs(fileUploadPath);
        //data base path
        string fileDowloadPath = "~/ProfilPic/" + fileName;

        string conn = ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
        using (SqlConnection con = new SqlConnection(conn))
        {
            con.Open();
            if (con.State == ConnectionState.Open)
            {
                using (SqlCommand cmd = new SqlCommand("UPDATE [User] SET Name='" + NameInput.Text.Trim() + "' , Surname='" + SurnameInput.Text.Trim() + "', Phone='" + PhoneInput.Text.Trim() + "', Address='" + AddressInput.Text.Trim() + "', IDNumber='" + TCInput.Text.Trim() + "',IBAN='" + IBANInput.Text.Trim() + "', Annotation='" + AnnotationInput.Text.Trim() + "',UserPicture='" + fileDowloadPath + "' WHERE UserID='" + Convert.ToInt32(Session["KullaniciID"]) + "'", con))
                {
                    res = cmd.ExecuteNonQuery();

                }
            }
            return res;
        }

    }
    private int updateUserPw()//will take userID as param
    {
        int res = 0;
        string conn = ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
        using (SqlConnection con = new SqlConnection(conn))
        {
            SqlDataAdapter sda = new SqlDataAdapter("select UserPassword from [User] where UserID='" + Convert.ToInt32(Session["KullaniciID"]) + "' and UserPassword='" + txtOldPw.Text.Trim() + "'", con);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            if (dt.Rows.Count.ToString() == "1")
            {
                if (txtPw.Text.ToString() == txtPwControl.Text.ToString())
                {
                    con.Open();
                    if (con.State == ConnectionState.Open)
                    {
                        SqlCommand cmd = new SqlCommand("UPDATE [User] SET UserPassword='" + txtPwControl.Text.Trim() + "' WHERE UserID='" + Convert.ToInt32(Session["KullaniciID"]) + "'", con);
                        res = cmd.ExecuteNonQuery();
                        lblPwStatus.Text = "successfully updated.";
                        lblPwStatus.Visible = true;
                    }
                }
                else
                {
                    lblPwStatus.Text = "Passwords not matching.Please make sure you enter same pws";
                    lblPwStatus.Visible = true;
                }
            }
            else
            {
                lblPwStatus.Text = "your current pw is wrong.Please try again";
                lblPwStatus.Visible = true;
            }

        }
        return res;
    }
    public void SaveBtn_Click(object sender, EventArgs e)
    {
        int result = updateUser();
        if (result > 0)
        {
            lblStatus.Text = "TEMIZ";
            lblStatus.Visible = true;
        }

    }
    public void SaveBtnPass_Click(object sender, EventArgs e)
    {
        int result = updateUserPw();
    }
    public void Checkin_Click(object sender, EventArgs e)
    {
        int res = InsertCheckin();
        if (res > 0)
        {
            //Response.Write("basarili");
        }
        else
        {
            //Response.Write("basarisiz");
        }
        //select * from OnRentBike WHERE HirerUsername = '" + Convert.ToInt32(Session["kullaciniAdi"]) + "'
        //bindRent();
        // SELECT dbo.Bike.* FROM dbo.OnRentBike INNER JOIN dbo.[User] ON dbo.OnRentBike.HirerUsername = dbo.[User].Username INNER JOIN dbo.Bike ON dbo.OnRentBike.BikeID = dbo.Bike.BikeID
    }
    private void bindRent()
    {
        //SELECT * FROM dbo.Bike INNER JOIN dbo.OnRentBike ON dbo.Bike.BikeID = dbo.OnRentBike.BikeID INNER JOIN dbo.[User] ON dbo.OnRentBike.HirerUsername = dbo.[User].Username WHERE  (dbo.OnRentBike.BikeID = '" + Session["ChkBikeID"].ToString() + "')
        string conn = ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
        using (SqlConnection con = new SqlConnection(conn))
        {
            using (SqlCommand cmd = new SqlCommand("SELECT dbo.Bike.BikeID, dbo.Bike.OwnerID, dbo.Bike.Brand, dbo.Bike.Category, dbo.Bike.Picture, dbo.Bike.Description, dbo.Bike.Transmission, dbo.Bike.AdsHeader, dbo.Bike.Price, dbo.Bike.Currency, dbo.Bike.AddingDate, dbo.Bike.Availability, dbo.Bike.BikeCity, dbo.Bike.BikeCounty,dbo.OnRentBike.HirerCheckIn,dbo.OnRentBike.RenterCheckIn FROM  dbo.Bike INNER JOIN dbo.OnRentBike ON dbo.Bike.BikeID = dbo.OnRentBike.BikeID WHERE(dbo.OnRentBike.HirerUsername = '" + Session["kullaciniAdi"].ToString() + "')", con))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    Session.Add("KiraSayisi", dt.Rows.Count.ToString());
                    //for (int i = 0; i < dt.Rows.Count; i++)
                    //{
                    //    if ((Convert.ToInt32(dt.Rows[i]["CheckIn"])) == 1)
                    //    {
                    //        //button.text checkin out
                    //        btn = true;
                    //    }
                    //    if ((Convert.ToInt32(dt.Rows[i]["CheckIn"])) == 0)
                    //    {
                    //        //button.text onayla
                    //        btn = false;
                    //    }
                    //}
                    RepRent.DataSource = dt;
                    RepRent.DataBind();
                    if (dt.Rows.Count == 0)
                    {
                        RepRent.Visible = false;
                        zeroRent.Visible = true;
                    }
                }
            }
        }
    }
    protected void RepIlan_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        Button lb = e.Item.FindControl("btn1") as Button;
        if (lb != null)
        {
            if (e.CommandName == "CheckinnClick")
            {
                //Response.Write("girdi");
                BikeID = Convert.ToInt32(e.CommandArgument);
                //Response.Write(BikeID);
                Session.Add("ChkBikeID", BikeID);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal();", true);
            }
        }
        else { Response.Write("item not found"); }

        LinkButton lbEnd = e.Item.FindControl("lbTheEnd") as LinkButton;
        if (lbEnd != null)
        {
            if (e.CommandName == "TheEndClick")
            {
                //Response.Write("girdi");
                EndBikeID = Convert.ToInt32(e.CommandArgument);
                //Response.Write(EndBikeID);
                Session.Add("EndBikeID", EndBikeID);
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal();", true); pisikletiniz sapasaglam geri aldiniz mi hebele hubele
            }
        }
        else { Response.Write("item not found"); }


    }
    protected void RepRent_ItemCommand(object source, RepeaterCommandEventArgs e)
    {

        LinkButton lb = e.Item.FindControl("btnCheckinrent") as LinkButton;
        if (lb != null)
        {
            if (e.CommandName == "CheckinrentClick")
            {
                //Response.Write("girdi");
                BikeRentID = Convert.ToInt32(e.CommandArgument);
                //Response.Write(BikeRentID);
                Session.Add("RentBikeID", BikeRentID);
                int res = updateinRent();
                if (res > 0)
                {
                    //Response.Write("basarili"); 
                }
                else
                {
                    //Response.Write("GG");
                }
                int res2 = updateAvailability();
                if (res2 > 0)
                {
                    //Response.Write(" Abasarili");
                }
                else
                {
                    //Response.Write(" A GG"); 
                }
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal();", true); EMIN MISINIZ POP UP EKLENEBILIR
            }
        }
        else { Response.Write("item not found"); }

        LinkButton lbOut = e.Item.FindControl("btnCheckinoutrent") as LinkButton;
        if (lbOut != null)
        {
            if (e.CommandName == "CheckinoutrentClick")
            {
                //Response.Write("girdi");
                BikeRentOutID = Convert.ToInt32(e.CommandArgument);
                //Response.Write(BikeRentOutID);
                Session.Add("RentOutBikeID", BikeRentOutID);
                int res = updateOutRent();
                if (res > 0)
                {
                    //Response.Write("basarili"); 
                }
                else
                {
                    //Response.Write("GG"); 
                }
                int res2 = updateOutAvailability();
                if (res2 > 0)
                { //Response.Write(" Abasarili"); 
                }
                else
                { //Response.Write(" A GG"); 
                }
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal3();", true);
            }
        }
        else { Response.Write("item not found"); }

    }
    private int InsertCheckin()
    {
        int res = 0;
        var connectionString = ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
        SqlConnection connection = new SqlConnection(connectionString);
        connection.Open();

        //int ceptelnoInt = 0; Int64.TryParse(ceptelno.Text, out ceptelnoInt);
        //int IDInt = 0; Int64.TryParse(tcno.Text, out IDInt);
        string queryInsert = "INSERT INTO OnRentBike";
        try
        {
            if (connection.State == ConnectionState.Open && Session["ChkBikeID"] != null)
            {

                string queryValues = " VALUES('" + Convert.ToInt32(Session["ChkBikeID"]) + "','" + Session["kullaciniAdi"].ToString() + "','" + txtTarget.Text.ToString() + "','1','0')";
                Session.Add("HirerUsername", txtTarget.Text.ToString());
                string query = queryInsert + queryValues;
                SqlCommand cmd = new SqlCommand(query, connection);
                res = cmd.ExecuteNonQuery();

            }
            else
            {
                //errorbox.Text = "Başarıyla kayıt olunmadı.";
            }

        }
        catch (Exception ex)
        {
            Response.Write(ex);
        }
        //errorbox.Text = "Başarıyla kayıt olundu.";
        connection.Close();
        return res;
    }
    protected void btnCheckinrent_Click(object sender, EventArgs e)//repeatera tasi bikeid ile sessiona al temiz olsun
    {
        //delay ekleyebilirisn
        int res = updateinRent();
        if (res > 0)
        {
            //Response.Write("basarili");
        }
        else
        {
            //Response.Write("GG"); 
        }
        int res2 = updateAvailability();
        if (res2 > 0)
        {
            //Response.Write(" Abasarili"); 
        }
        else
        {
            //Response.Write(" A GG"); 
        }
    }
    private int updateinRent()//hirer
    {
        int res = 0;
        string conn = ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
        using (SqlConnection con = new SqlConnection(conn))
        {
            con.Open();
            if (con.State == ConnectionState.Open && Session["kullaciniAdi"] != null)
            {
                using (SqlCommand cmd = new SqlCommand("UPDATE dbo.OnRentBike SET dbo.OnRentBike.HirerCheckIn='1' WHERE(dbo.OnRentBike.HirerUsername = '" + Session["kullaciniAdi"].ToString() + "')", con))
                {
                    res = cmd.ExecuteNonQuery();
                }
            }
            return res;
        }
    }
    private int updateAvailability()//hirer
    {
        int res = 0;
        string conn = ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
        using (SqlConnection con = new SqlConnection(conn))
        {
            con.Open();
            if (con.State == ConnectionState.Open && Session["RentBikeID"] != null)//renterusername al ordan where where bikeID
            {
                //Response.Write("rentbike not null");
                //update b set[Availability] = '1' from[dbo].[Bike] b inner join[dbo].[OnRentBike] s on  b.BikeID = s.BikeID where s.BikeID = '1'
                using (SqlCommand cmd = new SqlCommand("UPDATE CUST SET  CUST.[Availability] = '0' FROM   dbo.Bike CUST INNER JOIN dbo.OnRentBike ORDR ON CUST.BikeID = ORDR.BikeID WHERE ORDR.BikeID='" + Convert.ToInt32(Session["RentBikeID"]) + "'", con))
                {
                    res = cmd.ExecuteNonQuery();
                }
            }
            return res;
        }
    }
    protected void btnCheckinoutrent_Click(object sender, EventArgs e)//text onay bekleniyor
    {
        //int res = updateOutRent();
        //if (res > 0) {
        //    //Response.Write("basarili"); 
        //}
        //else {
        //    //Response.Write("GG"); 
        //}
        //int res2 = updateOutAvailability();
        //if (res2 > 0) { //Response.Write(" Abasarili"); 
        //}
        //else { //Response.Write(" A GG"); 
        //}
    }
    private int updateOutRent()//hirer
    {
        int res = 0;
        string conn = ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
        using (SqlConnection con = new SqlConnection(conn))
        {
            con.Open();
            if (con.State == ConnectionState.Open && Session["kullaciniAdi"] != null)//Session["RentOutBikeID"] !=null
            {
                using (SqlCommand cmd = new SqlCommand("UPDATE dbo.OnRentBike SET dbo.OnRentBike.HirerCheckIn='0' WHERE(dbo.OnRentBike.HirerUsername = '" + Session["kullaciniAdi"].ToString() + "')", con))
                {
                    res = cmd.ExecuteNonQuery();
                }
            }
            return res;
        }
    }
    private int updateOutAvailability()//hirer//olmazsa joinle where username=renterusername then update bike
    {
        int res = 0;
        string conn = ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
        using (SqlConnection con = new SqlConnection(conn))
        {
            con.Open();
            if (con.State == ConnectionState.Open && Session["RentOutBikeID"] != null)//renterusername al ordan where where bikeID
            {
                //update b set[Availability] = '1' from[dbo].[Bike] b inner join[dbo].[OnRentBike] s on  b.BikeID = s.BikeID where s.BikeID = '1'
                using (SqlCommand cmd = new SqlCommand("UPDATE CUST SET  CUST.[Availability] = '1' FROM   dbo.Bike CUST INNER JOIN dbo.OnRentBike ORDR ON CUST.BikeID = ORDR.BikeID WHERE ORDR.BikeID='" + Convert.ToInt32(Session["RentOutBikeID"]) + "'", con))
                {
                    res = cmd.ExecuteNonQuery();
                }
            }
            return res;
        }
    }
    protected void btnTheEnd_Click(object sender, EventArgs e)
    {
        int res = EndCheckin();
        if (res > 0)
        {
            //Response.Write("basarili"); 
        }
        else
        {
            //Response.Write("GG"); 
        }
        int res2 = deleteRecord();
        if (res > 0)
        {
            //Response.Write("silindi"); 
        }
        else
        {
            //Response.Write("GG bok silersin"); 
        }
    }
    private int EndCheckin()
    {
        int res = 0;
        string conn = ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
        using (SqlConnection con = new SqlConnection(conn))
        {
            con.Open();
            if (con.State == ConnectionState.Open && Session["kullaciniAdi"] != null)
            {
                using (SqlCommand cmd = new SqlCommand("UPDATE dbo.OnRentBike SET dbo.OnRentBike.RenterCheckIn='0' WHERE(dbo.OnRentBike.RenterUsername = '" + Session["kullaciniAdi"].ToString() + "')", con))
                {
                    res = cmd.ExecuteNonQuery();
                }
            }
            return res;
        }
    }
    private int deleteRecord()
    {
        int res = 0;
        string conn = ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
        using (SqlConnection con = new SqlConnection(conn))
        {
            con.Open();
            if (con.State == ConnectionState.Open && Session["kullaciniAdi"] != null)
            {
                using (SqlCommand cmd = new SqlCommand("DELETE FROM dbo.OnRentBike WHERE(dbo.OnRentBike.RenterUsername = '" + Session["kullaciniAdi"].ToString() + "')", con))
                {
                    res = cmd.ExecuteNonQuery();
                }
            }
            return res;
        }
    }
    protected void RepMessage_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        LinkButton lb = e.Item.FindControl("btnmes") as LinkButton;
        if (lb != null)
        {
            if (e.CommandName == "MessageClick")
            {
                string[] commandArgs = e.CommandArgument.ToString().Split(new char[] { ',' });
                string OwnerID = commandArgs[0];
                string Bid = commandArgs[1];

                //Response.Write("girdi");
                TargetID = Convert.ToInt32(OwnerID);
                //Response.Write(OwnerID);
                Session.Add("MsgTargetID", OwnerID);
                txtMessageTargetUsername.Text = Bid;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal2();", true);
            }
        }
        else { Response.Write("item not found"); }

    }
    public void Respond_Click(object sender, EventArgs e)
    {
        RespondMessage();
    }
    private void RespondMessage()//guncellencek
    {
        string connectionString = ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
        SqlConnection connection = new SqlConnection(connectionString);
        connection.Open();

        if (connection.State == ConnectionState.Open && Session["MsgTargetID"] != null)
        {
            //guncelle
            SqlCommand cmd = new SqlCommand("insert into [Message](TargetID,[Message],SendDate,SenderID) values('" + Convert.ToInt32(Session["MsgTargetID"]) + "','" + txtMessageText.Text.Trim() + "','5/1/2008 8:30:52 AM','" + Convert.ToInt32(Session["kullaniciID"]) + "')", connection);//where target bilmem ne 
            cmd.ExecuteNonQuery();
        }
        connection.Close();

    }
    private void FillPlaceHolders()
    {
        NameInput.Text = Session["isim"].ToString();
        SurnameInput.Text = Session["soyisim"].ToString();
        PhoneInput.Text = Session["cepno"].ToString();
        AddressInput.Text = Session["adres"].ToString();
        IBANInput.Text = Session["iban"].ToString();
        TCInput.Text = Session["tcno"].ToString();
        AnnotationInput.Text = Session["ekaciklama"].ToString();
        uNameInput.Text = Session["kullaciniAdi"].ToString();
        emailInput.Text = Session["email"].ToString();
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
    public void btnSendFeedback_Click(object sender, EventArgs e)
    {
        int res = InsertFeedback();
        if (res > 0)
        {
            //Response.Write("basarili"); 
        }
        else
        {
            //Response.Write("GG"); 
        }
    }
    private int InsertFeedback()
    {
        int res = 0;
        var connectionString = ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
        SqlConnection connection = new SqlConnection(connectionString);
        connection.Open();

        try
        {
            if (connection.State == ConnectionState.Open && Session["kullaniciID"] != null && Session["RentOutBikeID"] != null)
            {

                SqlCommand cmd = new SqlCommand("InsertFeedback", connection);
                cmd.CommandType = CommandType.StoredProcedure;

                SqlParameter paramOwner = new SqlParameter()
                {
                    ParameterName = "@userid",
                    Value = Convert.ToInt32(Session["kullaniciID"])
                };
                cmd.Parameters.Add(paramOwner);
                SqlParameter paramMarka = new SqlParameter()
                {
                    ParameterName = "@bikeid",
                    Value = Convert.ToInt32(Session["RentOutBikeID"])
                };
                cmd.Parameters.Add(paramMarka);
                SqlParameter paramTur = new SqlParameter()
                {
                    ParameterName = "@fbtext",
                    Value = txtFeedback.Text.ToString()
                };
                cmd.Parameters.Add(paramTur);
                SqlParameter paramImage = new SqlParameter()
                {
                    ParameterName = "@score",
                    Value = Convert.ToInt32(Score.SelectedValue)
                };
                cmd.Parameters.Add(paramImage);
                SqlParameter paramAciklama = new SqlParameter()
                {
                    ParameterName = "@datee",
                    Value = DateTime.Now
                };
                cmd.Parameters.Add(paramAciklama);

                res = cmd.ExecuteNonQuery();
            }

            else
            {
                //errorbox.Text = "Başarıyla kayıt olunmadı.";
            }

        }
        catch (Exception ex)
        {
            Response.Write(ex);
        }
        //errorbox.Text = "Başarıyla kayıt olundu.";
        connection.Close();
        return res;
    }
    protected void RepBikes_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName == "ImageClick")
        {
            string[] commandArgs = e.CommandArgument.ToString().Split(new char[] { ',' });
            string OwnerID = commandArgs[0];
            string Bid = commandArgs[1];

            //Response.Write("tikladin");
            userID = Convert.ToInt32(OwnerID);
            BikeID = Convert.ToInt32(Bid);

            Session.Add("Target", userID);
            Session.Add("TargetBike", BikeID);

            Response.Redirect("BikeDescription.aspx");
        }
    }
}