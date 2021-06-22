using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace web.Areas.admin.Controllers.comm
{
    /// <summary>
    /// Excel导入和导出
    /// </summary>
    public class sys_ExlImportController : Controller
    {
        //展示导入界面
        [HttpGet]
        public ActionResult Import(string tableName)
        {
            ViewBag.TableName = tableName;
            return View();
        }

        //文件上传并读取到DataTable中
        [HttpPost]
        public JsonResult ImportUpload(string tableName)
        {
            try
            {
                string pathForSaving = "/upload/excelImport/" + tableName;
                rui.diskHelper.createDirectory(rui.webDiskHelper.getAbsolutePath(pathForSaving));
                List<string> pathList = rui.webDiskHelper.saveUploadFiles(pathForSaving, "Upload");
                if (pathList.Count > 0)
                {
                    DataTable table = rui.excelHelper.excelToDataTable(rui.webDiskHelper.getAbsolutePath(pathList[0]));
                    rui.sessionHelper.saveValue("importTable", table);
                    return Json(rui.jsonResult.getAJAXResult("上传成功", true), "text/html", JsonRequestBehavior.AllowGet);
                }
                else
                {
                    return Json(rui.jsonResult.getAJAXResult("上传失败", false), "text/html", JsonRequestBehavior.AllowGet);
                }
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex);
                return Json(rui.jsonResult.getAJAXResult(ex.Message, false), "text/html", JsonRequestBehavior.AllowGet);
            }
        }

        //导入保存
        [HttpPost]
        public JsonResult SaveData(string tableName)
        {
            rui.jsonResult result = new rui.jsonResult();
            try
            {
                
                //根据表名调用不用的数据保存方法
                db.bll.sys_ExlImport.importData(tableName);

                result.data = rui.jsonResult.getAJAXResult("数据保存成功！", true);
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex);
                result.data = rui.jsonResult.getAJAXResult(rui.excptHelper.getExMsg(ex), false);
            }
            return Json(result.data);
        }

        //展示导入数据
        public ActionResult disPlayImport()
        {
            return PartialView("disPlayImport");
        }
    }
}
