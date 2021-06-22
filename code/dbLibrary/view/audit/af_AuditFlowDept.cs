using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db.view
{
    /// <summary>
    /// 审批流与部门关联
    /// </summary>
    public class af_AuditFlowDept : rui.pagerBase
    {
        //所属组织
        public string orgCode { get; set; }

        //部门编号
        public string deptCode { get; set; }

        //部门名称
        public string deptName { get; set; }

        //审批流行号
        public string rowID { get; set; }
        //查询类型
        public string type { get; set; }

        public override void Search()
        {
            this.keyField = "deptCode";
            this.ResourceCode = "sbs_Dept";
            this.PageSize = rui.configHelper.pageSizeSelect;

            this.orgCode = db.bll.loginAdminHelper.getDefaultOrgCode(this.orgCode);
            string inSql = " SELECT deptCode FROM dbo.af_AuditFlowDept WHERE flowCode in ( SELECT flowCode FROM dbo.af_AuditFlow WHERE rowID=@rowID ) ";
            this.cmdPara.Add("rowID", this.rowID);
            //查询已关联部门
            if (type == "link")
            {
                //搜索语句
                string querySql = @" SELECT * from dbo.sv_sbs_Dept where 1=1 ";
                querySql += rui.dbTools.searchDdl("orgCode", this.orgCode, this.cmdPara);
                querySql += rui.dbTools.searchTbx("deptCode", this.deptCode, this.cmdPara);
                querySql += rui.dbTools.searchTbx("deptName", this.deptName, this.cmdPara);
                querySql += rui.dbTools.searchIn("deptCode", inSql, this.cmdPara);

                //搜索数据
                rui.pagerHelper ph = new rui.pagerHelper(querySql, this.getOrderSql("deptCode", "desc"), this);
                ph.Execute(this.PageSize, this.PageIndex, this);
                this.dataTable = ph.Result;

                //显示的列和列顺序
                this.showColumn = this.getShowColumn(false);
            }
            //查询未关联部门
            if (type == "nolink")
            {
                //搜索语句
                string querySql = @" SELECT * from dbo.sv_sbs_Dept where 1=1 ";
                querySql += rui.dbTools.searchDdl("orgCode", this.orgCode, this.cmdPara);
                querySql += rui.dbTools.searchTbx("deptCode", this.deptCode, this.cmdPara);
                querySql += rui.dbTools.searchTbx("deptName", this.deptName, this.cmdPara);
                querySql += rui.dbTools.searchNoIn("deptCode", inSql, this.cmdPara);

                //搜索数据
                rui.pagerHelper ph = new rui.pagerHelper(querySql, this.getOrderSql("deptCode", "desc"), this);
                ph.Execute(this.PageSize, this.PageIndex, this);
                this.dataTable = ph.Result;

                //显示的列和列顺序
                this.showColumn = this.getShowColumn(false);
            }
        }
    }
}
