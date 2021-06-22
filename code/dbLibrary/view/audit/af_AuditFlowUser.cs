using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db.view
{
    /// <summary>
    /// 审批流节点关联用户
    /// </summary>
    public class af_AuditFlowUser : rui.pagerBase
    {
        //所属部门
        public string deptCode { get; set; }
        //用户编号
        public string userCode { get; set; }
        //用户名称
        public string userName { get; set; }

        //已选择的用户编号:，分割
        public string selected { get; set; }
        //查询类型
        public string searchType { get; set; }

        public override void Search()
        {
            this.keyField = "userCode";
            this.ResourceCode = "rbac_User";
            this.PageSize = rui.configHelper.pageSizeSelect;

            //查询已关联用户
            string inExpr = rui.dbTools.getInExpression(selected);
            if (searchType == "link")
            {
                //搜索语句
                string querySql = @" SELECT * FROM sv_rbac_User WHERE isLogin='是' ";
                querySql += rui.dbTools.searchDdl("orgCode", db.bll.loginAdminHelper.getOrgCode(), this.cmdPara);
                querySql += rui.dbTools.searchDdl("deptCode", this.deptCode, this.cmdPara);
                querySql += rui.dbTools.searchTbx("userCode", this.userCode, this.cmdPara);
                querySql += rui.dbTools.searchTbx("emplName", this.userName, this.cmdPara);
                querySql += rui.dbTools.searchIn("userCode", inExpr, this.cmdPara);

                //搜索数据
                rui.pagerHelper ph = new rui.pagerHelper(querySql, this.getOrderSql("userCode", "asc"), this);
                ph.Execute(this.PageSize, this.PageIndex, this);
                this.dataTable = ph.Result;

                //显示的列和列顺序
                this.showColumn = this.getShowColumn(false);
            }
            //查询未关联用户
            if (searchType == "nolink")
            {
                //搜索语句
                string querySql = @" SELECT * FROM sv_rbac_User WHERE isLogin='是' ";
                querySql += rui.dbTools.searchDdl("orgCode", db.bll.loginAdminHelper.getOrgCode(), this.cmdPara);
                querySql += rui.dbTools.searchDdl("deptCode", this.deptCode, this.cmdPara);
                querySql += rui.dbTools.searchTbx("userCode", this.userCode, this.cmdPara);
                querySql += rui.dbTools.searchTbx("emplName", this.userName, this.cmdPara);
                querySql += rui.dbTools.searchNoIn("userCode", inExpr, this.cmdPara);

                //搜索数据
                rui.pagerHelper ph = new rui.pagerHelper(querySql, this.getOrderSql("userCode", "asc"), this);
                ph.Execute(this.PageSize, this.PageIndex, this);
                this.dataTable = ph.Result;

                //显示的列和列顺序
                this.showColumn = this.getShowColumn(false);
            }
        }
    }
}
