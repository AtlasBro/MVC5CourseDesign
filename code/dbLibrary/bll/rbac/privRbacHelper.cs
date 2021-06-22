using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Xml.Linq;
using System.Collections.Generic;
using System.Web.Mvc;
using db.bll;

namespace db.bll
{
    /// <summary>
    /// rbac授权数据获取
    /// </summary>
    public class privRbacHelper
    {
        //获取某个用户在某组织内拥有的资源和权限列表(合并角色权限) --- 获取用户权限的基础方法
        /// <summary>
        /// 超级管理员，获取所有的权限和最高数据权限
        /// 普通用户，获取被授予的操作权限和数据权限，加上无需权限控制的资源
        /// 普通用户，获取所属角色被授予的操作权限和数据权限
        /// 普通用户，将角色权限合并到用户权限上（资源已存在，合并数据权限和操作权限，资源不存在，增加新资源）
        /// </summary>
        /// <param name="userCode"></param>
        /// <param name="orgCode"></param>
        /// <param name="hasNoPrivResource">是否包含不需要权限控制的资源</param>
        /// <param name="isUserOnly ">是否只获取用户自己的</param>
        /// <returns></returns>
        public static DataTable getUserPrivResource(string userCode, string orgCode, db.dbEntities dc, bool hasNoPrivResource = false, bool isUserOnly = false)
        {
            efHelper ef = new efHelper(ref dc);
            //超级管理员，获取所有资源的操作权限和最高数据权限seeOrg (不包括不进行权限控制的和不显示的)
            if (userCode == rui.configHelper.adminName)
            {
                DataTable tableUser = new DataTable();
                string sql = string.Format(@" SELECT dbo.rbac_Module.moduleCode,moduleName,
                    dbo.rbac_Resource.rowID,resourceCode,resourceName,resourceUrl,dataControl,
                    haveOperations AS opPriv,'seeOrg' AS dataPriv
                     FROM dbo.rbac_Resource
                    INNER JOIN dbo.rbac_Module ON dbo.rbac_Resource.moduleCode = dbo.rbac_Module.moduleCode where rbac_Resource.isShow='是' ");

                //只获取需要权限控制的
                if (hasNoPrivResource == false)
                    sql += " and opControl='是' ";

                sql += "  ORDER BY dbo.rbac_Module.showOrder ASC,dbo.rbac_Resource.showOrder ASC ";
                tableUser = ef.ExecuteDataTable(sql);
                return tableUser;
            }
            else
            {
                //其它用户，获取登录用户在登录组织下被授予的操作权限和数据权限
                DataTable tableUser = new DataTable();
                {
                    string sqlUser = @" SELECT rbac_Module.moduleCode,moduleName,rbac_Module.showOrder AS mshowOrder,
                       rbac_Resource.rowID,rbac_Resource.resourceCode,resourceName,resourceUrl,rbac_Resource.showOrder AS rshowOrder,dataControl,
                       opPriv,dataPriv
                        FROM rbac_UserPriv
                       INNER JOIN rbac_Resource ON rbac_UserPriv.resourceCode = rbac_Resource.resourceCode and rbac_Resource.isShow='是'
                       INNER JOIN rbac_Module ON rbac_Resource.moduleCode = rbac_Module.moduleCode
                       WHERE opPriv IS NOT NULL AND userCode=@userCode AND orgCode=@orgCode ";
                    tableUser = ef.ExecuteDataTable(sqlUser, new { userCode, orgCode });
                }
                //查询用户所属角色在当前登录组织下被授予的操作权限和数据权限，合并到用户权限上
                if (isUserOnly == false)
                {
                    string sqlRole = @" SELECT DISTINCT rbac_Module.moduleCode,moduleName,rbac_Module.showOrder AS mshowOrder,
		                    rbac_Resource.rowID,rbac_Resource.resourceCode,resourceName,resourceUrl,rbac_Resource.showOrder AS rshowOrder,dataControl,
		                    opPriv,dataPriv FROM rbac_RolePriv
                            INNER JOIN rbac_RoleUser ON rbac_RolePriv.roleCode = rbac_RoleUser.roleCode and orgCode=@orgCode
                            INNER JOIN rbac_Resource ON rbac_RolePriv.resourceCode = rbac_Resource.resourceCode and rbac_Resource.isShow='是'
                            INNER JOIN rbac_Module ON rbac_Resource.moduleCode = rbac_Module.moduleCode
                            WHERE userCode=@userCode ";
                    DataTable tableRole = ef.ExecuteDataTable(sqlRole, new { orgCode, userCode });

                    //角色权限合并到用户权限上
                    tableUser = db.bll.privRbacHelper.mergePriv(tableUser, tableRole);
                }

                //查询不需要进行权限控制的资源，合并到用户权限上
                if (hasNoPrivResource == true)
                {
                    string sql = @" SELECT dbo.rbac_Module.moduleCode,moduleName,dbo.rbac_Module.showOrder AS mshowOrder,
                    dbo.rbac_Resource.rowID,resourceCode,resourceName,resourceUrl,dbo.rbac_Resource.showOrder AS rshowOrder,dataControl,
                    haveOperations AS opPriv,'self' AS dataPriv
                     FROM dbo.rbac_Resource
                    INNER JOIN dbo.rbac_Module ON dbo.rbac_Resource.moduleCode = dbo.rbac_Module.moduleCode
                    WHERE rbac_Resource.isShow='是' and opControl='否' ";
                    DataTable table = ef.ExecuteDataTable(sql);

                    //权限合并
                    tableUser = db.bll.privRbacHelper.mergePriv(tableUser, table);
                }

                //对合并后的查询结果进行排序
                DataView view = tableUser.DefaultView;
                view.Sort = " mshowOrder asc,rshowOrder asc ";
                return view.ToTable();
            }
        }

        //获取某个用户在某组织内可以授出的模块(合并角色权限) - 授权页面用
        /// <summary>
        /// 调用getUserPrivResource
        /// 获取其中包含的模块编号和模块名称，并去重
        /// </summary>
        /// <param name="userCode"></param>
        /// <param name="orgCode"></param>
        /// <param name="containShow">是否包含不可授出的权限</param>
        /// <returns></returns>
        public static DataTable getUserPrivModule(string userCode, string orgCode, db.dbEntities dc, bool containShow = false)
        {
            DataTable moduleDt = db.bll.privRbacHelper.getUserPrivResource(userCode, orgCode, dc, containShow);
            Dictionary<string, string> moduleDic = new Dictionary<string, string>();
            foreach (DataRow row in moduleDt.Rows)
            {
                string moduleCode = row["moduleCode"].ToString();
                if (moduleDic.ContainsKey(moduleCode) == false)
                    moduleDic.Add(moduleCode, rui.typeHelper.toString(row["moduleName"]));
            }

            //构造dataTable
            DataTable table = new DataTable();
            table.Columns.Add("moduleCode");
            table.Columns.Add("moduleName");
            foreach (var key in moduleDic.Keys)
            {
                DataRow row = table.NewRow();
                row["moduleCode"] = key;
                row["moduleName"] = moduleDic[key];
                table.Rows.Add(row);
            }
            return table;
        }

        //获取某个角色在某组织内能够授出的资源和权限列表(资源编号是重复的，需要合并去重) -- 授权页面用
        /// <summary>
        /// 利用角色授权表进行关联查询
        /// </summary>
        /// <param name="roleCode"></param>
        /// <param name="orgCode"></param>
        /// <returns></returns>
        public static DataTable getRolePrivResource(string roleCode, string orgCode, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);
            string sql = @" SELECT rbac_Module.moduleCode,moduleName,rbac_Module.showOrder AS mshowOrder,
		                    rbac_Resource.rowID,rbac_Resource.resourceCode,resourceName,resourceUrl,rbac_Resource.showOrder AS rshowOrder,dataControl,
		                    opPriv,dataPriv FROM rbac_RolePriv
                        INNER JOIN rbac_Resource ON rbac_RolePriv.resourceCode = rbac_Resource.resourceCode
                        INNER JOIN rbac_Module ON rbac_Resource.moduleCode = rbac_Module.moduleCode
                        WHERE rbac_RolePriv.roleCode=@roleCode  ";
            DataTable tableRole = ef.ExecuteDataTable(sql, new { roleCode, orgCode });

            //返回合并之后的
            DataTable table = tableRole.Clone();
            table = db.bll.privRbacHelper.mergePriv(table, tableRole);
            return table;
        }

        //合并权限(去重合并)，返回合并之后的
        public static DataTable mergePriv(DataTable tableUser, DataTable tableRole)
        {
            foreach (DataRow rowRole in tableRole.Rows)
            {
                string resourceCode = rowRole["resourceCode"].ToString();
                DataRow[] rowsUser = tableUser.Select("resourceCode='" + resourceCode + "'");

                if (rowsUser.Length > 0)
                {
                    //已存在，操作权限和数据权限进行合并
                    rowsUser[0]["opPriv"] = db.bll.privRbacHelper.mergeOpPriv(rowsUser[0]["opPriv"].ToString(), rowRole["opPriv"].ToString());
                    rowsUser[0]["dataPriv"] = db.bll.privRbacHelper.mergeDataPriv(rowsUser[0]["dataPriv"].ToString(), rowRole["dataPriv"].ToString());
                }
                else
                {
                    //不存在，则新增到用户权限上
                    DataRow rowAdd = tableUser.NewRow();
                    rowAdd.ItemArray = rowRole.ItemArray;
                    tableUser.Rows.Add(rowAdd);
                }
            }
            return tableUser;
        }

        //合并操作权限（合并去重） 
        public static string mergeOpPriv(string val1, string val2)
        {
            var result1 = from a in val1.Split(',')
                          where a.Length > 0
                          select a;
            var result2 = from a in val2.Split(',')
                          where a.Length > 0
                          select a;
            List<string> result = new List<string>();
            foreach (var item in result1)
            {
                if (result.Contains(item) == false)
                    result.Add(item);
            }
            foreach (var item in result2)
            {
                if (result.Contains(item) == false)
                    result.Add(item);
            }
            //合并后，在权限后边加上,结果
            return rui.dbTools.getShowExpression(result) + ",";
        }

        //合并数据权限（返回数据权限大的）
        public static string mergeDataPriv(string val1, string val2)
        {
            if (compareDataPriv(val1, val2))
                return val1;
            else
                return val2;
        }

        //比较数据权限的大小(val1和val2进行比较,大于等于返回True)
        public static bool compareDataPriv(string val1, string val2)
        {
            if (val1 == "")
                val1 = "self";
            if (val2 == "")
                val2 = "self";

            //类型转换
            dataPriv v1 = (db.bll.dataPriv)Enum.Parse(typeof(db.bll.dataPriv), val1);
            dataPriv v2 = (db.bll.dataPriv)Enum.Parse(typeof(db.bll.dataPriv), val2);

            if (v1 >= v2)
                return true;
            else
                return false;
        }
    }

    //数据权限枚举项目
    public enum dataPriv
    {
        self,           //本人
        dept,           //本部门
        deptAndSub,     //本部分加下级和分管
        loginOrg,       //登录组织
        seeOrg          //可见组织
    }
}
