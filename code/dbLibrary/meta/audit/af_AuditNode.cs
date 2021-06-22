using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db
{
    /// <summary>
    /// 审批流节点元数据
    /// </summary>
    [MetadataType(typeof(metaData))]
    public partial class af_AuditNode
    {
        private class metaData
        {
            public string rowID { get; set; }

            [Display(Name = "所属审批流")]
            public string flowCode { get; set; }

            [Display(Name = "节点编号")]
            public string nodeCode { get; set; }

            [Display(Name = "节点JSON")]
            public string nodeJson { get; set; }

            [Display(Name = "节点名称")]
            public string nodeDesc { get; set; }

            [Display(Name = "节点类型")]
            public string nodeType { get; set; }

            [Display(Name = "通过类型")]
            public string passType { get; set; }

            [Display(Name = "打印标记")]
            public string printTag { get; set; }

            [Display(Name = "指定审核人员")]
            public string auditUserCodes { get; set; }

            [Display(Name = "指定审批角色")]
            public string auditRoleCodes { get; set; }

            [Display(Name = "指定审核职务")]
            public string auditPostCodes { get; set; }

            [Display(Name = "可选审核人员")]
            public string selectUserCodes { get; set; }

            [Display(Name = "可选审核角色")]
            public string selectRoleCodes { get; set; }

            [Display(Name = "可选审核职务")]
            public string selectPostCodes { get; set; }

            [Display(Name = "是否短信通知")]
            public string isNoteInform { get; set; }

            [Display(Name = "是否邮件通知")]
            public string isEmailInform { get; set; }

            [Display(Name = "备注")]
            public string remark { get; set; }
        }
    }
}
