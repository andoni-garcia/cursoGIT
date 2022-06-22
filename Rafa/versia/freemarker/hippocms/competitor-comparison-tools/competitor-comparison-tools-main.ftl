<#include "../../include/imports.ftl">
<#include "./_competitorcomparison-tools-scripts.ftl">
<@hst.setBundle basename="competitorTools,partNumberConverter,SearchPage,ParametricSearch,SearchBar,StandardStockedItems,comparisonMap"/>
<#-- @ftlvariable name="compToolsReducedVersion" type="java.lang.Boolean" -->
<div class="smc-main-container">
        <div class="container">
            <h2 class="heading-08 color-blue mt-20"><@fmt.message key="title"/></h2>
            <div class="smc-tabs desktop mt-5">
                <main id="CCTcontenedor">
                    <div class="smc-tabs__head">
                        <ul class="w-100" >
                            <li class="heading-0a smc-tabs__head--active"><a href="#" id="pnc"><@fmt.message key="tab.partnumberconverter.title"/></a></li>
                            <li class="heading-0a"><a href="#" id="cm"><@fmt.message key="tab.comparisonmap.title"/></a></li>
                            <#if !compToolsReducedVersion>
                            	<li class="heading-0a"><a  href="#" data-bind="click:redirectSuccessStories" target="_blank"><@fmt.message key="tab.successstories.title"/><i class="fas fa-external-link-alt ml-3" aria-hidden="true"></i></a></li>
                        	</#if>
                        </ul>
                    </div>
                </main>
                <section class="search-results">
                    <div class="smc-tabs__body  search-result-item simple-collapse  smc-tabs__body--active">
                        <#include "./part-number-converter.ftl">
                    </div>
                </section>
                <section  class="search-results">
                    <div class="smc-tabs__body  search-result-item simple-collapse ">
                        <#include "./comparison-map.ftl">
                    </div>
                </section>
            </div>
        </div>
</div>
<@hst.actionURL var="actionURL"/>
<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/comparisonCompetitorTools/competitorComparisonToolsMain/CompetitorComparisonToolsMainViewModel.js"/>" type="text/javascript"></script>
</@hst.headContribution>
