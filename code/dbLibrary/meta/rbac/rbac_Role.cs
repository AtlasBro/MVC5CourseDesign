using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db
{
    [MetadataType(typeof(metaData))]
    public partial class rbac_Role
    {
        private class metaData
        {
            public string rowID { get; set; }

            [Display(Name = "角色编号")]
            public string roleCode { get; set; }

            [Display(Name = "角色名称")]
            [Required(ErrorMessage = "必填")]
            public string roleName { get; set; }

            [Display(Name = "备注")]
            public string remark { get; set; }
        }
    }
}
