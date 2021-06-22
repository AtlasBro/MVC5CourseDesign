using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace db.view
{
    /// <summary>
    /// rui
    /// 模块表
    /// </summary>
    public class rbac_Module : rui.pagerBase
    {
        public string moduleName { get; set; }
        public override void Search()
        {
            this.ResourceCode = "rbac_Module";
            
            //搜索语句
            string querySql = " SELECT * FROM dbo.rbac_Module WHERE 1=1 ";
            querySql += rui.dbTools.searchTbx("moduleName", this.moduleName, this.cmdPara);

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