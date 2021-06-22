using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Web;

namespace db.bll
{
    //网站日志操作记录
    public class sys_WebLog
    {
        //获取来源地址
        private static string _getFromLoc(HttpContext ctx)
        {
            string url = "";
            try
            {
                url = rui.typeHelper.toString(ctx.Request.UrlReferrer);
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex, true);
            }
            return url;
        }

        //获取访问地址
        private static string _getAccessLoc(HttpContext ctx)
        {
            return ctx.Request.Url.ToString();
        }

        //获取访问方式
        private static string _getRequestType(HttpContext ctx)
        {
            return ctx.Request.RequestType;
        }

        //获取查询字符串数据
        private static void _getQueryData(logEntry entry)
        {
            string[] queryString = entry.ctx.Request.QueryString.AllKeys;
            for (int i = 0; i < queryString.Length; i++)
            {
                string key = queryString[i];
                entry.queryDic.Add(key, entry.ctx.Request.QueryString[key]);
            }
        }

        //获取表单数据
        private static void _getFormData(logEntry entry)
        {
            string[] form = entry.ctx.Request.Form.AllKeys;
            for (int i = 0; i < form.Length; i++)
            {
                string key = form[i];
                entry.formDic.Add(key, entry.ctx.Request.Form[key]);
            }
        }

        //----------------------------以上代码.net和.netCore不同------------------------------

        //记录登录日志
        public static void logLogin()
        {
            db.efHelper ef = new db.efHelper();
            logEntry entry = new logEntry();
            entry.ctx = rui.autoFacHelper.getHttpContext();
            entry.userCode = db.bll.loginAdminHelper.getUserCode();
            entry.fromIP = rui.sessionHelper.getValue("fromIP");
            entry.ipLoc = rui.sessionHelper.getValue("ipLoc");

            //通过线程完成登录日志记录
            Task.Factory.StartNew(() => {
                string userCode = entry.userCode;
                string fromIp = entry.fromIP;
                string ipLoc = entry.ipLoc;
                string sql = @" INSERT INTO sys_WebLog(rowID,logDate,logType,userCode,fromIP,ipLoc)
                                VALUES  (@rowID,GETDATE(),N'登录',@userCode,@fromIp,@ipLoc) ";
                ef.Execute(sql, new { rowID = ef.newGuid(), userCode, fromIp, ipLoc });
            });
        }

        //记录所有访问日志
        public static void logAccess()
        {
            logEntry entry = new logEntry();
            entry.ctx = rui.autoFacHelper.getHttpContext();
            entry.userCode = db.bll.loginAdminHelper.getUserCode();
            entry.fromIP = rui.sessionHelper.getValue("fromIP");
            entry.ipLoc = rui.sessionHelper.getValue("ipLoc");

            //获取相关的数据
            _getQueryData(entry);
            _getFormData(entry);

            Task.Factory.StartNew(() => {
                db.efHelper ef = new db.efHelper();
                string userCode = entry.userCode;
                string fromIp = entry.fromIP;
                string ipLoc = entry.ipLoc;
                string fromLoc = sys_WebLog._getFromLoc(entry.ctx);
                string accessLoc = sys_WebLog._getAccessLoc(entry.ctx);
                string requestType = sys_WebLog._getRequestType(entry.ctx);

                if (requestType == "GET") {
                    string sql = @" INSERT INTO sys_WebLog(rowID,logDate,logType,userCode,fromIP,ipLoc,fromLoc,accessLoc,requestType)
                                VALUES  (@rowID,GETDATE(),N'请求',@userCode,@fromIp,@ipLoc,@fromLoc,@accessLoc,@requestType) ";
                    ef.Execute(sql, new { rowID = ef.newGuid(), userCode, fromIp, ipLoc, fromLoc, accessLoc, requestType });
                }
                if (requestType == "POST") {
                    StringBuilder remark = new StringBuilder();
                    List<string> exceptKey = new List<string>();
                    exceptKey.Add("__RequestVerificationToken");
                    //获取操作数据
                    foreach (var key in entry.queryDic.Keys) {
                        if (exceptKey.Contains(key) == false)
                            remark.Append(string.Format("&{0}={1}", key, entry.queryDic[key]));
                    }
                    foreach (var key in entry.formDic.Keys) {
                        if (exceptKey.Contains(key) == false)
                            remark.Append(string.Format("&{0}={1}", key, entry.formDic[key]));
                    }

                    string sql = @" INSERT INTO sys_WebLog(rowID,logDate,logType,userCode,fromIP,ipLoc,fromLoc,accessLoc,requestType,remark)
                                VALUES  (rowID = ef.newGuid(),GETDATE(),N'提交',@userCode,@fromIp,@ipLoc,@fromLoc,@accessLoc,@requestType,@remark) ";
                    string remarkValue = remark.ToString();
                    ef.Execute(sql, new { userCode, fromIp, ipLoc, fromLoc, accessLoc, requestType, remark = remarkValue });

                    entry.queryDic.Clear();
                    entry.formDic.Clear();
                    entry = null;
                }
            });
        }

        class logEntry 
        {
            public HttpContext ctx { get; set; }
            public string userCode { get; set; }
            public string fromIP { get; set; }
            public string ipLoc { get; set; }
            public Dictionary<string, string> queryDic = new Dictionary<string, string>();
            public Dictionary<string, string> formDic = new Dictionary<string, string>();
        }
    }
}

