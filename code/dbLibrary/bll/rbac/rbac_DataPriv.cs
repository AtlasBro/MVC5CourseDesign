using System;
using System.Collections.Generic;
using System.Data;
using System.Web.Mvc;

namespace db.bll
{
    /// <summary>
    /// 数据权限
    /// </summary>
    public class rbac_DataPriv
    {
        /// <summary>
        /// 授权数据权限 - 返回允许授出的数据权限
        /// </summary>
        /// <param name="allowDataPriv">允许授出的数据权限</param>
        /// <param name="haveDataPriv">被授权用户拥有的数据权限</param>
        /// <param name="has请选择">是否包含请选择</param>
        /// <returns></returns>
        public static List<SelectListItem> bindDdl(string allowDataPriv, string haveDataPriv, bool has请选择 = false)
        {
            efHelper ef = new efHelper();
            List<SelectListItem> list = new List<SelectListItem>();
            rui.listHelper.add请选择(list, has请选择);
            string sql = @" SELECT dataPrivCode AS code,dataPrivName AS name FROM dbo.rbac_DataPriv ORDER BY rowID DESC ";
            DataTable table = ef.ExecuteDataTable(sql);
            foreach (DataRow row in table.Rows)
            {
                //只返回自己允许授出的数据权限
                if (db.bll.privRbacHelper.compareDataPriv(allowDataPriv, row["code"].ToString()))
                {
                    if (row["code"].ToString() == haveDataPriv)
                        list.Add(new SelectListItem() { Text = row["name"].ToString(), Value = row["code"].ToString(), Selected = true });
                    else
                        list.Add(new SelectListItem() { Text = row["name"].ToString(), Value = row["code"].ToString() });

                }
            }
            if (haveDataPriv == "")
            {
                foreach (var item in list)
                {
                    if (item.Value == "loginOrg")
                    {
                        item.Selected = true;
                    }
                }
            }
            return list;
        }

        /// <summary>
        /// 返回所有的数据权限
        /// </summary>
        /// <param name="has请选择"></param>
        /// <returns></returns>
        public static List<SelectListItem> bindDdl(bool has请选择 = false)
        {
            efHelper ef = new efHelper();
            string sql = @" SELECT dataPrivCode AS code,dataPrivName AS name FROM dbo.rbac_DataPriv ORDER BY rowID DESC ";
            DataTable table = ef.ExecuteDataTable(sql);
            List<SelectListItem> list = rui.listHelper.dataTableToDdlList(table, has请选择, "");
            return list;
        }
    }
}
