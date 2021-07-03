using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using web.Controllers;
namespace web.Areas.admin.Controllers
{
    public class bks_OrderInfoController : baseController
    {
        //
        // GET: /admin/bks_OrderInfo/
        public ActionResult Index()
        {
            return View();
        }
        [HttpPost]
        public JsonResult batchpush(string keyFieldValues)

    {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                string msg = db.bll.bks_OrderInfo.batchpush(keyFieldValues, dc);
                result.data = rui.jsonResult.getAJAXResult(msg, true);
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex);
                result.data = rui.jsonResult.getAJAXResult(ex.Message, false);
            }
            return Json(result.data);
        }
        /// <summary>
        /// 主界面的查询Action
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public ActionResult Select(db.view.bks_OrderInfo model)
        {
            model.Search();
            //ajax请求是返回局部视图
            if (Request.IsAjaxRequest())
                return PartialView("_showData", model);
            return View(model);
        }
        public ActionResult Detail(string rowID)
        {
            db.bks_OrderInfo model = db.bll.bks_OrderInfo.getEntryByRowID(rowID, dc);
            return View(model);
        }
	}
}