using db.lib;
using db.lib.auditBill;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using web.Controllers;

namespace web.Areas.admin.Controllers
{
    /// <summary>
    /// 审批中心
    /// </summary>
    public class af_AuditCenterController : baseController
    {
        private static object lockObj = new object();

        //展示审批单据
        public ActionResult Select(db.view.af_AuditCenter model)
        {
            model.isWait = false;
            model.Search();
            if (rui.requestHelper.isAjax())
                return PartialView("_showData", model);
            return View(model);
        }

        //展示某个人的待审单据
        public ActionResult waitAudit(db.view.af_AuditCenter model)
        {
            model.isWait = true;
            model.Search();
            if (rui.requestHelper.isAjax())
                return PartialView("_showData", model);
            return PartialView("waitAudit", model);
        }

        //单据送审操作
        /// <summary>
        /// 1）首选判断单据类型是否启用审批流
        ///     不启用直接送审，并返回成功
        /// 2）如果单据启用审批，获取启用的审批流数量
        ///     如果零个，则提示，否则返回成功
        ///     如果1个，则直接单据送审
        ///     如果多个,则返回数量，并显示审批流选择界面
        /// </summary>
        /// <param name="type">审批单据类型</param>
        /// <param name="relatedRowID">关联单据行号</param>
        /// <returns></returns>
        [HttpPost]
        public JsonResult doSendAudit(afType type, long relatedRowID)
        {
            rui.jsonResult result = new rui.jsonResult();
            using (var dbTran = dc.Database.BeginTransaction())
            {
                try
                {
                    Dictionary<string, string> dic = new Dictionary<string, string>();
                    bool isAudit = db.lib.auditHelper.auditTypeIsAudit(type,dc);
                    //判断单据类型是否启用审批
                    if (isAudit)
                    {
                        //获取跟单据关联的业务部门所用的审批流列表，多个提供选择
                        string orgCode = db.bll.loginAdminHelper.getOrgCode();
                        db.lib.auditBill.IBill bill = db.lib.auditHelper.getBillByType(type);
                        string deptCode = bill.getDeptCode(relatedRowID);
                        DataTable table = db.lib.auditHelper.getAuditFlowList(type, orgCode, deptCode,dc);
                        if (table.Rows.Count == 0)
                        {
                            dic.Add("message", "该单据类型启用了审批，可是单据类型下不存在启用的审批流");
                            dic.Add("result", false.ToString());
                        }
                        else
                        {
                            int count = table.Rows.Count;
                            dic.Add("count", count.ToString());
                            if (count == 1)
                            {
                                lock (lockObj)
                                {
                                    string message = "wait:";
                                    message += db.lib.auditHelper.sendAudit(table.Rows[0]["flowCode"].ToString(), type, relatedRowID, "", dc);
                                    message += "该单据类型只有一个审批流，已送审成功";
                                    dic.Add("message", message);
                                }
                            }
                            else
                            {
                                dic.Add("message", "该单据类型存在多个启用的审批流，请选择要送审的审批流");
                            }
                            dic.Add("result", true.ToString());
                        }
                    }
                    else
                    {
                        //送审后直接审批通过
                        db.lib.auditHelper.sendAudit("", type, relatedRowID, "", dc);
                        dic.Add("result", true.ToString());
                        dic.Add("count", "1");
                        dic.Add("message", "该单据类型未启用审批，送审单据已审批通过");
                    }
                    result.data = dic;

                    dbTran.Commit();
                }
                catch (Exception ex)
                {
                    dbTran.Rollback();
                    rui.logHelper.log(ex);
                    result.data = rui.jsonResult.getAJAXResult(rui.excptHelper.getExMsg(ex), false);
                }
            }
            return Json(result.data);
        }

        //多个审批流时，展示可送审的审批流
        /// <summary>
        /// （当有多个审批流的时候展示选择界面）
        /// </summary>
        /// <param name="rowID">关联单据的行号</param>
        /// <returns></returns>
        public ActionResult SelectAuditFlow(db.view.af_SelectAuditFlow model)
        {
            model.Search();
            if (rui.requestHelper.isAjax())
                return PartialView("_SelectShowData", model);
            return View(model);
        }

        //当多个审批流时，选择审批流之后调用此方法进行送审
        /// <summary>
        /// 送审方法
        /// </summary>
        /// <param name="flowCode">选用的审批流编码</param>
        /// <param name="type">审批单据类型</param>
        /// <param name="relatedRowID">关联的单据行号</param>
        /// <returns></returns>
        public JsonResult sendAudit(string flowCode, afType type, long relatedRowID)
        {
            rui.jsonResult result = new rui.jsonResult();
            using (var dbTran = dc.Database.BeginTransaction())
            {
                try
                {
                    lock (lockObj)
                    {
                        db.lib.auditHelper.sendAudit(flowCode, type, relatedRowID, "", dc);
                        result.data = rui.jsonResult.getAJAXResult("送审成功", true);
                    }
                    dbTran.Commit();
                }
                catch (Exception ex)
                {
                    dbTran.Rollback();
                    rui.logHelper.log(ex);
                    result.data = rui.jsonResult.getAJAXResult(rui.excptHelper.getExMsg(ex), false);
                }
            }
            return Json(result.data);
        }

        //单据审批通过后所调用的方法
        /// <summary>
        /// 
        /// </summary>
        /// <param name="logRowID">审批的日志行号</param>
        /// <param name="seletedUserCodes">选择的下一级参审人员</param>
        /// <returns></returns>
        public JsonResult auditPass(string logRowID, string auditRemark, string seletedUserCodes, string passDate)
        {
            rui.jsonResult result = new rui.jsonResult();
            using (var dbTran = dc.Database.BeginTransaction())
            {
                try
                {
                    lock (lockObj)
                    {
                        DateTime financeDataTime = DateTime.Now;
                        if (passDate != "")
                        {
                            DateTime passDateTemp = rui.typeHelper.toDateTime(passDate);
                            financeDataTime = new DateTime(passDateTemp.Year, passDateTemp.Month, passDateTemp.Day, DateTime.Now.Hour, DateTime.Now.Minute, DateTime.Now.Second);
                        }
                        db.lib.auditHelper.auditPass(logRowID, auditRemark, seletedUserCodes, financeDataTime, dc);
                        result.data = rui.jsonResult.getAJAXResult("审批通过成功", true);
                    }
                    dbTran.Commit();
                }
                catch (Exception ex)
                {
                    dbTran.Rollback();
                    rui.logHelper.log(ex);
                    result.data = rui.jsonResult.getAJAXResult(rui.excptHelper.getExMsg(ex), false);
                }
            }
            return Json(result.data);
        }

        //展示允许驳回的列表
        [HttpGet]
        public ActionResult auditReject(string logRowID)
        {
            DataTable table = db.bll.af_AuditLog.getRejectList(logRowID,dc);
            if (rui.requestHelper.isAjax())
                return PartialView("auditReject", table);
            return View(table);
        }

        //驳回操作所调用的Action
        /// <summary>
        /// 
        /// </summary>
        /// <param name="relatedRowID">关联单据行号</param>
        /// <param name="nodeCode">驳回的节点编号</param>
        /// <returns></returns>
        [HttpPost]
        public JsonResult auditReject(string logRowID, long relatedRowID, string nodeCode, string auditRemark)
        {
            rui.jsonResult result = new rui.jsonResult();
            using (var dbTran = dc.Database.BeginTransaction())
            {
                try
                {

                    lock (lockObj)
                    {
                        db.lib.auditHelper.auditReject(logRowID, relatedRowID, nodeCode, auditRemark, dc);
                        result.data = rui.jsonResult.getAJAXResult("审批驳回成功", true);
                    }
                    dbTran.Commit();

                }
                catch (Exception ex)
                {
                    dbTran.Rollback();
                    rui.logHelper.log(ex);
                    result.data = rui.jsonResult.getAJAXResult(rui.excptHelper.getExMsg(ex), false);
                }
            }
            return Json(result.data);
        }

        //显示审批日志
        public ActionResult AuditLog(db.view.af_AuditLog model)
        {
            model.Search();
            if (rui.requestHelper.isAjax())
                return PartialView("_LogShowData", model);
            return View(model);
        }
    }
}
