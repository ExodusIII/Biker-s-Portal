using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

public partial class SignUp : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void SignIn_Click(object sender, EventArgs e)
    {
        var encodedResponse = Request.Form["g-Recaptcha-Response"];
        var isCaptchaValid = ReCaptcha.Validate(encodedResponse);
        var connectionString = ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
        SqlConnection connection = new SqlConnection(connectionString);
        connection.Open();


        //int ceptelnoInt = 0; Int64.TryParse(ceptelno.Text, out ceptelnoInt);
        //int IDInt = 0; Int64.TryParse(tcno.Text, out IDInt);
        string query;
        string queryInsert = "INSERT INTO [dbo].[User]([Username],[UserPassword],[UserType],[Name],[Surname],[Email],[Phone],[Address],[BDate],[IBAN],[UserPicture],[Annotation],[IDNumber])";
        if (isCaptchaValid)
        {
            try
            {
                if (connection.State == ConnectionState.Open && sozlesme.Checked)
                {

                    string queryValues = " VALUES('" + kullanici_adi.Text + "','" + parola.Text + "'," + tur.SelectedValue + ",'" + isim.Text + "','" + soyisim.Text + "','" + email.Text + "','" + ceptelno.Text + "','" + adres.Text + "','" + dogum_tarihi.Text + "','" + IBAN.Text + "',NULL,NULL,";
                    query = queryInsert + queryValues;
                    if (tcno.Text == "")
                    {
                        query += "NULL)";
                    }
                    else
                    {
                        query += "'" + tcno.Text + "')";
                    }

                    SqlCommand cmd = new SqlCommand(query, connection);
                    cmd.ExecuteNonQuery();
                    errorbox.Text = "Başarıyla kayıt olundu.";
                }
                else
                {
                    errorbox.Text = "Başarıyla kayıt olunmadı.";
                }
            }
            catch (Exception ex)
            {
                Response.Write(ex);
            }
        }
        else
        {
            errorbox.Text = "Başarıyla kayıt olunmadı.";
        }
        
        connection.Close();
    }
    public class ReCaptcha
    {
        public bool Success { get; set; }
        public List<string> ErrorCodes { get; set; }

        public static bool Validate(string encodedResponse)
        {
            if (string.IsNullOrEmpty(encodedResponse)) return false;

            var client = new System.Net.WebClient();
            var secret = "6LdlNFYUAAAAALpyiHzEynrkY3HSEgYc8lXhIyxp";

            if (string.IsNullOrEmpty(secret)) return false;

            var googleReply = client.DownloadString(string.Format("https://www.google.com/recaptcha/api/siteverify?secret={0}&response={1}", secret, encodedResponse));

            var serializer = new System.Web.Script.Serialization.JavaScriptSerializer();

            var reCaptcha = serializer.Deserialize<ReCaptcha>(googleReply);

            return reCaptcha.Success;
        }
    }
}
