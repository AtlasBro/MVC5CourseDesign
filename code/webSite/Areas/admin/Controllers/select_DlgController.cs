using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using web.Controllers;

namespace web.Areas.admin.Controllers
{
    /// <summary>
    /// 弹窗选择控制器 - 单选
    /// </summary>
    public class select_DlgController : baseController
    {
        public ActionResult SelectBook(db.view.bks_Book model)
        {
            model.Search();
            //ajax请求是返回局部视图
            if (Request.IsAjaxRequest())
                return PartialView("_showData", model);
            return View(model);
        }
    }
}
