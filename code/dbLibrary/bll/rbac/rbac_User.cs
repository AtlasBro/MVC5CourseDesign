using LitJson;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;

namespace db.bll
{
    /// <summary>
    /// rui
    /// 用户表
    /// </summary>
    public class rbac_User
    {

        /// <summary>
        /// 修改
        /// </summary>
        /// <param name="entry"></param>
        /// <param name="dc"></param>
        public static void update(db.rbac_User entry, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            //变更用户组织部门对应表的所属部门，可登录和项目权限
            string orgCode = db.bll.loginAdminHelper.getOrgCode();
            db.rbac_UserOrg orgEntry = dc.rbac_UserOrg.SingleOrDefault(a => a.orgCode == orgCode && a.userCode == entry.userCode);
            if (orgEntry == null)
            {
                orgEntry = new db.rbac_UserOrg();
                orgEntry.userCode = entry.userCode;
                orgEntry.orgCode = orgCode;
                dc.rbac_UserOrg.Add(orgEntry);
            }
            orgEntry.deptCode = entry.deptCode;
            orgEntry.isLogin = entry.isLogin;

            //如果职工的组织等于登录组织，则同步职工的部门
            db.sbs_Empl emplEntry = dc.sbs_Empl.SingleOrDefault(a => a.emplCode == entry.userCode && a.orgCode == orgCode);
            if (emplEntry != null)
            {
                emplEntry.deptCode = orgEntry.deptCode;
            }

            if (rui.typeHelper.isNullOrEmpty(orgEntry.deptCode) == false && rui.typeHelper.isNullOrEmpty(orgEntry.isLogin))
                rui.excptHelper.throwEx("可登录后，必须设置部门");

            efHelper.entryUpdate(entry, dc, "deptCode,isLogin");
            dc.SaveChanges();
        }

        /// <summary>
        /// 超级管理员不允许删除
        /// 删除前检查所有用到职工的位置
        /// 删除时，将角色关联和用户权限一起删除
        /// </summary>
        /// <param name="keyCode"></param>
        public static void delete(string keyCode, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            try
            {
                //如果是超级管理员，不允许删除
                string sql = " SELECT rowID FROM rbac_User WHERE userCode=@userCode AND isAdmin='是' ";
                if (ef.ExecuteExist(sql, new { userCode = keyCode }))
                    rui.excptHelper.throwEx("超级管理员不允许删除");
                //删除检测
                ef.checkCanDelete("af_AuditPostUser", "userCode", keyCode, "已安排审批职务");
                ef.checkCanDeleteIn("af_AuditNode", "auditUserCodes", keyCode + ",", "已关联审批流，不能删除");
                ef.checkCanDeleteIn("af_AuditNode", "selectUserCodes", keyCode + ",", "已关联审批流,不能删除");
                ef.checkCanDelete("af_AuditLog", "relatedUserCode", keyCode, "已创建业务单据,不允许删除");
                ef.checkCanDelete("af_AuditLog", "userCode", keyCode, "已审批单据,不允许删除");
                //删除相关表（用户授权表，用户角色表，用户表）
                ef.beginTran();
                var cmdPara = new { userCode = keyCode };
                ef.Execute(" DELETE FROM rbac_UserPriv WHERE userCode=@userCode ", cmdPara);
                ef.Execute(" DELETE FROM rbac_RoleUser WHERE userCode=@userCode ", cmdPara);
                ef.Execute(" DELETE FROM rbac_User WHERE userCode=@userCode ", cmdPara);
                ef.Execute(" DELETE FROM rbac_UserOrg where userCode=@userCode ", cmdPara);
                ef.Execute(" DELETE FROM sys_UCColumn where userCode=@userCode ", cmdPara);
                ef.Execute(" DELETE FROM sys_UCPager where userCode=@userCode ", cmdPara);
                ef.Execute(" DELETE FROM af_AuditPostUser where userCode=@userCode ", cmdPara);
                ef.commit();
            }
            catch (Exception ex)
            {
                ef.rollBack();
                rui.logHelper.log(ex, true);
            }
        }

        /// <summary>
        /// 设置是否可以登录
        /// </summary>
        /// <param name="table"></param>
        /// <param name="dc"></param>
        public static void setIsLogin(DataTable table, string fieldName, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);
            string orgCode = db.bll.loginAdminHelper.getOrgCode();
            string sql = @" SELECT userCode FROM rbac_UserOrg WHERE isLogin = '是' AND orgCode = @orgCode AND userCode IN @userCode ";
            DataTable isLoginTable = ef.ExecuteDataTable(sql, new { orgCode, userCode = rui.dbTools.getDpList(table, fieldName) });
            foreach (DataRow row in table.Rows)
            {
                string emplCode = row[fieldName].ToString();
                if (isLoginTable.Select(string.Format("userCode='{0}'", emplCode)).Length > 0)
                    row["isLogin"] = "是";
                else
                    row["isLogin"] = "否";
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

            string sql = " SELECT userCode FROM rbac_User WHERE rowID=@rowID ";
            return rui.typeHelper.toString(ef.ExecuteScalar(sql, new { rowID }));
        }

        /// <summary>
        /// 通过code获取Name
        /// </summary>
        /// <param name="code"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static string getNameByCode(string code, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            string sql = " SELECT userName FROM rbac_User WHERE userCode=@userCode ";
            return rui.typeHelper.toString(ef.ExecuteScalar(sql, new { userCode = code }));
        }

        /// <summary>
        /// 获取多个用户的名称(编号)，参数是a,b,c,格式
        /// </summary>
        /// <param name="userCodes"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static string getNameAndCodeByCodes(string userCodes, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            if (String.IsNullOrWhiteSpace(userCodes))
                return "";

            string sql = @"  SELECT userName+'('+userCode+')' AS userName FROM rbac_User  WHERE userCode IN @userCode ";
            DataTable table = ef.ExecuteDataTable(sql, new { userCode = rui.dbTools.getDpList(userCodes) });
            return rui.dbTools.getShowExpression(table, "userName");
        }

        /// <summary>
        /// 获取多个用户的名称(编号)，参数是a,b,c,格式
        /// </summary>
        /// <param name="userCodes"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static string getNamesByCodes(string userCodes, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            if (String.IsNullOrWhiteSpace(userCodes))
                return "";

            string sql = @" SELECT userName FROM rbac_User WHERE userCode IN @userCode ";
            DataTable table = ef.ExecuteDataTable(sql, new { userCode = rui.dbTools.getDpList(userCodes) });
            return rui.dbTools.getShowExpression(table, "userName");
        }

        /// <summary>
        /// 主键查询
        /// </summary>
        /// <param name="rowID"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static db.rbac_User getEntryByRowID(string rowID, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            db.rbac_User entry = dc.rbac_User.Single(a => a.rowID == rowID);
            string orgCode = db.bll.loginAdminHelper.getOrgCode();
            db.rbac_UserOrg orgEntry = dc.rbac_UserOrg.SingleOrDefault(a => a.orgCode == orgCode && a.userCode == entry.userCode);
            if (orgEntry != null)
            {
                entry.deptCode = orgEntry.deptCode;
                entry.isLogin = orgEntry.isLogin;
            }
            return entry;
        }

        /// <summary>
        /// 利用其它表创建关联的登录用户
        /// </summary>
        /// <param name="userCode"></param>
        /// <param name="userName"></param>
        /// <param name="orgCode"></param>
        /// <param name="deptCode"></param>
        /// <param name="dc"></param>
        public static string createRelatedUser(string userCode, string userName, string orgCode, string deptCode, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            //创建用户表数据

            db.rbac_User entryUser = dc.rbac_User.SingleOrDefault(a => a.userCode == userCode);
            if (entryUser == null)
            {
                entryUser = new db.rbac_User();
                dc.rbac_User.Add(entryUser);

                entryUser.rowID = ef.newGuid();
                entryUser.userCode = userCode;
                entryUser.userName = userName;
                entryUser.password = rui.encryptHelper.toMD5(entryUser.userCode);
                entryUser.isAdmin = "否";
                entryUser.relatedCode = userCode;
            }

            //创建用户组织关联表数据

            db.rbac_UserOrg entryOrg = dc.rbac_UserOrg.SingleOrDefault(a => a.userCode == userCode && a.orgCode == orgCode);
            if (entryOrg == null)
            {
                entryOrg = new db.rbac_UserOrg();
                dc.rbac_UserOrg.Add(entryOrg);

                entryOrg.rowID = ef.newGuid();
                entryOrg.userCode = userCode;
                entryOrg.orgCode = orgCode;
                entryOrg.deptCode = deptCode;
                //有部门，则允许登录
                if (rui.typeHelper.isNotNullOrEmpty(entryOrg.deptCode))
                    entryOrg.isLogin = "是";
            }
            else
                rui.excptHelper.throwEx("已经创建过该组织内的登录账号");

            dc.SaveChanges();
            return entryUser.rowID;
        }

        /// <summary>
        /// 获取用户所属的主部门
        /// </summary>
        /// <param name="userCode"></param>
        /// <param name="orgCode"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static string getDeptCode(string userCode, string orgCode, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            string sql = @" SELECT deptCode FROM rbac_UserOrg WHERE orgCode=@orgCode AND userCode=@userCode ";
            return rui.typeHelper.toString(ef.ExecuteScalar(sql, new { orgCode, userCode }));
        }

        /// <summary>
        /// 更改密码
        /// </summary>
        /// <param name="oldPW"></param>
        /// <param name="newPW"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static bool changePW(string oldPW, string newPW, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            string userCode = rui.sessionHelper.getValue("admin.userCode");
            oldPW = rui.encryptHelper.toMD5(oldPW);
            newPW = rui.encryptHelper.toMD5(newPW);

            string sql = " UPDATE rbac_User SET password=@passwordNew WHERE userCode=@userCode AND password=@passwordOld ";
            if (ef.Execute(sql, new { passwordNew = newPW, userCode, passwordOld = oldPW }) > 0)
                return true;
            else
                return false;
        }

        /// <summary>
        /// 重置密码
        /// </summary>
        /// <param name="userCode"></param>
        /// <param name="dc"></param>
        public static void resetPW(string userCode, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);
            string password = rui.encryptHelper.toMD5(userCode);
            string sql = string.Format(" UPDATE dbo.rbac_User SET password='{0}' WHERE userCode='{1}' ", password, userCode);
            ef.Execute(sql);
        }

        /// <summary>
        /// 允许登录
        /// </summary>
        /// <param name="keyFieldValues"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static string allowLogin(string keyFieldValues, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            List<string> KeyFieldList = rui.dbTools.getList(keyFieldValues);
            Dictionary<string, string> errorDic = new Dictionary<string, string>();

            string orgCode = db.bll.loginAdminHelper.getOrgCode();
            string sqlCheck = @" SELECT userCode,isLogin,deptCode FROM dbo.rbac_UserOrg WHERE userCode in @userCode AND orgCode=@orgCode 
                    and (isLogin='是' or isnull(deptCode,'')='') ";
            DataTable table = ef.ExecuteDataTable(sqlCheck, new { userCode = KeyFieldList, orgCode });

            foreach (string userCode in KeyFieldList)
            {
                try
                {
                    DataRow[] rows = table.Select("userCode='" + userCode + "'");
                    rui.dbTools.checkRowFieldValue(rows, "isLogin", "是", "已允许登录");
                    rui.dbTools.checkRowFieldValue(rows, "deptCode", "", "未设定登录部门");

                    string sql = @" UPDATE rbac_UserOrg SET isLogin='是' WHERE isnull(deptCode,'') != '' 
                        and isLogin='否' and orgCode=@orgCode AND userCode=@userCode ";
                    ef.Execute(sql, new { orgCode, userCode });
                }
                catch (Exception ex)
                {
                    errorDic.Add(userCode, rui.excptHelper.getExMsg(ex));
                    rui.logHelper.log(ex);
                }
            }
            return rui.dbTools.getBatchMsg("批量允许登录", KeyFieldList.Count, errorDic);
        }

        /// <summary>
        /// 禁用登录
        /// </summary>
        /// <param name="keyFieldValues"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static string noLogin(string keyFieldValues, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            List<string> KeyFieldList = rui.dbTools.getList(keyFieldValues);
            Dictionary<string, string> errorDic = new Dictionary<string, string>();

            string orgCode = db.bll.loginAdminHelper.getOrgCode();
            string sqlCheck = @" SELECT userCode,isLogin FROM dbo.rbac_UserOrg WHERE userCode in @userCode AND orgCode=@orgCode and isLogin='否' ";
            DataTable table = ef.ExecuteDataTable(sqlCheck, new { userCode = KeyFieldList, orgCode });

            foreach (string userCode in KeyFieldList)
            {
                try
                {
                    DataRow[] rows = table.Select("userCode='" + userCode + "'");
                    rui.dbTools.checkRowFieldValue(rows, "isLogin", "否", "已禁止登录");

                    string sql = @" UPDATE rbac_UserOrg SET isLogin='否' WHERE  
                             isLogin='是' and orgCode=@orgCode AND userCode=@userCode ";
                    ef.Execute(sql, new { orgCode, userCode });
                }
                catch (Exception ex)
                {
                    errorDic.Add(userCode, rui.excptHelper.getExMsg(ex));
                    rui.logHelper.log(ex);
                }
            }
            return rui.dbTools.getBatchMsg("批量禁止登录", KeyFieldList.Count, errorDic);
        }

        /// <summary>
        /// 绑定所有账户
        /// </summary>
        /// <param name="has请选择"></param>
        /// <param name="selectedValue"></param>
        /// <returns></returns>
        public static List<SelectListItem> bindDdl(bool has请选择 = false, string selectedValue = "")
        {
            efHelper ef = new efHelper();
            string sql = string.Format(@" SELECT userCode AS code,userName AS name FROM sv_rbac_User where isLogin='是' and orgCode=@orgCode ");
            DataTable table = ef.ExecuteDataTable(sql, new { orgCode = db.bll.loginAdminHelper.getOrgCode() });
            List<SelectListItem> list = rui.listHelper.dataTableToDdlList(table, has请选择, selectedValue);
            return list;
        }

        /// <summary>
        /// 根据部门获用户
        /// </summary>
        /// <param name="deptCode"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static string getUserDdlJsonByDeptCode(string deptCode, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            string orgCode = db.bll.loginAdminHelper.getOrgCode();
            string sql = @" SELECT rbac_User.userCode AS code,userName AS name FROM rbac_User
                 INNER JOIN rbac_UserOrg ON rbac_User.userCode = rbac_UserOrg.userCode
                 WHERE isLogin='是' and orgCode=@orgCode AND deptCode=@deptCode ";
            DataTable table = ef.ExecuteDataTable(sql, new { orgCode, deptCode });

            return rui.jsonResult.dataTableToJsonStr(table);
        }
    }
}
