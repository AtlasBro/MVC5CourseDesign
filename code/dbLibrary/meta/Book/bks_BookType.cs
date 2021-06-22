using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db
{
    /// <summary>
    /// meta-图书类别表
    /// wzrui 2020-02-20
    /// </summary>
    [MetadataType(typeof(metaData))]
    public partial class bks_BookType
    {
        private class metaData
        {
            [Display(Name = "图书类别编号")]
            public string bookTypeCode { get; set; }

            [Display(Name = "图书类别名称")]
            public string bookTypeName { get; set; }

            [Display(Name = "显示顺序")]
            public Nullable<int> showOrder { get; set; }

            [Display(Name = "备注")]
            public string remark { get; set; }

        }
    }
}