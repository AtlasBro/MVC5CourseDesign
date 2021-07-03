using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db

{
    [MetadataType(typeof(metaData))]
    public partial class bks_CustomerAddress
    {
        private class metaData
        {
            public long rowNum { get; set; }
            public string rowID { get; set; }
            public Nullable<System.Guid> addressCode { get; set; }
            [Display(Name ="顾客号")]
            public string customerCode { get; set; }
            [Display(Name = "地址")]

            public string addressName { get; set; }
            [Display(Name = "是否默认")]

            public Nullable<bool> isDefault { get; set; }
            [Display(Name = "备注")]

            public string remark { get; set; }
        }
    }
}
