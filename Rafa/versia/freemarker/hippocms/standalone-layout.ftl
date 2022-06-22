<#include "../include/imports.ftl">
<@hst.setBundle basename="essentials.global,skeleton,SalesInfoDashboard"/>
<#-- @ftlvariable name="editMode" type="java.lang.Boolean"-->
<!doctype html>
<html lang="en">
    <head>
        <#if pagetitle??>
            <title>${pagetitle}</title>
        </#if>
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
        <meta name="format-detection" content="telephone=no">
        <#if hstRequest.requestContext.channelManagerPreviewRequest>
            <link rel="stylesheet" href="<@hst.webfile  path="/freemarker/versia/css-menu/cms-request.css"/>" type="text/css"/>
        </#if>
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
        <link rel="stylesheet" href="<@hst.webfile path="/freemarker/versia/css-menu/lks.css"/>" type="text/css"/>
        <link rel="stylesheet" href="<@hst.webfile path="/freemarker/versia/css-menu/components/ask-smc/ask-smc.component.css"/>" type="text/css"/>

        <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/libs/jquery.min.js"/>"></script>
        <script>
            (function () {
                window.CatTile = {};
                CatTile.addExpandButtons = $.noop;
                CatTile.addMobileEmptyCheck = $.noop;
                CatTile.adaptHeight = $.noop;

            })();
        </script>
        <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/libs/extend/extend.js"/>"></script>

        <@hst.headContribution category="htmlBodyEnd">
            <script src="<@hst.webfile path="/freemarker/versia/js-menu/libs/jquery-ui.min.js"/>" type="text/javascript"></script>
        </@hst.headContribution>
        <@hst.headContribution category="htmlBodyEnd">
            <script src="<@hst.webfile path="/freemarker/versia/js-menu/libs/datepicker_languages.js"/>" type="text/javascript"></script>
        </@hst.headContribution>
        <@hst.headContribution category="htmlBodyEnd">
            <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/popper.min.js"/>"></script>
        </@hst.headContribution>
        <@hst.headContribution category="htmlBodyEnd">
            <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/bootstrap.js"/>"></script>
        </@hst.headContribution>
        <@hst.headContribution category="htmlBodyEnd">
            <script src="<@hst.webfile path="/freemarker/versia/js-menu/components/search/typeahead-module.js"/>"></script>
        </@hst.headContribution>
        <@hst.headContribution category="htmlBodyEnd">
            <script src="<@hst.webfile path="/freemarker/versia/js-menu/components/search/dynamic-pagination.js"/>"></script>
        </@hst.headContribution>
        <@hst.headContribution category="htmlBodyEnd">
            <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/slick.js"/>"></script>
        </@hst.headContribution>
        <@hst.headContribution category="htmlBodyEnd">
            <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/product_catalogue.js"/>"></script>
        </@hst.headContribution>
        <@hst.headContribution category="htmlBodyEnd">
            <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/jquery.waypoints.min.js"/>"></script>
        </@hst.headContribution>
        <@hst.headContribution category="htmlBodyEnd">
            <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/parallax.js"/>"></script>
        </@hst.headContribution>
        <@hst.headContribution category="htmlBodyEnd">
            <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/video/videoYoutube.js"/>"></script>
        </@hst.headContribution>
        <@hst.headContribution category="htmlBodyEnd">
            <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/nouislider.js"/>"></script>
        </@hst.headContribution>
        <@hst.headContribution category="htmlBodyEnd">
            <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/nav_manager.js"/>"></script>
        </@hst.headContribution>
        <@hst.headContribution category="htmlBodyEnd">
            <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/plp.js"/>"></script>
        </@hst.headContribution>
        <@hst.headContribution category="htmlBodyEnd">
            <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/search.js"/>"></script>
        </@hst.headContribution>
        <@hst.headContribution category="htmlBodyEnd">
            <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/category_tile.js"/>"></script>
        </@hst.headContribution>
        <@hst.headContribution category="htmlBodyEnd">
            <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/picturefill.min.js"/>"></script>
        </@hst.headContribution>
        <@hst.headContribution category="htmlBodyEnd">
            <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/ofi.min.js"/>"></script>
        </@hst.headContribution>
        <@hst.headContribution category="htmlBodyEnd">
            <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/main.js"/>"></script>
        </@hst.headContribution>
        <@hst.headContribution category="htmlBodyEnd">
            <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/forms/form-validator.js"/>"></script>
        </@hst.headContribution>
        <@hst.headContribution category="htmlBodyEnd">
            <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/main-custom.js"/>"></script>
        </@hst.headContribution>
        <@hst.headContribution category="htmlBodyEnd">
            <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/js.cookie.js"/>"></script>
        </@hst.headContribution>
        <@hst.headContribution category="htmlBodyEnd">
            <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/basket/basket-layer-functions.js"/>"></script>
        </@hst.headContribution>
        <script>
            // Picture element HTML5 shiv
            document.createElement( "picture" );

            var knockoutTemplates = '<@hst.webfile path="/freemarker/versia/js-menu/knockout/templates/"/>';
        </script>
        <#include "../digitalcatalog/_spinner.ftl">
    </head>
    <body>
        <!-- statistics -->
        <@hst.include ref="statistics" />
        <!-- END statistics -->

        <#include "./language-layer.ftl">

        <link rel="stylesheet" href="<@hst.webfile  path="/freemarker/versia/css-menu/sales-info-dashboard.css"/>" type="text/css"/>
        <#include "salesinfodashboard/sales-info-dashboard-modal.ftl"/>
        <#include "salesinfodashboard/sales-info-dashboard.ftl"/>

        <#include "./eshop-apps-layer.ftl">

        <@hst.include ref="basket-layer"/>
        <@hst.include ref="workplace-layer"/>

        <@hst.include ref="more-info-layer" />
        <#include "./eshop-apps-layer.ftl">

        <@hst.include ref="partnumber-info-layer"/>
        <@hst.include ref="favourites-folders-layer"/>

        <@hst.include ref="content"/>

        <@hst.headContributions categoryIncludes="scriptsEssential" xhtml=true/>
        <@hst.headContributions categoryIncludes="html,empty-layout,htmlHead,htmlBodyEnd,scripts" xhtml=true/>
        <script>
            $(function () {
                FormValidator.init();
            });
        </script>
    </body>
</html>