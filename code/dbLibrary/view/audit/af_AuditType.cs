using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db.view
{
    /// <summary>
    /// 审批单据类型
    /// </summary>
    public class af_AuditType : rui.pagerBase
    {
        public string billTypeName { get; set; }

        public override void Search()
        {
            this.ResourceCode = "af_AuditType";

            //搜索语句
            string querySql = @" SELECT * FROM dbo.af_AuditType WHERE 1=1 ";
            querySql += rui.dbTools.searchTbx("auditTypeName", this.billTypeName, this.cmdPara);

            //搜索数据
            this.getPageConfig();
            rui.pagerHelper ph = new rui.pagerHelper(querySql, this.getOrderSql("auditTypeCode", "desc"), this);
            ph.Execute(this.PageSize, this.PageIndex, this);
            this.dataTable = ph.Result;

            //显示的列和列顺序
            this.showColumn = this.getShowColumn();
        }
    }
}
