<!doctype html>
<#include "../include/imports.ftl">
<@hst.setBundle basename="skeleton,SalesInfoDashboard"/>
<html lang="${.locale?replace("_", "-")}" class="has-sticky-header has-header">
<head>
    <#include "page-title.ftl">
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no">
    <#include "page-metas.ftl">

    <script>
        var sentryEnabled  = <#if sentryActive?? && sentryActive == true>true<#else>false</#if>;
    </script>

    <#if hstRequest.requestContext.channelManagerPreviewRequest>
        <link rel="stylesheet" href="<@hst.webfile  path="/freemarker/versia/css-menu/cms-request.css"/>" type="text/css"/>
    </#if>
    <#include "_base_alternate_links.ftl">
    <link rel="stylesheet" href="<@hst.webfile  path="/freemarker/versia/css-menu/nouislider.min.css"/>" type="text/css"/>
    <link rel="stylesheet" href="<@hst.webfile  path="/freemarker/versia/css-menu/slick.css"/>" type="text/css"/>
    <link rel="stylesheet" href="<@hst.webfile  path="/freemarker/versia/css-menu/slick-theme.css"/>" type="text/css"/>
    <link rel="stylesheet" href="<@hst.webfile  path="/freemarker/versia/css-menu/main.css"/>" type="text/css"/>
    <link rel="stylesheet" href="<@hst.webfile  path="/freemarker/versia/css-menu/components/main-styles.css"/>" type="text/css"/>
    <link rel="stylesheet" href="<@hst.webfile  path="/freemarker/versia/css-menu/components/home/home-styles.css"/>" type="text/css"/>
    <link rel="stylesheet" href="<@hst.webfile  path="/freemarker/versia/css-menu/osudio-main.css"/>" type="text/css"/>
    <link rel="stylesheet" href="<@hst.webfile  path="/freemarker/versia/css-menu/osudio-icons.css"/>" type="text/css"/>
    <link rel="stylesheet" href="<@hst.webfile  path="/freemarker/versia/css-menu/custom_main.css"/>" type="text/css"/>
    <link rel="shortcut icon" href="<@hst.webfile  path="/images/favicon.ico"/>" />
    <link rel="icon" type="image/gif" href="<@hst.webfile  path="/images/favicon.gif"/>" />
    <link rel="stylesheet" href="<@hst.webfile path="/freemarker/versia/css-menu/fontawesome/css/fontawesome.css"/>" type="text/css"/>
    <link rel="stylesheet" href="<@hst.webfile path="/freemarker/versia/css-menu/lks.css"/>" type="text/css" />
    <link rel="stylesheet" href="<@hst.webfile path="/freemarker/versia/css-menu/jquery-ui/jquery-ui.min.css"/>" type="text/css" />
    <link rel="stylesheet" href="<@hst.webfile path="/freemarker/versia/css-menu/jquery-ui/jquery-ui.structure.min.css"/>" type="text/css" />
    <link rel="stylesheet" href="<@hst.webfile path="/freemarker/versia/css-menu/jquery-ui/jquery-ui.theme.min.css"/>" type="text/css" />
    <link rel="stylesheet" href="<@hst.webfile path="/freemarker/versia/css-menu/workplace.css"/>" type="text/css"/>
    <link rel="stylesheet" href="<@hst.webfile path="/freemarker/versia/css-menu/responsive.css"/>" type="text/css"/>
    <link rel="stylesheet" href="<@hst.webfile path="/freemarker/versia/css-menu/components/banner/banner-styles.component.css"/>" type="text/css" />
    <link rel="stylesheet" href="<@hst.webfile path="/freemarker/versia/css-menu/google-fonts.css"/>" type="text/css"/>

    <@hst.include ref="thirdparty-tools"/>
    <@hst.headContributions categoryExcludes="htmlBodyEnd, scripts, scriptsEssential" xhtml=true/>
    <@hst.include ref="cookie-consent"/>
</head>
 <body>
     <!-- statistics -->
     <@hst.include ref="statistics" />
     <!-- END statistics -->

     <header class="main-header" data-swiftype-index='false'>
          <@hst.include ref="header"/>
     </header>
     <div class="main-navigation-outer" data-swiftype-index="false">
        <nav class="main-navigation">
            <@hst.include ref="top-menu"/>
        </nav>
     </div>
     <#include "./language-layer.ftl">

     <link rel="stylesheet" href="<@hst.webfile  path="/freemarker/versia/css-menu/sales-info-dashboard.css"/>" type="text/css"/>
     <#include "salesinfodashboard/sales-info-dashboard-modal.ftl"/>
     <#include "salesinfodashboard/sales-info-dashboard.ftl"/>

     <@hst.include ref="basket-layer"/>
     <@hst.include ref="workplace-layer"/>

     <@hst.include ref="more-info-layer" />

	 <#include "./eshop-apps-layer.ftl">

     <@hst.include ref="favourites-folders-layer"/>
	 <@hst.include ref="partnumber-info-layer"/>

     <@hst.include ref="main"/>
     <footer class="main-footer" data-swiftype-index='false'>
       <@hst.include ref="footer"/>
     </footer>
     <#include "../include/back-to-top.ftl">
     <@hst.headContributions categoryIncludes="scriptsEssential" xhtml=true/>
     <@hst.headContributions categoryIncludes="htmlBodyEnd, scripts" xhtml=true/>
  </body>


</html>