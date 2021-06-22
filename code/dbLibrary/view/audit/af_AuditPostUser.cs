using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db.view
{
    /// <summary>
    /// view-用户任职表
    /// wzrui 2019-06-17
    /// </summary>
    public class af_AuditPostUser : rui.pagerBase
    {
        public string userCode { get; set; }
        public string userName { get; set; }
        public override void Search()
        {
            this.keyField = "userCode";
            this.ResourceCode = "af_AuditPostUser";
	
            //搜索语句
            string querySql = "SELECT * FROM dbo.sv_af_AuditPostUser where 1=1 ";
            querySql += rui.dbTools.searchDdl("orgCode", db.bll.loginAdminHelper.getOrgCode(), this.cmdPara);
            querySql += rui.dbTools.searchTbx("userCode", this.userCode, this.cmdPara);
            querySql += rui.dbTools.searchTbx("userName", this.userName, this.cmdPara);

            //数据搜索
            this.getPageConfig();
            rui.pagerHelper ph = new rui.pagerHelper(querySql, this.getOrderSql("userCode", "desc"), this);
            ph.Execute(this.PageSize, this.PageIndex, this);
            this.dataTable = ph.Result;

            //显示的列和列顺序
            this.showColumn = this.getShowColumn();
        }
    }
}