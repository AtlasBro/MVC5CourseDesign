using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db.view
{
    public class bks_Sell : rui.pagerBase
    {
        //定义需要的搜索条件
        public string bookCode { get; set; }
        
        public string orderDateStart { get; set; }
        public string orderDateEnd { get; set; }
        
        public override void Search()
        {
            this.keyField = "orderCode";
            this.ResourceCode = "bks_Sell";

            //拼接搜索语句
            string querySql = " select * from sv_bks_Sell where 1=1 ";

            querySql += rui.dbTools.searchTbx("bookCode", this.bookCode, this.cmdPara);
            querySql += rui.dbTools.searchDate("orderDate", this.orderDateStart, this.orderDateEnd, this.cmdPara);
            //汇总查询
            this.sumSql = "select sum(subTotal)  as subTotal ,sum(subTotal-costPrice) as remark from sv_bks_Sell";
            this.sumRange = rui.dataRange.all.ToString();
            //盈利查询
            //this.sumSql = "select  as  from sv_bks_Sell";
            //this.sumRange = rui.dataRange.all.ToString();
            //利用搜索语句获取数据
            this.getPageConfig();
            rui.pagerHelper ph = new rui.pagerHelper(querySql, this.getOrderSql("rowNum", "asc"), this);
            ph.Execute(this.PageSize, this.PageIndex, this);
            this.dataTable = ph.Result;
            //获取要展示的列配置
            this.showColumn = this.getShowColumn();
        }
    }
}
