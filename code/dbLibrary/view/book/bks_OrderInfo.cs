using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db.view
{
    public class bks_OrderInfo : rui.pagerBase
    {
        //定义需要的搜索条件
        public string orderCode { get; set; }
        public string customerCode { get; set; }
        public string addressCode { get; set; }
        public string orderDate { get; set; }
        public string totalPrice { get; set; }
        public string status { get; set; }
        public string employeeCode { get; set; }
        public string remark { get; set; }
        public override void Search()
        {
            this.keyField = "orderCode";
            this.ResourceCode = "bks_OrderInfo";

            //拼接搜索语句
            string querySql = " select * from sv_bks_OrderInfo  where 1=1 ";
            querySql += rui.dbTools.searchDdl("customerCode", this.customerCode, this.cmdPara);
            querySql += rui.dbTools.searchDdl("addressCode", this.addressCode, this.cmdPara);
            querySql += rui.dbTools.searchTbx("totalPrice", this.totalPrice, this.cmdPara);
            querySql += rui.dbTools.searchTbx("orderDate", this.orderDate, this.cmdPara);
            querySql += rui.dbTools.searchDdl("status", this.status, this.cmdPara);

            //利用搜索语句获取数据
            this.getPageConfig();
            rui.pagerHelper ph = new rui.pagerHelper(querySql, this.getOrderSql("rowID", "asc"), this);
            ph.Execute(this.PageSize, this.PageIndex, this);
            this.dataTable = ph.Result;
            //获取要展示的列配置
            this.showColumn = this.getShowColumn();
        }
    }
}
