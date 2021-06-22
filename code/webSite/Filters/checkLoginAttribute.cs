using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Mvc;

namespace web.Filters
{
    /// <summary>
    /// 授权过滤器
    /// </summary>
    public class checkLoginAttribute : FilterAttribute, IAuthorizationFilter
    {
        public void OnAuthorization(AuthorizationContext filterContext)
        {
            //记录访问日志
            //db.bll.sys_WebLog.logAccess();

            //如果在Controller或者Action上加了 AllowAnonymous 特性，则不进行登录和授权控制
            var actionAnonymous = filterContext.ActionDescriptor.GetCustomAttributes(typeof(AllowAnonymousAttribute), true) as IEnumerable<AllowAnonymousAttribute>;
            var controllerAnonymous = filterContext.Controller.GetType().GetCustomAttributes(typeof(AllowAnonymousAttribute), true) as IEnumerable<AllowAnonymousAttribute>;
            if ((actionAnonymous != null && actionAnonymous.Any()) || (controllerAnonymous != null && controllerAnonymous.Any()))
            {
                return;
            }

            //类名称
            string classFullName = filterContext.Controller.ControllerContext.Controller.ToString();

            //请求的是后台模块
            if (classFullName.StartsWith("web.Areas.admin"))
            {
                //获取控制器名称
                string controllerName = filterContext.ActionDescriptor.ControllerDescriptor.ControllerName;
                //获取Action名称
                string actionName = filterContext.ActionDescriptor.ActionName;
                rui.logHelper.log(string.Format("{0}-{1}", controllerName, actionName));

                //排除的特定Action
                if (actionName.IndexOf("printData") >= 0)
                    return;

                //判断登录状态
                if (db.bll.loginAdminHelper.isLogin() == false)
                {
                    if (filterContext.HttpContext.Request.IsAjaxRequest())
                    {
                        rui.jsonResult result = new rui.jsonResult();
                        result.data = rui.jsonResult.getAJAXResult("登录状态实现", false);
                        filterContext.Result = new JsonResult() { Data = result.data };
                    }
                    else
                    {
                        filterContext.Result = new RedirectResult("/login/tologinAdmin");
                    }
                }
                else
                {
                    //判断是否有权限，没权限跳转到用户首页
                    if (rui.privCtl.isPriv(controllerName, actionName) == false)
                    {
                        if (filterContext.HttpContext.Request.IsAjaxRequest())
                        {
                            rui.jsonResult result = new rui.jsonResult();
                            result.data = rui.jsonResult.getAJAXResult("无权限", false);
                            filterContext.Result = new JsonResult() { Data = result.data };
                        }
                        else
                        {
                            filterContext.Result = new RedirectResult("/admin/sys_Home/Desktop");
                        }
                    }
                }
            }
        }
    }
}