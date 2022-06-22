<@hst.link var="communicationimageslistmaintext" siteMapItemRefId="communicationimageslistmaintext" fullyQualified=true />
<#-- @ftlvariable name="cparam" type="com.smc.hippocms.components.intranet.communicationimages.CommunicationImagesListComponent" -->

<#macro dashboardCI location>
    <#if location == "list">
        <#-- Download documents -->
        <#if cparam.showExport>
            <div class="row my-5 dashboard-user">
                <div class="row m-3 w-100">
                    <div class="col-md-6">
                        <div><button type="button" onclick="exportCI()" class="heading-09"><i class="fas fa-download"></i><@fmt.message key="ci.button.download"/></button></div>
                    </div>
                </div>
            </div>
        </#if>
    </#if>

    <#if location == "detail">
        <div class="row my-5 dashboard-user">
            <div class="row m-3 w-100">
                <div class="col-md-6">
                    <div><a href="javascript:history.back()" class="heading-09"><i class="fas fa-reply"></i><@fmt.message key="ci_detail.summarypage"/></a></div>
                    <div class="mt-2">
                        <div><a href="${communicationimageslistmaintext}" class="heading-09"><i class="fas fa-arrow-up"></i><@fmt.message key="ci_detail.mainpage"/></a></div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div><a href="${renderActionUrl(baseUrl, 'back')}" class="heading-09"><i class="fas fa-arrow-left"></i><@fmt.message key="ci_detail.previousItem"/></a></div>
                </div>
                <div class="col-md-3">
                    <div><a href="${renderActionUrl(baseUrl, 'next')}" class="heading-09"><i class="fas fa-arrow-right"></i><@fmt.message key="ci_detail.nextItem"/></a></div>
                </div>
            </div>
        </div>
    </#if>


</#macro>