using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db.client.bll
{
    public class loginHelper
    {
        public static bool login(string userCode,string userPassword,db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);
            userPassword = rui.encryptHelper.toMD5(userPassword);
            db.bks_Customer entry = dc.bks_Customer.FirstOrDefault(a => a.cusomterName == userCode);
            if (entry != null)
            {
                rui.sessionHelper.saveValue("client.userCode", entry.customerCode);
                rui.sessionHelper.saveValue("client.userName", entry.cusomterName);
                rui.sessionHelper.saveValue("client.isLogin", true);
                return true;
            }
            return false;
        }
        //获取登录的用户编号
        public static string getLoginUserCode()
        {
            return rui.sessionHelper.getValue<string>("client.userCode");
        }
        //获取登录的用户名
        public static string getLoginUserName()
        {
            return rui.sessionHelper.getValue<string>("client.userName");
        }

        public static bool isLogin()
        {
            bool isLogin = rui.sessionHelper.getValue<bool>("client.isLogin");
            return isLogin;
        }
        public static void exit()
        {
            rui.sessionHelper.saveValue("client.isLogin", false);
        }
    }
}
