using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db.view
{
    /// <summary>
    /// view-图书类别表
    /// wzrui 2020-02-20
    /// </summary>
    public class bks_BookType : rui.pagerBase
    {
        public string bookTypeCode { get; set; }
        public string bookTypeName { get; set; }
        public override void Search()
        {
            this.keyField = "rowNum";
            this.ResourceCode = "bks_BookType";

		
            //搜索语句
            string querySql = "SELECT * FROM dbo.bks_BookType where 1=1 ";
            querySql += rui.dbTools.searchTbx("bookTypeCode", this.bookTypeCode, this.cmdPara);
            querySql += rui.dbTools.searchTbx("bookTypeName", this.bookTypeName, this.cmdPara);

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