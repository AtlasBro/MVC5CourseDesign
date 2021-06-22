using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db
{
    /// <summary>
    /// meta-供应商表
    /// wzrui 2020-02-20
    /// </summary>
    [MetadataType(typeof(metaData))]
    public partial class bks_Supplier
    {
        private class metaData
        {
            [Display(Name = "供应商编号")]
            public string supplierCode { get; set; }

            [Display(Name = "供应商名称")]
            public string supplierName { get; set; }

            [Display(Name = "联系人")]
            public string contactUser { get; set; }

            [Display(Name = "联系电话")]
            public string contactPhone { get; set; }

            [Display(Name = "备注")]
            public string remark { get; set; }

        }
    }
}