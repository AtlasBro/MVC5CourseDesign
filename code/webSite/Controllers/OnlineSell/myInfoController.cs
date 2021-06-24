using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using web.Filters;

namespace web.Controllers.OnlineSell
{
    public class myInfoController : Controller
    {
        [checkClientLogin]
        // GET: myInfo
        public ActionResult Index()
        {
            return View();
        }
    }
}