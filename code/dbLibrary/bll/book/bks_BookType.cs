using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web.Mvc;

namespace db.bll
{
    /// <summary>
    /// 业务类-图书类别表
    /// wzrui 2020-02-20
    /// </summary>
    public class bks_BookType
    {
        /// <summary>
        /// 生成编号
        /// </summary>
        /// <param name="dc"></param>
        /// <returns></returns>
        private static string _createCode(db.dbEntities dc)
        {
            string Code = "BT";
            string result = (from a in dc.bks_BookType
                             where a.bookTypeCode.StartsWith(Code)
                             select a.bookTypeCode).Max();
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
        public static string insert(db.bks_BookType entry, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            _checkInput(entry);
            if (rui.typeHelper.isNullOrEmpty(entry.bookTypeCode))
                entry.bookTypeCode = _createCode(dc);
            else if (dc.bks_BookType.Count(a => a.bookTypeCode == entry.bookTypeCode) > 0)
            {
                rui.excptHelper.throwEx("编号已存在");
            }
            entry.rowID = ef.newGuid();
            dc.bks_BookType.Add(entry);
            dc.SaveChanges();
            return entry.rowID;
        }

        /// <summary>
        /// 检查录入
        /// </summary>
        /// <param name="entry"></param>
        private static void _checkInput(db.bks_BookType entry)
        {

        }

        /// <summary>
        /// 修改
        /// </summary>
        /// <param name="entry"></param>
        /// <param name="dc"></param>
        public static void update(db.bks_BookType entry, db.dbEntities dc)
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
                ef.Execute(" delete from dbo.bks_BookType where rowID=@rowID ", new { rowID });
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex, true);
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

            string sql = " select bookTypeCode from dbo.bks_BookType where rowID=@rowID ";
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

            string sql = " select bookTypeName from dbo.bks_BookType where rowID=@rowID ";
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

            string sql = " select bookTypeName from dbo.bks_BookType where bookTypeCode=@bookTypeCode ";
            return rui.typeHelper.toString(ef.ExecuteScalar(sql, new { bookTypeCode = keyCode }));
        }

        /// <summary>
        /// 获取实体
        /// </summary>
        /// <param name="rowID"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static db.bks_BookType getEntryByRowID(string rowID, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            db.bks_BookType entry = dc.bks_BookType.SingleOrDefault(a => a.rowID == rowID);
            return entry;
        }
        public static db.bks_BookType getEntryByCode(string keyCode, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            db.bks_BookType entry = dc.bks_BookType.SingleOrDefault(a => a.bookTypeCode == keyCode);
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
            string sql = @" SELECT bookTypeCode AS code,bookTypeName AS name FROM dbo.bks_BookType order by bookTypeCode asc ";
            DataTable table = ef.ExecuteDataTable(sql);
            List<SelectListItem> list = rui.listHelper.dataTableToDdlList(table, has请选择, "");
            return list;
        }


    }
}
