using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;

namespace rui {
    /// <summary>
    /// Session内置对象辅助方法
    /// </summary>
    public class sessionHelper {
        /// <summary>
        /// 向Session中存入值
        /// </summary>
        /// <param name="sessionKey"></param>
        /// <param name="value"></param>
        public static void saveValue<T>(string sessionKey, T value) {
            HttpContext.Current.Session[sessionKey] = value;
        }

        /// <summary>
        /// 获取Session中的值，返回字符串
        /// </summary>
        /// <param name="sessionKey"></param>
        /// <param name="isThrowOnNull"></param>
        /// <returns></returns>
        public static string getValue(string sessionKey, bool isThrowOnNull = false) {
            return getValue<string>(sessionKey, isThrowOnNull);
        }

        /// <summary>
        /// 获取Session中的值
        /// </summary>
        /// <param name="sessionKey"></param>
        /// <param name="isThrowOnNull"></param>
        /// <returns></returns>
        public static T getValue<T>(string sessionKey, bool isThrowOnNull = false) {
            if (HttpContext.Current.Session[sessionKey] == null) {
                if (isThrowOnNull) {
                    rui.excptHelper.throwEx(string.Format("{0}在Session中不存在", sessionKey));
                } else
                    return default(T);
            }
            return (T)HttpContext.Current.Session[sessionKey];
        }


        /// <summary>
        /// 判断Session中是否有值
        /// </summary>
        /// <param name="sessionName"></param>
        /// <returns></returns>
        public static bool hasKey(string sessionName) {
            if (HttpContext.Current.Session[sessionName] == null)
                return false;
            else
                return true;
        }

        /// <summary>
        /// 移除Session中存入变量
        /// </summary>
        /// <param name="sessionName"></param>
        public static void removeKey(string sessionName) {
            HttpContext.Current.Session.Remove(sessionName);
        }

        /// <summary>
        /// Session注销
        /// </summary>
        public static void exit() {
            HttpContext.Current.Session.Clear();
            HttpContext.Current.Session.Abandon();
        }
    }
}

