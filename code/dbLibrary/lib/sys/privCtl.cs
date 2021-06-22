using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;

namespace rui
{
    //权限控制
    public class privCtl
    {
        //判断登录用户能否访问某个资源
        /// <summary>
        /// 首先判断是否需要权限控制
        /// 如果需要权限控制，则判断是否有权限
        /// </summary>
        /// <param name="controller"></param>
        /// <returns></returns>
        public static bool isPriv(string controller)
        {
            string resourceCode = controller;
            //获取所有需要权限控制的资源
            DataTable controlResource = (DataTable)rui.sessionHelper.getValue<DataTable>("admin.resource");
            //判断是否需要权限控制，不需要则返回TRUE，需要则获取用户权限进行判断
            if (controlResource.Select("resourceCode='" + resourceCode + "'").Length > 0)
            {
                //获取用户拥有的所有权限
                DataTable userPrivResource = (DataTable)rui.sessionHelper.getValue<DataTable>("admin.priv");
                //没有权限，则返回False
                if (userPrivResource.Select("resourceCode='" + resourceCode + "'").Length == 0)
                    return false;
            }
            return true;
        }

        //页面操作是否显示 ，用在页面上 data_show=(以前的条件 and 返回值)
        /// <summary>
        /// 首先判断该资源的该操作是否需要权限控制
        /// 需要控制，则判断是否有权限
        /// </summary>
        /// <param name="controller"></param>
        /// <param name="action"></param>
        /// <returns></returns>
        public static bool isPriv(string controller, eOp action)
        {
            return isPriv(controller, action.ToString());
        }

        //页面操作是否显示 ，用在页面上 data_show=(以前的条件 and 返回值)
        public static bool isPriv(string controller, string action)
        {
            string resourceCode = controller;
            //获取所有需要权限控制的资源
            DataTable controlResource = (DataTable)rui.sessionHelper.getValue<DataTable>("admin.resource");
            DataRow[] ctlRows = controlResource.Select("resourceCode='" + resourceCode + "'");
            //资源需要权限控制，则继续判断，否则返回TRUE
            if (ctlRows.Length > 0)
            {
                action = action + ",";
                //操作需要权限控制，则继续判断
                if (ctlRows[0]["haveOperations"].ToString().IndexOf(action, StringComparison.OrdinalIgnoreCase) >= 0)
                {
                    //获取用户拥有的所有权限
                    DataTable userPrivResource = (DataTable)rui.sessionHelper.getValue<DataTable>("admin.priv");

                    DataRow[] rows = userPrivResource.Select("resourceCode='" + resourceCode + "'");
                    //用户没资源权限，则返回False
                    if (rows.Length == 0)
                    {
                        return false;
                    }
                    else
                    {
                        string opPriv = rows[0]["opPriv"].ToString() + ",";
                        //用户有资源权限，但是没操作权限则返回FALSE
                        if (opPriv.IndexOf(action, StringComparison.OrdinalIgnoreCase) < 0)
                            return false;
                    }
                }
            }
            return true;
        }

        //可访问操作
        public enum eOp
        {
            Select,             //查询
            Detail,             //详情
            Insert,             //新增
            Update,             //更新
            Delete,             //删除
            Import,             //导入
            Export,             //导出
            Print,              //打印
            AllowLogin,         //允许登录
            resetPW,            //重置密码
            Priv,               //授权

            AttachUpload,       //附件上传
            AttachDownload,     //附件下载
            AttachDelete,       //附件删除

            BatchSave,          //批量保存
            BatchOp,            //批量操作

            Link,               //关联XXX
            Enable,             //启用
            Disable,            //禁用

            Confirm,            //单据确认
            Cancel,             //单据取消
        }
    }
}
