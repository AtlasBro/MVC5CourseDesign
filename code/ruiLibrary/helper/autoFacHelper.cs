using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace rui
{
    /// <summary>
    /// autofac容器的保存工具类
    /// 先采用静态变量保存,可以换成全局变量
    /// </summary>
    public class autoFacHelper
    {
        /// <summary>
        /// 获取HTTP上下文
        /// </summary>
        /// <returns></returns>
        public static HttpContext getHttpContext()
        {
            return HttpContext.Current;
        }
    }
}
