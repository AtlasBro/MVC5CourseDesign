using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using web.Controllers;

namespace web.Areas.admin.Controllers
{
    public class sbs_DeptController : baseController
    {
        //列表主界面
        public ActionResult Select(db.view.sbs_Dept model)
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
            db.sbs_Dept model = db.bll.sbs_Dept.getEntryByRowID(rowID, dc);
            model.upDeptCode = db.bll.sbs_Dept.getNameByCode(model.upDeptCode, dc);
            model.orgCode = db.bll.sbs_Org.getNameByCode(model.orgCode, dc);
            return View(model);
        }

        //展示新增
        [HttpGet]
        public ActionResult Insert()
        {
            db.sbs_Dept model = new db.sbs_Dept();
            return View(model);
        }

        //保存新增
        [HttpPost]
        public JsonResult Insert(db.sbs_Dept model)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                if (ModelState.IsValid)
                {
                    string rowID = db.bll.sbs_Dept.insert(model, dc);
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
            db.sbs_Dept model = db.bll.sbs_Dept.getEntryByRowID(rowID, dc);
            return View(model);
        }

        //保存更新
        [HttpPost]
        public JsonResult Update(db.sbs_Dept model)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                if (ModelState.IsValid)
                {
                    db.bll.sbs_Dept.update(model, dc);
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
                string keyCode = db.bll.sbs_Dept.getCodeByRowID(rowID,dc);
                db.bll.sbs_Dept.delete(keyCode,dc);
                result.data = rui.jsonResult.getAJAXResult("删除成功", true);
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
                if (ModelState.IsValid)
                {
                    Dictionary<string, string> dic = new Dictionary<string, string>();
                    dic.Add("showName", db.bll.sbs_Dept.getNameByCode(code,dc));
                    result.data = rui.jsonResult.getAJAXResult("获取成功", true, dic);
                }
                else
                {
                    result.data = rui.jsonResult.getAJAXResult("获取失败", false);
                }
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex);
                result.data = rui.jsonResult.getAJAXResult(rui.excptHelper.getExMsg(ex), false);
            }
            return Json(result.data);
        }

        //通过组织获取部门列表 json
        public JsonResult getDdlJsonByOrgCode(string upCode)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                if (ModelState.IsValid)
                {
                    Dictionary<string, string> dic = new Dictionary<string, string>();
                    dic.Add("subList", db.bll.sbs_Dept.getDdlJsonByOrgCode(upCode,dc));
                    result.data = rui.jsonResult.getAJAXResult("获取部门成功", true, dic);
                }
                else
                {
                    result.data = rui.jsonResult.getAJAXResult("获取部门失败", false);
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
