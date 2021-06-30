using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db.client.view
{
    public class bks_ShoppingTrolley:rui.pagerBase
    {

        public override void Search()
        {
            this.keyField = "rowID";
            this.ResourceCode = "bks_ShoppingTrolley";

            //获取登录用户名
            string customerCode = rui.sessionHelper.getValue("client.userCode");
            
            //搜索语句
            string querySql = "SELECT * FROM dbo.sv_bks_ShoppingTrolley WHERE 1=1";
            querySql += rui.dbTools.searchIn("customerCode", customerCode, this.cmdPara);
           
            //汇总
            this.sumSql = @"SELECT SUM(subPrice) AS subPrice FROM dbo.sv_bks_ShoppingTrolley";
            this.sumRange = rui.dataRange.all.ToString();
            
            //利用搜索语句获取数据
            this.getPageConfig();
            rui.pagerHelper ph = new rui.pagerHelper(querySql, this.getOrderSql("rowNum", "asc"), this);
            ph.Execute(this.PageSize, this.PageIndex, this);
            this.dataTable = ph.Result;
            //列配置
            this.showColumn = this.getShowColumn();
        }
    }
}
