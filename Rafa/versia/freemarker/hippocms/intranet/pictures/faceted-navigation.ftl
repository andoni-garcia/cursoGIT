<#include "../../../include/imports.ftl">

<#compress>
    <@hst.setBundle basename="intranet-pictures"/>
</#compress>

<#if facets??>
    <div class="row">
        <div class="col-12">
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
                                                <#if indexList[value.name]??>
                                                    ${indexList[value.name]} &nbsp;(${value.count})
                                                <#else>
                                                    ${value.name} &nbsp;(${value.count})
                                                </#if>
                                            </option>
                                        <#else>
                                            <@hst.link var="facetLink" hippobean=value navigationStateful=true/>
                                            <option value="${facetLink}">
                                                <#if indexList[value.name]??>
                                                    ${indexList[value.name]} &nbsp;(${value.count})
                                                <#else>
                                                    ${value.name} &nbsp;(${value.count})
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
    </div>
</#if>
<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/lister&detail-pages.js"/>"></script>
</@hst.headContribution>