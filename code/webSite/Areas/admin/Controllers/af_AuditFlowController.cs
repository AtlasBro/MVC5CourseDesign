using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using web.Controllers;

namespace web.Areas.admin.Controllers
{
    public class af_AuditFlowController : baseController
    {
        //搜索数据
        public ActionResult Select(db.view.af_AuditFlow model)
        {
            model.Search();
            if (rui.requestHelper.isAjax())
                return PartialView("_showData", model);
            return View(model);
        }

        //展示详情
        public ActionResult Detail(string rowID)
        {
            db.af_AuditFlow model = db.bll.af_AuditFlow.getEntryByRowID(rowID, dc);
            model.auditTypeCode = db.bll.af_AuditType.getNameByCode(model.auditTypeCode, dc);
            model.orgCode = db.bll.sbs_Org.getNameByCode(model.orgCode, dc);
            return View(model);
        }

        //展示新增
        [HttpGet]
        public ActionResult Insert()
        {
            db.af_AuditFlow model = new db.af_AuditFlow();
            return View(model);
        }

        //保存新增
        [HttpPost]
        public JsonResult Insert(db.af_AuditFlow model)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                if (ModelState.IsValid)
                {  
                    string rowID = db.bll.af_AuditFlow.insert(model, dc);
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
            db.af_AuditFlow model = db.bll.af_AuditFlow.getEntryByRowID(rowID, dc);
            return View(model);
        }

        //保存更新
        [HttpPost]
        public JsonResult Update(db.af_AuditFlow model)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                if (ModelState.IsValid)
                {
                    db.bll.af_AuditFlow.update(model, dc);
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
                string keyCode = db.bll.af_AuditFlow.getKeyByRowID(rowID,dc);
                db.bll.af_AuditFlow.delete(keyCode, dc);
                result.data = rui.jsonResult.getAJAXResult("删除成功", true);
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex);
                result.data = rui.jsonResult.getAJAXResult(rui.excptHelper.getExMsg(ex), false);
            }
            return Json(result.data);
        }

        //启用
        public JsonResult Enable(string keyFieldValues)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                string msg= db.bll.af_AuditFlow.toUse(keyFieldValues,dc);
                result.data = rui.jsonResult.getAJAXResult(msg, true);
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex);
                result.data = rui.jsonResult.getAJAXResult(rui.excptHelper.getExMsg(ex), false);
            }
            return Json(result.data);
        }

        //禁用
        public JsonResult Disable(string keyFieldValues)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                 string msg = db.bll.af_AuditFlow.toNoUse(keyFieldValues,dc);
                 result.data = rui.jsonResult.getAJAXResult(msg, true);
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex);
                result.data = rui.jsonResult.getAJAXResult(rui.excptHelper.getExMsg(ex), false);
            }
            return Json(result.data);
        }

        //审批流设计 - 以前有，则打开编辑，没有则新增
        [HttpGet]
        public ActionResult Design(string rowID)
        {
            db.view.af_AuditFlowDesign model = new db.view.af_AuditFlowDesign();
            model.rowID = rowID.ToString();
            model.opMode = db.bll.af_AuditFlow.hasNode(rowID,dc) ? "update" : "insert";
            if(model.opMode == "update")
            {
                Dictionary<string, string> dic = db.bll.af_AuditFlow.getWFJson(rowID, dc);
                model.begin = dic["begin"];
                model.end = dic["end"];
                model.actives = dic["actives"];
                model.routes = dic["routes"];
            }
            return View(model);
        }

        //选中节点（展示节点编辑分部视图）
        [HttpGet]
        public ActionResult SelectNode(string nodeID)
        {
            db.af_AuditNode model = db.bll.af_AuditNode.getEntryByCode(nodeID, dc);
            return PartialView("SelectNode", model);
        }

        //保存选中节点
        [HttpPost]
        public JsonResult SelectNode(db.af_AuditNode model)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                db.bll.af_AuditNode.update(model, dc);
                result.data = rui.jsonResult.getAJAXResult("成功", true);
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex);
                result.data = rui.jsonResult.getAJAXResult(rui.excptHelper.getExMsg(ex), false);
            }
            return Json(result.data);
        }

        //选中路由（展示路由编辑分部视图）
        [HttpGet]
        public ActionResult SelectRoute(string nodeID)
        {
            db.af_NodeRelation model = db.bll.af_NodeRelation.getEntryByCode(nodeID, dc);
            return PartialView("SelectRoute", model);
        }

        //保存选中路由
        [HttpPost]
        public JsonResult SelectRoute(db.af_NodeRelation model)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                db.bll.af_NodeRelation.update(model, dc);
                result.data = rui.jsonResult.getAJAXResult("成功", true);
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex);
                result.data = rui.jsonResult.getAJAXResult(rui.excptHelper.getExMsg(ex), false);
            }
            return Json(result.data);
        }

        //创建开始和结束节点
        public JsonResult createStartAndEnd(string rowID,string startID,string endID)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                db.bll.af_AuditNode.createStartAndEnd(rowID, startID, endID, dc);
                result.data = rui.jsonResult.getAJAXResult("no:成功", true);
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex);
                result.data = rui.jsonResult.getAJAXResult(rui.excptHelper.getExMsg(ex), false);
            }
            return Json(result.data);
        }

        //创建活动节点（节点编号）
        public JsonResult createNode(string rowID,string guidID)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                db.bll.af_AuditNode.createNode(rowID, guidID,dc);
                result.data = rui.jsonResult.getAJAXResult("no:成功", true);
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex);
                result.data = rui.jsonResult.getAJAXResult(rui.excptHelper.getExMsg(ex), false);
            }
            return Json(result.data);
        }

        //创建路由（路由编号，开始，结束）
        public JsonResult createRoute(string rowID, string guidID, string startID, string endID)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                db.bll.af_AuditNode.createRoute(rowID, guidID, startID, endID, dc);
                result.data = rui.jsonResult.getAJAXResult("no:成功", true);
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex);
                result.data = rui.jsonResult.getAJAXResult(rui.excptHelper.getExMsg(ex), false);
            }
            return Json(result.data);
        }

        //移除元素（元素编号，类型）
        public JsonResult dropElement(string rowID,string guidID,string type)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                db.bll.af_AuditNode.dropElement(rowID, guidID, type, dc);
                result.data = rui.jsonResult.getAJAXResult("no:成功", true);
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex);
                result.data = rui.jsonResult.getAJAXResult(rui.excptHelper.getExMsg(ex), false);
            }
            return Json(result.data);
        }

        //审批流结果保存
        [HttpPost]
        public JsonResult saveJson(string rowID, string startJson, string activeJsons, string routeJsons, string endJson)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                db.bll.af_AuditNode.saveJson(rowID, startJson, activeJsons, routeJsons, endJson, dc);
                result.data = rui.jsonResult.getAJAXResult("no:成功", true);
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex);
                result.data = rui.jsonResult.getAJAXResult(rui.excptHelper.getExMsg(ex), false);
            }
            return Json(result.data);
        }

        #region 选择审批的用户，选择完毕之后，直接返回选择用户的信息
        /// <param name="value">已选择的项目,格式a,b,c</param>
        /// <returns></returns>
        public ActionResult LinkUsers(string value)
        {
            return View();
        }

        //查询已选择项目(分部Action)
        public ActionResult SelectLinkUsers(db.view.af_AuditFlowUser model)
        {
            model.searchType = "link";
            model.Search();
            return PartialView("_ShowDataLink", model);
        }

        //查询未选择项目(分部Action)
        public ActionResult SelectNoLinkUsers(db.view.af_AuditFlowUser model)
        {
            model.searchType = "nolink";
            model.Search();
            return PartialView("_ShowDataLink", model);
        }
        #endregion


        #region 审批流关联部门
        [HttpGet]
        public ActionResult LinkDepts(string rowID)
        {
            return View();
        }

        //查询已关联预算项目(分部Action)
        public ActionResult SelectLinkDepts(db.view.af_AuditFlowDept model)
        {
            model.type = "link";
            model.Search();
            return PartialView("_ShowDataLink", model);
        }

        //查询未关联预算项目(分部Action)
        public ActionResult SelectNoLinkDepts(db.view.af_AuditFlowDept model)
        {
            model.type = "nolink";
            model.Search();
            return PartialView("_ShowDataLink", model);
        }

        //删除已关联的预算项目 value格式为1,2,3
        /// <summary>
        /// 
        /// </summary>
        /// <param name="rowID">角色rowID</param>
        /// <param name="selected">选中预算项目的Code</param>
        /// <returns></returns>
        [HttpPost]
        public JsonResult deleteLinkDepts(string rowID, string keyFieldValues)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                db.bll.af_AuditFlow.deleteDept(rowID, keyFieldValues,dc);
                result.data = rui.jsonResult.getAJAXResult("操作成功", true);
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex);
                result.data = rui.jsonResult.getAJAXResult(rui.excptHelper.getExMsg(ex), false);
            }
            return Json(result.data);
        }

        //添加未关联的预算项目 value格式为1,2,3
        /// <summary>
        /// 
        /// </summary>
        /// <param name="rowID">角色rowID</param>
        /// <param name="selected">选中预算项目的Code</param>
        /// <returns></returns>
        [HttpPost]
        public JsonResult addNoLinkDepts(string rowID, string keyFieldValues)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                db.bll.af_AuditFlow.addDept(rowID, keyFieldValues, dc);
                result.data = rui.jsonResult.getAJAXResult("操作成功", true);
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex);
                result.data = rui.jsonResult.getAJAXResult(rui.excptHelper.getExMsg(ex), false);
            }
            return Json(result.data);
        } 
        #endregion
        
    }
}
