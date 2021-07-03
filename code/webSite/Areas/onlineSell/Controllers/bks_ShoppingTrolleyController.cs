using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using web.Controllers;

namespace web.Areas.onlineSell.Controllers
{
    public class bks_ShoppingTrolleyController : baseController
    {
        // GET: onlineSell/bks_ShoppingTrolley
        public ActionResult Index(db.client.view.bks_ShoppingTrolley model)
        {
            model.PageSize = 10;
            model.Search();
            if (Request.IsAjaxRequest())
                return PartialView("_showData", model);
            return View(model);
        }
        //加入购物车
        public JsonResult addCart(string bookCode)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                string customerCode = db.client.bll.loginHelper.getLoginUserCode();
                if (customerCode == null)
                    rui.excptHelper.throwEx("客户端未登录");

                db.client.bll.bks_ShoppingTrolley.addCart1(customerCode, bookCode, dc);
                result.data = rui.jsonResult.getAJAXResult("添加成功", true);
            }
            catch(Exception ex)
            {
                rui.logHelper.log(ex);
                result.data = rui.jsonResult.getAJAXResult(rui.excptHelper.getExMsg(ex), false);
            }
            return Json(result.data);
        }
        //数量+
        public JsonResult add(string bookCode)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                string customerCode = db.client.bll.loginHelper.getLoginUserCode();
                if (customerCode == null)
                    rui.excptHelper.throwEx("客户端未登录");

                db.client.bll.bks_ShoppingTrolley.addNum1(customerCode, bookCode, dc);
                result.data = rui.jsonResult.getAJAXResult("累加成功", true);
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex);
                result.data = rui.jsonResult.getAJAXResult(rui.excptHelper.getExMsg(ex), false);
            }
            return Json(result.data);
        }
        //数量-
        public JsonResult sub(string bookCode)
        {
            db.dbEntities dc = new db.dbEntities();
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                string customerCode = db.client.bll.loginHelper.getLoginUserCode();
                if (customerCode == null)
                    rui.excptHelper.throwEx("客户端未登录");

                db.client.bll.bks_ShoppingTrolley.subNum1(customerCode, bookCode, dc);
                result.data = rui.jsonResult.getAJAXResult("累减成功", true);
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