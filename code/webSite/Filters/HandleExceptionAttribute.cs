using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace web.Filters
{
    /// <summary>
    /// 异常过滤器
    /// </summary>
    public class HandleExceptionAttribute : HandleErrorAttribute, System.Web.Mvc.IExceptionFilter
    {
        public override void OnException(ExceptionContext filterContext)
        {
            rui.logHelper.log(filterContext.Exception);

            string message = filterContext.Exception.Message;
            if (filterContext.Exception.InnerException != null)
                message += "<br/>" + filterContext.Exception.InnerException.Message;
            rui.autoFacHelper.getHttpContext().Session["errorMessage"] = message;
            // 标记异常已处理
            filterContext.ExceptionHandled = true;
            // 跳转到错误页
            filterContext.Result = new RedirectResult("/login/errorShow");
        }
    }
}