using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace db.bll
{
    /// <summary>
    /// 单据附件
    /// </summary>
    public class sys_BillAttach
    {
        //附件上传
        /// <summary>
        /// 
        /// </summary>
        /// <param name="resourceCode">资源标识</param>
        /// <param name="prjSysCode">项目系统编号</param>
        /// <param name="keyCode">单据编号</param>
        /// <param name="dc"></param>
        public static void upload(string resourceCode, string keyCode, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc); 

            //创建目录
            string path = string.Format("~/upload/bill/{0}/{1}/{2}/", resourceCode, DateTime.Now.Year, DateTime.Now.Month);
            rui.diskHelper.createDirectory(rui.webDiskHelper.getAbsolutePath(path));
            //保存文件
            HttpFileCollection files = HttpContext.Current.Request.Files;
            if (files.Count > 0)
            {
                for (int i = 0; i < files.Count; i++)
                {
                    string filename = rui.diskHelper.getFileName(files[i].FileName);
                    string filepath = string.Format("{0}/{1}", path, DateTime.Now.ToString("yyyyMMddHHmmss") + filename);
                    string PhysicalPath = HttpContext.Current.Server.MapPath(filepath);
                    files[i].SaveAs(PhysicalPath);

                    db.sys_BillAttach entry = new db.sys_BillAttach();
                    entry.rowID = ef.newGuid();
                    entry.attachCode = ef.newGuid();
                    entry.relatedResourceCode = resourceCode;
                    entry.relatedKeyCode = keyCode;
                    entry.attachUrl = filepath.Substring(1);
                    entry.attachName = files[i].FileName;
                    //entry.attachExt = rui.diskHelper.getEtn(filepath);
                    entry.attachLength = files[i].ContentLength;
                    entry.attachMIME = files[i].ContentType;
                    entry.uploadUserCode = db.bll.loginAdminHelper.getUserCode();
                    entry.uploadDateTime = DateTime.Now;
                    try
                    {
                        entry.prieviewUrl = db.bll.sys_BillAttach.createPreviewHTML(resourceCode, filepath, entry.attachName);
                    }
                    catch (Exception)
                    {
                    }
                    dc.sys_BillAttach.Add(entry);
                }
                dc.SaveChanges();
            }
            else
            {
                rui.excptHelper.throwEx("请选择上传的文件");
            }
        }

        //保存附件(备注)
        public static void batchSave(db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            Dictionary<string, List<string>> dic = new Dictionary<string, List<string>>();
            dic.Add("rowID", rui.requestHelper.getList("attach.rowID"));
            dic.Add("attachContent", rui.requestHelper.getList("attach.attachContent"));
            List<db.sys_BillAttach> list = db.efHelper.getEntryList<db.sys_BillAttach>(dc, dic);

            foreach (var item in list)
            {
                db.sys_BillAttach entry = getEntryByRowID(item.rowID, dc);
                entry.attachContent = item.attachContent;
            }
            dc.SaveChanges();
        }

        //附件删除
        public static void delete(string rowID, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc); 

            db.sys_BillAttach entry = dc.sys_BillAttach.SingleOrDefault(a => a.rowID == rowID);
            if (entry != null)
            {
                string filePath = entry.attachUrl;
                dc.sys_BillAttach.Remove(entry);
                dc.SaveChanges();
                rui.diskHelper.deleteFile(rui.webDiskHelper.getAbsolutePath(filePath));
            }
        }

        //生成预览网页
        public static string createPreviewHTML(string billType, string filePath, string fileName)
        {
            //取扩展名
            string previewPath = filePath;
            string extension = fileName.Substring(fileName.LastIndexOf(".") + 1);

            //生成word的预览文件
            if (extension == "doc" || extension == "docx")
            {
                //创建目录
                string path = string.Format("/upload/preview/{0}/{1}/{2}/", billType, DateTime.Now.Year, DateTime.Now.ToString("MMddHHssmm"));
                rui.diskHelper.createDirectory(rui.webDiskHelper.getAbsolutePath(path));

                Aspose.Words.Document doc = new Aspose.Words.Document(HttpContext.Current.Server.MapPath(filePath));
                previewPath = path + "/index.html";
                doc.Save(HttpContext.Current.Server.MapPath(previewPath), Aspose.Words.SaveFormat.Html);
            }
            //生成excel预览文件
            if (extension == "xls" || extension == "xlsx")
            {
                //创建目录
                string path = string.Format("/upload/preview/{0}/{1}/{2}/", billType, DateTime.Now.Year, DateTime.Now.ToString("MMddHHssmm"));
                rui.diskHelper.createDirectory(rui.webDiskHelper.getAbsolutePath(path));

                Aspose.Cells.Workbook doc = new Aspose.Cells.Workbook(HttpContext.Current.Server.MapPath(filePath));
                previewPath = path + "/index.html";
                doc.Save(HttpContext.Current.Server.MapPath(previewPath), Aspose.Cells.SaveFormat.Html);
            }
            return previewPath.Substring(1);
        }

        //获取实体
        public static db.sys_BillAttach getEntryByRowID(string rowID, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc); 

            db.sys_BillAttach entry = dc.sys_BillAttach.Single(a => a.rowID == rowID);
            return entry;
        }

        //获取实体
        public static db.sys_BillAttach getEntryByCode(string keyCode, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc); 

            db.sys_BillAttach entry = dc.sys_BillAttach.SingleOrDefault(a => a.attachCode == keyCode);
            return entry;
        }

        //通过文件路径获取文件的MIME类型
        public static string getMIME(string filePath)
        {
            string extName = filePath.Substring(filePath.LastIndexOf(".") + 1, (filePath.Length - filePath.LastIndexOf(".") - 1));
            Dictionary<string, string> dic = new Dictionary<string, string>();      
            dic.Add("*","application/octet-stream");
            dic.Add("323","text/h323");
            dic.Add("acx","application/internet-property-stream");
            dic.Add("ai","application/postscript");
            dic.Add("aif","audio/x-aiff");
            dic.Add("aifc","audio/x-aiff");
            dic.Add("aiff","audio/x-aiff");
            dic.Add("asf","video/x-ms-asf");
            dic.Add("asr","video/x-ms-asf");
            dic.Add("asx","video/x-ms-asf");
            dic.Add("au","audio/basic");
            dic.Add("avi","video/x-msvideo");
            dic.Add("axs","application/olescript");
            dic.Add("bas","text/plain");
            dic.Add("bcpio","application/x-bcpio");
            dic.Add("bin","application/octet-stream");
            dic.Add("bmp","image/bmp");
            dic.Add("c","text/plain");
            dic.Add("cat","application/vnd.ms-pkiseccat");
            dic.Add("cdf","application/x-cdf");
            dic.Add("cer","application/x-x509-ca-cert");
            dic.Add("class","application/octet-stream");
            dic.Add("clp","application/x-msclip");
            dic.Add("cmx","image/x-cmx");
            dic.Add("cod","image/cis-cod");
            dic.Add("cpio","application/x-cpio");
            dic.Add("crd","application/x-mscardfile");
            dic.Add("crl","application/pkix-crl");
            dic.Add("crt","application/x-x509-ca-cert");
            dic.Add("csh","application/x-csh");
            dic.Add("css","text/css");
            dic.Add("dcr","application/x-director");
            dic.Add("der","application/x-x509-ca-cert");
            dic.Add("dir","application/x-director");
            dic.Add("dll","application/x-msdownload");
            dic.Add("dms","application/octet-stream");
            dic.Add("doc","application/msword");
            dic.Add("dot","application/msword");
            dic.Add("dvi","application/x-dvi");
            dic.Add("dxr","application/x-director");
            dic.Add("eps","application/postscript");
            dic.Add("etx","text/x-setext");
            dic.Add("evy","application/envoy");
            dic.Add("exe","application/octet-stream");
            dic.Add("fif","application/fractals");
            dic.Add("flr","x-world/x-vrml");
            dic.Add("gif","image/gif");
            dic.Add("gtar","application/x-gtar");
            dic.Add("gz","application/x-gzip");
            dic.Add("h","text/plain");
            dic.Add("hdf","application/x-hdf");
            dic.Add("hlp","application/winhlp");
            dic.Add("hqx","application/mac-binhex40");
            dic.Add("hta","application/hta");
            dic.Add("htc","text/x-component");
            dic.Add("htm","text/html");
            dic.Add("html","text/html");
            dic.Add("htt","text/webviewhtml");
            dic.Add("ico","image/x-icon");
            dic.Add("ief","image/ief");
            dic.Add("iii","application/x-iphone");
            dic.Add("ins","application/x-internet-signup");
            dic.Add("isp","application/x-internet-signup");
            dic.Add("jfif","image/pipeg");
            dic.Add("jpe","image/jpeg");
            dic.Add("jpeg","image/jpeg");
            dic.Add("jpg","image/jpeg");
            dic.Add("js","application/x-javascript");
            dic.Add("latex","application/x-latex");
            dic.Add("lha","application/octet-stream");
            dic.Add("lsf","video/x-la-asf");
            dic.Add("lsx","video/x-la-asf");
            dic.Add("lzh","application/octet-stream");
            dic.Add("m13","application/x-msmediaview");
            dic.Add("m14","application/x-msmediaview");
            dic.Add("m3u","audio/x-mpegurl");
            dic.Add("man","application/x-troff-man");
            dic.Add("mdb","application/x-msaccess");
            dic.Add("me","application/x-troff-me");
            dic.Add("mht","message/rfc822");
            dic.Add("mhtml","message/rfc822");
            dic.Add("mid","audio/mid");
            dic.Add("mny","application/x-msmoney");
            dic.Add("mov","video/quicktime");
            dic.Add("movie","video/x-sgi-movie");
            dic.Add("mp2","video/mpeg");
            dic.Add("mp3","audio/mpeg");
            dic.Add("mpa","video/mpeg");
            dic.Add("mpe","video/mpeg");
            dic.Add("mpeg","video/mpeg");
            dic.Add("mpg","video/mpeg");
            dic.Add("mpp","application/vnd.ms-project");
            dic.Add("mpv2","video/mpeg");
            dic.Add("ms","application/x-troff-ms");
            dic.Add("mvb","application/x-msmediaview");
            dic.Add("nws","message/rfc822");
            dic.Add("oda","application/oda");
            dic.Add("p10","application/pkcs10");
            dic.Add("p12","application/x-pkcs12");
            dic.Add("p7b","application/x-pkcs7-certificates");
            dic.Add("p7c","application/x-pkcs7-mime");
            dic.Add("p7m","application/x-pkcs7-mime");
            dic.Add("p7r","application/x-pkcs7-certreqresp");
            dic.Add("p7s","application/x-pkcs7-signature");
            dic.Add("pbm","image/x-portable-bitmap");
            dic.Add("pdf","application/pdf");
            dic.Add("pfx","application/x-pkcs12");
            dic.Add("pgm","image/x-portable-graymap");
            dic.Add("pko","application/ynd.ms-pkipko");
            dic.Add("pma","application/x-perfmon");
            dic.Add("pmc","application/x-perfmon");
            dic.Add("pml","application/x-perfmon");
            dic.Add("pmr","application/x-perfmon");
            dic.Add("pmw","application/x-perfmon");
            dic.Add("pnm","image/x-portable-anymap");
            dic.Add("pot,","application/vnd.ms-powerpoint");
            dic.Add("ppm","image/x-portable-pixmap");
            dic.Add("pps","application/vnd.ms-powerpoint");
            dic.Add("ppt","application/vnd.ms-powerpoint");
            dic.Add("prf","application/pics-rules");
            dic.Add("ps","application/postscript");
            dic.Add("pub","application/x-mspublisher");
            dic.Add("qt","video/quicktime");
            dic.Add("ra","audio/x-pn-realaudio");
            dic.Add("ram","audio/x-pn-realaudio");
            dic.Add("ras","image/x-cmu-raster");
            dic.Add("rgb","image/x-rgb");
            dic.Add("rmi","audio/mid");
            dic.Add("roff","application/x-troff");
            dic.Add("rtf","application/rtf");
            dic.Add("rtx","text/richtext");
            dic.Add("scd","application/x-msschedule");
            dic.Add("sct","text/scriptlet");
            dic.Add("setpay","application/set-payment-initiation");
            dic.Add("setreg","application/set-registration-initiation");
            dic.Add("sh","application/x-sh");
            dic.Add("shar","application/x-shar");
            dic.Add("sit","application/x-stuffit");
            dic.Add("snd","audio/basic");
            dic.Add("spc","application/x-pkcs7-certificates");
            dic.Add("spl","application/futuresplash");
            dic.Add("src","application/x-wais-source");
            dic.Add("sst","application/vnd.ms-pkicertstore");
            dic.Add("stl","application/vnd.ms-pkistl");
            dic.Add("stm","text/html");
            dic.Add("svg","image/svg+xml");
            dic.Add("sv4cpio","application/x-sv4cpio");
            dic.Add("sv4crc","application/x-sv4crc");
            dic.Add("swf","application/x-shockwave-flash");
            dic.Add("t","application/x-troff");
            dic.Add("tar","application/x-tar");
            dic.Add("tcl","application/x-tcl");
            dic.Add("tex","application/x-tex");
            dic.Add("texi","application/x-texinfo");
            dic.Add("texinfo","application/x-texinfo");
            dic.Add("tgz","application/x-compressed");
            dic.Add("tif","image/tiff");
            dic.Add("tiff","image/tiff");
            dic.Add("tr","application/x-troff");
            dic.Add("trm","application/x-msterminal");
            dic.Add("tsv","text/tab-separated-values");
            dic.Add("txt","text/plain");
            dic.Add("uls","text/iuls");
            dic.Add("ustar","application/x-ustar");
            dic.Add("vcf","text/x-vcard");
            dic.Add("vrml","x-world/x-vrml");
            dic.Add("wav","audio/x-wav");
            dic.Add("wcm","application/vnd.ms-works");
            dic.Add("wdb","application/vnd.ms-works");
            dic.Add("wks","application/vnd.ms-works");
            dic.Add("wmf","application/x-msmetafile");
            dic.Add("wps","application/vnd.ms-works");
            dic.Add("wri","application/x-mswrite");
            dic.Add("wrl","x-world/x-vrml");
            dic.Add("wrz","x-world/x-vrml");
            dic.Add("xaf","x-world/x-vrml");
            dic.Add("xbm","image/x-xbitmap");
            dic.Add("xla","application/vnd.ms-excel");
            dic.Add("xlc","application/vnd.ms-excel");
            dic.Add("xlm","application/vnd.ms-excel");
            dic.Add("xls","application/vnd.ms-excel");
            dic.Add("xlt","application/vnd.ms-excel");
            dic.Add("xlw","application/vnd.ms-excel");
            dic.Add("xof","x-world/x-vrml");
            dic.Add("xpm","image/x-xpixmap");
            dic.Add("xwd","image/x-xwindowdump");
            dic.Add("z","application/x-compress");
            dic.Add("zip","application/zip");

            return dic[extName];
        }

        //通过路径获取文件名称
        public static string getFileName(string filePath)
        {
            string fileName = filePath.Substring(filePath.LastIndexOf("\\") + 1);
            return fileName;
        }
    }
}
