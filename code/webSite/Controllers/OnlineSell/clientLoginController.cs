using db;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace web.Controllers.Client
{
    public class clientLoginController : Controller
    {
        // GET: clientLogin
        [HttpGet]
        public ActionResult Index()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Index(string userName, string password)
        {
            string username = db.bll.client.user.getUserName(userName);
            string pass = db.bll.client.user.getUserPass(userName);
            //bool boole= (username == userName);
            //bool booll = (password == pass);
            if (userName == username && password == pass)
            {
                //创建登录标识
                Session["isLogin"] = true;
                //判断来源
                if (Session["toUrl"] != null)
                {
                    return new RedirectResult(Session["toUrl"].ToString());
                }
                return new RedirectResult("/Book/Index");
            }
            else
            {
                
                ViewData["msg"] = "账号或密码不正确！"/*+username+pass+" "+userName+password+boole+booll*/;
                return View();
            }
        }
        public ActionResult Error()
        {
            return View();
        }
    }
}