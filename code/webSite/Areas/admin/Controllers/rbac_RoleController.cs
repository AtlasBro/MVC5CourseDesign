using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using web.Controllers;

namespace web.Areas.admin.Controllers
{
    /// <summary>
    /// 角色维护
    /// </summary>
    public class rbac_RoleController : baseController
    {
        public ActionResult Select(db.view.rbac_Role model)
        {
            model.Search();
            if (rui.requestHelper.isAjax())
                return PartialView("_showData", model);
            return View(model);
        }

        //展示详情
        public ActionResult Detail(string rowID)
        {
            db.rbac_Role model = db.bll.rbac_Role.getEntryByRowID(rowID, dc);
            return View(model);
        }

        //展示新增
        [HttpGet]
        public ActionResult Insert()
        {
            db.rbac_Role model = new db.rbac_Role();
            return View(model);
        }

        //保存新增
        [HttpPost]
        public JsonResult Insert(db.rbac_Role model)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                if (ModelState.IsValid)
                {
                    string rowID = db.bll.rbac_Role.insert(model, dc);
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
            db.rbac_Role model = db.bll.rbac_Role.getEntryByRowID(rowID, dc);
            return View(model);
        }

        //保存更新
        [HttpPost]
        public JsonResult Update(db.rbac_Role model)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                if (ModelState.IsValid)
                {
                    db.bll.rbac_Role.update(model, dc);
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
                string keyCode = db.bll.rbac_Role.getCodeByRowID(rowID,dc);
                db.bll.rbac_Role.delete(keyCode,dc);
                result.data = rui.jsonResult.getAJAXResult("删除成功", true);
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex);
                result.data = rui.jsonResult.getAJAXResult(rui.excptHelper.getExMsg(ex), false);
            }
            return Json(result.data);
        }

        //授权
        /// <summary>
        /// 获取可授权模块列表和搜索模块下拥有的资源列表
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public ActionResult Priv(db.view.rbac_RolePriv model)
        {
            //获取登录用户可授权的模块
            model.moduleList = db.bll.loginAdminHelper.getPrivModule();

            //默认选中第一个模块
            if (string.IsNullOrEmpty(model.moduleCode))
                model.moduleCode = model.moduleList[0].Value;

            model.Search();
            if (rui.requestHelper.isAjax())
                return PartialView("_showDataPriv", model);
            return View(model);
        }

        //授权保存
        /// <summary>
        /// 首选获取本页所有资源编号
        /// 再通过资源编号获取每个资源所授予的操作权限和数据权限
        /// 将获取结果传递后业务层进行处理
        /// </summary>
        /// <param name="rowID"></param>
        /// <returns></returns>
        [HttpPost]
        public JsonResult Priv(string rowID)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                if (ModelState.IsValid)
                {
                    //获取当前页的资源和每个资源勾选的权限列表
                    Dictionary<string, string> dicOP = new Dictionary<string, string>();
                    Dictionary<string, string> dicData = new Dictionary<string, string>();
                    List<string> list = rui.requestHelper.getList("resourceCodeList");
                    foreach (string keyCode in list)
                    {
                        //获取授权的操作
                        {
                            string value = rui.requestHelper.getMulValue(keyCode + "_cbx");
                            dicOP.Add(keyCode, rui.typeHelper.toString(value));
                        }
                        //获取授权的数据权限(下拉框）
                        {
                            string value = rui.requestHelper.getValue(keyCode + "_ddl");
                            string dataPriv = rui.requestHelper.getValue(keyCode + "_dataPriv");
                            string haveDataPriv = rui.requestHelper.getValue(keyCode + "_haveDataPriv");
                            //当授权的数据权限大于被授权的数据权限时，允许更改客户的数据权限，否则不给修改
                            if (db.bll.privRbacHelper.compareDataPriv(dataPriv, haveDataPriv))
                                dicData.Add(keyCode, value);
                            else
                                dicData.Add(keyCode, haveDataPriv);
                        }
                    }
                    //保存所授权限
                    db.bll.rbac_RolePriv.savePriv(rowID, db.bll.loginAdminHelper.getOrgCode(), dicOP, dicData, dc);
                    result.data = rui.jsonResult.getAJAXResult("保存成功", true);
                }
                else
                {
                    result.data = rui.jsonResult.getAJAXResult("保存失败", false);
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
