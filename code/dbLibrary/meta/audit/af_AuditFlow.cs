using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db
{
    /// <summary>
    /// 审批流元数据
    /// </summary>
    [MetadataType(typeof(metaData))]
    public partial class af_AuditFlow
    {
        private class metaData
        {
            public string rowID { get; set; }

            [Display(Name = "审批流编号")]
            public string flowCode { get; set; }

            [Required(ErrorMessage="必填")]
            [Display(Name = "审批流名称")]
            public string flowName { get; set; }

            [Display(Name = "单据类型")]
            [Required(ErrorMessage = "必填")]
            public string auditTypeCode { get; set; }

            [Display(Name = "是否启用")]
            public string isUse { get; set; }

            [Display(Name = "所属组织")]
            public string orgCode { get; set; }

            [Display(Name = "备注")]
            public string remark { get; set; }
        }
    }
}
