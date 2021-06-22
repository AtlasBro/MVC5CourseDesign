using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db.view
{
    /// <summary>
    /// rui
    /// 资源表
    /// </summary>
    public class rbac_Resource : rui.pagerBase
    {
        //搜索条件
        public string moduleCode { get; set; }
        public string resourceName { get; set; }
        public override void Search()
        {
            this.keyField = "resourceCode";
            this.ResourceCode = "rbac_Resource";
            
            //搜索语句
            string querySql = @" SELECT * from dbo.sv_rbac_Resource WHERE 1=1 ";
            querySql += rui.dbTools.searchDdl("moduleCode", this.moduleCode, this.cmdPara);
            querySql += rui.dbTools.searchTbx("resourceName", this.resourceName, this.cmdPara);

            //搜索数据
            this.getPageConfig();
            rui.pagerHelper ph = new rui.pagerHelper(querySql, this.getOrderSql("showOrder", "asc"), this);
            ph.Execute(this.PageSize, this.PageIndex, this);
            this.dataTable = ph.Result;

            //显示的列和列顺序
            this.showColumn = this.getShowColumn();
        }
    }
}
