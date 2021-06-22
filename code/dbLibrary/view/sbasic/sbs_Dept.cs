using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db.view
{
    /// <summary>
    /// 部门
    /// </summary>
    public class sbs_Dept : rui.pagerBase
    {
        public string orgCode { get; set; }
        public string deptCode { get; set; }
        public string deptName { get; set; }

        public override void Search()
        {
            this.ResourceCode = "sbs_Dept";

            //搜索语句
            this.orgCode = db.bll.loginAdminHelper.getDefaultOrgCode(this.orgCode);
            string querySql = @" SELECT * FROM dbo.sv_sbs_Dept WHERE 1=1 ";
            //只能查看该组织内的部门
            querySql += rui.dbTools.searchTbx("orgCode", this.orgCode, this.cmdPara);
            querySql += rui.dbTools.searchTbx("deptCode", this.deptCode, this.cmdPara);
            querySql += rui.dbTools.searchTbx("deptName", this.deptName, this.cmdPara);

            //搜索数据
            this.getPageConfig();
            rui.pagerHelper ph = new rui.pagerHelper(querySql, this.getOrderSql("deptCode", "asc"), this);
            ph.Execute(this.PageSize, this.PageIndex, this);
            this.dataTable = ph.Result;

            //显示的列和列顺序
            this.showColumn = this.getShowColumn();
        }
    }
}
