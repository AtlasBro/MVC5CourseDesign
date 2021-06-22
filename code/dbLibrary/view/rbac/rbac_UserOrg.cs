using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db.view
{
    public class rbac_UserOrg : rui.pagerBase
    {
        //职工行号
        public string rowID { get; set; }

        //查询类型
        public string searchType { get; set; }

        public override void Search()
        {
            this.keyField = "orgCode";
            string userCode = db.bll.sbs_Empl.getCodeByRowID(rowID,efHelper.newDc());
            string inSql = " SELECT orgCode FROM dbo.rbac_UserOrg WHERE userCode='" + userCode + "' ";

            //查询已关联组织
            if (searchType == "link")
            {
                string querySql = @"  SELECT * FROM dbo.sv_rbac_UserOrg WHERE userCode='" + userCode + "' ";
                querySql += rui.dbTools.searchIn("orgCode", inSql, this.cmdPara);

                //搜索数据
                rui.pagerHelper ph = new rui.pagerHelper(querySql, this.getOrderSql("orgCode", "asc"), this);
                ph.Execute(this.PageSize, this.PageIndex, this);
                this.dataTable = ph.Result;

                //显示的列和列顺序
                this.showColumn = this.getShowColumn("rbac_UserOrg", false);
            }

            //查询未关联组织
            if (searchType == "nolink")
            {
                string querySql = @" SELECT * FROM dbo.sbs_Org WHERE 1=1 ";
                querySql += rui.dbTools.searchNoIn("orgCode", inSql, this.cmdPara);

                //搜索数据
                rui.pagerHelper ph = new rui.pagerHelper(querySql, this.getOrderSql("orgCode", "asc"), this);
                ph.Execute(this.PageSize, this.PageIndex, this);
                this.dataTable = ph.Result;

                //显示的列和列顺序
                this.showColumn = this.getShowColumn("sbs_Org", false);
            }
        }
    }
}
