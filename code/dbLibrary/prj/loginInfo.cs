using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db
{
    /// <summary>
    /// app代理商登录账号
    /// 视图模型
    /// </summary>
    public class loginInfo
    {
        //登录账号
        public string userCode { get; set; }

        //密码
        public string password { get; set; }
    }
}
