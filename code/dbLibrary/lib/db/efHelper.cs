using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data;
using System.Linq;
using Dapper;

namespace db
{
    /// <summary>
    /// ef和ADO.NET混合封装类，本项目数据库访问用此类
    /// </summary>
    public class efHelper
    {
        private static int timeOut = 600;

        /// <summary>
        /// 保存所用的dc对象
        /// </summary>
        public db.dbEntities dc = null;

        /// <summary>
        /// 是否使用自己的事务对象
        /// </summary>
        public bool isSelfTran = false;

        /// <summary>
        /// 快速返回一个dc对象
        /// </summary>
        /// <returns></returns>
        public static db.dbEntities newDc()
        {
            db.dbEntities dc = new dbEntities();
            return dc;
        }

        /// <summary>
        /// 无参数的构造函数
        /// </summary>
        public efHelper()
        {
            this.dc = efHelper.newDc();
        }

        /// <summary>
        /// 构造函数创建dc
        /// </summary>
        /// <param name="upDc">上层方法的dc对象，允许空值</param>
        public efHelper(ref db.dbEntities upDc)
        {
            if (upDc != null)
            {
                this.dc = upDc;
                if (upDc.efTran != null)
                    this.isSelfTran = false;
            }
            else
            {
                this.dc = efHelper.newDc();
                upDc = this.dc;
            }
        }

        #region #跨方法事务控制 事务方法

        /// <summary>
        /// 开始事务
        /// </summary>
        /// <param name="level"></param>
        public void beginTran(IsolationLevel level = IsolationLevel.Serializable)
        {
            if (dc.efTran == null)
            {
                if (dc.efConn.State == ConnectionState.Open)
                    rui.excptHelper.throwEx("外层方法连接对象已经被打开，必须给外层方法加上事务控制");

                dc.efConn.Open();
                //.net写法
                dc.efTran = dc.Database.BeginTransaction(level).UnderlyingTransaction;
                //.netCore的写法,需要引入Microsoft.EntityFrameworkCore.Storage;
                //dc.efTran = dc.Database.BeginTransaction().GetDbTransaction();
                this.isSelfTran = true;
            }
            else
                this.isSelfTran = false;
        }

        /// <summary>
        /// 提交事务
        /// </summary>
        public void commit()
        {
            if (dc.efTran != null && isSelfTran == true)
            {
                dc.efTran.Commit();
                dc.efTran.Dispose();
                dc.efTran = null;

                if (dc.efConn.State == ConnectionState.Open)
                    dc.efConn.Close();
            }
        }

        /// <summary>
        /// 回滚事务
        /// </summary>
        public void rollBack()
        {
            if (dc.efTran != null && isSelfTran == true)
            {
                dc.efTran.Rollback();
                dc.efTran.Dispose();
                dc.efTran = null;

                if (dc.efConn.State == ConnectionState.Open)
                    dc.efConn.Close();
            }
        }
        #endregion

        #region Dapper数据访问方法封装

        /// <summary>
        /// 查询返回列表数据
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="cmdText"></param>
        /// <param name="cmdPara"></param>
        /// <returns></returns>
        public List<T> ExecuteEntryList<T>(string cmdText, object cmdPara = null)
        {
            List<T> list = dc.efConn.Query<T>(cmdText, cmdPara, dc.efTran, false, timeOut).AsList<T>();
            return list;
        }

        //查询返回单行数据
        public T ExecuteEntry<T>(string cmdText, object cmdPara = null)
        {
            T entry = dc.efConn.QueryFirst<T>(cmdText, cmdPara, dc.efTran, timeOut);
            return entry;
        }

        /// <summary>
        /// Dapper版本的查询方法
        /// </summary>
        /// <returns></returns>
        public DataTable ExecuteDataTable(string cmdText, object param = null, CommandType type = CommandType.Text)
        {
            IDataReader dr = dc.efConn.ExecuteReader(cmdText, param, dc.efTran, timeOut, type);
            DataTable table = new DataTable();
            table.Load(dr);
            return table;
        }

        /// <summary>
        /// 执行后返回DataRow
        /// </summary>
        /// <param name="cmdText"></param>
        /// <param name="param"></param>
        /// <returns></returns>
        public DataRow ExecuteDataRow(string cmdText, object param = null, CommandType type = CommandType.Text)
        {
            DataTable dataTable = this.ExecuteDataTable(cmdText, param, type);
            //利用DataTable内的记录条数判断是否查询出一条记录，并且有且只能有一条
            if (dataTable.Rows.Count >= 1)
            {
                return dataTable.Rows[0];
            }
            return null;
        }

        /// <summary>
        /// 执行返回单个值
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="cmdText"></param>
        /// <param name="param"></param>
        /// <returns></returns>
        public object ExecuteScalar(string cmdText, object param = null, CommandType type = CommandType.Text)
        {
            object result = dc.efConn.ExecuteScalar(cmdText, param, dc.efTran, timeOut, type);
            return result;
        }

        /// <summary>
        /// 判断是否有查询结果
        /// </summary>
        /// <param name="cmdText"></param>
        /// <param name="param"></param>
        /// <returns></returns>
        public bool ExecuteExist(string cmdText, object param = null, CommandType type = CommandType.Text)
        {
            object result = this.ExecuteScalar(cmdText, param, type);
            if (result == null)
                return false;
            else
                return true;
        }

        /// <summary>
        /// 执行数据库操作insert,
        /// </summary>
        /// <param name="cmdText"></param>
        /// <param name="param"></param>
        /// <returns></returns>
        public int Execute(string cmdText, object param = null, CommandType type = CommandType.Text)
        {
            return dc.efConn.Execute(cmdText, param, dc.efTran, timeOut, type);
        }

        #endregion

        //==============================================删除检测方法

        //检查是否可以删除，一个字段存储一个外检值。
        public void checkCanDelete(string tableName, string fieldName, string fieldValue, string errorMsg, string whereExpr = "")
        {
            string sql = string.Format("SELECT {0} FROM {1} WHERE {0}=@fieldValue " + whereExpr, fieldName, tableName);
            if (this.ExecuteExist(sql, new { fieldValue }))
                rui.excptHelper.throwEx(errorMsg);
        }

        //一个字段存储多个外检值 a,b
        public void checkCanDeleteIn(string tableName, string fieldName, string fieldValue, string errorMsg, string whereExpr = "")
        {
            string sql = string.Format("SELECT {0} FROM {1} WHERE charindex(@fieldValue,{0})>0 " + whereExpr, fieldName, tableName);
            if (this.ExecuteExist(sql, new { fieldValue }))
                rui.excptHelper.throwEx(errorMsg);
        }

        //==============================================实体对象的相关操作

        /// <summary>
        /// 单表更新（只更新提交的字段） 
        /// </summary>
        /// <param name="entry">要更新的实体对象</param>
        /// <param name="entryPreTag">实体前缀名称</param>
        /// <param name="dc"></param>
        /// <param name="exceptField">被排除的不需要更新的属性,分割</param>
        /// <param name="containField">界面没有,但是需要更新的字段,分割, 也可以将界面不包含的,但需要更新的属性赋值放在该方法的下方</param>
        public static void entryUpdate(object entry, db.dbEntities dc, string exceptField = null, string containField = null)
        {
            List<string> exceptList = rui.dbTools.getList(exceptField);
            List<string> containList = rui.dbTools.getList(containField);
            List<string> allKey = rui.requestHelper.getAllKey("");
            if (entry == null)
                return;
            //附加进来
            //.net写法
            dc.Entry(entry).State = System.Data.Entity.EntityState.Unchanged;
            //.netCore写法
            //dc.Entry(entry).State = Microsoft.EntityFrameworkCore.EntityState.Unchanged;
            foreach (System.Reflection.PropertyInfo p in entry.GetType().GetProperties())
            {
                if (allKey.Contains(p.Name) == true)
                {
                    //排除NotMapped的，在额外增加的字段上增加NotMapped,更新时会自动排除掉
                    bool isNotMapped = false;
                    foreach (var attr in p.CustomAttributes)
                    {
                        if (attr.AttributeType.Name == typeof(NotMappedAttribute).Name)
                        {
                            isNotMapped = true;
                            continue;
                        }

                    }
                    if (isNotMapped)
                        continue;

                    //排除不需要处理的
                    if (p.Name == "rowNum" || p.Name == "rowID" || exceptList.Contains(p.Name) == true)
                        continue;
                    dc.Entry(entry).Property(p.Name).IsModified = true;
                }
            }
            //包含的元素
            foreach (string item in containList)
            {
                dc.Entry(entry).Property(item).IsModified = true;
            }
        }

        /// <summary>
        /// 对象复制(复制非排除属性的值，表数据复制的时候用(所有字段都复制)
        /// </summary>
        /// <param name="dc"></param>
        /// <param name="entryDesc"></param>
        /// <param name="entrySrc"></param>
        /// <param name="exceptField"></param>
        public static void copyEntry(db.dbEntities dc, object entryDesc, object entrySrc, List<string> exceptField = null)
        {
            foreach (System.Reflection.PropertyInfo srcP in entrySrc.GetType().GetProperties())
            {
                object value = srcP.GetValue(entrySrc);
                if (value != null)
                {
                    //排除不需要处理的
                    if (exceptField != null && exceptField.Contains(srcP.Name) == true)
                        continue;
                    dc.Entry(entryDesc).Property(srcP.Name).CurrentValue = value;
                }
            }
        }

        /// <summary>
        /// 设置EF实体中数值类型字段的默认值，如果为空置为0
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="dc"></param>
        /// <param name="entry"></param>
        /// <returns></returns>
        public static T setEntryDefault<T>(db.dbEntities dc, T entry) where T : class
        {
            foreach (System.Reflection.PropertyInfo pItem in entry.GetType().GetProperties())
            {
                if (pItem.GetType() == typeof(Int16) || pItem.GetType() == typeof(Int32) || pItem.GetType() == typeof(Int64) || pItem.GetType() == typeof(decimal))
                {
                    pItem.SetValue(entry, _getFieldValue(pItem, pItem.GetValue(entry)));
                }
            }
            return entry;
        }

        /// <summary>
        /// 利用明细表的提交数据，构造明细实体对象集合
        /// </summary>
        /// <param name="dic">Key是字段名,Key对应的List对应的字段的相关值</param>
        /// <param name="keyValue">界面没传入字段的默认值(主要是主表主键字段的值)</param>
        /// <returns></returns>
        public static List<T> getEntryList<T>(db.dbEntities dc, Dictionary<string, List<string>> dic)
            where T : class, new()
        {
            List<T> list = new List<T>();

            for (int i = 0; i < dic.First().Value.Count; i++)
            {
                T entry = new T();
                foreach (System.Reflection.PropertyInfo pItem in entry.GetType().GetProperties())
                {
                    if (dic.Keys.Contains(pItem.Name) && dic[pItem.Name][i].ToString() != "")
                    {
                        pItem.SetValue(entry, _getFieldValue(pItem, dic[pItem.Name][i]));
                    }
                }
                list.Add(entry);
            }
            return list;
        }

        /// <summary>
        /// 根据属性的类型，返回特定类型的值
        /// </summary>
        /// <param name="p"></param>
        /// <param name="val"></param>
        /// <returns></returns>
        private static object _getFieldValue(System.Reflection.PropertyInfo p, object val)
        {
            Type t = p.PropertyType;

            if (p.PropertyType == typeof(string))
                return val;
            if (p.PropertyType == typeof(Int16))
                return rui.typeHelper.toInt(val);
            if (p.PropertyType == typeof(Int16?))
                return rui.typeHelper.toInt(val);
            if (p.PropertyType == typeof(Int32))
                return rui.typeHelper.toInt(val);
            if (p.PropertyType == typeof(Int32?))
                return rui.typeHelper.toInt(val);
            if (p.PropertyType == typeof(Int64))
                return rui.typeHelper.toLong(val);
            if (p.PropertyType == typeof(Int64?))
                return rui.typeHelper.toLong(val);
            if (p.PropertyType == typeof(System.Decimal?))
                return rui.typeHelper.toDecimal(val);
            if (p.PropertyType == typeof(DateTime))
                return rui.typeHelper.toDateTime(val);

            return null;
        }

        /// <summary>
        /// 当属性值为空时,获取默认值
        /// </summary>
        /// <typeparam name="T">数据类型</typeparam>
        /// <param name="value">属性值</param>
        /// <param name="dValue">默认值</param>
        /// <returns></returns>
        public T getDefault<T>(T value, T dValue)
        {
            if (rui.typeHelper.isNotNullOrEmpty(value))
                return value;
            else
                return dValue;
        }

        /// <summary>
        /// 返回Guid编号
        /// </summary>
        /// <returns></returns>
        public string newGuid()
        {
            string value = Guid.NewGuid().ToString();
            value = value.Replace("-", "");
            return value;
        }

    }
}
