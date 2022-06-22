<#include "../../../include/imports.ftl">
<@hst.link var="ci_textList" siteMapItemRefId="communicationimageslistmaintext" fullyQualified=true />
<@hst.link var="ci_imageList" siteMapItemRefId="communicationimageslistmainimages" fullyQualified=true />

<#compress>
    <@hst.setBundle basename="intranet-communication_images"/>
</#compress>

<#if facets??>
    <div class="row">
        <div class="col-md-12 icons_ci-switch d-lg-none">
            <a href="${ci_imageList}" class="heading-09 icons imageIcon"><i class="fas fa-th-large"></i></a>
            <a href="${ci_textList}" class="heading-09 icons textIcon"><i class="fas fa-list"></i></a>
        </div>
        <div class="col-12 col-md-10">
            <div class="mb-4">
                <#list facets.folders as facet>
                    <#if facet.folders?? && facet.folders?has_content>
                        <label class="smc-select mr-2 w-auto-md-up">
                            <select class="facet-select">
                                <option class="first-option" value="">
                                    <@fmt.message key="${facet.name}"/>
                                </option>
                                <#list facet.folders as value>
                                    <#if value.count &gt; 0>
                                        <#if value.leaf>
                                            <@hst.facetnavigationlink var="removeLink" remove=value current=facets />
                                            <option class="remove-option" selected value="${removeLink}">
                                                <#if subsidiaryList[value.name]??>
                                                    ${subsidiaryList[value.name]} &nbsp;(${value.count})
                                                <#elseif productFamilyList[value.name]??>
                                                    ${productFamilyList[value.name]} &nbsp;(${value.count})
                                                <#elseif fileList[value.name]??>
                                                    ${fileList[value.name]} &nbsp;(${value.count})
                                                <#else>
                                                    <#if value.name == "true">
                                                        Yes &nbsp;(${value.count})
                                                    <#elseif value.name == "false">
                                                        No  &nbsp;(${value.count})
                                                    <#else>
                                                        ${value.name} &nbsp;(${value.count})
                                                    </#if>
                                                </#if>
                                            </option>
                                        <#else>
                                            <@hst.link var="facetLink" hippobean=value navigationStateful=true/>
                                            asd ${value.name}
                                            <option value="${facetLink}">
                                                <#if subsidiaryList[value.name]??>
                                                    ${subsidiaryList[value.name]} &nbsp;(${value.count})
                                                <#elseif productFamilyList[value.name]??>
                                                    ${productFamilyList[value.name]} &nbsp;(${value.count})
                                                <#elseif fileList[value.name]??>
                                                    ${fileList[value.name]} &nbsp;(${value.count})
                                                <#else>
                                                    <#if value.name == "true">
                                                        Yes &nbsp;(${value.count})
                                                    <#elseif value.name == "false">
                                                        No  &nbsp;(${value.count})
                                                    <#else>
                                                        ${value.name} &nbsp;(${value.count})a
                                                    </#if>
                                                </#if>
                                            </option>
                                        </#if>
                                    </#if>
                                </#list>
                            </select>
                        </label>
                    </#if>
                </#list>
            </div>
        </div>
        <div class="col-lg-2 icons_ci-switch d-none d-lg-block">
            <a href="${ci_imageList}" class="heading-09 icons imageIcon"><i class="fas fa-th-large"></i></a>
            <a href="${ci_textList}" class="heading-09 icons textIcon"><i class="fas fa-list"></i></a>
        </div>
    </div>
</#if>
<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/lister&detail-pages.js"/>"></script>
</@hst.headContribution>