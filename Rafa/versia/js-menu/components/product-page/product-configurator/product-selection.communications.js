(function (window) {
    var globalConfig = window.smc;

    //Polyfill for IE CustomEvent
    (function () {

        if ( typeof window.CustomEvent === "function" ) return false;

        function CustomEvent ( event, params ) {
            params = params || { bubbles: false, cancelable: false, detail: undefined };
            var evt = document.createEvent('CustomEvent');
            evt.initCustomEvent( event, params.bubbles, params.cancelable, params.detail );
            return evt;
        }

        CustomEvent.prototype = window.Event.prototype;

        window.CustomEvent = CustomEvent;
    })();

    function ProductSelectionCommunicator(config) {
        this.id = config.id;
        this.config = config;
    }

    ProductSelectionCommunicator.prototype.init = init;
    ProductSelectionCommunicator.prototype.initializeEvents = initializeEvents;
    ProductSelectionCommunicator.prototype.loadProduct = loadProduct;
    ProductSelectionCommunicator.prototype.resetFilters = resetFilters;
    ProductSelectionCommunicator.prototype.sendConfigurationToIFrame = sendConfigurationToIFrame;
    ProductSelectionCommunicator.prototype.updateConfigWithFilterValues = updateConfigWithFilterValues;

    function init() {
        this.$btnResetFilters = $(".btn-reset-filters");
        this.initializeEvents();
        this.reloadingFilterValues = false;
    }

    function initializeEvents() {
        console.log("[ProductSelectionCommunicator] initializeEvents");
        var _self = this;
        var $document = $(document);
        window.document.addEventListener('product.selection.productId.found', function (e) {
            $("#productconfigurator-component__ps_no_results_found").addClass("hidden");
            $("#productconfigurator-component__ps_no_unique_results_found").addClass("hidden");
            var productId = e.detail.productId;
            var partNumber = e.detail.selectedPartNumber;
            var filters = e.detail.selectedFilters;
            if (productId !== undefined) {
                console.log("[Product Selection Communications] [config] message received -->", e.detail, productId);
                _self.loadProduct(productId, partNumber, filters);
            }
        }, false);

        window.document.addEventListener('product.selection.filters.updated', function (e) {
            if (e.detail.filterValues !== undefined) {
                console.log("[Product Selection Communications] [config] message received -->", e.detail.filterValues);
                if (!$("#productconfigurator-component__section").is(":empty")) {
                    var selectedFilters = e.detail.filterValues;
                    if ($("#configuration_area").is(":visible") && document.getElementById(gConstraintFormID)) {
                        _self.updateConfigWithFilterValues(selectedFilters);
                    }
                    // if (selectedFilters.length  > 0){
                    //     var url = new URL(window.location.href);
                    //     var params = new URLSearchParams(url.search);
                    //     for (var p in params) {
                    //         if (p.length == 2 & p[0].startsWith("PSF_")) {
                    //             url.searchParams.delete(p[0]);
                    //         }
                    //     }
                    //     for (var filter in selectedFilters){
                    //         var currElement = selectedFilters[filter];
                    //         if (currElement.code !== undefined){
                    //             url.searchParams.delete("PSF_" +currElement.code);
                    //             url.searchParams.set("PSF_" + currElement.code, currElement.value);
                    //         }
                    //     }
                    //     window.history.pushState({}, window.document.title, url.toString());
                    // }
                }
            }
        }, false);

        window.document.addEventListener('product.selection.multiple.productId.found', function (e) {
            if (e.detail !== undefined) {
                console.log("[Product Selection] [config] message received --> Multiple productId found in search", e.detail.response, e.detail.areAllSelectsWithValue);
                $("#productconfigurator-component__section").empty();
                if (e.detail.areAllSelectsWithValue || e.detail.areAllSelectsWithValue === "true") {
                    if (e.detail.response.length === 0  ) {
                        $("#productconfigurator-component__ps_no_unique_results_found").addClass("hidden");
                        $("#productconfigurator-component__ps_no_results_found").removeClass("hidden");
                    }else {
                        $("#productconfigurator-component__ps_no_results_found").addClass("hidden");
                        $("#productconfigurator-component__ps_no_unique_results_found").removeClass("hidden");
                    }
                } else {
                    $("#productconfigurator-component__ps_no_results_found").addClass("hidden");
                    $("#productconfigurator-component__ps_no_unique_results_found").addClass("hidden");
                }
                var url = new URL(window.location.href);
                url.searchParams.delete("productId");
                window.history.pushState({}, window.document.title, url.toString());
            }
        }, false);

        this.$btnResetFilters.unbind('click').click(resetFilters.bind(this));

        $(document).on('smc.productSelection.partNumber.changed', function (e) {
            if (!this.reloadingFilterValues) {
                _self.sendConfigurationToIFrame();
            }
        });
    }


    function resetFilters() {
        console.log("[ProductSelectionCommunicator] reset filters");
        $("#productconfigurator-component__section").empty();
        $("#productconfigurator-component__ps_no_results_found").addClass("hidden");
        $("#productconfigurator-component__ps_no_unique_results_found").addClass("hidden");
        var url = new URL(window.location.href);
        var params = new URLSearchParams(url.search);
        window.history.pushState({}, window.document.title, url.toString());
        var event = new CustomEvent('product.selection.communication.resetFilters', {})
        document.querySelector('#product-selection-iframe').contentDocument.dispatchEvent(event);
        var url = new URL(window.location.href);
        url.searchParams.delete("selectedFilters");
        window.history.pushState({}, window.document.title, url.toString());
        console.log("[Product Selection] [config] message sent --> reset filters");
    }

    function updateConfigWithFilterValues(selectedFilters) {
        console.log("[ProductSelectionCommunicator] updateConfigWithFilterValues", selectedFilters);

        selectedFilters = decomposeFilters(selectedFilters);

        var config = {};
        this.reloadingFilterValues = true;
        if (selectedFilters !== undefined) {
            for (var filterIndex in selectedFilters) {
                var currentFilter = selectedFilters[filterIndex];
                if (currentFilter.code !== undefined) {
                    config[currentFilter.code] = currentFilter.value;
                    updateEtechConfiguratorValue(currentFilter.code, currentFilter.value);
                }
            }
        }
        this.reloadingFilterValues = false;
    }


    function sendConfigurationToIFrame() {
        console.log("[ProductSelectionCommunicator] sendConfigurationToIFrame init");
        var selectedConfigurationElements = [];
        var elementValues = getEtechConfigValues();
        for (var currentDomain in window.oDomains.domains) {
            var currentElement = window.oDomains.domains[currentDomain];
            var currentElementCode = currentElement.code;
            if (elementValues[currentDomain] !== undefined && elementValues[currentDomain] !== "&middot;") {
                var element = {code: currentElementCode, value: elementValues[currentDomain]};
                selectedConfigurationElements.push(element);
            }
        }
        if (selectedConfigurationElements.length > 0) {
            var data = {selectedComponents: selectedConfigurationElements};
            var event = new CustomEvent('product.selection.communication.configUpdated', {detail: data});
            document.querySelector('#product-selection-iframe').contentDocument.dispatchEvent(event);
            console.log("[Product Selection] [config] message sent -->", event.detail.selectedComponents);
        }
    }

    function loadProduct(productId, partNumber, filters) {
        $("#productconfigurator-component__section").empty();
        // addSearchingSpinner();
        $("#productconfigurator-component__section").html(getSearchingSpinner());
        var url = new URL(window.location.protocol + "//" + window.location.host + window.location.pathname);
        url.searchParams.set("productId", productId);
        if (partNumber !== undefined && partNumber !== "") {
            url.searchParams.set("partNumber", partNumber);
        }
        var seriesConfig = getUrlParameter("seriesConfig");
        if (seriesConfig !== undefined && seriesConfig !== "") {
            url.searchParams.set("seriesConfig", seriesConfig);
        }
        var productSelection = getUrlParameter("productSelection");
        if (productSelection !== undefined && productSelection !== "") {
            url.searchParams.set("productSelection", productSelection);
        }
        var productSelectionId = getUrlParameter("productSelectionId");
        if (productSelectionId !== undefined && productSelectionId !== "") {
            url.searchParams.set("productSelectionId", productSelectionId);
        }
        var urlString = url.toString();
        window.history.pushState({}, window.document.title, urlString);

        // Get ajax product configurator
        var url = new URL(document.getElementById('getProductConfiguratorComponentLink').href);
        url.searchParams.delete("productId");
        url.searchParams.delete("partNumber");
        var data = {
            productId: productId,
            partNumber: partNumber
        };
        $.get(url, data).then(function (response) {
            resetConfiguratorStatus();
            $("title").remove();

            $("#productconfigurator-component__section").html(response);
            $(".series-loading-container").html("");

            setTimeout(function () {
                $('#free_configuration').show();
                if ($(".loading-container-ssi-js") !== undefined) {
                    $(".loading-container-ssi-js").empty();
                }
                $('#free_configuration_trigger').click();
                $("#productConfiguratorContainer").show();
                $('#free_configuration').css("display", "");
                $("#rodEndOptionsSwitchToggle").attr("disabled", true);
                if ($("#rodEndOptionsSwitchToggle").is(":checked")) {
                    $(".builder").attr("style", "");
                    $(".project-alert-container").removeClass("hidden");
                    $("#project-section").removeClass("hidden");
                    $("#project-section-buttons").removeClass("hidden");
                }
                emptySearchingSpinner();
                if ($("#configuration_area").is(":visible") && document.getElementById(gConstraintFormID)) {
                    updateConfigWithFilterValues(filters);
                }
            }, 1000);
        });
    }

    function resetConfiguratorStatus() {
        delete window.smc.pc;
        delete window.smc.projectInformationModule;
        delete window.smc.ssiAllPartNumbers;
        delete window.smc.standardStockedItemsComponent;
        delete window.smc.productConfiguratorComponent;
        delete window.smc.productPageController;
    }

    function addSearchingSpinner() {
        if ($(".pc__loading_spinner").is(":empty")) {
            $(".pc__loading_spinner").append(getSearchingSpinner());
        }
    }

    function getSearchingSpinner() {
        return document.getElementById('spinner-template').innerHTML;
    }

    function emptySearchingSpinner() {
        $(".pc__loading_spinner").empty();
    }


    window.smc.ProductSelectionCommunicator = ProductSelectionCommunicator;
})(window);