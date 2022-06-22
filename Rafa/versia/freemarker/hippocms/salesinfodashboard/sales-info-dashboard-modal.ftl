<#if justLogIn?? && justLogIn == true && salesInfoMenu?has_content && !isExtranet>
<style>
        body{
            overflow: hidden;
        }
    </style>
<div class="modal fade show" id="product-sales-information" tabindex="-1" role="dialog"
     aria-labelledby="product-sales-informationLabel" style="display: block; overflow-y: scroll;">
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
                            <div class="info-box__head_title" title="${salesInfoMenuItem.name}">
                                <h2 class="heading-07">${salesInfoMenuItem.name}</h2>
                            </div>
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
<script>
        $(function () {
            var $productSalesInformation= $('#product-sales-information');
            $productSalesInformation.modal('show');
            $productSalesInformation.on('hidden.bs.modal', function(){
                $productSalesInformation.modal('hide');
                $productSalesInformation.css('display', 'none');
                $('body').css('overflow', 'auto');
            })
        });
    </script>
</#if>