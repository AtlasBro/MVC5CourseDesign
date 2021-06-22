using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace db
{
    /// <summary>
    /// rui
    /// 资源表
    /// </summary>
    [MetadataType(typeof(metaData))]
    public partial class rbac_Resource
    {
        [NotMapped]
        public List<SelectListItem> operationCodeDdlList { get; set; }

        private class metaData
        {
            public string rowID { get; set; }

            [Display(Name = "资源编号")]
            [Required(ErrorMessage = "必填")]
            public string resourceCode { get; set; }

            [Display(Name = "资源名称")]
            [Required(ErrorMessage = "必填")]
            public string resourceName { get; set; }

            [Display(Name = "所属模块")]
            [Required(ErrorMessage = "必填")]
            public string moduleCode { get; set; }

            [Display(Name = "显示顺序")]
            [Required(ErrorMessage = "必填")]
            public Nullable<int> showOrder { get; set; }

            [Display(Name = "拥有操作")]
            public string haveOperations { get; set; }

            [Display(Name = "资源路径")]
            [Required(ErrorMessage = "必填")]
            public string resourceUrl { get; set; }

            [Display(Name = "权限控制")]
            public string opControl { get; set; }

            [Display(Name = "数据控制")]
            public string dataControl { get; set; }

            [Display(Name = "页面宽度")]
            public string pageWidth { get; set; }

            [Display(Name="是否显示")]
            public string isShow { get; set; }

            [Display(Name = "备注")]
            public string remark { get; set; }
        }
    }
}
