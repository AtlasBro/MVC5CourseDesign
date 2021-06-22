using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web.Mvc;

namespace db.bll
{
    /// <summary>
    /// 业务类-出版社表
    /// wzrui 2020-02-20
    /// </summary>
    public class bks_Press
    {
        /// <summary>
        /// 生成编号
        /// </summary>
        /// <param name="dc"></param>
        /// <returns></returns>
        private static string _createCode(db.dbEntities dc)
        {
            string Code = "P";
            string result = (from a in dc.bks_Press
                             where a.pressCode.StartsWith(Code)
                             select a.pressCode).Max();
            if (result != null)
            {
                Code = rui.stringHelper.codeNext(result, 4);
            }
            else
            {
                Code = Code + "0001";
            }
            return Code;
        }

        /// <summary>
        /// 新增
        /// </summary>
        /// <param name="entry"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static string insert(db.bks_Press entry, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            _checkInput(entry);
            if (rui.typeHelper.isNullOrEmpty(entry.pressCode))
                entry.pressCode = _createCode(dc);
            else if (dc.bks_Press.Count(a => a.pressCode == entry.pressCode) > 0)
            {
                rui.excptHelper.throwEx("编号已存在");
            }
            entry.rowID = ef.newGuid();
            dc.bks_Press.Add(entry);
            dc.SaveChanges();
            return entry.rowID;
        }

        /// <summary>
        /// 检查录入
        /// </summary>
        /// <param name="entry"></param>
        private static void _checkInput(db.bks_Press entry)
        {

        }

        /// <summary>
        /// 修改
        /// </summary>
        /// <param name="entry"></param>
        /// <param name="dc"></param>
        public static void update(db.bks_Press entry, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            _checkInput(entry);
            efHelper.entryUpdate(entry, dc);
            dc.SaveChanges();
        }

        /// <summary>
        /// 删除
        /// </summary>
        /// <param name="rowID"></param>
        /// <param name="dc"></param>
        public static void delete(string rowID, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);
            try
            {
                //删除前检查


                //删除
                ef.Execute(" delete from dbo.bks_Press where rowID=@rowID ", new { rowID });
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex, true);
            }
        }

        public static void SaveData(db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);
            try
            {
                //查询数据库中已经存在的数据
                DataTable tableExist = ef.ExecuteDataTable("select * from bks_Press");
                //获取要导入的数据
                DataTable table = rui.sessionHelper.getValue<DataTable>("importTable");
                if (table == null || table.Rows.Count == 0)
                    rui.excptHelper.throwEx("文件内容为空！");
                ef.beginTran();
                for (int i = 0; i < table.Rows.Count; i++)
                {
                    //获取Excel导入的每一行数据
                    string pressCode = rui.typeHelper.toString(table.Rows[i]["出版社编号"]);
                    string pressName = rui.typeHelper.toString(table.Rows[i]["出版社名称"]);

                    //1、如果主键不存在,则插入一条数据
                    if (tableExist.Select("pressCode='" + pressCode + "'").Length == 0)
                    {
                        db.bks_Press entry = new db.bks_Press();
                        entry.pressCode = pressCode;
                        entry.pressName = pressName;
                        entry.rowID = ef.newGuid();
                        dc.bks_Press.Add(entry);
                        dc.SaveChanges();
                    }
                }
                ef.dc.SaveChanges();
                ef.commit();
            }
            catch (Exception ex)
            {
                ef.rollBack();
                rui.logHelper.log("导入出错", ex, true);
                throw ex;
            }
        }


        /// <summary>
        /// 通过rowID获取Code
        /// </summary>
        /// <param name="rowID"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static string getCodeByRowID(string rowID, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            string sql = " select pressCode from dbo.bks_Press where rowID=@rowID ";
            return rui.typeHelper.toString(ef.ExecuteScalar(sql, new { rowID }));
        }

        /// <summary>
        /// 通过rowID获取Name
        /// </summary>
        /// <param name="rowID"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static string getNameByRowID(string rowID, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            string sql = " select pressName from dbo.bks_Press where rowID=@rowID ";
            return rui.typeHelper.toString(ef.ExecuteScalar(sql, new { rowID }));
        }

        /// <summary>
        /// 通过Code获取Name
        /// </summary>
        /// <param name="rowID"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static string getNameByCode(string keyCode, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            string sql = " select pressName from dbo.bks_Press where pressCode=@pressCode ";
            return rui.typeHelper.toString(ef.ExecuteScalar(sql, new { pressCode = keyCode }));
        }

        /// <summary>
        /// 获取实体
        /// </summary>
        /// <param name="rowID"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static db.bks_Press getEntryByRowID(string rowID, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            db.bks_Press entry = dc.bks_Press.SingleOrDefault(a => a.rowID == rowID);
            return entry;
        }
        public static db.bks_Press getEntryByCode(string keyCode, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            db.bks_Press entry = dc.bks_Press.SingleOrDefault(a => a.pressCode == keyCode);
            return entry;
        }


        /// <summary>
        /// 绑定下拉框
        /// </summary>
        /// <param name="has请选择"></param>
        /// <returns></returns>
        public static List<SelectListItem> bindDdl(bool has请选择 = false, string selectedValues = "")
        {
            efHelper ef = new efHelper();
            string sql = @" SELECT pressCode AS code,pressName AS name FROM dbo.bks_Press order by pressCode asc ";
            DataTable table = ef.ExecuteDataTable(sql);
            List<SelectListItem> list = rui.listHelper.dataTableToDdlList(table, has请选择, "");
            return list;
        }
    }
}
