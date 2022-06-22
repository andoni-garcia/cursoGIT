<#ftl encoding="UTF-8">

<#include "../../include/imports.ftl">
<#include "../catalog-macros.ftl">

<link rel="stylesheet" href="<@hst.webfile path="/freemarker/versia/css-menu/components/cad-download/cad-download.component.css"/>" type="text/css"/>

<@hst.setBundle basename="essentials.global,CadDownload"/>
<#assign componentId = .now?long?c + productId>

<div id="${componentId}" class="cad-download-component ${deviceInfo.deviceType?lower_case}">
    <input id = "product_seriesAttrValue" class="hidden" value = "${statisticsSeries}" />
    <form method="POST" action="<@hst.resourceURL resourceId='getCadFile'/>" class="">
        <div class="header row">
            <div class="col-lg-12 text-wrap">
                <p><@fmt.message key="caddownload.selectyourformat"/></p>
                <p><@fmt.message key="caddownload.yourcadformat"/>: <strong class="cad-download-format-js">--</strong></p>
                <p class="alert-text" style="display: none"><@fmt.message key="caddownload.alertformat"/></p>
                <div class="hidden cad-download-error"><p id = "cad-download-error-message" style="color:#D20000"><@fmt.message key="caddownload.alertError"/></p></div>
            </div>
        </div>

        <div id="cad-download-body" class="body ${(deviceInfo.deviceType == "DESKTOP")?then('row', '')}">
            <div class="format-2d-container col-lg-6 col-md-6 col-sm-6 col-xs-12">
                <div id="format-2d-heading" class="collapsed" data-toggle="${(deviceInfo.deviceType == "PHONE" || deviceInfo.deviceType == "TABLET")?then('collapse', '')}" data-target="#format-2d-list" aria-expanded="false" aria-controls="format-2d-list">
                    <span><@fmt.message key="caddownload.2dformats" /></span>
                    <i class="fa" aria-hidden="true"></i>
                </div>

                <div id="format-2d-list" class="cad-download-format-list collapse ${(deviceInfo.deviceType == "DESKTOP")?then('show', '')}" aria-labelledby="format-2d-heading" data-parent="#cad-download-body">
                <#list cadOptions.getType2d() as format>
                    <div class="form-check">
                        <input class="form-check-input cad-format-option-js" type="radio" name="format"
                               id="format_${format.getKey()}" value="${format.getKey()}" data-label="${format.getValue()}">
                        <label class="form-check-label" for="format_${format.getKey()}">
                            ${format.getValue()}
                        </label>
                    </div>
                </#list>
                </div>
            </div>

            <div class="format-3d-container col-lg-6 col-md-6 col-sm-6 col-xs-12">
                <p id="format-3d-heading" class="collapsed" data-toggle="${(deviceInfo.deviceType == "PHONE" || deviceInfo.deviceType == "TABLET")?then('collapse', '')}" data-target="#format-3d-list" aria-expanded="false" aria-controls="format-3d-list">
                    <@fmt.message key="caddownload.3dformats" />
                    <i class="fa" aria-hidden="true"></i>
                </p>

                <div id="format-3d-list" class="cad-download-format-list collapse ${(deviceInfo.deviceType == "DESKTOP")?then('show', '')}" aria-labelledby="format-3d-heading" data-parent="#cad-download-body">
                <#list cadOptions.getType3d() as format>
                    <div class="form-check">
                        <input class="form-check-input cad-format-option-js" type="radio" name="format"
                               id="format_${format.getKey()}" value="${format.getKey()}" data-label="${format.getValue()}">
                        <label class="form-check-label" for="format_${format.getKey()}">
                            ${format.getValue()}
                        </label>
                    </div>
                </#list>
                </div>
            </div>
        </div>

        <footer class="footer">
            <div class="text-right">
                <button class="btn btn-primary cad-download-btn cad-download-btn-js" aria-label="<@fmt.message key="caddownload.download"/>"
                        smc-statistic-action="DOWNLOAD FILE" smc-statistic-source="${source}" smc-statistic-data3="CAD FILE">
                    <div class="loading-container loading-container-js"></div>
                    <span class="faicon fas fa-download fa-sm" aria-hidden="true"></span> <span><@fmt.message key="caddownload.download"/></span>
                </button>
            </div>
        </footer>

        <button type="submit" id="cad-download-submit-btn" class="hidden" aria-label="Submit" />
    </form>
</div>

<div class="hidden" data-swiftype-index='false'>
    <a id="downloadCadFileLink" href="<@hst.resourceURL resourceId='downloadCadFile'/>"></a>
</div>

<script type="text/javascript">
    var smc = window.smc || {};
    smc.cadDownloadComponent = smc.cadDownloadComponent || {};

    (function createFormats() {
        var formats = {};
    <#list cadOptions.getType2d() as format>
        formats['${format.getKey()}'] = '${format.getValue()}';
    </#list>
    <#list cadOptions.getType3d() as format>
        formats['${format.getKey()}'] = '${format.getValue()}';
    </#list>
        smc.cadDownloadComponent.formats = formats;
    })();
</script>

<script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/components/product-page/cookie-consent.component.js"/>"></script>
<script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/components/cad-download/cad-download.component.js"/>"></script>

<script>
    $(function() {
        //Clean the params of the Hippo generated URL
        var downloadCadFileUrl = new URL(document.getElementById('downloadCadFileLink').href);
        downloadCadFileUrl.searchParams.delete('productId');
        downloadCadFileUrl.searchParams.delete('partNumber');
        downloadCadFileUrl.searchParams.delete('rodEndConf');

        smc.cadDownloadComponent.urls = {
            downloadCadFile: downloadCadFileUrl.href
        };

        var CookieConsentComponent = window.smc.CookieConsentComponent;
        var cookieConsentComponent = new CookieConsentComponent();
        cookieConsentComponent.init();

        var CadDownloadComponent = window.smc.CadDownloadComponent;
        var config = {
            id: ${componentId},
            container: $('#${componentId}'),
            productId: '${productId}',
            partNumber: '${partNumber}' || '',
            rodEndConf: '${rodEndConf}' || '',
            cookieConsentComponent: cookieConsentComponent
        };
        var cadDownloadComponent = new CadDownloadComponent(config);
        cadDownloadComponent.init();
    });
</script>
