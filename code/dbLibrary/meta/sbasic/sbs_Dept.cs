using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db
{
    [MetadataType(typeof(metaData))]
    public partial  class sbs_Dept
    {
        private   class metaData
        {
            public string rowID { get; set; }

            [Display(Name = "部门编号")]
            [Required(ErrorMessage = "必填")]
            public string deptCode { get; set; }

            [Display(Name = "部门名称")]
            [Required(ErrorMessage = "必填")]
            public string deptName { get; set; }

            [Display(Name = "所属组织")]
            [Required(ErrorMessage = "必填")]
            public string orgCode { get; set; }

            [Display(Name = "上级部门")]
            public string upDeptCode { get; set; }

            [Display(Name = "来源")]
            public string sourceFrom { get; set; }

            [Display(Name = "导入时间")]
            public string importDate { get; set; }

            [Display(Name = "备注")]
            public string remark { get; set; }
        }
    }
}
