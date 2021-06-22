using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace db
{
    [MetadataType(typeof(metaData))]
    public partial class rbac_User
    {
        //在登录组织下所属部门
        [NotMapped]
        public string deptCode { get; set; }
        //在登录组织下是否可登录
        [NotMapped]
        public string isLogin { get; set; }

        private class metaData
        {
            public string rowID { get; set; }

            [Display(Name = "用户编码")]
            public string userCode { get; set; }

            [Display(Name = "用户名称")]
            public string userName { get; set; }

            [Display(Name = "是否超级管理员")]
            public string isAdmin { get; set; }

            [Display(Name = "关联职工")]
            public string relatedCode { get; set; }

            [Display(Name = "所属部门")]
            public string deptCode { get; set; }

            [Display(Name = "可登录")]
            public string isLogin { get; set; }

            [Display(Name = "备注")]
            public string remark { get; set; }
        }
    }
}
