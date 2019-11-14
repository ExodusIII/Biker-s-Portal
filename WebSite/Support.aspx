<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true" CodeFile="Support.aspx.cs" Inherits="Support" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container">
        <br />
        <br />

        <!-- İstek Gönder Başlık -->
        <div class="form-group">
            <div class="col-md-8">
                <h2 class="border border-dark font text-center">İstek Gönder</h2>
            </div>
        </div>

        <asp:literal id="errorbox" runat="server"></asp:literal>
        <br />

        <!-- Kategori -->
        <div class="form-group">
            <div class="col-md-8">
                <span class="font-italic font-weight-light">İlk önce kategori seçerek başlayın</span>
                <asp:DropDownList ID="kategori" runat="server" CssClass="form-control">
                    <asp:ListItem Value="0" Text="Güvenlik"></asp:ListItem>
                    <asp:ListItem Value="1" Text="Site bug"></asp:ListItem>
                    <asp:ListItem Value="2" Text="Diğer"></asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>

        <!-- Email -->
        <div class="form-group">
            <label class="col-md-4 control-label" for="textinput">Email Adresi*</label>
            <div class="col-md-8">
                <asp:TextBox ID="email" runat="server" CssClass="form-control input-md"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="email" ErrorMessage="Gerekli" ForeColor="Red" ValidationGroup="RequestVali"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator runat="server" ControlToValidate="email" Display="Dynamic" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ErrorMessage="Geçersiz Karakter" ForeColor="Red" ValidationGroup="RequestVali"></asp:RegularExpressionValidator>
            </div>
        </div>

        <!-- Konu -->
        <div class="form-group">
            <label class="col-md-4 control-label" for="textinput">Konu*</label>
            <div class="col-md-8">
                <asp:TextBox ID="konu" runat="server" CssClass="form-control input-md"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="konu" ErrorMessage="Gerekli" ForeColor="Red" ValidationGroup="RequestVali"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator runat="server" ControlToValidate="konu" Display="Dynamic" ValidationExpression="^[a-zA-ZşŞçÇğĞİöÖüÜı''-'\s]{1,75}$" ErrorMessage="Geçersiz Karakter" ForeColor="Red" ValidationGroup="RequestVali"></asp:RegularExpressionValidator>
            </div>
        </div>
        <!-- Açıklama -->
        <div class="form-group">
            <label class="col-md-4 control-label" for="textarea">Açıklama*</label>
            <div class="col-md-8">
                <asp:TextBox ID="aciklama" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="aciklama" ErrorMessage="Gerekli" ForeColor="Red" ValidationGroup="RequestVali"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator runat="server" ControlToValidate="aciklama" Display="Dynamic" ValidationExpression="^[a-zA-Z0-9şŞçÇğĞİöÖüÜı''-'\s]{1,250}$" ErrorMessage="Geçersiz Karakter" ForeColor="Red" ValidationGroup="RequestVali"></asp:RegularExpressionValidator>
            </div>
        </div>

        <div class="form-group">
            <div class="g-recaptcha" data-sitekey="6LdlNFYUAAAAAC6y82HNClpTnlWk9jbA8E38a1vH"></div>
        </div>

        <!-- Send Ticket -->
        <div class="form-group">
            <div class="col-md-4">
                <asp:Button ID="sendticket" runat="server" Text="Gönder" CssClass="btn btn-dark" OnClick="send_ticket" ValidationGroup="RequestVali" />
            </div>
        </div>
        <!-- Form-End -->
    </div>

</asp:Content>

