using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db.view
{
    /// <summary>
    /// 审批流
    /// rui
    /// </summary>
    public class af_AuditFlow : rui.pagerBase
    {
        public string auditTypeCode { get; set; }
        public string flowName { get; set; }
        public string orgCode { get; set; }
        public override void Search()
        {
            this.keyField = "flowCode";
            this.ResourceCode = "af_AuditFlow";

            //搜索语句
            string querySql = " SELECT * FROM dbo.sv_af_AuditFlow WHERE 1=1 ";
            querySql += rui.dbTools.searchDdl("auditTypeCode", this.auditTypeCode, this.cmdPara);
            querySql += rui.dbTools.searchTbx("flowName", this.flowName, this.cmdPara);
            this.orgCode = db.bll.loginAdminHelper.getDefaultOrgCode(this.orgCode);
            querySql += rui.dbTools.searchDdl("orgCode", this.orgCode, this.cmdPara);

            //搜索数据
            this.getPageConfig();
            rui.pagerHelper ph = new rui.pagerHelper(querySql, this.getOrderSql("flowCode", "desc"), this);
            ph.Execute(this.PageSize, this.PageIndex, this);
            this.dataTable = ph.Result;

            //显示的列和列顺序
            this.showColumn = this.getShowColumn();
        }
    }
}
