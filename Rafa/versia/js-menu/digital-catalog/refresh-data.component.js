(function (globalConfig) {
    function RefreshDataComponent(config) {
        this.config = config;
    }

    RefreshDataComponent.prototype.init = init;
    RefreshDataComponent.prototype.initializeEvents = initializeEvents;
    // FunctionalityComponent.prototype.showLastBlock = showLastBlock;

    // CylinderConfigurator.prototype.moveRodEndConfigurationRows = moveRodEndConfigurationRows;

    function init() {
        console.log("[RefreshDataComponent] Init");
        this.initializeEvents();
        // this.showLastBlock();
    }

    function initializeEvents() {
        var _self = this;
        console.log("[RefreshDataComponent] initializeEvents");
        // _self.config.$refreshDataBtn.on('click', function() {
        //     _self.config.$refreshDataModal.show();
        // });
        _self.config.$modalConfirmButton.on('click', _refreshData.bind(this));
        $('#refresh-data-modal').on('shown.bs.modal', function (e) {
            const currentUrl = new URL(window.location.href);
            if (currentUrl.searchParams.get("productId")) {
                $('#product-level-options').show();
            } else {
                $('#product-level-options').hide();
            }
        })
        _getRefreshDataStatus();
    }

    function _getRefreshDataStatus() {
        console.log("_getRefreshDataStatus");
        var _self = this;
        var url = new URL(document.getElementById('refreshDataStatusLink').href);
        let $lastFailureCause = $('#last-failure-cause');
        $.get(url)
            .then(function (response) {
                let $refreshDataBtn = $('#refresh-data-btn');
                if (response === "BUSY") {
                    $lastFailureCause.hide();
                    $refreshDataBtn.prop("disabled", true);
                    $refreshDataBtn.html(refreshingDataLiteral + "...");
                    setTimeout(_getRefreshDataStatus, 10000);
                } else {
                    $refreshDataBtn.html(refreshDataLiteral);
                    $refreshDataBtn.prop("disabled", false);
                    if (response) {
                        $lastFailureCause.html(lastFailureCauseLiteral + ": " + response);
                        $lastFailureCause.show();
                    }
                    $lastFailureCause.hide();
                    setTimeout(_getRefreshDataStatus, 10000);
                }
            })
            .catch(function (error) {
                console.error("_getRefreshDataStatus: " + error);
                setTimeout(_getRefreshDataStatus, 10000);
            })
    }

    function _refreshData() {
        console.log("_refreshData");
        const _self = this;
        let processType = $("input[name='refreshDataModalInput']:checked").val();
        let productId = _self.config.productId;
        if (processType === 'PRODUCT_NODE_INFORMATION') {
            processType = 'NODE_INFORMATION';
            const currentUrl = new URL(window.location.href);
            productId = currentUrl.searchParams.get("productId");
        }
        const data = {
            productId: productId,
            processType: processType,
        };
        const url = new URL(document.getElementById('refreshDataLink').href);
        let $refreshDataBtn = $('#refresh-data-btn');
        $.get(url, data)
            .then(function (response) {
                if (response === "SUCCESS") {
                    $refreshDataBtn.prop("disabled", true);
                    $refreshDataBtn.html(refreshingDataLiteral + "...");
                    console.log("_refreshData");
                    _self.config.$refreshDataModal.modal('hide');
                } else {
                    console.error("_refreshData");
                    _getRefreshDataStatus();
                }
            })
            .catch(function (error) {
                console.error("_refreshData: " + error);
                _getRefreshDataStatus();
            })
    }

    window.smc.RefreshDataComponent = RefreshDataComponent;
})(window.smc);