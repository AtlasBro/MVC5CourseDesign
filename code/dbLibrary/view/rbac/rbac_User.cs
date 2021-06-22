using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db.view
{
    /// <summary>
    /// rui
    /// 用户表
    /// </summary>
    public class rbac_User : rui.pagerBase
    {
        //搜索条件
        public string deptCode { get; set; }
        public string userCode { get; set; }
        public string userName { get; set; }

        public string isLogin { get; set; }
        public override void Search()
        { 
            this.keyField = "userCode";
            this.ResourceCode = "rbac_User";

            //搜索语句
            string querySql = @" SELECT * FROM sv_rbac_User WHERE 1=1 ";
            querySql += rui.dbTools.searchDdl("orgCode", db.bll.loginAdminHelper.getOrgCode(), this.cmdPara);
            querySql += rui.dbTools.searchTbx("userCode", this.userCode, this.cmdPara);
            querySql += rui.dbTools.searchTbx("userName", this.userName, this.cmdPara);
            querySql += rui.dbTools.searchDdl("deptCode", this.deptCode, this.cmdPara);
            querySql += rui.dbTools.searchDdl("isLogin", this.isLogin, this.cmdPara);

            //搜索数据
            this.getPageConfig();
            rui.pagerHelper ph = new rui.pagerHelper(querySql, this.getOrderSql("userCode", "asc"), this);
            ph.Execute(this.PageSize, this.PageIndex, this);
            this.dataTable = ph.Result;

            //显示的列和列顺序
            this.showColumn = this.getShowColumn();
        }
    }
}
