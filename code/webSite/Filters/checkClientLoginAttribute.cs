using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace web.Filters
{
    //前端用户
    public class checkClientLoginAttribute:FilterAttribute,IAuthorizationFilter
    {
        public void OnAuthorization(AuthorizationContext filterContext)
        {
            //判断登录状态
            if (db.client.bll.loginHelper.isLogin() == false)
            {
                filterContext.Result = new RedirectResult("/onlineSell/Default/Index");
            }
        }
    }
}