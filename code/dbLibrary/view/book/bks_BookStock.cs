using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db.view
{
    /// <summary>
    /// view-入库主表表
    /// wzrui 2020-02-19
    /// </summary>
    public class bks_BookStock : rui.pagerBase
    {
        public string stockCode { get; set; }
        public string stockName { get; set; }
        public override void Search()
        {
            this.keyField = "rowID";
            this.ResourceCode = "bks_BookStock";
		
            //搜索语句
            string querySql = "SELECT * FROM dbo.sv_bks_BookStock where 1=1 ";
            querySql += rui.dbTools.searchTbx("stockCode", this.stockCode, this.cmdPara);
            querySql += rui.dbTools.searchTbx("stockName", this.stockName, this.cmdPara);

            //数据搜索
            this.getPageConfig();
            rui.pagerHelper ph = new rui.pagerHelper(querySql, this.getOrderSql("rowID", "desc"), this);
            ph.Execute(this.PageSize, this.PageIndex, this);
            this.dataTable = ph.Result;

            //显示的列和列顺序
            this.showColumn = this.getShowColumn();
        }
    }
}