using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using web.Controllers;

namespace web.Areas.admin.Controllers
{
    /// <summary>
    /// 控制器-入库明细表表
    /// wzrui 2020-02-19
    /// </summary>
    public class bks_BookStockDetailController : baseController
    {
        //主界面
        public ActionResult Select(db.view.bks_BookStockDetail model)
        {
            model.Search();
            if (Request.IsAjaxRequest())
                return PartialView("_showData" + model.opMode, model);
            return PartialView(model);
        }

        //详情
        public ActionResult Detail(string rowID)
        {
            db.bks_BookStockDetail model = db.bll.bks_BookStockDetail.getEntryByRowID(rowID, dc);
            return View(model);
        }

        //展示新增
        [HttpGet]
        public ActionResult Insert(string stockCode)
        {
            db.bks_BookStockDetail model = new db.bks_BookStockDetail();
            model.stockCode = stockCode;
            return View(model);
        }

        //保存新增
        [HttpPost]
        public JsonResult Insert(db.bks_BookStockDetail model)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                if (ModelState.IsValid)
                {
                    string rowID = db.bll.bks_BookStockDetail.insert(model, dc);
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

        //批量新增图书明细
        [HttpPost]
        public JsonResult batchInsert(string stockCode, string selectedBooks)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                db.bll.bks_BookStockDetail.batchInsert(stockCode, selectedBooks, dc);
                result.data = rui.jsonResult.getAJAXResult("批量新增成功", true);
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
            db.bks_BookStockDetail model = db.bll.bks_BookStockDetail.getEntryByRowID(rowID, dc);
            return View(model);
        }

        //保存更新
        [HttpPost]
        public ActionResult Update(db.bks_BookStockDetail model)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                if (ModelState.IsValid)
                {
                    db.bll.bks_BookStockDetail.update(model, dc);
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
                db.bll.bks_BookStockDetail.delete(rowID, dc);
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
