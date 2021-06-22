using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web.Security;

namespace rui
{
    /// <summary>
    /// 发送短信的插件（sms平台的）
    /// </summary>
    public class messageHelper
    {
        /// <summary>
        /// 发送方法
        /// </summary>
        /// <param name="message"></param>
        /// <param name="phone"></param>
        public static void Send(string message,string phone)
        {
            string sendurl = "http://api.sms.cn/mt/";
            string mobile = phone;  //发送号码
            string strContent = message;
            StringBuilder sbTemp = new StringBuilder();
            string uid = "wzrui";
            string pwd = "gujian";
            string Pass = rui.encryptHelper.toMD5(pwd + uid); //密码进行MD5加密
            //POST 传值
            sbTemp.Append("uid=" + uid + "&pwd=" + Pass + "&mobile=" + mobile + "&content=" + strContent);
            byte[] bTemp = System.Text.Encoding.GetEncoding("GBK").GetBytes(sbTemp.ToString());
            String postReturn = doPostRequest(sendurl, bTemp);
            showResult(postReturn);
        }
        //POST方式发送得结果
        private static String doPostRequest(string url, byte[] bData)
        {
            System.Net.HttpWebRequest hwRequest;
            System.Net.HttpWebResponse hwResponse;

            string strResult = string.Empty;
            try
            {
                hwRequest = (System.Net.HttpWebRequest)System.Net.WebRequest.Create(url);
                hwRequest.Timeout = 5000;
                hwRequest.Method = "POST";
                hwRequest.ContentType = "application/x-www-form-urlencoded";
                hwRequest.ContentLength = bData.Length;

                System.IO.Stream smWrite = hwRequest.GetRequestStream();
                smWrite.Write(bData, 0, bData.Length);
                smWrite.Close();
            }
            catch (System.Exception err)
            {
                WriteErrLog(err.ToString());
                return strResult;
            }

            //get response
            try
            {
                hwResponse = (HttpWebResponse)hwRequest.GetResponse();
                StreamReader srReader = new StreamReader(hwResponse.GetResponseStream(), Encoding.ASCII);
                strResult = srReader.ReadToEnd();
                srReader.Close();
                hwResponse.Close();
            }
            catch (System.Exception err)
            {
                WriteErrLog(err.ToString());
            }
            return strResult;
        }
        private static void WriteErrLog(string strErr)
        {
            logHelper.log(strErr);
            System.Diagnostics.Trace.WriteLine(strErr);
        }
        private static void showResult(string result)
        {
            if (result.IndexOf("100") >= 0)
                rui.logHelper.log("发送成功");
            else if(result.IndexOf("102") >= 0)
                rui.logHelper.log("短信不足，请充值");
            else if (result.IndexOf("109") >= 0)
                rui.logHelper.log("账户冻结");
            else if (result.IndexOf("114") >= 0)
                rui.logHelper.log("账号被锁，10分钟后登录");
            else if (result.IndexOf("115") >= 0)
                rui.logHelper.log("连接失败");
            else if (result.IndexOf("120") >= 0)
                rui.logHelper.log("系统升级");
            else
            {
                rui.logHelper.log("未知错误发生");
                logHelper.log(result);
            }
        }
    }
}
