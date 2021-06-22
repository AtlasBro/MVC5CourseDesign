using db.bll;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db.view
{
    /// <summary>
    /// 分页定制 wzrui
    /// </summary>
    public class pageConfig : rui.pagerBase
    {
        public int cPageSize { get; set; }
        public int cPageWidth { get; set; }

        public override void Search()
        {         
            this.PageSize = 1000;

            //搜索语句
            string querySql = @" SELECT rowNum, rowID, fieldCode,fieldName,fieldName as cFieldName,isShow,showOrder,isOrder,colWidth,isResize,fixedValue,alignType FROM dbo.sys_Column WHERE isShow='1' ";
            querySql += rui.dbTools.searchDdl("resourceCode", this.ResourceCode, this.cmdPara);

            //搜索数据
            rui.pagerHelper ph = new rui.pagerHelper(querySql, this.getOrderSql("showOrder", "asc"), this);
            ph.Execute(this.PageSize, this.PageIndex, this);

            //合并用户的数据列定义数据
            efHelper ef = new efHelper();
            DataTable tableSys = ph.Result;
            {
                string sqlCustomer = " SELECT fieldCode,fieldName,isShow,showOrder,isOrder,colWidth,isResize,fixedValue,alignType FROM dbo.sys_UCColumn WHERE resourceCode='" + this.ResourceCode + "' AND userCode='" + db.bll.loginAdminHelper.getUserCode() + "' ";
                DataTable tableCustomer = ef.ExecuteDataTable(sqlCustomer);
                foreach(DataRow row in tableCustomer.Rows)
                {
                    DataRow[] rowSys = tableSys.Select("fieldCode='" + row["fieldCode"].ToString() + "' ");
                    if (rowSys.Length > 0)
                    {
                        rowSys[0]["CFieldName"] = row["fieldName"];
                        rowSys[0]["isShow"] = row["isShow"];
                        rowSys[0]["showOrder"] = row["showOrder"];
                        rowSys[0]["isOrder"] = row["isOrder"];
                        rowSys[0]["colWidth"] = row["colWidth"];
                        rowSys[0]["isResize"] = row["isResize"];
                        rowSys[0]["fixedValue"] = row["fixedValue"];
                        rowSys[0]["alignType"] = row["alignType"];
                    }
                }
            }
            //获取系统的配置数据
            {
                string sqlPage = " SELECT pageWidth,pagerCount FROM rbac_Resource WHERE resourceCode=@resourceCode ";
                DataRow row = ef.ExecuteDataRow(sqlPage, new { resourceCode = this.ResourceCode });
                if (row != null)
                {
                    this.cPageWidth = rui.typeHelper.toInt(row["pageWidth"]);
                    this.cPageSize = rui.typeHelper.toInt(row["pagerCount"]);
                    if (this.cPageSize == 0)
                        this.cPageSize = rui.configHelper.pageSize;
                }
            }
            //获取用户的配置数据
            {
                string sqlPage = " SELECT pageSize,pageWidth FROM sys_UCPager WHERE resourceCode=@resourceCode AND userCode=@userCode ";
                DataRow row = ef.ExecuteDataRow(sqlPage, new { resourceCode = this.ResourceCode, userCode = db.bll.loginAdminHelper.getUserCode() });

                if (row != null)
                {
                    if (rui.typeHelper.toInt(row["pageSize"])>0)
                        this.cPageSize = rui.typeHelper.toInt(row["pageSize"]);
                    if (rui.typeHelper.toInt(row["pageWidth"]) > 0)
                        this.cPageWidth = rui.typeHelper.toInt(row["pageWidth"]);
                }
            }
            DataView view = tableSys.DefaultView;
            view.Sort = "showOrder asc";

            this.dataTable = view.ToTable() ;

            //显示的列和列顺序
            this.showColumn = this.getShowColumn("sys_Column");
        }
    }
}
