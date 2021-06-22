using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db
{
    /// <summary>
    /// meta-入库主表表
    /// wzrui 2020-02-19
    /// </summary>
    [MetadataType(typeof(metaData))]
    public partial class bks_BookStock
    {
        private class metaData
        {

            [Display(Name = "入库编号")]
            public string stockCode { get; set; }

            [Display(Name = "入库日期")]
            public Nullable<System.DateTime> stockDate { get; set; }

            [Display(Name = "经手人")]
            public string userCode { get; set; }

            [Display(Name = "供应商")]
            public string supplierCode { get; set; }

            [Display(Name = "状态")]
            public string status { get; set; }

            [Display(Name = "备注")]
            public string remark { get; set; }

        }
    }
}