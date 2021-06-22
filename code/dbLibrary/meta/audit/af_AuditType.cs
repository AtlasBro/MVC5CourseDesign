using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db
{
    /// <summary>
    /// 审批单据类型
    /// </summary>
    [MetadataType(typeof(metaData))]
    public partial class af_AuditType
    {
        private class metaData
        {
            public string rowID { get; set; }

            [Display(Name="审批单据类型编号")]
            [Required(ErrorMessage = "必填")]
            public string auditTypeCode { get; set; }

            [Display(Name = "审批单据类型名称")]
            [Required(ErrorMessage = "必填")]
            public string auditTypeName { get; set; }

            [Display(Name = "是否启用审批")]
            [Required(ErrorMessage = "必填")]
            public string isAudit { get; set; }

            [Display(Name = "备注")]
            public string remark { get; set; }
        }
    }
}
