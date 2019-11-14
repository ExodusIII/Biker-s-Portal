<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true" CodeFile="SignUp.aspx.cs" Inherits="SignUp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="container">

        <br />
        <br />
        <!-- Kayıt Ol Başlık -->
        <div class="form-group">
            <div class="col-md-8">
                <h2 class="border border-dark font text-center">Kayıt Ol</h2>
            </div>
        </div>

        <asp:Literal ID="errorbox" runat="server"></asp:Literal><br />

        <!-- Kullanıcı Adı -->
        <div class="form-group">
            <label class="col-md-4 control-label" for="">Kullanıcı Adı</label>
            <div class="col-md-8">
                <asp:textbox id="kullanici_adi" runat="server" cssclass="form-control input-md"></asp:textbox>
                <asp:requiredfieldvalidator runat="server" controltovalidate="kullanici_adi" errormessage="Gerekli" forecolor="Red" validationgroup="RequestVali"></asp:requiredfieldvalidator>
                <asp:regularexpressionvalidator runat="server" controltovalidate="kullanici_adi" display="Dynamic" validationexpression="^[a-zA-Z0-9_\s]{1,100}$" errormessage="*Sadece harfler ve sayılar" forecolor="Red" validationgroup="RequestVali"></asp:regularexpressionvalidator>
            </div>
        </div>

        <!-- Parola -->
        <div class="form-group">
            <label class="col-md-4 control-label" for="">Parola</label>
            <div class="col-md-8">
                <asp:textbox id="parola" runat="server" cssclass="form-control input-md" textmode="Password"></asp:textbox>
                <asp:requiredfieldvalidator runat="server" controltovalidate="parola" errormessage="Gerekli" forecolor="Red" validationgroup="RequestVali"></asp:requiredfieldvalidator>
                <asp:regularexpressionvalidator runat="server" controltovalidate="parola" display="Dynamic" validationexpression="^(?=.*[A-Za-zşŞçÇğĞİöÖüÜı])(?=.*\d)[A-Za-zşŞçÇğĞİöÖüÜı\d]{6,16}$" errormessage="*En 1 harf,sayı(6-16)" forecolor="Red" validationgroup="RequestVali"></asp:regularexpressionvalidator>
             </div>
        </div>

        <!-- Paralo Tekrar -->
        <div class="form-group">
            <label class="col-md-4 control-label" for="">Paralo Tekrar</label>
            <div class="col-md-8">
                <asp:textbox id="parola_tekrar" runat="server" cssclass="form-control input-md" textmode="Password"></asp:textbox>
                <asp:requiredfieldvalidator runat="server" controltovalidate="parola_tekrar" errormessage="Gerekli" forecolor="Red" validationgroup="RequestVali"></asp:requiredfieldvalidator>
                <asp:regularexpressionvalidator runat="server" controltovalidate="parola_tekrar" display="Dynamic" validationexpression="^(?=.*[A-Za-zşŞçÇğĞİöÖüÜı])(?=.*\d)[A-Za-zşŞçÇğĞİöÖüÜı\d]{6,16}$" errormessage="*En 1 harf,sayı(6-16)" forecolor="Red" validationgroup="RequestVali"></asp:regularexpressionvalidator>
                <asp:CompareValidator runat="server" ControlToCompare="parola" ControlToValidate="parola_tekrar" ErrorMessage="Parola eşleşmiyor" ForeColor="Red" validationgroup="RequestVali"/>
            </div>
        </div>

        <!-- İsim -->
        <div class="form-group">
            <label class="col-md-4 control-label" for="">İsim</label>
            <div class="col-md-8">
                <asp:textbox id="isim" runat="server" cssclass="form-control input-md"></asp:textbox>
                <asp:requiredfieldvalidator runat="server" controltovalidate="isim" errormessage="Gerekli" forecolor="Red" validationgroup="RequestVali"></asp:requiredfieldvalidator>
                <asp:regularexpressionvalidator runat="server" controltovalidate="isim" display="Dynamic" validationexpression="^[a-zA-ZşŞçÇğĞİöÖüÜı''-'\s]{1,150}$" errormessage="*Sadece harfler" forecolor="Red" validationgroup="RequestVali"></asp:regularexpressionvalidator>
            </div>
        </div>

        <!-- Soyisim -->
        <div class="form-group">
            <label class="col-md-4 control-label" for="">Soyisim</label>
            <div class="col-md-8">
                <asp:textbox id="soyisim" runat="server" cssclass="form-control input-md"></asp:textbox>
                <asp:requiredfieldvalidator runat="server" controltovalidate="soyisim" errormessage="Gerekli" forecolor="Red" validationgroup="RequestVali"></asp:requiredfieldvalidator>
                <asp:regularexpressionvalidator runat="server" controltovalidate="soyisim" display="Dynamic" validationexpression="^[a-zA-ZşŞçÇğĞİöÖüÜı''-'\s]{1,100}$" errormessage="*Sadece harfler" forecolor="Red" validationgroup="RequestVali"></asp:regularexpressionvalidator>
            </div>
        </div>

        <!-- Doğum Tarihi -->
        <div class="form-group">
            <label class="col-md-4 control-label" for="">
                Doğum Tarihi<br />
                (yyyy-aa-gg)</label>
            <div class="col-md-8">
                <asp:textbox id="dogum_tarihi" runat="server" cssclass="form-control input-md" textmode="Date"></asp:textbox>
            </div>
        </div>

        <!-- T.C. Kimlik No -->
        <div class="form-group">
            <label class="col-md-4 control-label" for="">T.C. Kimlik No</label>
            <div class="col-md-8">
                <asp:textbox id="tcno" runat="server" cssclass="form-control input-md" textmode="SingleLine" placeholder="Tercihe Bağlı"></asp:textbox>
                <asp:regularexpressionvalidator runat="server" controltovalidate="tcno" display="Dynamic" validationexpression="^\d{11}$" errormessage="*11 sayı olmalı" forecolor="Red" validationgroup="RequestVali"></asp:regularexpressionvalidator>
            </div>
        </div>

        <!-- IBAN -->
        <div class="form-group">
            <label class="col-md-4 control-label" for="">IBAN</label>
            <div class="col-md-8">
                <asp:textbox id="IBAN" runat="server" cssclass="form-control input-md" placeholder="Tercihe Bağlı"></asp:textbox>
                <asp:regularexpressionvalidator runat="server" controltovalidate="IBAN" display="Dynamic" validationexpression="^[a-zA-Z0-9]{32}$" errormessage="" forecolor="Red" validationgroup="RequestVali"></asp:regularexpressionvalidator>
            </div>
        </div>

        <!-- Email -->
        <div class="form-group">
            <label class="col-md-4 control-label" for="">Email</label>
            <div class="col-md-8">
                <asp:textbox id="email" runat="server" cssclass="form-control input-md"></asp:textbox>
                <asp:requiredfieldvalidator runat="server" controltovalidate="email" errormessage="Gerekli" forecolor="Red" validationgroup="RequestVali"></asp:requiredfieldvalidator>
                <asp:regularexpressionvalidator runat="server" controltovalidate="email" display="Dynamic" validationexpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" errormessage="Geçersiz Karakter" forecolor="Red" validationgroup="RequestVali"></asp:regularexpressionvalidator>
            </div>
        </div>

        <!-- Cep Telefonu -->
        <div class="form-group">
            <label class="col-md-4 control-label" for="">Cep Telefonu</label>
            <div class="col-md-8">
                <asp:textbox id="ceptelno" runat="server" cssclass="form-control input-md" textmode="Phone" placeholder="05xxxxxxxxx"></asp:textbox>
                <asp:requiredfieldvalidator runat="server" controltovalidate="ceptelno" errormessage="Gerekli" forecolor="Red" validationgroup="RequestVali"></asp:requiredfieldvalidator>
                <asp:regularexpressionvalidator runat="server" controltovalidate="ceptelno" display="Dynamic" validationexpression="^[01]?[- .]?(\([2-9]\d{2}\)|[2-9]\d{2})[- .]?\d{3}[- .]?\d{4}$" errormessage="Doğru giriniz" forecolor="Red" validationgroup="RequestVali"></asp:regularexpressionvalidator>
            </div>
        </div>

        <!-- Adres -->
        <div class="form-group">
            <label class="col-md-4 control-label" for="">Adres</label>
            <div class="col-md-8">
                <asp:textbox id="adres" runat="server" cssclass="form-control input-md" textmode="MultiLine" MaxLength="250" Rows="10"></asp:textbox>
                <asp:requiredfieldvalidator runat="server" controltovalidate="adres" errormessage="Gerekli" forecolor="Red" validationgroup="RequestVali"></asp:requiredfieldvalidator>
<%--                <asp:regularexpressionvalidator runat="server" controltovalidate="adres" display="Dynamic" validationexpression="^[a-zA-Z0-9şŞçÇğĞİöÖüÜı''-'\s]{1,250}$" errormessage="*Sadece harfler ve sayılar" forecolor="Red" validationgroup="RequestVali"></asp:regularexpressionvalidator>--%>
            </div>
        </div>

        <!-- Tür -->
        <div class="form-group">
            <label class="col-md-4 control-label" for="">Tür</label>
            <div class="col-md-8">
                <asp:dropdownlist id="tur" runat="server" cssclass="form-control">
                    <asp:ListItem Value="0" Text="Bireysel"></asp:ListItem>
                    <asp:ListItem Value="1" Text="Kurumsal"></asp:ListItem>
                </asp:dropdownlist>
            </div>
        </div>

        <!-- Kullanıcı Sözleşmesi -->
        <div class="form-group">
            <div class="col-md-8">
                <div class="checkbox">
                    <label for="-0">
                        <asp:CheckBox ID="sozlesme" runat="server" Text=" Kullanıcı Sözleşmesi" />
                    </label>
                </div>
            </div>
        </div>

        <div class="form-group">
            <div class="g-recaptcha" data-sitekey="6LdlNFYUAAAAAC6y82HNClpTnlWk9jbA8E38a1vH"></div>
        </div>

        <!-- Kayıt Ol Buton -->
        <div class="form-group">
            <div class="col-md-4">
                <asp:button id="SignIn" runat="server" cssclass="btn btn-dark" text="Kayıt Ol" onclick="SignIn_Click" validationgroup="RequestVali" />
            </div>
        </div>
        <!-- Form-End -->
    </div>

</asp:Content>

