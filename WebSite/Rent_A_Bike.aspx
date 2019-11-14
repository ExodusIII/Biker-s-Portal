<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true" CodeFile="Rent_A_Bike.aspx.cs" Inherits="Rent_A_Bike" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="container">
        <br />
        <br />

        <!-- İlan Ver Başlık -->
        <div class="form-group">
            <div class="col-md-8">
                <h2 class="border border-dark font text-center">İlan Ver</h2>
            </div>
        </div>

        <asp:Literal ID="errorbox" runat="server"></asp:Literal><br />

        <!-- İlan Başlığı -->
        <div class="form-group">
            <label class="col-md-4 control-label " for="İlan Başlığı">İlan Başlığı</label>
            <div class="col-md-8">
                <asp:TextBox ID="ilan_baslik" runat="server" CssClass="form-control input-md"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="ilan_baslik" ErrorMessage="Gerekli" ForeColor="Red" ValidationGroup="RequestVali"></asp:RequiredFieldValidator>
<%--                <asp:RegularExpressionValidator runat="server" ControlToValidate="ilan_baslik" Display="Dynamic" ValidationExpression="^[a-zA-ZşŞçÇğĞİöÖüÜı''-'\s]{1,150}$" ErrorMessage="*Sadece harfler" ForeColor="Red" ValidationGroup="RequestVali"></asp:RegularExpressionValidator>--%>
            </div>
        </div>

        <!-- İlan Açıklaması -->
        <div class="form-group">
            <label class="col-md-4 control-label" for="">İlan Açıklaması</label>
            <div class="col-md-8">
                <asp:TextBox ID="ilan_aciklama" runat="server" CssClass="form-control input-md" TextMode="MultiLine"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="ilan_aciklama" ErrorMessage="Gerekli" ForeColor="Red" ValidationGroup="RequestVali"></asp:RequiredFieldValidator>
<%--                <asp:RegularExpressionValidator runat="server" ControlToValidate="ilan_aciklama" Display="Dynamic" ValidationExpression="^[a-zA-Z0-9şŞçÇğĞİöÖüÜı''-'\s]{1,250}$" ErrorMessage="*Sadece harfler ve sayılar" ForeColor="Red" ValidationGroup="RequestVali"></asp:RegularExpressionValidator>--%>
            </div>
        </div>

        <!-- Marka -->
        <div class="form-group">
            <label class="col-md-4 control-label" for="textinput">Marka</label>
            <div class="col-md-8">
                <asp:TextBox ID="marka" runat="server" CssClass="form-control input-md"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="marka" ErrorMessage="Gerekli" ForeColor="Red" ValidationGroup="RequestVali"></asp:RequiredFieldValidator>
<%--                <asp:RegularExpressionValidator runat="server" ControlToValidate="ilan_baslik" Display="Dynamic" ValidationExpression="^[a-zA-ZşŞçÇğĞİöÖüÜı''-'\s]{1,150}$" ErrorMessage="*Sadece harfler" ForeColor="Red" ValidationGroup="RequestVali"></asp:RegularExpressionValidator>--%>
            </div>
        </div>

        <!-- Bisiklet Türü -->
        <div class="form-group">
            <label class="col-md-4 control-label" for="Türü">Bisiklet Türü</label>
            <div class="col-md-8">
                <asp:DropDownList ID="tur" runat="server" CssClass="form-control" OnSelectedIndexChanged="tur_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
            </div>
        </div>

        <!-- Vites -->
        <div class="form-group">
            <label class="col-md-4 control-label" for="Vites">Vites</label>
            <div class="col-md-8">
                <asp:DropDownList ID="vites" runat="server" CssClass="form-control"></asp:DropDownList>
            </div>
        </div>

        <!-- İl -->
        <div class="form-group">
            <label class="col-md-4 control-label" for="">İl</label>
            <div class="col-md-8">
                <asp:DropDownList ID="ilBike" runat="server" OnSelectedIndexChanged="ilBike_SelectedIndexChanged" AutoPostBack="true" CssClass="form-control input-md"></asp:DropDownList>
            </div>
        </div>

        <!-- İlçe -->
        <div class="form-group">
            <label class="col-md-4 control-label" for="">İlçe</label>
            <div class="col-md-8">
                <asp:DropDownList ID="ilceBike" runat="server" CssClass="form-control input-md"></asp:DropDownList>
            </div>
        </div>

        <!-- Haftalık Ücret -->
        <div class="form-group">
            <label class="col-md-4 control-label" for="Haftalık Ücret">Haftalık Ücret</label>
            <div class="col-md-8">
                <div class="input-group">
                    <asp:TextBox ID="ucret" runat="server" CssClass="form-control input-md"></asp:TextBox>
                    <div class="input-group-btn">
                        <asp:DropDownList ID="parabirim" runat="server" class="form-control">
                            <asp:ListItem Value="0" Text="₺"></asp:ListItem>
                            <asp:ListItem Value="1" Text="$"></asp:ListItem>
                            <asp:ListItem Value="2" Text="€"></asp:ListItem>
                            <asp:ListItem Value="3" Text="£"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="ucret" ErrorMessage="Gerekli" ForeColor="Red" ValidationGroup="RequestVali"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator runat="server" ControlToValidate="ucret" Display="Dynamic" ValidationExpression="^\d*\.?\d*$" ErrorMessage="*Sadece sayılar" ForeColor="Red" ValidationGroup="RequestVali"></asp:RegularExpressionValidator>
            </div>
        </div>

        <!-- Resim Yükle -->
        <div class="form-group">
            <label class="col-md-4 control-label" for="filebutton">Resim Ekle</label>
            <div class="col-md-8">
                <asp:FileUpload ID="resim_yukle" runat="server" CssClass="form-control input-file" AllowMultiple="False" />
            </div>
        </div>

        <!-- Şartlar ve Koşullar -->
        <div class="form-group">
            <div class="col-md-8">
                <button type="button" class="form-control" data-toggle="modal" data-target="#terms">Şartlar ve koşullar</button>
                <asp:CheckBox ID="sozlesme" runat="server" Text="" CssClass="form-control" />
            </div>
        </div>
        <div class="modal fade" id="terms" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLongTitle">Şart ve Kullanım Koşulları</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p class="font-weight-bold">
                            Lütfen bu İnternet Sitesini kullanmadan önce aşağıdaki Kullanım Şartlarını ve Yasal Uyarıları Dikkatle Okuyun
                        </p>
                        <p>
                            Şartların Kabul Edilmesi
                            merhaba
                        </p>
                             
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="form-group">
            <div class="g-recaptcha" data-sitekey="6LdlNFYUAAAAAC6y82HNClpTnlWk9jbA8E38a1vH"></div>
        </div>

        <!-- İlan ver -->
        <div class="form-group">
            <div class="col-md-4">
                <asp:Button runat="server" ID="ilan_ver" Text="İlan Ver" CssClass="btn btn-dark" OnClick="ilan_ver_Click" ValidationGroup="RequestVali"></asp:Button>
            </div>
        </div>
    </div>

</asp:Content>

