<#include "../../include/imports.ftl">
<#include "../catalog-macros.ftl">
<#include "../product/product-toolbar-macro.ftl">


<@hst.setBundle basename="essentials.global,ProductConfigurator,ProductToolbar,AddToCartBar,StandardStockedItems,SearchPage,SparesAccessories"/>
<#if !index??>
    <#assign index = 0 />
</#if>

<#if putItToWorkProduct.getNode()?? && putItToWork?? && putItToWork.getShowFeaturesCatalogues()??>
    <@productToolbar id=("producttoolbar_pitw_" + product.getNode().getId()?long?c +"_"+ index + "_header")
    product=putItToWorkProduct.getNode() boxTitle="product.toolbar.featureCatalogues" renderingMode="simple"
    showCadDownload=false show3dPreview=false showDataSheet=false showVideo=false isSeries=true
    statisticsSource="PCP GENERAL" />
</#if>

<#if putItToWorkProduct.getNode()?? && putItToWorkProduct.getNode().getTechnicalDocumentation()?? && (
(putItToWorkProduct.getNode().getTechnicalDocumentation().getImms()?? && putItToWorkProduct.getNode().getTechnicalDocumentation().getImms()?size != 0)
|| (putItToWorkProduct.getNode().getTechnicalDocumentation().getOpms()?? && putItToWorkProduct.getNode().getTechnicalDocumentation().getOpms()?size != 0)
|| (putItToWorkProduct.getNode().getTechnicalDocumentation().getDocs()?? &&  putItToWorkProduct.getNode().getTechnicalDocumentation().getDocs()?size != 0))>
    <div class="smc-filters__categories filters-wrapper__item simple-collapse simple-collapse--generic simple-collapse--filter ${putItToWorkViewType}">
        <div class="simple-collapse__head">
            <h2 class="pitw-subtitle heading-06"><@fmt.message key="product.toolbar.manuals"/></h2>
        </div>
        <div class="simple-collapse__body">
            <div class="simple-collapse__bodyInner">
                <ul class="filters-categories__item__level2">

                    <#if putItToWorkProduct.getNode()?? && putItToWorkProduct.getNode().getTechnicalDocumentation()?? && putItToWorkProduct.getNode().getTechnicalDocumentation().getImms()?? &&  putItToWorkProduct.getNode().getTechnicalDocumentation().getImms()?size != 0>
                        <li>
                            <div class="instructions-maintenance instructions-maintenance-js">
                                <span class="product-toolbar-subtitle"><@fmt.message key="product.toolbar.installationmanual"/></span>
                            </div>
                            <ul class="empty-list">
                                <#list  putItToWorkProduct.getNode().getTechnicalDocumentation().getImms() as doc>
                                    <li>
                                        <a href="${doc.getUrl()}" target="_blank">${doc.getName()}</a>
                                    </li>
                                </#list>
                            </ul>
                        </li>
                    </#if>
                    <#if putItToWorkProduct.getNode()?? && putItToWorkProduct.getNode().getTechnicalDocumentation()?? && putItToWorkProduct.getNode().getTechnicalDocumentation().getOpms()?? &&  putItToWorkProduct.getNode().getTechnicalDocumentation().getOpms()?size != 0>
                        <li>
                            <div class="operation-manuals operation-manuals-js">
                                <span class="product-toolbar-subtitle"><@fmt.message key="product.toolbar.operationManual"/></span>
                            </div>
                            <ul class="empty-list">
                                <#list  putItToWorkProduct.getNode().getTechnicalDocumentation().getOpms() as doc>
                                    <li>
                                        <a href="${doc.getUrl()}" target="_blank">${doc.getName()}</a>
                                    </li>
                                </#list>
                            </ul>
                        </li>
                    </#if>
                    <#if putItToWorkProduct.getNode()?? && putItToWorkProduct.getNode().getTechnicalDocumentation()?? && putItToWorkProduct.getNode().getTechnicalDocumentation().getDocs()?? &&  putItToWorkProduct.getNode().getTechnicalDocumentation().getDocs()?size != 0>
                        <li>
                            <div class="ce-certificates ce-certificates-js">
                                <span class="product-toolbar-subtitle"><@fmt.message key="product.toolbar.cecertificates"/></span>
                            </div>
                            <ul class="empty-list">
                                <#list  putItToWorkProduct.getNode().getTechnicalDocumentation().getDocs() as doc>
                                    <li>
                                        <a href="${doc.getUrl()}" target="_blank">${doc.getName()}</a>
                                    </li>
                                </#list>
                            </ul>
                        </li>
                    </#if>

                </ul>
            </div>
        </div>
    </div>
</#if>
<#if (putItToWorkProduct.getNode()?? && putItToWorkProduct.getNode().getConfigurationFile()?? && putItToWorkProduct.getNode().getSettings()?? && putItToWorkProduct.getNode().getSettings()?size != 0)
|| (putItToWorkProduct.getNode().getSettings()?? && putItToWorkProduct.getNode().getSettings()?? && putItToWorkProduct.getNode().getSettings()?size != 0)>
    <div class="smc-filters__categories filters-wrapper__item simple-collapse simple-collapse--generic simple-collapse--filter ${putItToWorkViewType}">
        <div class="simple-collapse__head">
            <h2 class="pitw-subtitle heading-06"><@fmt.message key="product.toolbar.settings"/></h2>
        </div>
        <div class="simple-collapse__body">
            <div class="simple-collapse__bodyInner">
                <ul class="filters-categories__item__level2">
                    <#if putItToWorkProduct.getNode()?? && putItToWork?? && putItToWork.getSettings()?? && putItToWork.getSettings()?size != 0 >
                        <#list putItToWork.getSettings() as item>
                            <li>
                                <a href="${item.getUrl()}"
                                   target="_blank"><@fmt.message key="product.toolbar.title." + item.getName() /></a>
                            </li>
                        </#list>
                    </#if>
                    <#if putItToWorkProduct.getNode()?? && putItToWorkProduct.getNode().getDrivers()?? && putItToWorkProduct.getNode().getDrivers().getDocuments()?? &&  putItToWorkProduct.getNode().getDrivers().getDocuments()?size != 0>
                        <li>
                            <a href="${putItToWorkProduct.getNode().getDrivers().getDocuments()[0].getUrl()}"
                               target="_blank"><@fmt.message key="product.toolbar.drivers"/></a>
                        </li>
                    </#if>
                </ul>
            </div>
        </div>
    </div>
</#if>
<#if putItToWorkProduct.getNode()?? && putItToWork?? && putItToWork.getLibraries()?? && putItToWork.getLibraries()?size != 0>
    <div class="smc-filters__categories filters-wrapper__item simple-collapse simple-collapse--generic simple-collapse--filter ${putItToWorkViewType}">
        <div class="simple-collapse__head">
            <h2 class="pitw-subtitle heading-06"><@fmt.message key="product.toolbar.libraries"/></h2>
        </div>
        <div class="simple-collapse__body">
            <div class="simple-collapse__bodyInner">
                <ul class="filters-categories__item__level2">
                    <#list putItToWork.getLibraries() as item>
                        <li>
                            <a href="${item.getUrl()}"
                               target="_blank"><@fmt.message key="product.toolbar." + item.getName() /></a>
                        </li>
                    </#list>
                    <#--<#if putItToWorkProduct.getNode().getLibraries()>
                        <li>
                            <a href="${putItToWorkProduct.getNode().getEPlan()}" class="" target="_blank">e-Plan library</a>
                        </li>
                    </#if>
                    <#if putItToWorkProduct.getNode()?? && putItToWorkProduct.getNode().getSistemaLibrary()??>
                        <li>
                            <a href="${putItToWorkProduct.getNode().getSistemaLibrary()}" class="" target="_blank">SISTEMA library</a>
                        </li>
                    </#if>
                    <#if putItToWorkProduct.getNode()?? && putItToWorkProduct.getNode().getPneumaticSymbol()??>
                        <li>
                            <a href="${putItToWorkProduct.getNode().getPneumaticSymbol()}" class="" target="_blank">Pneumatic symbol</a>
                        </li>
                    </#if>-->
                </ul>
            </div>
        </div>
    </div>
</#if>
