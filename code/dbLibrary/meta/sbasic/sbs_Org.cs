using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db
{
    [MetadataType(typeof(metaData))]
    public partial class sbs_Org
    {
        private class metaData
        {
            [Display(Name = "行号")]
            public string rowID { get; set; }

            [Display(Name = "组织编号")]
            [Required(ErrorMessage = "必填")]
            public string orgCode { get; set; }

            [Display(Name = "组织名称")]
            [Required(ErrorMessage = "必填")]
            public string orgName { get; set; }

            [Display(Name = "是否默认")]
            public string isDefault { get; set; }

            [Display(Name = "来源")]
            public string sourceFrom { get; set; }

            [Display(Name = "导入时间")]
            public Nullable<System.DateTime> importDate { get; set; }

            [Display(Name = "备注")]
            public string remark { get; set; }
        }
    }
}
