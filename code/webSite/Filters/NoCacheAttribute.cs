using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace web.Filters
{
    /// <summary>
    /// 缓存过滤器
    /// </summary>
    public class NoCacheAttribute : ActionFilterAttribute 
    {
        public override void OnResultExecuting(ResultExecutingContext filterContext)
        {
            filterContext.HttpContext.Response.Cache.SetCacheability(System.Web.HttpCacheability.NoCache);
            filterContext.HttpContext.Response.Cache.SetNoStore();
        }
    }
}