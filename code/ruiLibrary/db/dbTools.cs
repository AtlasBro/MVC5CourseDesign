using Dapper;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace rui
{
    /// <summary>
    /// 数据库辅助方法
    /// </summary>
    public class dbTools
    {
        #region DataTable相关

        /// <summary>
        /// 转换DataTable，转换后所有列都转为非只读字符串
        /// 方便对数据做处理
        /// </summary>
        /// <param name="table"></param>
        /// <returns></returns>
        public static DataTable tranferDataTable(DataTable table)
        {
            DataTable newTable = table.Clone();
            foreach (DataColumn col in newTable.Columns)
            {
                col.DataType = typeof(string);
                col.ReadOnly = false;
                col.MaxLength = 1000;
                col.AllowDBNull = true;  
            }
            rui.dbTools.copyDataTable(table, newTable);
            return newTable;
        }

        /// <summary>
        /// 从DataTable中移除展示的列
        /// </summary>
        /// <param name="table">包含展示列的dataTable对象</param>
        /// <param name="removeColumns">要移出的列名; 通过,分割多个列名</param>
        /// <returns></returns>
        public static DataTable removeShowColumn(DataTable table, string removeColumns)
        {
            List<string> list = rui.dbTools.getList(removeColumns);
            for (int i = table.Rows.Count - 1; i >= 0; i--)
            {
                if (list.Contains(table.Rows[i]["fieldCode"].ToString()))
                {
                    table.Rows.Remove(table.Rows[i]);
                }
            }
            return table;
        }

        /// <summary>
        /// 给DataTable左侧添加序号列
        /// </summary>
        /// <param name="table"></param>
        /// <param name="startIndex">开始值，默认0</param>
        /// <returns></returns>
        public static DataTable insert序号(DataTable table, int startIndex = 0)
        {
            if (table.Columns.Contains("序号"))
                table.Columns.Remove("序号");

            DataColumn column = new DataColumn();
            column.ColumnName = "序号";
            column.DataType = typeof(Int32);
            table.Columns.Add(column);
            table.Columns["序号"].SetOrdinal(0);
            for (int i = 0; i < table.Rows.Count; i++)
            {
                table.Rows[i]["序号"] = i + startIndex + 1;
            }
            return table;
        }

        /// <summary>
        /// 将DataRow数组转成DataTable
        /// </summary>
        /// <param name="rows"></param>
        /// <returns></returns>
        public static DataTable toDataTable(DataRow[] rows)
        {
            if (rows == null || rows.Length == 0)
                return new DataTable();
            //复制DataRow的表结构  
            DataTable table = rows[0].Table.Clone();
            //将DataRow添加到DataTable中 
            foreach (DataRow row in rows)
                table.Rows.Add(row.ItemArray);
            return table;
        }

        /// <summary>
        /// 将dic内容构造成DataTable
        /// </summary>
        /// <param name="dic"></param>
        /// <returns></returns>
        public static DataTable getTableByDic(Dictionary<string, string> dic)
        {
            DataTable table = new DataTable();
            table.Columns.Add("key");
            table.Columns.Add("name");
            foreach (string key in dic.Keys)
            {
                DataRow row = table.NewRow();
                row["key"] = key;
                row["name"] = dic[key];
                table.Rows.Add(row);
            }
            return table;
        }

        /// <summary>
        /// 判断DataTable中指定列中是否存在某个值
        /// </summary>
        /// <param name="table"></param>
        /// <param name="columnName">列名</param>
        /// <param name="value">查找的值（值要求相等）</param>
        /// <returns></returns>
        public static bool checkExist(DataTable table, string columnName, string value)
        {
            if (table.Select($"{columnName}='{value}'").Length > 0)
                return true;
            else
                return false;
        }

        /// <summary>
        /// 将sourTable的内容复制到descTable中,列名要保存一直
        /// </summary>
        /// <param name="sourTable">原表数据为空，将目标表内包含的字段复制过来</param>
        /// <param name="descTable">前台页面展示用的表格</param>
        /// <returns></returns>
        public static DataTable copyDataTable(DataTable sourTable, DataTable descTable)
        {
            descTable = setAllowNull(descTable);
            foreach (DataRow row in sourTable.Rows)
            {
                DataRow rowDesc = descTable.NewRow();
                foreach (DataColumn col in sourTable.Columns)
                {
                    if (descTable.Columns.Contains(col.ColumnName))
                        rowDesc[col.ColumnName] = row[col.ColumnName];
                }
                descTable.Rows.Add(rowDesc);
            }
            return descTable;
        }

        /// <summary>
        /// DataTable进行合并（审批流，不同审批人员合并的时候调用）
        /// 将2合并到1,并返回（2中有的1中没有则合并过来）
        /// </summary>
        /// <param name="table1"></param>
        /// <param name="table2"></param>
        /// <param name="keyName">判断是否重复的主键字段名称</param>
        /// <returns></returns>
        public static DataTable margeDataTable(DataTable table1, DataTable table2, string keyName)
        {
            foreach (DataRow row in table2.Rows)
            {
                if (table1.Select(string.Format(" {0}='{1}' ", keyName, row[keyName])).Length == 0)
                {
                    table1.ImportRow(row);
                }
            }
            return table1;
        }

        /// <summary>
        /// 处理DataTable内的日期格式，长格式换成短格式
        /// </summary>
        /// <param name="table"></param>
        /// <param name="exceptFieldName">需要排除的列，多个列用,分割</param>
        /// <returns></returns>
        public static DataTable dateFormat(DataTable table, string exceptFieldName = "")
        {
            List<string> dateColumn = new List<string>();
            //获取所有日期列
            foreach (DataColumn column in table.Columns)
            {
                if (column.DataType == typeof(DateTime) && exceptFieldName.Contains(column.ColumnName) == false)
                {
                    dateColumn.Add(column.ColumnName);
                }
            }
            //复制列
            foreach (string item in dateColumn)
            {
                string columnName = item;
                if (table.Columns.Contains(columnName))
                {
                    int index = table.Columns.IndexOf(table.Columns[columnName]);
                    table.Columns[index].ColumnName = columnName + "bak";
                    DataColumn newColumn = new DataColumn(columnName, typeof(string));
                    table.Columns.Add(newColumn);
                    table.Columns[columnName].SetOrdinal(index + 1);
                }
            }
            //列赋值
            for (int i = 0; i < table.Rows.Count; i++)
            {
                foreach (string item in dateColumn)
                {
                    table.Rows[i][item] = rui.typeHelper.toDateTimeString(table.Rows[i][item + "bak"]);
                }
            }
            //移除列
            foreach (string item in dateColumn)
            {
                table.Columns.Remove(item + "bak");
            }
            return table;
        }

        /// <summary>
        /// 设置表格列可以为空
        /// </summary>
        /// <param name="table">设置DataTable的列值允许为Null值</param>
        /// <returns></returns>
        public static DataTable setAllowNull(DataTable table)
        {
            foreach (DataColumn col in table.Columns)
                col.AllowDBNull = true;
            table.AcceptChanges();
            return table;
        }

        /// <summary>
        /// 获取DataRow中某字段的值
        /// </summary>
        /// <param name="row"></param>
        /// <param name="fieldName">字段名</param>
        /// <param name="isThrow">如果row为空，是否抛出异常</param>
        /// <returns></returns>
        public static string getRowValue(DataRow row, string fieldName, bool isThrow = true)
        {
            if (row == null)
            {
                if (isThrow)
                    rui.excptHelper.throwEx("空的数据行");
            }
            else
                return row[fieldName].ToString();
            return "";
        }

        #endregion

        #region in表达式拼接

        /// <summary>
        /// 将集合元素拼接成in表达式
        /// </summary>
        /// <param name="list">集合对象</param>
        /// <param name="handleEmpty">当集合为空时，是否默认返回''</param>
        /// <returns></returns>
        public static string getInExpression(List<string> list, bool handleEmpty = true)
        {
            string result = "";
            foreach (string item in list)
                result += string.Format("'{0}',", item);
            if (result.Length > 0)
                return result.Substring(0, result.Length - 1);
            if (result.Length == 0 && handleEmpty)
                return "''";
            return "";
        }

        /// <summary>
        /// 将DataTable指定列的值拼接成in表达式
        /// </summary>
        /// <param name="table">DataTable数据</param>
        /// <param name="columnName">列名</param>
        /// <param name="handleEmpty">当集合为空时，是否默认返回''</param>
        /// <returns></returns>
        public static string getInExpression(DataTable table, string columnName, bool handleEmpty = true)
        {
            string result = "";
            foreach (DataRow row in table.Rows)
            {
                result += string.Format("'{0}',", row[columnName].ToString());
            }
            if (result.Length > 0)
                return result.Substring(0, result.Length - 1);
            if (result.Length == 0 && handleEmpty)
                return "''";
            return "";
        }

        /// <summary>
        /// 将,分割的字符串拼接成in表达式
        /// 例如：a,b,c,
        /// 返回：'a','b','c'
        /// </summary>
        /// <param name="value">,分割的字符串</param>
        /// <param name="handleEmpty">当集合为空时，是否默认返回''</param>
        /// <returns></returns>
        public static string getInExpression(string value, bool handleEmpty = true)
        {
            return rui.dbTools.getInExpression(rui.dbTools.getList(value), handleEmpty);
        }

        /// <summary>
        /// 将DataTable指定列的值拼接成展示的表达式
        /// 返回形式：a,b,c
        /// </summary>
        /// <param name="table">DataTable数据</param>
        /// <param name="columnName">列名</param>
        /// <param name="splitTag">分割符，默认,</param>
        /// <returns></returns>
        public static string getShowExpression(DataTable table, string columnName, char splitTag = ',')
        {
            string result = "";
            foreach (DataRow row in table.Rows)
            {
                result += string.Format("{0}{1}", row[columnName].ToString(), splitTag);
            }
            return rui.stringHelper.removeLastChar(result);
        }

        /// <summary>
        /// 将集合元素拼接长展示的表达式,例如：a,b,c,
        /// </summary>
        /// <param name="list">集合</param>
        /// <param name="splitTag">分隔符,默认,</param>
        /// <returns></returns>
        public static string getShowExpression(List<string> list, char splitTag = ',')
        {
            string result = "";
            foreach (string item in list)
                result += string.Format("{0}{1}", item, splitTag);
            return rui.stringHelper.removeLastChar(result);
        }

        #endregion

        #region Dapper参数辅助类

        /// <summary>
        /// 返回like 参数支持的参数值形式
        /// userName like @userName
        /// @userName 返回的值形式为：%数据值%
        /// </summary>
        /// <param name="value"></param>
        /// <returns></returns>
        public static string getDpLike(string value)
        {
            return string.Format("%{0}%", value);
        }

        /// <summary>
        /// 返回in 参数支持的参数值形式
        /// rowID in @rowID
        /// @rowID 返回的值形式为: 集合对象。
        /// </summary>
        /// <param name="values">,分割的值</param>
        /// <returns></returns>
        public static List<string> getDpList(string values)
        {
            if (values.IndexOf("'") >= 0)
                return rui.dbTools.getListByInExpr(values);
            else
                return rui.dbTools.getList(values);
        }

        /// <summary>
        /// 获取in后边的表达式
        /// </summary>
        /// <param name="table">表格数据</param>
        /// <param name="columnName">列名称</param>
        /// <returns></returns>
        public static List<string> getDpList(DataTable table, string columnName)
        {
            return rui.dbTools.getList(table, columnName);
        }

        #endregion

        //-------------------------------------处理搜索语句

        /// <summary>
        /// 拼接 = 查询
        /// </summary>
        /// <param name="fieldName">字段名/参数名</param>
        /// <param name="fieldValue">字段值</param>
        /// <param name="cmdPara">动态参数</param>
        /// <returns></returns>
        public static string searchDdl(string fieldName, string fieldValue, DynamicParameters cmdPara = null)
        {
            string result = "";
            if (cmdPara == null)
            {
                if (string.IsNullOrWhiteSpace(fieldValue) == false && fieldValue != rui.configHelper.va请选择Value)
                    result = string.Format(" and {0} = '{1}' ", fieldName, fieldValue.Trim());
            }
            else
            {
                if (string.IsNullOrWhiteSpace(fieldValue) == false && fieldValue != rui.configHelper.va请选择Value)
                {
                    result = string.Format(" and {0} = @{0} ", fieldName);
                    cmdPara.Add(fieldName, fieldValue);
                }
            }
            return result;
        }

        /// <summary>
        /// 拼接 like 模糊查询 
        /// </summary>
        /// <param name="fieldName">字段名/参数名</param>
        /// <param name="fieldValue">字段值</param>
        /// <param name="cmdPara">动态参数</param>
        /// <returns></returns>
        public static string searchTbx(string fieldName, string fieldValue, DynamicParameters cmdPara = null)
        {
            string result = "";
            if (cmdPara == null)
            {
                if (string.IsNullOrWhiteSpace(fieldValue) == false)
                    result = string.Format(" and {0} like '%{1}%' ", fieldName, fieldValue.Trim());
            }
            else
            {
                if (string.IsNullOrWhiteSpace(fieldValue) == false)
                {
                    result = string.Format(" and {0} like @{0} ", fieldName);
                    cmdPara.Add(fieldName, getDpLike(fieldValue));
                }
            }
            return result;
        }

        /// <summary>
        /// 字段值 包含 值
        /// </summary>
        /// <param name="fieldName">搜索字段/参数名</param>
        /// <param name="subValue">子串</param>
        /// <param name="cmdPara">动态参数</param>
        /// <returns></returns>
        public static string searchContainValue(string fieldName, string subValue, DynamicParameters cmdPara = null)
        {
            string result = "";
            if (cmdPara == null)
            {
                if (string.IsNullOrWhiteSpace(subValue) == false)
                    result = string.Format(" and charindex('{0}',{1})>0 ", subValue.Trim(), fieldName);
            }
            else
            {
                if (string.IsNullOrWhiteSpace(subValue) == false)
                {
                    result = string.Format(" and charindex(@{0},{0})>0 ", fieldName);
                    cmdPara.Add(fieldName, subValue);
                }
            }
            return result;
        }

        /// <summary>
        /// 值 包含 字段值
        /// </summary>
        /// <param name="fieldName">搜索字段/参数名</param>
        /// <param name="parentValue">父串</param>
        /// <param name="cmdPara">动态参数</param>
        /// <returns></returns>
        public static string searchContainField(string fieldName, string parentValue, DynamicParameters cmdPara = null)
        {
            string result = "";
            if (cmdPara == null)
            {
                if (string.IsNullOrWhiteSpace(parentValue) == false)
                    result = string.Format(" and charindex({0},'{1}')>0 ", fieldName, parentValue.Trim());
            }
            else
            {
                if (string.IsNullOrWhiteSpace(parentValue) == false)
                {
                    result = string.Format(" and charindex({0},@{0})>0 ", fieldName);
                    cmdPara.Add(fieldName, parentValue);
                }
            }
            return result;
        }

        /// <summary>
        /// 拼接 in 查询
        /// 支持两种情况
        /// 1)子查询语句，如果子查询语句中包含参数需要通过cmdPara单独添加。
        /// 2)inExpr;
        /// </summary>
        /// <param name="fieldName">字段名/参数名</param>
        /// <param name="inValue">in表达式</param>
        /// <param name="cmdPara">动态参数</param>
        public static string searchIn(string fieldName, string inValue, DynamicParameters cmdPara = null)
        {
            string result = "";
            if (cmdPara == null)
            {
                if (string.IsNullOrWhiteSpace(inValue) == false)
                    result = string.Format(" and {0} in ({1}) ", fieldName, inValue.Trim());
            }
            else
            {
                if (string.IsNullOrWhiteSpace(inValue) == false)
                {
                    if (inValue.IndexOf("select", StringComparison.OrdinalIgnoreCase) > 0)
                    {
                        result = string.Format(" and {0} in ({1}) ", fieldName, inValue.Trim());
                    }
                    else
                    {
                        result = string.Format(" and {0} in @{0} ", fieldName);
                        cmdPara.Add(fieldName, getDpList(inValue));
                    }
                }
            }
            return result;
        }

        /// <summary>
        /// 拼接 not in 查询
        /// 支持两种情况
        /// 1)子查询语句，如果子查询语句中包含参数需要通过cmdPara单独添加。
        /// 2)inExpr;
        /// </summary>
        /// <param name="fieldName">字段名/参数名</param>
        /// <param name="inValue">in表达式</param>
        /// <param name="cmdPara">动态参数</param>
        public static string searchNoIn(string fieldName, string inValue, DynamicParameters cmdPara = null)
        {
            string result = "";
            if (cmdPara == null)
            {
                if (string.IsNullOrWhiteSpace(inValue) == false && inValue.Length > 2)
                    result = string.Format(" and {0} not in ({1}) ", fieldName, inValue.Trim());
            }
            else
            {
                if (string.IsNullOrWhiteSpace(inValue) == false && inValue.Length > 2)
                {
                    if (inValue.IndexOf("select", StringComparison.OrdinalIgnoreCase) > 0)
                        result = string.Format(" and {0} not in ({1}) ", fieldName, inValue.Trim());
                    else
                    {
                        result = string.Format(" and {0} not in @{0} ", fieldName);
                        cmdPara.Add(fieldName, getDpList(inValue));
                    }
                }
            }
            return result;
        }

        /// <summary>
        /// 拼接时间搜索
        /// </summary>
        /// <param name="fieldName">字段名/参数名</param>
        /// <param name="dateStart">开始时间</param>
        /// <param name="dataEnd">结果时间</param>
        /// <param name="cmdPara">动态参数</param>
        /// <returns></returns>
        public static string searchDate(string fieldName, string dateStart, string dataEnd, DynamicParameters cmdPara = null)
        {
            string result = "";
            if (cmdPara == null)
            {
                if (string.IsNullOrWhiteSpace(dateStart) == false)
                    result += string.Format(" and {0} >= '{1}' ", fieldName, rui.typeHelper.getDayStart(dateStart.Trim()));
                if (string.IsNullOrWhiteSpace(dataEnd) == false)
                    result += string.Format(" and {0} <= '{1}' ", fieldName, rui.typeHelper.getDayEnd(dataEnd.Trim()));
            }
            else
            {
                if (string.IsNullOrWhiteSpace(dateStart) == false)
                {
                    result += string.Format(" and {0} >= @{0}Start ", fieldName);
                    cmdPara.Add(fieldName + "Start", rui.typeHelper.getDayStart(dateStart.Trim()));
                }
                if (string.IsNullOrWhiteSpace(dataEnd) == false)
                {
                    result += string.Format(" and {0} <= @{0}End ", fieldName);
                    cmdPara.Add(fieldName + "End", rui.typeHelper.getDayEnd(dataEnd.Trim()));
                }
            }
            return result;
        }

        /// <summary>
        /// 数据范围搜索
        /// </summary>
        /// <param name="fieldName">字段名/参数名</param>
        /// <param name="startValue">开始值</param>
        /// <param name="endValue">结束值</param>
        /// <param name="cmdPara">动态参数</param>
        /// <returns></returns>
        public static string searchRange(string fieldName, string startValue, string endValue, DynamicParameters cmdPara = null)
        {
            string result = "";
            if (cmdPara == null)
            {
                if (string.IsNullOrWhiteSpace(startValue) == false)
                    result += string.Format(" and {0} >= '{1}' ", fieldName, startValue.Trim());
                if (string.IsNullOrWhiteSpace(endValue) == false)
                    result += string.Format(" and {0} <= '{1}' ", fieldName, endValue.Trim());
            }
            else
            {
                if (string.IsNullOrWhiteSpace(startValue) == false)
                {
                    result += string.Format(" and {0} >= @{0}Start ", fieldName);
                    cmdPara.Add(fieldName + "Start", startValue.Trim());
                }
                if (string.IsNullOrWhiteSpace(endValue) == false)
                {
                    result += string.Format(" and {0} <= @{0}End ", fieldName);
                    cmdPara.Add(fieldName + "End", endValue.Trim());
                }
            }
            return result;
        }

        /// <summary>
        /// 拼接 like 模糊查询  - 外库导入查询 ===
        /// </summary>
        /// <param name="fieldName">字段名</param>
        /// <param name="fieldValue">字段值</param>
        /// <param name="dic">保存拼接结果</param>
        /// <returns></returns>
        public static void searchTbx(string fieldName, string fieldValue, Dictionary<string, string> dic)
        {
            if (String.IsNullOrWhiteSpace(fieldValue) == false)
                dic.Add(fieldName, string.Format(" like '%{0}%' ", fieldValue.Trim()));
        }

        /// <summary>
        /// 拼接 = 查询  - 外库导入查询 ===
        /// </summary>
        /// <param name="fieldName">字段名</param>
        /// <param name="fieldValue">字段值</param>
        /// <param name="dic">保存拼接结果</param>
        public static void searchDdl(string fieldName, string fieldValue, Dictionary<string, string> dic)
        {
            if (string.IsNullOrWhiteSpace(fieldValue) == false && fieldValue != rui.configHelper.va请选择Value)
                dic.Add(fieldName, string.Format(" ='{0}' ", fieldValue.Trim()));
        }

        /// <summary>
        /// 获取查询语句中Where语句表达式,包含 where 关键字
        /// 如果包含order 语句 需要去除
        /// </summary>
        /// <param name="querySql">查询语句</param>
        /// <returns></returns>
        public static string getWhereExpr(string querySql)
        {
            string sql = querySql.Substring(querySql.IndexOf(" where ", StringComparison.OrdinalIgnoreCase));
            if (sql.IndexOf(" order ", StringComparison.OrdinalIgnoreCase) > 0)
                sql = sql.Substring(0, sql.IndexOf(" order ", StringComparison.OrdinalIgnoreCase));
            return sql;
        }

        #region 集合操作

        /// <summary>
        /// 将in表达式转换为List
        /// </summary>
        /// <param name="inExpr">类似：'1','2',</param>
        /// <returns></returns>
        public static List<string> getListByInExpr(string inExpr)
        {
            List<string> list = (from a in inExpr.Split(',')
                                 where a.Length > 0
                                 select a).ToList<string>();
            List<string> result = new List<string>();
            foreach (string val in list)
            {
                result.Add(val.Substring(1, val.Length - 2));
            }
            return result;
        }

        /// <summary>
        /// 将字符串内容 添加到集合中
        /// </summary>
        /// <param name="value">包含分隔符的字符串</param>
        /// <param name="splitTag">默认,</param>
        /// <returns></returns>
        public static List<string> getList(string value, char splitTag = ',')
        {
            if (String.IsNullOrWhiteSpace(value))
                return new List<string>();

            List<string> list = (from a in value.Split(splitTag)
                                 where a.Length > 0
                                 select a).ToList<string>();
            return list;
        }

        /// <summary>
        /// 将DataTable指定列的值添加到集合中，并返回
        /// </summary>
        /// <param name="table"></param>
        /// <param name="columnName">列名</param>
        /// <returns></returns>
        public static List<string> getList(DataTable table, string columnName)
        {
            if (table == null)
                return new List<string>();

            List<string> list = new List<string>();
            foreach (DataRow row in table.Rows)
            {
                if (list.Contains(row[columnName].ToString()) == false)
                {
                    list.Add(row[columnName].ToString());
                }
            }
            return list;
        }

        /// <summary>
        /// 向集合中添加元素
        /// </summary>
        /// <typeparam name="T">元素的类型</typeparam>
        /// <param name="list">集合</param>
        /// <param name="item">元素</param>
        /// <returns></returns>
        public static List<T> addList<T>(List<T> list, T item)
        {
            if (list.Contains(item) == false)
                list.Add(item);
            return list;
        }

        /// <summary>
        /// 两个集合合并
        /// </summary>
        /// <typeparam name="T">集合元素类型</typeparam>
        /// <param name="list1">集合1</param>
        /// <param name="list2">集合2</param>
        /// <returns></returns>
        public static List<T> unionList<T>(List<T> list1, List<T> list2)
        {
            List<T> list = new List<T>();
            foreach (var item in list1)
                addList<T>(list, item);

            foreach (var item in list2)
                addList<T>(list, item);

            return list;
        }

        /// <summary>
        /// 两个集合差运算，从List1中排除List2中包含的元素
        /// </summary>
        /// <typeparam name="T">元素类型</typeparam>
        /// <param name="list1">集合1</param>
        /// <param name="list2">集合2</param>
        /// <returns></returns>
        public static List<T> exceptList<T>(List<T> list1, List<T> list2)
        {
            List<T> list = new List<T>();
            foreach (var item in list1)
                addList<T>(list, item);

            foreach (var item in list2)
                list.Remove(item);

            return list;
        }

        /// <summary>
        /// 向键值对集合添加元素
        /// </summary>
        /// <typeparam name="K">键的类型</typeparam>
        /// <typeparam name="V">值的类型</typeparam>
        /// <param name="dic">集合</param>
        /// <param name="key">键</param>
        /// <param name="value">值</param>
        /// <returns></returns>
        public static Dictionary<K, V> addDic<K, V>(Dictionary<K, V> dic, K key, V value)
        {
            if (dic.ContainsKey(key) == false)
                dic.Add(key, value);
            return dic;
        }

        #endregion

        /// <summary>
        /// 检查rows是否有数据
        /// 如果有数据，判断第一行fieldName的值是否等于fieldValue
        /// 如果等于，则抛出异常
        /// </summary>
        /// <param name="rows">DataRow数组</param>
        /// <param name="fieldName">要判断的字段名</param>
        /// <param name="fieldValue">要判断的字段值</param>
        /// <param name="errorMsg">等于时抛出的错误</param>
        public static void checkRowFieldValue(DataRow[] rows, string fieldName, string fieldValue, string errorMsg)
        {
            if (rows.Length > 0)
            {
                if (rui.typeHelper.toString(rows[0][fieldName]) == fieldValue)
                {
                    rui.excptHelper.throwEx(errorMsg);
                }
            }
        }

        /// <summary>
        /// 检查rows是否有数据
        /// 如果有数据，判断第一行fieldName的值是否等于fieldValue
        /// 如果不等于，则抛出异常
        /// </summary>
        /// <param name="rows">DataRow数组</param>
        /// <param name="fieldName">要判断的字段名</param>
        /// <param name="fieldValue">要判断的字段值</param>
        /// <param name="errorMsg">不等于时抛出的错误</param>
        public static void checkRowFieldNotValue(DataRow[] rows, string fieldName, string fieldValue, string errorMsg)
        {
            if (rows.Length > 0)
            {
                if (rui.typeHelper.toString(rows[0][fieldName]) != fieldValue)
                {
                    rui.excptHelper.throwEx(errorMsg);
                }
            }
        }

        /// <summary>
        /// 获取批量操作的显示消息-带异常提醒
        /// </summary>
        /// <param name="opName">操作名称</param>
        /// <param name="rowCount">批量操作的数据行数</param>
        /// <param name="errorDic">出错主键集合：Key:出错提醒键值，Value:出错描述</param>
        /// <returns></returns>
        public static string getBatchMsg(string opName, int rowCount, Dictionary<string, string> errorDic)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append(string.Format("{0}执行完成,共操作了{1}条，成功了{2}条", opName, rowCount, rowCount - errorDic.Count));
            if (errorDic.Count > 0)
            {
                sb.Insert(0, "wait:");
                sb.Append("<br/>以下主键不成功<br/>");
                foreach (string key in errorDic.Keys)
                    sb.Append(string.Format("主键：{0}；错误：{1}<br/>", key, errorDic[key]));
            }
            return sb.ToString();
        }
    }
}
