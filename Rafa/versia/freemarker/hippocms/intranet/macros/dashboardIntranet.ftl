
<#macro dashboardIntranet location>
<#if location == "list">
</#if>

<#if location == "detail">
<div class="row my-5 dashboard-user">
    <div class="row m-3 w-100">
        <div class="col-md-6">
            <div><a href="javascript:history.back()" class="heading-09"><i class="fas fa-reply"></i><@fmt.message key="ci_detail.summarypage"/></a></div>
        </div>
    </div>
</div>
</#if>
</#macro>