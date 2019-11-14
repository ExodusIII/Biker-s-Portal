using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.IO;

public partial class Rent_A_Bike : System.Web.UI.Page
{
 
    DateTime dateTime = DateTime.Today;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //İl- ilce first items
            ilBike.Items.Insert(0, new ListItem("İl Seçiniz..", "0"));
            ilBike.Items.Insert(1, new ListItem("Ankara", "1"));
            ilBike.Items.Insert(2, new ListItem("İstanbul", "2"));
            ilceBike.Items.Insert(0, new ListItem("İlçe Seçiniz..", "0"));
            
            //Tur-vites first items
            tur.Items.Insert(0, new ListItem("Tür Seçiniz", "0"));
            tur.Items.Insert(1, new ListItem("Dağ Bisikleti", "1"));
            tur.Items.Insert(2, new ListItem("Şehir Bisikleti", "2"));
            tur.Items.Insert(3, new ListItem("Yarış/Yol Bisikleti", "3"));
            tur.Items.Insert(4, new ListItem("Çocuk Bisikleti", "4"));
            vites.Items.Insert(0, new ListItem("Vites Seçiniz", "0"));
        }
    }
    protected void ilan_ver_Click(object sender, EventArgs e)
    {
        var encodedResponse = Request.Form["g-Recaptcha-Response"];
        var isCaptchaValid = ReCaptcha.Validate(encodedResponse);
        var connectionString = ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
        SqlConnection connection = new SqlConnection(connectionString);

        //Insert
        float ucretInt = float.Parse(ucret.Text, System.Globalization.CultureInfo.InvariantCulture);
        //string queryInsert = "INSERT INTO [dbo].[Bike]([Brand],[Category],[Picture],[Description],[Transmission],[AdsHeader],[Price],[Currency],[Availability],[AddingDate])";

        //File and attributes
        HttpPostedFile postedFile = resim_yukle.PostedFile;
        string fileName = Path.GetFileName(postedFile.FileName);
        string fileExtension = Path.GetExtension(fileName);
        int fileSize = postedFile.ContentLength;

        //Current Project path
        string projectPath = AppDomain.CurrentDomain.BaseDirectory;
        //Full path to upload
        string fileUploadPath = projectPath + "\\BikePic\\" + fileName; 
        //Upload the file to project
        resim_yukle.SaveAs(fileUploadPath);
        //data base path
        string fileDowloadPath = "~/BikePic/" + fileName;

        if (isCaptchaValid)
        {
            if (fileExtension.ToLower() == ".jpg" || fileExtension.ToLower() == ".gif"
                || fileExtension.ToLower() == ".png" || fileExtension.ToLower() == ".bmp")
            {
                connection.Open();
                try
                {
                    if (connection.State == ConnectionState.Open && sozlesme.Checked)
                    {

                        SqlCommand cmd = new SqlCommand("BikeInsert", connection);
                        cmd.CommandType = CommandType.StoredProcedure;

                        SqlParameter paramOwner = new SqlParameter()
                        {
                            ParameterName = "@owner",
                            Value = Convert.ToInt32(Session["kullaniciID"])
                        };
                        cmd.Parameters.Add(paramOwner);
                        SqlParameter paramMarka = new SqlParameter()
                        {
                            ParameterName = "@marka",
                            Value = marka.Text
                        };
                        cmd.Parameters.Add(paramMarka);
                        SqlParameter paramTur = new SqlParameter()
                        {
                            ParameterName = "@tur",
                            Value = tur.SelectedValue
                        };
                        cmd.Parameters.Add(paramTur);
                        SqlParameter paramImage = new SqlParameter()
                        {
                            ParameterName = "@image",
                            Value = fileDowloadPath
                        };
                        cmd.Parameters.Add(paramImage);
                        SqlParameter paramAciklama = new SqlParameter()
                        {
                            ParameterName = "@aciklama",
                            Value = ilan_aciklama.Text
                        };
                        cmd.Parameters.Add(paramAciklama);
                        SqlParameter paramVites = new SqlParameter()
                        {
                            ParameterName = "@vites",
                            Value = vites.SelectedValue
                        };
                        cmd.Parameters.Add(paramVites);
                        SqlParameter paramBaslik = new SqlParameter()
                        {
                            ParameterName = "@baslik",
                            Value = ilan_baslik.Text
                        };
                        cmd.Parameters.Add(paramBaslik);
                        SqlParameter paramUcret = new SqlParameter()
                        {
                            ParameterName = "@ucret",
                            Value = ucretInt
                        };
                        cmd.Parameters.Add(paramUcret);
                        SqlParameter paramBirim = new SqlParameter()
                        {
                            ParameterName = "@birim",
                            Value = parabirim.SelectedValue
                        };
                        cmd.Parameters.Add(paramBirim);
                        SqlParameter paramUlasik = new SqlParameter()
                        {
                            ParameterName = "@ulasik",
                            Value = 1
                        };
                        cmd.Parameters.Add(paramUlasik);
                        SqlParameter paramDate = new SqlParameter()
                        {
                            ParameterName = "@datee",
                            Value = dateTime
                        };
                        cmd.Parameters.Add(paramDate);

                        SqlParameter paramCity = new SqlParameter()
                        {
                            ParameterName = "@city",
                            Value = ilBike.SelectedValue
                        };
                        cmd.Parameters.Add(paramCity);
                        SqlParameter paramCounty = new SqlParameter()
                        {
                            ParameterName = "@county",
                            Value = ilceBike.SelectedValue
                        };
                        cmd.Parameters.Add(paramCounty);

                        cmd.ExecuteNonQuery();
                        errorbox.Text = "İlan başarıyla verildi.";
                    }
                    else
                    {
                        errorbox.Text = "Bilinmeyene hata. Yazdığınız bilgileri kontrol ediniz.";
                    }
                }
                catch (Exception ex)
                {
                    Response.Write(ex);
                }
            }
        }
        else
        {
            errorbox.Text = "İlan başarıyla verilmedi.";
        }
        connection.Close();
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
    protected void tur_SelectedIndexChanged(object sender, EventArgs e)
    {
        vites.Items.Clear();
        vites.Items.Insert(0, new ListItem("Vites Seçiniz", "0"));
        int turBike = Int32.Parse(tur.SelectedItem.Value);
        string[,] dagVites = new string[,]{ { "20", "1x11" }, { "21", "2x10" }, { "22", "2x11" }, { "23", "3x6" }, 
            { "24", "3x7" }, { "26", "3x8" }, { "27", "3x9" }, { "28", "3x10" }
        };
        string[,] normalBike = new string[,] { { "1", "1" }, { "2", "2" }, { "3", "3" }, { "4", "6" }, { "5", "7" }, { "6", "8" },
        { "7", "9" }, { "8", "10" }, { "9", "11" }, { "10", "12" }, { "11", "14" }, { "12", "16" }, { "13", "18" }, { "14", "20" }, { "15", "21" },
        { "16", "22" }, { "17", "24" }, { "18", "27" }, { "19", "30" } };


        if(turBike == 1)
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
            vites.Items.Insert(1, new ListItem("1", "1"));
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