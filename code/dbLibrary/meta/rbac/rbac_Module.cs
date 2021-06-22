using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace db
{
    /// <summary>
    /// rui
    /// 模块表
    /// </summary>
    [MetadataType(typeof(metaData))]
    public partial class rbac_Module
    {
        private class metaData
        {
            [Display(Name="行号")]
            public string rowID { get; set; }

            [Display(Name = "模块编号")]
            [Required(ErrorMessage = "必填")]
            public string moduleCode { get; set; }

            [Display(Name = "模块名称")]
            [Required(ErrorMessage = "必填")]
            public string moduleName { get; set; }

            [Display(Name = "账户类别")]
            [Required(ErrorMessage = "必填")]
            public string userType { get; set; }

            [Display(Name = "排序号")]
            [DataType(DataType.PhoneNumber)]
            [Required(ErrorMessage = "必填")]
            public Nullable<int> showOrder { get; set; }

            [Display(Name = "备注")]
            public string remark { get; set; }
        }
    }
}
