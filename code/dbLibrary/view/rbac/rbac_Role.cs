using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db.view
{
    /// <summary>
    /// 角色维护
    /// </summary>
    public class rbac_Role : rui.pagerBase
    {
        //搜索条件
        public string roleName { get; set; }
        public override void Search()
        {
            this.ResourceCode = "rbac_Role";

            //搜索语句
            string querySql = @" SELECT * FROM dbo.rbac_Role WHERE 1=1 ";
            querySql += rui.dbTools.searchTbx("roleName", this.roleName, this.cmdPara);

            //搜索数据
            this.getPageConfig();
            rui.pagerHelper ph = new rui.pagerHelper(querySql, this.getOrderSql("roleCode", "asc"), this);
            ph.Execute(this.PageSize, this.PageIndex, this);
            this.dataTable = ph.Result;

            //显示的列和列顺序
            this.showColumn = this.getShowColumn();
        }
    }
}
