using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using web.Controllers;

namespace web.Areas.admin.Controllers
{
    public class bks_SupplierController : baseController
    {
        //
        // GET: /admin/bks_Supplier/
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Select(db.view.bks_Supplier model)
        {
            model.Search();
            if (Request.IsAjaxRequest())
                return PartialView("_showData", model);
            return View(model);
        }

        public ActionResult Detail(string rowID)
        {
            db.bks_Supplier model = db.bll.bks_Supplier.getEntryByRowID(rowID, dc);
            return View(model);
        }
        //展示新增
        [HttpGet]
        public ActionResult Insert()
        {
            db.bks_Supplier model = new db.bks_Supplier();
            return View(model);
        }
        //保存新增
        [HttpPost]
        public JsonResult Insert(db.bks_Supplier model)
        {
            JsonResult result = new JsonResult();
            try
            {
                if (ModelState.IsValid)
                {
                    string rowID = db.bll.bks_Supplier.insert(model, dc);
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
            db.bks_Supplier model = db.bll.bks_Supplier.getEntryByRowID(rowID, dc);
            return View(model);
        }

        //保存更新
        [HttpPost]
        public ActionResult Update(db.bks_Supplier model)
        {
            JsonResult result = new JsonResult();
            try
            {
                if (ModelState.IsValid)
                {
                    db.bll.bks_Supplier.update(model, dc);
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
                db.bll.bks_Supplier.delete(rowID, dc);
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