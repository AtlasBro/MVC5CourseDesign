using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace rui
{
    /// <summary>
    /// cookie辅助方法
    /// </summary>
    public class cookieHelper
    {
        /// <summary>
        /// 向Cookie中存入值
        /// </summary>
        /// <param name="keyName"></param>
        /// <param name="value"></param>
        /// <param name="Expires">过期时间</param>
        public static void saveValue(string keyName, string value,DateTime Expires)
        {
            HttpContext.Current.Response.Cookies[keyName].Value = HttpContext.Current.Server.UrlEncode(value);
            HttpContext.Current.Response.Cookies[keyName].Expires = Expires;
        }

        /// <summary>
        /// 获取Cookie中的值
        /// </summary>
        /// <param name="keyName"></param>
        /// <param name="isThrowOnNull"></param>
        /// <returns></returns>
        public static string getValue(string keyName, bool isThrowOnNull = false)
        {
            string value = "";
            if (HttpContext.Current.Request.Cookies[keyName] == null)
            {
                if (isThrowOnNull)
                {
                    rui.excptHelper.throwEx(string.Format("{0}在Cookie中不存在", keyName));
                }
                else
                    return "";
            }
            value = HttpContext.Current.Request.Cookies[keyName].Value;
            return HttpContext.Current.Server.UrlDecode(value);
        }


        /// <summary>
        /// 判断Cookie中是否有值
        /// </summary>
        /// <param name="keyName"></param>
        /// <returns></returns>
        public static bool hasKey(string keyName)
        {
            if (HttpContext.Current.Request.Cookies[keyName] == null)
                return false;
            else
                return true;
        }

        /// <summary>
        /// 移除Cookie中存入变量
        /// </summary>
        /// <param name="keyName"></param>
        public static void removeKey(string keyName)
        {
            HttpContext.Current.Request.Cookies[keyName].Expires = DateTime.Now.AddMinutes(-1);
        }
    }
}
