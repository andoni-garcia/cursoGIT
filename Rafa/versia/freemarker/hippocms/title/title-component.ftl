<#include "../../include/imports.ftl">


<#if document??>
<div class="container">
    <div class="cmseditlink">
       <@hst.manageContent hippobean=document/>
    </div>
    <#if document.title?? && document.title?has_content>
        <h2 class="heading-08 color-blue mt-20">
            ${document.title?html}
        </h2>
    </#if>
    <#if document.subTitle?? && document.subTitle?has_content>
        <h1 class="heading-02 heading-main">
            ${document.subTitle?html}
        </h1>
    </#if>
</div>
<#elseif editMode??>
    <h2 class="not-configured">Click to configure Title</h2>
</#if>


