//------------------------------------------------------------------------------
// <auto-generated>
//     此代码已从模板生成。
//
//     手动更改此文件可能导致应用程序出现意外的行为。
//     如果重新生成代码，将覆盖对此文件的手动更改。
// </auto-generated>
//------------------------------------------------------------------------------

namespace db
{
    using System;
    using System.Collections.Generic;
    
    public partial class sv_bks_BookStockDetail
    {
        public long rowNum { get; set; }
        public string rowID { get; set; }
        public string stockCode { get; set; }
        public int detailNo { get; set; }
        public string bookCode { get; set; }
        public Nullable<int> quantity { get; set; }
        public Nullable<int> sellQuantity { get; set; }
        public Nullable<decimal> price { get; set; }
        public string remark { get; set; }
    }
}
