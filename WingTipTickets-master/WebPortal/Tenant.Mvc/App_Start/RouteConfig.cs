﻿using System.Web.Mvc;
using System.Web.Routing;

namespace Tenant.Mvc
{
    public class RouteConfig
    {
        #region - Public Methods -

        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(
                            name: "Default",
                            url: "{controller}/{action}/{id}",
                            defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional }
                );
        }

        #endregion
    }
}
