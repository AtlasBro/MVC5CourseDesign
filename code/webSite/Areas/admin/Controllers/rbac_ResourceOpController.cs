using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using web.Controllers;


namespace web.Areas.admin.Controllers
{
    public class rbac_ResourceOpController : baseController
    {
        public ActionResult SelectPartial(db.view.rbac_ResourceOp model)
        {
            model.Search();
            if (rui.requestHelper.isAjax())
                return PartialView("_ShowData" + model.opMode, model);
            return PartialView("SelectPartial", model);
        }

        //通过勾选维护行
        [HttpPost]
        public JsonResult InsertFromCheck(string resourceCode,string opCode,string tag)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                if (tag == "true")
                {
                    db.bll.rbac_ResourceOp.insert(resourceCode, opCode, dc);
                    result.data = rui.jsonResult.getAJAXResult("no:新增成功", true);
                }
                if(tag == "false")
                {
                    db.bll.rbac_ResourceOp.delete(resourceCode, opCode, dc);
                    result.data = rui.jsonResult.getAJAXResult("no:删除成功", true);
                }
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex);
                result.data = rui.jsonResult.getAJAXResult(rui.excptHelper.getExMsg(ex), false);
            }
            return Json(result.data);
        }

        //新增行
        [HttpPost]
        public JsonResult Insert(string resourceCode)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                db.bll.rbac_ResourceOp.insert(resourceCode, dc);
                result.data = rui.jsonResult.getAJAXResult("no:新增成功", true);
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex);
                result.data = rui.jsonResult.getAJAXResult(rui.excptHelper.getExMsg(ex), false);
            }
            return Json(result.data);
        }

        //删除
        [HttpPost]
        public JsonResult Delete(string rowID)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                db.bll.rbac_ResourceOp.delete(rowID, dc);
                result.data = rui.jsonResult.getAJAXResult("no:删除成功", true);
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