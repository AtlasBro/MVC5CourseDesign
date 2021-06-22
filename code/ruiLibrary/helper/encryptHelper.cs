using IntelliLock.Licensing;
using System;
using System.IO;
using System.Security.Cryptography;
using System.Text;

namespace rui
{
    /// <summary>
    /// 加密辅助类
    /// </summary>
    public class encryptHelper
    {
        /// <summary>
        /// 把一个字符串转换成对应的MD5
        /// </summary>
        /// <param name="value"></param>
        /// <returns></returns>
        public static string toMD5(string value)
        {
            System.Security.Cryptography.MD5 md5 = System.Security.Cryptography.MD5.Create();
            value = BitConverter.ToString(md5.ComputeHash(Encoding.UTF8.GetBytes(value))).Replace("-", null);
            return value.ToLower();
        }

        private static string _KEY = "wzr17021";  //密钥
        private static string _IV = "wzr17022";   //向量

        /// <summary>
        /// 加密
        /// </summary>
        /// <param name="data">明文</param>
        /// <returns>密文</returns>
        public static string DES加密(string data)
        {
            byte[] byKey = System.Text.ASCIIEncoding.ASCII.GetBytes(_KEY);
            byte[] byIV = System.Text.ASCIIEncoding.ASCII.GetBytes(_IV);

            DESCryptoServiceProvider cryptoProvider = new DESCryptoServiceProvider();
            int i = cryptoProvider.KeySize;
            MemoryStream ms = new MemoryStream();
            CryptoStream cst = new CryptoStream(ms, cryptoProvider.CreateEncryptor(byKey, byIV), CryptoStreamMode.Write);

            StreamWriter sw = new StreamWriter(cst);
            sw.Write(data);
            sw.Flush();
            cst.FlushFinalBlock();
            sw.Flush();

            string strRet = Convert.ToBase64String(ms.GetBuffer(), 0, (int)ms.Length);
            return strRet;
        }

        /// <summary>
        /// 解密
        /// </summary>
        /// <param name="data">密文</param>
        /// <returns>明文</returns>
        public static string DES解密(string data)
        {

            byte[] byKey = System.Text.ASCIIEncoding.ASCII.GetBytes(_KEY);
            byte[] byIV = System.Text.ASCIIEncoding.ASCII.GetBytes(_IV);

            byte[] byEnc;

            try
            {
                data.Replace("_%_", "/");
                data.Replace("-%-", "#");
                byEnc = Convert.FromBase64String(data);

            }
            catch
            {
                return null;
            }

            DESCryptoServiceProvider cryptoProvider = new DESCryptoServiceProvider();
            MemoryStream ms = new MemoryStream(byEnc);
            CryptoStream cst = new CryptoStream(ms, cryptoProvider.CreateDecryptor(byKey, byIV), CryptoStreamMode.Read);
            StreamReader sr = new StreamReader(cst);
            return sr.ReadToEnd();
        }

        /// <summary>
        /// 获取授权信息
        /// </summary>
        /// <returns></returns>
        public static string getPrivInfo()
        {
            LicenseStatus value = IntelliLock.Licensing.EvaluationMonitor.CurrentLicense.LicenseStatus;
            rui.logHelper.log("授权状态:" + value);
            if (value != LicenseStatus.Licensed)
            {
                return "授权时间到：" + IntelliLock.Licensing.EvaluationMonitor.CurrentLicense.ExpirationDate.ToString();
            }
            else
            {
                return "已授权用户";
            }
        }

        /// <summary>
        /// 获取硬件标识
        /// </summary>
        /// <param name="cpu"></param>
        /// <param name="hdd"></param>
        /// <param name="mac"></param>
        /// <param name="mainBoard"></param>
        /// <param name="bios"></param>
        /// <param name="os"></param>
        /// <returns></returns>
        public static string getHardwareID(bool cpu, bool hdd, bool mac, bool mainBoard, bool bios, bool os)
        {
            string value = IntelliLock.Licensing.HardwareID.GetHardwareID(cpu, hdd, mac, mainBoard, bios, os);
            return value;
        }

    }
}
