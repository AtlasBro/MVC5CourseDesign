using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace rui
{
    /// <summary>
    /// 系统常用配置项目
    /// 处理和Core代码差异性
    /// </summary>
    public partial class configHelper
    {
        /// <summary>
        /// 获取数据库配置信息
        /// </summary>
        /// <param name="configCode"></param>
        /// <returns></returns>
        public static string getDbValue(string configCode)
        {
            using(rui.dbHelper db = rui.dbHelper.createHelper())
            {
                string sql = @" SELECT configValue FROM dbo.sys_Config WHERE configCode=@configCode ";
                object value = db.ExecuteScalar(sql, new { configCode });
                return rui.typeHelper.toString(value);
            }
        }

        /// <summary>
        /// 获取配置串的值
        /// </summary>
        /// <param name="configKey"></param>
        /// <param name="defaultValue">默认值</param>
        /// <returns></returns>
        public static string getAppValue(string configKey, string defaultValue = "")
        {
            string value = System.Configuration.ConfigurationManager.AppSettings[configKey];
            if (value == null)
                value = defaultValue;
            return value;
        }
        /// <summary>
        /// 返回连接串连接值
        /// </summary>
        /// <returns></returns>
        public static string getConnString(string connName)
        {
            return System.Configuration.ConfigurationManager.ConnectionStrings[connName].ConnectionString;
        }
        /// <summary>
        /// 返回连接串提供程序
        /// </summary>
        /// <returns></returns>
        public static string getConnProvider(string connName)
        {
            return System.Configuration.ConfigurationManager.ConnectionStrings[connName].ProviderName;
        }


        /// <summary>
        /// 请选择显示的内容
        /// </summary>
        public static string va请选择Text = getAppValue("va请选择Text", "=请选择=");
        /// <summary>
        /// 请选择的Value值
        /// </summary>
        public static string va请选择Value = getAppValue("va请选择Value", "");
        /// <summary>
        /// 长日期格式
        /// </summary>
        public static string dateFormatLang = getAppValue("dateFormatLang", "yyyy-MM-dd HH:mm:ss");
        /// <summary>
        /// 短日期格式
        /// </summary>
        public static string dateFormat = getAppValue("dateFormat", "yyyy-MM-dd");
        /// <summary>
        /// 默认分页大小 - 在appSetting - pageSize
        /// </summary>
        public static int pageSize = rui.typeHelper.toInt(getAppValue("pageSize", "18"));
        /// <summary>
        /// 默认对话框页面分页大小 - 在appSetting - pageSizeDlg
        /// </summary>
        public static int pageSizeDlg = rui.typeHelper.toInt(getAppValue("pageSizeDlg", "15"));
        /// <summary>
        /// 默认选择界面分页大小 - 在appSetting - pageSizeSelect
        /// </summary>
        public static int pageSizeSelect = rui.typeHelper.toInt(getAppValue("pageSizeSelect", "15"));
        /// <summary>
        /// 最大分页大小
        /// </summary>
        public static int pageSizeMax = 1000000;
        /// <summary>
        /// 是否上线运行
        /// true和false
        /// </summary>
        public static string isOnline = getAppValue("isOnline","否");
        /// <summary>
        /// 是否输出的异常错误
        /// </summary>
        public static string isShowRuiException = getAppValue("isShowRuiException", "否");
        /// <summary>
        /// 运行的项目名称
        /// </summary>
        public static string prjName = getAppValue("prjName", "mvc开发框架");
        /// <summary>
        /// 前端资源缓存控制
        /// </summary>
        public static string ctxKey = $"?v={getAppValue("ctxKey", "20200101")}";
        /// <summary>
        /// 系统管理员账号名称，在appSetting - sysAdmin
        /// </summary>
        public static string adminName = getAppValue("adminName", "sysAdmin");
        /// <summary>
        /// 新增数据的sourceForm名称
        /// </summary>
        public static string va新增名 = "系统";
        /// <summary>
        /// 导入数据的sourceForm名称，在appSetting - va外库名
        /// </summary>
        public static string va外库名 = getAppValue("va外库名");
    }
}
