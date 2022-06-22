<#include "../include/imports.ftl">
<@hst.setBundle basename="LoadingPage"/>

<!doctype html>
<html lang="en">
    <head>
        <#if pagetitle??>
            <title>${pagetitle}</title>
        </#if>
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
        <meta name="format-detection" content="telephone=no">

        <link rel="stylesheet" href="<@hst.webfile  path="/freemarker/versia/css-menu/main.css"/>" type="text/css"/>
        <link rel="stylesheet" href="<@hst.webfile  path="/freemarker/versia/css-menu/components/main-styles.css"/>" type="text/css"/>
        <link rel="stylesheet" href="<@hst.webfile  path="/freemarker/versia/css-menu/components/home/home-styles.css"/>" type="text/css"/>
        <link rel="shortcut icon" href="<@hst.webfile  path="/images/favicon.ico"/>" />
        <link rel="icon" type="image/gif" href="<@hst.webfile  path="/images/favicon.gif"/>" />
        <link rel="stylesheet" href="<@hst.webfile path="/freemarker/versia/css-menu/spinner.css"/>" type="text/css"/>
        <style>
            body {
                background-color: #EEEEEE;
            }

            .container {
                display: flex;
                align-items: center;
                justify-content: center;
                flex-direction: column;
                height: 100vh;
            }

            .loading-spinner .spinner {
                margin: auto;
            }

            .loaded {
                display: none;
            }
        </style>
    </head>
    <body>
        <div class="container" data-swiftype-index='false'>
            <#if hstRequest.getParameter("cadUrl")?has_content >
                <a id="cad_link" class="hidden" target="_blank" href="${hstRequest.getParameter("cadUrl")}"><@fmt.message key="smartQuotations.here" /></a>
                <div class="loaded">
                    <div class="loading-text center text-center">
                        <h3><@fmt.message key="file.ready" /></h3>
                    </div>
                </div>
            <#elseif hstRequest.getParameter("datasheetUrl")?has_content >
                <a id="datasheet_link" class="hidden" target="_blank" href="${hstRequest.getParameter("datasheetUrl")}"><@fmt.message key="smartQuotations.here" /></a>
                <div class="loaded">
                    <div class="loading-text center text-center">
                        <h3><@fmt.message key="file.ready" /></h3>
                    </div>
                </div>
            <#else>
                <div class="loading">
                    <div class="cms-component component-render-placeholder loading-spinner">
                        <div class="spinner">
                            <div class="bounce1"></div>
                            <div class="bounce2"></div>
                            <div class="bounce3"></div>
                        </div>
                    </div>
                    <div class="loading-text center text-center">
                        <h3><@fmt.message key="loading.text" /></h3>
                    </div>
                </div>
                <div class="loaded">
                    <div class="loading-text center text-center">
                        <h3><@fmt.message key="file.ready" /></h3>
                    </div>
                </div>
            </#if>
        </div>
    </body>
</html>

<script type="text/javascript">
    $(document).ready(function() {
        if ($("#cad_link") !== undefined && $("#cad_link")[0] !== undefined ){
            $("#cad_link")[0].click();
            $(".loaded").show();
        } else if ($("#datasheet_link") !== undefined && $("#datasheet_link")[0] !== undefined ){
            $("#datasheet_link")[0].click();
            $(".loaded").show();
        }
    });
</script>
