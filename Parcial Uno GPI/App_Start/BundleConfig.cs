using System.Web;
using System.Web.Optimization;

namespace Parcial_Uno_GPI
{
    public class BundleConfig
    {
        // For more information on bundling, visit https://go.microsoft.com/fwlink/?LinkId=301862
        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new ScriptBundle("~/bundles/jquery").Include(
                        "~/Scripts/bootstrap.bundle.min.js",
                        "~/Scripts/jquery.validate*",
                        "~/Scripts/main.js"));

            bundles.Add(new ScriptBundle("~/bundles/mensaje").Include(
                        "~/Scripts/jquery-3.6.0.min.js",
                        "~/Scripts/sweetalert2.min.js",
                        "~/Scripts/alerts.js"));

            // Use the development version of Modernizr to develop with and learn from. Then, when you're
            // ready for production, use the build tool at https://modernizr.com to pick only the tests you need.
            bundles.Add(new ScriptBundle("~/bundles/modernizr").Include(
                        "~/Scripts/modernizr-*"));

            bundles.Add(new StyleBundle("~/bundles/login").Include(
                      "~/Content/login.css"));

            bundles.Add(new StyleBundle("~/Content/estilos").Include(
                      "~/Content/all.css",
                      "~/Content/bootstrap.min.css",
                      "~/Content/dark.css",
                      "~/Content/estilos.css"));
        }
    }
}
