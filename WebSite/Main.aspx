<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true" CodeFile="Main.aspx.cs" Inherits="Main" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="container">
        <div class="row">
            <h1 class="my-4">Biker's Portal</h1>

            <!-- Blog Post -->


            <div id="carouselExampleControls" class="carousel slide" data-ride="carousel">
                <div class="carousel-inner">
                    <div class="carousel-item active">
                        <a href="SortedBikes.aspx">
                            <img class="d-block w-100" width="300" height="400" src="img/slide1.jpg" />
                        </a>
                    </div>
                    <div class="carousel-item">
                        <a href="SignUp.aspx">
                            <img class="d-block w-100" width="300" height="400" src="img/slide2.jpg" />
                        </a>
                    </div>
                    <div class="carousel-item">
                        <img class="d-block w-100" width="300" height="400" src="img/takip.jpg" />
                    </div>

                </div>
                <a class="carousel-control-prev" href="#carouselExampleControls" role="button" data-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                </a>
                <a class="carousel-control-next" href="#carouselExampleControls" role="button" data-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="sr-only">Next</span>
                </a>
            </div>

        </div>


        <div class="row">
            <div class="col-sm-4">
                <br />
                <img height="100" width="250" src="img/hakkimizda.jpg" />
                <br />
                <p>Biker’s Portal hem kişisel bilgisayarlarda hem de mobil cihazlarda çalışan bir bisiklet kiralama sitesidir. Biker’s Portal web sitesi bisiklet sahibi ve kiralamak isteyen kişi arasında aracı olur. Bu şekilde kenarda kalmış, kullanılmayan bisikletler değerlendirilecek veya lokal bisiklet dükkanları kendi kullanım ağlarını genişletebilecekler.</p>

            </div>
            <div class="col-sm-4">
                <br />
                <img height="100" width="250" src="img/guvenlik.jpg" />
                <br />
                <p>Şirketimiz tarafından kişisel verilerinizin değişikliğe veya kazara ya da yasadışı kayıplara veya izinsiz kullanıma, ifşa etmeye ya da erişime karşı korumak amacıyla gerekli teknik ve organizasyonel önlemler alınmaktadır.</p>

            </div>
            <div class="col-sm-4">
                <br />
                <img height="100" width="250" src="img/bisiklett.jpg" />
                <br />
                <p>Bisiklete binmek kasları güçlendirir, nefes alımını düzenler, aşırı kilo alımını önler, kolesterol, yüksek tansiyon, eklem ve romatizma ağrılarına da iyi gelir. Bisiklet kullanımı stresi azalttığı gibi doğanın korunmasına da yardımcı olur.</p>
            </div>

        </div>
    </div>
</asp:Content>

