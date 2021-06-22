using iTextSharp.text.pdf;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;

namespace rui
{
    /// <summary>
    /// iTextSharp类的使用 生成PDF文件
    /// </summary>
    public  class iTextSharpHelper
    {
        /// <summary>
        /// 生成pdf文件 - 新华印务微信号用的，定制作品生成为pdf文件
        /// </summary>
        /// <param name="designCode"></param>
        public static void createPdf(string designCode)
        {
            //获取所有图片信息
            string path = string.Format("/upload/design/{0}/result/", designCode);
            List<string> files = System.IO.Directory.GetFiles(rui.webDiskHelper.getAbsolutePath(path), ".jgp").ToList();
            if (files.Count > 0)
            {
                Size firstSize = rui.imageHelper.getImageSize(files[0]);
                iTextSharp.text.Document doc = new iTextSharp.text.Document(new iTextSharp.text.Rectangle(firstSize.Width, firstSize.Height)
                    , 0F, 0F, 0F, 0F);
                PdfWriter.GetInstance(doc, new FileStream(HttpContext.Current.Server.MapPath(path) + designCode + ".pdf", FileMode.Create));
                doc.Open();
                foreach (var file in files)
                {
                    Size size = rui.imageHelper.getImageSize(file);
                    doc.SetPageSize(new iTextSharp.text.Rectangle(size.Width, size.Height));
                    iTextSharp.text.Image img = iTextSharp.text.Image.GetInstance(file);
                    doc.Add(img);
                }
                doc.Close();
            }
        }
    }
}
