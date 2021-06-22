using System.Web;
using System.Web.Optimization;

namespace web
{
    public class BundleConfig
    {
        // 有关捆绑的详细信息，请访问 https://go.microsoft.com/fwlink/?LinkId=301862
        public static void RegisterBundles(BundleCollection bundles)
        {
            ////jquery
            //bundles.Add(new ScriptBundle("~/jquery").Include(
            //            "~/content/scripts/jquery-1.12.4.js"));

            ////jquery val
            //bundles.Add(new ScriptBundle("~/jqueryval").Include(
            //            "~/content/scripts/jquery.validate-vsdoc.js",
            //            "~/content/scripts/jquery.validate.js",
            //            "~/content/scripts/jquery.validate.message.js",
            //            "~/content/scripts/jquery.validate.unobtrusive.js",
            //            "~/content/scripts/jquery.unobtrusive-ajax.js",
            //            "~/content/scripts/jquery.metadata.js"));

            //html5+css3功能检测
            // 使用要用于开发和学习的 Modernizr 的开发版本。然后，当你做好
            // 生产准备就绪，请使用 https://modernizr.com 上的生成工具仅选择所需的测试。
            bundles.Add(new ScriptBundle("~/modernizr").Include(
                        "~/content/scripts/modernizr-2.5.3.js"));

            ////easyUI
            //bundles.Add(new StyleBundle("~/easyui/css").Include(
            //    "~/content/easyui/icon.css",
            //    "~/content/easyui/bootstrap/easyui.css"));
            //bundles.Add(new ScriptBundle("~/easyui/js").Include(
            //    "~/content/easyui/jquery.easyui.js"));

            ////ruiJS
            //bundles.Add(new ScriptBundle("~/ruiJS").Include(
            //    "~/content/scripts/rui.tools.js",
            //    "~/content/fontawesome/rui.button.js",
            //    "~/content/scripts/rui.modelDialog.js",
            //    "~/content/scripts/rui.dropDownList.js",
            //    "~/content/scripts/rui.bill.js",
            //    "~/content/scripts/rui.cbxMulSelected.js",
            //    "~/content/scripts/rui.table_rui.js",
            //    "~/content/scripts/rui.table_lay.js",
            //    "~/content/scripts/rui.table.js",
            //    "~/content/scripts/rui.pager.js",
            //    "~/content/scripts/rui.layout.js"
            //    ));
        }
    }
}
