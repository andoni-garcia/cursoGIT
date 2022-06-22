<#include "../../include/imports.ftl">

<#assign c=JspTaglibs ["http://java.sun.com/jsp/jstl/core"] >
<div class="smc-tabs">
    <div class="smc-tabs__head">
        <div class="container" id="tabs">
            <ul>
                 <#if tabs?? && (tabs?size > 0)>
                     <#list tabs?keys as tab>
                        <li class="heading-0a <#if tab?index == defaultTab>smc-tabs__head--active</#if>"><a href="#">${tab}</a></li>
                     </#list>
                     <#if logActions?? && logActions == true>
                        <input type="hidden" id="tabs_logRegisterLink" smc-content-statistic-action="CLICK ON COMPONENT" smc-statistic-source="TAB ELEMENT"/>
                         <script>
                             $(document).ready(function () {
                                 $("#tabs_logRegisterLink").attr("smc-statistic-data1", window.location.href);
                                 $("#tabs a").click(function (e){
                                     $("#tabs_logRegisterLink").attr("smc-statistic-data2", $(e.target).text());
                                     contentlogAction($("#tabs_logRegisterLink"), $("#logActionLink").attr("href"));

                                 });
                             });
                         </script>
                     </#if>
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
                    <h2 class="heading-06 heading-semi-light">${pageTitle}</h2>
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