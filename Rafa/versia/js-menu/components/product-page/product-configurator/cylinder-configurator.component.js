(function (globalConfig) {
    function CylinderConfigurator(config) {
        this.id = config.id;
        this.config = config;
        this.updateSummaryCallCount = 0;
    }

    CylinderConfigurator.prototype.init = init;
    CylinderConfigurator.prototype.initializeEvents = initializeEvents;
    CylinderConfigurator.prototype.createAlias = createAlias;
    CylinderConfigurator.prototype.showAliasModal = showAliasModal;
    CylinderConfigurator.prototype.aliasFinish = aliasFinish;
    CylinderConfigurator.prototype._exportBom = _exportBom;
    CylinderConfigurator.prototype._onPartNumberUpdatedCylinder = _onPartNumberUpdatedCylinder;
    CylinderConfigurator.prototype.loadSummaryTable = loadSummaryTable;
    CylinderConfigurator.prototype.selectWorkingZone = selectWorkingZone;
    CylinderConfigurator.prototype.hideError = hideError;
    CylinderConfigurator.prototype.showError = showError;
    CylinderConfigurator.prototype.getSelectedZone = getSelectedZone;
    CylinderConfigurator.prototype.loadAccesories = loadAccesories;
    CylinderConfigurator.prototype.getAddedAccesoryList = getAddedAccesoryList;
    CylinderConfigurator.prototype.getAddedAccesoryDescriptionsList = getAddedAccesoryDescriptionsList;
    CylinderConfigurator.prototype.addAccesory = addAccesory;
    CylinderConfigurator.prototype.modifyRodEnd = modifyRodEnd;
    CylinderConfigurator.prototype.addAccesoryListeners = addAccesoryListeners;
    CylinderConfigurator.prototype.addAccesoryToSummary = addAccesoryToSummary;
    CylinderConfigurator.prototype.addReference = addReference;
    CylinderConfigurator.prototype.getCurrentRodEndAccesoriesPN = getCurrentRodEndAccesoriesPN;
    CylinderConfigurator.prototype.parseAccesories = parseAccesories;
    CylinderConfigurator.prototype.loadConfigurationFromSimpleSpecial = loadConfigurationFromSimpleSpecial;
    CylinderConfigurator.prototype.loadConfigurationFromSimpleSpecialInfo = loadConfigurationFromSimpleSpecialInfo;
    CylinderConfigurator.prototype.resetAccessoriesSelection = resetAccessoriesSelection;
    CylinderConfigurator.prototype.showCylinderType = showCylinderType;
    CylinderConfigurator.prototype.addAccessoryData = addAccessoryData;
    CylinderConfigurator.prototype.addReferenceData = addReferenceData;
    CylinderConfigurator.prototype.loadAccessoriesFromUrlProjectInfo = loadAccessoriesFromUrlProjectInfo;

    // CylinderConfigurator.prototype.moveRodEndConfigurationRows = moveRodEndConfigurationRows;

    function init() {
        console.log("[Cylinder-configurator] Init");
        this.$aliasInput = $("#alias");
        this.$aliasModalButton = $("#showAliasModalButton");
        this.$aliasFinish = $("#btn-alias-finish");
        this.$exportBomBtn = $('#exportBomBtn');
        this.$addReferenceBtn = $('#btn-submit-reference');
        this.$copySSToClipBoardBtn = $('#copySSToClipBoard_btn');
        this.$addAccesoryButton = $("#aareo_configuration_part_addAccesory");
        this.$modifyRodEndButton = $("#aareo_configuration_part_modifyRodEnd");
        this.accessorySummaryNoPositionTemplate = $('#aareo_accesory_summary_no_position_template').html();
        this.currentLoadingSummaryPN = "";
        this.currentLoadingRodEndConf = "";
        this.initializeEvents();
        setTimeout(function () {
            if ($("#rodEndOptionsSwitchToggle").is(":checked") && !$(".builder").is(":visible")) {
                $(".builder").attr("style", "");
            }
        }, 800);
        $("#productConfiguratorContainer").addClass("free_configuration--cylinder");
        checkSummaryVisibility();

    }

    function initializeEvents() {
        console.log("[Cylinder-configurator] initializeEvents");
        var _self = this;
        var $document = $(document);
        if (_self.$aliasModalButton !== undefined) {
            _self.$aliasModalButton.click(_self.showAliasModal.bind(this));
            _self.$aliasFinish.click(_self.createAlias.bind(this));
        }
        if (this.$exportBomBtn !== undefined) {
            // this.$exportBomBtn = this.$exportBomBtn || $('#exportBomBtn');
            this.$exportBomBtn.on('click', _exportBom.bind(this));
        }
        if (this.$addAccesoryButton !== undefined) {
            this.$addAccesoryButton.click(_self.addAccesory.bind(this));
        }
        if (this.$modifyRodEndButton !== undefined) {
            this.$modifyRodEndButton.click(_self.modifyRodEnd.bind(this));
        }

        if (this.$addReferenceBtn !== undefined) {
            this.$addReferenceBtn.click(_self.addReference.bind(this));
        }

        this.$copySSToClipBoardBtn.click(copySSPartNumberToClipboard.bind(this));

        $document.on('smc.reload.summary', function (e) {
            _self._onPartNumberUpdatedCylinder();
        });

        $document.on('smc.rodEndUpdate.reload', function (e, status) {
            _self.loadSummaryTable(true, status);
        });

        $document.on('smc.product.config.changed', function (e) {
            _self.showCylinderType();

            _self.resetAccessoriesSelection();
            if ($("#accesoriesAndRodEndOptionsSwitchToggle").val() == 'on' && $("#aareo__choose-accesory").is(":visible")) {
                loadAccesories($("#aareo_configuration_part_addAccesory").is(":visible"));
            }
            if (!isRodEndConfigured()) {
                var url = new URL(window.location.href);
                url.searchParams.delete('rodEndConf');
                window.history.replaceState({}, window.document.title, url.toString());
            }
        });

        $("#cylinder-info-container__partnumber_switch").click(function () {
            _self.loadSummaryTable();
        });
        $("#cylinder-info-container__switch").click(function () {
            _self.loadSummaryTable();
        });

        $(".aareo__cylinder__part_position_js").each(function () {
            $(this).click(function () {
                if (!$(this).hasClass("selected")) {
                    _self.selectWorkingZone(this);
                }
            });
        });

        $("#accesoriesAndRodEndOptionsSwitchToggle").on('change', function () {
            var checked = $("#accesoriesAndRodEndOptionsSwitchToggle").prop("checked");

            if (!checked) {
                removeAllAccessoriesFromSummary();
                resetRodEndConf();
                hideRodEndConfigurationform();
                hideChooseAccessory();
            }
        });

        $("#mounted_summary").on('change', function () {
            _self.loadSummaryTable(true);
        });

        this.loadAccesories(false);
        // this.moveRodEndConfigurationRows();

        _self.showCylinderType();
        setTimeout(function () {
            var selectedZone = $(".aareo__cylinder__part_position_js.selected");
            if ($(selectedZone).parent().hasClass("aareo__cylinder__part_rodEnd")) {
                if (isRodEndConfigured()) {
                    if (!$("#accesoriesAndRodEndOptionsSwitchToggle").is(":checked")) {
                        $("#accesoriesAndRodEndOptionsSwitchToggle").click();
                    }

                    _self.$modifyRodEndButton.click();
                } else {
                    hideRodEndConfigurationform();
                    if ($(".aareo__cylinder__part_rodEnd .aareo__cylinder__part_position_js .selected") !== undefined
                        && $(".aareo__cylinder__part_rodEnd .aareo__cylinder__part_position_js.selected").length > 0) {
                        hideChooseAccessory();
                    }
                }

            }

            if (simpleSpecialData && !$.isEmptyObject(simpleSpecialData)) {
                _self.loadConfigurationFromSimpleSpecialInfo(simpleSpecialData);
            }
        }, 1000);
        var currentSimpleSpecialCodeInUrl = getUrlParameter("simpleSpecialCode");
        if (currentSimpleSpecialCodeInUrl !== undefined && currentSimpleSpecialCodeInUrl !== "") {
            $(document).trigger('smc.disable.cylinderConfigurator');
            $("#series_hto_simple_special").text(currentSimpleSpecialCodeInUrl);
            $(".cylinder-info-container__content__actions").removeClass("hidden");
        }

        function checkPitwIsLoaded() {
            try {
                var pitwIsLoaded = $("#pitw-wrapper").is(":visible")
                if (pitwIsLoaded) {
                    loadAccessoriesFromUrlProjectInfo();
                } else {
                    setTimeout(checkPitwIsLoaded, 100);
                }
            } catch (e) {
                console.log("Error checking ChangesInConfigurator", e)
            }
        }

        checkPitwIsLoaded();
    }

    function _onPartNumberUpdatedCylinder() {
        console.debug("[_onPartNumberUpdatedCylinder]");
        this.loadSummaryTable(false);
        if ($("#aareo_configuration-summary_accesory_summary-list") !== undefined || isRodEndConfigured()) {
            if (!configurationHasAccessories() && !isRodEndConfigured()
                && $("#without-position__collapse .aareo_accesory_no_position_row").length === 0) {
                hideAccessoriesSelectionSummary();
                hideCreateSimpleSpecialButtons();
            } else {
                if (configurationHasAccessories()) {
                    showAccessoriesSelectionSummary();
                }
                if ($(".rodEndRow .formStatusNO_OK").length === 0 && $("#accesoriesAndRodEndOptionsSwitchToggle").is(":checked")) {
                    showCreateSimpleSpecialButtons();
                } else if ($(".rodEndRow .formStatusNO_OK").length > 0) {
                    hideCreateSimpleSpecialButtons();
                }
            }
            this.showCylinderType();
        }
        // if ($("#aareo__create-single-special") !== undefined && $("#aareo__create-single-special").is(":visible")
        //     && !$("#accesoriesAndRodEndOptionsSwitchToggle").is(":checked")){
        //     $("#accesoriesAndRodEndOptionsSwitchToggle").click();
        // }
    }

    function showAliasModal() {
        console.log("[Cylinder-configurator] showAliasModal");
        var confirm = $("#createCustomerAliasModal");
        this.$aliasInput.val($("#configuration_details__alias__value").text());
        confirm.modal('show');
    }

    function aliasFinish() {
        if (this.$aliasInput.val().trim() !== "") {
            $("#configuration_details__alias__value").text(this.$aliasInput.val().trim());
            var confirm = $("#createCustomerAliasModal");
            confirm.modal('hide');

            this.$aliasModalButton.addClass("hidden");

            smc.NotifyComponent && smc.NotifyComponent.info(this.config.messages.aliasCreated);
        }
    }

    function createAlias() {
        console.debug("[CylinderConfigurator - createAlias]");
        var _self = this;
        _self.hideError();
        var url = globalConfig.CylinderConfigurator.urls.createSimpleSpecialAlias;
        var alias = $("#alias").val();
        var simpleSpecialCode = $("#sscw__info_table__simple_special_code").text();
        var data = {
            alias: alias,
            simpleSpecialCode: simpleSpecialCode
        };

        $.get(url, data)
            .then(function (response) {
                if (response === "SUCCESS") {
                    _self.aliasFinish();
                } else {
                    _self.showError();
                    $("#alias-error-message").text($("#sscw_modal_general_error").text());
                    $(".sscw-message-error").removeClass("hidden");
                }
            })
            .catch(function (error) {
                console.debug("Alias creation error" + error);
                _self.showError();
                $("#alias-error-message").text($("#sscw_modal_general_error").text());
                $(".sscw-message-error").removeClass("hidden");
                // _self.enableElement(_self.$acceptButton);
            }).always(function () {

        }.bind(this));
    }

    function parseAccesories() {
        console.debug("[CylinderConfigurator - parseAccessories]");
        var accessories = [];
        $("#aareo_configuration-summary_accesory_summary-list .aareo_accesory_summary_element").each(function () {
            var partNumber = $(this).attr("partnumber-value");
            var currentZone = $(this).attr("zone-value");
            var currentDescription = $(this).find(".aareo_accesory_summary_row_description").text();
            var accessory = {partNumber: partNumber, position: currentZone, description: currentDescription};
            accessories.push(accessory);
        });
        $("#aareo_configuration-summary_accesory_no_position_summary-list .aareo_accesory_no_position_row").each(function () {
            var partNumber = $(this).attr("partnumber-value");
            var currentZone = $(this).attr("zone-value");
            var currentDescription = $(this).find(".aareo_accesory_summary_row_description").text();
            var currentQuantity = $(this).find(".aareo_accesory_summary_row_description").text();
            for (i = 0; i < parseInt(currentQuantity); i++) {
                let accessory = {
                    partNumber: partNumber,
                    position: currentZone,
                    description: currentDescription
                };
                accessories.push(accessory);
            }
        });
        return accessories;
    }

    function _exportBom() {
        console.debug("[CylinderConfigurator - exportBom]");
        var productId = getUrlParameter("productId");
        var partNumber = getUrlParameter("partNumber");
        var seriesCode = $("#product_series_code").val();
        var _self = this;
        var rodEnd = getRodEndCode() + "##" + getRodEndPosition();
        var rodEndConf = getUrlParameter("rodEndConf");
        var data = {
            productId: productId,
            partNumberSel: partNumber,
            seriesCode: seriesCode,
            rodEnd: rodEnd,
            rodEndConf: rodEndConf,
            accessories: JSON.stringify(_self.parseAccesories())
        };
        var openReference = window.open(smc.channelPrefix + '/loading-page', '_blank');
        var url = globalConfig.CylinderConfigurator.urls.exportBomURL;
        $.get(url, data)
            .then(function (response) {
                if (response.url && response.url !== undefined && response.url !== null && response.url !== "") {
                    //Remove spinner & set File Ready
                    $('.loading', openReference.document).hide();
                    $('.loaded ', openReference.document).show();
                    openReference.location = response.url;
                }
                // _self.enableElement(_self.$zipDownloadButton);
            })
            .catch(function (error) {
                console.debug("zipDownload error" + error);
                if (!(window.isIOS || window.isIE || window.isEdge)) openReference.close();
            }).always(function () {
            setTimeout(function () {
                if (!(window.isIOS || window.isIE || window.isEdge)) openReference.close();
            }, 1500);
        }.bind(this));
    }

    function loadSummaryTable(force, rodEndConfStatus) {
        console.log("loadSummaryTable() - Start");
        var _self = this;
        var currentPNAccesories = "";
        var currentRodEndConf = "";
        setTimeout(function () {
            if (configuratorOptionsEnabled) {
                // if (rodEndConfStatus !== undefined && rodEndConfStatus === false && partNumberString.indexOf("-XA") > -1) {
                //     console.log("loadSummaryTable() - Invalid rod end configuration");
                //     showWarningMessageForInvalidConfiguration(_self);
                //     $("#sscw__selection_table_pricesConfirm").empty();
                //     $("#sscw__selection_table_summary_wrapper .sscw__selection_table").empty();
                // } else {
                    currentPNAccesories = _self.getCurrentRodEndAccesoriesPN();
                    currentRodEndConf = getUrlParameter("rodEndConf");

                    console.log("loadSummaryTable() - force=" + force + " rodEndConfStatus=" + rodEndConfStatus + " currentPNAccesories=" + currentPNAccesories + " currentRodEndConf=" + currentRodEndConf);

                if (rodEndConfStatus === undefined || partNumberString.indexOf("-XA") > -1 || _self.currentLoadingSummaryPN !== currentPNAccesories) {
                    // if (force || _self.currentLoadingSummaryPN !== currentPNAccesories) {
                    if (force || _self.currentLoadingSummaryPN !== currentPNAccesories || _self.currentLoadingRodEndConf !== currentRodEndConf) {
                        console.log("loadSummaryTable() - Forced or configuration change detected");

                        //try not to load multiple times the same summary on reading change event
                        _self.currentLoadingSummaryPN = currentPNAccesories;
                        _self.currentLoadingRodEndConf = currentRodEndConf;

                        if ($("#cpn_partnumber").hasClass("status-complete") && !$("#sscw__selection_table_summary_wrapper").hasClass("hidden")) {
                            console.log("loadSummaryTable() - Configuration is complete");

                            showWarningMessageForInvalidConfiguration(_self);

                            $("#sscw__selection_table_pricesConfirm").empty();
                            $("#sscw__selection_table_summary_wrapper .sscw__selection_table").empty();
                            var partNumber = getUrlParameter("partNumber");
                            var rodEnd = getRodEndCode();
                            var seriesCode = $("#product_series_code").val();
                            var accessories = encodeURIComponent(JSON.stringify(_self.getAddedAccesoryList()));
                            var mounted = $("#mounted_summary").prop("checked");
                            var data = {
                                partNumberSel: partNumber,
                                rodEndSel: rodEnd,
                                rodEndConfSel: currentRodEndConf,
                                seriesCode: seriesCode,
                                accessories: accessories,
                                mounted: mounted
                                // descriptions: _self.getAddedAccesoryDescriptionsList()
                            };
                            addSearchingSpinner("#sscw__confirmConfiguration .sscw__loading_spinner");
                            addSearchingSpinner("#sscw__selection_table_summary_wrapper .sscw__loading_spinner");
                            var url = document.getElementById('getCylinderSummaryTableLink').href;

                            var urlSimpleSpecialCode = getUrlParameter("simpleSpecialCode");
                            if (urlSimpleSpecialCode == undefined || urlSimpleSpecialCode == '') {
                                url = getURLRemoveParam(url, "simpleSpecialCode");
                            }

                            _self.updateSummaryCallCount = _self.updateSummaryCallCount + 1;
                            var currentUpdateSummaryCallCount = _self.updateSummaryCallCount;

                            console.log("loadSummaryTable() - Calling get summary (" + currentUpdateSummaryCallCount + ") with data", url, data);

                            $.get(url, data)
                                .then(function (response) {
                                    console.log("loadSummaryTable() - Data obtained (" + currentUpdateSummaryCallCount + ")", _self.updateSummaryCallCount);

                                    if (currentUpdateSummaryCallCount === _self.updateSummaryCallCount) {
                                        if (!isConfigurationValid()) {
                                            console.log("loadSummaryTable() - Configuration is not valid on data obtention");

                                            showWarningMessageForInvalidConfiguration(_self);
                                        } else {
                                            if (response !== undefined && response !== "") {
                                                $(".sscw__selection_table").html(response);
                                                $("#sscw__selection_table_pricesConfirm").html(response);
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

                                        showWarningMessageForInvalidConfiguration(_self);
                                    } else {
                                        console.log("loadSummaryTable() - Error but another call made", error);
                                    }
                                });
                        } else {
                            console.log("loadSummaryTable() - Configuration is NOT complete");
                        }
                    } else {
                        console.log("loadSummaryTable() - Same configuration as result shown");
                    }
                }
                // }
            }
            console.log("loadSummaryTable() - Finish");
        }, 600);

    }

    function showWarningMessageForInvalidConfiguration(_self) {
        if (!isConfigurationValid()) {
            if (isConfigurationComplete()) {
                $(".sscw__selection_table").html(_self.config.messages.completeRodEndConfigToViewPrices);
                $("#sscw__selection_table_pricesConfirm").html(_self.config.messages.completeRodEndConfigToViewPrices);
            } else {
                $(".sscw__selection_table").html(_self.config.messages.completeConfigToViewPrices);
                $("#sscw__selection_table_pricesConfirm").html(_self.config.messages.completeConfigToViewPrices);
            }
        }
    }

    function selectWorkingZone(selectedZone) {
        console.log("[CylinderConfigurator - selectWorkingZone]");
        $(".aareo__cylinder__part_position_js").removeClass("selected");
        $(".aareo__cylinder__images_part_image img").addClass("hidden");
        var selectedZoneStr = $(selectedZone).attr("data-value");
        $(".aareo__cylinder__images_part_image_" + selectedZoneStr).removeClass("hidden");
        $(selectedZone).addClass("selected");
        $(".builder").hide();
        if ($(selectedZone).parent().hasClass("aareo__cylinder__part_rodEnd")) {
            if ($("#accesoriesAndRodEndOptionsSwitchToggle").is(":checked")) {
                $(".aareo__choose-add-modify").removeClass("hidden");
            }
            $(".aareo__choose-accesory").addClass("hidden");
            $(".aareo__another-reference").addClass("hidden");


            if (isRodEndConfigured()) {
                if (!$("#accesoriesAndRodEndOptionsSwitchToggle").is(":checked")) {
                    $("#accesoriesAndRodEndOptionsSwitchToggle").click();
                }

                this.$modifyRodEndButton.click();
            } else {
                hideRodEndConfigurationform();
                if ($(".aareo__cylinder__part_rodEnd .aareo__cylinder__part_position_js .selected") !== undefined
                    && $(".aareo__cylinder__part_rodEnd .aareo__cylinder__part_position_js.selected").length > 0) {
                    hideChooseAccessory();
                }
            }

        } else {
            $(".aareo__choose-add-modify").addClass("hidden");
            $(".aareo__choose-accesory").removeClass("hidden");
            $(".aareo__another-reference").removeClass("hidden");
        }
        if ($(".aareo__cylinder__part_rodEnd .aareo__cylinder__part_position_js .selected") !== undefined
            && $(".aareo__cylinder__part_rodEnd .aareo__cylinder__part_position_js.selected").length > 0) {
            hideChooseAccessory();
        }
        this.loadAccesories(false);
    }

    function addAccesory() {
        console.log("[CylinderConfigurator - addAccesory]");
        $(".aareo__choose-accesory").removeClass("hidden");
        $(".aareo__another-reference").removeClass("hidden");
        hideRodEndConfigurationform();
        this.loadAccesories(true);
        showChooseAccessory();
        resetRodEndConf();
    }

    function modifyRodEnd() {
        console.log("[CylinderConfigurator - modifyRodEnd]");
        var _self = this;
        $(".aareo__choose-accesory").addClass("hidden");
        $(".aareo__another-reference").addClass("hidden");
        showRodEndConfigurationForm();
        //Clean accesories from this zone
        var currentZone = _self.getSelectedZone();
        if ($(".aareo_accesory_summary_element[zone-value='" + currentZone + "']") !== undefined
            && $(".aareo_accesory_summary_element[zone-value='" + currentZone + "']").length > 0) {
            var idToRemove = $(".aareo_accesory_summary_element[zone-value='" + currentZone + "']").get(0).id;
            removeAccesoryFromSummary(idToRemove);
            $(".aareo_accesory_summary_element[zone-value='" + currentZone + "']").remove();
        }
    }


    function loadAccesories(fromAddAccesory) {
        console.log("[CylinderConfigurator - loadAccesories]");
        var _self = this;
        $("#aareo__choose-accesory .alert-info").addClass("hidden");

        var productId = getUrlParameter("productId");
        var partNumber = getUrlParameter("partNumber");
        var rodEndConf = getUrlParameter("rodEndConf");
        var seriesCode = $("#product_series_code").val();
        var selectedZone = getSelectedZone();

        if (selectedZone && partNumber && selectedZone != "" && partNumber != "") {
            addSearchingSpinner(".aareo_configuration_part .sscw__loading_spinner");
            $("#sscw_spares-accessories-result-container").empty();
            var $msgBody = $("#sscw_spares-accessories-result-container");
            //this line is needed?
            if (partNumber !== undefined && partNumber !== "") {
                partNumber = partNumber.replace("-" + rodEndConf, "");
            }
            var url = document.getElementById('getAccessoryListByZoneLink').href;
            url = getURLRemoveParam(url, "partNumber");
            url = getURLRemoveParam(url, "productId");
            var data = {
                componentId: this.id,
                productId: productId,
                partNumber: partNumber,
                rodEndConf: rodEndConf,
                seriesCode: seriesCode,
                selectedZone: selectedZone
            };

            $.get(url, data)
                .then(function (response) {
                    $msgBody.empty();
                    $msgBody.append($(response));
                    if ($(".spare-accessory-item").size() === 0) {
                        $("#aareo__choose-accesory .alert-info").removeClass("hidden");
                    }
                    _self.addAccesoryListeners();
                    emptySearchingSpinner(".aareo_configuration_part .sscw__loading_spinner");

                    if ($(".aareo__cylinder__part_rodEnd .aareo__cylinder__part_position_js .selected") !== undefined
                        && $(".aareo__cylinder__part_rodEnd .aareo__cylinder__part_position_js.selected").length > 0 && !fromAddAccesory) {
                        hideChooseAccessory();
                    }

                    if ($("#aareo_configuration-summary_accesory_summary-list .aareo_accesory_summary_element[zone-value='" + selectedZone + "']") !== undefined
                        && $("#aareo_configuration-summary_accesory_summary-list .aareo_accesory_summary_element[zone-value='" + selectedZone + "']").length > 0) {
                        var alreadySelectedPN = $("#aareo_configuration-summary_accesory_summary-list .aareo_accesory_summary_element[zone-value='" + selectedZone + "']").attr("partnumber-value");
                        if (alreadySelectedPN !== "") {
                            $(".aareo__choosen_accesory[value='" + alreadySelectedPN + "']").click();
                        }
                    }
                })
                .catch(function (error) {
                    console.debug("loadAccesories error" + error);
                    $("#aareo_configuration_part .alert-info").removeClass("hidden");
                    emptySearchingSpinner(".aareo_configuration_part .sscw__loading_spinner");
                }).always(function () {
                emptySearchingSpinner(".aareo_configuration_part .sscw__loading_spinner");
            }.bind(this));
        }
    }

    function addAccesoryListeners() {
        console.log("[CylinderConfigurator - addAccesoryListeners]");
        var _self = this;
        $(".aareo__choosen_accesory").each(function () {
            $(this).change(function () {
                var selectedZone = _self.getSelectedZone();
                var currentRowContainer = $(this).parent().parent().parent();
                if ($(this).is(":checked")) {
                    //Add accesory to zone
                    showAccessoriesSelectionSummary();
                    _self.addAccesoryToSummary(this, currentRowContainer, selectedZone);
                }/*else {
                    //remove accesory from zone
                   var partNumber = $(currentRowContainer).find(".partNumberLabel").text();
                   removeAccesoryFromSummary(partNumber);
               }*/
            });
        });
    }

    function addAccesoryToSummary(accesory, currentRowContainer, selectedZone) {
        console.log("[CylinderConfigurator - addAccesoryToSummary]");
        var _self = this;
        var partNumberAcc = $(currentRowContainer).find(".partNumberLabel").text().trim();
        var description = $(currentRowContainer).find(".descriptionLabel").text().trim();
        var group = $(currentRowContainer).find(".groupLabel").text().trim();
        _self.addAccessoryData(partNumberAcc, description, group, selectedZone);
    }

    function addAccessoryData(partNumberAcc, description, group, selectedZone) {
        if ($("#aareo_accesory_summary_" + partNumberAcc.replace('+', '\\+') + "_" + selectedZone) !== undefined
            && $("#aareo_accesory_summary_" + partNumberAcc.replace('+', '\\+') + "_" + selectedZone).length > 0) {
            return;
        }
        var _self = this;
        var data = {
            componentId: this.id,
            partNumberAcc: partNumberAcc,
            partNumber: getUrlParameter("partNumber"),
            group: group,
            description: description,
            selectedZone: selectedZone
        };
        var url = document.getElementById('getAccessorySummaryRowLink').href;
        url = getURLRemoveParam(url, "partNumber");

        $.get(url, data)
            .then(function (response) {
                // var replacedHtml = response.replace("{{aareo_accesory_image}}",imageHtml);
                $("#aareo_configuration-summary_accesory_summary-list").append(response);
                //remove other selected pns in the same zone
                addAccesoryToProjectSummary(partNumberAcc, selectedZone, true);
                $("#aareo_configuration-summary_accesory_summary-list .aareo_accesory_summary_element").each(function () {
                    if ($(this).attr("zone-value") === selectedZone && this.id !== "aareo_accesory_summary_" + partNumberAcc + "_" + selectedZone) {
                        removeAccesoryFromSummary(this.id);
                    }
                });
                showCreateSimpleSpecialButtons();
                reloadHTOAccesoryList();
                _self.loadSummaryTable();
                emptySearchingSpinner(".aareo_configuration-summary .sscw__loading_spinner");
                if ($("#series_hto_simple_special").text() !== "") {
                    $(".aareo_accesory_summary_row_buttons_delete_container").addClass("hidden");
                    $(".cylinder-info-container__content__actions").removeClass("hidden");
                }
                $("#pdfReportBtn").removeAttr("disabled");
                $(document).trigger('smc.productToolbar.reloadPreview');
                $(document).trigger('smc.partNumber.changed');
            })
            .catch(function (error) {
                console.debug("addAccesoryToSummary error" + error);
                emptySearchingSpinner(".aareo_configuration-summary .sscw__loading_spinner");
            }).always(function () {
            emptySearchingSpinner(".aareo_configuration-summary .sscw__loading_spinner");
        }.bind(this));
    }

    function getAddedAccesoryList() {
        var accessories = [];
        $("#aareo_configuration-summary_accesory_summary-list .aareo_accesory_summary_element").each(function () {
            var partNumber = $(this).attr("partnumber-value");
            var quantity = $(this).find(".aareo_accesory_summary_row_quantity").text();
            var description = $(this).find(".aareo_accesory_summary_row_description").text();
            if (partNumber !== "") {
                var accessory = {partNumber: partNumber, quantity: quantity, description: description};
                accessories.push(accessory);
            }
        });
        $("#without-position__collapse .aareo_accesory_no_position_row").each(function () {
            //FIXME
            var partNumber = $(this).attr("partnumber-value");
            var quantity = $(this).find(".aareo_accesory_summary_row_quantity").text();
            var description = $(this).find(".aareo_accesory_summary_row_description").text();
            if (partNumber !== "") {
                var accessory = {partNumber: partNumber, quantity: quantity, description: description};
                accessories.push(accessory);
            }
        });
        return accessories;
    }

    function getAddedAccesoryDescriptionsList() {
        var descriptions = "";
        $("#aareo_configuration-summary_accesory_summary-list .aareo_accesory_summary_row_description").each(function () {
            var description = $(this).text();
            if ("" !== descriptions) {
                descriptions += "###";
            }
            descriptions += description;
        });
        $("#without-position__collapse .aareo_accesory_no_position_row").each(function () {
            var partNumber = $(this).attr("partnumber-value");
            var quantity = $(this).find(".aareo_accesory_summary_row_quantity").text();
            var description = $(this).find(".aareo_accesory_summary_row_description").text();
            for (i = 0; i < parseInt(quantity); i++) {
                if ("" !== descriptions) {
                    descriptions += "###";
                }
                descriptions += description;
            }
        });
        return descriptions;
    }

    function addReference() {
        console.log("[CylinderConfigurator - addReference]");
        var referenceTrm = $("#aareo__add-reference_reference").val().toUpperCase();
        var referenceTrmId = referenceTrm.replace(".", "_").replace(",", "_").replace(" ", "_");
        var referenceDescription = $("#aareo__add-reference_product_description").val();
        this.addReferenceData(referenceTrm, referenceTrmId, referenceDescription);
        $("#pdfReportBtn").removeAttr("disabled");
    }

    function addReferenceData(referenceTrm, referenceTrmId, referenceDescription) {
        console.log("[CylinderConfigurator - addReferenceData]");
        // Old version. Add by reference without zone and without checking anything
        // if (referenceTrm !== undefined && referenceTrm.trim() !== "") {
        //     // if ($("#aareo_configuration-summary_accesory_no_position_summary-list").is(":empty")){
        //     //     var headerTemplate = $("#aareo_accesory_summary_no_position_header_template").html();
        //     //     $("#aareo_configuration-summary_accesory_no_position_summary-list").append(headerTemplate);
        //     // }
        //     if ($("#aareo_accesory_summary_" + referenceTrmId).text() !== "") {
        //         var quantity = parseInt($("#aareo_accesory_summary_" + referenceTrmId + " .aareo_accesory_summary_row_quantity").text());
        //         quantity++;
        //         $("#aareo_accesory_summary_" + referenceTrmId + " .aareo_accesory_summary_row_quantity").text(quantity);
        //         if (referenceDescription !== "" && referenceDescription !== "-") {
        //             $("#aareo_accesory_summary_" + referenceTrmId + " .aareo_accesory_summary_row_description").text(referenceDescription);
        //         }
        //     } else {
        //         var rowDataTemplate = this.accessorySummaryNoPositionTemplate;
        //         rowDataTemplate = rowDataTemplate.replace("{{aareo_accesory_partNumber}}", referenceTrm);
        //         rowDataTemplate = rowDataTemplate.replace("{{aareo_accesory_partNumber_remove}}", referenceTrmId);
        //         rowDataTemplate = rowDataTemplate.replace("{{aareo_accesory_partNumber_id}}", referenceTrmId);
        //         rowDataTemplate = rowDataTemplate.replace("{{aareo_accesory_header_partNumber}}", referenceTrm);
        //         rowDataTemplate = rowDataTemplate.replace("{{aareo_accesory_description}}", referenceTrm);
        //         $("#without-position__collapse").append(rowDataTemplate);
        //         if (referenceDescription !== "" && referenceDescription !== "-") {
        //             $("#aareo_accesory_summary_" + referenceTrmId + " .aareo_accesory_summary_row_description").text(referenceDescription);
        //         }
        //     }
        //     showAccessoriesSelectionSummary();
        //     $(".aareo__another-reference .alert-info").removeClass("hidden");
        //     showCreateSimpleSpecialButtons();
        //     reloadHTOAccesoryList();
        //     addAccesoryToProjectSummary(referenceTrm, "no-position", false);
        //     // $(document).trigger('smc.partNumber.changed');
        //     $(".accordion__item--without-position").removeClass("hidden");
        //     setTimeout(function () {
        //         $(".aareo__another-reference .alert-info").addClass("hidden");
        //     }, 4000);
        // }

        //new Version. Validate PN
        var _self = this;
        var selectedZone = getSelectedZone();
        // if (($("#aareo_accesory_summary_"+referenceTrm+"_"+selectedZone) !== undefined && $("#aareo_accesory_summary_"+referenceTrm+"_"+selectedZone).length > 0)){
        //     return;
        // }
        _self.$addReferenceBtn.attr("disabled", "disabled");
        addSearchingSpinner("#btn-submit-reference .sscw__loading_spinner");

        if (referenceDescription === "" || referenceDescription === undefined) {
            referenceDescription = $("#aareo_accesory_summary_no_position_template_default_description").text().replace("{{aareo_accesory_description}}", referenceTrm);
        }

        var data = {
            componentId: this.id,
            productId: getUrlParameter("productId"),
            partNumber: getUrlParameter("partNumber"),
            referenceTrm: referenceTrm,
            referenceTrmId: referenceTrmId,
            description: referenceDescription,
            selectedZone: selectedZone
        };
        var url = new URL(document.getElementById('getReferenceSummaryRowLink').href);
        url.searchParams.delete("partNumber");
        url.searchParams.delete("productId");
        $.get(url, data)
            .then(function (response) {
                if (response === "") {
                    $(".aareo__another-reference .not-added-info").removeClass("hidden");
                    setTimeout(function () {
                        $(".aareo__another-reference .not-added-info").addClass("hidden");
                    }, 4000);
                    _self.$addReferenceBtn.removeAttr("disabled");
                    emptySearchingSpinner(".aareo_configuration-summary .sscw__loading_spinner");
                    emptySearchingSpinner("#btn-submit-reference .sscw__loading_spinner");
                    return;
                }
                //remove other selected pns in the same zone
                $("#aareo_configuration-summary_accesory_summary-list .aareo_accesory_summary_element").each(function () {
                    if ($(this).attr("zone-value") === selectedZone) {
                        removeAccesoryFromSummary(this.id);
                    }
                });
                $("#aareo_configuration-summary_accesory_summary-list").append(response);
                addAccesoryToProjectSummary(referenceTrm, selectedZone, true);
                showCreateSimpleSpecialButtons();
                reloadHTOAccesoryList();
                _self.loadSummaryTable();
                if ($("#series_hto_simple_special").text() !== "") {
                    $(".aareo_accesory_summary_row_buttons_delete_container").addClass("hidden");
                    $(".cylinder-info-container__content__actions").removeClass("hidden");
                }
                $("#pdfReportBtn").removeAttr("disabled");
                showAccessoriesSelectionSummary();
                $(".aareo__another-reference .added-info").removeClass("hidden");
                setTimeout(function () {
                    $(".aareo__another-reference .added-info").addClass("hidden");
                }, 4000);
                _self.$addReferenceBtn.removeAttr("disabled");
                $(document).trigger('smc.productToolbar.reloadPreview');
            })
            .catch(function (error) {
                console.debug("addAccesoryToSummary error" + error);
                $(".aareo__another-reference .not-added-info").removeClass("hidden");
                setTimeout(function () {
                    $(".aareo__another-reference .not-added-info").addClass("hidden");
                }, 4000);
                _self.$addReferenceBtn.removeAttr("disabled");
            }).always(function () {
            emptySearchingSpinner(".aareo_configuration-summary .sscw__loading_spinner");
            emptySearchingSpinner("#btn-submit-reference .sscw__loading_spinner");
        }.bind(this));
    }

    function loadConfigurationFromSimpleSpecial(simpleSpecialCode) {
        console.debug("[CylinderConfigurator -loadConfigurationFromSimpleSpecial] init");
        // var simpleSpecialCode = $("#series_hto_simple_special").text();
        var _self = this;
        if (simpleSpecialCode !== "") {
            $("#aareo_configuration-summary_accesory_summary-list").empty();
            $("#series_hto_simple_special").text(simpleSpecialCode);
            $(".cylinder-info-container__content__actions").removeClass("hidden");
            if (simpleSpecialCode !== undefined && simpleSpecialCode !== "") {
                $("#idbl_hto_wrapper .idbl_hto").removeClass("idbl_hto--cc");
                $("#idbl_hto_wrapper .idbl_hto").addClass("idbl_hto--ccss");
            }
            var data = {
                simpleSpecialCode: simpleSpecialCode
            };
            var url = document.getElementById('getSimpleSpecialFromCodeLink').href;
            $.get(url, data)
                .then(function (response) {
                    if (response !== undefined && response !== "") {
                        loadConfigurationFromSimpleSpecialInfo(response);
                    }
                })
                .catch(function (error) {
                    console.debug("[CylinderConfigurator - loadConfigurationFromSimpleSpecial] error" + error);
                });
        }
    }

    function loadConfigurationFromSimpleSpecialInfo(data) {
        console.debug("[CylinderConfigurator -loadConfigurationFromSimpleSpecial] Loaded: ", data);
        var _self = this;
        var customerNumber = data.customerNumber;
        var currentPartNumber = getUrlParameter("partNumber");
        var accessories = data.projectInfo.accessories;
        var configurationFound = false;
        var accessoryFound = false;
        var simpleSpecialCode = data.simpleSpecialCode;
        $("#series_hto_simple_special").text(simpleSpecialCode);
        $(".cylinder-info-container__content__actions").removeClass("hidden");
        for (var i = 0; i < accessories.length; i++) {
            var accessory = accessories[i];
            if (accessory !== undefined) {
                var zone = accessory.position;
                var partNumber = accessory.partNumber;
                var description = accessory.description;
                var itemGroup = accessory.itemGroup;
                if (zone !== undefined && zone !== "no-position" && zone !== "") {
                    _self.addAccessoryData(partNumber, description, itemGroup, zone);
                } else {
                    _self.addReferenceData(partNumber, partNumber, description);
                }
                configurationFound = true;
                accessoryFound = true;
            }
        }
        if (data.rodEnd !== "") {
            configurationFound = true;
        }
        if (configurationFound) {
            if (!$("#accesoriesAndRodEndOptionsSwitchToggle").is(":checked")) {
                $("#accesoriesAndRodEndOptionsSwitchToggle").click();
            }

            if (accessoryFound) {
                showAccessoriesSelectionSummary();
            }

            $("#configuration_details__simpleSpecial_value").text(data.simpleSpecialCode);

            if (data.mounted == true) {
                $("#configuration_details__mounted_value").removeClass("hidden");
                $("#mounted").prop('checked', true);
                $("#mounted_summary").prop('checked', true);
            } else {
                $("#configuration_details__mounted_value").addClass("hidden");
            }

            $("#configuration_details__customerNumber_value").text(data.customerNumber);
            $("#configuration_details__endUserCode_value").text(data.projectInfo.solicitorName);
            $("#configuration_details__customerName_value").text(data.projectInfo.customerName);
            $("#configuration_details__endUserName_value").text(data.projectInfo.solicitorName);
            $("#projectDescription").val(data.projectInfo.projDesc);
            $("#sscw__info_table__customer_code").text(data.customerNumber);
            $("#sscw__info_table__customer_name").text(data.projectInfo.customerName);
            $(".cylinder-info-container__configuration_details__info").removeClass("hidden");
            $(document).trigger('smc.partNumber.changed');
            $(document).trigger('smc.disable.cylinderConfigurator');
            // var rodEndConf = window.smc.productConfiguratorComponent.getRodEndModificationConfigurationValuesInString();
            var rodEndConf = data.projectInfo.rodEndConf;
            if (rodEndConf === "") {
                var url = new URL(window.location.href);
                url.searchParams.delete('rodEndConf');
                window.history.replaceState({}, window.document.title, url.toString());
            }
        }
    }

    function resetAccessoriesSelection() {
        removeAllAccessoriesFromSummary();

        // Return to C zone
        $(".aareo__cylinder__part_rodEnd a").click();
    }

    function showCylinderType() {
        console.log("[CylinderConfigurator] showCylinderType", window.partNumberString);
        // if (typeof window.partNumberString === undefined) {
        //     return;
        // }
        //
        // var partNumber = window.partNumberString;

        var conditions = [];

        $(".cylinder_type_part_container").each(function () {
            var cylinderTypeConditions = {};
            cylinderTypeConditions.id = $(this).attr('id');
            cylinderTypeConditions.typeConditions = [];

            $("#" + $(this).attr('id') + "_conditions span").each(function () {
                var condition = $(this).html().split("=");
                cylinderTypeConditions.typeConditions.push(condition);
            });
            conditions.push(cylinderTypeConditions);
        });

        var possibleCylinderTypeList = [];

        conditions.forEach(function (condition) {
            var allConditionsMeet = true;
            condition.typeConditions.forEach(function (currCondition) {
                var domainList = window.oDomains.domains;
                var currConditionKey = currCondition[0];
                var currConditionValue = currCondition[1];
                var currentConditionIsMeet = false;
                for (var currDomain in domainList) {
                    var domainElement = window.oDomains.domains[currDomain];
                    if (domainElement.code === currConditionKey) {
                        //KEY FOUND, must compare value
                        var specList = window.buildSpecList();
                        var currSpecSupposedEntry = "(\"" + currDomain + "\",\"" + currConditionValue + "\")";
                        if (specList.indexOf(currSpecSupposedEntry) >= 0) {
                            //found!
                            currentConditionIsMeet = true;
                        }
                    }
                }
                if (!currentConditionIsMeet) {
                    allConditionsMeet = false;
                }
            });

            if (allConditionsMeet) {
                possibleCylinderTypeList.push(condition.id);
            }
        });

        if (possibleCylinderTypeList.length == 0 && conditions.length > 0) {
            possibleCylinderTypeList.push(conditions[0].id);
        } else if (conditions.length === 0 && $(".cylinder_type_part_container").length > 0) {
            possibleCylinderTypeList.push($(".cylinder_type_part_container")[0].id);
        }

        // TODO: Show first cylinder type of possibleCylinderTypeList
        if (possibleCylinderTypeList.length > 0) {
            $(".cylinder_type_part_container").addClass("hidden");
            $("#" + possibleCylinderTypeList[0]).removeClass("hidden");
        }
    }

    function getSelectedZone() {
        var selected = "";
        $(".aareo__cylinder__part_position_js.selected").each(function () {
            selected = $(this).data("value");
        });
        return selected;
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

    function hideError() {
        $('.addSearchingSpinner').addClass("hidden");
        // $('#alert-wizard-text-message').text("");
        $(".sscw-message-error").addClass("hidden");
        $("#wizard-error-message").text("");
    }

    function showError() {
        // $('#alert-wizard-text-message').text(message);
        $('.error-wizard-text').removeClass("hidden");
    }

    function getRodEndCode() {
        //we have to check if there is rod End to separate it from the partNumber
        var rodEnd = "";
        if ($("#rodEndOptionsSwitchToggle").is(":checked")) {
            var selectedImage = $(".XRodImage.image_sel_class_selected").first();
            if (selectedImage !== undefined && selectedImage.length > 0) {
                // rodEnd = partNumber.substr(partNumber.lastIndexOf("-")+1);
                rodEnd = $(selectedImage).attr("re_code");
                // partNumber = partNumber.replace("-"+rodEnd,"");
            }
        }
        return rodEnd;
    }

    function getRodEndPosition() {
        if ($(".aareo__cylinder__part_rodEnd .btn") !== undefined && $(".aareo__cylinder__part_rodEnd .btn").length > 0) {
            return $(".aareo__cylinder__part_rodEnd .btn").first().attr("data-value");
        }
        return "";
    }

    function getCurrentRodEndAccesoriesPN() {
        return $("#cylinder-info-container__partnumber_title__cylinder").text() + $("#cylinder-info-container__partnumber_title__accesories").text();
    }

    function resetRodEndConf() {
        $(".builder input:checked").click();
        $(".rod_sel_images_container img").first().click();
        $(document).trigger('smc.partNumber.changed');
    }

    function loadAccessoriesFromUrlProjectInfo() {
        let currentUrl = new URL(window.location.href);
        var urlAccessories = currentUrl.searchParams.get("accessories");
        if (urlAccessories) {
            var accessories = JSON.parse(decodeURIComponent(urlAccessories));
            var isMounted = currentUrl.searchParams.get("mounted") === 'true';
            console.debug("[CylinderConfigurator -loadAccessoriesFromUrlProjectInfo] Loaded: ", accessories);
            for (var i = 0; i < accessories.length; i++) {
                var accessory = accessories[i];
                if (accessory !== undefined) {
                    var zone = accessory.position;
                    var partNumber = accessory.partNumber;
                    var description = accessory.description;
                    var itemGroup = accessory.itemGroup;
                    if (zone !== undefined && zone !== "no-position" && zone !== "") {
                        addAccessoryData(partNumber, description, itemGroup, zone);
                    } else {
                        addReferenceData(partNumber, partNumber, description);
                    }
                }
            }
            let $accesoriesAndRodEndOptionsSwitchToggle = $("#accesoriesAndRodEndOptionsSwitchToggle");
            $accesoriesAndRodEndOptionsSwitchToggle.prop("disabled", false)
            if (!$accesoriesAndRodEndOptionsSwitchToggle.is(":checked")) {
                $accesoriesAndRodEndOptionsSwitchToggle.click();
            }
            showAccessoriesSelectionSummary();
            if (isMounted) {
                $("#mounted").prop('checked', true);
                $("#mounted_summary").prop('checked', true);
            }
        }
    }

    function copySSPartNumberToClipboard(event) {
        if (event) event.preventDefault();

        var simpleSpecialCode = $("#series_hto_simple_special").text();
        console.debug('[CylinderConfigurator]', 'copySSPartNumberToClipboard', 'SS=', simpleSpecialCode);
        if (!simpleSpecialCode) return;

        var $temp = $("<input>");
        $("body").append($temp);
        $temp.val(simpleSpecialCode).select();
        document.execCommand("copy");
        $temp.remove();

        smc.NotifyComponent && smc.NotifyComponent.info(this.config.messages.partNumberCopied);
    }

    // function moveRodEndConfigurationRows(){
    //     console.debug("[CylinderConfigurator - moveRodEndConfigurationRows] init");
    //     $("#configuration_area tr.builder").each(function(){
    //         var currentRow = this;
    //         $(currentRow).remove();
    //         $("#cylinder_rod_end_configuration_table").append(currentRow);
    //         $(currentRow).show();
    //     });
    // }

    window.smc.CylinderConfigurator = CylinderConfigurator;
})(window.smc);


function removeAccesoryFromSummary(idToRemove) {
    console.log("[CylinderConfigurator - removeAccesoryFromSummary]", idToRemove);
    var partNumber = "";
    var selectedZone = "";

    if (idToRemove.indexOf("aareo_accesory_summary_") < 0) {
        idToRemove = "#aareo_accesory_summary_" + idToRemove;
    }

    partNumber = $(document.getElementById(idToRemove)).attr("partnumber-value");
    selectedZone = $(document.getElementById(idToRemove)).attr("zone-value");
    $(document.getElementById(idToRemove)).remove();

    if ($("input[value='" + partNumber + "']").is(":checked")) {
        $("input[value='" + partNumber + "']").prop("checked", false);
    }
    // $(document).trigger('smc.partNumber.changed');
    removeAccesoryFromProjectSummary(partNumber, selectedZone);
    checkSummaryVisibility();
    reloadHTOAccesoryList();
    if ($(".cylinder-info-container__partnumber_title__accesories").is(":empty")) {
        $("#pdfReportBtn").attr("disabled", "disabled");
    }
    $(document).trigger('smc.productToolbar.reloadPreview');
    $(document).trigger('smc.reload.summary');
    $(document).trigger('smc.partNumber.changed');
}

function removeAllAccessoriesFromSummary() {
    console.log("[CylinderConfigurator - removeAllAccessoriesFromSummary]");

    $(".aareo_accesory_summary_element").each(function () {
        $(this).remove();
    });

    $(".aareo__choosen_accesory").prop("checked", false);

    // $(document).trigger('smc.partNumber.changed');
    removeAllAccessoriesFromProjectSummary();
    checkSummaryVisibility();
    reloadHTOAccesoryList();
}

function checkSummaryVisibility() {
    if ($("#aareo_configuration-summary_accesory_summary-list .aareo_accesory_summary_element").length === 0
        && $("#without-position__collapse .aareo_accesory_no_position_row").length === 0) {
        hideAccessoriesSelectionSummary();
        if (!isRodEndConfigured()) {
            hideCreateSimpleSpecialButtons();
        }
    } else {
        if (($("#aareo_configuration-summary_accesory_summary-list .aareo_accesory_summary_element").length > 0)
            || $("#without-position__collapse .aareo_accesory_no_position_row").length > 0) {
            showAccessoriesSelectionSummary();
        } else {
            hideAccessoriesSelectionSummary();
        }
        showCreateSimpleSpecialButtons();
    }
}

function reloadHTOAccesoryList() {
    console.debug("[CylinderConfigurator - reloadHTOAccesoryList] init");
    $(".cylinder-info-container__partnumber_title__accesories").text('');
    if ($("#idbl_hto_wrapper") === undefined) {
        var accesoriesPN = "";
        $("#aareo_configuration-summary_accesory_summary-list .aareo_accesory_summary_element").each(function () {
            accesoriesPN += " + " + $(this).attr("partnumber-value");
        });
        $("#without-position__collapse .aareo_accesory_no_position_row").each(function () {
            accesoriesPN += " + " + $(this).attr("partnumber-value");
            var currentQty = $(this).find(".aareo_accesory_summary_row_quantity").text();
            if (currentQty !== 1) {
                accesoriesPN += "(" + currentQty + ")";
            }
        });
        $(".cylinder-info-container__partnumber_title__accesories").text(accesoriesPN);
    } else {
        $(".cylinder-info-container__partnumber_title__accesories").empty();
        $("#aareo_configuration-summary_accesory_summary-list .aareo_accesory_summary_element").each(function () {
            var rowHTML = "<span class='idbl_hto__partnumber__accesory_value'>" + $(this).attr("partnumber-value") + "</span>";
            $(".cylinder-info-container__partnumber_title__accesories").append(rowHTML);
        });
        $("#without-position__collapse .aareo_accesory_no_position_row").each(function () {
            var currentQty = $(this).find(".aareo_accesory_summary_row_quantity").text();
            var qtyText = "(" + currentQty + ")";
            var rowHTML = "<span class='idbl_hto__partnumber__accesory_value'>" + $(this).attr("partnumber-value") + qtyText + "</span>";
            $(".cylinder-info-container__partnumber_title__accesories").append(rowHTML);
        });
        $(".cylinder-info-container__partnumber_title__accesories").text(accesoriesPN);
    }
}

function addAccesoryToProjectSummary(partNumber, selectedZone, withPosition) {
    console.log("[addAccesoryToProjectSummary] init");
    var rowHtml = $("#aareo_accesory_project_row_template").html();
    if (!withPosition) {
        rowHtml = $("#aareo_no_position_accesory_project_row_template").html();
    }
    rowHtml = rowHtml.replace("{{attributeName}}", selectedZone);
    rowHtml = rowHtml.replace("{{attributeValue}}", partNumber);
    rowHtml = rowHtml.replace("{{aareo_accesory_project_partNumber}}", partNumber);
    rowHtml = rowHtml.replace("{{aareo_accesory_project_zone}}", selectedZone);
    rowHtml = rowHtml.replace("{{aareo_accesory_header_partNumber}}", selectedZone);
    $("#project-section .project-summary-attribute-list-js").append(rowHtml);
    showAccessoriesSelectionSummary();
}

function reloadAccessoriesSummary() {
    if ($("#aareo_configuration-summary_accesory_summary-list") !== undefined) {
        if (!configurationHasAccessories() && !isRodEndConfigured()
            && $("#without-position__collapse .aareo_accesory_no_position_row").length === 0) {
            hideAccessoriesSelectionSummary();
            hideCreateSimpleSpecialButtons();
        } else {
            if (configurationHasAccessories()) {
                showAccessoriesSelectionSummary();
            }
            if ($(".rodEndRow .formStatusNO_OK").length === 0) {
                showCreateSimpleSpecialButtons();
            }
        }
    }
}

function removeAccesoryFromProjectSummary(partNumber, selectedZone) {
    console.log("[removeAccesoryFromProjectSummary]", partNumber, selectedZone);
    $("#project-section .aareo_accesory[partnumber-value='" + partNumber + "']").each(function () {
        if ($(this).attr("zone-value") === selectedZone) {
            $(this).remove();
            if ($("#without-position__collapse .aareo_accesory_no_position_row").length === 0) {
                $(".accordion__item--without-position").addClass("hidden");
            }
        }
    });

    reloadAccessoriesSummary();
}

function removeAllAccessoriesFromProjectSummary() {
    console.log("[removeAllAccessoriesFromProjectSummary]");
    $("#project-section .aareo_accesory").each(function () {
        $(this).remove();
        if ($("#without-position__collapse .aareo_accesory_no_position_row").length === 0) {
            $(".accordion__item--without-position").addClass("hidden");
        }
    });

    reloadAccessoriesSummary();
}

function isRodEndConfigured() {
    if (typeof partNumberString !== 'undefined') {
        var partNumber = partNumberString;
        if (partNumber !== undefined && partNumber !== "") {
            var partNumberSplitted = partNumber.split("-");
            var lastPart = partNumberSplitted[partNumberSplitted.length - 1];
            if (lastPart.indexOf("XA") === 0) {
                return true;
            }
        }
    }
    return false;
}


function hideAccessoriesSelectionSummary() {
    $(".aareo__accesories-selection-summary").addClass("hidden");
}

function showAccessoriesSelectionSummary() {
    $(".aareo__accesories-selection-summary").removeClass("hidden");
}

function showChooseAccessory() {
    $("#aareo__choose-accesory").removeClass("hidden");
    $(".aareo__another-reference").removeClass("hidden");
}

function hideChooseAccessory() {
    $("#aareo__choose-accesory").addClass("hidden");
    $(".aareo__another-reference").addClass("hidden");
}

function hideCreateSimpleSpecialButtons() {
    $(".aareo__create-single-special").addClass("hidden");
    $(".show-cylinder-wizard-btn-js").addClass("hidden");
}

function showCreateSimpleSpecialButtons() {
    $(".aareo__create-single-special").removeClass("hidden");
    $(".show-cylinder-wizard-btn-js").removeClass("hidden");
}

function getURLRemoveParam(urlToChange, paramToRemove) {
    var url = new URL(urlToChange);
    var search_params = url.searchParams;

    // new value of "id" is set to "101"
    search_params.delete(paramToRemove);

    // change the search property of the main url
    url.search = search_params.toString();

    // the new url string
    return url.toString();
}

function showRodEndConfigurationForm() {
    $(".builder.configurationRow").removeClass("hidden");
    $(".builder.configurationRow").show();
    $(".builder").removeClass("hidden");
    $(".builder").show();
}

function hideRodEndConfigurationform() {
    $(".builder.configurationRow").hide();
    $(".builder.configurationRow").addClass("hidden");
    $(".builder").addClass("hidden");
    $(".builder").hide();
}

function configurationHasAccessories() {
    return $("#aareo_configuration-summary .aareo_accesory_summary_element").length > 0;
}

