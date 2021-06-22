using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db
{
    /// <summary>
    /// meta-职务任职表表
    /// wzrui 2019-06-16
    /// </summary>
    [MetadataType(typeof(metaData))]
    public partial class af_AuditPost
    {
        private class metaData
        {
            [Display(Name = "行号")]
            public string rowID { get; set; }

            [Display(Name = "职务编号")]
            public string postCode { get; set; }

            [Display(Name = "职务名称")]
            public string postName { get; set; }

            [Display(Name = "是否部门职务")]
            public string isDeptPost { get; set; }

            [Display(Name = "来源")]
            public string sourceFrom { get; set; }

            [Display(Name = "导入时间")]
            public Nullable<System.DateTime> importDate { get; set; }

            [Display(Name = "备注")]
            public string remark { get; set; }

        }
    }
}