using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using web.Filters;

namespace web.Controllers.OnlineSell
{
    [checkClientLogin]
    public class bks_CustomerAddressController : Controller
    {
        // GET: bks_CustomerAddress
        public ActionResult Index()
        {
            return View();
        }
    }
}