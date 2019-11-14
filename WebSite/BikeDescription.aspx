<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true" CodeFile="BikeDescription.aspx.cs" Inherits="BikeDescription" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <br />
    <br />
    <div class="container">
        <div class="row">
            <h1 class="col-md-12">
                <asp:Label ID="lblAd" runat="server"></asp:Label></h1>
            <div class="col-sm-7">
                <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
                    <ol class="carousel-indicators">
                        <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
                        <%--<li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
                        <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>--%>
                    </ol>
                    <div class="carousel-inner">
                        <div class="carousel-item active">
                            <asp:Image ID="slideImage" runat="server" CssClass="img-fluid" />
                        </div>

                    </div>
                    <%-- İleri-Geri Buttons --%>
                    <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="sr-only">Previous</span>
                    </a>
                    <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="sr-only">Next</span>
                    </a>
                </div>
                <br />
                <div class="row">
                    <div class="offset-md-3 col-md-6">
                        <button type="button" class="btn btn-warning btn-md" data-toggle="modal" data-target="#myModal1">
                            Hemen ilan sahibiyle
                        <br />
                            iletişime geç!</button>
                    </div>
                    <div id="myModal1" class="modal fade" role="dialog">
                        <div class="modal-dialog">

                            <!-- Modal content-->
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h3>Mesaj Gönder</h3>
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                </div>
                                <div class="modal-body">
                                    <!-- Password input-->
                                    <div class="form-group">
                                        <label class="col-md-4 control-label" for="messageinput">Mesaj</label>
                                        <div class="col-md-8">
                                            <asp:TextBox ID="txtMessage" runat="server" class="form-control" TextMode="MultiLine"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-md-8">
                                            <asp:Button ID="btnMessage" runat="server" CssClass="btn btn-warning" OnClick="SaveBtnPass_Click" Text="Mesaj Gönder" />
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
                <br />
            </div>
            <div class="col-sm-5">
                <h4>
                    <asp:Label ID="lblPrice" runat="server"></asp:Label>
                    <asp:Label ID="lblCurr" runat="server"></asp:Label>
                </h4>
                <h5>
                    <asp:Label ID="lblCityCounty" runat="server"></asp:Label>
                </h5>
                <div id="accordion">
                    <div class="card">
                        <div class="card-header">
                            <a class="card-link" data-toggle="collapse" href="#collapseOne">İletişim Bilgileri</a>
                        </div>
                        <div id="collapseOne" class="collapse" data-parent="#accordion">
                            <div class="card-body">
                                <asp:Repeater ID="RepUser" runat="server">
                                    <HeaderTemplate>
                                        <table class="table">
                                            <thead>
                                                <tr>
                                                    <th scope="col"></th>
                                                    <th scope="col"></th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <tr>
                                            <td>İsim Soyisim:</td>
                                            <td><%# Eval("Name") %>
                                                <br />
                                                <%# Eval("Surname") %></td>
                                        </tr>
                                        <tr>
                                            <td>Telefon:</td>
                                            <td><%# Eval("Phone") %></td>
                                        </tr>
                                        <tr>
                                            <td>Adres:</td>
                                            <td><%# Eval("Address") %></td>
                                        </tr>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        </tbody>
                                </table>
                                    </FooterTemplate>
                                </asp:Repeater>
                            </div>
                        </div>
                    </div>
                    <div class="card">
                        <div class="card-header">
                            <a class="collapsed card-link" data-toggle="collapse" href="#collapseTwo">Bisikletin Özellikleri</a>
                        </div>
                        <div id="collapseTwo" class="collapse" data-parent="#accordion">
                            <div class="card-body">
                                <table class="table">
                                    <tr>
                                        <th></th>
                                        <th></th>
                                    </tr>
                                    <tr>
                                        <td>Marka:</td>
                                        <td>
                                            <asp:Label ID="lblBrand" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td>Tür:</td>
                                        <td>
                                            <asp:Label ID="lblCategory" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td>Vites:</td>
                                        <td>
                                            <asp:Label ID="lblTransmission" runat="server"></asp:Label></td>
                                    </tr>
                                </table>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <br />
        <br />

        <ul class="nav nav-tabs" id="myTab" role="tablist">
            <li class="nav-item">
                <a class="nav-link active" data-toggle="tab" href="#home" aria-controls="home" aria-selected="true">Bisiklet Açıklaması</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-toggle="tab" href="#yorum" aria-controls="yorum" aria-selected="false">Ürün Hakkındaki Yorumlar</a>
            </li>
        </ul>

        <div class="tab-content" id="myTabContent">
            <div id="home" class="tab-pane fade show active" role="tabpanel" aria-labelledby="home-tab">
                <br />
                <br />
                <asp:Label ID="lblAnno" runat="server"></asp:Label>

            </div>
            <div id="yorum" class="tab-pane fade" role="tabpanel" aria-labelledby="yorum-tab">
                <nav class="navbar navbar-default navbar-fixed-top">
                    <div class="container">
                        <div class="row">
                            <div class="col-sm-4">
                                <h4>Average user rating</h4>
                                <h2 class="bold padding-bottom-7">
                                    <asp:Label ID="lblScore" runat="server"></asp:Label><small>/ 5</small></h2>

                                <asp:LinkButton ID="avgstar1" runat="server" aria-label="Left Align"><span class="fa fa-star" aria-hidden="true"></span></asp:LinkButton>
                                <asp:LinkButton ID="avgstar2" runat="server" aria-label="Left Align"><span class="fa fa-star" aria-hidden="true"></span></asp:LinkButton>
                                <asp:LinkButton ID="avgstar3" runat="server" aria-label="Left Align"><span class="fa fa-star" aria-hidden="true"></span></asp:LinkButton>
                                <asp:LinkButton ID="avgstar4" runat="server" aria-label="Left Align"><span class="fa fa-star" aria-hidden="true"></span></asp:LinkButton>
                                <%--garip bi sekilde calismiyor  <asp:LinkButton ID="avgstar5" runat="server" aria-label="Left Align"><span class="fa fa-star" aria-hidden="true"></span></asp:LinkButton>--%>

                                <%--<button type="button" class="btn btn-warning btn-sm" aria-label="Left Align">
                                    <span class="fa fa-star" aria-hidden="true"></span>
                                </button>
                                <button type="button" class="btn btn-warning btn-sm" aria-label="Left Align">
                                    <span class="fa fa-star" aria-hidden="true"></span>
                                </button>
                                <button type="button" class="btn btn-warning btn-sm" aria-label="Left Align">
                                    <span class="fa fa-star" aria-hidden="true"></span>
                                </button>
                                <button type="button" class="btn btn-default btn-grey btn-sm" aria-label="Left Align">
                                    <span class="fa fa-star" aria-hidden="true"></span>
                                </button>
                                <button type="button" class="btn btn-default btn-grey btn-sm" aria-label="Left Align">
                                    <span class="fa fa-star" aria-hidden="true"></span>
                                </button>--%>
                            </div>
                            <div class="col-sm-5">
                                <h4>Rating breakdown</h4>
                                <div class="pull-left">
                                    <div class="pull-left" style="width: 35px; line-height: 1;">
                                        <div style="height: 9px; margin: 5px 0;">5 <span class="fa fa-star"></span></div>
                                    </div>
                                    <div class="pull-left" style="width: 180px;">
                                        <div class="progress" style="height: 9px; margin: 8px 0;">
                                            <div class="progress-bar progress-bar-striped progress-bar-success" role="progressbar" aria-valuenow="5" aria-valuemin="0" aria-valuemax="5" style="width: 1000%">
                                                <span class="sr-only">80% Complete (danger)</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="pull-right" style="margin-left: 10px;">
                                        <asp:Label ID="star55" runat="server"></asp:Label>
                                    </div>
                                </div>
                                <div class="pull-left">
                                    <div class="pull-left" style="width: 35px; line-height: 1;">
                                        <div style="height: 9px; margin: 5px 0;">4 <span class="fa fa-star"></span></div>
                                    </div>
                                    <div class="pull-left" style="width: 180px;">
                                        <div class="progress" style="height: 9px; margin: 8px 0;">
                                            <div class="progress-bar bg-success progress-bar-striped progress-bar-primary" role="progressbar" aria-valuenow="4" aria-valuemin="0" aria-valuemax="5" style="width: 80%">
                                                <span class="sr-only">80% Complete (danger)</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="pull-right" style="margin-left: 10px;">
                                        <asp:Label ID="star44" runat="server"></asp:Label>
                                    </div>
                                </div>
                                <div class="pull-left">
                                    <div class="pull-left" style="width: 35px; line-height: 1;">
                                        <div style="height: 9px; margin: 5px 0;">3 <span class="fa fa-star"></span></div>
                                    </div>
                                    <div class="pull-left" style="width: 180px;">
                                        <div class="progress" style="height: 9px; margin: 8px 0;">
                                            <div class="progress-bar bg-info progress-bar-striped" role="progressbar" aria-valuenow="3" aria-valuemin="0" aria-valuemax="5" style="width: 60%">
                                                <span class="sr-only">80% Complete (danger)</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="pull-right" style="margin-left: 10px;">
                                        <asp:Label ID="star33" runat="server"></asp:Label>
                                    </div>
                                </div>
                                <div class="pull-left">
                                    <div class="pull-left" style="width: 35px; line-height: 1;">
                                        <div style="height: 9px; margin: 5px 0;">2 <span class="fa fa-star"></span></div>
                                    </div>
                                    <div class="pull-left" style="width: 180px;">
                                        <div class="progress" style="height: 9px; margin: 8px 0;">
                                            <div class="progress-bar bg-warning progress-bar-striped" role="progressbar" aria-valuenow="2" aria-valuemin="0" aria-valuemax="5" style="width: 40%">
                                                <span class="sr-only">80% Complete (danger)</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="pull-right" style="margin-left: 10px;">
                                        <asp:Label ID="star22" runat="server"></asp:Label>
                                    </div>
                                </div>
                                <div class="pull-left">
                                    <div class="pull-left" style="width: 35px; line-height: 1;">
                                        <div style="height: 9px; margin: 5px 0;">1 <span class="fa fa-star"></span></div>
                                    </div>
                                    <div class="pull-left" style="width: 180px;">
                                        <div class="progress" style="height: 9px; margin: 8px 0;">
                                            <div class="progress-bar bg-danger progress-bar-striped" role="progressbar" aria-valuenow="1" aria-valuemin="0" aria-valuemax="5" style="width: 20%">
                                                <span class="sr-only">80% Complete (danger)</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="pull-right" style="margin-left: 10px;">
                                        <asp:Label ID="star11" runat="server"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <asp:Repeater ID="RepFeedback" runat="server">
                                <HeaderTemplate>
                                    <table class="table table-striped table-responsive-sm">
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <tr>
                                        <td>
                                            <asp:Image ID="phImage" runat="server" ImageUrl='<%# Eval("UserPicture") %>' CssClass="img-rounded" Width="50px" />
                                            <div class="review-block-name">
                                                <a href="#">
                                                    <asp:Label ID="lblUserFeedback" runat="server" Text='<%# Eval("Username") %>'></asp:Label></a>
                                            </div>
                                            <div class="review-block-date">
                                                <asp:Label ID="lblFeedbackDate" runat="server" Text='<%# ProcessDay(Eval("date"))  %>'></asp:Label><br />
                                            </div>
                                        </td>
                                        <td class="col-sm-9">
                                            <div class="review-block-rate">
                                                <asp:LinkButton ID="star1" runat="server" CssClass='<%# ((Convert.ToInt32(Eval("Score")) == 1 ||  Convert.ToInt32(Eval("Score")) == 2  ||  Convert.ToInt32(Eval("Score")) == 3  ||  Convert.ToInt32(Eval("Score")) == 4  ||  Convert.ToInt32(Eval("Score")) == 5 ) ? "btn btn-warning btn-xs" : "btn btn-default btn-grey btn-xs") %>' aria-label="Left Align"><span class="fa fa-star" aria-hidden="true"></span></asp:LinkButton>
                                                <asp:LinkButton ID="star2" runat="server" CssClass='<%# (( Convert.ToInt32(Eval("Score")) == 2  ||  Convert.ToInt32(Eval("Score")) == 3  ||  Convert.ToInt32(Eval("Score")) == 4  ||  Convert.ToInt32(Eval("Score")) == 5 ) ? "btn btn-warning btn-xs" : "btn btn-default btn-grey btn-xs") %>' aria-label="Left Align"><span class="fa fa-star" aria-hidden="true"></span></asp:LinkButton>
                                                <asp:LinkButton ID="star3" runat="server" CssClass='<%# ((Convert.ToInt32(Eval("Score")) == 3  ||  Convert.ToInt32(Eval("Score")) == 4  ||  Convert.ToInt32(Eval("Score")) == 5 ) ? "btn btn-warning btn-xs" : "btn btn-default btn-grey btn-xs") %>' aria-label="Left Align"><span class="fa fa-star" aria-hidden="true"></span></asp:LinkButton>
                                                <asp:LinkButton ID="star4" runat="server" CssClass='<%# ((Convert.ToInt32(Eval("Score")) == 4  ||  Convert.ToInt32(Eval("Score")) == 5 ) ? "btn btn-warning btn-xs" : "btn btn-grey btn-xs") %>' aria-label="Left Align"><span class="fa fa-star" aria-hidden="true"></span></asp:LinkButton>
                                                <asp:LinkButton ID="star5" runat="server" CssClass='<%# ((Convert.ToInt32(Eval("Score")) == 5 ) ? "btn btn-warning btn-xs" : "btn btn-default btn-grey btn-xs") %>' aria-label="Left Align"><span class="fa fa-star" aria-hidden="true"></span></asp:LinkButton>
                                                <%--   <asp:LinkButton ID="wtf" runat="server" CssClass="btn btn-default btn-grey btn-xs"><span class="fa fa-star" aria-hidden="true"></span></asp:LinkButton>
                                            <button type="button" class="btn btn-warning btn-xs" aria-label="Left Align">
                                                <span class="fa fa-star" aria-hidden="true"></span>
                                            </button>
                                            <button type="button" class="btn btn-warning btn-xs" aria-label="Left Align">
                                                <span class="fa fa-star" aria-hidden="true"></span>
                                            </button>
                                            <button type="button" class="btn btn-warning btn-xs" aria-label="Left Align">
                                                <span class="fa fa-star" aria-hidden="true"></span>
                                            </button>
                                            <button type="button" class="btn btn-default btn-grey btn-xs" aria-label="Left Align">
                                                <span class="fa fa-star" aria-hidden="true"></span>
                                            </button>
                                            <button type="button" class="btn btn-grey btn-xs" aria-label="Left Align">
                                                <span class="fa fa-star" aria-hidden="true"></span>
                                            </button>--%>
                                            </div>
                                            <div class="review-block-title">
                                                <br />
                                            </div>
                                            <div class="review-block-description">
                                                <asp:Label ID="lblFeedback" runat="server" Text='<%# Eval("FeedbackText") %>'></asp:Label>
                                            </div>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                                <FooterTemplate>
                                    </table>
                                </FooterTemplate>
                            </asp:Repeater>
                        </div>
                    </div>
                    <!-- /container -->
                </nav>
            </div>
        </div>
    </div>
</asp:Content>
