using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace rui
{

    /// <summary>
    /// 字符串辅助方法
    /// </summary>
    public class stringHelper
    {
        //累加编码
        /// <summary>
        /// 返回下一个可用编码
        /// </summary>
        /// <param name="code">原编码</param>
        /// <param name="NumLength">尾部数字长度</param>
        /// <returns></returns>
        public static string codeNext(string code, int NumLength)
        {
            string subStr = code.Substring(0, code.Length - NumLength);
            int value = Convert.ToInt32(code.Substring(code.Length - NumLength));
            return subStr + (++value).ToString("D" + NumLength.ToString());
        }

        /// <summary>
        /// 取字串
        /// </summary>
        /// <param name="value">母串</param>
        /// <param name="length">子串长度</param>
        /// <returns>返回子串</returns>
        public static string subString(object value, int length)
        {
            if (value.ToString().Length > length)
                return value.ToString().Substring(0, length) + "...";
            else
                return value.ToString();
        }

        /// <summary>
        /// 去除字符串最后一个字符(主要去除后边的拼接符合)
        /// </summary>
        /// <param name="str">字符串值</param>
        /// <returns>返回处理过之后的字符串</returns>
        public static string removeLastChar(string str)
        {
            if (str.Length > 0)
                return str.Substring(0, str.Length - 1);
            else
                return str;
        }

        /// <summary>
        /// 字符串 并集运算
        /// </summary>
        /// <param name="val1"></param>
        /// <param name="val2"></param>
        /// <param name="splitTag"></param>
        /// <returns></returns>
        public static string unionString(string val1, string val2, char splitTag)
        {
            List<string> list1 = rui.dbTools.getList(val1, splitTag);
            List<string> list2 = rui.dbTools.getList(val2, splitTag);
            List<string> list = rui.dbTools.unionList<string>(list1, list2);
            return rui.dbTools.getShowExpression(list1);
        }

        /// <summary>
        /// 字符串 排除元素
        /// </summary>
        /// <param name="val1"></param>
        /// <param name="val2"></param>
        /// <param name="splitTag"></param>
        /// <returns></returns>
        public static string exceptString(string val1, string val2, char splitTag)
        {
            List<string> list1 = rui.dbTools.getList(val1, splitTag);
            List<string> list2 = rui.dbTools.getList(val2, splitTag);
            List<string> list = rui.dbTools.exceptList<string>(list1, list2);
            return rui.dbTools.getShowExpression(list);
        }

        /// <summary>
        /// 全角转半角
        /// </summary>
        /// <param name="input"></param>
        /// <returns></returns>
        public static String ToDBC(String input)
        {
            char[] c = input.ToCharArray();
            for (int i = 0; i < c.Length; i++)
            {
                if (c[i] == 12288)
                {
                    c[i] = (char)32;
                    continue;
                }
                if (c[i] > 65280 && c[i] < 65375)
                    c[i] = (char)(c[i] - 65248);
            }
            return new String(c);
        }
    }
}
