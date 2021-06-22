using LitJson;
using System;
using System.Collections.Generic;
using System.Data;
using System.Text;
using System.Web.Mvc;

namespace rui
{
    /// <summary>
    /// 封装JSON返回结果
    /// </summary>
    public class jsonResult
    {
        /// <summary>
        /// 保存需要返回的所有数据
        /// result 代表请求是否成功
        /// message 代表请求的提示信息
        /// </summary>
        public Dictionary<string, string> data { get; set; }

        /// <summary>
        /// 返回操作消息，Ajax请求时用
        /// </summary>
        /// <param name="message">返回的message键的值</param>
        /// <param name="success">返回的success键的值</param>
        /// <param name="returnDic">附加的其它键值数据</param>
        /// <returns></returns>
        public static Dictionary<string, string> getAJAXResult(string message, bool success,
            Dictionary<string, string> returnDic = null)
        {
            Dictionary<string, string> dic = new Dictionary<string, string>();
            dic.Add("result", success.ToString());

            dic.Add("message", message);
            //附加的返回值
            if (returnDic != null)
            {
                foreach (string key in returnDic.Keys)
                    dic.Add(key, returnDic[key]);
            }
            return dic;
        }

        /// <summary>
        /// 通过rowID的值返回一个Dictionary，数据新增的时候用
        /// </summary>
        /// <param name="rowID">rowID的值</param>
        /// <returns></returns>
        public static Dictionary<string, string> getDicByRowID(object rowID)
        {
            Dictionary<string, string> dic = new Dictionary<string, string>();
            dic.Add("rowID", rowID.ToString());
            return dic;
        }

        /// <summary>
        /// 添加DataTable数据
        /// </summary>
        /// <param name="keyName">键名</param>
        /// <param name="dtData">键值：表格的json字符串值</param>
        public void addTable(string keyName, DataTable dtData)
        {
            if (this.data == null)
                this.data = new Dictionary<string, string>();
            if (this.data.ContainsKey(keyName) == false)
                this.data.Add(keyName, rui.jsonResult.dataTableToJsonStr(dtData));
            else
                this.data[keyName] = rui.jsonResult.dataTableToJsonStr(dtData);
        }

        /// <summary>
        /// 添加key/value数据
        /// </summary>
        /// <param name="keyName">键名</param>
        /// <param name="keyValue">键值</param>
        public void addValue(string keyName, string keyValue)
        {
            if (this.data == null)
                this.data = new Dictionary<string, string>();
            if (this.data.ContainsKey(keyName) == false)
                this.data.Add(keyName, keyValue);
            else
                this.data[keyName] = keyValue;
        }

        /// <summary>
        /// 批量添加键值对
        /// </summary>
        /// <param name="dic">Dictionary对象</param>
        public void addDic(Dictionary<string, string> dic)
        {
            if (dic == null)
                return;
            if (this.data == null)
                this.data = new Dictionary<string, string>();
            foreach (string key in dic.Keys)
                addValue(key, dic[key]);
        }

        /// <summary>
        /// 合并多个Dictionary
        /// </summary>
        /// <param name="dic1">Dictionary对象1</param>
        /// <param name="dic2">Dictionary对象2</param>
        /// <returns></returns>
        public static Dictionary<string, string> mergeDictionary(Dictionary<string, string> dic1,
            Dictionary<string, string> dic2)
        {
            Dictionary<string, string> result = new Dictionary<string, string>();
            //复制来源1
            foreach (string key in dic1.Keys)
            {
                if (result.ContainsKey(key) == false)
                    result.Add(key, dic1[key]);
            }
            //复制来源2
            foreach (string key in dic2.Keys)
            {
                if (result.ContainsKey(key) == false)
                    result.Add(key, dic2[key]);
            }
            return result;
        }

        /// <summary>
        /// 把dataTable 转为 json字符串  下拉框联动用
        /// 必须包含code和Name两个列
        /// </summary>
        /// <param name="table">DataTable对象</param>
        /// <returns></returns>
        public static string dataTableToJsonStr(DataTable table)
        {
            JsonData data = new JsonData();
            foreach (DataRow row in table.Rows)
            {
                JsonData item = new JsonData();
                item["code"] = row["code"].ToString();
                item["name"] = row["name"].ToString();
                data.Add(item);
            }
            return data.ToJson();
        }

        /// <summary>
        /// 把SelectList转换为json字符串  下拉框联动用
        /// </summary>
        /// <param name="list">SelectListItem的集合</param>
        /// <returns></returns>
        public static string SelectListToJsonStr(List<SelectListItem> list)
        {
            JsonData data = new JsonData();
            foreach (var row in list)
            {
                JsonData item = new JsonData();
                item["code"] = row.Value;
                item["name"] = row.Text;
                data.Add(item);
            }
            return data.ToJson();
        }
    }
}
