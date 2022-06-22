<#include "../../include/imports.ftl">
<#include "imports.ftl">

<#if facets??>
    <@hst.setBundle basename="success-stories.list"/>
    <@fmt.message var="statusApproved" key="sstories.status.approved" />
    <@fmt.message var="statusNotapproved" key="sstories.status.notapproved" />

    <div class="row">
        <div class="col-12">
            <div class="mb-4">
                <#list facets.folders as facet>
                    <#if facet?index == 0 && !isSuccessStoryAdmin>
                    <#else>
                        <#if facet.folders?? && facet.folders?has_content>
                            <label class="smc-select mr-2 w-auto-md-up">
                                <select class="facet-select">
                                    <option class="first-option" value="">
                                        <@fmt.message key="${facet.name}"/>
                                    </option>
                                    <#list facet.folders as value>
                                        <#assign facetName><@fmt.message key="facet.label.${value.name}" /></#assign>
                                        <#switch value.name>
                                            <#case 'true'>
                                                <#assign valueName = statusApproved>
                                                <#break>
                                            <#case 'false'>
                                                <#assign valueName = statusNotapproved>
                                                <#break>
                                            <#default>
                                                <#assign valueName = value.name>
                                        </#switch>
                                        <#if value.count &gt; 0>
                                            <#if value.leaf>
                                                <@hst.facetnavigationlink var="removeLink" remove=value current=facets />
                                                <option class="remove-option" selected
                                                        value="${cleanLinkUrl(removeLink)}">${facetName?contains("???")?then(valueName, facetName)}
                                                    &nbsp;(${value.count})
                                                </option>
                                            <#else>
                                                <@hst.link var="facetLink" hippobean=value navigationStateful=true/>
                                                <option value="${cleanLinkUrl(facetLink)}">${facetName?contains("???")?then(valueName, facetName)}
                                                    &nbsp;(${value.count})
                                                </option>
                                            </#if>
                                        </#if>
                                    </#list>
                                </select>
                            </label>
                        </#if>
                    </#if>
                </#list>
            </div>
        </div>
    </div>
</#if>

<#function cleanLinkUrl facetLink>
    <#if !facetLink?contains("en-eu")>
        <#return facetLink?replace("/success-stories", "/${locale}/success-stories")>
    <#else>
        <#return facetLink>
    </#if>
    <#return facetLink>
</#function>