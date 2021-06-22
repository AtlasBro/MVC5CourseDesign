using System;
using System.Collections.Generic;
using System.Web.Mvc;
using System.Linq;
using System.Data;
using System.Web;
using web.Controllers;

namespace web.Areas.admin.Controllers
{
    /// <summary>
    /// 用户维护
    /// </summary>
    public class rbac_UserController : baseController
    {
        //搜索数据
        public ActionResult Select(db.view.rbac_User model)
        {
            model.Search();
            if (rui.requestHelper.isAjax())
                return PartialView("_showData", model);
            return View(model);
        }

        //展示详情
        public ActionResult Detail(string rowID)
        {
            db.rbac_User model = db.bll.rbac_User.getEntryByRowID(rowID, dc);
            model.relatedCode = string.Format("{0}({1})", db.bll.rbac_User.getNameByCode(model.relatedCode,dc), model.relatedCode);
            return View(model);
        }

        //展示新增
        [HttpGet]
        public ActionResult Insert()
        {
            db.rbac_User model = new db.rbac_User();
            return View(model);
        }

        //保存新增
        [HttpPost]
        public JsonResult Insert(db.rbac_User model)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                if (ModelState.IsValid)
                {
                    string orgCode = db.bll.loginAdminHelper.getOrgCode();
                    string rowID = db.bll.rbac_User.createRelatedUser(model.userCode, model.userName, orgCode, model.deptCode, dc);
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
            db.rbac_User model = db.bll.rbac_User.getEntryByRowID(rowID, dc);
            return View(model);
        }

        //保存更新
        [HttpPost]
        public JsonResult Update(db.rbac_User model)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                if (ModelState.IsValid)
                {
                    db.bll.rbac_User.update(model, dc);
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
                string keyCode = db.bll.rbac_User.getCodeByRowID(rowID,dc);
                db.bll.rbac_User.delete(keyCode,dc);
                result.data = rui.jsonResult.getAJAXResult("删除成功", true);
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex);
                result.data = rui.jsonResult.getAJAXResult(rui.excptHelper.getExMsg(ex), false);
            }
            return Json(result.data);
        }

        //重置密码
        public JsonResult ResetPW(string userCode)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                db.bll.rbac_User.resetPW(userCode,dc);
                result.data = rui.jsonResult.getAJAXResult("重置成功", true);
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex);
                result.data = rui.jsonResult.getAJAXResult(rui.excptHelper.getExMsg(ex), false);
            }
            return Json(result.data);
        }

        //允许登录
        public JsonResult AllowLogin(string keyFieldValues)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                 string msg= db.bll.rbac_User.allowLogin(keyFieldValues,dc);
                 result.data = rui.jsonResult.getAJAXResult(msg, true);
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex);
                result.data = rui.jsonResult.getAJAXResult(rui.excptHelper.getExMsg(ex), false);
            }
            return Json(result.data);
        }

        //取消登录
        public JsonResult CancelLogin(string keyFieldValues)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                 string msg = db.bll.rbac_User.noLogin(keyFieldValues,dc);
                 result.data = rui.jsonResult.getAJAXResult(msg, true);
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex);
                result.data = rui.jsonResult.getAJAXResult(rui.excptHelper.getExMsg(ex), false);
            }
            return Json(result.data);
        }

        //权限查看
        /// <summary>
        /// 展示某用户拥有的所有权限
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public ActionResult PrivShow(db.view.rbac_UserPriv model)
        {
            //获取登录用户可授权的模块
            model.moduleList = db.bll.loginAdminHelper.getPrivModule();

            List<SelectListItem> list = new List<SelectListItem>();

            //获取被授权用户拥有的模块
            {
                string userCode = db.bll.rbac_User.getCodeByRowID(model.rowID,dc);
                DataTable table = db.bll.privRbacHelper.getUserPrivModule(userCode, db.bll.loginAdminHelper.getOrgCode(), dc);
                foreach (var item in model.moduleList)
                {
                    DataRow[] rows = table.Select("moduleCode='" + item.Value + "'");
                    if (rows.Length != 0)
                    {
                        list.Add(item);
                    }
                        
                }
                model.moduleList = list;
            }

            //默认选中第一个模块
            if (string.IsNullOrEmpty(model.moduleCode) && model.moduleList.Count>0)
                model.moduleCode = model.moduleList[0].Value;

            model.isUser = true;
            model.Search();
            if (rui.requestHelper.isAjax())
                return PartialView("_showDataPriv", model);
            return View(model);
        }

        //授权
        /// <summary>
        /// 获取可授权模块列表和搜索模块下拥有的资源列表
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public ActionResult Priv(db.view.rbac_UserPriv model)
        {
            //获取登录用户可授权的模块
            model.moduleList = db.bll.loginAdminHelper.getPrivModule();

            //默认选中第一个模块
            if(string.IsNullOrEmpty(model.moduleCode))
                model.moduleCode = model.moduleList[0].Value;

            model.isUser = true;
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
                    db.bll.rbac_UserPriv.savePriv(rowID,db.bll.loginAdminHelper.getOrgCode(), dicOP, dicData, dc);
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

        //获取展示的用户名称(多个)
        [HttpPost]
        public JsonResult getShowNames(string userCodes)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                if (ModelState.IsValid)
                {
                    Dictionary<string, string> dic = new Dictionary<string, string>();
                    dic.Add("showName", db.bll.rbac_User.getNameAndCodeByCodes(userCodes,dc));
                    result.data = rui.jsonResult.getAJAXResult("保存成功", true, dic);
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

        //获取展示的用户名称(单个)
        public JsonResult getShowName(string code)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                if (ModelState.IsValid)
                {
                    Dictionary<string, string> dic = new Dictionary<string, string>();
                    dic.Add("showName", db.bll.rbac_User.getNameByCode(code,dc));
                    result.data = rui.jsonResult.getAJAXResult("保存成功", true, dic);
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

        //通过部门获取账户列表(当前组织内，可登录的部门人员)
        public JsonResult getUserListByDeptCode(string deptCode)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                if (ModelState.IsValid)
                {
                    Dictionary<string, string> dic = new Dictionary<string, string>();
                    dic.Add("userList", db.bll.rbac_User.getUserDdlJsonByDeptCode(deptCode,dc));
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
    }
}
