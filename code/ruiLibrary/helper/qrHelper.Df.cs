using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Gma.QrCodeNet.Encoding;
using Gma.QrCodeNet.Encoding.Windows.Render;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;

namespace rui
{
    /// <summary>
    /// 二维码和条形码生成的
    /// </summary>
    public class qrHelper
    {
        /// <summary>
        /// 创建URL的二维码
        /// </summary>
        /// <param name="url"></param>
        /// <returns></returns>
        public static Image create二维码(string url)
        {

            QrEncoder qrEncoder = new QrEncoder(ErrorCorrectionLevel.H);
            QrCode qrCode = qrEncoder.Encode(url);
            GraphicsRenderer renderer = new GraphicsRenderer(new FixedModuleSize(2, QuietZoneModules.Two));
            MemoryStream ms = new MemoryStream();
            renderer.WriteToStream(qrCode.Matrix, ImageFormat.Png, ms);
            Bitmap b = new Bitmap(ms);
            //b.Save(@"F:\a.jpg");
            return (Image)b;
        }
        /// <summary>
        /// 创建加工单条形码
        /// </summary>
        /// <param name="No"></param>
        /// <returns></returns>
        public static Image createCode39(string No)
        {
            BarcodeLib.Barcode b = new BarcodeLib.Barcode();
            b.BackColor = System.Drawing.Color.White;//图片背景颜色  
            b.ForeColor = System.Drawing.Color.Black;//条码颜色  
            b.IncludeLabel = true;
            b.Alignment = BarcodeLib.AlignmentPositions.CENTER;
            b.LabelPosition = BarcodeLib.LabelPositions.BOTTOMCENTER;
            b.ImageFormat = System.Drawing.Imaging.ImageFormat.Jpeg;//图片格式  
            System.Drawing.Font font = new System.Drawing.Font("verdana", 10f);//字体设置  
            b.LabelFont = font;
            b.Height = 55;//图片高度设置(px单位)  
            b.Width = 170;//图片宽度设置(px单位)  

            Image image = b.Encode(BarcodeLib.TYPE.CODE39, No);//生成图片 
            return image;
        }
    }
}
