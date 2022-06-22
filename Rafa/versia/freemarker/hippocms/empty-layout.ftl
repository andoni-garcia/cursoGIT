<#include "../include/imports.ftl">
<@hst.setBundle basename="essentials.global,skeleton"/>
<#-- @ftlvariable name="editMode" type="java.lang.Boolean"-->
<#if editMode>
    <!doctype html>
    <html lang="en">
        <head>
            <#if pagetitle??>
                <title>${pagetitle}</title>
            </#if>
            <meta charset="utf-8"/>
            <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
            <meta name="format-detection" content="telephone=no">
            <#include "page-metas.ftl">

            <#if hstRequest.requestContext.channelManagerPreviewRequest>
                <link rel="stylesheet" href="<@hst.webfile  path="/freemarker/versia/css-menu/cms-request.css"/>" type="text/css"/>
            </#if>
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

            <@hst.headContribution category="empty-layout">
                <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/libs/jquery.min.js"/>"></script>
            </@hst.headContribution>
            <@hst.headContribution category="empty-layout">
                <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/forms/form-validator.js"/>"></script>
            </@hst.headContribution>
            <@hst.headContribution category="empty-layout">
                <script>
                    $(function () {
                        FormValidator.init();
                    });
                </script>
            </@hst.headContribution>
        </head>
        <body>
            <!-- statistics -->
                <@hst.include ref="statistics" />
            <!-- END statistics -->

            <div class="container">
                <@hst.include ref="content"/>
            </div>

            <@hst.headContributions categoryIncludes="html" xhtml=true/>
        </body>
    </html>
<#else >
    <@hst.include ref="content"/>
</#if>