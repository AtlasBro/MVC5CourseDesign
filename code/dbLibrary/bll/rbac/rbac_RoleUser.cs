using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db.bll
{
    public class rbac_RoleUser
    {

        /// <summary>
        /// 获取实体
        /// </summary>
        /// <param name="rowID"></param>
        /// <returns></returns>
        public db.rbac_RoleUser getEntryByRowID(string rowID, db.dbEntities dc)
        {
            db.efHelper ef = new db.efHelper(ref dc);
            return dc.rbac_RoleUser.Single(a => a.rowID == rowID);
        }

        /// <summary>
        /// 向角色中添加用户
        /// </summary>
        /// <param name="orgCode">组织编号</param>
        /// <param name="roleCode">角色编码</param>
        /// <param name="userCode">用户编码</param>
        /// <param name="dc"></param>
        public static void addRoleUser(string orgCode, string roleCode, string userCode, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);
            db.rbac_RoleUser entryRole = dc.rbac_RoleUser.SingleOrDefault(a => a.roleCode == "R0001" && a.userCode == userCode);
            if (entryRole == null)
            {
                entryRole = new db.rbac_RoleUser();
                entryRole.rowID = ef.newGuid();
                entryRole.userCode = userCode;
                entryRole.roleCode = roleCode;
                entryRole.orgCode = orgCode;
                dc.rbac_RoleUser.Add(entryRole);
                dc.SaveChanges();
            }
        }

        /// <summary>
        /// 添加角色用户关联
        /// </summary>
        /// <param name="roleRowID">角色行号</param>
        /// <param name="userCodes">多个用户编号</param>
        /// <param name=""></param>
        public static void addUsers(string roleRowID, string userCodes, db.dbEntities dc)
        {
            db.efHelper ef = new db.efHelper(ref dc);
            string orgCode = db.bll.loginAdminHelper.getOrgCode();
            string roleCode = db.bll.rbac_Role.getCodeByRowID(roleRowID, dc);
            List<string> userCodeList = rui.dbTools.getList(userCodes);
            foreach (string userCode in userCodeList)
            {
                ef.Execute(" INSERT INTO rbac_RoleUser( rowID, roleCode, userCode,orgCode) VALUES (@rowID, @roleCode, @userCode, @orgCode) ",
                    new { rowID = ef.newGuid(), roleCode, userCode, orgCode });
            }
        }

        /// <summary>
        /// 删除角色用户关联
        /// </summary>
        /// <param name="roleRowID">角色行号</param>
        /// <param name="userCodes">多个用户编号</param>
        /// <param name=""></param>
        public static void deleteUsers(string roleRowID, string userCodes, db.dbEntities dc)
        {
            db.efHelper ef = new db.efHelper(ref dc);

            string orgCode = db.bll.loginAdminHelper.getOrgCode();
            string roleCode = db.bll.rbac_Role.getCodeByRowID(roleRowID, dc);
            List<string> userCodeList = rui.dbTools.getList(userCodes);
            foreach (string userCode in userCodeList)
            {
                ef.Execute(" DELETE FROM rbac_RoleUser WHERE orgCode=@orgCode AND roleCode=@roleCode AND userCode=@userCode ",
                    new { roleCode, userCode, orgCode });
            }
        }

        /// <summary>
        /// 删除
        /// </summary>
        /// <param name="rowID"></param>
        public static void delete(string rowID, db.dbEntities dc)
        {
            db.efHelper ef = new db.efHelper(ref dc);

            try
            {
                //删除相关表
                {
                    string sql = " DELETE FROM dbo.rbac_RoleUser where rowID=@rowID ";
                    ef.Execute(sql, new { rowID });
                }
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex, true);
            }
        }
    }
}
