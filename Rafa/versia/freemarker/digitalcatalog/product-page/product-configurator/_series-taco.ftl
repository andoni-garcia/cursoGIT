<#include "../../addtobasketbar-component/addtobasketbar-component.ftl">

<div class="idbl_hto_wrapper ${isAuthenticated?then('idbl_hto_wrapper--user_logged_in', '')}" id="idbl_hto_wrapper">
    <div class="idbl_hto  idbl_hto--light container">
        <header class="idbl_hto__header"></header>
        <div class="idbl_hto__content">
            <section class="idbl_hto__content__data">
            </section>
            <section class="idbl_hto__content__partnumber">
                <div class="idbl_hto__partnumber__actions">
                    <a id="copyToClipBoard_btn" class="btn btn-secondary btn-secondary--blue-border" href="#"
                       data-toggle="tooltip" data-placement="bottom" title=""
                       data-original-title="<@fmt.message key="productConfigurator.copytoclipboard"/>">
                        <div class="icon-container-hto">
                            <i class="icon-copy"></i>
                        </div>
                    </a>
                </div>
                <!-- ToDo: código del cpn_partnumber en data-partnumber-code -->
                <div class="idbl_hto__partnumber__code_wrapper idbl_hto__partnumber__code_wrapper--status-complete"
                     id="idbl_hto__partnumber__code_wrapper" data-partnumber-code="">
                    <span class="idbl_hto__partnumber__code_status"></span>

                    <div class="idbl_hto__partnumber__code config" id="idbl_hto__partnumber__code">
                        <!---------------------------------------------------------------------------------->
                        <!------------------------------- PART NUMBER HTML --------------------------------->
                        <!---------------------------------------------------------------------------------->

                        ${ product.getNode().getPartNumberHtml() }

                        <!---------------------------------------------------------------------------------->
                        <!--------------------------- END PART NUMBER HTML --------------------------------->
                        <!---------------------------------------------------------------------------------->
                    </div>

                </div>
                <div class="idbl_hto__partnumber__accesories_wrapper"></div>
            </section>
            <#--TODO Remove this condition when the login implementation in the iframe is done-->
            <#if isStandalonePage && !isAuthenticated>
                <@addToBasketBar productId="${product.getNode().getId()?long?c}" renderingMode="configurator" showQuantityBox=true showInfo=true showExtraInfo=true showAddToFavoritesBtn=false  series = true  new_hto=true
                statisticsSource="PCP FREE CONFIGURATION" />
            <#else>
                <@addToBasketBar productId="${product.getNode().getId()?long?c}" renderingMode="configurator" showQuantityBox=true showInfo=true showExtraInfo=true series = true  new_hto=true
                statisticsSource="PCP FREE CONFIGURATION" />
            </#if>
            <section class="idbl_hto__content__actions idbl_hto__content__actions--switch">
            </section>
        </div>
    </div>
</div>