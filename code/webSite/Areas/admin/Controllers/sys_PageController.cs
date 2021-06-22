using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using web.Controllers;

namespace web.Areas.admin.Controllers
{
    /// <summary>
    /// 页面分页和列配置
    /// </summary>
    public class sys_PageController : baseController
    {
        //页面设置展示
        public ActionResult select(db.view.pageConfig model)
        {
            model.Search();
            if (rui.requestHelper.isAjax())
                return PartialView("_showData", model);
            return View(model);
        }

        //保存页面设置
        public JsonResult Update(string resourceCode,int cPageSize,int cPageWidth)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                db.bll.sys_UcPage.update(resourceCode, cPageSize, cPageWidth, dc);
                result.data = rui.jsonResult.getAJAXResult("保存成功", true);
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex);
                result.data = rui.jsonResult.getAJAXResult(rui.excptHelper.getExMsg(ex), false);
            }
            return Json(result.data);
        }

        //页面设置重置
        public JsonResult reSet(string resourceCode)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                db.bll.sys_UcPage.reSet(resourceCode, dc);
                result.data = rui.jsonResult.getAJAXResult("重置成功", true);
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex);
                result.data = rui.jsonResult.getAJAXResult(rui.excptHelper.getExMsg(ex), false);
            }
            return Json(result.data);
        }
    }
}
