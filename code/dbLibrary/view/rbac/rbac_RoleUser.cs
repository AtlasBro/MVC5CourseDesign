using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db.view
{
    /// <summary>
    /// 角色用户关联（已关联和未关联公用）
    /// </summary>
    public class rbac_RoleUser : rui.pagerBase
    {
        //部门编号
        public string deptCode { get; set; }
        //用户编号
        public string userCode { get; set; }
        //用户名称
        public string userName { get; set; }
        //角色行号
        public string rowID { get; set; }
        //查询类型
        public string type { get; set; }

        public override void Search()
        {
            this.keyField = "userCode";
            this.ResourceCode = "rbac_User";
            this.PageSize = rui.configHelper.pageSizeDlg;

            string orgCode = db.bll.loginAdminHelper.getOrgCode();
            string roleCode = db.bll.rbac_Role.getCodeByRowID(rowID, efHelper.newDc());
            string inSql = " SELECT userCode FROM dbo.rbac_RoleUser WHERE orgCode='" + orgCode + "' AND roleCode='" + roleCode + "' ";
            //查询已关联用户
            if (type == "link")
            {
                //搜索语句
                string querySql = @" SELECT * FROM sv_rbac_User WHERE isLogin='是' ";
                querySql += rui.dbTools.searchIn("userCode", inSql, this.cmdPara);
                querySql += rui.dbTools.searchDdl("orgCode", db.bll.loginAdminHelper.getOrgCode(), this.cmdPara);
                querySql += rui.dbTools.searchDdl("deptCode", this.deptCode, this.cmdPara);
                querySql += rui.dbTools.searchTbx("userCode", this.userCode, this.cmdPara);
                querySql += rui.dbTools.searchTbx("userName", this.userName, this.cmdPara);

                //搜索数据
                //this.getPageConfig();
                rui.pagerHelper ph = new rui.pagerHelper(querySql, this.getOrderSql("userCode", "asc"), this);
                ph.Execute(this.PageSize, this.PageIndex, this);
                this.dataTable = ph.Result;

                //显示的列和列顺序
                this.showColumn = this.getShowColumn(false);
            }
            //查询未关联用户
            if (type == "nolink")
            {
                //搜索语句
                string querySql = @" SELECT * FROM sv_rbac_User WHERE isLogin='是' ";
                querySql += rui.dbTools.searchNoIn("userCode", inSql, this.cmdPara);
                querySql += rui.dbTools.searchDdl("orgCode", orgCode, this.cmdPara);
                querySql += rui.dbTools.searchDdl("deptCode", this.deptCode, this.cmdPara);
                querySql += rui.dbTools.searchTbx("userCode", this.userCode, this.cmdPara);
                querySql += rui.dbTools.searchTbx("userName", this.userName, this.cmdPara);

                //搜索数据
                //this.getPageConfig();
                rui.pagerHelper ph = new rui.pagerHelper(querySql, this.getOrderSql("userCode", "asc"), this);
                ph.Execute(this.PageSize, this.PageIndex, this);
                this.dataTable = ph.Result;

                //显示的列和列顺序
                this.showColumn = this.getShowColumn(false);
            }
        }
    }
}
