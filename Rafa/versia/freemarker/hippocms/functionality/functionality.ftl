<#include "../../include/imports.ftl">
<#include "./_functionality-scripts.ftl">
<@hst.setBundle basename="Functionality"/>
<@hst.actionURL var="actionURL"/>

<@hst.headContribution category="htmlHead">
    <script>
        var actionUrl;
    </script>
</@hst.headContribution>

<@hst.headContribution category="scripts">
    <script type="text/javascript">
        $(document).ready(function () {
            actionUrl = "${actionURL}";
            console.log(actionUrl)
        });
    </script>
</@hst.headContribution>

<main id="psfFuntionalitycontenedor" class="psfFuntionalitycontenedor">
    <div id="psfcontainer" class="container">
        <div class="row">
            <div class="col-12">
                <h2 class="heading-08 color-blue mt-20"><@fmt.message key="functionality.navigationbyfunctionality"/></h2>
                <h1 class="heading-02 heading-main mb-4"><@fmt.message key="functionality.savetimeandeliminateerrors"/></h1>
                <p class="">
                    <@fmt.message key="functionality.smcexpertise"/>
                </p>
                <p class="">
                    <@fmt.message key="functionality.readitsmanual"/>
                </p>
            </div>
        </div>
        <!-- Define funtionality -->
        <div class="smc-tabs desktop mt-5">
            <div class="smc-tabs__head d-block">
                <ul class="nav w-100" role="tablist">
                    <li class="nav-item heading-0a subHeading-0a smc-tabs__head--active mb-0">
                        <a class="active"
                           data-toggle="tab"
                           role="tab"
                           aria-selected="true"><span class="psf-steps mr-3">1</span>
                            <span><@fmt.message key="functionality.definethefunctionality"/></span>
                        </a>
                    </li>
                </ul>
            </div>
            <div class="tab-content">
                <div id="accordion">
                    <#list navigationNodes as navigationNode>
                        <#include "_functionality-card.ftl">
                    </#list>
                </div>
            </div>
        </div>
        <#if productCategory??>
            <#include "_functionality-additional-params.ftl">
        </#if>

    </div>
    <#include "_functionality-confirmation-modal.ftl">
</main>

<@hst.headContribution category="scripts">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/productssolutionsfinder/ProductsSolutionsFinderByFuntionalityViewModel.js"/>"
            type="text/javascript"></script>
</@hst.headContribution>

<div class="hidden" data-swiftype-index='false'>
    <a id="functionalityNavigationLink" href="<@hst.resourceURL resourceId='functionalityNavigation'/>"></a>
    <a id="functionalitySearchLink" href="<@hst.resourceURL resourceId='functionalitySearch'/>"></a>
    <a id="generateCardOptionsLink" href="<@hst.resourceURL resourceId='generateCardOptions'/>"></a>
    <a id="getActiveFiltersLink" href="<@hst.resourceURL resourceId='getActiveFilters'/>"></a>
</div>
<input type="hidden" id="isSeriesPage" value="true">
<script>
    $(function () {
        var FunctionalityComponent = window.smc.FunctionalityComponent;
        var config = {};
        var functionalityComponent = new FunctionalityComponent(config);
        functionalityComponent.init();
    });
</script>