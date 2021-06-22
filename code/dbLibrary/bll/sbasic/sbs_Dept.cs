using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web.Mvc;

namespace db.bll
{
    public class sbs_Dept
    {

        /// <summary>
        /// 生成编号
        /// </summary>
        /// <param name="dc"></param>
        /// <returns></returns>
        private static string _createCode(db.dbEntities dc)
        {
            string Code = "B";
            string result = (from a in dc.sbs_Dept
                             where a.deptCode.StartsWith(Code)
                             select a.deptCode).Max();
            if (result != null)
            {
                Code = rui.stringHelper.codeNext(result, 3);
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
        public static string insert(db.sbs_Dept entry, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            _checkInput(entry);
            if (rui.typeHelper.isNullOrEmpty(entry.deptCode))
                entry.deptCode = _createCode(dc);
            else 
            {
                entry.deptCode = string.Format("{0}.{1}", entry.orgCode, entry.deptCode); 
                if (dc.sbs_Dept.Count(a => a.deptCode == entry.deptCode) > 0)
                    rui.excptHelper.throwEx("编号已存在");
            }
            entry.rowID = ef.newGuid();
            entry.importDate = DateTime.Now;
            entry.sourceFrom = "系统";
            dc.sbs_Dept.Add(entry);
            dc.SaveChanges();
            return entry.rowID;
        }

        /// <summary>
        /// 检查录入
        /// </summary>
        /// <param name="entry"></param>
        private static void _checkInput(db.sbs_Dept entry)
        {
            rui.dataCheck.checkNotNull(entry.orgCode, "部门");
            rui.dataCheck.checkNotNull(entry.orgCode, "组织");
            if (entry.deptCode == entry.upDeptCode)
                rui.excptHelper.throwEx("上级部门不能是自己");
        }

        /// <summary>
        /// 修改
        /// </summary>
        /// <param name="entry"></param>
        /// <param name="dc"></param>
        public static void update(db.sbs_Dept entry, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            _checkInput(entry);
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
                ef.checkCanDelete("sbs_Empl", "deptCode", keyCode, "部门下有职工,不允许删除");
                ef.checkCanDelete("sbs_Dept", "updeptCode", keyCode, "部门下有下级部门,不允许删除");

                //删除相关表
                ef.Execute(" delete from sbs_Dept where deptCode=@deptCode ", new { deptCode = keyCode });
            }
            catch (Exception ex)
            {
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

            string sql = " SELECT deptCode FROM sbs_Dept WHERE rowID=@rowID ";
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

            if (String.IsNullOrWhiteSpace(code))
                return "";
            string sql = " SELECT deptName FROM sbs_Dept WHERE deptCode=@deptCode ";
            return rui.typeHelper.toString(ef.ExecuteScalar(sql, new { deptCode = code }));
        }

        /// <summary>
        /// 主键查询(详情用)
        /// </summary>
        /// <param name="rowID"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static db.sbs_Dept getEntryByRowID(string rowID, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            return dc.sbs_Dept.Single(a => a.rowID == rowID);
        }

        /// <summary>
        /// 主键查询(详情用)
        /// </summary>
        /// <param name="rowID"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static db.sbs_Dept getEntryByCode(string code, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            return dc.sbs_Dept.Single(a => a.deptCode == code);
        }

        /// <summary>
        /// 通过组织获取部门列表 json
        /// </summary>
        /// <param name="orgCode"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static string getDdlJsonByOrgCode(string orgCode, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            string sql = " SELECT deptCode as code,deptName as name FROM dbo.sbs_Dept WHERE 1=1 and orgCode=@orgCode ";
            DataTable table = ef.ExecuteDataTable(sql, new { orgCode });

            return rui.jsonResult.dataTableToJsonStr(table);
        }

        /// <summary>
        /// 通过部门编号获取所属组织名称
        /// </summary>
        /// <param name="deptCode"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static string getOrgNameByDeptCode(string deptCode, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            string sql = @" SELECT orgName FROM sbs_Org 
                LEFT JOIN sbs_Dept ON sbs_Org.orgCode = sbs_Dept.orgCode
                WHERE deptCode=@deptCode ";
            return rui.typeHelper.toString(ef.ExecuteScalar(sql, new { deptCode }));
        }

        /// <summary>
        /// 绑定部门
        /// </summary>
        /// <param name="has请选择"></param>
        /// <param name="isLoginOrg">是否当前登录组织</param>
        /// <param name="selectedValue"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static List<SelectListItem> bindDdl(bool has请选择 = false, bool isLoginOrg = true, string selectedValue = "")
        {
            efHelper ef = new efHelper();
            string sql = " SELECT deptCode as code,deptName as name FROM dbo.sbs_Dept where 1=1 ";
            //当前登录组织内的部门
            if (isLoginOrg)
                sql += " and orgCode='" + db.bll.loginAdminHelper.getOrgCode() + "' ";
            DataTable table = ef.ExecuteDataTable(sql);
            List<SelectListItem> list = rui.listHelper.dataTableToDdlList(table, has请选择, selectedValue);
            return list;
        }

        /// <summary>
        /// 导入数据，如果关联的表没有过来，一起导入
        /// 上级关联的表有：rbac_Org
        /// </summary>
        /// <param name="sysTableName"></param>
        /// <param name="selectedList"></param>
        /// <param name="message"></param>
        /// <returns></returns>
        public static bool syncData(string selectedinExpression, ref string message, db.dbEntities dc)
        {
            efHelper ef = new efHelper();
            bool result = rui.syncHelper.syncData("sbs_Dept", selectedinExpression, ref message);

            dealUpDeptCode(selectedinExpression, dc);

            //导入缺少的组织
            #region
            {
                string sql = @"SELECT DISTINCT orgCode FROM dbo.sbs_Dept
                            except
                            SELECT orgCode FROM sbs_Org ";
                DataTable table = ef.ExecuteDataTable(sql);
                string selectInExpr = rui.dbTools.getInExpression(table, "orgCode");
                if (selectInExpr.Length > 0)
                    result = result && db.bll.sbs_Org.syncData(selectInExpr, ref message);
            }
            #endregion

            return result;
        }

        /// <summary>
        /// //处理新导入数据的上级部门
        /// </summary>
        /// <param name="selectedinExpression"></param>
        /// <param name="dc"></param>
        private static void dealUpDeptCode(string selectedinExpression, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            string sql = "select deptCode from sbs_Dept where deptCode in @deptCode ";
            DataTable table = ef.ExecuteDataTable(sql, new { deptCode = rui.dbTools.getDpList(selectedinExpression) });
            foreach (DataRow row in table.Rows)
            {
                string deptCode = row["deptCode"].ToString();
                if (deptCode.Length != 6)
                    ef.Execute("update sbs_Dept set upDeptCode=@upDeptCode where deptCode=@deptCode ",
                        new { upDeptCode = deptCode.Substring(0, deptCode.Length - 2), deptCode });
            }
        }
    }
}