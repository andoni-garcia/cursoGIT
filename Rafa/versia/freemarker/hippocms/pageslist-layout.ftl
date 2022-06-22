<#include "../include/imports.ftl">
<@hst.setBundle basename="skeleton"/>

<#-- @ftlvariable name="editMode" type="java.lang.Boolean"-->
<#if editMode>
    <!doctype html>
    <html lang="en">
        <head>
            <#if pagetitle??>
                <title>${pagetitle}</title>
            </#if>
            <meta charset="utf-8"/>
            <link rel="stylesheet" href="<@hst.webfile path="/freemarker/versia/css-menu/google-fonts.css"/>" type="text/css"/>
            <link rel="stylesheet" href="https://file.myfontastic.com/8nEKk7XDEzbBRei96cKcwS/icons.css" type="text/css"/>
            <#if hstRequest.requestContext.channelManagerPreviewRequest>
                <link rel="stylesheet" href="<@hst.webfile  path="/freemarker/versia/css-menu/cms-request.css"/>" type="text/css"/>
            </#if>
            <link rel="stylesheet" href="<@hst.webfile  path="/freemarker/versia/css-menu/main.css"/>" type="text/css"/>
            <link rel="stylesheet" href="<@hst.webfile  path="/freemarker/versia/css-menu/components/home/home-styles.css"/>" type="text/css"/>
            <link rel="stylesheet" href="<@hst.webfile  path="/freemarker/versia/css-menu/components/main-styles.css"/>" type="text/css"/>
            <link rel="stylesheet" href="<@hst.webfile  path="/freemarker/versia/css-menu/nouislider.min.css"/>" type="text/css"/>
            <link rel="stylesheet" href="<@hst.webfile  path="/freemarker/versia/css-menu/slick.css"/>" type="text/css"/>
            <link rel="stylesheet" href="<@hst.webfile  path="/freemarker/versia/css-menu/slick-theme.css"/>" type="text/css"/>
            <@hst.headContributions categoryExcludes="htmlBodyEnd, scripts, scriptsEssential" xhtml=true/>
        </head>
        <body>
            <h1>Children pages</h1>
            <div class="container">
                <ul>
                    <#list pages as pagelink>
                        <li><a href="<@hst.link link=pagelink />">${pagelink.hstSiteMapItem.pageTitle}</a></li>
                    </#list>
                </ul>

                <div>
                    <p><i>This page is not visible publicly.</i></p>
                </div>
            </div>
        </body>
    </html>
</#if>