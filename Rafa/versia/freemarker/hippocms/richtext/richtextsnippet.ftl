<#include "../../include/imports.ftl">
<#if document??>
<div class="container">
   <div class="cmseditlink">
       <@hst.manageContent hippobean=document/>
   </div>
   <@hst.html hippohtml=document.richtext/>
</div>
<#elseif editMode??>
    <h2 class="not-configured">Click to configure Rich text snippet</h2>
</#if>
