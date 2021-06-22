using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace web.Filters
{
    /// <summary>
    /// 默认过滤器扩展
    /// </summary>
    public class ruiModelBinder : DefaultModelBinder
    {
        protected override void SetProperty(ControllerContext controllerContext, 
            ModelBindingContext bindingContext, 
            System.ComponentModel.PropertyDescriptor propertyDescriptor, 
            object value)
        {
            if (value == null && propertyDescriptor.PropertyType == typeof(string))
            {
                value = string.Empty;
            }
            if (value == null && propertyDescriptor.PropertyType == typeof(Nullable<Int32>))
            {
                value = 0;
            }
            if (value == null && propertyDescriptor.PropertyType == typeof(Int32))
            {
                value = 0;
            }
            if (value == null && propertyDescriptor.PropertyType == typeof(Nullable<Int64>))
            {
                value = 0;
            }
            if (value == null && propertyDescriptor.PropertyType == typeof(Int64))
            {
                value = 0;
            }
            if (value == null && propertyDescriptor.PropertyType == typeof(decimal))
            {
                value = 0;
            }
            if (value == null && propertyDescriptor.PropertyType == typeof(Nullable<decimal>))
            {
                value = 0;
            }
            if (value == null && propertyDescriptor.PropertyType == typeof(DateTime))
            {
                value = new DateTime(1800, 1, 1);
            }
            if (value == null && propertyDescriptor.PropertyType == typeof(Nullable<DateTime>))
            {
                value = new DateTime(1800, 1, 1);
            }
            base.SetProperty(controllerContext, bindingContext, propertyDescriptor, value);
        }
    }
}