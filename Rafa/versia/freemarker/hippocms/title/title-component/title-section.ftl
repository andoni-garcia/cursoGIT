<#include "../../../include/imports.ftl">


<#if document??>
<div class="container">
    <div class="cmseditlink">
       <@hst.manageContent hippobean=document/>
    </div>
    <#if document.title??>
        <h2 class="heading-08 color-blue mt-20 <#if cparam.titleCentered == true>text-center</#if>">
            ${document.title?html}
        </h2>
    </#if>
</div>
<#elseif editMode??>
    <h2 class="not-configured">Click to configure Title</h2>
</#if>


