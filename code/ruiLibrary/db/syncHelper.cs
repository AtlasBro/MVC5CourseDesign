using System;
using System.Collections.Generic;
using System.Data;

namespace rui
{
    /// <summary>
    /// 项目中用来进行同步的方法
    /// </summary>
    public class syncHelper
    {
        /// <summary>
        /// 检查数据存在是否使用外库
        /// </summary>
        public static bool checkExistUse外库 = true;

        /// <summary>
        /// 同步所有表的数据
        /// 周期性的同步导入日志，保证数据的一致性 
        /// </summary>
        public static void periodicalUpdateImportLogForPurchaseSys()
        {
            using (rui.dbHelper dbHelper = rui.dbHelper.createHelper(null))
            {
                using (rui.dbHelper dbHelperForI6 = rui.dbHelper.createI6Helper(null))
                {
                    //正向检查
                    try
                    {
                        //查出所有有导入日志的表
                        string importTableSql = "SELECT sysTableName,sysInsertTableName,sourceTableName,syskeyFieldName FROM dbo.sys_DataSyncInterface where isPrimary = '1' ";
                        DataTable importTableList = dbHelper.ExecuteDataTable(importTableSql);

                        //对每一张表进行处理
                        foreach (DataRow row in importTableList.Rows)
                        {
                            Dictionary<string, object> sqlList = new Dictionary<string, object>();
                            //获取相关的配置数据
                            string sysTableName = row["sysTableName"].ToString();
                            string sysInsertTableName = row["sysInsertTableName"].ToString();
                            string sourceTableName = row["sourceTableName"].ToString();
                            string syskeyFieldName = row["syskeyFieldName"].ToString();

                            //查询出当前表内所有的数据
                            string dataSql = "select @syskeyFieldName as keyField from @sysInsertTableName where sourceFrom='i6' ";
                            if (sysTableName == "QuotationParameter")
                                dataSql += " and isMateriel='否' ";
                            if (sysTableName == "Materiel")
                                dataSql += " and isMateriel='是' ";
                            DataTable dataTable = dbHelper.ExecuteDataTable(dataSql, new { syskeyFieldName, sysInsertTableName });

                            //查询出当前表相关的所有日志
                            string logSql = "SELECT keyValue FROM dbo.[_importLog] where tableName=@sourceTableName ";
                            DataTable logTable = dbHelperForI6.ExecuteDataTable(logSql, new { sourceTableName });

                            //判断每一条数据是否在日志中存在，如果不存在，则生成日志的新增语句
                            foreach (DataRow dataRow in dataTable.Rows)
                            {
                                string keyValue = dataRow["keyField"].ToString();
                                DataRow[] logRow = logTable.Select("keyValue='" + keyValue + "'");
                                if (logRow.Length == 0)
                                {
                                    sqlList.Add(" INSERT INTO dbo.[_importLog](tableName, keyValue) VALUES (@tableName, @keyValue)", new { tableName = sourceTableName, keyValue });
                                }
                            }
                            dbHelperForI6.Execute(sqlList);
                        }
                    }
                    catch (Exception ex)
                    {
                        rui.logHelper.log(ex);
                    }

                    //反向检查
                    try
                    {
                        //查出所有有导入日志的表
                        string importTableSql = "SELECT sysTableName,sysInsertTableName,sourceTableName,syskeyFieldName FROM dbo.sys_DataSyncInterface where isPrimary = '1' ";
                        DataTable importTableList = dbHelper.ExecuteDataTable(importTableSql);

                        //对每个表进行处理
                        foreach (DataRow row in importTableList.Rows)
                        {
                            Dictionary<string, object> sqlList = new Dictionary<string, object>();

                            //获取相关的配置数据
                            string sysTableName = row["sysTableName"].ToString();
                            string sysInsertTableName = row["sysInsertTableName"].ToString();
                            string sourceTableName = row["sourceTableName"].ToString();
                            string syskeyFieldName = row["syskeyFieldName"].ToString();

                            //查询出日志表内所有的数据
                            string logSql = "";
                            logSql = " SELECT keyValue FROM dbo.[_importLog] WHERE tableName=@sourceTableName ";
                            DataTable logTable = dbHelperForI6.ExecuteDataTable(logSql, new { sourceTableName });

                            //查询出对应表内所有的数据
                            string dataSql = " select @syskeyFieldName as keyField from @sysInsertTableName where sourceFrom='i6' ";
                            if (sysTableName == "QuotationParameter")
                                dataSql += " and isMateriel='否' ";
                            if (sysTableName == "Materiel")
                                dataSql += " and isMateriel='是' ";
                            DataTable dataTable = dbHelper.ExecuteDataTable(dataSql, new { syskeyFieldName, sysInsertTableName });

                            //判断每一条日志是否在数据表中存在，如果不存在，则生成日志的删除语句
                            foreach (DataRow logRow in logTable.Rows)
                            {
                                string keyValue = logRow["keyValue"].ToString();
                                DataRow[] dataRow = dataTable.Select(string.Format("{0}='{1}'", "keyField", keyValue));
                                if (dataRow.Length == 0)
                                {
                                    sqlList.Add(" DELETE FROM dbo.[_importLog] WHERE tableName=@sourceTableName and keyValue=@keyValue ", new { tableName = sourceTableName, keyValue });
                                }
                            }
                            dbHelperForI6.Execute(sqlList);
                        }
                    }
                    catch (Exception ex)
                    {
                        rui.logHelper.log(ex);
                    }
                }
            }
        }

        /// <summary>
        /// 同步单个表的数据
        /// 周期性的利用外库数据更新本库已导入数据
        /// </summary>
        /// <param name="sysTableName">表名称</param>
        public static void periodicalUpdateTableData(string sysTableName)
        {
            using (rui.dbHelper dbHelper = rui.dbHelper.createHelper(null))
            {
                using (rui.dbHelper dbHelperForI6 = rui.dbHelper.createI6Helper(null))
                {
                    //查询出外库的表名
                    syncPara para = new syncPara(sysTableName);
                    syncHelper.getSyncPara(ref para);

                    //利用外库导入日志查询出已导入的数据
                    string sqlOuter = string.Format("SELECT * FROM {0} WHERE {1} IN (SELECT keyValue FROM dbo.[_importLog] WHERE tableName='{0}')",
                        para.sourceTableName, getFieldName(para.importFieldList[para.sysKeyFieldName]));
                    DataTable dtOuter = dbHelperForI6.ExecuteDataTable(sqlOuter);

                    Dictionary<string, object> sqlList = new Dictionary<string, object>();
                    foreach (DataRow row in dtOuter.Rows)
                    {
                        //拼接Update语句
                        string sqlUpdate = string.Format(" update {0} set ", para.sysInsertTableName);
                        foreach (string item in para.importFieldList.Keys)
                        {
                            string value = row[getFieldName(para.importFieldList[item], true)].ToString();
                            if (item != para.sysKeyFieldName && value != "")
                            {
                                sqlUpdate += string.Format(" {0} = '{1}' ,", item, value.Replace("'", "''"));
                            }
                        }
                        sqlUpdate = sqlUpdate.Substring(0, sqlUpdate.Length - 1);
                        string keyField = getFieldName(para.importFieldList[para.sysKeyFieldName], true);
                        sqlUpdate += string.Format(" where {0} = '{1}' ", para.sysKeyFieldName, row[keyField].ToString().Replace("'", "''"));
                        sqlList.Add(sqlUpdate, null);

                        if (sqlList.Count > 5000)
                        {
                            dbHelper.Execute(sqlList);
                            sqlList.Clear();
                        }
                    }
                    dbHelper.Execute(sqlList);
                    sqlList.Clear();
                }
            }
        }

        /// <summary>
        /// 导入数据
        /// 完成基本数据的同步任务而写的通用数据同步代码（利用同步接口）
        /// </summary>
        /// <param name="sysTableName">表名称</param>
        /// <param name="selectedinExpression">选中项表达式</param>
        /// <param name="message">消息提醒</param>
        /// <returns></returns>
        public static bool syncData(string sysTableName, string selectedinExpression, ref string message)
        {
            using (rui.dbHelper dbHelper = rui.dbHelper.createHelper(null))
            {
                using (rui.dbHelper dbHelperForI6 = rui.dbHelper.createI6Helper(null))
                {
                    if (selectedinExpression == "")
                        return false;

                    //获取导入配置数据
                    syncPara para = new syncPara(sysTableName);
                    syncHelper.getSyncPara(ref para);

                    //拼接需要导入的字段列表（查询出表的主键字段）
                    string importFieldStr = syncHelper.getFieldName(para.showFieldList[para.sysKeyFieldName]) + " as 组合主键,";
                    foreach (string key in para.importFieldList.Keys)
                        importFieldStr += para.importFieldList[key] + ",";
                    importFieldStr = importFieldStr.Substring(0, importFieldStr.Length - 1);

                    //查询本库中已经存在的数据
                    List<string> existList = new List<string>();
                    {
                        string sql = string.Format(" select {0} as 组合主键 from {1} where {0} in ({2}) ", para.sysKeyFieldName,
                            para.sysInsertTableName, selectedinExpression);
                        DataTable table = dbHelper.ExecuteDataTable(sql);
                        for (int i = 0; i < table.Rows.Count; i++)
                            existList.Add(table.Rows[i]["组合主键"].ToString());
                    }
                    //从外库中查询出需要导入的数据
                    {
                        string sql = "select distinct " + importFieldStr + " from " + para.sourceTableName + para.sourceTableJoinExpression + " where "
                                + syncHelper.getFieldName(para.filterFieldList[para.sysKeyFieldName]) + " in (" + selectedinExpression + ")";

                        //拼接配置的筛选表达式
                        if (para.sourceTableWhereExpression != "")
                            sql += " and " + para.sourceTableWhereExpression;

                        //写入日志==
                        //rui.logTools.log("导入时外库查询语句:" + sql);

                        //获取需要导入的数据
                        DataTable importTable = dbHelperForI6.ExecuteDataTable(sql);

                        //将需要导入的数据插入到系统库中
                        //生成新增的sqlField列表
                        string insertFieldStr = "";
                        foreach (string sysFieldName in para.importFieldList.Keys)
                            insertFieldStr += sysFieldName + ",";

                        //拼接sourceFrom和importDate字段
                        insertFieldStr += "sourceFrom,importDate,";
                        insertFieldStr = insertFieldStr.Substring(0, insertFieldStr.Length - 1);

                        //特殊表特殊字段处理
                        {

                        }

                        //利用要导入的数据 生成新增的SQL语句
                        Dictionary<string, object> insertSqlList = new Dictionary<string, object>();
                        Dictionary<string, object> insertSqlList外库 = new Dictionary<string, object>();
                        List<string> importKeyList = new List<string>();
                        foreach (DataRow row in importTable.Rows)
                        {
                            string keyValue = row["组合主键"].ToString();

                            //对存在的数据不进行处理
                            if (existList.Count > 0 && existList.Contains(keyValue))
                                continue;

                            importKeyList.Add(keyValue);
                            //生成新增的每一个字段的SqlValue列表; 
                            string insertValueStr = "";
                            foreach (string sysFieldName in para.importFieldList.Keys)
                            {
                                // 2016-01-21 如果内容中有'，则替换成 '' 再导入
                                string value = row[syncHelper.getFieldAliasName(para.importFieldList[sysFieldName])].ToString();
                                value = value.Replace("'", "''");
                                insertValueStr += syncHelper.getFildValue("N'" + value + "'") + ",";
                            }
                            //拼接sourceFrom,importDate字段的值
                            insertValueStr += "N'" + rui.configHelper.va外库名 + "',N'" + DateTime.Now.ToString() + "'" + ",";
                            insertValueStr = insertValueStr.Substring(0, insertValueStr.Length - 1);

                            //特殊表特殊字段的值处理
                            {

                            }

                            //拼出每一行的插入语句
                            string insertSql = "INSERT INTO " + para.sysInsertTableName + " (" + insertFieldStr + ")  VALUES (" + insertValueStr + ") ";

                            insertSqlList.Add(insertSql, null);

                            //添加插入外库的SQL(导出日志）
                            insertSqlList外库.Add("INSERT INTO dbo.[_importLog]( tableName, keyValue) VALUES (@tableName,@keyValue)", new { tableName = para.sourceTableName, keyValue });
                        }
                        try
                        {
                            dbHelper.beginTran();
                            //获取从表导入脚本
                            {

                            }
                            dbHelper.Execute(insertSqlList);
                            dbHelper.commit();

                            if (checkExistUse外库)
                                dbHelperForI6.Execute(insertSqlList外库);
                            return true;
                        }
                        catch (Exception ex)
                        {
                            dbHelper.rollBack();
                            message += "异常:" + ex.Message;
                            throw ex;
                        }
                    }
                }
            }
        }

        /// <summary>
        /// 获取导入从表的脚本
        /// 获取插入从表所需要的sql语句
        /// （从表的导入不直接调用，导入主表时一起导入，不记录导入日志）
        /// </summary>
        /// <param name="sysTableName"></param>
        /// <param name="insertKeyList"></param>
        /// <param name="insertSqlList"></param>
        public static void syncSubData(string sysTableName, List<string> insertKeyList, ref List<string> insertSqlList)
        {
            using (rui.dbHelper dbHelperForI6 = rui.dbHelper.createI6Helper(null))
            {
                if (insertKeyList.Count == 0)
                    return;

                syncPara para = new syncPara(sysTableName);
                syncHelper.getSyncPara(ref para);

                //拼接需要导入的字段列表（查询出表的主键字段）
                string importFieldStr = syncHelper.getFieldName(para.showFieldList[para.sysKeyFieldName]) + " as 组合主键,";
                foreach (string key in para.importFieldList.Keys)
                    importFieldStr += para.importFieldList[key] + ",";
                importFieldStr = importFieldStr.Substring(0, importFieldStr.Length - 1);

                string selectedinExpression = rui.dbTools.getInExpression(insertKeyList);
                //从外库中查询出需要导入的数据
                {
                    string sql = "select " + importFieldStr + " from " + para.sourceTableName + para.sourceTableJoinExpression + " where "
                            + syncHelper.getFieldName(para.filterFieldList[para.sysKeyFieldName]) + " in (" + selectedinExpression + ")";

                    //拼接配置的筛选表达式
                    if (para.sourceTableWhereExpression != "")
                        sql += " and " + para.sourceTableWhereExpression;
                    //查询出获取需要导入的数据
                    DataTable table = dbHelperForI6.ExecuteDataTable(sql);

                    //将需要导入的数据插入到系统库中
                    //生成新增的sqlField列表
                    string insertFieldStr = "";
                    foreach (string sysFieldName in para.importFieldList.Keys)
                        insertFieldStr += sysFieldName + ",";
                    //拼接sourceFrom和importDate字段
                    insertFieldStr += "sourceFrom,importDate,";
                    insertFieldStr = insertFieldStr.Substring(0, insertFieldStr.Length - 1);

                    //从表特殊表处理
                    {

                    }

                    //生成新增的SQL语句
                    foreach (DataRow row in table.Rows)
                    {
                        string keyValue = row["组合主键"].ToString();

                        //生成新增的每一行的SqlValue列表; 
                        string insertValueStr = "";
                        foreach (string sysFieldName in para.importFieldList.Keys)
                        {
                            // 2016-01-21 如果内容中有'，则替换成 '' 再导入
                            string value = row[syncHelper.getFieldAliasName(para.importFieldList[sysFieldName])].ToString();
                            value = value.Replace("'", "''");
                            insertValueStr += syncHelper.getFildValue("N'" + value + "'") + ",";
                        }
                        //拼接sourceFrom,importDate字段的值
                        insertValueStr += "N'" + rui.configHelper.va外库名 + "',N'" + DateTime.Now.ToString() + "'" + ",";
                        insertValueStr = insertValueStr.Substring(0, insertValueStr.Length - 1);

                        //从表特殊表处理
                        {

                        }

                        //拼出每一行的插入语句
                        string insertSql = "INSERT INTO " + para.sysInsertTableName + " (" + insertFieldStr + ")  VALUES (" + insertValueStr + ") ";

                        insertSqlList.Add(insertSql);
                    }
                }
            }
        }

        /// <summary>
        /// 导入外库中所有未导入的数据
        /// 将外库所有未导入数据导入
        /// </summary>
        /// <param name="sysTableName"></param>
        /// <param name="message"></param>
        public static void syncAllData(string sysTableName, ref string message)
        {
            using (rui.dbHelper dbHelperForI6 = rui.dbHelper.createI6Helper(null))
            {
                DataTable table = new DataTable();
                string sourceKeyFieldName = "";
                //查询库中所有未导入的数据
                {
                    //获取外库查询语句
                    string orderSql = "";
                    Dictionary<string, string> dic = new Dictionary<string, string>();
                    string defaultSql = rui.syncHelper.getSearchSql(sysTableName, ref orderSql, ref sourceKeyFieldName, ref dic);
                    table = dbHelperForI6.ExecuteDataTable(defaultSql);
                }

                //拼接selectedinExpression表达式，进行数据导入
                {
                    string selectedinExpression = "";
                    int count = 0;
                    for (int i = 0; i < table.Rows.Count; i++)
                    {
                        selectedinExpression += string.Format("'{0}',", table.Rows[i][sourceKeyFieldName].ToString());
                        count++;
                        //阶段性导入数据
                        if (count == 1000)
                        {
                            if (selectedinExpression.Length > 0)
                            {
                                selectedinExpression = selectedinExpression.Substring(0, selectedinExpression.Length - 1);
                            }
                            rui.syncHelper.syncData(sysTableName, selectedinExpression, ref message);
                            selectedinExpression = "";
                            count = 0;
                        }
                    }
                    if (selectedinExpression.Length > 0)
                    {
                        selectedinExpression = selectedinExpression.Substring(0, selectedinExpression.Length - 1);
                    }
                    rui.syncHelper.syncData(sysTableName, selectedinExpression, ref message);
                }
            }
        }

        /// <summary>
        /// 拼接查询来源库的Sql
        /// 获取查询外库的sql语句
        /// </summary>
        /// <param name="sysTableName">表名</param>
        /// <param name="orderSql">回传的排序表达式</param>
        /// <param name="sourceKeyFieldName">回转的来源库主键字段</param>
        /// <param name="searchCon">传入的是搜索条件，回传的是显示字段列表</param>
        /// <param name="exceptExist">是否排除已存在的记录</param>
        /// <returns></returns>
        public static string getSearchSql(string sysTableName, ref string orderSql,
            ref string sourceKeyFieldName, ref Dictionary<string, string> searchCon, bool exceptExist = true)
        {
            using (rui.dbHelper dbHelper = rui.dbHelper.createHelper(null))
            {
                //获取配置参数
                syncPara para = new syncPara(sysTableName);
                if (syncHelper.getSyncPara(ref para))
                {
                    //拼接需要展示的字段列表
                    string fieldSet = "";
                    foreach (string key in para.showFieldList.Keys)
                        fieldSet += para.showFieldList[key] + ",";
                    fieldSet = fieldSet.Substring(0, fieldSet.Length - 1);


                    //生成查询语句
                    string querySql = "select " + fieldSet + " from " + para.sourceTableName + para.sourceTableJoinExpression + " where 1=1 ";

                    //利用本库排除已存在记录
                    if (exceptExist && checkExistUse外库 == false)
                    {
                        //获取数据库中已存在的记录列表。
                        string existList = "";
                        string existSql = string.Format("select {0} as '{1}' from {2}", para.sysKeyFieldName, "主键", para.sysInsertTableName);
                        DataTable table = dbHelper.ExecuteDataTable(existSql);
                        foreach (DataRow row in table.Rows)
                        {
                            existList += string.Format("'{0}',", row["主键"].ToString());
                        }

                        //如果系统中已有部分数据，则排除掉==
                        if (existList.Length > 0)
                        {
                            existList = existList.Substring(0, existList.Length - 1);
                            querySql += " and " + syncHelper.getFieldName(para.filterFieldList[para.sysKeyFieldName]) + " not in ( " + existList + ") ";
                        }
                    }
                    //利用外库排除已存在记录
                    if (exceptExist && checkExistUse外库 == true)
                    {
                        querySql += " and " + syncHelper.getFieldName(para.filterFieldList[para.sysKeyFieldName]) +
                            " not in (select keyValue from _importLog where tableName='" + para.sourceTableName + "') ";
                    }

                    //拼接筛选条件
                    if (searchCon.Count > 0)
                    {
                        foreach (string fieldName in searchCon.Keys)
                        {
                            querySql += " and " + syncHelper.getFieldName(para.filterFieldList[fieldName]) + searchCon[fieldName];
                        }
                    }

                    //拼接配置的筛选表达式
                    if (para.sourceTableWhereExpression != "")
                        querySql += " and " + para.sourceTableWhereExpression;

                    //设置传回的数据
                    orderSql = para.sourceTableOrderExpression;
                    sourceKeyFieldName = syncHelper.getFieldAliasName(para.filterFieldList[para.sysKeyFieldName]);
                    Dictionary<string, string> dic = new Dictionary<string, string>();
                    foreach (string key in para.showFieldList.Keys)
                    {
                        dic.Add(key, rui.syncHelper.getFieldAliasName(para.showFieldList[key]));
                    }
                    searchCon = dic;

                    //写入日志==
                    //rui.logTools.log("显示时外库查询语句:" + querySql);

                    return querySql;
                }
                else
                {
                    return "";
                }
            }
        }

        /// <summary>
        /// 利用para.sysTableName属性值获取导入配置参数信息
        /// </summary>
        /// <param name="para"></param>
        /// <returns></returns>
        private static bool getSyncPara(ref syncPara para)
        {
            using (rui.dbHelper dbHelper = rui.dbHelper.createHelper(null))
            {
                try
                {
                    //获取主表信息
                    {
                        string sql = "select syskeyFieldName,sysInsertTableName,sourceTableName,sourceTableJoinExpression,sourceTableWhereExpression,sourceTableOrderExpression from dbo.sys_DataSyncInterface where sysTableName=@sysTableName ";
                        DataRow row = dbHelper.ExecuteDataRow(sql, new { para.sysTableName });
                        if (row != null)
                        {
                            para.sysInsertTableName = row["sysInsertTableName"].ToString();
                            para.sourceTableName = row["sourceTableName"].ToString();
                            para.sourceTableJoinExpression = " " + row["sourceTableJoinExpression"].ToString() + " ";
                            para.sysKeyFieldName = row["syskeyFieldName"].ToString();
                            para.sourceTableWhereExpression = row["sourceTableWhereExpression"].ToString();
                            para.sourceTableOrderExpression = row["sourceTableOrderExpression"].ToString();
                        }
                        else
                            throw new Exception("接口文件中不存在" + para.sysTableName + "的记录");
                    }

                    //显示的字段列表(包含别名，定义个性化列名)
                    {
                        string sql = sql = "select sysFieldName,sourceFieldName,sourceFieldAliasName from dbo.sys_DataSyncInterfaceDetail where show='是' and sysTableName='" + para.sysTableName + "' order by showOrder asc ";
                        DataTable table = dbHelper.ExecuteDataTable(sql);
                        foreach (DataRow row in table.Rows)
                        {
                            //有别名的字段
                            if (row["sourceFieldAliasName"].ToString() != "")
                                para.showFieldList.Add(row["sysFieldName"].ToString(), row["sourceFieldName"].ToString() + " as " + row["sourceFieldAliasName"].ToString());
                            else
                                para.showFieldList.Add(row["sysFieldName"].ToString(), row["sourceFieldName"].ToString());
                        }
                    }
                    //导入的字段(用来去目标库中查询的）（包含别名）
                    {
                        string sql = sql = "select sysFieldName,sourceFieldName,sourceFieldAliasName from dbo.sys_DataSyncInterfaceDetail where import='是' and sysTableName='" + para.sysTableName + "'";
                        DataTable table = dbHelper.ExecuteDataTable(sql);
                        foreach (DataRow row in table.Rows)
                        {
                            if (row["sourceFieldAliasName"].ToString() != "")
                                para.importFieldList.Add(row["sysFieldName"].ToString(), row["sourceFieldName"].ToString() + " as " + row["sourceFieldAliasName"].ToString());
                            else
                                para.importFieldList.Add(row["sysFieldName"].ToString(), row["sourceFieldName"].ToString());
                        }
                    }
                    //筛选的字段列表(不包含别名)
                    {
                        string sql = sql = "select sysFieldName,sourceFieldName,sourceFieldAliasName from dbo.sys_DataSyncInterfaceDetail where filter='是' and sysTableName='" + para.sysTableName + "'";
                        DataTable table = dbHelper.ExecuteDataTable(sql);
                        foreach (DataRow row in table.Rows)
                        {
                            if (row["sourceFieldAliasName"].ToString() != "")
                                para.filterFieldList.Add(row["sysFieldName"].ToString(), row["sourceFieldName"].ToString() + " as " + row["sourceFieldAliasName"].ToString());
                            else
                                para.filterFieldList.Add(row["sysFieldName"].ToString(), row["sourceFieldName"].ToString());
                        }
                    }

                    //默认采用主键降序排列
                    if (para.sourceTableOrderExpression == "")
                    {
                        para.sourceTableOrderExpression = string.Format(" order by {0} desc", syncHelper.getFieldName(para.filterFieldList[para.sysKeyFieldName]));
                    }

                    return true;
                }
                catch (Exception ex)
                {
                    rui.logHelper.log(ex);
                    throw ex;
                }
            }
        }

        /// <summary>
        /// 获取字段名称（如果有别名，则返回别名），用于获取字段值
        /// </summary>
        /// <param name="name"></param>
        /// <returns></returns>
        private static string getFieldAliasName(string name)
        {
            int loc = name.IndexOf(" as ");
            if (loc > 0)
            {
                return name.Substring(loc + 4);
            }
            else
                return name;
        }

        /// <summary>
        /// 获取字段名称（如果有别名，获取原始名称），用于Where条件
        /// </summary>
        /// <param name="name"></param>
        /// <param name="removePre"></param>
        /// <returns></returns>
        private static string getFieldName(string name, bool removePre = false)
        {
            string result = "";
            int loc = name.IndexOf(" as ");
            if (loc > 0)
            {
                result = name.Substring(0, loc);
            }
            else
                result = name;

            //移除表名前缀
            if (removePre)
            {
                int temp = result.IndexOf(".");
                if (temp > 0)
                {
                    return result.Substring(temp + 1);
                }
            }
            return result;
        }

        /// <summary>
        /// 对于空的字段返回null
        /// </summary>
        /// <param name="value"></param>
        /// <returns></returns>
        private static string getFildValue(string value)
        {
            if (value == "N''")
                return "null";
            return value;
        }

        /// <summary>
        /// 获取外库表名
        /// </summary>
        /// <param name="sysTableName"></param>
        /// <returns></returns>
        public static string getTableName(string sysTableName)
        {
            using (rui.dbHelper dbHelper = rui.dbHelper.createHelper(null))
            {
                string sql = "SELECT sourceTableName FROM dbo.sys_DataSyncInterface WHERE sysTableName=@sysTableName ";
                return rui.typeHelper.toString(dbHelper.ExecuteScalar(sql, new { sysTableName }));
            }
        }
    }

    /// <summary>
    /// 数据导入配置参数
    /// </summary>
    public class syncPara
    {
        /// <summary>
        /// 本系统表名标识
        /// </summary>
        public string sysTableName = "";
        /// <summary>
        /// 本系统需要导入的表名称
        /// </summary>
        public string sysInsertTableName = "";
        /// <summary>
        /// 本系统库主键字段名
        /// </summary>
        public string sysKeyFieldName = "";
        /// <summary>
        /// 来源库的表名
        /// </summary>
        public string sourceTableName = "";
        /// <summary>
        /// 来源库join表达式
        /// </summary>
        public string sourceTableJoinExpression = "";
        /// <summary>
        /// 来源库where表达式
        /// </summary>
        public string sourceTableWhereExpression = "";
        /// <summary>
        /// 来源库order表达式
        /// </summary>
        public string sourceTableOrderExpression = "";

        /// <summary>
        /// 需要展示的字段
        /// </summary>
        public Dictionary<string, string> showFieldList;
        /// <summary>
        /// 需要导入的字段
        /// </summary>
        public Dictionary<string, string> importFieldList;
        /// <summary>
        /// 筛选用的字段
        /// </summary>
        public Dictionary<string, string> filterFieldList;

        /// <summary>
        /// 配置对应的属性
        /// </summary>
        /// <param name="sysTableName"></param>
        public syncPara(string sysTableName)
        {
            this.sysTableName = sysTableName;

            showFieldList = new Dictionary<string, string>();
            filterFieldList = new Dictionary<string, string>();
            importFieldList = new Dictionary<string, string>();
        }
    }
}
