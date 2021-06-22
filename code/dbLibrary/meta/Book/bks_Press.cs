using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db
{
    /// <summary>
    /// meta-出版社表
    /// wzrui 2020-02-20
    /// </summary>
    [MetadataType(typeof(metaData))]
    public partial class bks_Press
    {
        private class metaData
        {
            [Display(Name = "出版社编号")]
            public string pressCode { get; set; }

            [Display(Name = "出版社名称")]
            public string pressName { get; set; }

            [Display(Name = "备注")]
            public string remark { get; set; }

        }
    }
}