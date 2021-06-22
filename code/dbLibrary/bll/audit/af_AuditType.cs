using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace db.bll
{
    /// <summary>
    /// 审批类型
    /// </summary>
    public class af_AuditType
    {
        /// <summary>
        /// 新增
        /// </summary>
        /// <param name="entry"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static string insert(db.af_AuditType entry, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            entry.rowID = ef.newGuid();
            dc.af_AuditType.Add(entry);
            dc.SaveChanges();
            return entry.rowID;
        }

        /// <summary>
        /// 修改
        /// </summary>
        /// <param name="entry"></param>
        /// <param name="dc"></param>
        public static void update(db.af_AuditType entry, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc); 

            efHelper.entryUpdate(entry, dc);
            dc.SaveChanges();
        }

        /// <summary>
        /// 删除
        /// </summary>
        /// <param name="keyCode"></param>
        public static void delete(string keyCode,db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc); 
            try
            {
                //删除检测
                ef.checkCanDelete("af_AuditFlow", "flowCode", keyCode, "审批单据类型下已创建审批流，不允许删除");
                //删除相关表(事务)
                ef.Execute("delete from af_AuditType where auditTypeCode=@auditTypeCode ", new { auditTypeCode = keyCode });
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex,true);
            }
        }

        /// <summary>
        /// 绑定所有审批单据类型
        /// </summary>
        /// <param name="has请选择"></param>
        /// <returns></returns>
        public static List<SelectListItem> bindDdl(bool has请选择 = false)
        {
            efHelper ef = new efHelper();
            string sql = @" SELECT auditTypeCode AS code,auditTypeName AS name FROM dbo.af_AuditType ";
            DataTable table = ef.ExecuteDataTable(sql);
            List<SelectListItem> list = rui.listHelper.dataTableToDdlList(table, has请选择, "");
            return list;
        }

        /// <summary>
        /// 通过rowID获取主键
        /// </summary>
        /// <param name="rowID"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static string getKeyByRowID(string rowID, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc); 

            string sql = " SELECT auditTypeCode FROM af_AuditType WHERE rowID=@rowID ";
            return rui.typeHelper.toString(ef.ExecuteScalar(sql, new { rowID }));
        }

        /// <summary>
        /// 通过编号获取名称
        /// </summary>
        /// <param name="code"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static string getNameByCode(string code, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc); 

            string sql = " SELECT auditTypeCode FROM af_AuditType WHERE auditTypeCode=@auditTypeCode ";
            return rui.typeHelper.toString(ef.ExecuteScalar(sql, new { auditTypeCode = code }));
        }

        /// <summary>
        /// 获取实体
        /// </summary>
        /// <param name="rowID"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static db.af_AuditType getEntryByRowID(string rowID, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc); 

            return dc.af_AuditType.Single(a => a.rowID == rowID);
        }
        public static db.af_AuditType getEntryByCode(string keyCode, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc); 

            return dc.af_AuditType.Single(a => a.auditTypeCode == keyCode);
        }
    }
}
