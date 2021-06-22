using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db.view
{
    /// <summary>
    /// view-职务任职表表
    /// wzrui 2019-06-16
    /// </summary>
    public class af_AuditPost : rui.pagerBase
    {
        public string postCode { get; set; }
        public string postName { get; set; }
        public override void Search()
        {
            this.keyField = "postCode";
            this.ResourceCode = "af_AuditPost";

		
            //搜索语句
            string querySql = "SELECT * FROM dbo.af_AuditPost where 1=1 ";
            querySql += rui.dbTools.searchTbx("postCode", this.postCode, this.cmdPara);
            querySql += rui.dbTools.searchTbx("postName", this.postName, this.cmdPara);

            //数据搜索
            this.getPageConfig();
            rui.pagerHelper ph = new rui.pagerHelper(querySql, this.getOrderSql("postCode", "desc"), this);
            ph.Execute(this.PageSize, this.PageIndex, this);
            this.dataTable = ph.Result;

            //显示的列和列顺序
            this.showColumn = this.getShowColumn();
        }
    }
}