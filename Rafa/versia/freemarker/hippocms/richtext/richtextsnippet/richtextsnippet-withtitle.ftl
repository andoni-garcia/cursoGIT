<#include "../../../include/imports.ftl">

<#if document??>
<div class="container">
	<h2>${document.localizedName}</h2>
    <div class="content-p">
      <@hst.manageContent hippobean=document/>
       <@hst.html hippohtml=document.richtext/>
    </div>
</div>
<#elseif editMode??>
    <h2 class="not-configured">Click to configure Rich text snippet</h2>
</#if>
