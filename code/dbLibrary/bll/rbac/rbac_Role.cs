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
    /// rui
    /// 角色表
    /// </summary>
    public class rbac_Role
    {
        /// <summary>
        /// 生成编号
        /// </summary>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static string _createCode(db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            string Code = "R";
            string result = (from a in dc.rbac_Role
                             where a.roleCode.StartsWith(Code)
                             select a.roleCode).Max();
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
        public static string insert(db.rbac_Role entry, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            if (rui.typeHelper.isNullOrEmpty(entry.roleCode))
                entry.roleCode = db.bll.rbac_Role._createCode(dc);

            entry.rowID = ef.newGuid();
            dc.rbac_Role.Add(entry);
            dc.SaveChanges();
            return entry.rowID;
        }

        /// <summary>
        /// 修改
        /// </summary>
        /// <param name="entry"></param>
        /// <param name="dc"></param>
        public static void update(db.rbac_Role entry, db.dbEntities dc)
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
                {
                    ef.checkCanDeleteIn("af_AuditNode", "auditRoleCodes", keyCode, "已关联审批流，不能删除");
                    ef.checkCanDeleteIn("af_AuditNode", "selectRoleCodes", keyCode, "已关联审批流,不能删除");
                }
                //删除相关表（角色用户关联，角色授权，角色表）
                {
                    ef.beginTran();
                    var cmdPara = new { roleCode = keyCode };
                    ef.Execute(" DELETE FROM rbac_RoleUser WHERE roleCode=@roleCode ", cmdPara);
                    ef.Execute(" DELETE FROM rbac_RolePriv WHERE roleCode=@roleCode ", cmdPara);
                    ef.Execute(" DELETE FROM rbac_Role WHERE roleCode=@roleCode ", cmdPara);
                    ef.commit();
                }
            }
            catch (Exception ex)
            {
                ef.rollBack();
                rui.logHelper.log(ex, true);
            }
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

            string sql = " SELECT roleCode FROM rbac_Role WHERE rowID=@rowID ";
            return rui.typeHelper.toString(ef.ExecuteScalar(sql, new { rowID }));
        }

        /// <summary>
        /// 获取实体
        /// </summary>
        /// <param name="rowID"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static db.rbac_Role getEntryByRowID(string rowID, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            return dc.rbac_Role.Single(a => a.rowID == rowID);
        }

        /// <summary>
        /// 绑定下拉框
        /// </summary>
        /// <param name="has请选择"></param>
        /// <returns></returns>
        public static List<SelectListItem> bindDdl(bool has请选择 = false)
        {
            efHelper ef = new efHelper();
            string sql = @" SELECT roleCode AS code,roleName AS name FROM dbo.rbac_Role order by roleCode asc ";
            DataTable table = ef.ExecuteDataTable(sql);
            List<SelectListItem> list = rui.listHelper.dataTableToDdlList(table, has请选择, "");
            return list;
        }
    }
}
