using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void btnAdd_Click(object sender, System.EventArgs e)
    {
        String path = XmlDataSource1.XPath;
        XmlDocument myXml = new XmlDocument();
        myXml = (XmlDocument)XmlDataSource1.GetXmlDocument();

        XmlNodeList nodeList;
        nodeList = myXml.SelectNodes(path);

        XmlNode first_node = myXml.SelectNodes(path)[0];
        XmlNode to_add = first_node.Clone();

        to_add.ChildNodes[0].InnerText = txtDate.Text;
        to_add.ChildNodes[1].InnerText = txtTitle.Text;
        to_add.ChildNodes[2].InnerXml = "<![CDATA[ " + txtDescr.Text + " ]]>";

        first_node.ParentNode.InsertBefore(to_add, first_node);

        XmlDataSource1.Save();
        XmlDataSource1.DataBind();
        gvRSS.DataBind();
    }
    protected void btnDelEntry_Click(object sender, System.EventArgs e)
    {
        int to_del_idx = ((GridViewRow)((Button)sender).Parent.Parent).RowIndex;
        String path = XmlDataSource1.XPath;
        XmlDocument myXml = new XmlDocument();
        myXml = (XmlDocument)XmlDataSource1.GetXmlDocument();

        XmlNode to_del_node = myXml.SelectNodes(path)[to_del_idx];
        to_del_node.ParentNode.RemoveChild(to_del_node);

        XmlDataSource1.Save();
        XmlDataSource1.DataBind();
        gvRSS.DataBind();

    }

}