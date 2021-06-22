using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db
{
    /// <summary>
    /// meta-入库明细表表
    /// wzrui 2020-02-19
    /// </summary>
    [MetadataType(typeof(metaData))]
    public partial class bks_BookStockDetail
    {
        private class metaData
        {
            [Display(Name = "进货编号")]
            public string stockCode { get; set; }

            [Display(Name = "明细行号")]
            public string detailNo { get; set; }

            [Display(Name = "图书编号")]
            public string bookCode { get; set; }

            [Display(Name = "进货数量")]
            public Nullable<int> quantity { get; set; }

            [Display(Name = "已售数量")]
            public Nullable<int> sellQuantity { get; set; }

            [Display(Name = "进货价")]
            public Nullable<decimal> price { get; set; }

            [Display(Name = "备注")]
            public string remark { get; set; }

        }
    }
}