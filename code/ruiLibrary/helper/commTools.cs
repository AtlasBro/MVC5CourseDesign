using System;

namespace rui
{
    /// <summary>
    /// commTools 的摘要说明
    /// </summary>
    public partial class commHelper
    {
        /// <summary>
        /// 检测sql注入特定字符
        /// </summary>
        /// <param name="value"></param>
        public static void checkAttack(string value)
        {
            if (string.IsNullOrWhiteSpace(value) == false)
            {
                if (value.Contains("'"))
                    rui.excptHelper.throwEx("提交内从存在非法符号");
            }
        }

        /// <summary>
        /// 获取一个新的Guid字符串
        /// </summary>
        /// <returns></returns>
        public static string getGuid()
        {
            string value = Guid.NewGuid().ToString();
            return value.Replace("-", "");
        }
    }
}