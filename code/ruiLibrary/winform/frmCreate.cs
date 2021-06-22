using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Reflection;

namespace rui.winform
{
    //通过单例的方式创建窗体对象
    /// <summary>
    /// 
    /// </summary>
    /// <typeparam name="T"></typeparam>
    public class frmCreate<T> where T : Form, new()
    {
        private static T instance;
        /// <summary>
        /// 创建窗体
        /// </summary>
        /// <param name="mdi"></param>
        /// <returns></returns>
        public static T createFrom(Form mdi)
        {
            if (instance == null || instance.IsDisposed)
            {
                instance = new T();
                instance.StartPosition = FormStartPosition.CenterScreen;
                instance.MdiParent = mdi;
                instance.Show();
            }
            instance.WindowState = FormWindowState.Normal;
            return instance;
        }
    }
    /// <summary>
    /// 
    /// </summary>
    public class frmAssist
    {
        /// <summary>
        /// 
        /// </summary>
        /// <param name="mdi"></param>
        /// <param name="frmName"></param>
        /// <returns></returns>
        public static Form createForm(Form mdi, string frmName)
        {
            //判断对此窗体的权限

            string className = frmName.Substring(frmName.IndexOf(".") + 1);
            //保证单例问题
            foreach (Form frm in Application.OpenForms)
            {
                if (frm.Name == className)
                {
                    frm.WindowState = FormWindowState.Normal;
                    frm.BringToFront();
                    return frm;
                }
            }

            Assembly assembly = Assembly.GetExecutingAssembly();
            Form instance = assembly.CreateInstance("珠宝加工管理系统." + frmName) as Form;
            instance.StartPosition = FormStartPosition.CenterScreen;
            instance.MaximizeBox = false;
            instance.FormBorderStyle = FormBorderStyle.FixedSingle;
            instance.MdiParent = mdi;
            instance.Show();
            return instance;
        }
    }
}
