using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db 
{
    [MetadataType(typeof(metaData))]
    public partial class bks_OrderInfo
    {
        private class metaData
        {
             [Display(Name ="订单号")]
            public string orderCode { get; set; }
             [Display(Name = "客户号")]
            public string customerCode { get; set; }
             [Display(Name = "地址号")]
            public string addressCode { get; set; }
             [Display(Name = "订货日期")]
            public string orderDate { get; set; }
            [Display(Name = "总价")]
            public string totalPrice { get; set; }
            [Display(Name = "状态")]
            public string status { get; set; }
            [Display(Name = "员工号")]
            public string employeeCode { get; set; }
            [Display(Name = "评论")]
            public string remark { get; set; }

        }
    }
}
