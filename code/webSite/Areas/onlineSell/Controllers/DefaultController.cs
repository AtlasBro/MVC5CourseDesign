using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using web.Controllers;

namespace web.Areas.onlineSell.Controllers
{
    public class DefaultController : baseController
    {
        // GET: Default
        //图书首页
        public ActionResult Index(db.client.view.bks_Book model)
        {
            if (Request.IsAjaxRequest())
                return PartialView("_showData", model);
            return View(model);
        }

        [HttpGet]
        public ActionResult Login()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Login(string userCode, string userPassword)
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