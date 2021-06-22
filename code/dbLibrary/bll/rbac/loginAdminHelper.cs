using System.Collections.Generic;
using System.Data;
using System.Web.Mvc;

namespace db.bll
{
    /// <summary>
    /// 管理员登录
    /// </summary>
    public class loginAdminHelper
    {
        /// <summary>
        /// 用户登录,并获取用户的权限并保存到Session变量中
        /// 用户编号：admin.userCode
        /// 用户名称：admin.userName
        /// 部门编号：admin.deptCode
        /// 部门名称：admin.deptName
        /// 组织编号：admin.orgCode
        /// 组织名称：admin.orgName
        /// 用户权限：admin.priv
        /// 所有需要权限控制的资源：admin.resource
        /// </summary>
        /// <param name="userCode">登录用户标识</param>
        /// <param name="password">登录密码</param>
        /// <param name="orgCode">登录的组织</param>
        /// <param name="accessType">可访问的资源类型</param>
        public static void login(string userCode, string password, string orgCode, dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);
            if (rui.loginHelper.checkLogin(userCode, password))
            {
                string sql = @" SELECT rbac_User.userCode,userName,rbac_UserOrg.deptCode 
                            FROM rbac_User 
                            LEFT JOIN rbac_UserOrg ON rbac_User.userCode=rbac_UserOrg.userCode AND rbac_UserOrg.orgCode=@orgCode 
                            WHERE isLogin='是' AND rbac_User.userCode=@userCode AND password=@password ";
                DataRow row = ef.ExecuteDataRow(sql, new { orgCode, userCode, password });
                if (row != null)
                {
                    string deptCode = row["deptCode"].ToString();
                    rui.sessionHelper.saveValue<string>("admin.userCode", userCode);
                    rui.sessionHelper.saveValue<string>("admin.userName", row["userName"].ToString());
                    rui.sessionHelper.saveValue<string>("admin.orgCode", orgCode);
                    rui.sessionHelper.saveValue<string>("admin.orgName", db.bll.sbs_Org.getNameByCode(orgCode, dc));
                    rui.sessionHelper.saveValue<string>("admin.deptCode", deptCode);
                    rui.sessionHelper.saveValue<string>("admin.deptName", db.bll.sbs_Dept.getNameByCode(deptCode, dc));
                    //保存当前登录用户拥有的权限
                    rui.sessionHelper.saveValue<DataTable>("admin.priv", db.bll.privRbacHelper.getUserPrivResource(userCode, orgCode, dc, true, false));
                    //保存当前平台内所有需要权限控制的资源和操作
                    rui.sessionHelper.saveValue<DataTable>("admin.resource", db.bll.rbac_Resource.getControlResource(dc));
                }
                else
                    rui.excptHelper.throwEx("登录信息有误，无法登录");
            }
        }

        /// <summary>
        /// 获取登录用户被授权的资源（不包括无需授权的）
        /// </summary>
        /// <returns></returns>
        public static DataTable getPrivResource()
        {
            DataTable priv = rui.sessionHelper.getValue<DataTable>("admin.priv");
            if (priv == null)
            {
                string userCode = db.bll.loginAdminHelper.getUserCode();
                string orgCode = db.bll.loginAdminHelper.getOrgCode();
                DataTable table = db.bll.privRbacHelper.getUserPrivResource(userCode, orgCode, db.efHelper.newDc());
                rui.sessionHelper.saveValue("admin.priv", table);
                return table;
            }
            else
                return priv;
        }

        /// <summary>
        /// 获取登录用户被授权的模块（不包括无需授权的）
        /// </summary>
        /// <returns></returns>
        public static List<SelectListItem> getPrivModule()
        {
            string userCode = db.bll.loginAdminHelper.getUserCode();
            string orgCode = db.bll.loginAdminHelper.getOrgCode();
            DataTable table = db.bll.privRbacHelper.getUserPrivModule(userCode, orgCode, db.efHelper.newDc());
            List<SelectListItem> list = new List<SelectListItem>();
            foreach (DataRow row in table.Rows)
            {
                SelectListItem item = new SelectListItem() { Text = row["moduleName"].ToString(), Value = row["moduleCode"].ToString() };
                list.Add(item);
            }
            return list;
        }

        /// <summary>
        /// 获取登录用户对某资源拥有的数据权限
        /// 本人：selft
        /// 本部门：dept
        /// 本部门加下级和分管:
        /// 登录组织：loginOrg
        /// 可登录组织：seeOrg
        /// </summary>
        /// <param name="controllerName"></param>
        /// <returns></returns>
        public static string getDataPriv(string controllerName)
        {
            //resourceCode,opPriv,dataPriv
            DataTable table = db.bll.loginAdminHelper.getPrivResource();
            DataRow[] rows = table.Select("resourceCode='" + controllerName + "'");
            string result = "";
            if (rows.Length == 0)
                result = "本人";
            else
                result = rows[0]["dataPriv"].ToString();
            return result;
        }

        //根据用户拥有的数据权限筛选sql语句
        public static string getDataPrivSql(string resourceCode, string userField, string deptField, string prjSysCodeField)
        {
            efHelper ef = new efHelper();
            string userCode = db.bll.loginAdminHelper.getUserCode();    //获取登录用户
            string deptCode = db.bll.loginAdminHelper.getDeptCode();    //获取登录部门
            string orgCode = db.bll.loginAdminHelper.getOrgCode();      //获取登录组织
            string dataPriv = getDataPriv(resourceCode);                //获取用户的数据权限

            string querySql = "  ";

            //本人 - 只能查看自己的单据
            if (dataPriv == "self")
            {
                if (userField != "")
                    querySql = " and " + userField + " = '" + userCode + "' ";
                else
                    querySql = " and 1!=1 ";
            }
            //本部门  -- 只能查看本部门人员的单据
            if (dataPriv == "dept")
            {
                if (userField != "")
                    querySql = " and (" + deptField + " in ('" + deptCode + "') or " + userField + " = '" + userCode + "' )";
                else
                    querySql = " and " + deptField + " in ('" + deptCode + "') ";
            }
            //登录组织 - 当前登录组织内所有的部门
            if (dataPriv == "loginOrg")
            {
                string sql = " SELECT deptCode FROM sbs_Dept WHERE orgCode=@orgCode ";
                DataTable table = ef.ExecuteDataTable(sql, new { orgCode });
                if (userField != "")
                    querySql = " and ( " + deptField + " in (" + rui.dbTools.getInExpression(table, "deptCode", true) + ") or " + userField + " = '" + userCode + "' ) ";
                else
                    querySql = " and " + deptField + " in (" + rui.dbTools.getInExpression(table, "deptCode", true) + ") ";
            }
            //可登录组织 - 用户组织关联表内可登录的组织的部门
            if (dataPriv == "seeOrg")
            {
                //string sql = string.Format(@" SELECT deptCode FROM dbo.rbac_UserOrg WHERE isLogin='是' and userCode='{0}'  ", userCode);
                string sql = @" SELECT deptCode FROM dbo.sbs_Dept ";
                DataTable table = ef.ExecuteDataTable(sql);
                if (userField != "")
                    querySql = " and ( " + deptField + " in (" + rui.dbTools.getInExpression(table, "deptCode", true) + ") or " + userField + " = '" + userCode + "' ) ";
                else
                    querySql = " and " + deptField + " in (" + rui.dbTools.getInExpression(table, "deptCode", true) + ") ";
            }
            return querySql;
        }

        //判断是否已登录
        public static bool isLogin()
        {
            if (rui.configHelper.getAppValue("isDev") == "true")
                return true;

            return rui.sessionHelper.hasKey("admin.userCode");
        }

        /// <summary>
        /// 获取登录的账号编号
        /// </summary>
        /// <returns></returns>
        public static string getUserCode()
        {
            if (rui.configHelper.getAppValue("isDev") == "true")
                return "sysAdmin";

            return rui.sessionHelper.getValue<string>("admin.userCode");
        }

        /// <summary>
        /// 获取用户名称
        /// </summary>
        /// <returns></returns>
        public static string getUserName()
        {
            return rui.sessionHelper.getValue<string>("admin.userName");
        }

        /// <summary>
        /// 获取登录的部门编号
        /// </summary>
        /// <param name="isThrowError"></param>
        /// <returns></returns>
        public static string getDeptCode(bool isThrowError = true)
        {
            string deptCode = rui.sessionHelper.getValue<string>("admin.deptCode");
            if (deptCode == "" && isThrowError)
                rui.excptHelper.throwEx("无法获取登录人的所属部门");
            return deptCode;
        }

        /// <summary>
        /// 获取登录的部门名称
        /// </summary>
        /// <param name="isThrowError"></param>
        /// <returns></returns>
        public static string getDeptName(bool isThrowError = true)
        {
            return rui.sessionHelper.getValue<string>("admin.deptName");
        }

        /// <summary>
        /// 获取登录的组织编号
        /// </summary>
        /// <returns></returns>
        public static string getOrgCode()
        {
            return rui.sessionHelper.getValue("admin.orgCode");
        }

        /// <summary>
        /// 获取登录的组织名称
        /// </summary>
        /// <returns></returns>
        public static string getOrgName()
        {
            return rui.sessionHelper.getValue("admin.orgName");
        }

        /// <summary>
        /// 获取默认的组织号
        /// 传入一个组织号，如果传入的为空则获取登录的组织号
        /// </summary>
        /// <param name="orgCode"></param>
        /// <returns></returns>
        public static string getDefaultOrgCode(string orgCode)
        {
            if (string.IsNullOrWhiteSpace(orgCode))
                return db.bll.loginAdminHelper.getOrgCode();
            else
                return orgCode;
        }

        /// <summary>
        /// 获取组织和部门名称
        /// 格式：组织名-部门名
        /// </summary>
        /// <returns></returns>
        public static string getOrgDeptName(db.dbEntities dc)
        {
            return db.bll.sbs_Org.getNameByCode(getOrgCode(), dc) + "-" + db.bll.sbs_Dept.getNameByCode(getDeptCode(), dc);
        }

    }
}
