using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db.client.view
{
    /// <summary>
    /// view-出版社表
    /// wzrui 2020-02-20
    /// </summary>
    public class bks_Press : rui.pagerBase
    {
        public string pressCode { get; set; }
        public string pressName { get; set; }
        public override void Search()
        {
            this.keyField = "rowNum";
            this.ResourceCode = "bks_Press";

            //搜索语句
            string querySql = "SELECT * FROM dbo.bks_Press where 1=1 ";
            querySql += rui.dbTools.searchTbx("pressCode", this.pressCode, this.cmdPara);
            querySql += rui.dbTools.searchTbx("pressName", this.pressName, this.cmdPara);

            //数据搜索
            this.getPageConfig();
            rui.pagerHelper ph = new rui.pagerHelper(querySql, this.getOrderSql("rowNum", "desc"), this);
            ph.Execute(this.PageSize, this.PageIndex, this);
            this.dataTable = ph.Result;

            //显示的列和列顺序
            this.showColumn = this.getShowColumn();
        }
    }
}