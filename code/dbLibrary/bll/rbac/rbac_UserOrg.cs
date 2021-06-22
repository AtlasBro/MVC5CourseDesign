using LitJson;
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
    /// 用户组织
    /// </summary>
    public class rbac_UserOrg
    {
        /// <summary>
        /// 判断用户是否能够登录该组织
        /// </summary>
        /// <param name="userCode"></param>
        /// <param name="orgCode"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static bool isCanLogin(string userCode,string orgCode,db.dbEntities dc) {
            efHelper ef = new efHelper(ref dc); 
            string sql = " SELECT rowID FROM rbac_UserOrg WHERE isLogin='是' AND userCode=@userCode AND orgCode=@orgCode ";
            return ef.ExecuteExist(sql, new { userCode, orgCode });
        }

        /// <summary>
        /// 添加用户组织关系
        /// </summary>
        /// <param name="userCode"></param>
        /// <param name="orgCode"></param>
        /// <param name="dc"></param>
        public static void addUserOrg(string userCode,string orgCode,db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);
            db.rbac_UserOrg entry = dc.rbac_UserOrg.SingleOrDefault(a => a.orgCode == orgCode && a.userCode == userCode);
            if(entry == null)
            {
                entry = new db.rbac_UserOrg();
                dc.rbac_UserOrg.Add(entry);
                entry.rowID = ef.newGuid();
                entry.orgCode = orgCode;
                entry.userCode = userCode;
                entry.isLogin = "是";
                dc.SaveChanges();
            }
        }

        /// <summary>
        /// 下拉框绑定某一部门下的所有用户
        /// </summary>
        /// <param name="has请选择"></param>
        /// <param name="selectedValues"></param>
        /// <param name="deptCode"></param>
        /// <returns></returns>
        public static List<SelectListItem> bindDdl(bool has请选择 = false, string selectedValue = "", string deptCode = "")
        {
            efHelper ef = new efHelper();
            string sql = @" SELECT  rbac_User.userCode as code, rbac_User.userName as name
                            FROM rbac_User 
                            LEFT OUTER JOIN rbac_UserOrg ON rbac_User.userCode = rbac_UserOrg.userCode 
                            LEFT OUTER JOIN sbs_Dept ON rbac_UserOrg.deptCode = sbs_Dept.deptCode 
                            WHERE sbs_Dept.deptCode=@deptCode ";
            DataTable table = ef.ExecuteDataTable(sql, new { deptCode });
            List<SelectListItem> list = rui.listHelper.dataTableToDdlList(table, has请选择, selectedValue);
            return list;
        }

        /// <summary>
        /// 获取某个用户能够访问的组织列表
        /// </summary>
        /// <param name="userCode"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static string getOrgDdlJsonByUserCode(string userCode, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc); 

            string sql = @" SELECT sbs_Org.orgCode AS code,orgName AS name FROM rbac_UserOrg
                LEFT JOIN sbs_Org ON rbac_UserOrg.orgCode = sbs_Org.orgCode
                WHERE isLogin='是' and userCode=@userCode order by sbs_Org.orgCode desc ";
            DataTable table = ef.ExecuteDataTable(sql, new { userCode });

            return rui.jsonResult.dataTableToJsonStr(table);
        }
    }
}
