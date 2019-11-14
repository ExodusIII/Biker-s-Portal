using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class Home : System.Web.UI.MasterPage
{
    static bool girili;
    
    protected void loginin_logout()
    {
        string curPage = HttpContext.Current.Request.Url.AbsolutePath.ToString();
        if (curPage == "/Home.aspx") { }
        if (curPage == "/Profil.aspx") { if (Session["MesajSayisi"].ToString() != null && Session["IlanSayisi"].ToString() != null) { lblMesajSayisi.Text = Session["MesajSayisi"].ToString(); lblIlanSayisi.Text = Session["IlanSayisi"].ToString(); } ProfilSidebar(); anamenu.Visible = false; profilmenu.Visible = true; }
        if (Session["logincheck"] == null)
        {
            uye_giris_buttons.Visible = true;
            profil.Visible = false;
        }
        else
        {
            uye_giris_buttons.Visible = false;
            profil.Visible = true;
            
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        Session.Add("category", "0");
        loginin_logout();
    }
    protected void kayit_ol_Click(object sender, EventArgs e)
    {
        Response.Redirect("SignUp.aspx");
    }
    private void ProfilSidebar()
    {

        string connectionString = ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
        SqlConnection connection = new SqlConnection(connectionString);
        connection.Open();

        DataTable userTable = new DataTable();
        if (connection.State == ConnectionState.Open)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT * FROM [dbo].[User] WHERE UserID='" + Session["KullaniciID"].ToString() + "'", connection);
            adapter.Fill(userTable);
            try
            {
                for (int i = 0; i < userTable.Rows.Count; i++)
                {

                    lblProfilUsername.Text = userTable.Rows[i]["Username"].ToString();
                    lblProfilAnno.Text = userTable.Rows[i]["Annotation"].ToString();
                    phImage.ImageUrl = userTable.Rows[i]["UserPicture"].ToString();
                }
            }
            catch (Exception ex)
            {
                sonuc.Text = ex.ToString();
            }
        }
        connection.Close();
    }
    protected void giris_yap_Click(object sender, EventArgs e)
    {

        string connectionString = ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
        SqlConnection connection = new SqlConnection(connectionString);
        connection.Open();

        DataTable userTable = new DataTable();
        if (connection.State == ConnectionState.Open)
        {

            SqlDataAdapter adapter = new SqlDataAdapter("SELECT * FROM [dbo].[User]", connection);
            adapter.Fill(userTable);
            try { 
                for (int i = 0; i < userTable.Rows.Count; i++)
                {
                    if (kullanici_adi.Text.ToString() == (string)userTable.Rows[i]["Username"] && parola.Text.ToString() == (string)userTable.Rows[i]["UserPassword"])
                    { 
                        Session.Add("kullaniciID", userTable.Rows[i]["UserID"]);
                        Session.Add("kullaciniAdi", userTable.Rows[i]["Username"]);
                        Session.Add("kullaniciTur", userTable.Rows[i]["UserType"]);
                        Session.Add("isim", userTable.Rows[i]["Name"]);
                        Session.Add("soyisim", userTable.Rows[i]["Surname"]);
                        Session.Add("email", userTable.Rows[i]["Email"]);
                        Session.Add("cepno", userTable.Rows[i]["Phone"]);
                        Session.Add("adres", userTable.Rows[i]["Address"]);
                        Session.Add("iban", userTable.Rows[i]["IBAN"]);
                        Session.Add("tcno", userTable.Rows[i]["IDNumber"]);
                        Session.Add("ekaciklama", userTable.Rows[i]["Annotation"]);
                        Session.Add("logincheck", "1");
                        //girili = true;
                        Session.Timeout = 30; //x min timeout

                        Response.Redirect("Main.aspx");
                    }
                }
            }
            catch(Exception ex)
            {
                sonuc.Text = ex.ToString();
            }
        }
        connection.Close();
    }
    protected void ilan_ver_Click(object sender, EventArgs e)
    {
        Response.Redirect("Rent_A_Bike.aspx");
    }
    protected void userprofil_Click(object sender, EventArgs e)
    {
        Response.Redirect("Profil.aspx");

    }
    protected void cikis_Click(object sender, EventArgs e)
    {
        Session.Contents.RemoveAll();
        //girili = false;
        Response.Redirect("Main.aspx");
    }
    protected void main_Click(object sender, EventArgs e)
    {
        Response.Redirect("Main.aspx");
    }
    protected void hepsi_Click(object sender, EventArgs e)
    {
        Session.Add("category", "0");
        Response.Redirect("SortedBikes.aspx");
    }
    protected void dag_Click(object sender, EventArgs e)
    {
        Session.Add("category", "1");
        Response.Redirect("SortedBikes.aspx");
    }
    protected void sehir_Click(object sender, EventArgs e)
    {
        Session.Add("category", "2");
        Response.Redirect("SortedBikes.aspx");
    }
    protected void yol_Click(object sender, EventArgs e)
    {
        Session.Add("category", "3");
        Response.Redirect("SortedBikes.aspx");
    }
    protected void cocuk_Click(object sender, EventArgs e)
    {
        Session.Add("category", "4");
        Response.Redirect("SortedBikes.aspx");
    }
    protected void searchItemBtn_Click(object sender, EventArgs e)
    {
        Response.Redirect("SortedBikes.aspx");
    }
}