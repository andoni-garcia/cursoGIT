<#include "../../include/imports.ftl">


<@hst.include ref="carousel" />
<div class="container" ${hidebreadcrumbs???then("style='display:none'","")}>
     <@hst.include ref="breadcrumb"/>
</div>
<main class="smc-main-container">
    <@hst.include ref="title" />
    <@hst.include ref="content" />
</main>