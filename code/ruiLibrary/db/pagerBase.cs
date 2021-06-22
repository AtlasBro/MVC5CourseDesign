using Aspose.Cells;
using Dapper;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;

namespace rui
{
    /// <summary>
    /// 分页模型类基类
    /// </summary>
    public abstract class pagerBase {
        #region 私有变量
        //分页大小,默认系统配置
        private int _pageSize = 0;
        //页面宽度
        private int _pageWidth = 0;
        //当前页码,默认第一页
        private int _pageIndex = 1;
        //是否执行countSql，执行完毕之后，计算pageCount和recordCount
        private bool _exeCountSql = true;
        //总页数 - 通过countSql的查询结果计算
        private int _pageCount = 1;
        //总记录数
        private int _rowCount = 1;
        //排序字段
        private string _orderField = null;
        //排序方向
        private string _orderWay = "desc";
        //是否需要数据权限
        private bool _isDataPriv = true;
        //资源分页标识
        private string _resourceCode;    
        //数据导出的范围,空不导出,page本页,all搜索的所有数据
        private string _exportRange;
        //SheetName
        private string _sheetName;
        //长格式日期列
        private string _longDateField = "";
        //导出的Excel文件
        private Stream _exportFile;
        //命令参数                                          
        private DynamicParameters _cmdPara = new DynamicParameters();
        //登录用户标识
        private string _loginUserCode;
        //汇总语句
        private string _sumSql;
        //汇总数据范围(page-当前页数据,all-所有查询数据)
        private string _sumRange = "all";
        //操作模式
        private string _opMode;
        #endregion

        /// <summary>
        /// 存放要展示的表格数据
        /// </summary>
        public DataTable dataTable;  

        /// <summary>
        /// 存放默认主键字段
        /// </summary>
        public string keyField = "rowNum";

        /// <summary>
        /// 存放表格列配置数据
        /// </summary>
        public DataTable showColumn;  

        /// <summary>
        /// 汇总查询语句
        /// </summary>
        public string sumSql { get { return _sumSql; } set { _sumSql = value; } }

        /// <summary>
        /// 汇总数据范围
        /// </summary>
        public string sumRange { get { return _sumRange; } set { _sumRange = value; } }

        /// <summary>
        /// 存放汇总列数据
        /// </summary>
        public Dictionary<string, decimal> sumRow = new Dictionary<string, decimal>();

        /// <summary>
        /// 存放查询语句中包含参数的参数值
        /// </summary>
        public DynamicParameters cmdPara { get { return _cmdPara; } set { _cmdPara = value; } }

        /// <summary>
        /// 当前登录用户的标识
        /// </summary>
        public string loginUserCode { get { return _loginUserCode; } set { _loginUserCode = value; } }

        /// <summary>
        /// 分页大小
        /// </summary>
        public int PageSize { get { return _pageSize; } set { _pageSize = value; } }

        /// <summary>
        /// 页面宽度
        /// </summary>
        public int PageWidth { get { return _pageWidth; } set { _pageWidth = value; } }

        /// <summary>
        /// 当前页码
        /// </summary>
        public int PageIndex { get { return _pageIndex; } set { _pageIndex = value; } }

        /// <summary>
        /// 是否执行Count语句
        /// </summary>
        public bool ExeCountSql { get { return _exeCountSql; } set { _exeCountSql = value; } }

        /// <summary>
        /// 总页数
        /// </summary>
        public int PageCount { get { return _pageCount; } set { _pageCount = value; } }

        /// <summary>
        /// 总行数
        /// </summary>
        public int RowCount { get { return _rowCount; } set { _rowCount = value; } }

        /// <summary>
        /// 排序字段名
        /// </summary>
        public string OrderField { get { return _orderField; } set { _orderField = value; } }

        /// <summary>
        /// 排序方式
        /// </summary>
        public string OrderWay { get { return _orderWay; } set { _orderWay = value; } }

        /// <summary>
        /// 资源编码
        /// </summary>
        public string ResourceCode { get { return _resourceCode; } set { _resourceCode = value; } }

        /// <summary>
        /// 是否启用数据权限控制，只是一个bool变量，获取指定的数据范围需要单独写代码
        /// </summary>
        public bool IsDataPriv { get { return _isDataPriv; } set { _isDataPriv = value; }}

        /// <summary>
        /// excel导出数据范围
        /// 空-不导出，page-当前页数据,all-所有查询数据
        /// </summary>
        public string ExportRange { get { return _exportRange; } set { _exportRange = value; } }

        /// <summary>
        /// 导出文件的Sheet名称
        /// </summary>
        public string SheetName { get { return _sheetName; } set { _sheetName = value; } }

        /// <summary>
        /// 需要显示成长日期格式的字段;多个字段用,分割
        /// </summary>
        public string LongDateField { get { return _longDateField; } set { _longDateField = value; } }

        /// <summary>
        /// 视图模型 Update/Detail
        /// </summary>
        public string opMode { get { return _opMode; } set { _opMode = value; } }

        /// <summary>
        /// 搜索方法，需要重写的方法
        /// </summary>
        public abstract void Search();

        /// <summary>
        /// 获取分页大小和页面宽度
        /// 三个配置优先级有低到高
        /// 1、系统资源内可以配置
        /// 2、用户可以自己定义
        /// 3、可以通过属性来设定
        /// <param name="userSessionName">存放用户登录账号的sessionID</param>
        /// </summary>
        public void getPageConfig(string userSessionName = "admin.userCode")
        {
            this.loginUserCode = rui.sessionHelper.getValue(userSessionName);
            getPageConfig(this._resourceCode, userSessionName);
        }

        /// <summary>
        /// 获取分页大小和页面宽度
        /// 三个配置优先级有低到高
        /// 1、系统资源内可以配置
        /// 2、用户可以自己定义
        /// 3、可以通过属性来设定
        /// </summary>
        /// <param name="resourceCode">当列配置码和资源编码不一致的时候用</param>
        /// <param name="userSessionName">存放用户登录账号的sessionID</param>
        public void getPageConfig(string resourceCode, string userSessionName = "")
        {

            //统一配置
            int pageSiseSet = rui.configHelper.pageSize;
            int pageWidthSet = 0;

            //资源配置的数据
            int pagerSizeRes = 0, pageWidthRes = 0;
            //用户定制的数据
            int pageSizeUc = 0, pageWidthUc = 0;
            this.loginUserCode = rui.sessionHelper.getValue(userSessionName);
            using (rui.dbHelper dbHelper = rui.dbHelper.createHelper(null))
            {
                //获取系统资源中配置的分页大小和分页宽度
                string sql = @" SELECT dbo.rbac_Resource.pageWidth as sysPageWidth,dbo.rbac_Resource.pagerCount as sysPagerCount
                            FROM dbo.rbac_Resource
                            WHERE dbo.rbac_Resource.resourceCode=@resourceCode ";
                DataRow row = dbHelper.ExecuteDataRow(sql, new { resourceCode });
                if (row != null)
                {
                    pagerSizeRes = rui.typeHelper.toInt(row["sysPagerCount"]);
                    pageWidthRes = rui.typeHelper.toInt(row["sysPageWidth"]);                     
                }
                //获取用户定制的分页大小和分页宽度
                if (rui.typeHelper.isNotNullOrEmpty(this.loginUserCode))
                {
                    string sqlUc = @" SELECT sys_UCPager.pageSize,sys_UCPager.pageWidth AS pageWidth
                            FROM dbo.sys_UCPager
                            WHERE userCode=@userCode AND resourceCode=@resourceCode ";
                    DataRow rowUc = dbHelper.ExecuteDataRow(sqlUc, new { userCode = this.loginUserCode, resourceCode });
                    if (rowUc != null)
                    {
                        pageSizeUc = rui.typeHelper.toInt(rowUc["pageSize"]);
                        pageWidthUc = rui.typeHelper.toInt(rowUc["pageWidth"]);
                    }
                }
            }
            //按照优先级设定分页大小(统一配置，资源配置，用户配置)
            if (pageSiseSet > 0)
                this.PageSize = pageSiseSet;
            if (pagerSizeRes > 0)
                this.PageSize = pagerSizeRes;
            if (pageSizeUc > 0)
                this.PageSize = pageSizeUc;

            //按照优先级设定页面宽度（统一配置，资源配置，用户配置）
            if (pageWidthSet > 0)
                this.PageWidth = pageWidthSet;
            if (pageWidthRes > 0)
                this.PageWidth = pageWidthRes;
            if (pageWidthUc > 0)
                this.PageWidth = pageWidthUc;
        }

        /// <summary>
        /// 拼接排序语句
        /// </summary>
        /// <param name="orderField">排序字段</param>
        /// <param name="orderWay">排序方式</param>
        /// <param name="prev">前置排序字段  rowID desc </param>
        /// <param name="next">后置排序字段  rowID desc </param>
        /// <returns></returns>
        public string getOrderSql(string orderField, string orderWay,string prev="",string next="")
        {
            if (this.OrderField == null) 
            { 
                this.OrderField = orderField; 
                this.OrderWay = orderWay; 
            }
            if (rui.typeHelper.isNotNullOrEmpty(prev))
                prev = prev + ",";
            if (rui.typeHelper.isNotNullOrEmpty(next))
                next = "," + next;
            string orderSql = $" order by {prev} {this.OrderField} {this.OrderWay} {next} ";
            return orderSql;
        }

        /// <summary>
        /// 通过资源编号获取列配置(采用对象的资源编号)
        /// </summary>
        /// <param name="isUseUser">是否获取用户配置的,loginUserCode需要保存登录用户的值</param>
        /// <returns></returns>
        public DataTable getShowColumn(bool isUseUser = true)
        {
            return getShowColumn(this._resourceCode, isUseUser);
        }

        /// <summary>
        /// 通过资源编号获取资源列配置
        /// </summary>
        /// <param name="resourceCode">资源的标识</param>
        /// <param name="isUseUser">是否获取用户配置的,loginUserCode需要保存登录用户的值</param>
        /// <returns></returns>
        public DataTable getShowColumn(string resourceCode,bool isUseUser=true)
        {
            using (rui.dbHelper dbHelper = rui.dbHelper.createHelper(null))
            {
                string sql = " select * from sys_Column where isShow='1' and resourceCode=@resourceCode order by fixedValue asc,showOrder asc ";
                DataTable table = dbHelper.ExecuteDataTable(sql,new { resourceCode });
                if (table.Rows.Count == 0)
                    rui.excptHelper.throwEx(string.Format("{0}未创建列配置", resourceCode));

                if (isUseUser && rui.typeHelper.isNotNullOrEmpty(this.loginUserCode))
                {
                    string sqlUC = " SELECT fieldCode,fieldName,isShow,showOrder,isOrder,colWidth,isResize,fixedValue,alignType FROM dbo.sys_UCColumn WHERE resourceCode=@resourceCode AND userCode=@userCode ";
                    DataTable tableUc = dbHelper.ExecuteDataTable(sqlUC, new { resourceCode, userCode = this.loginUserCode });
                    foreach (DataRow row in tableUc.Rows)
                    {
                        string fieldCode = row["fieldCode"].ToString();
                        DataRow[] rows = table.Select("fieldCode='" + fieldCode + "'");
                        if (rows.Length > 0)
                        {
                            rows[0]["fieldName"] = row["fieldName"];
                            rows[0]["isShow"] = row["isShow"];
                            rows[0]["showOrder"] = row["showOrder"];
                            rows[0]["isOrder"] = row["isOrder"];
                            rows[0]["colWidth"] = row["colWidth"];
                            rows[0]["isResize"] = row["isResize"];
                            rows[0]["fixedValue"] = row["fixedValue"];
                            rows[0]["alignType"] = row["alignType"];
                        }
                    }
                }
                DataView view = table.DefaultView;
                view.RowFilter = " isShow=true";
                view.Sort = " fixedValue asc,showOrder asc ";
                DataTable mergeTable = view.ToTable();
                _createTableOption(mergeTable);
                return mergeTable;
            }
        }

        /// <summary>
        /// 将查询数据生成为xlsx文件,需要通过下载才能实现最终的导出效果
        /// 当exportType参数不为空时，执行数据导出方法
        /// </summary>
        public MemoryStream ExportToXls()
        {
            //删除操作,操作列
            rui.dbTools.removeShowColumn(showColumn, "操作,选择");
            Workbook wb = new Workbook(FileFormatType.Xlsx);
            Worksheet sheet = wb.Worksheets[0];
            sheet.Name = this.SheetName;

            //添加标题行
            int rowIndex = 0;
            for (int j = 0; j < showColumn.Rows.Count; j++)
            {
                sheet.Cells[rowIndex, j].PutValue(showColumn.Rows[j]["fieldName"]);
            }
            //添加数据行
            rowIndex = 1;
            for (int i = 0; i < this.dataTable.Rows.Count; i++)
            {
                for (int j = 0; j < showColumn.Rows.Count; j++)
                {
                    string colName = showColumn.Rows[j]["fieldCode"].ToString();
                    if (this.LongDateField.Contains(colName))
                    {
                        sheet.Cells[rowIndex + i, j].PutValue(this.dataTable.Rows[i][colName]);
                        Style style = sheet.Cells[rowIndex + i, j].GetStyle();
                        style.Number = 22;
                        sheet.Cells[rowIndex + i, j].SetStyle(style);
                    }
                    else
                        sheet.Cells[rowIndex + i, j].PutValue(this.dataTable.Rows[i][colName]);
                }
            }
            //添加汇总行
            rowIndex = this.dataTable.Rows.Count + 1;
            if(sumRow != null && sumRow.Count>0)
            {
                for (int j = 0; j < showColumn.Rows.Count; j++)
                {
                    string colName = showColumn.Rows[j]["fieldCode"].ToString();
                    if(sumRow.Keys.Contains(colName))
                        sheet.Cells[rowIndex, j].PutValue(showColumn.Rows[j]["fieldName"]);
                }
            }

            //返回文件流
            MemoryStream ms = new MemoryStream();
            wb.Save(ms, SaveFormat.Xlsx);
            wb = null;
            ms.Position = 0;
            return ms;
        }

        /// <summary>
        /// 为layTable表格组件生成表格的列选项数据
        /// </summary>
        /// <param name="table"></param>
        private static void _createTableOption(DataTable table)
        {
            foreach (DataRow row in table.Rows)
            {
                row["optionValue"] = _createColOption(row);
            }
        }

        /// <summary>
        /// 生成列的选项数据
        /// </summary>
        /// <param name="row"></param>
        /// <returns></returns>
        private static string _createColOption(DataRow row)
        {
            StringBuilder sb = new StringBuilder();
            //字段
            sb.Append(string.Format("field:'{0}',", row["fieldCode"]));
            //字段名
            sb.Append(string.Format("title:'{0}',", row["fieldName"]));
            //是否排序
            if (rui.typeHelper.toBoolean(row["isOrder"]) == true)
                sb.Append("sort:true,");
            //列宽
            if (rui.typeHelper.toInt(row["colWidth"]) > 0)
                sb.Append(string.Format("width:{0},", row["colWidth"]));
            //允许拖放大小
            if (rui.typeHelper.toBoolean(row["isResize"]) == false)
                sb.Append("unresize:true,");
            //停靠位置
            if (rui.typeHelper.toString(row["fixedValue"]) != "no")
                sb.Append(string.Format("fixed:'{0}',", row["fixedValue"]));
            //数据对齐方式
            if (rui.typeHelper.toString(row["alignType"]) != "")
                sb.Append(string.Format("align:'{0}',", row["alignType"]));
            string value = sb.ToString();
            return "{" + string.Format("{0}", rui.stringHelper.removeLastChar(value)) + "}";
        }
    }
}
