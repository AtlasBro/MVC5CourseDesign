using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db
{
    [MetadataType(typeof(metaData))]
    public partial class bks_Book
    {
        private class metaData
        {
            public long rowNum { get; set; }
            public string rowID { get; set; }
            [Display(Name ="图书编号")]
            public string bookCode { get; set; }
            [Display(Name = "图书名称")]
            public string bookName { get; set; }
            [Display(Name = "ISBN号")]
            public string isbnNO { get; set; }
            [Display(Name = "价格")]
            public Nullable<decimal> price { get; set; }
            [Display(Name = "作者名")]
            public string authorName { get; set; }
            [Display(Name = "作者介绍")]
            public string authorIntroduce { get; set; }
            [Display(Name = "图书介绍")]
            public string bookIntroduce { get; set; }
            [Display(Name = "图书目录")]
            public string bookDirectory { get; set; }
            [Display(Name = "图书类型")]
            public string bookTypeCode { get; set; }
            [Display(Name = "出版社")]
            public string pressCode { get; set; }
            [Display(Name = "出版时间")]
            public Nullable<System.DateTime> pressDate { get; set; }
            [Display(Name = "版次")]
            public string release { get; set; }
            [Display(Name = "封面图")]
            public string surfacePic { get; set; }
            [Display(Name = "是否在售")]
            public string isSell { get; set; }
            [Display(Name = "库存量")]
            public Nullable<int> stockSum { get; set; }
            [Display(Name = "已售数量")]
            public Nullable<int> sellSum { get; set; }
            [Display(Name = "备注")]
            public string remark { get; set; }
        }
    }
}
