using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using web.Controllers;

namespace web.Areas.admin.Controllers
{
    /// <summary>
    /// 审批单据类型
    /// </summary>
    public class af_AuditTypeController : baseController
    {
        //搜索数据
        public ActionResult Select(db.view.af_AuditType model)
        {
            model.Search();
            if (rui.requestHelper.isAjax())
                return PartialView("_showData", model);
            return View(model);
        }

        //展示详情
        public ActionResult Detail(string rowID)
        {
            db.af_AuditType model = db.bll.af_AuditType.getEntryByRowID(rowID, dc);
            return View(model);
        }

        //展示新增
        [HttpGet]
        public ActionResult Insert()
        {
            db.af_AuditType model = new db.af_AuditType();
            return View(model);
        }

        //保存新增
        [HttpPost]
        public JsonResult Insert(db.af_AuditType model)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                if (ModelState.IsValid)
                {
                    string rowID = db.bll.af_AuditType.insert(model, dc);
                    result.data = rui.jsonResult.getAJAXResult("新增成功", true, 
                        rui.jsonResult.getDicByRowID(rowID));
                }
                else
                {
                    result.data = rui.jsonResult.getAJAXResult("输入不合法", false);
                }
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex);
                result.data = rui.jsonResult.getAJAXResult(rui.excptHelper.getExMsg(ex), false);
            }
            return Json(result.data);
        }

        //展示更新
        [HttpGet]
        public ActionResult Update(string rowID)
        {
            db.af_AuditType model = db.bll.af_AuditType.getEntryByRowID(rowID, dc);
            return View(model);
        }

        //保存更新
        [HttpPost]
        public JsonResult Update(db.af_AuditType model)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                if (ModelState.IsValid)
                {
                    db.bll.af_AuditType.update(model, dc);
                    result.data = rui.jsonResult.getAJAXResult("更新成功", true);
                }
                else
                {
                    result.data = rui.jsonResult.getAJAXResult("输入不合法", false);
                }
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
                string keyCode = db.bll.af_AuditType.getKeyByRowID(rowID,dc);
                db.bll.af_AuditType.delete(keyCode, dc);
                result.data = rui.jsonResult.getAJAXResult("删除成功", true);
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
