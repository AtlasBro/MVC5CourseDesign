using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace rui.winform
{
    /// <summary>
    /// winForm消息显示和确认
    /// </summary>
    public class alert
    {
        /// <summary>
        /// 显示消息
        /// </summary>
        /// <param name="message">消息内容</param>
        public static void Show(string message)
        {
            MessageBox.Show(message,"请注意",MessageBoxButtons.OK,MessageBoxIcon.Warning);
        }
        /// <summary>
        /// 显示确认框
        /// </summary>
        /// <param name="message">确认框提示内容</param>
        /// <returns>返回确认界面的选择的结果</returns>
        public static DialogResult confirm(string message)
        {
            return MessageBox.Show(message, "请确认？", MessageBoxButtons.OKCancel, MessageBoxIcon.Warning);
        }
    }
}
