using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Web;
using System.Web.Mvc;
using rui;

namespace System.Web.Mvc.Html
{
    /// <summary>
    /// HTML辅助方法的扩展
    /// </summary>
    public static class HtmlExtensions
    {
        /// <summary>
        /// 日期录入文本框 
        /// </summary>
        /// <typeparam name="TModel"></typeparam>
        /// <typeparam name="TProperty"></typeparam>
        /// <param name="helper"></param>
        /// <param name="expression"></param>
        /// <param name="htmlAttributes"></param>
        /// <param name="isLang">是否显示长日期格式</param>
        /// <returns></returns>
        public static MvcHtmlString TextBoxDateFor<TModel, TProperty>(this HtmlHelper<TModel> helper, 
            Expression<Func<TModel, TProperty>> expression, 
            object htmlAttributes = null,bool isLang = false)
        {
            ModelMetadata metadata = ModelMetadata.FromLambdaExpression(expression, helper.ViewData);
            return TextBoxDate(helper, ExpressionHelper.GetExpressionText((LambdaExpression)expression), metadata.Model, htmlAttributes);
        }

        /// <summary>
        /// 日期录入文本框
        /// </summary>
        /// <param name="helper"></param>
        /// <param name="name"></param>
        /// <param name="value"></param>
        /// <param name="htmlAttributes"></param>
        /// <param name="isLang">是否显示长日期格式</param>
        /// <returns></returns>
        public static MvcHtmlString TextBoxDate(this HtmlHelper helper, 
            string name, 
            object value, 
            object htmlAttributes = null,bool isLang=false)
        {
            //获取传入的htmlAttributes信息
            IDictionary<string, object> HtmlAttributes = HtmlHelper.AnonymousObjectToHtmlAttributes(htmlAttributes);
            //构建checkbox属性
            HtmlAttributes.Add("type", "text");
            HtmlAttributes.Add("name", string.Format("{0}", name));
            HtmlAttributes.Add("onfocus", "WdatePicker()");
            HtmlAttributes.Add("value", rui.typeHelper.toDateTimeString(value, isLang));

            TagBuilder tagBuilder = new TagBuilder("input");
            tagBuilder.MergeAttributes<string, object>(HtmlAttributes);
            string inputAllHtml = tagBuilder.ToString(TagRenderMode.SelfClosing);
            return MvcHtmlString.Create(inputAllHtml);
        }

        /// <summary>
        /// 显示日期字段值
        /// </summary>
        /// <typeparam name="TModel"></typeparam>
        /// <typeparam name="TValue"></typeparam>
        /// <param name="helper"></param>
        /// <param name="expression"></param>
        /// <param name="isLang">是否长日期格式</param>
        /// <returns></returns>
        public static MvcHtmlString DisplayDateFor<TModel, TValue>(this HtmlHelper<TModel> helper, 
            Expression<Func<TModel, TValue>> expression,
            bool isLang=false)
        {
            string dateFormat = rui.configHelper.dateFormat;
            if (isLang)
                dateFormat = rui.configHelper.dateFormatLang;

            var metadata = ModelMetadata.FromLambdaExpression(expression, helper.ViewData);
            //DateTime类型
            if (typeof(TValue) == typeof(DateTime))
            {
                if (metadata.ModelType == typeof(DateTime))
                {
                    DateTime dt = (DateTime)metadata.Model;
                    return MvcHtmlString.Create(dt.ToString(dateFormat));
                }
                return MvcHtmlString.Create("Oops,not a DateTime");
            }
            //DateTime?类型
            else if (typeof(TValue) == typeof(DateTime?))
            {
                if (metadata.ModelType == typeof(DateTime?))
                {
                    if (metadata.Model == null)
                        return MvcHtmlString.Create("");
                    else
                    {
                        DateTime dt = Convert.ToDateTime(metadata.Model);
                        return MvcHtmlString.Create(dt.ToString(dateFormat));
                    }
                }
                return MvcHtmlString.Create("Oops,not a DateTime");
            }
            else
            {
                return MvcHtmlString.Create("Oops,not a DateTime");
            }
        }

        /// <summary>
        /// 展示图片
        /// </summary>
        /// <typeparam name="TModel"></typeparam>
        /// <typeparam name="TValue"></typeparam>
        /// <param name="helper"></param>
        /// <param name="expression"></param>
        /// <param name="noImgShow">无图片展示的文本提示</param>
        /// <param name="htmlAttributes"></param>
        /// <returns></returns>
        public static MvcHtmlString DisplayImgFor<TModel, TValue>(this HtmlHelper<TModel> helper,
            Expression<Func<TModel, TValue>> expression, string noImgShow= "无图片", object htmlAttributes = null)
        {
            IDictionary<string, object> HtmlAttributes = HtmlHelper.AnonymousObjectToHtmlAttributes(htmlAttributes);
            var metadata = ModelMetadata.FromLambdaExpression(expression, helper.ViewData);
            if (rui.typeHelper.isNotNullOrEmpty(metadata.Model))
            {
                TagBuilder tagBuilder = new TagBuilder("img");
                tagBuilder.MergeAttributes<string, object>(HtmlAttributes);
                HtmlAttributes.Add("src", metadata.Model);
                string inputAllHtml = tagBuilder.ToString(TagRenderMode.SelfClosing);
                return MvcHtmlString.Create(inputAllHtml);
            }
            else
            {
                return MvcHtmlString.Create(noImgShow);
            }
        }

        /// <summary>
        /// 多选下拉框
        /// </summary>
        /// <typeparam name="TModel"></typeparam>
        /// <typeparam name="TProperty"></typeparam>
        /// <param name="helper"></param>
        /// <param name="expression"></param>
        /// <param name="selectList"></param>
        /// <param name="htmlAttributes"></param>
        /// <returns></returns>
        public static MvcHtmlString DropDownListMulFor<TModel, TProperty>(this HtmlHelper<TModel> helper, 
            Expression<Func<TModel, TProperty>> expression, 
            IEnumerable<SelectListItem> selectList, 
            object htmlAttributes = null)
        {
            string name = ExpressionHelper.GetExpressionText((LambdaExpression)expression);
            ModelMetadata metadata = ModelMetadata.FromLambdaExpression(expression, helper.ViewData);
            return DropDownListMul(helper, name, selectList, metadata.Model, htmlAttributes);
        }

        /// <summary>
        /// 多选下拉框
        /// </summary>
        /// <param name="helper"></param>
        /// <param name="name"></param>
        /// <param name="selectList"></param>
        /// <param name="value">选中值,分割</param>
        /// <param name="htmlAttributes"></param>
        /// <returns></returns>
        public static MvcHtmlString DropDownListMul(this HtmlHelper helper, 
            string name, 
            IEnumerable<SelectListItem> selectList,
            object value, 
            object htmlAttributes = null)
        {
            StringBuilder stringBuilder = new StringBuilder();
            //select属性
            IDictionary<string, object> selectTagAttributes = HtmlHelper.AnonymousObjectToHtmlAttributes(htmlAttributes);
            selectTagAttributes.Add("name", name);
            selectTagAttributes.Add("multiple", "multiple");
            //select标记，并附加属性
            TagBuilder selectTag = new TagBuilder("select");
            selectTag.MergeAttributes<string, object>(selectTagAttributes);

            //添加select开始标记
            stringBuilder.Append(selectTag.ToString(TagRenderMode.StartTag));
            List<string> selectedList = rui.dbTools.getList(rui.typeHelper.toString(value));
            //添加option标记
            foreach (var item in selectList)
            {
                IDictionary<string, object> optionTagAttributes = new Dictionary<string, object>();
                optionTagAttributes.Add("value", item.Value);
                if (selectedList.Contains(item.Value))
                    optionTagAttributes.Add("selected", "selected");
                TagBuilder optionTag = new TagBuilder("option");
                optionTag.MergeAttributes<string, object>(optionTagAttributes);

                stringBuilder.Append(optionTag.ToString(TagRenderMode.StartTag));
                stringBuilder.Append(item.Text);
                stringBuilder.Append(optionTag.ToString(TagRenderMode.EndTag));
            }
            //添加select结束标记
            stringBuilder.Append(selectTag.ToString(TagRenderMode.EndTag));
            return MvcHtmlString.Create(stringBuilder.ToString());
        }

        /// <summary>
        /// 单选列表
        /// </summary>
        /// <typeparam name="TModel"></typeparam>
        /// <typeparam name="TProperty"></typeparam>
        /// <param name="helper"></param>
        /// <param name="expression"></param>
        /// <param name="selectList"></param>
        /// <param name="htmlAttributes"></param>
        /// <param name="isHorizon"></param>
        /// <returns></returns>
        public static MvcHtmlString RadioButtonListFor<TModel, TProperty>(this HtmlHelper<TModel> helper,
            Expression<Func<TModel, TProperty>> expression, 
            IEnumerable<SelectListItem> selectList, 
            object htmlAttributes = null, 
            bool isHorizon = true)
        {
            ModelMetadata metadata = ModelMetadata.FromLambdaExpression(expression, helper.ViewData);
            string name = ExpressionHelper.GetExpressionText((LambdaExpression)expression);
            if (metadata.Model != null)
            {
                string value = metadata.Model.ToString();
                foreach (SelectListItem item in selectList)
                {
                    if (item.Value == value)
                        item.Selected = true;
                    else
                        item.Selected = false;
                }
            }
            return RadioButtonList(helper, name, selectList, htmlAttributes, isHorizon);
        }

        /// <summary>
        /// 单选列表
        /// </summary>
        /// <param name="helper"></param>
        /// <param name="name"></param>
        /// <param name="selectList"></param>
        /// <param name="htmlAttributes"></param>
        /// <param name="isHorizon"></param>
        /// <returns></returns>
        public static MvcHtmlString RadioButtonList(this HtmlHelper helper, 
            string name, 
            IEnumerable<SelectListItem> selectList, 
            object htmlAttributes = null, 
            bool isHorizon = true)
        {
            StringBuilder stringBuilder = new StringBuilder();
            foreach (SelectListItem selectItem in selectList)
            {
                //获取传入的htmlAttributes信息
                IDictionary<string, object> HtmlAttributes = HtmlHelper.AnonymousObjectToHtmlAttributes(htmlAttributes);
                //构建checkbox属性
                HtmlAttributes.Add("type", "radio");
                HtmlAttributes.Add("id", string.Format("{0}[{1}]", name, selectItem.Value));
                HtmlAttributes.Add("name", string.Format("{0}", name));
                HtmlAttributes.Add("class", "ruiCheckBox");
                HtmlAttributes.Add("value", selectItem.Value);
                if (selectItem.Selected)
                {
                    HtmlAttributes.Add("checked", "checked");
                }
                TagBuilder tagBuilder = new TagBuilder("input");
                tagBuilder.MergeAttributes<string, object>(HtmlAttributes);
                string inputAllHtml = tagBuilder.ToString(TagRenderMode.SelfClosing);
                string containerFormat = isHorizon ? @"<span>{0}{1}</span>&nbsp;&nbsp;" : @"<p><span>{0}{1}</span></p>";
                stringBuilder.AppendFormat(containerFormat, selectItem.Text, inputAllHtml);
            }
            return MvcHtmlString.Create(stringBuilder.ToString());
        }
        
        /// <summary>
        /// 复选列表
        /// </summary>
        /// <typeparam name="TModel"></typeparam>
        /// <typeparam name="TProperty"></typeparam>
        /// <param name="helper"></param>
        /// <param name="expression"></param>
        /// <param name="selectList"></param>
        /// <param name="htmlAttributes"></param>
        /// <param name="isHorizon"></param>
        /// <returns></returns>
        public static MvcHtmlString CheckBoxListFor<TModel, TProperty>(this HtmlHelper<TModel> helper,
            Expression<Func<TModel, TProperty>> expression, 
            IEnumerable<SelectListItem> selectList, 
            object htmlAttributes=null, 
            bool isHorizon = true)
        {
            ModelMetadata metadata = ModelMetadata.FromLambdaExpression(expression, helper.ViewData);
            string name = ExpressionHelper.GetExpressionText((LambdaExpression)expression);
            if (metadata.Model != null)
            {
                string value = metadata.Model.ToString();
                List<string> list = (from a in value.Split(',')
                                     where a.Length > 0
                                     select a).ToList();
                foreach (SelectListItem item in selectList)
                {
                    if (list.Contains(item.Value))
                        item.Selected = true;
                    else
                        item.Selected = false;
                }
            }
            return CheckBoxList(helper, name, selectList, htmlAttributes, isHorizon);
        }

        
        /// <summary>
        /// 复选列表
        /// </summary>
        /// <param name="helper"></param>
        /// <param name="name">标记名称</param>
        /// <param name="selectList">列表项</param>
        /// <param name="htmlAttributes">html属性</param>
        /// <param name="isHorizon">排列方式</param>
        /// <returns></returns>
        public static MvcHtmlString CheckBoxList(this HtmlHelper helper, 
            string name, 
            IEnumerable<SelectListItem> selectList, 
            object htmlAttributes=null, 
            bool isHorizon = true)
        {
            StringBuilder stringBuilder = new StringBuilder();
            foreach (SelectListItem selectItem in selectList)
            {
                //获取传入的htmlAttributes信息
                IDictionary<string, object> HtmlAttributes = HtmlHelper.AnonymousObjectToHtmlAttributes(htmlAttributes);
                //构建checkbox属性
                HtmlAttributes.Add("type", "checkbox");
                HtmlAttributes.Add("id", string.Format("{0}[{1}]", name, selectItem.Value));
                HtmlAttributes.Add("name", string.Format("{0}", name));
                HtmlAttributes.Add("class", "ruiCheckBox");
                HtmlAttributes.Add("value", selectItem.Value);
                if (selectItem.Selected)
                {
                    HtmlAttributes.Add("checked", "checked");
                }
                TagBuilder tagBuilder = new TagBuilder("input");
                tagBuilder.MergeAttributes<string, object>(HtmlAttributes);
                string inputAllHtml = tagBuilder.ToString(TagRenderMode.SelfClosing);
                string containerFormat = isHorizon ? @"<span>{0}{1}</span>" : @"<p><span>{0}{1}</span></p>";
                stringBuilder.AppendFormat(containerFormat, selectItem.Text, inputAllHtml);
            }
            return MvcHtmlString.Create(stringBuilder.ToString());
        }

        //复选框辅助类 - 授权页面用
        /// <summary>
        /// 
        /// </summary>
        /// <param name="helper"></param>
        /// <param name="name">标记名称</param>
        /// <param name="allowOperations">允许出现的项目</param>
        /// <param name="haveOperations">已选中的项目</param>
        /// <param name="allOperations">所有的列表项信息,用来获取操作名称的</param>
        /// <returns></returns>
        public static MvcHtmlString CheckBoxListPriv(this HtmlHelper helper, 
            string name, 
            string allowOperations, 
            string haveOperations, 
            IEnumerable<SelectListItem> allOperations)
        {
            StringBuilder stringBuilder = new StringBuilder();
            List<string> allowList = (from a in allowOperations.Split(',')
                                      where a.Length > 0
                                      select a).ToList();
            List<string> haveList = (from a in haveOperations.Split(',')
                                 where a.Length > 0
                                 select a).ToList();
            foreach (string code in allowList)
            {
                //获取传入的htmlAttributes信息
                IDictionary<string, object> HtmlAttributes = new Dictionary<string, object>();
                //构建checkbox属性
                HtmlAttributes.Add("type", "checkbox");
                HtmlAttributes.Add("name", name);
                HtmlAttributes.Add("class", "ruiCheckBox");
                HtmlAttributes.Add("value", code);
                if (haveList.Contains(code))
                {
                    HtmlAttributes.Add("checked", "checked");
                }
                TagBuilder tagBuilder = new TagBuilder("input");
                tagBuilder.MergeAttributes<string, object>(HtmlAttributes);
                string inputAllHtml = tagBuilder.ToString(TagRenderMode.SelfClosing);
                string containerFormat = string.Format(@"<span>{0}{1}</span>", HtmlExtensions.getNameByCode(allOperations, code), inputAllHtml);
                stringBuilder.Append(containerFormat);
            }
            return MvcHtmlString.Create(stringBuilder.ToString());
        }

        /// <summary>
        /// 在th中根据排序方向生成排序列的展示标记
        /// </summary>
        /// <param name="helper"></param>
        /// <param name="orderField"></param>
        /// <param name="orderWay"></param>
        /// <param name="fieldName"></param>
        /// <returns></returns>
        public static MvcHtmlString orderColumn(this HtmlHelper helper, 
            string orderField, 
            string orderWay, 
            string fieldName)
        {
            StringBuilder stringBuilder = new StringBuilder();
            if (fieldName == orderField)
            {
                IDictionary<string, object> HtmlAttributes = new Dictionary<string, object>();
                HtmlAttributes.Add("height", "10px");
                if (orderWay == "asc")
                    HtmlAttributes.Add("src", "/Content/images/desc.png");
                if (orderWay == "desc")
                    HtmlAttributes.Add("src", "/Content/images/asc.png");

                TagBuilder tagBuilder = new TagBuilder("img");
                tagBuilder.MergeAttributes<string, object>(HtmlAttributes);
                string inputAllHtml = tagBuilder.ToString(TagRenderMode.SelfClosing);
                stringBuilder.Append(inputAllHtml);
            }
            return MvcHtmlString.Create(stringBuilder.ToString());
        }

        //返回列表项中某个Code的Name值
        private static string getNameByCode(IEnumerable<SelectListItem> list, 
            string code)
        {
            string result = "";
            foreach (var item in list)
            {
                if (item.Value == code)
                    return item.Text;
            }
            return result;
        }
    }
}