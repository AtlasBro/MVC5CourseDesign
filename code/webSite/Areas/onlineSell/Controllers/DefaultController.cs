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
            model.PageSize = 8;
            model.Search();
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
        [HttpGet]
        public ActionResult Register()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Register(db.client.view.Register model)
        {
            if (ModelState.IsValid)
            {
                TempData["code"] = model.customerCode;
                TempData["name"] = model.cusomterName;
                TempData["email"] = model.email;
                TempData["telphone"] = model.telphone;
                TempData["password"] = model.password;
            }
            if (db.client.bll.registerHelper.IsRepeat(model, dc))
            {
                db.client.bll.registerHelper.SaveAccount(model, dc);
                return RedirectToAction("show");
            }
            else
            {
                return RedirectToAction("Register");
            }
        }
        public ActionResult show()
        {
            return View();
        }
        public ActionResult Exit()
        {
            return RedirectToAction("Login");
        }
    }
}