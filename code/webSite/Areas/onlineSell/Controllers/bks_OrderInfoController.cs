using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using web.Controllers;

namespace web.Areas.onlineSell.Controllers
{
    public class bks_OrderInfoController : baseController
    {
        // GET: onlineSell/bks_OrderInfo
        public ActionResult Index(db.client.view.bks_OrderInfo model)
        {
            model.Search();
            if (Request.IsAjaxRequest())
                return PartialView("_showData", model);
            return View(model);
        }
    }
}