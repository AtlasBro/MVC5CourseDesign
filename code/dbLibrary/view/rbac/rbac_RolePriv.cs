using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace db.view
{
    /// <summary>
    /// rui
    ///用户授权
    ///可授权的模块（下拉框）
    ///可授权的资源（不分页）
    ///可授权的操作（checkBox)
    /// </summary>
    public class rbac_RolePriv : rui.pagerBase
    {
        //被授权角色的rowID
        public string rowID { get; set; }
        //登录用户可授权模块列表
        [NotMapped]
        public List<SelectListItem> moduleList { get; set; }

        //当前搜索的模块
        public string moduleCode { get; set; }

        //获取展示的资源
        /// <summary>
        /// </summary>
        public override void Search()
        {
            this.keyField = "resourceCode";
            this.ResourceCode = "rbac_UserPriv";

            //this.getPageConfig();
            DataTable table = db.bll.rbac_RolePriv.getPrivResource(moduleCode, rowID,efHelper.newDc());
            this.dataTable = rui.dbTools.insert序号(table, 0);

            //显示的列和列顺序
            this.showColumn = this.getShowColumn(false);
        }
    }
}
