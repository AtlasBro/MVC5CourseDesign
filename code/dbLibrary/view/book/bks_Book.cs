using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db.view
{
    public class bks_Book : rui.pagerBase
    {
        //定义需要的搜索条件
        public string bookTypeCode { get; set; }
        public string pressCode { get; set; }
        public string bookCode { get; set; }
        public string bookName { get; set; }
        public string pressDateStart { get; set; }
        public string pressDateEnd { get; set; }
        public string isSell { get; set; }
        //保存选择来源类型
        public string fromType { get; set; }
        //保存选择来源主键值
        public string fromCode { get; set; }
        public string lessnum { get; set; }

        public string isNeedStock;

        public override void Search()
        {
            this.keyField = "bookCode";
            this.ResourceCode = "bks_Book";
            
            //拼接搜索语句
            string querySql = " select * from sv_bks_Book where 1=1 ";
            if (isNeedStock == "是")
            {
                querySql += " and stockSum <= lessnum ";
            }
            querySql += rui.dbTools.searchDdl("bookTypeCode", this.bookTypeCode, this.cmdPara);
            querySql += rui.dbTools.searchDdl("pressCode", this.pressCode, this.cmdPara);
            querySql += rui.dbTools.searchTbx("bookCode", this.bookCode, this.cmdPara);
            querySql += rui.dbTools.searchTbx("bookName", this.bookName, this.cmdPara);
            querySql += rui.dbTools.searchDate("pressDate", this.pressDateStart, this.pressDateEnd, this.cmdPara);
            querySql += rui.dbTools.searchDdl("isSell", this.isSell, this.cmdPara);

           

            //如果选择来源于进货管理
            if(this.fromType == "bks_BookStock")
            {
                //如果弹出展示的类不一样，则重新定义一个
                this.ResourceCode = "bks_Book";
                //如果同一个进货单，相同书只允许出现一次，则加上如下代码
                string inSql = " SELECT bookCode FROM dbo.bks_BookStockDetail WHERE stockCode='" + this.fromCode + "' ";
                querySql += rui.dbTools.searchNoIn("bookCode", inSql,this.cmdPara);
            }

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
