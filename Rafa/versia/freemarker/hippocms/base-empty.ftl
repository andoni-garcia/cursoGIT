<!doctype html>
<#include "../include/imports.ftl">
<@hst.setBundle basename="skeleton"/>
<html lang="${.locale?replace("_", "-")}" class="has-sticky-header has-header">
<head>
    <#include "page-title.ftl">
    <meta charset="utf-8"/>
    <meta http-equiv='Content-Type' content='text/html; charset=UTF-8' />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no">
    <#include "page-metas.ftl">

    <!-- metas -->
    <@hst.headContributions categoryIncludes="swiftypeMeta"/>
    <!-- End metas -->

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
    <link rel="stylesheet" href="<@hst.webfile path="/freemarker/versia/css-menu/google-fonts.css"/>" type="text/css"/>

    <@hst.include ref="thirdparty-tools"/>
    <@hst.headContributions categoryExcludes="htmlBodyEnd, scripts, scriptsEssential, swiftypeMeta" xhtml=true/>
    <@hst.include ref="cookie-consent"/>
</head>
<body>

<@hst.include ref="main"/>

<@hst.headContributions categoryIncludes="scriptsEssential" xhtml=true/>
<@hst.headContributions categoryIncludes="htmlBodyEnd, scripts" xhtml=true/>
</body>


</html>