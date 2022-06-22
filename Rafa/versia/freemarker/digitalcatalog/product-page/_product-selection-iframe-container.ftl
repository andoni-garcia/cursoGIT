<script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/components/product-page/product-configurator/product-selection.communications.js"/>"></script>
<div id ="product-selection-iframe-container">
    <div class="hidden">
        <a id="getProductConfiguratorComponentLink" href="<@hst.resourceURL resourceId='getProductConfiguratorComponent'/>"></a>
    </div>
    <iframe id ="product-selection-iframe" src='${productSelectionIFrameSrc}' width="100%" height="110%" frameBorder="0">${browserNotCompatibleLbl}</iframe>
</div>

<script type="text/javascript">
    $(document).ready(function () {
        var productSelectionCommunicator;
        $(function() {
            var ProductSelectionCommunicator = window.smc.ProductSelectionCommunicator;
            var config = {
            };
            productSelectionCommunicator = new ProductSelectionCommunicator(config);
            productSelectionCommunicator.init();
        });
    });
</script>