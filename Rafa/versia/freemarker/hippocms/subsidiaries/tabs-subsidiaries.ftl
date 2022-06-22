<#include "../../include/imports.ftl">

<#assign c=JspTaglibs ["http://java.sun.com/jsp/jstl/core"] >
<@hst.setBundle basename="subsidiaries"/>
<div class="smc-tabs">
    <div class="smc-tabs__head">
        <div class="container">
            <ul>
                 <#if tabs?? && (tabs?size > 0)>
                     <#list tabs?keys as tab>
                        <li class="heading-0a <#if tab?index == defaultTab>smc-tabs__head--active</#if>"><a href="#"><@fmt.message key="${tab}"/></a></li>
                     </#list>
                 <#else>
                    <h3>No tabs defined</h3>
                 </#if>
            </ul>
        </div>
    </div>
    <#list tabs?keys as tab>
        <#assign pageTitle = tab>
        <#assign pageUrl=baseUrl+tabs[tab]>
        <section class="search-results sub_container">
            <div class="smc-tabs__body search-result-item simple-collapse simple-collapse--mobileOnly <#if tab?index == defaultTab>smc-tabs__body--active</#if>">
                <div class="simple-collapse__head">
                    <h2 class="heading-06 heading-semi-light"><@fmt.message key="${tab}"/></h2>
                </div>
                <div class="simple-collapse__body">
                    <div class="simple-collapse__bodyInner">
                        <@c.import url=pageUrl />
                    </div>
                </div>
            </div>
        </section>
    </#list>
</div>