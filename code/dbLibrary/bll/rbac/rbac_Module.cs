using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Mvc;

namespace db.bll
{
    /// <summary>
    /// rui
    /// 系统模块表
    /// </summary>
    public class rbac_Module
    {
        /// <summary>
        /// 通过rowID获取主键
        /// </summary>
        /// <param name="rowID"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static string getCodeByRowID(string rowID, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            string sql = " SELECT moduleCode FROM rbac_Module WHERE rowID=@rowID ";
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

            string sql = " SELECT moduleName FROM rbac_Module WHERE moduleCode=@moduleCode ";
            return rui.typeHelper.toString(ef.ExecuteScalar(sql, new { moduleCode = code }));
        }

        /// <summary>
        /// 获取实体
        /// </summary>
        /// <param name="rowID"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static db.rbac_Module getEntryByRowID(string rowID, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            return dc.rbac_Module.Single(a => a.rowID == rowID);
        }

        public static db.rbac_Module getEntryByCode(string keyCode, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            return dc.rbac_Module.Single(a => a.moduleCode == keyCode);
        }

        /// <summary>
        /// 新增
        /// </summary>
        /// <param name="entry"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static string insert(db.rbac_Module entry, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            entry.rowID = ef.newGuid();
            dc.rbac_Module.Add(entry);
            dc.SaveChanges();
            return entry.rowID;
        }

        /// <summary>
        /// 修改
        /// </summary>
        /// <param name="entry"></param>
        /// <param name="dc"></param>
        public static void update(db.rbac_Module entry, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            efHelper.entryUpdate(entry, dc);
            dc.SaveChanges();
        }

        /// <summary>
        /// 删除
        /// </summary>
        /// <param name="keyCode"></param>
        /// <param name="dc"></param>
        public static void delete(string keyCode, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            try
            {
                //删除检测
                ef.checkCanDelete("rbac_Resource", "moduleCode", keyCode, "模块下有资源,不允许删除");
                //删除相关表
                ef.Execute("delete from rbac_Module where moduleCode=@moduleCode ", new { moduleCode = keyCode });
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex, true);
            }
        }

        /// <summary>
        /// 批量保存
        /// </summary>
        /// <param name="moduleCodeList"></param>
        /// <param name="showOrderList"></param>
        /// <returns></returns>
        public static string batchSave(List<string> moduleCodeList, List<string> showOrderList, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            Dictionary<string, string> errorDic = new Dictionary<string, string>();
            for (int i = 0; i < moduleCodeList.Count; i++)
            {
                try
                {
                    string sql = " UPDATE rbac_Module SET showOrder=@showOrder WHERE moduleCode=@moduleCode ";
                    if (ef.Execute(sql, new { showOrder = showOrderList[i], moduleCode = moduleCodeList[i] }) == 0)
                        rui.excptHelper.throwEx("数据未变更");
                }
                catch (Exception ex)
                {
                    errorDic.Add(moduleCodeList[i], rui.excptHelper.getExMsg(ex));
                    rui.logHelper.log(ex);
                }
            }
            return rui.dbTools.getBatchMsg("批量保存", moduleCodeList.Count, errorDic);
        }

        /// <summary>
        /// 绑定下拉框
        /// </summary>
        /// <param name="has请选择"></param>
        /// <returns></returns>
        public static List<SelectListItem> bindDdl(bool has请选择 = false)
        {
            efHelper ef = new efHelper();
            string sql = @"SELECT moduleCode AS code,moduleName AS name FROM dbo.rbac_Module order by showOrder asc ";
            DataTable table = ef.ExecuteDataTable(sql);
            List<SelectListItem> list = rui.listHelper.dataTableToDdlList(table, has请选择, "");
            return list;
        }
    }
}
