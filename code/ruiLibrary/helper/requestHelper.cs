using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace rui
{
    /// <summary>
    /// 获取用户的值
    /// </summary>
    public class requestHelper
    {
        /// <summary>
        /// 获取请求key的值
        /// </summary>
        /// <param name="key">键值</param>
        /// <returns></returns>
        private static string _getValue_Df(string key)
        {
            HttpContext ctx = rui.autoFacHelper.getHttpContext();
            string value = null;
            if (ctx.Request[key] != null)
            {
                value = ctx.Request[key].ToString();
            }
            return value;
        }

        /// <summary>
        /// 返回Request中指定key的值
        /// 如果是表单数组，则返回:a,b,c格式
        /// </summary>
        /// <param name="key">请求数据标识</param>
        /// <param name="isShowError">无该请求数据是否显示错误</param>
        /// <param name="errorMsg">错误消息内容</param>
        /// <returns>获取到的值</returns>
        public static string getValue(string key, bool isShowError = false, string errorMsg = "要获取的参数不存在")
        {
            string value = _getValue_Df(key);
            if (value != null)
            {
                return value;
            }
            if (value == null && isShowError)
            {
                rui.excptHelper.throwEx(errorMsg);
            }
            return "";
        }

        /// <summary>
        /// 获取表单数组的值，如果有值会加上一个,
        /// 格式：a,b,c,
        /// </summary>
        /// <param name="key">请求数据标识</param>
        /// <param name="isShowError">无该请求数据是否显示错误</param>
        /// <param name="errorMsg">错误提示内容</param>
        /// <returns></returns>
        public static string getMulValue(string key, bool isShowError = false, string errorMsg = "要获取的参数不存在")
        {
            string value = getValue(key, isShowError, errorMsg);
            if (value.Length > 0)
                value = value + ",";
            return value;
        }

        /// <summary>
        /// 获取表单数组的值,返回List数组
        /// 将获取的值拆分成字符串数组
        /// </summary>
        /// <param name="name">表单name属性</param>
        /// <returns>返回的值集合（包含空值）</returns>
        public static List<string> getList(string name)
        {
            string value = _getValue_Df(name);
            if (value != null)
            {
                //表单数组转成List
                List<string> list = (from a in value.Split(',')
                                     select a).ToList<string>();
                return list;
            }
            else
            {
                return new List<string>();
            }
        }

        /// <summary>
        /// 获取客户端请求中包含的所有Key列表
        /// </summary>
        /// <param name="entryPreTag">key前缀过滤</param>
        /// <returns></returns>
        public static List<string> getAllKey(string entryPreTag = "")
        {
            HttpContext ctx = rui.autoFacHelper.getHttpContext();
            var queryString = HttpContext.Current.Request.QueryString.AllKeys;
            var form = HttpContext.Current.Request.Form.AllKeys;

            List<string> list = new List<string>();
            foreach (string item in queryString)
                list.Add(item);
            foreach (string item in form)
                list.Add(item);

            //获取某个前缀开头的key
            if (entryPreTag != "")
            {
                list = (from a in list
                        where a.StartsWith(entryPreTag)
                        select a.Substring(entryPreTag.Length + 1)).ToList<string>();
            }
            return list;
        }

        /// <summary>
        /// 判断列表页面是否左侧导航栏进入的请求 - 用来完成相关默认数据的配置
        /// 判断请求网址中是否包含PageIndex参数
        /// </summary>
        /// <returns></returns>
        public static bool isFirstRequest()
        {
            string value = _getValue_Df("pageIndex");
            if (value == null)
                return true;
            else
                return false;
        }

        /// <summary>
        /// 第一次进入的时候，不展示查询数据
        /// 如果是第一次请求,给查询语句自动拼接上 and 1!=1 
        /// </summary>
        /// <param name="querySql"></param>
        public static void firstNoSearchData(ref string querySql)
        {
            if (isFirstRequest())
                querySql += " and 1!=1 ";
        }

        /// <summary>
        /// 是否分页请求
        /// 分页请求返回TRUE，否则返回FALSE
        /// 判断请求网址中是否不包含exeCountSql
        /// </summary>
        /// <returns></returns>
        public static bool isPagerRequest()
        {
            string value = _getValue_Df("exeCountSql");
            if (value == "false")
                return true;
            return false;
        }

        /// <summary>
        /// 判断是否搜索操作
        /// 第一次进入和单击搜索都认为是搜索操作
        /// 判断请求网址中是否包含exeCountSql
        /// </summary>
        /// <returns></returns>
        public static bool isSearchRequest()
        {
            string value = _getValue_Df("exeCountSql");
            if (value == "true")
                return true;
            return false;
        }

        /// <summary>
        /// 判断是否AJAX请求
        /// </summary>
        /// <returns></returns>
        public static bool isAjax()
        {
            HttpContext ctx = rui.autoFacHelper.getHttpContext();
            bool result = false;
            if (ctx.Request.Headers.AllKeys.Contains("X-Requested-With")
                && ctx.Request.Headers["X-Requested-With"] == "XMLHttpRequest")
            {
                result = true;
            }
            return result;
        }

        /// <summary>
        /// 获取请求基类
        /// </summary>
        /// <returns></returns>
        public static HttpRequestBase getRequestBase()
        {
            System.Web.HttpRequestBase requestBase = new HttpRequestWrapper(HttpContext.Current.Request);
            return requestBase;
        }

        /// <summary>
        /// 判断是否工人保存的（自动保存的会附加上auto参数，没有则人工保存的）
        /// </summary>
        /// <returns>TRUE人工保存</returns>
        public static bool isClickSave()
        {
            string auto = _getValue_Df("auto");
            return rui.typeHelper.isNullOrEmpty(auto);
        }

    }
}
