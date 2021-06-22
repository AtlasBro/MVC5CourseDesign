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
    /// 组织表
    /// </summary>
    public class sbs_Org
    {
        /// <summary>
        /// 新增
        /// </summary>
        /// <param name="entry"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static string insert(db.sbs_Org entry, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            if (dc.sbs_Org.Count(a => a.orgCode == entry.orgCode) > 0)
            {
                rui.excptHelper.throwEx("编号已存在");
            }

            entry.rowID = ef.newGuid();
            entry.importDate = DateTime.Now;
            entry.sourceFrom = "系统";
            dc.sbs_Org.Add(entry);
            dc.SaveChanges();
            db.bll.rbac_UserOrg.addUserOrg(rui.configHelper.adminName, entry.orgCode, dc);
            return entry.rowID;
        }

        /// <summary>
        /// 修改
        /// </summary>
        /// <param name="entry"></param>
        /// <param name="dc"></param>
        public static void update(db.sbs_Org entry, db.dbEntities dc)
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

            //定义连接对象，公用一个连接对象进行数据库操作
            try
            {
                //删除检测
                ef.checkCanDelete("sbs_Dept", "orgCode", keyCode, "组织下有部门,不允许删除");
                ef.checkCanDelete("sbs_Empl", "orgCode", keyCode, "组织下有员工,不允许删除");
                ef.checkCanDelete("rbac_UserPriv", "orgCode", keyCode, "组织下有用户权限,不允许删除");
                ef.checkCanDelete("af_AuditFlow", "orgCode", keyCode, "组织下有审批流节点,不允许删除");
                //删除相关表
                ef.beginTran();
                ef.Execute(" delete from rbac_UserOrg where orgCode=@orgCode ", new { orgCode = keyCode });
                ef.Execute(" delete from sbs_Org where orgCode=@orgCode ", new { orgCode = keyCode });
                ef.commit();
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

            string sql = " SELECT orgCode FROM sbs_Org WHERE rowID=@rowID ";
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

            string sql = " SELECT orgName FROM sbs_Org WHERE orgCode=@orgCode ";
            return rui.typeHelper.toString(ef.ExecuteScalar(sql, new { orgCode = code }));
        }

        /// <summary>
        /// 主键查询
        /// </summary>
        /// <param name="rowID"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static db.sbs_Org getEntryByRowID(string rowID, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);
            return dc.sbs_Org.Single(a => a.rowID == rowID);
        }

        /// <summary>
        /// 绑定所有组织
        /// </summary>
        /// <param name="has请选择"></param>
        /// <param name="selectedValue"></param>
        /// <returns></returns>
        public static List<SelectListItem> bindDdl(bool has请选择 = false, string selectedValue = "")
        {
            efHelper ef = new efHelper();
            string sql = " SELECT orgCode as code,orgName as name FROM dbo.sbs_Org order by orgCode desc ";
            DataTable table = ef.ExecuteDataTable(sql);
            return rui.listHelper.dataTableToDdlList(table, has请选择, selectedValue);
        }

        /// <summary>
        /// 绑定当前登录组织
        /// </summary>
        /// <param name="has请选择"></param>
        /// <returns></returns>
        public static List<SelectListItem> bindDdlForLogin(bool has请选择 = false)
        {
            List<SelectListItem> list = new List<SelectListItem>();
            rui.listHelper.add请选择(list, has请选择);
            list.Add(new SelectListItem() { Text = db.bll.loginAdminHelper.getOrgName(), Value = db.bll.loginAdminHelper.getOrgCode() });
            return list;
        }

        /// <summary>
        /// 导入数据，如果关联的表没有过来，一起导入
        /// </summary>
        /// <param name="selectedinExpression"></param>
        /// <param name="message"></param>
        /// <returns></returns>
        public static bool syncData(string selectedinExpression, ref string message)
        {
            bool result = rui.syncHelper.syncData("sbs_Org", selectedinExpression, ref message);
            return result;
        }
    }
}
