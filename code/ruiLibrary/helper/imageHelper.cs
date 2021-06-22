using System;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Runtime.Serialization.Formatters.Binary;

namespace rui
{
    /// <summary>
    /// 图片操作辅助类
    /// </summary>
    public class imageHelper
    {
        /// <summary>
        /// 图片转base64
        /// </summary>
        /// <param name="img"></param>
        /// <returns></returns>
        public static string ImageToBase64(Image img)
        {
            BinaryFormatter binFormatter = new BinaryFormatter();
            MemoryStream memStream = new MemoryStream();
            binFormatter.Serialize(memStream, img);
            byte[] bytes = memStream.GetBuffer();
            string base64 = Convert.ToBase64String(bytes);
            return base64;
        }

        /// <summary>
        /// base64转图片
        /// </summary>
        /// <param name="base64"></param>
        /// <returns></returns>
        public static Image Base64ToImage(string base64)
        {
            //去除前边的 data:image/jpeg base64,
            if (base64.Contains(";base64,"))
            {
                base64 = base64.Substring(base64.IndexOf(";base64,") + 8);
            }

            byte[] bytes = Convert.FromBase64String(base64);
            MemoryStream ms = new MemoryStream(bytes);
            System.Drawing.Bitmap img = new System.Drawing.Bitmap(ms);
            return img;
        }

        /// <summary>
        /// Convert Image to Byte[]
        /// </summary>
        /// <param name="image"></param>
        /// <returns></returns>
        public static byte[] ImageToBytes(Image image)
        {
            ImageFormat format = image.RawFormat;
            using (MemoryStream ms = new MemoryStream())
            {
                if (format.Equals(ImageFormat.Jpeg))
                {
                    image.Save(ms, ImageFormat.Jpeg);
                }
                else if (format.Equals(ImageFormat.Png))
                {
                    image.Save(ms, ImageFormat.Png);
                }
                else if (format.Equals(ImageFormat.Bmp))
                {
                    image.Save(ms, ImageFormat.Bmp);
                }
                else if (format.Equals(ImageFormat.Gif))
                {
                    image.Save(ms, ImageFormat.Gif);
                }
                else if (format.Equals(ImageFormat.Icon))
                {
                    image.Save(ms, ImageFormat.Icon);
                }
                else
                {
                    image.Save(ms, ImageFormat.Jpeg);
                }
                byte[] buffer = new byte[ms.Length];
                //Image.Save()会改变MemoryStream的Position，需要重新Seek到Begin
                ms.Seek(0, SeekOrigin.Begin);
                ms.Read(buffer, 0, buffer.Length);
                return buffer;
            }
        }

        /// <summary>
        /// Convert Byte[] to Image
        /// </summary>
        /// <param name="buffer"></param>
        /// <returns></returns>
        public static Image BytesToImage(byte[] buffer)
        {
            if (buffer != null && buffer.Length > 0)
            {
                MemoryStream ms = new MemoryStream(buffer);
                Image image = System.Drawing.Image.FromStream(ms);
                return image;
            }
            else
                return null;
        }

        /// <summary>
        /// Convert Byte[] to a picture and Store it in file
        /// </summary>
        /// <param name="fileName">物理路径，不带后缀名</param>
        /// <param name="buffer"></param>
        /// <returns></returns>
        public static string CreateImageFromBytes(string fileName, byte[] buffer)
        {
            string file = fileName;
            Image image = BytesToImage(buffer);
            ImageFormat format = image.RawFormat;
            if (format.Equals(ImageFormat.Jpeg))
            {
                file += ".jpeg";
            }
            else if (format.Equals(ImageFormat.Png))
            {
                file += ".png";
            }
            else if (format.Equals(ImageFormat.Bmp))
            {
                file += ".bmp";
            }
            else if (format.Equals(ImageFormat.Gif))
            {
                file += ".gif";
            }
            else if (format.Equals(ImageFormat.Icon))
            {
                file += ".icon";
            }
            System.IO.FileInfo info = new System.IO.FileInfo(file);
            System.IO.Directory.CreateDirectory(info.Directory.FullName);
            File.WriteAllBytes(file, buffer);
            return file;
        }

        /// <summary>
        /// 通过路径获取图片对象
        /// </summary>
        /// <param name="path">物理路径</param>
        /// <returns></returns>
        public static Image getImageFromPath(string path)
        {
            FileStream io = new FileStream(path, FileMode.Open);
            Image img = new Bitmap(io);
            io.Close();
            return img;
        }

        /// <summary>
        /// 获取图片大小
        /// </summary>
        /// <param name="path">物理路径</param>
        /// <returns></returns>
        public static Size getImageSize(string path)
        {
            FileStream io = new FileStream(path, FileMode.Open);
            Image img = new Bitmap(io);
            io.Close();
            return new Size(img.Width, img.Height);
        }

        /// <summary>
        /// 图片保存
        /// </summary>
        /// <param name="img"></param>
        /// <param name="path">物理路径</param>
        /// <param name="imgFormat"></param>
        public static void saveImage(Image img, string path, System.Drawing.Imaging.ImageFormat imgFormat)
        {
            img.Save(path, imgFormat);
            img.Dispose();
        }

        /// <summary>
        /// 根据角度旋转图标
        /// </summary>
        /// <param name="img"></param>
        /// <param name="angle">角度</param>
        public System.Drawing.Image RotateImg(System.Drawing.Image img, float angle)
        {
            //通过Png图片设置图片透明，修改旋转图片变黑问题。
            int width = img.Width;
            int height = img.Height;
            //角度
            Matrix mtrx = new Matrix();
            mtrx.RotateAt(angle, new PointF((width / 2), (height / 2)), MatrixOrder.Append);
            //得到旋转后的矩形
            GraphicsPath path = new GraphicsPath();
            path.AddRectangle(new RectangleF(0f, 0f, width, height));
            RectangleF rct = path.GetBounds(mtrx);
            //生成目标位图
            Bitmap devImage = new Bitmap((int)(rct.Width), (int)(rct.Height));
            Graphics g = Graphics.FromImage(devImage);
            g.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.Bilinear;
            g.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.HighQuality;
            //计算偏移量
            Point Offset = new Point((int)(rct.Width - width) / 2, (int)(rct.Height - height) / 2);
            //构造图像显示区域：让图像的中心与窗口的中心点一致
            Rectangle rect = new Rectangle(Offset.X, Offset.Y, (int)width, (int)height);
            Point center = new Point((int)(rect.X + rect.Width / 2), (int)(rect.Y + rect.Height / 2));
            g.TranslateTransform(center.X, center.Y);
            g.RotateTransform(angle);
            //恢复图像在水平和垂直方向的平移
            g.TranslateTransform(-center.X, -center.Y);
            g.DrawImage(img, rect);
            //重至绘图的所有变换
            g.ResetTransform();
            g.Save();
            g.Dispose();
            path.Dispose();
            return devImage;
        }

        /// <summary>
        /// 第二种方法
        /// </summary>
        /// <param name="b"></param>
        /// <param name="angle"></param>
        /// <returns></returns>
        public System.Drawing.Image RotateImg2(System.Drawing.Image b, float angle)
        {
            angle = angle % 360;            //弧度转换
            double radian = angle * Math.PI / 180.0;
            double cos = Math.Cos(radian);
            double sin = Math.Sin(radian);
            //原图的宽和高
            int w = b.Width;
            int h = b.Height;
            int W = (int)(Math.Max(Math.Abs(w * cos - h * sin), Math.Abs(w * cos + h * sin)));
            int H = (int)(Math.Max(Math.Abs(w * sin - h * cos), Math.Abs(w * sin + h * cos)));
            //目标位图
            System.Drawing.Image dsImage = new Bitmap(W, H);
            System.Drawing.Graphics g = System.Drawing.Graphics.FromImage(dsImage);
            g.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.Bilinear;
            g.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.HighQuality;
            //计算偏移量
            Point Offset = new Point((W - w) / 2, (H - h) / 2);
            //构造图像显示区域：让图像的中心与窗口的中心点一致
            Rectangle rect = new Rectangle(Offset.X, Offset.Y, w, h);
            Point center = new Point(rect.X + rect.Width / 2, rect.Y + rect.Height / 2);
            g.TranslateTransform(center.X, center.Y);
            g.RotateTransform(360 - angle);
            //恢复图像在水平和垂直方向的平移
            g.TranslateTransform(-center.X, -center.Y);
            g.DrawImage(b, rect);
            //重至绘图的所有变换
            g.ResetTransform();
            g.Save();
            g.Dispose();
            //dsImage.Save("yuancd.jpg", System.Drawing.Imaging.ImageFormat.Jpeg);
            return dsImage;
        }

        /// <summary>
        /// EXIF 内部 Orientation参数的值进行图片的旋转
        /// </summary>
        /// <param name="img"></param>
        public static void ImgAutoRotate(Image img)
        {
            try
            {
                rui.logHelper.log("3");
                var result = from a in img.PropertyItems
                             where a.Id == 0x0112
                             select a.Value;
                if (result != null && result.Count() > 0)
                {
                    byte[] buffer = (byte[])result.First();
                    rotating(img, buffer[0]);
                }
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex);
            }
        }

        private static void rotating(Image img, int orien)
        {
            rui.logHelper.log("图片角度" + orien.ToString());
            switch (orien)
            {
                case 2:
                    img.RotateFlip(RotateFlipType.RotateNoneFlipX);//horizontal flip
                    break;
                case 3:
                    img.RotateFlip(RotateFlipType.Rotate180FlipNone);//right-top
                    break;
                case 4:
                    img.RotateFlip(RotateFlipType.RotateNoneFlipY);//vertical flip
                    break;
                case 5:
                    img.RotateFlip(RotateFlipType.Rotate90FlipX);
                    break;
                case 6:
                    img.RotateFlip(RotateFlipType.Rotate90FlipNone);//right-top
                    break;
                case 7:
                    img.RotateFlip(RotateFlipType.Rotate270FlipX);
                    break;
                case 8:
                    img.RotateFlip(RotateFlipType.Rotate270FlipNone);//left-bottom
                    break;
                default:
                    break;
            }
        }
    }
}
