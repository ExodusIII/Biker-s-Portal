<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true" CodeFile="Profil.aspx.cs" Inherits="Profil" EnableViewState="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script>
        // show the given page, hide the rest
        function show(elementID) {
            // try to find the requested page and alert if it's not found
            var ele = document.getElementById(elementID);
            if (!ele) {
                alert("no such element");
                return;
            }

            // get all pages, loop through them and hide them
            var pages = document.getElementsByClassName('container1');
            for (var i = 0; i < pages.length; i++) {
                if (pages[i])
                    pages[i].style.display = 'none';
            }

            // then show the requested page
            ele.style.display = 'block';
            return false;
        }
    </script>

    <script>
        $(document).ready(function () {
            //$('.nav-tabs a:first').tab('show');
            $(".nav-tabs a").click(function () {
                $(this).tab('show');
                $(this).tab('active');
            });


            //$("#sidebarr").remove();//does not work!!!


            $(".listgroup button").on("click", function () {
                $(".listgroup button").removeClass("active");
                $(this).addClass("active");
            });
        });
    </script>

    <script type="text/javascript">
        function openModal() {
            $('#myModal1').modal('show');
        }
    </script>

    <script type="text/javascript">
        function openModal2() {
            $('#myModal2').modal('show');
        }
    </script>
    <script type="text/javascript">
        function openModal3() {
            $('#myModal3').modal('show');
        }
    </script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container">
        <div class="row">

            <!-- ilanlar -->
            <div class="container1" id="ilanlar">
                <br />
                <br />
                <asp:Label ID="zeroIlan" runat="server" Visible="false" Text="Henuz bir ilaniniz bulunmamaktadir.Eski veya kullanmadiginiz bisikletleri degerlendirmek istermisiniz ?" Font-Size="X-Large" Font-Bold="true"></asp:Label>
                <asp:Repeater ID="RepIlan" runat="server" OnItemCommand="RepIlan_ItemCommand">
                    <HeaderTemplate>
                        <table class="table table-responsive table-responsive-sm">
                            <thead>
                                <tr>
                                    <th></th>
                                    <th>Açıklama</th>
                                    <th>Ücret</th>
                                    <th>Adding Date</th>
                                    <th>Location</th>
                                    <th>Duzenle</th>
                                </tr>
                            </thead>
                            <tbody>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td>
                                <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl='<%# Eval("Picture") %>' CommandName="ImageClick" CommandArgument='<%# Eval("OwnerID")+","+ Eval("BikeID") %>' Width="140" />
                               <%-- <asp:ImageButton ID="phImage" runat="server" ImageUrl='<%# Eval("Picture") %>' CommandName="ImageClick" CommandArgument='<%# Eval("BikeID") %>' Width="140" />--%>
                                <%--OnCommand="Image_Click" --%> <%--CommandName="CheckinClick" CommandArgument='<%# Eval("BikeID") %>'--%>
                            </td>
                            <td>
                                <%# Eval("Description")%>
                                <br />

                                <br />
                                <%-- <%# Eval("Availability")%>--%>
                                
                            </td>
                            <td><%# Eval("Price")%> <%# changeCurrency(Eval("Currency")) %> <a>/hafta</a></td>

                            <td>
                                <%# makeShortDate(Eval("AddingDate")) %> <%--<br /> <%# ProcessMyDataItem(Eval("RenterCheckIn")).ToString()%><br /><%# ProcessMyDataItem(Eval("HirerCheckIn")).ToString()%>--%>
                                <%--<i class="material-icons">remove_red_eye</i>
                                <span>Goruntulenme </span><span class="badge" style="margin-left:6px;font-size:13px;">32</span>
                                <br />
                                <i class="material-icons">stars</i>         goodbye i loved ur idea
                                <span>Favoriler</span><span class="badge" style="margin-left:6px;font-size:13px;">2</span>--%>
                                <td><%# changeLocation(Eval("BikeCity"), Eval("BikeCounty")) %></td>
                            </td>
                            <td>
                                <asp:Button ID="btn1" runat="server" CssClass="btn btn-warning btn-md" CommandName="CheckinnClick" Text="Check-in" CommandArgument='<%# Eval("BikeID") %>' Visible='<%# Convert.ToBoolean(ProcessMyDataItem(Eval("RenterCheckIn")).ToString() == "0" ? "true": "false") %>' />
                                <asp:LinkButton ID="lbTheEnd" runat="server" CssClass="btn btn-warning btn-md" Text="Check-in Out" CommandName="TheEndClick" CommandArgument='<%# Eval("BikeID") %>' OnClick="btnTheEnd_Click" Visible='<%# Convert.ToBoolean(ProcessMyDataItem(Eval("RenterCheckIn")).ToString() == "1" && ProcessMyDataItem(Eval("HirerCheckIn")).ToString() == "0" ? "true": "false") %>'></asp:LinkButton>
                                <br />
                                <span class="btn btn-danger" style="margin-top: 10px; width: 100%;">Kaldir</span>
                            </td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </tbody>

                </table>
                    </FooterTemplate>
                </asp:Repeater>

                <%-- Checkin pop-up--%>
                <div id="myModal1" class="modal fade" role="dialog">
                    <div class="modal-dialog">

                        <!-- Modal content-->
                        <div class="modal-content">
                            <div class="modal-header">
                                <h3>Check-in Baslat</h3>
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                            </div>
                            <div class="modal-body">


                                <!-- Password input-->
                                <div class="form-group">
                                    <asp:Label runat="server" AssociatedControlID="txtTarget" CssClass="col-md-4 control-label">Kullanici adi</asp:Label>
                                    <%--<label class="col-md-4 control-label" for="messageinput">Kullanici Adi</label>--%>
                                    <div class="col-md-8">
                                        <asp:TextBox ID="txtTarget" runat="server" CssClass="form-control"></asp:TextBox>

                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-md-8">
                                        <asp:Button ID="btnCheck" runat="server" CssClass="btn btn-warning" OnClick="Checkin_Click" Text="Gonder" />
                                        <%--<button id="singlebutton" name="singlebutton" class="btn btn-warning">Mesaj Gonder</button>--%>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button id="CLOSE" type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                            </div>
                        </div>

                    </div>
                </div>
                <%--END OF Checkin pop-up --%>

                <%-- Messaage pop-up--%>
                <div id="myModal2" class="modal fade" role="dialog">
                    <div class="modal-dialog">

                        <!-- Modal content-->
                        <div class="modal-content">
                            <div class="modal-header">
                                <h3>Mesaj Gonder</h3>
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                            </div>
                            <div class="modal-body">

                                <!-- Message input-->
                                <div class="form-group">
                                    <asp:Label runat="server" AssociatedControlID="txtMessageTargetUsername" CssClass="col-md-4 control-label">To : </asp:Label>
                                    <div class="col-md-8">
                                        <asp:TextBox ID="txtMessageTargetUsername" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <asp:Label runat="server" AssociatedControlID="txtMessageText" CssClass="col-md-4 control-label">Mesaj</asp:Label>
                                    <div class="col-md-8">
                                        <asp:TextBox ID="txtMessageText" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-md-8">
                                        <asp:Button ID="btnRespond" runat="server" CssClass="btn btn-warning" OnClick="Respond_Click" Text="Gonder" />
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                            </div>
                        </div>

                    </div>
                </div>
                <%-- END OF Messaage pop-up --%>

                <%-- Feedback pop-up--%>
                <div id="myModal3" class="modal fade" role="dialog">
                    <div class="modal-dialog">

                        <!-- Modal content-->
                        <div class="modal-content">
                            <div class="modal-header">
                                <h3>FEEDBACK VER</h3>
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                            </div>
                            <div class="modal-body">


                                <!-- Message input-->
                                <div class="form-group">
                                    <asp:Label runat="server" AssociatedControlID="txtMessageTargetUsername" CssClass="col-md-4 control-label">Score :</asp:Label>
                                    <%--										<label class="col-md-4 control-label" for="messageinput">Kullanici Adi</label>--%>
                                    <div class="col-md-8">
                                        <asp:DropDownList ID="Score" runat="server" class="form-control">
                                            <asp:ListItem Value="1" Text="1"></asp:ListItem>
                                            <asp:ListItem Value="2" Text="2"></asp:ListItem>
                                            <asp:ListItem Value="3" Text="3"></asp:ListItem>
                                            <asp:ListItem Value="4" Text="4"></asp:ListItem>
                                            <asp:ListItem Value="5" Text="5"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <asp:Label runat="server" AssociatedControlID="txtFeedback" CssClass="col-md-4 control-label">Mesaj</asp:Label>
                                    <%--										<label class="col-md-4 control-label" for="messageinput">Kullanici Adi</label>--%>
                                    <div class="col-md-8">
                                        <asp:TextBox ID="txtFeedback" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>

                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-md-8">
                                        <asp:Button ID="btnSendFeedback" runat="server" CssClass="btn btn-warning" OnClick="btnSendFeedback_Click" Text="Gonder" />
                                        <%--<button id="singlebutton" name="singlebutton" class="btn btn-warning">Mesaj Gonder</button>--%>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                            </div>
                        </div>

                    </div>
                </div>
                <%-- END OF Feedback pop-up --%>
            </div>

            <!-- ayarlar -->
            <div class="container1" id="settings" style="display: none;">

                <br />
                <br />
                <h2>Hesabim</h2>
                <ul class="nav nav-tabs">
                    <li class="nav-item">
                        <a class="nav-link active" data-toggle="tab" href="#ayarlar-profil">Profil</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-toggle="tab" href="#ayarlar-sifre">Sifre Degistir </a>
                    </li>
                </ul>

                <div class="tab-content">
                    <div id="ayarlar-profil" class="tab-pane active" style="margin-top: 15px;" role="tabpanel">
                        <div class="offset-md-1 col-md-10 ">
                            <div class="form-group">
                                <label for="">İsim</label>
                                <asp:TextBox ID="NameInput" runat="server" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="NameInput" ErrorMessage="Gerekli" ForeColor="Red" ValidationGroup="RequestVali"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator runat="server" ControlToValidate="NameInput" Display="Dynamic" ValidationExpression="^[a-zA-ZşŞçÇğĞİöÖüÜı''-'\s]{1,150}$" ErrorMessage="*Sadece harfler" ForeColor="Red" ValidationGroup="RequestVali"></asp:RegularExpressionValidator>
                            </div>
                            <div class="form-group">
                                <label for="">Soyisim</label>
                                <asp:TextBox ID="SurnameInput" runat="server" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="SurnameInput" ErrorMessage="Gerekli" ForeColor="Red" ValidationGroup="RequestVali"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator runat="server" ControlToValidate="SurnameInput" Display="Dynamic" ValidationExpression="^[a-zA-ZşŞçÇğĞİöÖüÜı''-'\s]{1,100}$" ErrorMessage="*Sadece harfler" ForeColor="Red" ValidationGroup="RequestVali"></asp:RegularExpressionValidator>
                            </div>
                            <div class="form-group">
                                <label for="" class="control-label">Kullanıcı İsmi</label>
                                <asp:TextBox ID="uNameInput" runat="server" CssClass="form-control" disabled></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <label for="" class="control-label">Email</label>
                                <asp:TextBox ID="emailInput" runat="server" CssClass="form-control " disabled></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <label for="">Cep Telefonu</label>
                                <asp:TextBox ID="PhoneInput" runat="server" CssClass="form-control" placeholder="05xxxxxxxxx"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="PhoneInput" ErrorMessage="Gerekli" ForeColor="Red" ValidationGroup="RequestVali"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator runat="server" ControlToValidate="PhoneInput" Display="Dynamic" ValidationExpression="^[01]?[- .]?(\([2-9]\d{2}\)|[2-9]\d{2})[- .]?\d{3}[- .]?\d{4}$" ErrorMessage="Doğru giriniz" ForeColor="Red" ValidationGroup="RequestVali"></asp:RegularExpressionValidator>
                            </div>
                            <div class="form-group">
                                <label for="">Adres</label>
                                <asp:TextBox ID="AddressInput" runat="server" CssClass="form-control" TextMode="MultiLine" placeholder=""></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="AddressInput" ErrorMessage="Gerekli" ForeColor="Red" ValidationGroup="RequestVali"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator runat="server" ControlToValidate="AddressInput" Display="Dynamic" ValidationExpression="^[a-zA-Z0-9şŞçÇğĞİöÖüÜı''-'\s]{1,250}$" ErrorMessage="*Sadece harfler ve sayılar" ForeColor="Red" ValidationGroup="RequestVali"></asp:RegularExpressionValidator>
                            </div>
                            <div class="form-group">
                                <label for="">IBAN</label>
                                <asp:TextBox ID="IBANInput" runat="server" CssClass="form-control" placeholder="Tercihe Bağlı"></asp:TextBox>
                                <asp:RegularExpressionValidator runat="server" ControlToValidate="IBANInput" Display="Dynamic" ValidationExpression="^[a-zA-Z0-9]{32}$" ErrorMessage="" ForeColor="Red" ValidationGroup="RequestVali"></asp:RegularExpressionValidator>
                            </div>
                            <div class="form-group">
                                <label for="">T.C. Kimlik No</label>
                                <asp:TextBox ID="TCInput" runat="server" CssClass="form-control" placeholder="Tercihe Bağlı"></asp:TextBox>
                                <asp:RegularExpressionValidator runat="server" ControlToValidate="TCInput" Display="Dynamic" ValidationExpression="^\d{11}$" ErrorMessage="*11 sayı olmalı" ForeColor="Red" ValidationGroup="RequestVali"></asp:RegularExpressionValidator>
                            </div>

                            <div class="form-group">
                                <label for="">Ek Açıklama</label>
                                <asp:TextBox ID="AnnotationInput" runat="server" CssClass="form-control" TextMode="MultiLine" placeholder="Tercihe Bağlı"></asp:TextBox>
                                <asp:RegularExpressionValidator runat="server" ControlToValidate="AnnotationInput" Display="Dynamic" ValidationExpression="^[a-zA-Z0-9şŞçÇğĞİöÖüÜı''-'\s]{1,250}$" ErrorMessage="*Sadece harfler ve sayılar" ForeColor="Red" ValidationGroup="RequestVali"></asp:RegularExpressionValidator>
                            </div>
                            <div class="form-group">
                                <label class="col-md-4 control-label" for="filebutton">Resim Ekle</label>
                                <div class="col-md-8">
                                    <asp:FileUpload ID="resim_yukle" runat="server" CssClass="form-control input-file" AllowMultiple="False" />
                                </div>
                            </div>
                            <%--<div class="form-group">
                                <label for="" class="control-label">Profil Resmi</label>
                                <div class="custom-file" id="customFile" lang="es">
                                    <input type="file" class="custom-file-input" id="exampleInputFile" aria-describedby="fileHelp">
                                    <label class="custom-file-label" for="exampleInputFile">
                                        Resim Sec...
                                   
                                    </label>
                                </div>
                            </div>--%>
                            <%--<div class="form-group">
                                <label for="inputdefault">Konum</label>
                                <br />
                                Insert Map HERE 
                            
                                <label style="margin-left: 20px; margin-right: 10px;">ve ya</label>
                                <span class="btn btn-success" style="display: inline;">konumumu sec</span>
                            </div>--%>
                            <asp:Button ID="btnUpdate" runat="server" CssClass="btn btn-primary" OnClick="SaveBtn_Click" Text="Guncelle" Style="margin: 10px 0 0 0; width: 100%;" />
                            <%--                            <button class="btn btn-danger" id="btnCancel" style="margin: 10px 0 0 0; width: 100%;">Vazgec</button>--%>
                            <asp:Label ID="lblStatus" Visible="false" CssClass="inputdefault" runat="server"></asp:Label>
                        </div>
                    </div>
                    <div id="ayarlar-sifre" class="tab-pane fade" role="tabpanel">
                        <div class="offset-md-1 col-md-10 ">
                            <div class="form-group" style="margin-top: 15px;">
                                <label for="inputdefault">Mevcut Sifreyi Giriniz</label>
                                <asp:TextBox ID="txtOldPw" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtOldPw" ErrorMessage="Gerekli" ForeColor="Red" ValidationGroup="RequestVali4"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator runat="server" ControlToValidate="txtOldPw" Display="Dynamic" ValidationExpression="^[a-zA-Z0-9şŞçÇğĞİöÖüÜı\s]{1,16}$" ErrorMessage="*Sadece harfler ve sayılar" ForeColor="Red" ValidationGroup="RequestVali4"></asp:RegularExpressionValidator>
                            </div>
                            <div class="form-group">
                                <label for="inputdefault">Yeni Sifre</label>
                                <asp:TextBox ID="txtPw" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPw" ErrorMessage="Gerekli" ForeColor="Red" ValidationGroup="RequestVali4"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator runat="server" ControlToValidate="txtPw" Display="Dynamic" ValidationExpression="^[a-zA-Z0-9şŞçÇğĞİöÖüÜı\s]{1,16}$" ErrorMessage="*Sadece harfler ve sayılar" ForeColor="Red" ValidationGroup="RequestVali4"></asp:RegularExpressionValidator>
                            </div>
                            <div class="form-group">
                                <label for="disabledInput" class="control-label">Yeni Sifre(tekrar)</label>
                                <asp:TextBox ID="txtPwControl" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPwControl" ErrorMessage="Gerekli" ForeColor="Red" ValidationGroup="RequestVali4"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator runat="server" ControlToValidate="txtPwControl" Display="Dynamic" ValidationExpression="^[a-zA-Z0-9şŞçÇğĞİöÖüÜı\s]{1,16}$" ErrorMessage="*Sadece harfler ve sayılar" ForeColor="Red" ValidationGroup="RequestVali4"></asp:RegularExpressionValidator>
                                <asp:Label ID="lblPwStatus" Visible="false" CssClass="inputdefault" runat="server"></asp:Label>

                            </div>
                            <asp:Button ID="btnPwUpdate" runat="server" CssClass="btn btn-primary" OnClick="SaveBtnPass_Click" Text="Guncelle" autopostback="false" Style="margin: 10px 0 0 0; width: 100%;" />
                            <%--                            <button class="btn btn-danger" id="btnpassCancel" style="margin: 10px 0 0 0; width: 100%;">Vazgec</button>--%>
                        </div>
                    </div>

                </div>
            </div>

            <!-- KIRA -->
            <div class="container1" id="favoriler" style="display: none;">
                <br />
                <br />
                <br />
                <asp:Label ID="zeroRent" runat="server" Visible="false" Text="Aktif Bisiklet kiralamaniz bulunmamaktadir &#010; Hemen bir bisiklet kiralayin" Font-Size="X-Large" Font-Bold="true"></asp:Label>
                <asp:Repeater ID="RepRent" runat="server" OnItemCommand="RepRent_ItemCommand">
                    <HeaderTemplate>
                        <table class="table table-responsive table-responsive-sm">
                            <thead>
                                <tr>
                                    <th>Picture</th>
                                    <th>Description</th>
                                    <th>Price</th>
                                    <th>Adding Date</th>
                                    <th>Location</th>
                                    <th>Kirala</th>
                                </tr>
                            </thead>

                            <tbody>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>

                            <td>
                                <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl='<%# Eval("Picture") %>' CommandName="ImageClick" CommandArgument='<%# Eval("OwnerID")+","+ Eval("BikeID") %>' Width="140" />
<%--                                <asp:ImageButton ID="phImage" runat="server" ImageUrl='<%# Eval("Picture") %>' CommandName="CheckinClick" CommandArgument='<%# Eval("BikeID") %>' Width="140" />--%>
                                <%--OnCommand="Image_Click" --%>
                            </td>
                            <td>
                                <%# Eval("Description")%>
                                <br />

                                <br />
                                <%-- <%# Eval("Availability")%>--%>
                                
                            </td>
                            <td><%# Eval("Price")%><%# changeCurrency(Eval("Currency")) %><a> /hafta</a></td>
                            <td>
                                <%# makeShortDate(Eval("AddingDate")) %>
                                <%--<i class="material-icons">remove_red_eye</i>
                                <span>Goruntulenme </span><span class="badge" style="margin-left:6px;font-size:13px;">32</span>
                                <br />
                                <i class="material-icons">stars</i>         goodbye i loved ur idea
                                <span>Favoriler</span><span class="badge" style="margin-left:6px;font-size:13px;">2</span>--%>
                            </td>
                            <td><%# changeLocation(Eval("BikeCity"), Eval("BikeCounty"))%></td>
                            <!--OnClick="btnCheckinrent_Click" -->
                            <td><%--'<%# ((int)Eval("CheckIn") < 1) ? "Onayla" : "Checkin Out" %>'                 AYNISINI ILANLAR ICINDE YAP --%>
                                <%--if db deki checkin 1 se button.text -> ceheckin out--%><asp:LinkButton ID="btnCheckinrent" runat="server" CssClass="btn btn-warning btn-md" CommandName="CheckinrentClick" CommandArgument='<%# Eval("BikeID") %>' Text="Onayla"  ValidationGroup="OutThat" Visible='<%# Convert.ToBoolean(Eval("RenterCheckIn").ToString()== "1" && ProcessMyDataItem(Eval("HirerCheckIn")).ToString() == "0" ? "true": "false") %>'></asp:LinkButton>
                                <asp:LinkButton ID="btnCheckinoutrent" runat="server" CssClass="btn btn-warning btn-md" CommandName="CheckinoutrentClick" CommandArgument='<%# Eval("BikeID") %>' Text="Checkin Out" OnClick="btnCheckinoutrent_Click" ValidationGroup="OutThat" Visible='<%# Convert.ToBoolean(ProcessMyDataItem(Eval("RenterCheckIn")).ToString() == "1" && ProcessMyDataItem(Eval("HirerCheckIn")).ToString() == "1" ? "true": "false") %>'></asp:LinkButton>
                                <%-- <asp:Button ID="btnCheckinrent" runat="server" CssClass="btn btn-warning btn-md" Text="Onayla" OnClick="btnCheckinrent_Click"  />  --%>
                                <br />
                                <span class="btn btn-danger" style="margin-top: 10px; width: 100%;">Vazgec</span>
                            </td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </tbody>

                </table>
                    </FooterTemplate>
                </asp:Repeater>
            </div>

            <!--mesajlarim  -->
            <div class="container1" id="inbox" style="display: none;">
                <br />
                <br />
                <br />
                <asp:Label ID="zeroMsg" runat="server" Visible="false" Text="Henuz bir mesajiniz bulunmamaktadir.Uzulmeyin yalniz degilsiniz..." Font-Size="X-Large" Font-Bold="true"></asp:Label>
                <div class="mail-box">

                    <asp:Repeater ID="RepMessage" runat="server" OnItemCommand="RepMessage_ItemCommand">
                        <HeaderTemplate>
                            <table class="table table-hover table-inbox">
                                <%-- table-hover--%>
                                <tbody>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr class="unread">
                                <td class="inbox-small-cells">
                                    <input type="checkbox" class="mail-checkbox">
                                </td>
                                <td class="inbox-small-cells"><i class="fa fa-star"></i></td>
                                <td class="view-message  dont-show"><%# Eval("Username") %></td>
                                <%--senderusername yap databasede veya--%>
                                <td class="view-message "><%# Eval("Message") %></td>
                                <td class="view-message  inbox-small-cells"><i class="fa fa-paperclip"></i></td>
                                <td class="view-message  text-right"><%# makeShortDate(Eval("SendDate")) %>
                                    <br />
                                    <%# ProcessDay(Eval("SendDate")) %></td>
                                <td>
                                    <asp:LinkButton ID="btnmes" runat="server" CssClass="btn btn-warning btn-md" CommandName="MessageClick" CommandArgument='<%# Eval("SenderID")+","+ Eval("Username") %>' Text="Yanitla" ValidationGroup="OutThat"></asp:LinkButton>

                                </td>
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
    </div>
</asp:Content>

