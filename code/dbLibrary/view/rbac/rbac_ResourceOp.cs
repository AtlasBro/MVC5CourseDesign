using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db.view
{
    public class rbac_ResourceOp : rui.pagerBase
    {
        public string upCode { get; set; }

        public override void Search()
        {
            this.ResourceCode = "rbac_ResourceOp";

            //搜索语句
            string querySql = " SELECT * FROM dbo.rbac_ResourceOp WHERE 1=1 ";
            querySql += rui.dbTools.searchDdl("resourceCode", this.upCode, this.cmdPara);

            //搜索数据
            this.getPageConfig();
            this.PageSize = 100;
            rui.pagerHelper ph = new rui.pagerHelper(querySql, this.getOrderSql("showOrder", "asc"), this);
            ph.Execute(this.PageSize, this.PageIndex, this);
            this.dataTable = ph.Result;

            //显示的列和列顺序
            this.showColumn = this.getShowColumn();
        }
    }
}
