<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true" CodeFile="Biker.aspx.cs" Inherits="Biker" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container">
        <div class="row">
            <h1 class="my-4">Hoşgeldiniz</h1>

            <!-- Blog Post -->

            <asp:Repeater ID="RepBikes" runat="server" OnItemCommand="RepBikes_ItemCommand">
                <HeaderTemplate>
                    <table class="table table-responsive">
                        <tr>
                            <th scope="col"></th>
                            <th scope="col">Açıklama</th>
                            <th scope="col">Haftalık Ücret</th>
                            <th scope="col">Ekleme Tarihi</th>
                            <th scope="col">Konum</th>
                        </tr>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td>
                            <asp:ImageButton ID="phImage" runat="server" ImageUrl='<%# Eval("Picture") %>' CommandName="ImageClick" CommandArgument='<%# Eval("OwnerID")+","+ Eval("BikeID") %>' Width="65" />
                        </td>
                        <td style="width:100px;">
                            <strong><%# Eval("AdsHeader")%></strong><br />
                            <%# Eval("Description")%>
                        </td>
                        <td>
                            <%# Eval("Price")%><a> </a><%# changeCurrency(Eval("Currency"))%>
                        </td>
                        <td>
                            <%# makeShortDate(Eval("AddingDate")) %>
                        </td>
                        <td>
                            <%# changeLocation(Eval("BikeCity"), Eval("BikeCounty")) %>
                        </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </table> 
                </FooterTemplate>
            </asp:Repeater>

            <!-- Pagination -->
            <%--        <ul class="pagination justify-content-center mb-4">
            <li class="page-item">
                <a class="page-link" href="#"></a>
            </li>

            <li class="page-item disabled">
                <a class="page-link" href="#">Newer &rarr;</a>
            </li>
        </ul>--%>
        </div>
    </div>

</asp:Content>

