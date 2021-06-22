using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace db.bll
{
    /// <summary>
    /// rui
    /// 授权控制逻辑
    /// </summary>
    public class rbac_UserPriv
    {
        /// <summary>
        /// 获取当前登录用户下某个模块下的可授权资源列表 - 用户授权页面用
        /// 这里的资源不包括别人委托的权限
        /// rowID:资源编号
        /// resourceCode:资源编号
        /// resourceName:资源名称
        /// dataControl:是否进行数据授权
        /// allowOperations:登录用户允许授出的权限
        /// haveOperations:被授权用户拥有的权限
        /// allowDataPriv:登录用户拥有的数据权限
        /// haveDataPriv:被授权用户拥有数据权限
        /// </summary>
        /// <param name="moduleCode"></param>
        /// <param name="privUserRowID"></param>
        /// <returns></returns>
        public static DataTable getPrivResource(string moduleCode, string privUserRowID, bool isUser,db.dbEntities dc)
        {
            //登录用户在当前登录组织内拥有的资源和资源的操作权限和数据权限
            DataTable tableAllow = db.bll.privRbacHelper.getUserPrivResource(db.bll.loginAdminHelper.getUserCode(), db.bll.loginAdminHelper.getOrgCode(), dc);

            //获取被授权用户在当前登录组织内拥有的资源和资源的操作权限和数据权限
            DataTable tableHave = db.bll.privRbacHelper.getUserPrivResource(db.bll.rbac_User.getCodeByRowID(privUserRowID, dc), db.bll.loginAdminHelper.getOrgCode(), dc, false, isUser);

            //对登录用户拥有的权限进行模块查询，并返回 (模块编号为空，则返回空行数据)
            if (rui.typeHelper.isNullOrEmpty(moduleCode) == false)
            {
                DataRow[] rows = tableAllow.Select("moduleCode='" + moduleCode + "'");
                tableAllow = rui.dbTools.toDataTable(rows);
            }
            else
            {
                tableAllow.Rows.Clear();
            }

            //给tableAllow增加haveOpPriv,haveDataPriv列，并设置每一行的值
            tableAllow.Columns.Add("haveOpPriv");
            tableAllow.Columns.Add("haveDataPriv");
            foreach (DataRow row in tableAllow.Rows)
            {
                string resourceCode = row["resourceCode"].ToString();
                DataRow[] have = tableHave.Select("resourceCode='" + resourceCode + "'");
                if (have.Length > 0)
                {
                    row["haveOpPriv"] = have[0]["opPriv"];
                    row["haveDataPriv"] = have[0]["dataPriv"];
                }
            }
            return tableAllow;
        }

        /// <summary>
        /// 用户授权保存
        /// 用户的资源授权 - 查看是否拥有资源权限，如果没有，则新增，有则修改
        /// </summary>
        /// <param name="userRowID">被授权用户的rowID</param>
        /// <param name="dicOp">key是被授权的资源编号，Value是每个资源的操作授权</param>
        /// <param name="dicData">key是被授权的资源编号，Value是每个资源的数据授权</param>
        public static void savePriv(string userRowID, string orgCode, Dictionary<string, string> dicOp, Dictionary<string, string> dicData, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc); 
            string userCode = dc.rbac_User.Single(a => a.rowID == userRowID).userCode;
            if(db.bll.rbac_UserOrg.isCanLogin(userCode,orgCode,dc)==false)
                rui.excptHelper.throwEx("该用户不能登录该组织，无法进行授权");
            foreach (string resourceCode in dicOp.Keys)
            {
                //如果没授权，以前有的需要删除
                if (dicOp[resourceCode] == "")
                {
                    db.rbac_UserPriv entry = dc.rbac_UserPriv
                        .SingleOrDefault(a => a.userCode == userCode && a.orgCode == orgCode && a.resourceCode == resourceCode);
                    if (entry != null)
                        dc.rbac_UserPriv.Remove(entry);
                }
                else
                {
                    //如果已授权,则根据是否已有来决定新增还是修改
                    db.rbac_UserPriv entry = dc.rbac_UserPriv
                        .SingleOrDefault(a => a.userCode == userCode && a.orgCode == orgCode && a.resourceCode == resourceCode);
                    if (entry == null)
                    {
                        entry = new db.rbac_UserPriv();

                        entry.rowID = ef.newGuid();
                        entry.userCode = userCode;
                        entry.orgCode = orgCode;
                        entry.resourceCode = resourceCode;
                        dc.rbac_UserPriv.Add(entry);
                    }
                    entry.opPriv = dicOp[resourceCode];
                    entry.dataPriv = dicData[resourceCode];
                }
            }
            dc.SaveChanges();
        }
    }
}
