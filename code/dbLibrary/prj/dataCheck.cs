using System.Text.RegularExpressions;

namespace rui
{
    /// <summary>
    /// 正则表达式检查数据合法性
    /// </summary>
    public class dataCheck
    {
        //==============================================合法数据检查的方法

        /// <summary>
        /// 检查字段的值是否为空，如果为空，则抛异常
        /// </summary>
        /// <param name="value"></param>
        /// <param name="fieldName"></param>
        public static void checkNotNull(object value, string fieldName, string showMsg = "")
        {
            string msg = string.Format("[{0}]必填", fieldName);
            if (rui.typeHelper.isNotNullOrEmpty(showMsg))
                msg = showMsg;

            if (rui.typeHelper.isNullOrEmpty(value))
                rui.excptHelper.throwEx(msg);
        }

        /// <summary>
        /// 检查是否是整数，不是整数，则报错误
        /// </summary>
        /// <param name="value"></param>
        /// <param name="fieldName"></param>
        public static void checkInt(object value, string fieldName, string showMsg = "")
        {
            string msg = string.Format("[{0}]的值必须是整数", fieldName);
            if (rui.typeHelper.isNotNullOrEmpty(showMsg))
                msg = showMsg;

            if (rui.typeHelper.toInt(value) == 0)
                rui.excptHelper.throwEx(msg);
        }

        /// <summary>
        /// 检查是否浮点数，不是浮点数，则报错误
        /// </summary>
        /// <param name="value"></param>
        /// <param name="fieldName"></param>
        public static void checkDecimal(object value, string fieldName, string showMsg = "")
        {
            string msg = string.Format("[{0}]的值必须是数值", fieldName);
            if (rui.typeHelper.isNotNullOrEmpty(showMsg))
                msg = showMsg;

            if (rui.typeHelper.toDecimal(value) == 0)
                rui.excptHelper.throwEx(msg);
        }

        /// <summary>
        /// 检查身份证是否合法
        /// </summary>
        /// <param name="value"></param>
        /// <param name="isThrow">是否抛出异常</param>
        /// <returns></returns>
        public static bool check身份证(string value,bool isThrow=false)
        {
            Regex regex = new Regex(@"^(^\d{15}$|^\d{18}$|^\d{17}(\d|X|x))$");
            bool result = regex.IsMatch(value);
            if (result == false && isThrow == true)
                rui.excptHelper.throwEx("身份证不合法");
            return result;
        }

        /// <summary>
        /// 检查手机号是否合法
        /// </summary>
        /// <param name="value"></param>
        /// <param name="isThrow">是否抛出异常</param>
        /// <returns></returns>
        public static bool check手机号(string value,bool isThrow=false)
        {
            Regex regex = new Regex(@"^[1]([1-9])[0-9]{9}$");
            bool result = regex.IsMatch(value);
            if (result == false && isThrow == true)
                rui.excptHelper.throwEx("手机号不合法");
            return result;
        }


        /// <summary>
        /// 检查变量值是否等于某个值，等于则抛出异常
        /// </summary>
        /// <param name="boolExpr">布尔表达式</param>
        /// <param name="errorMsg">成立时抛出的错误提醒</param>
        public static void checkExpr(bool boolExpr, string errorMsg)
        {
            if (boolExpr == true)
                rui.excptHelper.throwEx(errorMsg);
        }
    }
}
