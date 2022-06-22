<#include "_accessories-modal_links.ftl">
<#macro accessoriesModal product boxTitle renderMode id accessoryPartNumber>
    <@hst.setBundle basename="essentials.global,ProductConfigurator,ProductToolbar,AddToCartBar,StandardStockedItems,SearchPage,SparesAccessories"/>
    <#if renderMode == 'from-ssi-series'>
        <div id = "${id}" class="spares-accesory-item__actions">
            <div class="product-toolbar-item accessory-modal-container hidden" style = "padding-left: 8px">
                <a href="javascript:void(0);" data-toggle="tooltip" data-placement="bottom"
                   class="show-accessory-modal iconed-text series-ssi-cad-download"
                   title="<@fmt.message key="productConfigurator.showDetails"/>">
                    <div class="pl-2 product-toolbar-menu-item"><i class="icon-accessory-modal"></i></div>
                    <i class="loading-container-js"></i>
                </a>
            </div>
        </div>
    </#if>
    <script>

        $(function () {
            var AccessoriesModal = window.smc.AccessoriesModal;
            var urls = {
                getAccessoryDetail: document.getElementById('getAccessoryDetailLink').href,
                hasAccessoryDetail: document.getElementById('hasAccessoryDetailLink').href
            };
            var config = {
                id: '${id}',
                container: $('#${id}'),
                productId: '${product.getId()}',
                partNumber: '${accessoryPartNumber}',
                renderMode: '${renderMode}',
                urls : urls
            };
            var accessoriesModal = new AccessoriesModal(config);
            accessoriesModal.init();
        });
    </script>

</#macro>
