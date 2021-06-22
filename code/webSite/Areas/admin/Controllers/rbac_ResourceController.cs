using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using web.Controllers;

namespace web.Areas.admin.Controllers
{
    /// <summary>
    /// 资源维护
    /// </summary>
    public class rbac_ResourceController : baseController
    {
        //搜索数据
        public ActionResult Select(db.view.rbac_Resource model)
        {
            model.Search();
            if (rui.requestHelper.isAjax())
                return PartialView("_showData", model);
            return View(model);
        }

        //Excel导出
        public ActionResult SelectExport(db.view.rbac_Resource model)
        {
            try
            {
                //all代表要导出查询的所有数据,page代表导出本页的数据
                //当设定ExportType属性后
                //调用Search方式时才会执行ExportToXls内部的代码来生成要导出的文件。
                model.ExportRange = rui.dataRange.all.ToString();
                model.SheetName = "资源列表";
                model.Search();
                return File(model.ExportToXls(), rui.innerCode.mime(".xlsx"), "资源列表.xlsx");
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex);
                Response.Write(string.Format("<script>alert('{0}');history.go(-1);</script>", ex.Message));
            }
            return null;
        }

        //展示详情
        public ActionResult Detail(string rowID)
        {
            db.rbac_Resource model = db.bll.rbac_Resource.getEntryByRowID(rowID, dc);
            model.moduleCode = db.bll.rbac_Module.getNameByCode(model.moduleCode, dc);
            return View(model);
        }
        
        //展示新增
        [HttpGet]
        public ActionResult Insert(string moduleCode)
        {
            db.rbac_Resource model = new db.rbac_Resource();
            model.moduleCode = moduleCode;
            model.operationCodeDdlList = db.bll.rbac_Operation.bindDdl();
            return View(model);
        }
        
        //保存新增
        [HttpPost]
        [ValidateInput(false)]
        [checkPriv("rbac_Resource", "Insert")]
        public JsonResult Insert(db.rbac_Resource model)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                if (ModelState.IsValid)
                {
                    model.haveOperations = rui.requestHelper.getValue("haveOperations") + ",";
                    string rowID = db.bll.rbac_Resource.insert(model, dc);
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
            db.rbac_Resource model = db.bll.rbac_Resource.getEntryByRowID(rowID, dc);
            model.operationCodeDdlList = db.bll.rbac_Operation.bindDdl();
            rui.listHelper.setListSelected(model.operationCodeDdlList, model.haveOperations);
            return View(model);
        }

        //保存更新
        [HttpPost]
        [ValidateInput(false)]
        [checkPriv("rbac_Resource", "Update")]
        public JsonResult Update(db.rbac_Resource model)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                if (ModelState.IsValid)
                {
                    model.haveOperations = db.bll.rbac_ResourceOp.batchSave(dc);
                    db.bll.rbac_Resource.update(model, dc);
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
        [checkPriv("rbac_Resource", "Delete")]
        public JsonResult Delete(string rowID)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                string keyCode = db.bll.rbac_Resource.getCodeByRowID(rowID,dc);
                db.bll.rbac_Resource.delete(keyCode,dc);
                result.data = rui.jsonResult.getAJAXResult("删除成功", true);
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex);
                result.data = rui.jsonResult.getAJAXResult(rui.excptHelper.getExMsg(ex), false);
            }
            return Json(result.data);
        }

        //批量保存排序号
        public JsonResult batchSave()
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                Dictionary<string, List<string>> dic = new Dictionary<string, List<string>>();
                dic.Add("resourceCode", rui.requestHelper.getList("resourceCodeList"));
                dic.Add("showOrder", rui.requestHelper.getList("showOrderList"));
                dic.Add("pageWidth", rui.requestHelper.getList("pageWidthList"));
                dic.Add("pagerCount", rui.requestHelper.getList("pagerCountList"));
                List<db.rbac_Resource> entryList = db.efHelper.getEntryList<db.rbac_Resource>(dc, dic);

                string msg = db.bll.rbac_Resource.batchSave(entryList, dc);
                result.data = rui.jsonResult.getAJAXResult(msg, true);
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex);
                result.data = rui.jsonResult.getAJAXResult(rui.excptHelper.getExMsg(ex), false);
            }
            return Json(result.data);
        }

        //批量显示
        [HttpPost]
        public JsonResult batchShow(string keyFieldValues)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                string msg = db.bll.rbac_Resource.batchShow(keyFieldValues,dc);
                result.data = rui.jsonResult.getAJAXResult(msg, true);
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex);
                result.data = rui.jsonResult.getAJAXResult(ex.Message, false);
            }
            return Json(result.data);
        }

        //批量隐藏
        [HttpPost]
        public JsonResult batchNoShow(string keyFieldValues)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                string msg = db.bll.rbac_Resource.batchNoShow(keyFieldValues,dc);
                result.data = rui.jsonResult.getAJAXResult(msg, true);
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex);
                result.data = rui.jsonResult.getAJAXResult(ex.Message, false);
            }
            return Json(result.data);
        }

        //批量+1
        public JsonResult batchAdd(string keyFieldValues)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                string msg = db.bll.rbac_Resource.batchAdd(keyFieldValues,dc);
                result.data = rui.jsonResult.getAJAXResult(msg, true);
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex);
                result.data = rui.jsonResult.getAJAXResult(ex.Message, false);
            }
            return Json(result.data);
        }

        //批量-1
        public JsonResult batchSub(string keyFieldValues)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                string msg = db.bll.rbac_Resource.batchSub(keyFieldValues,dc);
                result.data = rui.jsonResult.getAJAXResult(msg, true);
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex);
                result.data = rui.jsonResult.getAJAXResult(ex.Message, false);
            }
            return Json(result.data);
        }

        //批量变更模块
        public JsonResult batchChangeModule(string keyFieldValues, string moduleCode)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                string msg = db.bll.rbac_Resource.BatchChangeModule(keyFieldValues, moduleCode, dc);
                result.data = rui.jsonResult.getAJAXResult(msg, true);
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
