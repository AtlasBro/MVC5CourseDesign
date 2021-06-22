using System;

namespace rui
{
    /// <summary>
    /// 异常操作
    /// </summary>
    public class excptHelper
    {
        /// <summary>
        /// 获取异常包含的准确的错误描述信息
        /// </summary>
        /// <param name="ex">异常对象</param>
        /// <returns></returns>
        public static string getExMsg(Exception ex)
        {
            string msg = string.Format("{0}", ex.Message);
            if (ex.InnerException != null)
            {
                msg += string.Format("<div>{0}</div>", ex.InnerException.Message);
                if (ex.InnerException.InnerException != null)
                {
                    msg += string.Format("<div>{0}</div>", ex.InnerException.InnerException.Message);
                }
            }
            return msg;
        }

        /// <summary>
        /// 抛出异常
        /// </summary>
        /// <param name="msg">异常消息</param>
        public static void throwEx(string msg)
        {
            ruiException ex = new ruiException(msg);
            throw ex;
        }
    }

    /// <summary>
    ///  业务类中抛出的不合法异常
    /// </summary>
    public class ruiException : Exception
    {
        private string error;
        /// <summary>
        /// 构造函数
        /// </summary>
        /// <param name="msg">异常消息</param>
        public ruiException(string msg) : base(msg)
        {
            this.error = msg;
        }
    }
}
