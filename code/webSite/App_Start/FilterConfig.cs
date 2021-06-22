using System.Web;
using System.Web.Mvc;
using web.Filters;

namespace web
{
    public class FilterConfig
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
            //filters.Add(new HandleExceptionAttribute());
            filters.Add(new NoCacheAttribute());
            filters.Add(new checkLoginAttribute());
        }
    }
}
