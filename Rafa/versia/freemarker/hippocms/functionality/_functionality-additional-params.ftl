<#include "../../include/imports.ftl">
<#include "./_functionality-scripts.ftl">
<#setting number_format="computer">


<div class="smc-tabs desktop mt-5 ssi-component" id="container_additionalParameters">
    <input type="hidden" id="functionality_categoryId" name="functionality_categoryId" value="${categoryId}"/>
    <div class="ssi-load">
        <div class="loading-container-ssi-js category-spinner-container"></div>
    </div>
    <!-- Define the additional parameters of suitable products -->
    <div class="smc-tabs__head">
        <ul class="nav w-100" role="tablist">
            <li class="nav-item heading-0a subHeading-0a smc-tabs__head--active mb-0">
                <a class="active"
                   data-toggle="tab"
                   role="tab"
                   aria-selected="true"><span
                            class="psf-steps mr-3">2</span><span><@fmt.message key="functionality.definetheadditionalparameters"/></span></a>
            </li>
        </ul>
    </div>
    <div class="tab-content">
        <#-- apsp = Additional Parameters Suitable Products -->
        <div class="row apsp-filters">
            <#list filters[0..*4] as filter>
                <div class="col-12 col-md-6 col-lg-3 mb-4 apsp-filter form-floating">
                    <#if filter?index != 3>
                        <select class="selectpicker w-100" data-size="7" data-live-search="true"
                                title="${filter.getName()}"
                                data-filterId="${filter.getFilterId()}">
                            <option value="" selected
                                    class="w-100 ">${filter.getName()}</option>
                            <#list filter.getValues() as filterValue>
                                <option value="${filterValue.getValueId()}"
                                        class="w-100">${filterValue.getName()}</option>
                            </#list>
                        </select>
                        <label class="form-control-placeholder" for="selDepApt"> ${filter.getName()} </label>
                    <#else>
                        <select class="selectpicker w-75" data-live-search="true" title="${filter.getName()}"
                                data-filterId="${filter.getFilterId()}" data-size="7">
                            <option value="" selected
                                    class="w-100">${filter.getName()}</option>
                            <#list filter.getValues() as filterValue>
                                <option value="${filterValue.getValueId()}"
                                        class="w-100">${filterValue.getName()}</option>
                            </#list>
                        </select>
                        <label class="form-control-placeholder" for="selDepApt"> ${filter.getName()} </label>
                        <span id="btn_collapseParameters" class="ml-auto circle-icon-plus-details"
                              data-toggle="collapse"
                              data-target="#collapseParameters" aria-expanded="false" aria-controls="collapseParameters"
                              role="button"><i class="fa fa-plus"></i>
                        </span>
                    </#if>
                </div>
            </#list>
        </div>

        <#--            <a href="#" title="Show more filters"-->
        <#--               class="mt-2 ssi-filter-btn-show ssi-filter-btn-show-js float-right mr-2"> <i-->
        <#--                        class="fas fa-plus-circle fa-2x blue"></i></a>-->


    </div>
    <div id="collapseParameters" class="collapse" aria-labelledby="headingParameters" data-parent="#accordion">
        <div class="row mt-3">
            <#if filters?size gt 4 >
                <#list filters[4..] as filter>
                    <div class="col-lg-3 col-12 col-md-6 mb-4 form-floating">
                        <select class="selectpicker w-100" data-live-search="true" title="${filter.getName()}"
                                data-filterId="${filter.getFilterId()}" data-size="7">
                            <option value="" selected
                                    class="w-100">${filter.getName()}</option>
                            <#list filter.getValues() as filterValue>
                                <option value="${filterValue.getValueId()}"
                                        class="w-100">${filterValue.getName()}</option>
                            </#list>
                        </select>
                        <label class="form-control-placeholder" for="selDepApt"> ${filter.getName()} </label>
                    </div>
                </#list>
            </#if>
        </div>
    </div>
</div>
<div class="row mt-4 ssi-component" id="search_container">
    <div class="col-12 col-md-9 col-lg-10 mb-4">
        <input class="form-control apsp__search_text" type="text" id="partNumberFilter"
               placeholder="<@fmt.message key="functionality.searchboxplaceholder"/>">
    </div>
    <div class="col-12 col-md-3 col-lg-2">
        <button id="reset-btn"
                class="btn btn-secondary btn-secondary--blue-border align-self-center w-100 ssi-filter-btn-all ssi-filter-btn-all-js apsp__search_text_submit">
            <@fmt.message key="standardstockeditems.filter.showall"/>
        </button>
    </div>
</div>
<div class="smc-tabs desktop mt-5" id="container_bestItems" style="display:none;">
    <!-- Best items adapted to you -->
    <#include "_functionality-search-result.ftl">
    <div class="row mt-4 hidden" id="container_additionalParameters_modal_selection">
        <#-- Engineering tools -->
        <#if engineeringTool??>
            <div class="col-12 bg-light engineering-tools mb-5">
                <article class="row">
                    <div class="col-12 col-md-4 offset-md-1 col-lg-3 mb-3 mb-md-0">
                        <div class="product-catalogue-tile psf-product-catalogue-tile product-catalogue-tile--smallImage">
                            <a class="d-block functionality_filter_btn category-tile__image psf-category-tile__image --medium js--LazyImageContainer image-shown"
                               href="${engineeringTool.getUrl()}" target="_blank">
                                <img src="${engineeringTool.getImageUrl()}"
                                     alt="${engineeringTool.getName()}" class="p-4 p-lg-1">
                                <span class="category-tile__image__mask"></span>
                            </a>
                            <div class="category-tile__text psf-category-tile__text text-01 pb-0 mb-0">
                                <h2 class="heading-07 pb-0 mb-1">${engineeringTool.getName()}</h2>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-md-6 col-lg-7 engineering-tools__text">
                        ${engineeringTool.getDescription()}
                    </div>
                </article>
            </div>
        </#if>
    </div>
</div>

<script>
    $(function () {
        var config = {
            firstLoad: true,
        }
        var FunctionalitySearchComponent = window.smc.FunctionalitySearchComponent;
        window.smc.functionalitySearchComponent = new FunctionalitySearchComponent(config);
        window.smc.functionalitySearchComponent.init();
        isFunctionalityFirstLoad = true;

        let $selectpicker = $(".selectpicker");
        $selectpicker.on("show.bs.select", float);
        $selectpicker.on("hide.bs.select", unfloat);
        $selectpicker.on("changed.bs.select", changefloat);
    });

    function float() {
        $(this).parents(".form-floating").children("label").addClass("float");
        $(this).parents(".bootstrap-select").find(".filter-option-inner-inner").addClass("lowered");
    }

    function unfloat() {
        if (!$(this).val()) {
            $(this).parents(".form-floating").children("label").removeClass("float");
            $(this).parents(".bootstrap-select").find(".filter-option-inner-inner").removeClass("lowered");
        }
    }

    function changefloat() {
        if ($(this).val()) {
            $(this).parents(".form-floating").children("label").addClass("changefloat");
            $(this).parents(".bootstrap-select").find(".filter-option-inner-inner").addClass("lowered");
        } else {
            $(this).parents(".form-floating").children("label").removeClass("changefloat");
            $(this).parents(".bootstrap-select").find(".filter-option-inner-inner").removeClass("lowered");
        }
    }
</script>

<style>
    .form-control-placeholder {
        pointer-events: none;
        color: #1d3147;
        font-size: 17px;
        position: absolute;
        top: 0;
        left: 2.2em;
        line-height: 2.2em;
        white-space: nowrap;
        /*background-image: linear-gradient(to bottom, #fff, #fff);*/
        background-size: 100% 5px;
        background-repeat: no-repeat;
        background-position: center;
        transition: all 0.3s;
        display: none;
        font-family: "Montserrat", sans-serif;
    }

    .float {
        display: inline-block;
        transform: translate(0, -0.25em);
        font-size: 75%;
        transition: 0.2s ease-in-out;
    }

    .changefloat {
        display: inline-block;
        transform: translate(0, -0.25em);
        font-size: 75%;
    }

    .lowered {
        transform: translate(0, 0.3em);
    }
</style>