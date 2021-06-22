using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db.view
{
    /// <summary>
    /// 框架首页
    /// </summary>
    public class adminIndex
    {
        public DataTable moduleDt { get; set; }
        public DataTable resourceDt { get; set; }
        public string loginUserName { get; set; }
        public string loginUserCode { get; set; }
        public string loginDeptName { get; set; }
    }
}
