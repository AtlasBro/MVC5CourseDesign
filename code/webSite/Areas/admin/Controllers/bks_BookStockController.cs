using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using web.Controllers;

namespace web.Areas.admin.Controllers
{
    /// <summary>
    /// 控制器-入库主表表
    /// wzrui 2020-02-19
    /// </summary>
    public class bks_BookStockController : baseController
    {
        //主界面
        public ActionResult Select(db.view.bks_BookStock model)
        {
            model.Search();
            if (Request.IsAjaxRequest())
                return PartialView("_showData", model);
            return View(model);
        }

        //详情
        public ActionResult Detail(string rowID)
        {
            db.bks_BookStock model = db.bll.bks_BookStock.getEntryByRowID(rowID, dc);
            return View(model);
        }

        //展示新增
        [HttpGet]
        public ActionResult Insert()
        {
            db.bks_BookStock model = new db.bks_BookStock();
            return View(model);
        }

        //保存新增
        [HttpPost]
        public JsonResult Insert(db.bks_BookStock model)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                if (ModelState.IsValid)
                {
                    string rowID = db.bll.bks_BookStock.insert(model, dc);
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
            db.bks_BookStock model = db.bll.bks_BookStock.getEntryByRowID(rowID, dc);
            return View(model);
        }

        //保存更新
        [HttpPost]
        public ActionResult Update(db.bks_BookStock model)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                if (ModelState.IsValid)
                {
                    db.bll.bks_BookStock.update(model, dc);
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
                db.bll.bks_BookStock.delete(rowID, dc);
                result.data = rui.jsonResult.getAJAXResult("删除成功", true);
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex);
                result.data = rui.jsonResult.getAJAXResult(rui.excptHelper.getExMsg(ex), false);
            }
            return Json(result.data);
        }
        [HttpPost]
        public JsonResult Print(string rowID)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                db.bll.bks_BookStock.Print(rowID, dc);
                result.data = rui.jsonResult.getAJAXResult("发布成功", true);
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex);
                result.data = rui.jsonResult.getAJAXResult(rui.excptHelper.getExMsg(ex), false);
            }
            return Json(result.data);
        }
        public ActionResult SelectExportl(db.view.bks_Book model)
        {
            
            try
            {
                //all代表要导出查询的所有数据,page代表导出本页的数据
                model.ExportRange = rui.dataRange.all.ToString();
                model.SheetName = "图书缺货信息";
                model.isNeedStock = "是";
                model.Search();
                return File(model.ExportToXls(), rui.innerCode.mime(".xlsx"), "图书缺货信息.xlsx");
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex);
                Response.Write(string.Format("<script>alert('{0}');history.go(-1);</script>", ex.Message));
            }
            return null;
        }
    }
}
