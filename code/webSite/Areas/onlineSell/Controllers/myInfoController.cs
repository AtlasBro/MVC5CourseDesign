using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using web.Controllers;
using web.Filters;

namespace web.Areas.onlineSell.Controllers
{
    [checkClientLogin]
    public class myInfoController : Controller
    {
        // GET: myInfo
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult Nav()
        {
            return  PartialView();
        }
    }
}