using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using web.Controllers;

namespace web.Areas.admin.Controllers
{
    /// <summary>
    /// 控制器-物料-性能测试表
    /// wzrui 2019-03-24
    /// </summary>
    public class sbs_MaterielController : baseController
    {
        public ActionResult Select(db.view.sbs_Materiel model)
        {
            model.Search();
            if (rui.requestHelper.isAjax())
                return PartialView("_showData", model);
            return View(model);
        }
    }
}
