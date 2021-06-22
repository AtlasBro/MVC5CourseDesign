using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db
{
    /// <summary>
    /// 审批流节点关系
    /// </summary>
    [MetadataType(typeof(metaData))]
    public partial class af_NodeRelation
    {
        private class metaData
        {
            public string rowID { get; set; }

            [Display(Name = "所属审批流")]
            [Required(ErrorMessage = "必填")]
            public string flowCode { get; set; }

            [Display(Name = "开始节点")]
            [Required(ErrorMessage = "必填")]
            public string startNodeCode { get; set; }

            [Display(Name = "结束节点")]
            [Required(ErrorMessage = "必填")]
            public string endNodeCode { get; set; }

            [Display(Name = "条件表达式")]
            public string passExpression { get; set; }

            public string nodeGuid { get; set; }
            public string nodeJson { get; set; }

            [Display(Name = "备注")]
            public string remark { get; set; }
        }
    }
}
