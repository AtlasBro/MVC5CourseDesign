using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace web.Areas.onlineSell.Controllers
{
    public class bks_CustomerAddressController : Controller
    {
        // GET: onlineSell/bks_CustomerAddress
        public ActionResult Index(db.client.view.bks_CustomerAddress model)
        {
            model.Search();
            if (Request.IsAjaxRequest())
                return PartialView("_showData", model);
            return View(model);
        }
    }
}