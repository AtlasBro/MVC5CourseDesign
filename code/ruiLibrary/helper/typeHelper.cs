using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace rui
{
    /// <summary>
    /// 数据类型转换
    /// </summary>
    public class typeHelper
    {
        /// <summary>
        /// 时间转字符串
        /// 长格式：yyyy/MM/dd HH:mm:ss
        /// 短格式：yyyy/MM/dd
        /// </summary>
        /// <param name="value">任意形式数据</param>
        /// <param name="islang">是否长格式</param>
        /// <returns></returns>
        public static string toDateTimeString(object value, bool islang = false)
        {
            try
            {
                if (rui.typeHelper.isNullOrEmpty(value))
                    return "";

                value = rui.typeHelper.toDateTimeAllowNull(value);

                if (value is DateTime == false)
                {
                    return "";
                }
                else
                {
                    if (islang)
                        return Convert.ToDateTime(value).ToString(rui.configHelper.dateFormatLang);
                    else
                        return Convert.ToDateTime(value).ToString(rui.configHelper.dateFormat);
                }
            }
            catch (Exception ex)
            {
                logHelper.log(ex);
                return "";
            }
        }

        /// <summary>
        /// 返回指定格式的日期字符串
        /// </summary>
        /// <param name="value">任意形式数据</param>
        /// <param name="format">日期格式化串</param>
        /// <returns></returns>
        public static string toDateTimeFormat(object value, string format)
        {
            if (rui.typeHelper.isNotNullOrEmpty(value))
            {
                DateTime time = rui.typeHelper.toDateTime(value);
                return time.ToString(format);
            }
            return "";
        }

        /// <summary>
        /// 字符串转为时间（不合法串返回null)
        /// </summary>
        /// <param name="value">任意形式数据</param>
        /// <returns></returns>
        public static DateTime? toDateTimeAllowNull(object value)
        {
            try
            {
                if (value == null || value.ToString() == "")
                    return null;
                else
                    return Convert.ToDateTime(value);
            }
            catch (Exception ex)
            {
                logHelper.log(ex);
                return null;
            }
        }

        /// <summary>
        /// 字符串转为时间（不合法返回当前时间)
        /// </summary>
        /// <param name="value">任意形式数据</param>
        /// <returns></returns>
        public static DateTime toDateTime(object value)
        {
            try
            {
                if (value == null || value.ToString() == "")
                    return DateTime.Now;
                else
                    return Convert.ToDateTime(value);
            }
            catch (Exception ex)
            {
                logHelper.log(ex);
                return DateTime.Now;
            }
        }

        /// <summary>
        /// 返回某个时间对应的时间戳
        /// </summary>
        /// <param name="time">时间值</param>
        /// <returns></returns>
        public static string getTimeStamp(DateTime time)
        {
            System.DateTime startTime = new System.DateTime(1970, 1, 1);
            return ((int)(time - startTime).TotalSeconds).ToString();
        }

        /// <summary>
        /// 获取当前时间所在周周一的时间
        /// </summary>
        /// <param name="datetime">时间值</param>
        /// <returns></returns>
        public static DateTime getWeekFirstDay(DateTime datetime)
        {
            //星期一为第一天  
            int weeknow = Convert.ToInt32(datetime.DayOfWeek);

            //因为是以星期一为第一天，所以要判断weeknow等于0时，要向前推6天。  
            weeknow = (weeknow == 0 ? (7 - 1) : (weeknow - 1));
            int daydiff = (-1) * weeknow;

            //本周第一天  
            string FirstDay = datetime.AddDays(daydiff).ToString("yyyy-MM-dd");
            return Convert.ToDateTime(FirstDay);
        }

        /// <summary>
        /// 获取月份的开始时刻
        /// </summary>
        /// <param name="value">任意形式数据</param>
        /// <returns></returns>
        public static string getMonthStart(object value)
        {
            DateTime day = Convert.ToDateTime(value);
            return typeHelper.toDateTimeString(new DateTime(day.Year, day.Month, 1, 0, 0, 0), true);
        }

        /// <summary>
        /// 获取月份的结束时刻
        /// </summary>
        /// <param name="value">时间值</param>
        /// <returns></returns>
        public static string getMonthEnd(object value)
        {
            DateTime t = Convert.ToDateTime(value).AddMonths(1);
            DateTime day = new DateTime(t.Year, t.Month, 1, 0, 0, 0);
            day = day.AddMilliseconds(-1);
            return typeHelper.toDateTimeString(day, true);
        }

        /// <summary>
        /// 返回某天的开始时刻
        /// </summary>
        /// <param name="value">时间值</param>
        /// <returns></returns>
        public static string getDayStart(object value)
        {
            DateTime day = Convert.ToDateTime(value);
            return typeHelper.toDateTimeString(new DateTime(day.Year, day.Month, day.Day, 0, 0, 0), true);
        }

        /// <summary>
        /// 返回某天的结束时刻
        /// </summary>
        /// <param name="value">时间值</param>
        /// <returns></returns>
        public static string getDayEnd(object value)
        {
            DateTime t = Convert.ToDateTime(value);
            t = t.AddDays(1);
            DateTime day = new DateTime(t.Year, t.Month, t.Day, 0, 0, 0);
            day = day.AddMilliseconds(-1);
            return typeHelper.toDateTimeString(day, true);
        }

        /// <summary>
        /// 把分钟转换为小时显示
        /// 32分钟
        /// 1小时20分钟
        /// </summary>
        /// <param name="value">整数值</param>
        /// <returns></returns>
        public static string getHourShow(object value)
        {
            int val = rui.typeHelper.toInt(value);
            int hour = 0;
            int minute = 0;
            hour = val / 60;
            minute = val % 60;

            string result = "";
            if (hour == 0)
                result = $"{minute}分钟";
            if (hour > 0)
                result = $"{hour}小时{minute}分钟";

            return result;
        }

        /// <summary>
        /// 对象转字符串（null返回"")
        /// </summary>
        /// <param name="value">任意形式数据</param>
        /// <returns></returns>
        public static string toString(object value)
        {
            if (value == null)
                return "";
            else
                return value.ToString();
        }

        /// <summary>
        /// 对象转字符串（null返回null)
        /// </summary>
        /// <param name="value">任意形式数据</param>
        /// <returns></returns>
        public static string toStringAllowNull(object value)
        {
            if (value == null)
                return null;
            else if (value.ToString() == "")
                return null;
            return value.ToString();
        }

        /// <summary>
        /// 对象转decimal，非法返回0
        /// </summary>
        /// <param name="value">任意形式数据</param>
        /// <returns></returns>
        public static decimal toDecimal(object value)
        {
            try
            {
                if (value == null || value.ToString().Trim() == "")
                    return 0;
                return Convert.ToDecimal(value);
            }
            catch (Exception ex)
            {
                logHelper.log(ex);
                return 0;
            }
        }

        /// <summary>
        /// 对象转decimal，非法返回null
        /// </summary>
        /// <param name="value">任意形式数据</param>
        /// <returns></returns>
        public static decimal? toDecimalAllowNull(object value)
        {
            try
            {
                if (value == null || value.ToString().Trim() == "" || Convert.ToDecimal(value.ToString()) == 0)
                    return null;
                return Convert.ToDecimal(value.ToString());
            }
            catch (Exception ex)
            {
                logHelper.log(ex);
                return null;
            }
        }

        /// <summary>
        /// 对象转double,非法返回0
        /// </summary>
        /// <param name="value">任意形式数据</param>
        /// <returns></returns>
        public static double toDouble(object value)
        {
            try
            {
                if (value == null || value.ToString().Trim() == "")
                    return 0;
                return Convert.ToDouble(value);
            }
            catch (Exception ex)
            {
                logHelper.log(ex);
                return 0;
            }
        }

        /// <summary>
        /// 对象转double，非法返回null
        /// </summary>
        /// <param name="value">任意形式数据</param>
        /// <returns></returns>
        public static double? toDoubleAllowNull(object value)
        {
            try
            {
                if (value == null || value.ToString().Trim() == "")
                    return null;
                return Convert.ToDouble(value.ToString());
            }
            catch (Exception ex)
            {
                logHelper.log(ex);
                return null;
            }
        }

        /// <summary>
        /// 对象转布尔，非法返回false
        /// </summary>
        /// <param name="value">任意形式数据</param>
        /// <returns></returns>
        public static bool toBoolean(object value)
        {
            try
            {
                if (value == null || value.ToString() == "")
                    return false;
                return Convert.ToBoolean(value);
            }
            catch (Exception ex)
            {
                logHelper.log(ex);
                return false;
            }
        }

        /// <summary>
        /// 对象转整数，非法返回0
        /// </summary>
        /// <param name="value">任意形式数据</param>
        /// <returns></returns>
        public static int toInt(object value)
        {
            try
            {
                if (value == null || value.ToString().Trim() == "")
                    return 0;
                return Convert.ToInt32(value);

            }
            catch (Exception ex)
            {
                logHelper.log(ex);
                return 0;
            }
        }

        /// <summary>
        /// 对象转整数，非法返回null
        /// </summary>
        /// <param name="value">任意形式数据</param>
        /// <returns></returns>
        public static int? toIntAllowNull(object value)
        {
            try
            {
                if (value == null || value.ToString().Trim() == "")
                    return null;
                return Convert.ToInt32(value);
            }
            catch (Exception ex)
            {
                logHelper.log(ex);
                return null;
            }
        }

        /// <summary>
        /// 对象转长整数，非法返回0
        /// </summary>
        /// <param name="value">任意形式数据</param>
        /// <returns></returns>
        public static long toLong(object value)
        {
            try
            {
                if (value == null || value.ToString().Trim() == "")
                    return 0;
                return Convert.ToInt64(value);

            }
            catch (Exception ex)
            {
                logHelper.log(ex);
                return 0;
            }
        }

        /// <summary>
        /// 对象转长整数，非法返回0
        /// </summary>
        /// <param name="value">任意形式数据</param>
        /// <returns></returns>
        public static long? toLongAllowNull(object value)
        {
            try
            {
                if (value == null || value.ToString().Trim() == "")
                    return null;
                return Convert.ToInt64(value);

            }
            catch (Exception ex)
            {
                logHelper.log(ex);
                return 0;
            }
        }

        /// <summary>
        /// 去除浮点数后边的多余0: 
        /// 0.95000返回0.95;
        /// </summary>
        /// <param name="value">浮点数</param>
        /// <param name="returnEmptyStr">如果是0值，是否返回空串</param>
        /// <returns></returns>
        public static string removeZero(object value, bool returnEmptyStr = true)
        {
            if (value != null && value.ToString() != "")
            {
                string temp = value.ToString();

                //非小数无需处理
                if (temp.IndexOf(".") == -1)
                    return temp;
                else
                {
                    int i = temp.Length - 1;
                    for (; i > 0; i--)
                    {
                        if (temp[i] != '0' || temp[i] == '.')
                            break;
                    }
                    temp = temp.Substring(0, i + 1);
                    if (temp[temp.Length - 1] == '.')
                        temp = temp.Substring(0, temp.Length - 1);

                    //如果是零，返回空串
                    if (returnEmptyStr && temp == "0")
                        return "";
                    return temp;
                }
            }
            else
            {
                if (returnEmptyStr)
                    return "";
                else
                    return "0";
            }
        }

        /// <summary>
        /// 四舍五入 - 小数位数
        /// </summary>
        /// <param name="value">数值</param>
        /// <param name="length">小数保留位数</param>
        /// <returns></returns>
        public static decimal va四舍五入(object value, int length)
        {
            decimal temp = rui.typeHelper.toDecimal(Math.Pow(10, length));
            decimal valueTemp = rui.typeHelper.toDecimal(value);

            valueTemp = valueTemp * temp;
            valueTemp = Math.Round((decimal)valueTemp, MidpointRounding.AwayFromZero) / temp;
            return rui.typeHelper.toDecimal(rui.typeHelper.removeZero(valueTemp));
        }

        /// <summary>
        /// 四舍五入为整数
        /// </summary>
        /// <param name="value">浮点数</param>
        /// <returns></returns>
        public static int va四舍五入(object value)
        {
            return rui.typeHelper.toInt(rui.typeHelper.va四舍五入(value, 0));
        }

        /// <summary>
        /// 返回指定小数位的展示字符串
        /// </summary>
        /// <param name="value">浮点数</param>
        /// <param name="length">保留的小数位数</param>
        /// <returns></returns>
        public static string va小数位(decimal value, int length)
        {
            if (value != 0)
                return value.ToString(string.Format("f{0}", length));
            else
                return "";
        }

        /// <summary>
        /// 小数转百分比
        /// 0.1 转为 10%
        /// </summary>
        /// <param name="value">浮点数</param>
        /// <returns></returns>
        public static string toPercent(object value)
        {
            if (value != null || value.ToString().Trim() != "")
            {
                decimal a = rui.typeHelper.toDecimal(value);
                string str = rui.typeHelper.removeZero((a * 100).ToString());
                return str + "%";
            }
            else
                return "0%";
        }

        /// <summary>
        /// 判断是否null或者空串
        /// </summary>
        /// <param name="value">任意形式数据</param>
        /// <returns></returns>
        public static bool isNullOrEmpty(object value)
        {
            if (value == null)
                return true;
            else if (value.ToString().Trim() == rui.configHelper.va请选择Value)
                return true;
            else
                return string.IsNullOrWhiteSpace(value.ToString());
        }

        /// <summary>
        /// 检查是否空对象，如果是，则抛出异常
        /// </summary>
        /// <param name="value">任意形式数据</param>
        /// <param name="msg">为空时抛出的错误</param>
        public static void isNullOrEmpty(object value, string msg)
        {
            if (isNullOrEmpty(value))
                rui.excptHelper.throwEx(msg);
        }

        /// <summary>
        /// 判断是否不是null或者空串
        /// </summary>
        /// <param name="value">任意形式数据</param>
        /// <returns></returns>
        public static bool isNotNullOrEmpty(object value)
        {
            return !isNullOrEmpty(value);
        }

        /// <summary>
        /// 累加整数
        /// </summary>
        /// <param name="val1">整数1</param>
        /// <param name="val2">整数2</param>
        /// <returns>累加后的值</returns>
        public static int addInt(object val1, object val2)
        {
            return rui.typeHelper.toInt(val1) + rui.typeHelper.toInt(val2);
        }

        /// <summary>
        /// 累减整数
        /// </summary>
        /// <param name="val1">整数1</param>
        /// <param name="val2">整数2</param>
        /// <returns>累减后的值</returns>
        public static int subInt(object val1, object val2)
        {
            return rui.typeHelper.toInt(val1) - rui.typeHelper.toInt(val2);
        }

        /// <summary>
        /// 累加浮点数
        /// </summary>
        /// <param name="val1">浮点数1</param>
        /// <param name="val2">浮点数2</param>
        /// <returns>累加后的浮点数</returns>
        public static decimal addDecimal(object val1, object val2)
        {
            return rui.typeHelper.toDecimal(val1) + rui.typeHelper.toDecimal(val2);
        }

        /// <summary>
        /// 累减浮点数
        /// </summary>
        /// <param name="val1">浮点数1</param>
        /// <param name="val2">浮点数2</param>
        /// <returns>累减后的浮点数</returns>
        public static decimal subDecimal(object val1, object val2)
        {
            return rui.typeHelper.toDecimal(val1) - rui.typeHelper.toDecimal(val2);
        }

        /// <summary>
        /// 数据相除
        /// </summary>
        /// <param name="val1">浮点数1</param>
        /// <param name="val2">浮点数2</param>
        /// <returns>相除的结果,被除数为0则返回0</returns>
        public static decimal divideValue(object val1, object val2)
        {
            if (rui.typeHelper.toDecimal(val2) == 0)
                return 0;
            else
                return rui.typeHelper.toDecimal(val1) / rui.typeHelper.toDecimal(val2);
        }

        /// <summary>
        /// 显示折扣
        /// 大于1显示无折扣
        /// 0.01 显示 1折
        /// 0.1 显示 10折
        /// </summary>
        /// <param name="value">浮点数</param>
        /// <returns></returns>
        public static string show折扣(object value)
        {
            decimal temp = rui.typeHelper.toDecimal(value);
            if (temp >= 1)
                return "无折扣";
            else
                return rui.typeHelper.removeZero(temp * 10, false) + "折";
        }

        /// <summary>
        /// 在数据后边加上“元”代码
        /// 不合法数据返回0元
        /// 10，返回10元
        /// </summary>
        /// <param name="value">数值</param>
        /// <returns></returns>
        public static string get人民币(object value)
        {
            if (value == null || value.ToString() == "")
                return "0元";
            else
                return value.ToString() + "元";
        }

        /// <summary>
        /// 获取元代表的分
        /// 2.01 返回 201分
        /// </summary>
        /// <param name="value">元为单位数值</param>
        /// <returns></returns>
        public static int get人民币分(object value)
        {
            return rui.typeHelper.toInt(rui.typeHelper.va四舍五入(rui.typeHelper.toDecimal(value) * 100, 0));
        }
    }
}
