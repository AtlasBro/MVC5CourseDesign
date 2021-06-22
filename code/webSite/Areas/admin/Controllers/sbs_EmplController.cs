using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using web.Controllers;

namespace web.Areas.admin.Controllers
{
    public class sbs_EmplController : baseController
    {
        //列表主界面
        public ActionResult Select(db.view.sbs_Empl model)
        {
            if (rui.requestHelper.isFirstRequest())
                model.orgCode = db.bll.loginAdminHelper.getOrgCode();
            model.Search();
            if (rui.requestHelper.isAjax())
                return PartialView("_showData", model);
            return View(model);
        }

        //展示详情
        public ActionResult Detail(string rowID)
        {
            db.sbs_Empl model = db.bll.sbs_Empl.getEntryByRowID(rowID, dc);
            model.orgCode = db.bll.sbs_Org.getNameByCode(model.orgCode, dc);
            model.deptCode = db.bll.sbs_Dept.getNameByCode(model.deptCode, dc);
            return View(model);
        }

        //展示新增
        [HttpGet]
        public ActionResult Insert()
        {
            db.sbs_Empl model = new db.sbs_Empl();
            return View(model);
        }

        //保存新增
        [HttpPost]
        public JsonResult Insert(db.sbs_Empl model)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                if (ModelState.IsValid)
                {
                    string rowID = db.bll.sbs_Empl.insert(model, dc);
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
            db.sbs_Empl model = db.bll.sbs_Empl.getEntryByRowID(rowID, dc);
            return View(model);
        }

        //保存更新
        [HttpPost]
        public JsonResult Update(db.sbs_Empl model)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                if (ModelState.IsValid)
                {
                    db.bll.sbs_Empl.update(model, dc);
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
                string keyCode = db.bll.sbs_Empl.getCodeByRowID(rowID,dc);
                db.bll.sbs_Empl.delete(keyCode,dc);
                result.data = rui.jsonResult.getAJAXResult("删除成功", true);
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex);
                result.data = rui.jsonResult.getAJAXResult(rui.excptHelper.getExMsg(ex), false);
            }
            return Json(result.data);
        }

        //设置为系统账号 - 允许登录
        public JsonResult setLogin(string keyFieldValues)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                if (keyFieldValues.Length > 0)
                {
                    string msg = db.bll.sbs_Empl.setLogin(keyFieldValues, dc);
                    result.data = rui.jsonResult.getAJAXResult(msg, true);
                }
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex);
                result.data = rui.jsonResult.getAJAXResult(rui.excptHelper.getExMsg(ex), false);
            }
            return Json(result.data);
        }


        //获取展示的用户名称(单个)
        public JsonResult getShowName(string code)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                Dictionary<string, string> dic = new Dictionary<string, string>();
                dic.Add("showName", db.bll.sbs_Empl.getNameByCode(code,dc));
                result.data = rui.jsonResult.getAJAXResult("获取成功", true, dic);
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex);
                result.data = rui.jsonResult.getAJAXResult(rui.excptHelper.getExMsg(ex), false);
            }
            return Json(result.data);
        }


        //设置为系统账号 - 允许登录
        public JsonResult Admin(string selected)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                if (selected.Length > 0)
                {
                    string msg = db.bll.sbs_Empl.setLogin(selected, dc);
                    result.data = rui.jsonResult.getAJAXResult(msg, true);
                }
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
