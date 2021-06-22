using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using web.Controllers;

namespace web.Areas.admin.Controllers
{
    public class rbac_RoleUserController : baseController
    {
        //展示关联用户 - 获取该用户已关联用户
        [HttpGet]
        public ActionResult LinkUsers(string rowID)
        {
            ViewData["rowID"] = rowID;
            return View();
        }

        //查询已关联用户(分部Action)
        public ActionResult SelectLinkUsers(db.view.rbac_RoleUser model)
        {
            model.type = "link";
            model.Search();
            return PartialView("_ShowDataLink", model);
        }

        /// <summary>
        /// 删除已关联的用户 value格式为1,2,3
        /// </summary>
        /// <param name="rowID">角色rowID</param>
        /// <param name="selected">选中用户的Code</param>
        /// <returns></returns>
        [HttpPost]
        public JsonResult deleteLinkUsers(string rowID, string keyFieldValues)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                db.bll.rbac_RoleUser.deleteUsers(rowID, keyFieldValues, dc);
                result.data = rui.jsonResult.getAJAXResult("删除成功", true);
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex);
                result.data = rui.jsonResult.getAJAXResult(rui.excptHelper.getExMsg(ex), false);
            }
            return Json(result.data);
        }

        //查询未关联用户(分部Action)
        public ActionResult SelectNoLinkUsers(db.view.rbac_RoleUser model)
        {
            model.type = "nolink";
            model.Search();
            return PartialView("_ShowDataLink", model);
        }

        /// <summary>
        /// 添加未关联的用户 value格式为1,2,3
        /// </summary>
        /// <param name="rowID">角色rowID</param>
        /// <param name="selected">选中用户的Code</param>
        /// <returns></returns>
        [HttpPost]
        public JsonResult addNoLinkUsers(string rowID, string keyFieldValues)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                db.bll.rbac_RoleUser.addUsers(rowID, keyFieldValues, dc);
                result.data = rui.jsonResult.getAJAXResult("添加成功", true);
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