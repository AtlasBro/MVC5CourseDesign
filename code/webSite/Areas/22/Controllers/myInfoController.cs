using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using web.Controllers;
using web.Filters;

namespace web.Areas.onlineSell.Controllers
{
    public class myInfoController : baseController
    {
        [checkClientLogin]
        // GET: myInfo
        public ActionResult Index()
        {
            return View();
        }
    }
}