<@hst.setBundle basename="ProductToolbar,CylinderConfigurator,ProductConfigurator,Eshop,AddToCartBar,ProductPDFReport"/>

<div class="idbl_hto_wrapper ${isAuthenticated?then('idbl_hto_wrapper--user_logged_in', '')}" id="idbl_hto_wrapper">
    <div class="idbl_hto  idbl_hto--cc container">
        <header class="idbl_hto__header">
            <span id="cylinder-info-container__partnumber_title__cylinder" class="hidden"></span>
            <span id="cylinder-info-container__partnumber_title__accesories" class="cylinder-info-container__partnumber_title__accesories hidden"></span>
        </header>
        <div class="idbl_hto__content">
            <input type="checkbox" name="cylinder-info-container__partnumber_switch" id="cylinder-info-container__partnumber_switch" class="">
            <section class="idbl_hto__content__data">
                <div id="" class="cylinder-info-container__configuration_details add-to-basket-bar-component" data-swiftype-index="false">
                    <h3 class="sscw__selection_table__title sub-title">
                        <span><@fmt.message key="cylinderConfigurator.youtConfigurationDetails"/></span>
                    </h3>
                    <div class="cylinder-info-container__configuration_details__info hidden">
                        <div class="cylinder-info-container__configuration_details__info__simple_special">
                            <strong class="configuration_details__info__label"><@fmt.message key="cylinderConfigurator.simpleSpecial"/>: </strong>
                            <span id="configuration_details__simpleSpecial_value" class="configuration_details__info__value"></span>
                        </div>
                        <#if apiPermission?? && apiPermission.isAlias() >
                            <div class="cylinder-info-container__configuration_details__info__alias">
                                <strong class="configuration_details__info__label"><@fmt.message key="cylinderConfigurator.alias"/> </strong>
                                <span id="configuration_details__alias__value" class="configuration_details__info__value"></span>
                                <button class="btn btn-primary px-2 py-1" id="showAliasModalButton">
                                    <i class="icon-pencil"></i>
                                </button>
                            </div>
                        </#if>
                        <div class="cylinder-info-container__configuration_details__info__customer_code">
                            <p id="configuration_details__mounted_value" class=" hidden">
                                <span class="configuration_details__info__status"><@fmt.message key="cylinderConfigurator.mounted"/></span>
                            </p>
                            <p>
                                <span class="configuration_details__info__label"><@fmt.message key="cylinderConfigurator.customerNumber"/>: </span>
                                <span id="configuration_details__customerNumber_value" class="configuration_details__info__value"></span>
                            </p>
                            <p>
                                <span class="configuration_details__info__label"><@fmt.message key="cylinderConfigurator.customerName"/>: </span>
                                <span id="configuration_details__customerName_value" class="configuration_details__info__value"></span>
                            </p>
                        </div>
                        <div class="cylinder-info-container__configuration_details__info__customer_code">
                            <p>
                                <span class="configuration_details__info__label"><@fmt.message key="cylinderConfigurator.endUserCode"/>: </span>
                                <span id="configuration_details__endUserCode_value" class="configuration_details__info__value"></span>
                            </p>
                            <p>
                                <span class="configuration_details__info__label"><@fmt.message key="cylinderConfigurator.endUserName"/>: </span>
                                <span id="configuration_details__endUserName_value" class="configuration_details__info__value"></span>
                            </p>
                        </div>
                    </div>
                    <div class="col-12 px-0 mb-4 sscw__selection_table_wrapper" id ="sscw__selection_table_summary_wrapper">
                        <div class="sscw__loading_spinner"></div>
                        <div class="sscw__selection_table">
                        </div>
                    </div>
                </div>
            </section>
            <section class="idbl_hto__content__partnumber">
                <div class="idbl_hto__content__title"><@fmt.message key="cylinderConfigurator.partNumber"/></div>
                <div class="idbl_hto__partnumber__actions">
                    <a id="copyToClipBoard_btn" class="btn btn-secondary btn-secondary--blue-border" href="#" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="<@fmt.message key="productConfigurator.copytoclipboard"/>">
                        <div  class="icon-container-hto">
                            <i class="icon-copy"></i>
                        </div>
                    </a>
                </div>
                <div class="idbl_hto__partnumber__code_wrapper idbl_hto__partnumber__code_wrapper--status-complete" id="idbl_hto__partnumber__code_wrapper" data-partnumber-code="">
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
                <div class="idbl_hto__partnumber__accesories_wrapper">
                    <span class="cylinder-info-container__partnumber_title__accesories idbl_hto__partnumber__accesories">
                    </span>
                </div>
            </section>
            <section class="idbl_hto__content__info">
                <div class="cylinder-info-container__content_simple_special">
                    <div class="idbl_hto__content__title">
                        <span><@fmt.message key="cylinderConfigurator.simpleSpecial"/></span>
                    </div>
                    <div>
                        <span class="form-control" id="series_hto_simple_special"></span>
                        <div class="cylinder-info-container__content__actions hidden">
                            <a id="copySSToClipBoard_btn" class="btn btn-secondary btn-secondary--blue-border " href="#" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="<@fmt.message key="productConfigurator.copytoclipboard"/>">
                                <div  class="icon-container-hto">
                                    <i class="icon-copy"></i>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>
            </section>
            <#if isStandalonePage && !isAuthenticated>
                <@addToBasketBar productId=product.getNode().getId()?long?c  renderingMode="cylinder-series" showQuantityBox=false showInfo=true showExtraInfo=true showAddToFavoritesBtn=false  series = true
                statisticsSource="PCP FREE CONFIGURATION" />
            <#else>
                <@addToBasketBar productId=product.getNode().getId()?long?c renderingMode="cylinder-series" showQuantityBox=false showInfo=true showExtraInfo=true series = true
                statisticsSource="PCP FREE CONFIGURATION" />
            </#if>
            <section class="idbl_hto__content__actions idbl_hto__content__actions--switch">
                <div data-side="partnumber" class="cylinder-info-container__partnumber_toggler">
                    <span><@fmt.message key="cylinderConfigurator.viewDetails"/></span>
                    <label for="cylinder-info-container__partnumber_switch" class="switch">
                        <span class="slider round"></span>
                    </label>
                </div>
            </section>
        </div>
    </div>
</div>