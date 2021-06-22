using System;
using System.IO;
using NLog;
using NLog.Config;
using NLog.Targets;
using System.Text;

namespace rui
{
    /// <summary>
    /// 日志输出辅助类
    /// </summary>
    public class logHelper
    {
        /// <summary>
        /// 记录文本内容
        /// 如果上线后不输出
        /// </summary>
        /// <param name="message">记录的文本内容</param>
        public static void log(string message)
        {
            logHelper.Instance.LogMsg(message);
        }

        /// <summary>
        /// 记录异常内容
        /// 如果是自定义的异常，上线后不记录
        /// </summary>
        /// <param name="ex">记录的异常对象</param>
        /// <param name="isThrow">是否继续向外抛出该异常</param>
        public static void log(Exception ex,bool isThrow=false)
        {
            if(ex != null)
                logHelper.Instance.LogException(ex);
            if (ex.InnerException != null)
                logHelper.Instance.LogException(ex.InnerException);

            if (isThrow == true)
                throw ex;
        }

        /// <summary>
        /// 记录错误，记录异常
        /// 如果上线了，错误不记录，自定义异常不记录
        /// </summary>
        /// <param name="message">记录的文本内容</param>
        /// <param name="ex">记录的异常对象</param>
        /// <param name="isThrow">是否继续向外抛出该异常</param>
        public static void log(string message, Exception ex, bool isThrow = false)
        {
            log(message);
            log(ex, isThrow);
        }

        /// <summary>
        /// 输出调试信息
        /// 上线后也输出
        /// </summary>
        /// <param name="message">调试的文本内容</param>
        public static void debug(string message)
        {
            try
            {
                logHelper.Instance.LogDebug(message);
            }
            catch
            {

            }
        }

        /// <summary>
        /// 记录字符串内容 - 上线后不输出
        /// </summary>
        /// <param name="message"></param>
        private void LogMsg(string message)
        {
            try
            {
                if (rui.configHelper.isOnline != "true")
                    logger.Info(message);
            }
            catch
            {

            }
        }

        /// <summary>
        /// 记录字符串内容 - 上线后还输出
        /// </summary>
        /// <param name="message"></param>
        private void LogDebug(string message)
        {
            try
            {
                logger.Info(message);
            }
            catch
            {

            }
        }

        /// <summary>
        /// 记录异常内容
        /// 如果是自定义的异常，则上线后不记录
        /// </summary>
        /// <param name="ex"></param>
        private void LogException(Exception ex)
        {
            try
            {
                //如果是自定义的异常，则不进行记录
                if(ex.GetType().ToString() != "rui.ruiException")
                {
                    logger.Error(getExInfo(ex));
                }
                if(ex.GetType().ToString() == "rui.ruiException" && rui.configHelper.isShowRuiException == "是")
                {
                    logger.Error(getExInfo(ex));
                }
            }
            catch
            {

            }
        }

        /// <summary>
        /// 获取异常消息
        /// </summary>
        /// <param name="ex"></param>
        /// <returns></returns>
        private string getExInfo(Exception ex)
        {
            StringBuilder info = new StringBuilder();
            info.AppendLine(ex.Message);
            info.AppendLine("------------begin-------------");
            info.AppendLine(ex.StackTrace);
            info.AppendLine("------------End-------------");
            return info.ToString();
        }

        private Logger logger;
        private logHelper()
        {
            LogDate = DateTime.Now;
            SimpleConfigurator.ConfigureForTargetLogging(GetFileTarget());
            logger = LogManager.GetCurrentClassLogger();
        }
        private DateTime logDate;
        private DateTime LogDate
        {
            get { return logDate; }
            set { logDate = value; }
        }
        //单例对象
        private static logHelper _Instance;
        private static logHelper Instance
        {
            get
            {
                if (_Instance == null)
                {
                    _Instance = new logHelper();
                }
                else
                {
                    if (_Instance.logDate.Date != DateTime.Now.Date)
                    {
                        _Instance = new logHelper();
                    }
                }
                return _Instance;
            }
        }
        //获取一个Log文件
        private string GetLogFile()
        {
            string fileName = "Log_" + DateTime.Now.ToString("yyyy-MM-dd") + ".txt";
            return Path.Combine(AppDomain.CurrentDomain.BaseDirectory + "log", fileName);
        }
        //设置Log输出的目标信息
        private FileTarget GetFileTarget()
        {
            FileTarget ft = new FileTarget();
            ft.Encoding = "UTF-8";
            ft.FileName = GetLogFile();
            ft.Layout = "${longdate} ${level} ${message} ";
            ft.KeepFileOpen = false;
            ft.OpenFileCacheTimeout = 10;
            ft.OpenFileCacheSize = 1;
            return ft;
        }
    }
}
