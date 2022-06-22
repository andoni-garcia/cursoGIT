<#include "../../include/imports.ftl">

<#-- @ftlvariable name="document" type="com.smc.hippocms.beans.Download" -->

<#if document??>
<div class="container">
    <div class="cmseditlink">
           <@hst.manageContent hippobean=document/>
    </div>
    <div class="info-box ">
        <div class="info-box__head">
            <h2 class="heading-07">${document.title}</h2>
        </div>
        <div class="info-box__body text-01" id="${document.getCanonicalHandleUUID()}">
            <#if document.description??>
                <p><@hst.html hippohtml=document.description/></p>
            </#if>
            <ul class="empty-list">
                <#if document.resources?? && document.resources?has_content>
                    <#list document.resources as resource>
                        <#assign title><#if resource.linkCaption?? && resource.linkCaption?length gt 0>${resource.linkCaption}<#else>${resource.internalLink.name}</#if></#assign>
                        <li>
                            <#assign link><@osudio.linkUrl link=resource /></#assign>
                            <a href="${link}" target="_blank" <@osudio.handleFileOpening downloadableFileExtensions link title />  class="iconed-text">
                                <span>${title}</span>
                                <#if resource.icon??><img src="<@hst.link hippobean=resource.icon.original/>"><#else><i class="faicon fas fa-download fa-sm"></i></#if>
                            </a>
                        </li>
                    </#list>
                </#if>
            </ul>
            <#if document.logActions?? && document.logActions == true>
                <input type="hidden" id="${document.getCanonicalHandleUUID()}_logRegisterLink" smc-content-statistic-action="CLICK ON COMPONENT" smc-statistic-source="MULTILINK"/>
                <script>
                    $(document).ready(function () {
                        $("#${document.getCanonicalHandleUUID()}_logRegisterLink").attr("smc-statistic-data1", window.location.href);
                        $("#${document.getCanonicalHandleUUID()} a").click(function (e){
                            $("#${document.getCanonicalHandleUUID()}_logRegisterLink").attr("smc-statistic-data2", $(e.target).text());
                            contentlogAction($("#${document.getCanonicalHandleUUID()}_logRegisterLink"), $("#logActionLink").attr("href"));
                        });
                    });
                </script>
            </#if>
        </div>
    </div>
</div>
<#-- @ftlvariable name="editMode" type="java.lang.Boolean"-->
<#elseif editMode>
  <div>
    <img src="<@hst.link path="/images/essentials/catalog-component-icons/simple-content.png" />"> Click to edit Download Component
  </div>
</#if>



