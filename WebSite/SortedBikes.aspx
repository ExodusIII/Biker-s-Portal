<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true" CodeFile="SortedBikes.aspx.cs" Inherits="SortedBikes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container">

        <nav class="navbar navbar-light bg-light">
            <div class="form-group">
                <asp:Label ID="Label3" runat="server" Text="İl-İlçe" CssClass="col-form-label"></asp:Label>
                <asp:DropDownList ID="ilBike" runat="server" OnSelectedIndexChanged="ilBike_SelectedIndexChanged" AutoPostBack="true" CssClass="form-control"></asp:DropDownList>
                <asp:DropDownList ID="ilceBike" runat="server" CssClass="form-control"></asp:DropDownList>
            </div>
            <div class="form-group">
                <asp:Label ID="Label2" runat="server" Text="Vites" CssClass="col-form-label"></asp:Label>
                <asp:DropDownList ID="vites" runat="server" CssClass="form-control"></asp:DropDownList>
            </div>
            <div class="form-group">
                <asp:Label ID="Label1" runat="server" Text="Min" CssClass="col-form-label"></asp:Label>
                <asp:TextBox ID="minPrice" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RegularExpressionValidator runat="server" ControlToValidate="minPrice" Display="Dynamic" ValidationExpression="^\d*\.?\d*$" ErrorMessage="*Sadece sayılar" ForeColor="Red" ValidationGroup="RequestVali"></asp:RegularExpressionValidator>
            </div>

            <div class="form-group">
                <asp:Label ID="maxPriceLabel" runat="server" Text="Max" CssClass="col-form-label"></asp:Label>
                <asp:TextBox ID="maxPrice" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RegularExpressionValidator runat="server" ControlToValidate="maxPrice" Display="Dynamic" ValidationExpression="^\d*\.?\d*$" ErrorMessage="*Sadece sayılar" ForeColor="Red" ValidationGroup="RequestVali"></asp:RegularExpressionValidator>

            </div>
            <div class="form-group">
                <asp:Button ID="sortBikes" runat="server" CssClass="form-control btn-warning" Text="Getir" OnClick="sortBikes_Click" />
            </div>
        </nav>


        <asp:Repeater ID="RepBikes" runat="server" OnItemCommand="RepBikes_ItemCommand">
            <HeaderTemplate>
                <table class="table table-responsive table-responsive-sm">
                    <thead>
                        <tr>
                            <th scope="col"></th>
                            <th scope="col">Açıklama</th>
                            <th scope="col">Haftalık Ücret</th>
                            <th scope="col">Ekleme Tarihi</th>
                            <th scope="col">Konum</th>
                        </tr>
                    </thead>
                    <tbody>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td>
                        <asp:ImageButton ID="phImage" runat="server" ImageUrl='<%# Eval("Picture") %>' CommandName="ImageClick" CommandArgument='<%# Eval("OwnerID")+","+ Eval("BikeID") %>' Width="65" />
                    </td>
                    <td>
                        <strong><%# Eval("AdsHeader")%></strong><br />
                        <%# Eval("Description")%>
                    </td>
                    <td>
                        <%# Eval("Price")%><a> </a><%# changeCurrency(Eval("Currency"))%>
                    </td>
                    <td>
                        <%# makeShortDate(Eval("AddingDate"))%>
                    </td>
                    <td>
                        <%# changeLocation(Eval("BikeCity"), Eval("BikeCounty"))%>
                    </td>
            </ItemTemplate>
            <FooterTemplate>
                </tbody>
        </table>
           
            </FooterTemplate>
        </asp:Repeater>

    </div>
</asp:Content>

