using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using web.Controllers;

namespace web.Areas.admin.Controllers
{
    /// <summary>
    /// 控制器-职务任职表表
    /// wzrui 2019-06-16
    /// </summary>
    public class af_AuditPostController : baseController
    {
        //列表主界面
        public ActionResult Select(db.view.af_AuditPost model)
        {
            model.Search();
            if (rui.requestHelper.isAjax())
                return PartialView("_showData", model);
            return View(model);
        }

        //详情
        public ActionResult Detail(string rowID)
        {
            db.af_AuditPost model = db.bll.af_AuditPost.getEntryByRowID(rowID, dc);
            return View(model);
        }

        //展示新增
        [HttpGet]
        public ActionResult Insert()
        {
            db.af_AuditPost model = new db.af_AuditPost();
            return View(model);
        }

        //保存新增
        [HttpPost]
        public JsonResult Insert(db.af_AuditPost model)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                if (ModelState.IsValid)
                {
                    string rowID = db.bll.af_AuditPost.insert(model, dc);
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
                result.data = rui.jsonResult.getAJAXResult(ex.Message, false);
            }
            return Json(result.data);
        }

        //展示更新
        [HttpGet]
        public ActionResult Update(string rowID)
        {
            db.af_AuditPost model = db.bll.af_AuditPost.getEntryByRowID(rowID, dc);
            return View(model);
        }

        //保存更新
        [HttpPost]
        public ActionResult Update(db.af_AuditPost model)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                if (ModelState.IsValid)
                {
                    db.bll.af_AuditPost.update(model, dc);
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
                result.data = rui.jsonResult.getAJAXResult(ex.Message, false);
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
                db.bll.af_AuditPost.delete(rowID, dc);
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
