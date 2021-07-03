using System.Web.Mvc;

namespace web.Areas.onlineSell
{
    public class onlineSellAreaRegistration : AreaRegistration 
    {
        public override string AreaName 
        {
            get 
            {
                return "onlineSell";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context) 
        {
            context.MapRoute(
                "onlineSell_default",
                "onlineSell/{controller}/{action}/{id}",
                new { action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}