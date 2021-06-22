using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using web.Controllers;

namespace web.Areas.admin.Controllers
{
    /// <summary>
    /// 后台框架页面
    /// </summary>
    public class sys_HomeController : baseController
    {
        //后台页面主框架
        public ActionResult Index()
        {
            db.view.adminIndex model = new db.view.adminIndex();
            model.moduleDt = db.bll.privRbacHelper.getUserPrivModule(db.bll.loginAdminHelper.getUserCode(), db.bll.loginAdminHelper.getOrgCode(), dc, true);
            model.resourceDt = db.bll.privRbacHelper.getUserPrivResource(db.bll.loginAdminHelper.getUserCode(), db.bll.loginAdminHelper.getOrgCode(), dc, true);
            model.loginUserName = db.bll.rbac_User.getNameByCode(db.bll.loginAdminHelper.getUserCode(),dc);
            model.loginUserCode = db.bll.loginAdminHelper.getUserCode();
            model.loginDeptName = db.bll.sbs_Dept.getNameByCode(db.bll.loginAdminHelper.getDeptCode(false),dc);
            return View(model);
        }

        //后台用户桌面
        public ActionResult Desktop()
        {
            return View();
        }

        //更改密码
        [HttpGet]
        public ActionResult ChangePW()
        {
            return View();
        }

        //密码保存
        [HttpPost]
        public JsonResult ChangePW(string oldPw,string newPW1,string newPW2)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                if (ModelState.IsValid)
                {
                    if (oldPw == "" || newPW1 == "" || newPW2 == "")
                    {
                        rui.excptHelper.throwEx("输入数据不合法");
                    }
                    if (newPW1 != newPW2)
                        rui.excptHelper.throwEx("新密码不相同");

                    if(db.bll.rbac_User.changePW(oldPw, newPW1,dc))
                        result.data = rui.jsonResult.getAJAXResult("修改成功", true);
                    else
                        result.data = rui.jsonResult.getAJAXResult("原始密码不正确", true);
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

        //退出
        public ActionResult Exit()
        {
            Session.Clear();
            Session.Abandon();
            return new RedirectResult("/Login/toLoginAdmin");
        }

    }
}
