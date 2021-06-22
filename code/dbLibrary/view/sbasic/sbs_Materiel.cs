using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db.view
{
    public class sbs_Materiel : rui.pagerBase
    {
        public string materielCode { get; set; }
        public override void Search()
        {
            //获取页面配置参数
            this.ResourceCode = "sbs_Materiel";

            //搜索语句
            string querySql = @" SELECT * FROM dbo.sbs_Materiel WHERE 1=1 ";
            querySql += rui.dbTools.searchTbx("materielCode", this.materielCode, this.cmdPara);

            //搜索数据
            this.getPageConfig();
            rui.pagerHelper ph = new rui.pagerHelper(querySql, this.getOrderSql("materielCode", "asc"), this);
            ph.Execute(this.PageSize, this.PageIndex, this);
            this.dataTable = ph.Result;

            //显示的列和列顺序
            this.showColumn = this.getShowColumn(this.ResourceCode);
        }
    }
}
