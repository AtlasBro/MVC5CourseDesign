using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using web.Controllers;

namespace web.Areas.admin.Controllers
{
    public class bks_PressController : baseController
    {
        //
        // GET: /admin/bks_Press/
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult Select(db.view.bks_Press model)
        {
            model.Search();
            //ajax请求是返回局部视图
            if (Request.IsAjaxRequest())
                return PartialView("_showData", model);
            return View(model);
        }
        public ActionResult Detail(string rowID)
        {
            db.bks_Press model = db.bll.bks_Press.getEntryByRowID(rowID, dc);
            return View(model);
        }

        //展示新增
        [HttpGet]
        public ActionResult Insert()
        {
            db.bks_Press model = new db.bks_Press();
            return View(model);
        }

        //保存新增
        [HttpPost]
        public JsonResult Insert(db.bks_Press model)
        {
            JsonResult result = new JsonResult();
            try
            {
                if (ModelState.IsValid)
                {
                    string rowID = db.bll.bks_Press.insert(model, dc);
                    result.Data = rui.jsonResult.getAJAXResult("新增成功", true,
                        rui.jsonResult.getDicByRowID(rowID));
                }
                else
                {
                    result.Data = rui.jsonResult.getAJAXResult("输入不合法", false);
                }
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex);
                result.Data = rui.jsonResult.getAJAXResult(ex.Message, false);
            }
            return result;
        }

        //展示更新
        [HttpGet]
        public ActionResult Update(string rowID)
        {
            db.bks_Press model = db.bll.bks_Press.getEntryByRowID(rowID, dc);
            return View(model);
        }

        //保存更新
        [HttpPost]
        public ActionResult Update(db.bks_Press model)
        {
            JsonResult result = new JsonResult();
            try
            {
                if (ModelState.IsValid)
                {
                    db.bll.bks_Press.update(model, dc);
                    result.Data = rui.jsonResult.getAJAXResult("更新成功", true);
                }
                else
                {
                    result.Data = rui.jsonResult.getAJAXResult("输入不合法", false);
                }
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex);
                result.Data = rui.jsonResult.getAJAXResult(ex.Message, false);
            }
            return result;
        }

        //删除
        [HttpPost]
        public JsonResult Delete(string rowID)
        {
            JsonResult result = new JsonResult();
            try
            {
                db.bll.bks_Press.delete(rowID, dc);
                result.Data = rui.jsonResult.getAJAXResult("删除成功", true);
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex);
                result.Data = rui.jsonResult.getAJAXResult(ex.Message, false);
            }
            return result;
        }
	}
}