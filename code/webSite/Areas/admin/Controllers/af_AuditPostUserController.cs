using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using web.Controllers;

namespace web.Areas.admin.Controllers
{
    /// <summary>
    /// 控制器-用户任职表
    /// wzrui 2019-06-17
    /// </summary>
    public class af_AuditPostUserController : baseController
    {
        public ActionResult Select(db.view.af_AuditPostUser model)
        {
            model.Search();
            if (rui.requestHelper.isAjax())
                return PartialView("_showData", model);
            return View(model);
        }

        //批量任职
        [HttpPost]
        public JsonResult userBatchPost(string keyFieldValues, string postCode)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                string msg = db.bll.af_AuditPostUser.batchSetPost(keyFieldValues, postCode, dc);
                result.data = rui.jsonResult.getAJAXResult(msg, true);
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex);
                result.data = rui.jsonResult.getAJAXResult(ex.Message, false);
            }
            return Json(result.data);
        }

        //批量保存
        public JsonResult batchSave()
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                List<string> rowIDList = rui.requestHelper.getList("rowIDList");
                List<string> showValueList = rui.requestHelper.getList("showValueList");
                List<string> isDeptPostList = rui.requestHelper.getList("isDeptPostList");
                List<string> deptCodeList = rui.requestHelper.getList("deptCodeList");

                string msg = db.bll.af_AuditPostUser.batchSave(rowIDList, showValueList, isDeptPostList, deptCodeList, dc);
                result.data = rui.jsonResult.getAJAXResult(msg, true);
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
                db.bll.af_AuditPostUser.delete(rowID, dc);
                result.data = rui.jsonResult.getAJAXResult("删除成功", true);
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex);
                result.data = rui.jsonResult.getAJAXResult(ex.Message, false);
            }
            return Json(result.data);
        }
    }
}
