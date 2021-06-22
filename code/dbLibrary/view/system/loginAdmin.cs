using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db.view
{
    /// <summary>
    /// 登录页面 wzrui
    /// </summary>
    public class loginAdmin
    {
        public string tbxUserName { get; set; }
        public string tbxPassword { get; set; }
        public string orgCode { get; set; }
    }
}
