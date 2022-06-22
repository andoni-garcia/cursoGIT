<#include "../include/imports.ftl">
<#setting number_format="computer">
<#include "_refresh-data-modal.ftl">
<div class="refresh-data-banner">
    <div class="d-flex">
        <div class="refresh-data-banner-content">
            <@fmt.message key="refreshdata.bannermessage" />
        </div>
        <button id="refresh-data-btn" type="button" class="btn btn-primary" data-toggle="modal"
                data-target="#refresh-data-modal">
            <@fmt.message key="refreshdata.refreshdata" />
        </button>
    </div>
    <div id="last-failure-cause" class="refresh-data-banner-error col-4 offset-8" style="display: none">
    </div>
</div>
<div class="hidden" data-swiftype-index='false'>
    <a id="refreshDataLink" href="<@hst.resourceURL resourceId='refreshData'/>"></a>
</div>
<div class="hidden" data-swiftype-index='false'>
    <a id="refreshDataStatusLink" href="<@hst.resourceURL resourceId='refreshDataStatus'/>"></a>
</div>