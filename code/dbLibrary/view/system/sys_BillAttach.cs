using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db.view
{
    /// <summary>
    /// 单据附件 - 展示已有的附件
    /// </summary>
    public class sys_BillAttach : rui.pagerBase
    {
        //关联单据类型，和资源编号保持一致
        public string attachResourceCode { get; set; }
        //关联单据编号
        public string attachKeyCode { get; set; }
        //操作模式
        public string attachOpMode { get; set; }

        public override void Search()
        {
            this.ResourceCode = "sys_BillAttach";

            //搜索语句
            string querySql = @" SELECT * FROM sv_sys_BillAttach WHERE 1=1 ";
            querySql += rui.dbTools.searchDdl("relatedResourceCode", this.attachResourceCode, this.cmdPara);
            querySql += rui.dbTools.searchDdl("relatedKeyCode", this.attachKeyCode, this.cmdPara);

            //搜索数据
            rui.pagerHelper ph = new rui.pagerHelper(querySql, this.getOrderSql("uploadDateTime", "desc"), this);
            ph.Execute(this.PageSize, this.PageIndex, this);
            this.dataTable = ph.Result;

            this.dataTable = rui.dbTools.insert序号(this.dataTable);

            //显示的列和列顺序
            this.showColumn = this.getShowColumn(false);
        }
    }
}
