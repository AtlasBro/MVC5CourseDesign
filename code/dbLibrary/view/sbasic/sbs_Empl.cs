using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db.view
{
    /// <summary>
    /// 员工表
    /// </summary>
    public class sbs_Empl : rui.pagerBase
    {
        //搜索条件
        public string orgCode { get; set; }
        public string deptCode { get; set; }
        public string emplCode { get; set; }
        public string emplName { get; set; }

        public override void Search()
        {
            this.keyField = "emplCode";
            this.ResourceCode = "sbs_Empl";

            //搜索语句
            string querySql = @" SELECT * FROM sv_sbs_Empl WHERE 1=1 ";
            querySql += rui.dbTools.searchDdl("orgCode", this.orgCode, this.cmdPara);
            querySql += rui.dbTools.searchDdl("deptCode", this.deptCode, this.cmdPara);
            querySql += rui.dbTools.searchTbx("emplCode", this.emplCode, this.cmdPara);
            querySql += rui.dbTools.searchTbx("emplName", this.emplName, this.cmdPara);

            //搜索数据
            this.getPageConfig();
            rui.pagerHelper ph = new rui.pagerHelper(querySql, this.getOrderSql("emplCode", "asc"), this);
            ph.Execute(this.PageSize, this.PageIndex, this);
            db.bll.rbac_User.setIsLogin(ph.Result, "emplCode", null);
            this.dataTable = ph.Result;

            //显示的列和列顺序
            this.showColumn = this.getShowColumn();
        }
    }
}
