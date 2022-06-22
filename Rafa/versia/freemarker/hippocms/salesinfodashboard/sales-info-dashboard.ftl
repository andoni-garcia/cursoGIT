<#if salesInfoMenu?has_content >
<div class="psi-sticky" id="product-sales-information__sticky-links">
    <div class="psi-sticky__fly">
        <a href="#" title="Product Sales Information" class="psi-sticky__button" data-toggle="modal" data-target="#product-sales-information_mobile">
            <i class="fa fa-th psi-sticky__button__icon"></i>
        </a>
    </div>

    <div class="psi-sticky__sticker">
        <#if !isExtranet>
            <div class="psi-sticky__info">
                <i class="fa fa-info-circle psi-sticky__info__icon"></i>
                <p class="psi-sticky__info__text"><@fmt.message key="salesinfodashboard.nosmc"/></p>
            </div>
        </#if>
        <div class="psi-sticky__buttons">
            <div class="psi-sticky__mainList">

                <#assign index=0>
                <#list salesInfoMenu as salesInfoMenuItem>

                <a title="${salesInfoMenuItem.name}" class="psi-sticky__button" data-index="${index}">
                    <figure class="psi-sticky__button__image">
                        <img src="${salesInfoMenuItem.iconUrl}" class="img-fluid" alt="...">
                    </figure>
                    <span class="psi-sticky__button__label psi-sticky__button__label_first">${salesInfoMenuItem.name}</span>
                    <i class="fas fa-chevron-right"></i>
                </a>


                <#assign index+=1>
            </#list>
        </div>

        <!-- Children -->
        <#list salesInfoMenu as salesInfoMenuItem>
        <#if salesInfoMenuItem.subMenus?has_content>
        <div class="psi-sticky__childrenList">
            <#if salesInfoMenuItem.company?? && salesInfoMenuItem.company?has_content>
                <a title="${salesInfoMenuItem.company}" class="psi-sticky__button psi-sticky__childrenList__child">
                    <span class="psi-sticky__button__label psi-sticky__button__label_first">Extranet</span>
                </a>
            <#else>
                <a title="${salesInfoMenuItem.name}" class="psi-sticky__button psi-sticky__childrenList__child">
                    <span class="psi-sticky__button__label psi-sticky__button__label_first">${salesInfoMenuItem.name}</span>
                </a>
            </#if>


            <#list salesInfoMenuItem.subMenus as subMenu>
                <#if subMenu.url?contains("https") || subMenu.url?contains("http")>
                    <a href="${subMenu.url}" title="${salesInfoMenuItem.name}" class="psi-sticky__button psi-sticky__childrenList__child" target="_blank">
                        <span class="psi-sticky__button__label">${subMenu.name}</span>
                    </a>
                <#else>
                    <a href="${subMenu.url}" title="${salesInfoMenuItem.name}" class="psi-sticky__button psi-sticky__childrenList__child">
                        <span class="psi-sticky__button__label">${subMenu.name}</span>
                    </a>
                </#if>
        </#list>
    </div>
</#if>
</#list>
</div>
</div>
</div>
<#if !isExtranet >
<div class="modal fade show" id="product-sales-information_mobile" tabindex="-1" role="dialog"
     aria-labelledby="product-sales-informationLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title" id="product-sales-informationLabel"><@fmt.message key="salesinfodashboard.title"/></h3>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body">
                <p>
                    <@fmt.message key="salesinfodashboard.welcome"/><br>
                    <@fmt.message key="salesinfodashboard.exclusiveaccess"/>
                </p>
                <p>
                    <@fmt.message key="salesinfodashboard.nosmc"/>
                </p>
                <div class="product-sales-information__buttons row">
                    <#--                    TODO use this when data loaded from Hippo-->
                    <#list salesInfoMenu as salesInfoMenuItem>
                    <div class="info-box psi-modal__containers">
                        <div class="info-box__head">
                            <a href="${salesInfoMenuItem.url}" title="${salesInfoMenuItem.name}">
                                <h2 class="heading-07">${salesInfoMenuItem.name}</h2>
                            </a>
                        </div>
                        <div class="info-box__body text-01">
                            <#if salesInfoMenuItem.subMenus?has_content>
                            <ul class="empty-list">
                                <#list salesInfoMenuItem.subMenus as subMenu>
                                <li>
                                    <a href="${subMenu.url}">
                                        <span class="children-span">${subMenu.name}</span>
                                    </a>
                                </li>
                            </#list>
                            </ul>
                        </#if>
                    </div>
                </div>
            </#list>
        </div>
    </div>
</div>
</div>
</div>
</#if>
</#if>