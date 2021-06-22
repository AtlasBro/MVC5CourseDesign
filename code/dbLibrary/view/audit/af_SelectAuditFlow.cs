using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db.view
{
    /// <summary>
    /// 选择送审的审批流
    /// </summary>
    public class af_SelectAuditFlow : rui.pagerBase
    {
        public string rowID { get; set; }     //关联单据行号
        public string type { get; set; }    //审批单据类型

        public override void Search()
        {
            this.keyField = "flowCode";
            this.ResourceCode = "af_SelectAuditFlow";

            //搜索语句
            string querySql = " SELECT * FROM dbo.af_AuditFlow WHERE isUse='是' ";
            querySql += " AND orgCode='" + db.bll.loginAdminHelper.getOrgCode() + "' ";
            querySql += rui.dbTools.searchDdl("auditTypeCode", this.type, this.cmdPara);

            //搜索数据
            rui.pagerHelper ph = new rui.pagerHelper(querySql, this.getOrderSql("flowCode", "desc"), this);
            ph.Execute(this.PageSize, this.PageIndex, this);
            this.dataTable = ph.Result;

            //显示的列和列顺序
            this.showColumn = this.getShowColumn();
        }
    }
}
