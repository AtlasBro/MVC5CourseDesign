using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using web.Controllers;

namespace web.Areas.onlineSell.Controllers
{
    public class bks_bookPressController : baseController
    {
        // GET: bks_bookPress
        public ActionResult Index(db.client.view.bks_Book model)
        {
            model.Search();
            //ajax请求返回局部视图
            if (Request.IsAjaxRequest())
                return PartialView("_showData", model);
            return View(model);
        }
        //栏目不怎么编号，缓存机制
        [OutputCache(Duration = 1000)]
        [ChildActionOnly]
        public ActionResult showNav()
        {
            ViewData["bks_PressTable"] = db.client.bll.bks_Press.getTable(dc);
            return PartialView();
        }
    }
}