using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace web.Controllers.OnlineSell
{
    public class DefaultController : baseController
    {
        // GET: Default
        //图书首页
        public ActionResult Index(db.client.view.bks_Book model)
        {
            if (Request.IsAjaxRequest())
                return PartialView("showData", model);
            return View(model);
        }

        [HttpGet]
        public ActionResult Login()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Login(string userCode,string userPassword)
        {
            if (db.client.bll.loginHelper.login(userCode, userPassword, dc))
            {
                return RedirectToAction("Index");
            }
            else
            {
                ViewData["msg"] = "账号或密码错误";
            }
            return View("Login");
        }
    }
}