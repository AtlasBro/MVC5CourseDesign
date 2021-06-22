using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace System.Web
{
    /// <summary>
    /// 授权过滤器
    /// 直接用到Action上进行权限控制
    /// 当请求的控制器和Action名称不和授权资源对应的时候使用
    /// 例如主从表的，从表未添加到资源，默认的登录检查里边就不会进行权限控制，需要通过该方式来加上控制
    /// </summary>
    public class checkPrivAttribute : FilterAttribute, IAuthorizationFilter
    {
        /// <summary>
        /// 授权资源
        /// </summary>
        private string resourceCode { get; set; }

        /// <summary>
        /// 授权操作
        /// 允许多个操作码
        /// 当多个的时候，用有个操作码有权限，则代表有权限
        /// </summary>
        private string opCode { get; set; }

        /// <summary>
        /// 构造函数
        /// </summary>
        /// <param name="resourceCode"></param>
        /// <param name="opCode"></param>
        public checkPrivAttribute(string resourceCode,string opCode)
        {
            this.resourceCode = resourceCode;
            this.opCode = opCode;
        }

        /// <summary>
        /// 通用的方法
        /// 按照控制器名和Action名进行权限判断
        /// </summary>
        /// <param name="filterContext"></param>
        public void OnAuthorization(AuthorizationContext filterContext)
        {
            List<string> opList = rui.dbTools.getList(this.opCode);
            bool isPriv = false;
            foreach (var item in opList)
            {
                if (rui.privCtl.isPriv(resourceCode, item) == true)
                {
                    isPriv = true;
                    break;
                }
            }
            //判断是否有权限，没权限跳转到用户首页
            if (isPriv == false)
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