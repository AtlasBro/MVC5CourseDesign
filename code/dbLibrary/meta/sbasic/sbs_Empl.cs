using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db
{
    [MetadataType(typeof(metaData))]
    public partial class sbs_Empl
    {
        private class metaData
        {
            [Display(Name = "职工编号")]
            public string rowID { get; set; }

            [Display(Name = "职工编号")]
            [Required(ErrorMessage = "必填")]
            public string emplCode { get; set; }

            [Display(Name = "职工名称")]
            [Required(ErrorMessage = "必填")]
            public string emplName { get; set; }

            [Display(Name = "所属组织")]
            [Required(ErrorMessage = "必填")]
            public string orgCode { get; set; }

            [Display(Name = "所属部门")]
            [Required(ErrorMessage = "必填")]
            public string deptCode { get; set; }

            [Display(Name = "来源")]
            public string sourceFrom { get; set; }

            [Display(Name = "导入时间")]
            public string importDate { get; set; }

            [Display(Name = "备注")]
            public string remark { get; set; }
        }
    }
}
