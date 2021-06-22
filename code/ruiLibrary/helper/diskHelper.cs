using System;
using System.Collections.Generic;
using System.IO;

namespace rui
{
    /// <summary>
    /// 文件和目录操作辅助类
    /// </summary>
    public class diskHelper
    {
        /// <summary>
        /// 获取Path中的路径部分
        /// </summary>
        /// <param name="pathValue"></param>
        /// <returns></returns>
        private static string _getDirectoryPath(string pathValue)
        {
            //包含文件，则返回路径，否则直接返回路径
            if (pathValue.IndexOf(".") > 0)
                return Path.GetDirectoryName(pathValue);
            else
                return pathValue;
        }

        /// <summary>
        /// 创建目录
        /// </summary>
        /// <param name="absolutePath">绝对路径</param>
        public static void createDirectory(string absolutePath)
        {
            absolutePath = _getDirectoryPath(absolutePath);
            if (Directory.Exists(absolutePath) == false)
                Directory.CreateDirectory(absolutePath);
        }

        /// <summary>
        /// 删除目录
        /// </summary>
        /// <param name="absolutePath">绝对路径</param>
        public static void deleteDirectory(string absolutePath)
        {
            absolutePath = _getDirectoryPath(absolutePath);
            if (Directory.Exists(absolutePath) == true)
                Directory.Delete(absolutePath, true);
        }

        /// <summary>
        /// 目录文件复制(存在则覆盖)
        /// </summary>
        /// <param name="sourPath">源目录</param>
        /// <param name="descPath">目标位置</param>
        /// <param name="exceptList">排除的文件类型</param>
        /// <param name="isOverWrite">是否强制覆盖,还是变更了才覆盖</param>
        /// <returns></returns>
        public static void copyDirectory(string sourPath, string descPath, List<string> exceptList = null, bool isOverWrite = false)
        {
            sourPath = _getDirectoryPath(sourPath);
            descPath = _getDirectoryPath(descPath);
            DirectoryInfo sourInfo = new DirectoryInfo(sourPath);
            //判断要复制目录是否存在
            if (Directory.Exists(sourPath))
            {
                //对目录内所有内容进行遍历
                foreach (FileSystemInfo f in sourInfo.GetFileSystemInfos())
                {
                    //目标路径destName = 目标文件夹路径 + 原文件夹下的子文件(或文件夹)名字
                    String destFilePath = Path.Combine(descPath, f.Name);
                    if (f is FileInfo)
                    {
                        //如果是文件
                        _copyFile(f.FullName, destFilePath, exceptList, isOverWrite);
                    }
                    else
                    {
                        if (Directory.Exists(destFilePath))
                        {
                            //如果目标目录存在，直接复制目录
                            copyDirectory(f.FullName, destFilePath, exceptList, isOverWrite);
                        }
                        else
                        {
                            //目标目录不存在，则创建目录并复制
                            rui.diskHelper.createDirectory(destFilePath);
                            copyDirectory(f.FullName, destFilePath, exceptList, isOverWrite);
                        }
                    }
                }
            }
        }

        /// <summary>
        /// 复制文件的子方法
        /// </summary>
        /// <param name="sourFilePath"></param>
        /// <param name="destFilePath"></param>
        /// <param name="exceptList"></param>
        /// <param name="isOverWrite">是否强制覆盖文件</param>
        private static void _copyFile(string sourFilePath, string destFilePath,List<string> exceptList, bool isOverWrite = false)
        {
            if (exceptList != null)
            {
                FileInfo f = new FileInfo(sourFilePath);
                if (exceptList.Contains(f.Extension))
                    return;

                if (sourFilePath.IndexOf(".vshost.") > 0)
                    return;
            }
            if (File.Exists(destFilePath) == false)
            {
                //如果目标文件不存在，则直接复制
                File.Copy(sourFilePath, destFilePath, true);
                rui.logHelper.log("拷贝了:" + destFilePath + " ~ " + sourFilePath);
            }
            else
            {
                //如果存在，则判断修改时间来决定是否要复制
                FileInfo sourInfo = new FileInfo(sourFilePath);
                FileInfo descInfo = new FileInfo(destFilePath);
                if (isOverWrite == true)
                {
                    File.Copy(sourFilePath, destFilePath, true);
                    rui.logHelper.log("拷贝了:" + destFilePath + " ~ " + sourFilePath);
                }
                else if(sourInfo.LastWriteTime > descInfo.LastWriteTime)
                {  
                    File.Copy(sourFilePath, destFilePath, true);
                    rui.logHelper.log("拷贝了:" + destFilePath + " ~ " + sourFilePath);
                }
            }
        }

        /// <summary>
        /// 文件复制
        /// </summary>
        /// <param name="sourFilePath">源文件</param>
        /// <param name="destFilePath">目标文件</param>
        /// <param name="isOverWrite">是否覆盖</param>
        public static void copyFile(string sourFilePath,string destFilePath,bool isOverWrite)
        {
            File.Copy(sourFilePath, destFilePath, isOverWrite);
        }

        /// <summary>
        /// 删除文件
        /// </summary>
        /// <param name="absolutePath">绝对路径</param>
        public static void deleteFile(string absolutePath)
        {
            if (File.Exists(absolutePath))
                File.Delete(absolutePath);
        }

        /// <summary>
        /// 判断文件是否存在
        /// </summary>
        /// <param name="absolutePath">绝对路径</param>
        /// <returns></returns>
        public static bool isExist(string absolutePath)
        {
            return File.Exists(absolutePath);
        }

        /// <summary>
        /// 获取客户端上传的文件名
        /// </summary>
        /// <param name="pathValue">客户端文件路径</param>
        /// <returns></returns>
        public static string getFileName(string pathValue)
        {
            return Path.GetFileName(pathValue);
        }

        /// <summary>
        /// 获取文件后缀名
        /// </summary>
        /// <param name="filePath">客户端文件路径</param>
        /// <returns></returns>
        public static string getEtn(string filePath)
        {
            return Path.GetExtension(filePath);
        }

        /// <summary>
        /// 导出sql文件
        /// </summary>
        /// <param name="absolutePath">物理路径</param>
        /// <param name="list"></param>
        public static void sqlListToFile(string absolutePath, List<string> list)
        {
            System.IO.StreamWriter sw = new StreamWriter(absolutePath);
            foreach (string sql in list)
            {
                sw.WriteLine(sql);
            }
            sw.Flush();
            sw.Close();
        }
    }
}
