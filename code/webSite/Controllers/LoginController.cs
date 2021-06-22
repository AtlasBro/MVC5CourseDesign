using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Remoting.Messaging;
using System.Web;
using System.Web.Mvc;
using System.Xml.Linq;
using web.Areas.admin.Controllers;

namespace web.Controllers
{
    public class LoginController : baseController
    {
        //跳转到登录页
        public ActionResult toLoginAdmin()
        {
            return View();
        }

        //管理员登陆界面
        [HttpGet]
        public ActionResult loginAdmin()
        {
            string path = Server.MapPath("/Content/login/showImg/setting.xml");
            var doc = XDocument.Load(path);
            var result = from item in doc.Descendants("pic")
                         select new
                         {
                             picUrl = item.Attribute("imgUrl").Value,
                             picTitle = item.Attribute("title").Value
                         };
            Dictionary<string, string> dic = new Dictionary<string, string>();
            foreach (var item in result)
                dic.Add(item.picUrl, item.picTitle);
            ViewBag.img = dic;
            return View();
        }

        [HttpPost]
        public JsonResult loginAdmin(string tbxUserName, string tbxPassword, string orgCode)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                //登陆逻辑，成功后进行页面跳转
                db.bll.loginAdminHelper.login(tbxUserName, tbxPassword, orgCode, dc);
                db.bll.sys_WebLog.logLogin();
                result.data = rui.jsonResult.getAJAXResult("登录成功", true);
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex);
                result.data = rui.jsonResult.getAJAXResult(rui.excptHelper.getExMsg(ex), false);
            }
            return Json(result.data);
        }

        //获取账户能够登录的组织
        [HttpPost]
        public JsonResult getLoginOrg(string userCode)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                Dictionary<string, string> dic = new Dictionary<string, string>();
                dic.Add("orgList", db.bll.rbac_UserOrg.getOrgDdlJsonByUserCode(userCode, dc));
                result.data = rui.jsonResult.getAJAXResult("no:获取成功", true, dic);
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex);
                result.data = rui.jsonResult.getAJAXResult(rui.excptHelper.getExMsg(ex), false);
            }
            return Json(result.data);
        }

        //错误页显示
        public ActionResult errorShow()
        {
            return View();
        }

        //授权信息
        public ContentResult Priv()
        {
            string value = rui.encryptHelper.getPrivInfo();
            return Content(value);
        }
    }
}
