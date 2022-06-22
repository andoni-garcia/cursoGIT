<#include "../../include/imports.ftl">
<#setting number_format="computer">
<#assign cardId = "${navigationNode.getNodeId()}">
<#assign cardName = "${navigationNode.getName()}">
<#assign selectedId = '${navigationNode.getSelectedId()!""}'>
<#assign selectedName = '${navigationNode.getSelectedName()!""}'>

<div class="card" id="card_${cardId}">
    <div class="card-header card-header__switch"
         id="heading_${cardId}"
         data-toggle="collapse"
         data-target="#collapse_${cardId}"
         aria-controls="collapse_${cardId}"
         role="button" aria-expanded="false">
        <div class="row">
            <div class="col-12 col-md-6 card-header__title">
                <h5 class="text-secondary">${cardName}</h5>
            </div>
            <div class="col-12 col-md-6">
                <div class="row">
                    <div class="col-10 col-lg-11 card-header__value">
                        <h5 id="selected_${cardId}" class="mr-4 font-weight-bold pr-0 mr-0">${selectedName}</h5>
                    </div>
                    <div class="col-2 col-lg-1 card-header__switch">
                        <span class="icon-plus-details">
                            <i class="fa fa-plus"></i>
                        </span>
                    </div>
                </div>
            </div>
        </div>
        <input type="hidden" id="selectedId" name="selectedId" value="${selectedId}"/>
    </div>
    <div id="collapse_${cardId}" class="collapse" aria-labelledby="heading_cardId"
         data-parent="#accordion">
        <div class="card-body">
            <#include "_functionality-options.ftl">
        </div>
    </div>
</div>
