using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace rui
{
    /// <summary>
    /// 文件上传辅助方法
    /// </summary>
    public class webDiskHelper
    {

        /// <summary>
        /// 获取网站部署的绝对路径
        /// </summary>
        /// <returns></returns>

        public static string getWebPath()
        {
            string path = HttpContext.Current.Server.MapPath($"~/");
            return path;
        }

        /// <summary>
        /// 获取物理路径
        /// </summary>
        /// <param name="webInnerPath">站内路径(前后需要携带/): 例如 "/download/"</param>
        /// <param name="fileName">如果路径内没有文件名，则提供文件名</param>
        /// <returns>物理路径</returns>
        public static string getAbsolutePath(string webInnerPath, string fileName = "")
        {
            string path = HttpContext.Current.Server.MapPath($"~{webInnerPath}") + fileName;
            return path;
        }

        /// <summary>
        /// 路径合并返回站内相对路径
        /// </summary>
        /// <param name="webInnerPath">站内路径(前后需要携带/): 例如 "/download/"</param>
        /// <param name="fileName">如果路径内没有文件名，则提供文件名</param>
        /// <returns></returns>
        public static string getInnerPath(string webInnerPath, string fileName = "")
        {
            return webInnerPath + fileName;
        }

        /// <summary>
        /// 保存上传文件
        /// </summary>
        /// <param name="webInnerPath">上传文件所保存的位置 - 站内跟路径,无需携带~符号,</param>
        /// <param name="nameKey">上传控件的Name值</param>
        /// <param name="fileName">不带文件类型的文件名,多个文件的时候后边增加_i</param>
        /// <returns>返回上传文件在服务器的存放位置 - 站内跟路径</returns>
        public static List<string> saveUploadFiles(string webInnerPath, string nameKey, string fileName = "")
        {
            List<string> list = new List<string>();
            //获取附件并保存
            HttpFileCollection files = HttpContext.Current.Request.Files;
            for (int i = 0; i < files.Count; i++)
            {
                if (files.AllKeys[i] == nameKey)
                {
                    string saveFileName = "";
                    if (fileName == "")
                        saveFileName = DateTime.Now.ToString("yyyyMMddHHmmss") + rui.diskHelper.getFileName(files[i].FileName);
                    else
                    {
                        if(files.Count > 1)
                        {
                            fileName = $"{fileName}_{i + 1}";
                        }
                        saveFileName = fileName + rui.diskHelper.getEtn(files[i].FileName);
                    }
                    string filepath = string.Format("{0}/{1}", webInnerPath, saveFileName);
                    string PhysicalPath = HttpContext.Current.Server.MapPath(filepath);
                    rui.diskHelper.createDirectory(PhysicalPath);
                    files[i].SaveAs(PhysicalPath);
                    list.Add(filepath);
                }
            }
            return list;
        }

        /// <summary>
        /// 文件复制
        /// </summary>
        /// <param name="webInnerSourPath">站内源文件</param>
        /// <param name="webInnerDescPath">站内目标文件</param>
        /// <param name="isOverWrite">是否覆盖</param>
        public static void copyFile(string webInnerSourPath, string webInnerDescPath, bool isOverWrite)
        {
            string sour = getAbsolutePath(webInnerSourPath);
            string desc = getAbsolutePath(webInnerDescPath);
            rui.diskHelper.createDirectory(desc);
            File.Copy(sour, desc, isOverWrite);
        }

        /// <summary>
        /// 删除文件
        /// </summary>
        /// <param name="webInnerPath">站内路径</param>
        public static void deleteFile(string webInnerPath)
        {
            string path = getAbsolutePath(webInnerPath);
            if (File.Exists(path))
                File.Delete(path);
        }

        /// <summary>
        /// 判断文件是否存在
        /// </summary>
        /// <param name="webInnerPath">站内路径</param>
        /// <returns></returns>
        public static bool isFileExist(string webInnerPath)
        {
            string path = getAbsolutePath(webInnerPath);
            return File.Exists(path);
        }
    }
}
