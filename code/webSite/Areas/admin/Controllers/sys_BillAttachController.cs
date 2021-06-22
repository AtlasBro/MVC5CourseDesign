using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using web.Controllers;

namespace web.Areas.admin.Controllers
{
    //单据附件的辅助类
    public class sys_BillAttachController : baseController
    {
        //展示单据的附件列表
        public ActionResult SelectPartial(db.view.sys_BillAttach model)
        {
            model.Search();
            if (rui.requestHelper.isAjax())
                return PartialView("_ShowData" + model.attachOpMode, model);
            return PartialView("SelectPartial", model);
        }

        //附件上传Upload
        /// <param name="resourceCode">资源标识</param>
        /// <param name="prjSysCode">项目系统编号</param>
        /// <param name="keyCode">单据编号</param>
        /// <param name="attachTypeCode">上传的附件类型</param>
        /// <returns></returns>
        public JsonResult fileUpload(string resourceCode, string keyCode)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                db.bll.sys_BillAttach.upload(resourceCode, keyCode, dc);
                result.data = rui.jsonResult.getAJAXResult("上传成功", true);
                return Json(result.data, "text/html", JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex);
                result.data = rui.jsonResult.getAJAXResult(ex.Message, true);
                return Json(result.data, "text/html", JsonRequestBehavior.AllowGet);
            }
            //return Json(result.data);
        }

        //附件下载
        public FileResult fileDownLoad(string rowID)
        {
            try
            {
                db.sys_BillAttach entry = dc.sys_BillAttach.SingleOrDefault(a => a.rowID == rowID);
                if (entry != null)
                {
                    string filePath = rui.webDiskHelper.getAbsolutePath(entry.attachUrl);
                    if (rui.diskHelper.isExist(filePath))
                    {
                        return File(filePath, entry.attachMIME, entry.attachName);
                    }
                    else
                        rui.excptHelper.throwEx("文件不存在");
                }
                else
                    rui.excptHelper.throwEx("文件不存在");
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex);
                Response.Write(string.Format("<script>alert('{0}');history.go(-1);</script>", ex.Message));
                rui.logHelper.log(ex);
            }
            return null;
        }

        //附件下载 - 通过文件路径下载
        public FileResult fileDown(string filePath)
        {
            try
            {
                filePath = rui.webDiskHelper.getAbsolutePath(filePath);
                if (rui.diskHelper.isExist(filePath))
                {
                    return File(filePath, db.bll.sys_BillAttach.getMIME(filePath), rui.diskHelper.getFileName(filePath));
                }
                else
                    rui.excptHelper.throwEx("文件不存在");
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex);
                Response.Write(string.Format("<script>alert('{0}');history.go(-1);</script>", ex.Message));
                rui.logHelper.log(ex);
            }
            return null;
        }

        //附件删除(同时删除文件)
        public JsonResult fileDelete(string rowID)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                db.bll.sys_BillAttach.delete(rowID, dc);
                result.data = rui.jsonResult.getAJAXResult("删除成功", true);
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex);
                result.data = rui.jsonResult.getAJAXResult(rui.excptHelper.getExMsg(ex), false);
            }
            return Json(result.data);
        }


        //附件保存
        /// <summary>
        /// 保存附件备注
        /// </summary>
        /// <returns></returns>
        public JsonResult saveUpload()
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                db.bll.sys_BillAttach.batchSave(dc);
                result.data = rui.jsonResult.getAJAXResult("保存成功", true);
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
