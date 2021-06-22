using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db.view
{
    public class af_AuditCenter : rui.pagerBase
    {
        public string deptCode { get; set; }
        public string auditTypeCode { get; set; }
        public string createDateStart { get; set; }
        public string createDataEnd { get; set; }
        public string auditDateStart { get; set; }
        public string auditDataEnd { get; set; }
        public string relatedKeyCode { get; set; }

        public bool isWait { get; set; }  //待审单据

        public override void Search()
        {
            this.ResourceCode = "af_AuditCenter";

            //搜索语句
            string querySql = " SELECT * FROM sv_af_AuditCenter WHERE userCode='" + db.bll.loginAdminHelper.getUserCode() + "' ";
            querySql += rui.dbTools.searchDdl("auditTypeCode", this.auditTypeCode, this.cmdPara);
            querySql += rui.dbTools.searchDdl("relatedDeptCode", this.deptCode, this.cmdPara);
            querySql += rui.dbTools.searchDate("createDate", this.createDateStart, this.createDataEnd, this.cmdPara);
            querySql += rui.dbTools.searchDate("auditDate", this.auditDateStart, this.auditDataEnd, this.cmdPara);
            querySql += rui.dbTools.searchTbx("relatedKeyCode", this.relatedKeyCode, this.cmdPara);
            if (isWait==true)
                querySql += " and auditDate IS NULL ";

            //搜索数据
            this.getPageConfig();
            rui.pagerHelper ph = new rui.pagerHelper(querySql, this.getOrderSql("createDate", "desc"), this);
            ph.Execute(this.PageSize, this.PageIndex, this);
            this.dataTable = ph.Result;

            //显示的列和列顺序
            this.showColumn = this.getShowColumn();
        }
    }
}
