using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web.Mvc;

namespace db.bll
{
    /// <summary>
    /// 业务类-入库主表表
    /// wzrui 2020-02-19
    /// </summary>
    public class bks_BookStock
    {
        /// <summary>
        /// 生成编号
        /// </summary>
        /// <param name="dc"></param>
        /// <returns></returns>
        private static string _createCode(db.dbEntities dc)
        {
            string Code = "BS" + DateTime.Now.ToString("yyyyMMdd");
            string result = (from a in dc.bks_BookStock
                             where a.stockCode.StartsWith(Code)
                             select a.stockCode).Max();
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
        public static string insert(db.bks_BookStock entry, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc); 

            _checkInput(entry);
            if(rui.typeHelper.isNullOrEmpty(entry.stockCode))
                entry.stockCode = _createCode(dc);
            else if (dc.bks_BookStock.Count(a => a.stockCode == entry.stockCode) > 0)
            { 
                rui.excptHelper.throwEx("编号已存在");
            }
            entry.rowID = ef.newGuid();
            //如果当前登录人就是经手人，则通过如下代码实现，如果通过下拉框选择经手人，则不需要如下的这行代码
            entry.userCode = db.bll.loginAdminHelper.getUserCode();
            entry.status = "初始";
            dc.bks_BookStock.Add(entry);
            dc.SaveChanges();
            return entry.rowID;
        }

        /// <summary>
        /// 检查录入
        /// </summary>
        /// <param name="entry"></param>
        private static void _checkInput(db.bks_BookStock entry) {

        }

        /// <summary>
        /// 修改
        /// </summary>
        /// <param name="entry"></param>
        /// <param name="dc"></param>
        public static void update(db.bks_BookStock entry, db.dbEntities dc)
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
                ef.Execute(" delete from dbo.bks_BookStock where rowID=@rowID ",new { rowID });
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

            string sql = " select stockCode from dbo.bks_BookStock where rowID=@rowID ";
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

            string sql = " select stockName from dbo.bks_BookStock where rowID=@rowID ";
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

            string sql = " select stockName from dbo.bks_BookStock where stockCode=@stockCode ";
            return rui.typeHelper.toString(ef.ExecuteScalar(sql, new { stockCode = keyCode }));
        }

        /// <summary>
        /// 获取实体
        /// </summary>
        /// <param name="rowID"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static db.bks_BookStock getEntryByRowID(string rowID, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc); 

            db.bks_BookStock entry = dc.bks_BookStock.SingleOrDefault(a => a.rowID == rowID);
            return entry;
        }
        public static db.bks_BookStock getEntryByCode(string keyCode, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc); 

            db.bks_BookStock entry = dc.bks_BookStock.SingleOrDefault(a => a.stockCode == keyCode);
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
            string sql = @" SELECT stockCode AS code,stockName AS name FROM dbo.bks_BookStock order by stockCode asc ";
            DataTable table = ef.ExecuteDataTable(sql);
            List<SelectListItem> list = rui.listHelper.dataTableToDdlList(table, has请选择, "");
            return list;
        }
    }
}
