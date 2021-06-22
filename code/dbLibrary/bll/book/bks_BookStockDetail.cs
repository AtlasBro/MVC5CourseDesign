using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web.Mvc;

namespace db.bll
{
    /// <summary>
    /// 业务类-入库明细表表
    /// wzrui 2020-02-19
    /// </summary>
    public class bks_BookStockDetail
    {
        /// <summary>
        /// 生成编号
        /// </summary>
        /// <param name="dc"></param>
        /// <returns></returns>
        private static int _createDetailNo(string stockCode, db.dbEntities dc)
        {
            int value = 0;
            var result = from a in dc.bks_BookStockDetail
                         where a.stockCode == stockCode
                         orderby a.detailNo descending
                         select a.detailNo;
            if (result.Count() == 0)
                value = 1;
            else
                value = rui.typeHelper.toInt(result.First()) + 1;
            return value;
        }

        /// <summary>
        /// 新增
        /// </summary>
        /// <param name="entry"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static string insert(db.bks_BookStockDetail entry, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc); 

            _checkInput(entry);
            if(rui.typeHelper.isNullOrEmpty(entry.stockCode))
                rui.excptHelper.throwEx("必须提供关联的入库编号");

            entry.detailNo = _createDetailNo(entry.stockCode, dc);
            entry.sellQuantity = 0;
            entry.rowID = ef.newGuid();
            dc.bks_BookStockDetail.Add(entry);
            dc.SaveChanges();
            return entry.rowID;
        }

        /// <summary>
        /// 批量新增
        /// </summary>
        /// <param name="stockCode"></param>
        /// <param name="selectedBooks"></param>
        public static void batchInsert(string stockCode,string selectedBooks,db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            List<string> list = rui.dbTools.getList(selectedBooks);

            foreach(string bookCode in list)
            {
                db.bks_BookStockDetail entry = new db.bks_BookStockDetail();
                entry.stockCode = stockCode;
                entry.bookCode = bookCode;
                db.bll.bks_BookStockDetail.insert(entry, dc);
            }
        }

        /// <summary>
        /// 检查录入
        /// </summary>
        /// <param name="entry"></param>
        private static void _checkInput(db.bks_BookStockDetail entry) {

        }

        /// <summary>
        /// 修改
        /// </summary>
        /// <param name="entry"></param>
        /// <param name="dc"></param>
        public static void update(db.bks_BookStockDetail entry, db.dbEntities dc)
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
        public static void delete(string rowID,db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc); 
            try
            {
                //删除前检查


                //删除
                ef.Execute(" delete from dbo.bks_BookStockDetail where rowID=@rowID ",new { rowID });
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

            string sql = " select stockCode from dbo.bks_BookStockDetail where rowID=@rowID ";
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

            string sql = " select stockName from dbo.bks_BookStockDetail where rowID=@rowID ";
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

            string sql = " select stockName from dbo.bks_BookStockDetail where stockCode=@stockCode ";
            return rui.typeHelper.toString(ef.ExecuteScalar(sql, new { stockCode = keyCode }));
        }

        /// <summary>
        /// 获取实体
        /// </summary>
        /// <param name="rowID"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static db.bks_BookStockDetail getEntryByRowID(string rowID, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc); 

            db.bks_BookStockDetail entry = dc.bks_BookStockDetail.SingleOrDefault(a => a.rowID == rowID);
            return entry;
        }
        public static db.bks_BookStockDetail getEntryByCode(string keyCode, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc); 

            db.bks_BookStockDetail entry = dc.bks_BookStockDetail.SingleOrDefault(a => a.stockCode == keyCode);
            return entry;
        }


        /// <summary>
        /// 绑定下拉框
        /// </summary>
        /// <param name="has请选择"></param>
        /// <returns></returns>
        public static List<SelectListItem> bindDdl(bool has请选择 = false,string selectedValues = "")
        {
            efHelper ef = new efHelper();
            string sql = @" SELECT stockCode AS code,stockName AS name FROM dbo.bks_BookStockDetail order by stockCode asc ";
            DataTable table = ef.ExecuteDataTable(sql);
            List<SelectListItem> list = rui.listHelper.dataTableToDdlList(table, has请选择, "");
            return list;
        }
    }
}
