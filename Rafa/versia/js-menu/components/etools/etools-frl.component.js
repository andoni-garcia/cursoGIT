(function (globalConfig) {
    var TABS = {
        SSI_TAB: 'standard_stocked_items_tab',
        FREE_CONFIG_TAB: 'free_configuration_tab'
    };

    function EToolsFRLPageComponent(config) {
        this.config = config;
        this.updateSummaryCallCount = 0;
    }

    EToolsFRLPageComponent.prototype.init = init;
    EToolsFRLPageComponent.prototype.initializeEvents = initializeEvents;
    EToolsFRLPageComponent.prototype.loadSummaryTable = loadSummaryTable;
    EToolsFRLPageComponent.prototype.getCurrentAccesoriesPN = getCurrentAccesoriesPN;


    function init() {
        console.debug('[EToolsFRLPageComponent]', 'init');
        this.templates = {};
        this.initializeEvents();
    }

    function initializeEvents() {
        var _self = this;
        $("#cylinder-info-container__partnumber_switch").click(function () {
            getBOM();
            _self.loadSummaryTable();
        });
        $("#cylinder-info-container__switch").click(function () {
            getBOM();
            _self.loadSummaryTable();
        });
        $("#copyToClipBoard_btn").click(copyPartNumberToClipboard.bind(this));
        $(document).on('smc.productConfiguratorComponent.loadProjectFile', _loadProject.bind(this));
    }

    function addSearchingSpinner(container) {
        if ($(container).is(":empty")) {
            $(container).append(getSearchingSpinner());
        }
    }

    function getSearchingSpinner() {
        return document.getElementById('spinner-template').innerHTML;
    }

    function emptySearchingSpinner(container) {
        $(container).empty();
    }

    function getCurrentAccesoriesPN() {
        return $("#cylinder-info-container__partnumber_title__cylinder").text() + $("#cylinder-info-container__partnumber_title__accesories").text();
    }

    function loadSummaryTable(force) {
        force = true;
        $("#sscw__selection_table_pricesConfirm").empty();
        $("#sscw__selection_table_summary_wrapper .sscw__selection_table").empty();
        addSearchingSpinner("#sscw__confirmConfiguration .sscw__loading_spinner");
        addSearchingSpinner("#sscw__selection_table_summary_wrapper .sscw__loading_spinner");
        if (!$("#cylinder-info-container__partnumber_switch").is(":checked")) {
            $("#hto_partnumbers").hide();
            $("#hto_closeLabel").hide();
            $(".idbl_hto__content__addtobasketbar").hide();
            $("#hto_viewDetailsLabel").show();
            $("#hto_closed_text").show();
            return;
        }
        $("#hto_viewDetailsLabel").hide();
        $("#hto_closeLabel").show();

        console.log("loadSummaryTable() - Start");
        var _self = this;
        var currentPNAccesories = "";
        //checkcondition
        var configuratorOptionsEnabled = true;
        setTimeout(function () {
            if (configuratorOptionsEnabled) {
                currentPNAccesories = _self.getCurrentAccesoriesPN();
                console.log("loadSummaryTable() - force=" + force + " currentPNAccesories=" + currentPNAccesories);
                if (force || _self.currentLoadingSummaryPN !== currentPNAccesories) {
                    console.log("loadSummaryTable() - Forced or configuration change detected");
                    //try not to load multiple times the same summary on reading change event
                    _self.currentLoadingSummaryPN = currentPNAccesories;
                    // if ($("#cpn_partnumber").hasClass("status-complete") && !$("#sscw__selection_table_summary_wrapper").hasClass("hidden")) {
                    if (!$("#free_configuration_tab").hasClass("disabled")) {
                        console.log("loadSummaryTable() - Configuration is complete");

                        // showWarningMessageForInvalidConfiguration(_self);

                        // $("#sscw__selection_table_pricesConfirm").empty();
                        // $("#sscw__selection_table_summary_wrapper .sscw__selection_table").empty();
                        // var accessories = encodeURIComponent(JSON.stringify(_self.getAddedAccesoryList()));
                        // var seriesCode = $("#product_series_code").val();
                        // var mounted = $("#mounted_summary").prop("checked");
                        var data = {
                            partNumbers: window.partNumberList.join(),
                            // quantities: window.quantityList.join(),
                            // partNumberSel: partNumber,
                            // accessories: accessories,
                            // seriesCode: seriesCode,
                            // mounted: mounted
                            // descriptions: _self.getAddedAccesoryDescriptionsList()
                        };
                        addSearchingSpinner("#sscw__confirmConfiguration .sscw__loading_spinner");
                        addSearchingSpinner("#sscw__selection_table_summary_wrapper .sscw__loading_spinner");
                        var url = smc.etools.urls.getEtoolsFrlSummaryTable;

                        // var urlSimpleSpecialCode = getUrlParameter("simpleSpecialCode");
                        // if (urlSimpleSpecialCode == undefined || urlSimpleSpecialCode == '') {
                        //     url = getURLRemoveParam(url, "simpleSpecialCode");
                        // }

                        _self.updateSummaryCallCount = _self.updateSummaryCallCount + 1;
                        var currentUpdateSummaryCallCount = _self.updateSummaryCallCount;

                        console.log("loadSummaryTable() - Calling get summary (" + currentUpdateSummaryCallCount + ") with data", url, data);

                        $.get(url, data)
                            .then(function (response) {
                                console.log("loadSummaryTable() - Data obtained (" + currentUpdateSummaryCallCount + ")", _self.updateSummaryCallCount);
                                if (currentUpdateSummaryCallCount === _self.updateSummaryCallCount) {
                                    // if (!isConfigurationValid()) {
                                    if (response !== undefined && response !== "") {
                                        $(".sscw__selection_table").html(response);
                                        $("#sscw__selection_table_pricesConfirm").html(response);
                                        $("#hto_partnumbers").show();
                                        $(".idbl_hto__content__addtobasketbar").show();
                                        $("#idbl_hto__partnumber__code").html($(".sscw__selection_table").find("#partnumbers").val());
                                    }
                                    if ($(".sscw__selection_table input[name=can_create_simple_special]").val() == 'false' || $("#sscw__selection_table__headings_main") === undefined || $("#sscw__selection_table__headings_main").length === 0) {
                                        // Disable create simple special buttons
                                        $(".spares-accesory-item__actions .show-cylinder-wizard-btn-js").prop("disabled", true);
                                        $("#create-simple-special-button").prop("disabled", true);
                                        $(".spares-accesory-item__actions .show-cylinder-wizard-btn-js").addClass("disabled");
                                        $("#create-simple-special-button").addClass("disabled");
                                        $(".create-simple-special-disabled-text").show();
                                        $(".spares-accesory-item__actions .show-cylinder-wizard-btn-js").attr("data-original-title", $(".spares-accesory-item__actions .show-cylinder-wizard-btn-js").attr("data-disabled-title"));

                                        $("#btn-summary-finish").addClass("disabled");
                                        $("#btn-summary-finish").prop("disabled", true);
                                    } else {
                                        // Enable create simple special buttons
                                        $(".spares-accesory-item__actions .show-cylinder-wizard-btn-js").prop("disabled", false);
                                        $("#create-simple-special-button").prop("disabled", false);
                                        $(".spares-accesory-item__actions .show-cylinder-wizard-btn-js").removeClass("disabled");
                                        $("#create-simple-special-button").removeClass("disabled");
                                        $(".create-simple-special-disabled-text").hide();
                                        $(".spares-accesory-item__actions .show-cylinder-wizard-btn-js").attr("data-original-title", $(".spares-accesory-item__actions .show-cylinder-wizard-btn-js").attr("data-info-title"));
                                        $("#btn-summary-finish").removeClass("disabled");
                                        $("#btn-summary-finish").prop("disabled", false);
                                    }
                                    emptySearchingSpinner("#sscw__confirmConfiguration .sscw__loading_spinner");
                                    emptySearchingSpinner("#sscw__selection_table_summary_wrapper .sscw__loading_spinner");
                                    console.log("loadSummaryTable() - Data obtained finished");
                                } else {
                                    console.log("loadSummaryTable() - Data obtained but another call made");
                                }
                            })
                            .catch(function (error) {
                                console.log("loadSummaryTable() - Error", error);
                                if (currentUpdateSummaryCallCount === _self.updateSummaryCallCount) {
                                    emptySearchingSpinner("#sscw__confirmConfiguration .sscw__loading_spinner");
                                    emptySearchingSpinner("#sscw__selection_table_summary_wrapper .sscw__loading_spinner");

                                    // showWarningMessageForInvalidConfiguration(_self);
                                } else {
                                    console.log("loadSummaryTable() - Error but another call made", error);
                                }
                            });
                    } else {
                        console.log("loadSummaryTable() - Configuration is NOT complete");
                        $(".sscw__selection_table").html("Complete product configuration to get details");
                    }
                } else {
                    console.log("loadSummaryTable() - Same configuration as result shown");
                }

                // }
            }
            console.log("loadSummaryTable() - Finish");
        }, 600);

    }

    function copyPartNumberToClipboard(event) {
        if (event) event.preventDefault();

        var partNumber = window.partNumberList.join();
        console.debug('[EtoolsFRLConfigurator]', 'copyPartNumberToClipboard', 'partNumber=', partNumber);
        if (!partNumber) return;

        var $temp = $("<input>");
        $("body").append($temp);
        $temp.val(partNumber).select();
        document.execCommand("copy");
        $temp.remove();

        smc.NotifyComponent && smc.NotifyComponent.info(this.config.messages.partNumberCopied);
    }

    function _loadProject(event, file) {
        console.info('[EtoolsFRLConfigurator]', '_loadProject');
        var _self = this;
        uploadConfigFromFile(file);
    }



    window.smc.EToolsFRLPageComponent = EToolsFRLPageComponent;
})(window.smc);

function hideDetails() {
    if ($("#cylinder-info-container__partnumber_switch").is(":checked")){
        $("#cylinder-info-container__partnumber_switch").click();
    }
}

var ssi_columns = '';