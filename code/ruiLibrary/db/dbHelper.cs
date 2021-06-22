using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using Dapper;

namespace rui
{
    /// <summary>
    /// dbHelper辅助类
    /// 和Core代码共享
    /// </summary>
    public class dbHelper : IDisposable
    {

        //超时时间
        private static int timeOut = 600;
        /// <summary>
        /// 连接对象
        /// </summary>
        public DbConnection dbConn { get; set; }
        private bool isSelfConn = true;

        /// <summary>
        /// 事务对象
        /// </summary>
        public DbTransaction dbTran { get; set; }

        /// <summary>
        /// 是否使用自己的事务对象 - 用于事务控制
        /// </summary>
        private bool isSelfTran = true;

        /// <summary>
        /// 返回连接串
        /// </summary>
        /// <param name="connName"></param>
        /// <returns></returns>
        public static string getConnStr(string connName="dbConn")
        {
            return rui.configHelper.getConnString(connName);
        }

        /// <summary>
        /// 获取提供程序
        /// </summary>
        /// <param name="connName "></param>
        /// <returns></returns>
        public static string getProvider(string connName = "dbConn")
        {
            return rui.configHelper.getConnProvider(connName);
        }

        /// <summary>
        /// 创建dbHelper
        /// </summary>
        /// <param name="upHelper">上层方法的dbHelper对象，要实现跨方法事务，需要传入上层方法对象</param>
        /// <returns></returns>
        public static dbHelper createHelper(dbHelper upHelper = null)
        {
            dbHelper helper = new dbHelper();
            if (upHelper != null)
            {
                helper.isSelfConn = false;
                helper.dbConn = upHelper.dbConn;
                helper.dbTran = upHelper.dbTran;
                if (helper.dbTran != null)
                    helper.isSelfTran = false;
            }
            else
            {
                string dbName = "dbConn";
                string prividerName = getProvider(dbName);
                DbProviderFactory dbFactory = new rui.dbFactory(prividerName);
                helper.dbConn = dbFactory.CreateConnection();
                helper.dbConn.ConnectionString = getConnStr(dbName);
                helper.dbTran = null;
            }
            return helper;
        }

        /// <summary>
        /// 创建比较库的dbHelper
        /// </summary>
        /// <param name="upHelper">上层方法的dbHelper对象，要实现跨方法事务，需要传入上层方法对象</param>
        /// <returns></returns>
        public static dbHelper createCPHelper(dbHelper upHelper = null)
        {
            dbHelper helper = new dbHelper();
            if (upHelper != null)
            {
                helper.isSelfConn = false;
                helper.dbConn = upHelper.dbConn;
                helper.dbTran = upHelper.dbTran;
                if (helper.dbTran != null)
                    helper.isSelfTran = false;
            }
            else
            {
                string dbName = "dbConnCompare";
                string prividerName = getProvider(dbName);
                DbProviderFactory dbFactory = new rui.dbFactory(prividerName);
                helper.dbConn = dbFactory.CreateConnection();
                helper.dbConn.ConnectionString = getConnStr(dbName);
                helper.dbTran = null;
            }
            return helper;
        }

        /// <summary>
        /// 创建I6的dbHelper
        /// </summary>
        /// <param name="upHelper">上层方法的dbHelper对象，要实现跨方法事务，需要传入上层方法对象</param>
        /// <returns></returns>
        public static dbHelper createI6Helper(dbHelper upHelper = null)
        {
            dbHelper helper = new dbHelper();
            if (upHelper != null)
            {
                helper.isSelfConn = false;
                helper.dbConn = upHelper.dbConn;
                helper.dbTran = upHelper.dbTran;
                if (helper.dbTran != null)
                    helper.isSelfTran = false;
            }
            else
            {
                string dbName = "dbConnI6";
                string prividerName = getProvider(dbName);
                DbProviderFactory dbFactory = new rui.dbFactory(prividerName);
                helper.dbConn = dbFactory.CreateConnection();
                helper.dbConn.ConnectionString = getConnStr(dbName);
                helper.dbTran = null;
            }
            return helper;
        }

        /// <summary>
        /// 查询返回列表数据
        /// </summary>
        /// <typeparam name="T">集合元素类型</typeparam>
        /// <param name="cmdText">命令文本</param>
        /// <param name="cmdPara">命令参数，匿名类</param>
        /// <returns></returns>
        public List<T> ExecuteList<T>(string cmdText, object cmdPara = null)
        {
            List<T> list = dbConn.Query<T>(cmdText, cmdPara, dbTran,false,timeOut).AsList<T>();
            return list;
        }

        /// <summary>
        /// 查询返回单行数据
        /// </summary>
        /// <typeparam name="T">结果类型</typeparam>
        /// <param name="cmdText">命令文本</param>
        /// <param name="cmdPara">命令参数，匿名类</param>
        /// <returns></returns>
        public T ExecuteEntry<T>(string cmdText, object cmdPara = null)
        {
            T entry = dbConn.QueryFirst<T>(cmdText, cmdPara, dbTran, timeOut);
            return entry;
        }

        /// <summary>
        /// 执行查询，并以DataTable离线的方式返回所查询的结果集
        /// </summary>
        /// <param name="cmdText">命令文本</param>
        /// <param name="cmdPara">命令参数</param>
        /// <param name="cmdType">命令类型</param>
        /// <returns></returns>
        public DataTable ExecuteDataTable(string cmdText, object cmdPara = null, CommandType cmdType = CommandType.Text)
        {
            IDataReader dr = dbConn.ExecuteReader(cmdText, cmdPara, dbTran, timeOut, cmdType);
            DataTable dataTable = new DataTable();
            dataTable.Load(dr);
            return dataTable;
        }

        /// <summary>
        /// 执行查询，并以DataRow离线的方式返回所查询的单条记录
        /// </summary>
        /// <param name="cmdText">命令文本</param>
        /// <param name="cmdPara">命令参数</param>
        /// <param name="cmdType">命令类型</param>
        /// <returns></returns>
        public DataRow ExecuteDataRow(string cmdText, object cmdPara = null, CommandType cmdType = CommandType.Text)
        {
            DataTable dataTable = this.ExecuteDataTable(cmdText, cmdPara, cmdType);
            //利用DataTable内的记录条数判断是否查询出一条记录，并且有且只能有一条
            if (dataTable.Rows.Count >= 1)
            {
                return dataTable.Rows[0];
            }
            return null;
        }

        /// <summary>
        /// 执行汇总查询
        /// </summary>
        /// <param name="cmdText">命令文本</param>
        /// <param name="cmdPara">命令参数</param>
        /// <param name="cmdType">命令类型</param>
        /// <returns></returns>
        public object ExecuteScalar(string cmdText, object cmdPara = null, CommandType cmdType = CommandType.Text)
        {
            object value = dbConn.ExecuteScalar(cmdText, cmdPara, dbTran, timeOut, cmdType);
            return value;
        }

        /// <summary>
        /// 判断查询是否有结果
        /// </summary>
        /// <param name="cmdText">命令文本</param>
        /// <param name="cmdPara">命令参数</param>
        /// <param name="cmdType">命令类型</param>
        /// <returns></returns>
        public bool ExecuteExist(string cmdText, object cmdPara = null, CommandType cmdType = CommandType.Text)
        {
            object result = this.ExecuteScalar(cmdText, cmdPara, cmdType);
            if (result == null)
                return false;
            else
                return true;
        }

        /// <summary>
        /// 执行Sql操作
        /// </summary>
        /// <param name="cmdText">命令文本</param>
        /// <param name="cmdPara">命令参数</param>
        /// <param name="cmdType">命令类型</param>
        /// <returns></returns>
        public int Execute(string cmdText, object cmdPara = null, CommandType cmdType = CommandType.Text)
        {
            return dbConn.Execute(cmdText, cmdPara, dbTran, timeOut, cmdType);
        }

        /// <summary>
        /// 批量执行操纵类的Sql语句
        /// </summary>
        /// <param name="sqlDic">命令集合</param>
        /// <returns></returns>
        public int Execute(Dictionary<string, object> sqlDic)
        {
            int count = 0;
            foreach (string sql in sqlDic.Keys)
            {
                count += dbConn.Execute(sql, sqlDic[sql], dbTran, timeOut);
            }
            return count;
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

        /// <summary>
        /// 开启事务
        /// </summary>
        public void beginTran(IsolationLevel level = IsolationLevel.ReadUncommitted)
        {
            if (this.dbTran == null)
            {
                this.dbConn.Open();
                this.dbTran = this.dbConn.BeginTransaction(level);
                this.isSelfTran = true;
            }
        }

        /// <summary>
        /// 提交事务
        /// </summary>
        public void commit()
        {
            if (this.isSelfTran && this.dbTran != null)
            {
                this.dbTran.Commit();
                this.dbTran.Dispose();
                this.dbTran = null;
                if (this.dbConn.State == ConnectionState.Open)
                {
                    this.dbConn.Close();
                }
            }
        }

        /// <summary>
        /// 回滚事务
        /// </summary>
        public void rollBack()
        {
            if (this.isSelfTran && this.dbTran != null)
            {
                this.dbTran.Rollback();
                this.dbTran.Dispose();
                this.dbTran = null;
                if (this.dbConn.State == ConnectionState.Open)
                {
                    this.dbConn.Close();
                }
            }
        }

        /// <summary>
        /// 对象释放
        /// 如果使用自己的连接对象，则自动释放
        /// </summary>
        public void Dispose()
        {
            if (this.isSelfConn == true && this.dbConn != null)
            {
                if (this.dbConn.State == ConnectionState.Open)
                    this.dbConn.Close();
                this.dbConn.Dispose();
            }
        }
    }
}
