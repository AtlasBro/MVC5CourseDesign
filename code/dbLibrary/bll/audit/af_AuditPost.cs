using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;

namespace db.bll
{
    /// <summary>
    /// 审批职务
    /// wzrui 2019-06-16
    /// </summary>
    public class af_AuditPost
    {
        /// <summary>
        /// 生成编号
        /// </summary>
        /// <param name="dc"></param>
        /// <returns></returns>
        private static string _createCode(db.dbEntities dc)
        {
            string Code = "M" + DateTime.Now.ToString("yyyyMMdd");
            string result = (from a in dc.af_AuditPost
                             where a.postCode.StartsWith(Code)
                             select a.postCode).Max();
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
        public static string insert(db.af_AuditPost entry, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            if (rui.typeHelper.isNullOrEmpty(entry.postCode))
                entry.postCode = _createCode(dc);
            else if (dc.af_AuditPost.Count(a => a.postCode == entry.postCode) > 0)
            {
                rui.excptHelper.throwEx("编号已存在");
            }
            entry.rowID = ef.newGuid();
            entry.sourceFrom = "新增";
            entry.importDate = DateTime.Now;
            dc.af_AuditPost.Add(entry);
            dc.SaveChanges();
            return entry.rowID;
        }

        /// <summary>
        /// 修改
        /// </summary>
        /// <param name="entry"></param>
        /// <param name="dc"></param>
        public static void update(db.af_AuditPost entry, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

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
                string keyCode = getCodeByRowID(rowID, dc);
                //删除前检查


                //删除
                ef.Execute(" DELETE from af_AuditPost where rowID=@rowID ", new { rowID = rowID });
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex, true);
            }
        }

        /// <summary>
        /// 绑定下拉框
        /// </summary>
        /// <param name="has请选择"></param>
        /// <param name="selectedValues"></param>
        /// <returns></returns>
        public static List<SelectListItem> bindDdl(bool has请选择 = false, string selectedValue = "")
        {
            efHelper ef = new efHelper();
            string sql = @" SELECT postCode AS code,postName AS name FROM dbo.af_AuditPost  ";
            DataTable table = ef.ExecuteDataTable(sql);
            List<SelectListItem> list = rui.listHelper.dataTableToDdlList(table, has请选择, selectedValue);
            return list;
        }

        /// <summary>
        /// 通过rowID获取主键
        /// </summary>
        /// <param name="rowID"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static string getCodeByRowID(string rowID, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            string sql = "select postCode from af_AuditPost where rowID=@rowID ";
            return rui.typeHelper.toString(ef.ExecuteScalar(sql, new { rowID }));
        }

        /// <summary>
        /// 通过rowID获取名称
        /// </summary>
        /// <param name="rowID"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static string getNameByRowID(string rowID, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            string sql = "select postName from af_AuditPost where rowID=@rowID ";
            return rui.typeHelper.toString(ef.ExecuteScalar(sql, new { rowID }));
        }

        /// <summary>
        /// 通过编号获取名称
        /// </summary>
        /// <param name="keyCode"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static string getNameByCode(string keyCode, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            string sql = "select postName from af_AuditPost where postCode=@postCode ";
            return rui.typeHelper.toString(ef.ExecuteScalar(sql, new { postCode = keyCode }));
        }

        /// <summary>
        /// 获取实体
        /// </summary>
        /// <param name="rowID"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static db.af_AuditPost getEntryByRowID(string rowID, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            db.af_AuditPost entry = dc.af_AuditPost.Single(a => a.rowID == rowID);
            return entry;
        }

        /// <summary>
        /// 获取实体
        /// </summary>
        /// <param name="keyCode"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static db.af_AuditPost getEntryByCode(string keyCode, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            db.af_AuditPost entry = dc.af_AuditPost.SingleOrDefault(a => a.postCode == keyCode);
            return entry;
        }

        /// <summary>
        /// 是否部门职务任职
        /// </summary>
        /// <param name="postCode"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static string isDeptPost(string postCode, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            string sql = " SELECT isDeptPost FROM af_AuditPost WHERE postCode=@postCode ";
            return rui.typeHelper.toString(ef.ExecuteScalar(sql, new { postCode }));
        }

        public static List<SelectListItem> bindDdlForPrintTag(bool has请选择 = false, string selectedValue = "")
        {
            efHelper ef = new efHelper();

            DataTable table = new DataTable();
            table.Columns.Add("code",typeof(string));
            table.Columns.Add("name", typeof(string));
            table.Rows.Add(new object[] { "经办人", "经办人" });
            table.Rows.Add(new object[] { "部门领导", "部门领导" });
            table.Rows.Add(new object[] { "分管领导", "分管领导" });
            table.Rows.Add(new object[] { "财务", "财务" });

            List<SelectListItem> list = rui.listHelper.dataTableToDdlList(table, has请选择, selectedValue);
            return list;
        }
    }
}
