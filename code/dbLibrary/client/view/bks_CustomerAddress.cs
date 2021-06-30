using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db.client.view
{
    public class bks_CustomerAddress:rui.pagerBase
    {
        public override void Search()
        {
            this.ResourceCode = "bks_CustomerAddress";
            //获取登录名
            string customerCode = rui.sessionHelper.getValue("client.userCode");
            //拼接搜索语句
            string querySql = "SELECT * FROM dbo.bks_CustomerAddress WHERE 1=1";
            querySql += rui.dbTools.searchDdl("customerCode", customerCode);

            //获取数据
            this.getPageConfig();
            rui.pagerHelper ph = new rui.pagerHelper(querySql, this.getOrderSql("rowNum", "asc"), this);
            ph.Execute(this.PageSize, this.PageIndex, this);
            this.dataTable = ph.Result;
            //获取列配置
            this.showColumn = this.getShowColumn();

        }
    }
}
