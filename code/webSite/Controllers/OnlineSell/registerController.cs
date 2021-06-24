using db.view.client;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace web.Controllers.Client
{
    public class registerController : Controller
    {
        // GET: register
        public ActionResult Index()
        {
            return View();
        }
        //注册
        public ActionResult register()
        {
            return View();
        }

        [HttpPost]
        public ActionResult submit(userinfo model)
        {
            if (ModelState.IsValid)
            {
                TempData["CustomerCode"] = model.CustomerCode;
                TempData["CustomerName"] = model.CustomerName;
                TempData["Password"] = model.password;
                TempData["telephone"] = model.telephone;
                TempData["email"] = model.email;
                db.bll.client.user.save(model);
                return RedirectToAction("show");
            }
            return View(model);
        }
        public ActionResult show()
        {
            return View();
        }
    }
}