using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

public partial class Support : System.Web.UI.Page
{
    DateTime dateTime = DateTime.Today;
    protected void Page_Load(object sender, EventArgs e)
    {
       
    }

    protected void send_ticket(object sender, EventArgs e)
    {
        var encodedResponse = Request.Form["g-Recaptcha-Response"];
        var isCaptchaValid = ReCaptcha.Validate(encodedResponse);
        var connectionString = ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
        SqlConnection connection = new SqlConnection(connectionString);
        connection.Open();
        if (isCaptchaValid)
        {
            try
            {
                if (connection.State == ConnectionState.Open)
                {
                    string query = "INSERT INTO [dbo].[Ticket]([TManagerID],[Email],[Subject],[Description],[Date],[category]) VALUES(" + 1 + ",'" + email.Text + "','" + konu.Text + "','" + aciklama.Text + "','" + dateTime.ToShortDateString() + "','" + kategori.SelectedItem + "')";
                    SqlCommand cmd = new SqlCommand(query, connection);
                    cmd.ExecuteNonQuery();
                    errorbox.Text = "Başarıyla Gönderildi.";
                }
            }
            catch (Exception ex)
            {
                Response.Write(ex);
                errorbox.Text = "Başarıyla Gönderilmedi.";
                goto close;
            }
        }
        else
        {
            errorbox.Text = "Başarıyla Gönderilmedi.";
        }
        
        close:
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