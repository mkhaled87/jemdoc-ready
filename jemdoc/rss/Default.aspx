<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" ValidateRequest="false" %>

<!DOCTYPE html>
<html>
<head runat="server">
	<title>Add News Element</title>
</head>
<body>
	<form id="form1" runat="server">
        
        
        <asp:XmlDataSource 
            ID="XmlDataSource1" runat="server" 
            DataFile="news.rss" 
            XPath="rss/channel/item"></asp:XmlDataSource>
            
        <h2> Add a new news entry </h2>
        <table style="border-width: 1px;">
          <tr>
            <th>Date</th>
            <td> <asp:TextBox runat="server" id="txtDate" Text="22.06.1987" /> </td>
          </tr>
          <tr>
            <th>Title</th>
            <td><asp:TextBox runat="server" id="txtTitle" Text="example title" Width="400px" /></td>
          </tr>
          <tr>
            <th>Description</th>
            <td><asp:TextBox runat="server" id="txtDescr" Text='example descritpion with a <a href="link address">link</a>' TextMode="MultiLine" Width="600px" /></td>
          </tr>
          <tr>
              <td></td>
              <td><asp:Button runat="server" id="btnAdd" Text="Add" OnClick="btnAdd_Click"></asp:Button></td>
          </tr>
        </table>            
            
        <br/>
        <br/>
        
        <h2> View/delete news entries </h2>
        <asp:GridView ID="gvRSS" 
                      runat="server" 
                      AutoGenerateColumns="false"
                      DataSourceID="XmlDataSource1">
            <Columns>
                <asp:TemplateField HeaderText="Date" ItemStyle-Width="100px">
                    <ItemTemplate>
                        <asp:Label runat="server" Text='<%# XPath("date") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>                    
                <asp:TemplateField HeaderText="Title" ItemStyle-Width="600px">
                    <ItemTemplate>
                        <asp:Label runat="server" Text='<%# XPath("title") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Description">
                    <ItemTemplate>
                        <asp:Label runat="server" Text='<%# XPath("description") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>   
                <asp:TemplateField HeaderText="Actions">
                    <ItemTemplate>
                        <asp:Button runat="server" id="btnDelEntry" Text="Delete" OnClick="btnDelEntry_Click"></asp:Button>
                    </ItemTemplate>
                </asp:TemplateField>                       
            </Columns>
        </asp:GridView>            
	</form>
</body>
</html>

