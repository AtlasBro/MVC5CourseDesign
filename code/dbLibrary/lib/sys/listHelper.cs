using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace rui
{
    /// <summary>
    /// 这里只存放与具体表无关的绑定方法，与表有关的放在表的业务类中提供bindDdl方法
    /// 
    /// 存放系统的列表数据，自己增加的增加在listHelperAdd类中
    /// </summary>
    public partial class listHelper
    {
        private static string _是否 = "是,否";
        private static string _性别 = "男,女";
        private static string _审批通过方式 = "单人,多人";
        private static string _模块账户类型 = "前端,后端";

		public static List<SelectListItem> bind是否(bool has请选择 = false, string selectedValues = "")
        {
            return bindValues(_是否, has请选择, selectedValues);
        }
        public static List<SelectListItem> bind性别(bool has请选择 = false, string selectedValues = "")
        {
            return bindValues(_性别, has请选择, selectedValues);
        } 
        public static List<SelectListItem> bind审批通过方式(bool has请选择 = false, string selectedValues = "")
        {
            return bindValues(_审批通过方式, has请选择, selectedValues);
        }
        public static List<SelectListItem> bind模块账户类型(bool has请选择 = false, string selectedValues = "")
        {
            return bindValues(_模块账户类型, has请选择, selectedValues);
        }

        public static List<SelectListItem> bind停靠位置(bool has请选择 = false, object selectedValues = null)
        {
            List<SelectListItem> list = new List<SelectListItem>();
            rui.listHelper.add请选择(list, has请选择);
            Dictionary<string,string> dic = new Dictionary<string,string>();
            dic.Add("no","不停靠");
            dic.Add("left","靠左");
            dic.Add("right","靠右");

            List<string> selectedList = rui.dbTools.getList(rui.typeHelper.toString(selectedValues));
            foreach (var item in dic.Keys)
            {
                if (selectedList.Contains(item))
                    list.Add(new SelectListItem() { Text = dic[item], Value = item, Selected = true });
                else
                    list.Add(new SelectListItem() { Text = dic[item], Value = item, Selected = false });
            }
            return list;
        }

        public static List<SelectListItem> bind对其方式(bool has请选择 = false, object selectedValues = null)
        {
            List<SelectListItem> list = new List<SelectListItem>();
            rui.listHelper.add请选择(list, has请选择);
            Dictionary<string, string> dic = new Dictionary<string, string>();
            dic.Add("left", "居左");
            dic.Add("center", "居中");
            dic.Add("right", "居右");

            List<string> selectedList = rui.dbTools.getList(rui.typeHelper.toString(selectedValues));
            foreach (var item in dic.Keys)
            {
                if (selectedList.Contains(item))
                    list.Add(new SelectListItem() { Text = dic[item], Value = item, Selected = true });
                else
                    list.Add(new SelectListItem() { Text = dic[item], Value = item, Selected = false });
            }
            return list;
        }

        /// <summary>
        /// 绑定Name和Value相同的下拉框
        /// </summary>
        /// <param name="has请选择">是否包含请选择</param>
        /// <param name="values">多个值:合格,不合格</param>
        /// <param name="selectedValues">默认值</param>
        private static List<SelectListItem> bindValues(string values, bool has请选择 = false, string selectedValues = "")
        {
            List<SelectListItem> list = new List<SelectListItem>();
            rui.listHelper.add请选择(list, has请选择);
            List<string> selectedList = rui.dbTools.getList(selectedValues);
            List<string> valueList = rui.dbTools.getList(values);
            foreach (var item in valueList)
            {
                if (selectedList.Contains(item))
                    list.Add(new SelectListItem() { Text = item, Value = item, Selected = true });
                else
                    list.Add(new SelectListItem() { Text = item, Value = item, Selected = false });
            }
            return list;
        }

        /// <summary>
        /// 把DataTable转为List<SelectListItem>
        /// 编码列为Code，名称列为Name
        /// </summary>
        /// <param name="table"></param>
        /// <param name="has请选择"></param>
        /// <param name="selectedValue"></param>
        /// <returns></returns>
        public static List<SelectListItem> dataTableToDdlList(DataTable table, bool has请选择, string selectedValue) {
            List<SelectListItem> list = new List<SelectListItem>();
            rui.listHelper.add请选择(list, has请选择);
            List<string> selectedList = rui.dbTools.getList(selectedValue);
            foreach (DataRow row in table.Rows) {
                if (selectedList.Contains(row["code"].ToString()))
                    list.Add(new SelectListItem() { Text = row["name"].ToString(), Value = row["code"].ToString(), Selected = true });
                else
                    list.Add(new SelectListItem() { Text = row["name"].ToString(), Value = row["code"].ToString() });
            }
            return list;
        }

        /// <summary>
        /// 为下拉项目集合添加请选择
        /// </summary>
        /// <param name="list"></param>
        /// <param name="has请选择"></param>
        public static void add请选择(List<SelectListItem> list, bool has请选择) {
            if (has请选择) {
                SelectListItem item = new SelectListItem() { Text = rui.configHelper.va请选择Text, Value = rui.configHelper.va请选择Value };
                list.Add(item);
            }
        }

        //获取集合中选中的项，拼接成a,b
        public static string getListSelected(List<SelectListItem> list)
        {
            string result = "";
            foreach (var item in list)
            {
                if (item.Selected == true)
                    result += string.Format("{0},", item.Value);
            }
            if (result.Length > 0)
                result = result.Substring(0, result.Length - 1);
            return result;
        }

        //设置集合中项的选中状态,values 按照a,b拼接
        public static void setListSelected(List<SelectListItem> list, string selectedValues)
        {
            if (rui.typeHelper.isNullOrEmpty(selectedValues) == false)
            {
                List<string> selectedList = rui.dbTools.getList(selectedValues);
                if (selectedList.Count > 0)
                {
                    foreach (var item in list)
                    {
                        if (selectedList.Contains(item.Value))
                            item.Selected = true;
                    }
                }
            }
        }


    }
}
