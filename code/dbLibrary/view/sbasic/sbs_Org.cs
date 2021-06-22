using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db.view
{
    /// <summary>
    /// 组织表
    /// </summary>
    public class sbs_Org : rui.pagerBase
    {
        public override void Search()
        {
            this.ResourceCode = "sbs_Org";

            //搜索语句
            string querySql = @" SELECT * FROM dbo.sbs_Org WHERE 1=1 ";

            //搜索数据
            this.getPageConfig();
            rui.pagerHelper ph = new rui.pagerHelper(querySql, this.getOrderSql("orgCode", "asc"), this);
            ph.Execute(this.PageSize, this.PageIndex, this);
            this.dataTable = ph.Result;

            //显示的列和列顺序
            this.showColumn = this.getShowColumn();
        }
    }
}
