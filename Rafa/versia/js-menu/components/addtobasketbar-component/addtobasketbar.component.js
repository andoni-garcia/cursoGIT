var partNumberToCompare = '';

(function (globalConfig) {
    function AddToBasketBar(config) {
        this.id = config.id;
        this.config = config;
    }

    AddToBasketBar.prototype.init = init;
    AddToBasketBar.prototype.initializeEvents = initializeEvents;
    AddToBasketBar.prototype.updateStatus = updateStatus;
    AddToBasketBar.prototype.updateButtons = updateButtons;
    AddToBasketBar.prototype.updateProductPrices = updateProductPrices;
    AddToBasketBar.prototype.getPartNumber = getPartNumber;
    AddToBasketBar.prototype.isValidConfiguration = isValidConfiguration;
    AddToBasketBar.prototype.showCylinderWizardModal = showCylinderWizardModal;
    AddToBasketBar.prototype.checkStockMessageVisibility = checkStockMessageVisibility;
    AddToBasketBar.prototype.isSSIPartNumber = isSSIPartNumber;
    AddToBasketBar.prototype.goToCompareConfiguredPN = goToCompareConfiguredPN;
    AddToBasketBar.prototype.checkNoErpInfo = checkNoErpInfo;


    function init() {
        console.debug('[AddToBasket]', 'init id=', this.id);
        if (!this.config.container) {
            throw new Error('"Container" is required');
        }

        this.$addToBasketBtn = $('.add-to-basket-btn-js', this.config.container);
        this.$addToFavouritesBtn = $('.add-to-favourites-js', this.config.container);
        this.$quantityContainer = $('.quantity-container', this.config.container);
        this.$quantityBoxInput = $('.quantity-box-input-js', this.config.container);
        this.$productPricesSubContainer = $('.product-prices', this.config.$productPricesDataContainer);
        this.$productDatesSubContainer = $('.product-dates', this.config.$productPricesDataContainer);
        this.$productOtherInfoSubContainer = $('.product-other-info', this.config.$productPricesDataContainer);
        this.$erpInfoMessage = $('.erp-info-message', this.config.$productPricesContainer);
        this.$showCylinderWizardBtn = $('.show-cylinder-wizard-btn-js', this.config.container);
        this.allSsiPartNumbers = null;

        this.config.defaults = {
            listPrice: '-',
            unitPrice: '-',
            deliveryDate: '-',
            bestAchievableDate: '-',
            countryOfOrigin: '-',
            taricCode: '-'
        };

        Object.defineProperty(this, 'quantity', {
            get: function () {
                var value = this.$quantityBoxInput.val();
                return value || 0;
            }.bind(this),
            set: function (x) {
                this.$quantityBoxInput.val(x);
            }.bind(this)
        });

        this.initializeEvents();
        this.updateButtons();
        $(document).trigger('smc.registercomponent', [this.id, this]);
    }

    var relaunched = false;
    var relaunchedPartNumber = "";

    function initializeEvents() {
        var _self = this;
        this.quantity = 1;

        this.$addToBasketBtn.on('click', manageAddToBasket.bind(this));
        this.$addToFavouritesBtn.on('click', manageAddToFavourites.bind(this));
        this.$quantityBoxInput.on('focus', _resetProductInfo.bind(this));
        //this.$quantityBoxInput.on('blur', _updateProductPrices.bind(this));
        this.$quantityBoxInput.on('keypress change', onQuantityChanged.bind(this));
        if (this.$showCylinderWizardBtn !== undefined) {
            this.$showCylinderWizardBtn.on('click', showCylinderWizardModal.bind(this));
        }
        $(document).on('smc.productConfiguratorComponent.created', updateProductConfiguratorComponent.bind(this));
        $(document).on('smc.partNumber.changed', updateStatus.bind(this));

        $(".idbl_hto__content__data_stockMessage_compare").each(function () {
            $(this).on('click', goToCompareConfiguredPN.bind(_self));
        });

        if (this.config.renderingMode === 'compare-products') {
            $(document).on('smc.compare.initialized.' + this.config.partNumber, updateStatus.bind(this));

            $(document).trigger('smc.compare.initialized.' + this.config.partNumber);
        }
    }

    function updateButtons() {
        if (this.getPartNumber() && this.isValidConfiguration()) {
            this.$addToBasketBtn.removeAttr('disabled');
            this.$addToBasketBtn.removeClass('disabled');
            this.$addToFavouritesBtn.removeAttr('disabled');
            this.$addToFavouritesBtn.removeClass('disabled');
            this.$quantityBoxInput.removeAttr('disabled');
            this.$quantityBoxInput.removeClass('disabled');
        }
    }

    function updateStatus() {
        if (this.config.isManualPartNumber) {
            this.$addToBasketBtn.removeAttr('disabled');
            this.$addToBasketBtn.removeClass('disabled');
            this.$addToFavouritesBtn.removeAttr('disabled');
            this.$addToFavouritesBtn.removeClass('disabled');
            this.$quantityBoxInput.removeAttr('disabled');
            this.$quantityBoxInput.removeClass('disabled');
        } else {
            if (this.getPartNumber() && this.isValidConfiguration()) {
                this.$addToBasketBtn.removeAttr('disabled');
                this.$addToBasketBtn.removeClass('disabled');
                this.$addToFavouritesBtn.removeAttr('disabled');
                this.$addToFavouritesBtn.removeClass('disabled');
                this.$quantityBoxInput.removeAttr('disabled');
                this.$quantityBoxInput.removeClass('disabled');
            } else {
                this.$addToBasketBtn.attr('disabled', 'disabled');
                this.$addToBasketBtn.addClass('disabled');
                this.$quantityBoxInput.attr('disabled', 'disabled');
                this.$quantityBoxInput.addClass('disabled');
            }
        }

        this.updateProductPrices();
    }

    function updateProductPrices() {
        var updateProductPricesDebounced = $.debounce(1200, _updateProductPrices.bind(this));
        updateProductPricesDebounced();
    }

    function _hiddenPrices() {
        var _self = this;
        if (_self.config.showInfo) {
            _self.$productPricesSubContainer.addClass('hidden');
            _self.$productDatesSubContainer.addClass('hidden');
        }
        if (_self.config.showExtraInfo) {
            _self.$productOtherInfoSubContainer.addClass('hidden');
        }
    }

    function _updateProductPrices() {
        var _self = this;
        var isAlreadyMakingProductInfoRequest = !!this._productInfoRequest;
        //idbl_hto_wrapper--no_info
        if (!(this.getPartNumber() && this.isValidConfiguration())) {
            $("#idbl_hto_wrapper").addClass("idbl_hto_wrapper--no_info");
            $("#idbl_hto_wrapper").removeClass("idbl_hto__wrapper--alert");
        } else {
            $("#idbl_hto_wrapper").removeClass("idbl_hto_wrapper--no_info");
        }
        if (isAlreadyMakingProductInfoRequest) {
            return;
        }

        if (!globalConfig.isAuthenticated || this.config.isLightUser) {
            this.checkStockMessageVisibility();
            this.checkNoErpInfo();
            return;
        }

        if (!(this.getPartNumber() && this.isValidConfiguration())) {
            $(".idbl_hto__content__data_stockMessage").addClass("hidden");
            return;
        }
        var currPartNumber = this.getPartNumber();
        var configuredPartNumber = getURLParameter("partNumber");

        if (!(this.config.showInfo || this.config.showExtraInfo)) {
            return;
        }

        // if (this.config.showInfo) {
        //     this.$productPricesSubContainer.removeClass('hidden');
        //     this.$productDatesSubContainer.removeClass('hidden');
        // }
        //
        // if (this.config.showExtraInfo) {
        //     this.$productOtherInfoSubContainer.removeClass('hidden');
        // }

        if (!_self.config.container.hasClass("loading")) {
            if (!this.quantity) {
                return _resetProductInfo.call(this);
            } else {
                _resetProductInfo.call(this);
            }
        }

        this._productInfoRequest = true;
        //Add Spinner
        _startProductInfoLoading.call(this);
        var $container = $("#check_prices_" + currPartNumber.replaceAll("/", "_"));
        _requestProductInfo.call(this)
            .then(function () {
                console.debug('[AddToBasket]', 'Updated ERP info');
                relaunched = false;
                _self.$erpInfoMessage.addClass('hidden');
                $("#idbl_hto_wrapper").removeClass("idbl_hto__wrapper--alert");
                $("#idbl_hto_wrapper").removeClass("idbl_hto_wrapper--no_info");
                if (_self.config.showInfo) {
                    _self.$productPricesSubContainer.removeClass('hidden');
                    _self.$productDatesSubContainer.removeClass('hidden');
                    let $bestAchievableDateSubContainer = $('.best-achievable-date');
                    if (!$bestAchievableDateSubContainer.find(".value").html()) {
                        $bestAchievableDateSubContainer.addClass('hidden');
                    }
                }
                if (_self.config.showExtraInfo) {
                    _self.$productOtherInfoSubContainer.removeClass('hidden');
                }
                _self.config.$productPricesContainer.removeClass('loading');
                if (_self.config.isConfiguratorPage) {
                    $(".idbl_hto__content__addtobasketbar").removeClass('idbl_hto__content__addtobasketbar--no_erp_info');
                }
                _self.config.container.removeClass('loading');
                endLoading($container);
            })
            .catch(function (error) {
                if (error && error.type === 'CAN_NOT_SEE_PRICES') {
                    _self.$erpInfoMessage.addClass('hidden');
                    $("#idbl_hto_wrapper").addClass("idbl_hto__wrapper--alert");
                    $("#idbl_hto_wrapper").addClass("idbl_hto_wrapper--no_info");
                    _hiddenPrices.call(_self);
                    _self.config.$productPricesContainer.removeClass('loading');
                    _self.config.container.addClass('loading');
                    endLoading($container);
                } else if (error && error.type === 'UPDATING') {
                    console.log('[AddToBasket] going to try again');
                    setTimeout(function () {
                        // $(document).trigger('smc.partNumber.changed');
                        _self.updateStatus();
                    }, 2000);
                } else if (error && !(error.type === 'request_duplicated' || error.type === 'not_data_changed')) {
                    console.error('[AddToBasket]', 'Couldn\'t get ERP info', 'Type=', error.type);
                    _self.config.$productPricesContainer.removeClass('loading');
                    _self.config.container.removeClass('loading');
                    _hiddenPrices.call(_self);
                    if (!(_self.config.partNumber || _self.config.statisticsSource.includes("SSI")) && !isConfigurationValid()) {
                        if (isConfigurationComplete()) {
                            _showWarningMessage.call(_self, _self.config.messages.completeRodEndConfigToViewPrices);
                        } else {
                            _showWarningMessage.call(_self, _self.config.messages.completeConfigToViewPrices);
                        }
                    } else {
                        _showWarningMessage.call(_self, _self.config.messages.couldntGetErpInfo);
                    }
                    endLoading($container);
                }

            })
            .always(_endProductInfoLoading.bind(_self));
    }

    function checkStockMessageVisibility() {
        console.log("[checkStockMessageVisibility] init");
        if ($("#idbl_hto_wrapper") !== undefined) {
            if (this.getPartNumber() && this.isValidConfiguration() && this.config.isConfiguratorPage) {
                $("#idbl_hto_wrapper").addClass("idbl_hto__wrapper--alert");
                if (!this.allSsiPartNumbers) {
                    //Load all ssi partnumbers
                    this.allSsiPartNumbers = window.smc.ssiAllPartNumbers || [];
                }
                if (($("#standard_stocked_items") === undefined && $("#standard_stocked_items_tab") === undefined)
                    || ($("#standard_stocked_items").length === 0 && $("#standard_stocked_items_tab").length === 0)) {//There is no SSI for this product
                    // Don't show any message
                    $("#idbl_hto__content__data_notStockClickHere_message").addClass("hidden");
                    $("#idbl_hto__content__data_inStock_message").addClass("hidden");
                    $("#idbl_hto__content__data_notStock_message").addClass("hidden");
                    $("#idbl_hto_wrapper").removeClass("idbl_hto__wrapper--alert");
                } else if (this.isSSIPartNumber(this.getPartNumber())) { //If there is an existing SSI with the same PN
                    $("#idbl_hto__content__data_notStockClickHere_message").addClass("hidden");
                    $("#idbl_hto__content__data_notStock_message").addClass("hidden");
                    $("#idbl_hto__content__data_inStock_message").removeClass("hidden");
                } else {//If there is no existing SSI with the same PN
                    $("#idbl_hto__content__data_notStockClickHere_message").removeClass("hidden");
                    $("#idbl_hto__content__data_inStock_message").addClass("hidden");
                    $("#idbl_hto__content__data_notStock_message").addClass("hidden");
                    $("#idbl_hto__content__data_comparing_with_message").removeClass("hidden");
                }
                this.checkNoErpInfo();
                return;
            }
        }
        if (this.config.isConfiguratorPage) {
            $("#idbl_hto_wrapper").removeClass("idbl_hto__wrapper--alert");
            $(".idbl_hto__content__data_stockMessage").addClass("hidden");
        }
    }

    function isSSIPartNumber(partNumberSearch) {
        var ssiContainsPartNumber = false;
        this.allSsiPartNumbers.forEach(function (part_number) {
            if (part_number !== undefined && part_number.part_number === partNumberSearch) {
                ssiContainsPartNumber = true;
            }
        });
        return ssiContainsPartNumber;
    }

    function endLoading($container) {
        $('.loading-container-js', $container)
            .removeClass('loading-container')
            .html('');
        $('.loading-container-js', $container).removeClass('spinner-margin');
        $container.removeClass('disabled');
        $container.removeClass('d-flex');
        $container.removeClass('hidden');
    }

    function getURLParameter(sParam) {
        var sPageURL = window.location.search.substring(1),
            sURLVariables = sPageURL.split('&'),
            sParameterName,
            i;
        for (i = 0; i < sURLVariables.length; i++) {
            sParameterName = sURLVariables[i].split('=');
            if (sParameterName[0] === sParam) {
                return sParameterName[1] === undefined ? true : decodeURIComponent(sParameterName[1]);
            }
        }
    }


    function manageAddToBasket() {
        addToBasket.call(this)
            .then(successAddingProductToBasket.bind(this))
            .fail(errorAddingProductToBasket.bind(this))
    }

    function addToBasket() {
        console.log('[AddToBasketBar]', 'addToBasket');

        var partNumber = this.getPartNumber();
        if (!partNumber) {
            throw new Error('"partNumber" is required');
        }

        if (!this.quantity) {
            throw new Error('"quantity" is required');
        }

        if (this.quantity < 1) {
            throw new Error('"quantity" must be bigger than 0');
        }

        this.config.basketViewModel = this.config.basketViewModel || window.basketViewModel;
        if (!this.config.basketViewModel) {
            throw new Error('"basketViewModel" module is required');
        }

        var product = {partnumbercode: partNumber, quantity: this.quantity};
        return this.config.basketViewModel.addToBasket(product, this.config.statisticsSource);
    }

    function successAddingProductToBasket(productList) {
        console.info('[AddToBasketBar]', 'addToBasket', 'successAddingProductToBasket', productList);
        this.lastAddedPartNumberBasketId = productList && productList.length && productList.pop().id;
        //LAUNCH QUESTION IN POP-UP IF WHE ARE IN FUNC-NAV
        if ($(".psfFuntionalitycontenedor").length > 0) {
            console.info("[AddToBasketBar] show poll");
            setTimeout(function () {
                // document.cookie = 'smcx_0_last_shown_at=;expires=Thu, 01 Jan 1970 00:00:01 GMT;';
                let script = document.createElement("script");
                document.body.appendChild(script);
                script.innerHTML = '(function(t,e,s,o){var n,c,l;t.SMCX=t.SMCX||[],e.getElementById(o)||(n=e.getElementsByTagName(s),c=n[n.length-1],l=e.createElement(s),l.type="text/javascript",l.async=!0,l.id=o,l.src="https://widget.surveymonkey.com/collect/website/js/tRaiETqnLgj758hTBazgd3yxW_2FeJxakdAGuqwdgaFhKhnFZUqs7xIdMrZcGwQ33H.js",c.parentNode.insertBefore(l,c))})(window,document,"script","smcx-sdk")';
            }, 1000);
        }
    }

    function errorAddingProductToBasket(error) {
        this.config.BASKET_ERROR_CODES = this.config.BASKET_ERROR_CODES || window.BASKET_ERROR_CODES || BASKET_ERROR_CODES;
        if (!this.config.BASKET_ERROR_CODES) {
            throw new Error('"BASKET_ERROR_CODES" is required. Check with LKS');
        }

        if (error
            && (error.errorCode !== this.config.BASKET_ERROR_CODES.PRODUCTS_ALREADY_INSERTED_ALL
                && error.errorCode !== this.config.BASKET_ERROR_CODES.PRODUCTS_ALREADY_INSERTED_SOME
                && error.errorCode !== this.config.BASKET_ERROR_CODES.UI_MODAL_REJECTED)) {
            console.error('[AddToBasketBar]', 'addToBasket', 'errorAddingProductToBasket', error);
            smc.NotifyComponent && smc.NotifyComponent.error(globalConfig.messages.generalError);
        }
    }

    function manageAddToFavourites() {
        addToFavourites.call(this)
            .then(successAddingProductToFavourites.bind(this))
            .fail(errorAddingProductToFavourites.bind(this))
    }

    function addToFavourites() {
        console.log('[AddToBasketBar]', 'addToFavourites');

        var partNumber = this.getPartNumber();
        if (!partNumber) {
            throw new Error('"partNumber" is required');
        }

        this.config.basketViewModel = this.config.basketViewModel || window.basketViewModel;
        if (!this.config.basketViewModel) {
            throw new Error('"basketViewModel" module is required');
        }

        return this.config.basketViewModel.addToFavourites(partNumber, this.config.statisticsSource);
    }

    function successAddingProductToFavourites(product) {
        console.info('[AddToBasketBar]', 'addToFavourites', 'successAddingProductToFavourites', product);
    }

    function errorAddingProductToFavourites(error) {
        this.config.BASKET_ERROR_CODES = this.config.BASKET_ERROR_CODES || window.BASKET_ERROR_CODES || BASKET_ERROR_CODES;
        if (!this.config.BASKET_ERROR_CODES) {
            throw new Error('"BASKET_ERROR_CODES" is required. Check with LKS');
        }

        if (error
            && (error.errorCode !== this.config.BASKET_ERROR_CODES.PRODUCTS_ALREADY_INSERTED_ALL
                && error.errorCode !== this.config.BASKET_ERROR_CODES.PRODUCTS_ALREADY_INSERTED_SOME
                && error.errorCode !== this.config.BASKET_ERROR_CODES.UI_MODAL_REJECTED)) {
            console.error('[AddToBasketBar]', 'addToFavourites', 'errorAddingProductToFavourites', error);
            smc.NotifyComponent && smc.NotifyComponent.error(globalConfig.messages.generalError);
        }
    }

    function getPartNumber() {
        var partNumber = this.config.partNumber;
        if (this.config.productConfiguratorComponent && this.config.isConfiguratorPage) {
            partNumber = this.config.productConfiguratorComponent.getPartNumber();
        }

        return partNumber;
    }

    function isValidConfiguration() {
        if (this.config.isManualPartNumber) {
            return true;
        }

        if (this.config.productConfiguratorComponent) {
            return this.config.productConfiguratorComponent.isValidConfiguration();
        }

        return false;
    }

    function updateProductConfiguratorComponent(event, productConfiguratorComponent) {
        this.config.productConfiguratorComponent = productConfiguratorComponent;
        this.updateStatus();
    }

    function onQuantityChanged(event) {
        var keyCode = event.keyCode || event.which;
        var isEnterKey = keyCode === 13;
        var isNumberKey = keyCode >= 48 && keyCode <= 57;
        if (!(isEnterKey || isNumberKey)) {
            return false;
        }

        this.updateProductPrices();
    }

    function _requestProductInfo() {
        console.log('[AddToBasketBar]', '_requestProductInfo');
        var def = $.Deferred();

        if (def.state() === 'pending') {
            var url = new URL(globalConfig.addToBasketBar.urls.getErpInfo);
            url.searchParams.set('quantity', this.quantity);
            url.searchParams.set('productId', this.config.productId);
            url.searchParams.set('partNumber', this.getPartNumber());

            return $.getJSON(url.toString())
                .then(_fillServerProductInfo.bind(this));
        }

        return def.promise();
    }

    function _resetProductInfo() {
        // this.$erpInfoMessage.addClass('hidden');
        _fillDefaultProductInfo.call(this);
    }

    function _fillServerProductInfo(response) {
        var def = $.Deferred();
        if (response.status !== null && response.status === "UPDATING") {
            console.log("[_fillServerProductInfo] status UPDATING, trying again...");
            var errorType = 'UPDATING';
            def.reject({type: errorType, message: 'Get ERP Info is still UPDATING data'});
            return def.promise();
        } else {
            var listPrice = response.listPrice,
                unitPrice = response.unitNetPrice,
                deliveryDate = response.deliveryDates,
                bestAchievableDate = response.bestArchievableDate,
                countryOfOrigin = response.countryOfOrigin,
                taricCode = response.taricCode,
                canSeePrices = response.canSeePrices,
                eclassCode = response.eclassCode,
                eclassVersion = response.eclassVersion,
                unspscNumber = response.unspscNumber,
                unspscVersion = response.unspscVersion;
            console.log("[_fillServerProductInfo] price: ", unitPrice);
            if (listPrice || unitPrice) {
                _fillProductInfo(this.config.$productPricesDataContainer, listPrice, unitPrice, deliveryDate, bestAchievableDate, countryOfOrigin, taricCode);
                _fillEClassInfo(this.config.$productPricesDataContainer, eclassCode, eclassVersion, unspscNumber, unspscVersion);
                def.resolve();
            } else {
                var errorType = 'NOT_ENOUGH_DATA';
                if (!canSeePrices) {
                    errorType = 'CAN_NOT_SEE_PRICES';
                }
                def.reject({type: errorType, message: 'The data doesn\'t have enough data to display'});
            }
            this._productInfoRequest = null;

            return def.promise();
        }

    }

    function _fillDefaultProductInfo() {
        _fillProductInfo(
            this.config.container,
            this.config.defaults.listPrice,
            this.config.defaults.unitPrice,
            this.config.defaults.deliveryDate,
            this.config.defaults.bestAchievableDate,
            this.config.defaults.countryOfOrigin,
            this.config.defaults.taricCode);
    }

    function formatPriceDecimals(priceValue) {
        if (priceValue !== null && priceValue !== "null" && priceValue !== undefined && priceValue !== "" && priceValue !== "-") {
            var currency = "";
            priceValue = priceValue.trim();
            if (priceValue.indexOf(" ") > 0) {
                currency = priceValue.substr(priceValue.indexOf(" "));
                priceValue = priceValue.substr(0, priceValue.indexOf(" "));
            }
            try {
                return "" + ((Math.round(priceValue * 100) / 100).toFixed(2)) + currency;
            } catch (error) {
                console.error("formatPriceDecimals:: not able to format value ", priceValue, error);
            }
        }
        return priceValue;
    }


    function _fillProductInfo(container, listPrice, unitPrice, deliveryDate, bestAchievableDate, countryOfOrigin, taricCode) {
        console.log("listPrice: ", listPrice);
        console.log("unitPrice: ", unitPrice);
        listPrice = formatPriceDecimals(listPrice);
        unitPrice = formatPriceDecimals(unitPrice);
        var $listPrice = $('.list-price', container);
        var $unitPrice = $('.unit-price', container);


        if (listPrice) {
            $listPrice.find('.value').text(listPrice);
        } else if (!$(".compare-tab-js").is(":visible")) {
            $listPrice.remove();
        }

        if (unitPrice) {
            $unitPrice.find('.value').text(unitPrice);
        } else if (!$(".compare-tab-js").is(":visible")) {
            $unitPrice.remove();
        }

        if (Array.isArray(deliveryDate)) {
            $('.delivery-date', container).find('.value').html(deliveryDate.map(function (deliveryDate) {
                return deliveryDate.date;
            }).join('<br/>'));
        } else {
            $('.delivery-date', container).find('.value').text(deliveryDate);
        }

        if (Array.isArray(bestAchievableDate)) {
            $('.best-achievable-date', container).find('.value').html(bestAchievableDate.map(function (deliveryDate) {
                return deliveryDate.date;
            }).join('<br/>'));
        } else {
            $('.best-achievable-date', container).find('.value').text(bestAchievableDate);
        }

        $('.country-of-origin', container).find('.value').text(countryOfOrigin);
        $('.taric-code', container).find('.value').text(taricCode);
    }

    function addEclassValue(value, className, $techSpectsTable, pricesContainer) {
        if (value) {
            if ($techSpectsTable.length > 0) {
                $(className + ' .key-text-value', $techSpectsTable).html(value);
                $(className + ' .attribute-value', $techSpectsTable).html(value);
                $(className, $techSpectsTable).show();
                $(className, $techSpectsTable).removeClass("hidden-important");
            } else {
                //Techspecs not loaded yet
                window[className.substring(1)] = value;
            }
            $(className + ' .value', pricesContainer).text(value);
        } else {
            $(className, pricesContainer).hide();
            $(className, pricesContainer).addClass("hidden-important");
        }
    }

    function _fillEClassInfo(container, eclassCode, eclassVersion, unspscNumber, unspscVersion) {
        let $techSpectsTable = container.closest('.spare-accessory-item__collapsed_details').find('.detail-table');
        if (!$techSpectsTable.length > 0) {
            $techSpectsTable = $('.detail-table', '#tech_specs_list');
        }
        addEclassValue(eclassCode, '.eclass-code', $techSpectsTable, container);
        addEclassValue(eclassVersion, '.eclass-version', $techSpectsTable, container);
        addEclassValue(unspscNumber, '.unspsc-number', $techSpectsTable, container);
        addEclassValue(unspscVersion, '.unspsc-version', $techSpectsTable, container);

        if ($('.erp-info-message.alert.fade.show').length > 0) {
            $('.erp-info-container .erp-info-data').addClass("hidden");
        } else {
            $('.erp-info-container .erp-info-data').removeClass("hidden");
        }
    }

    function _startProductInfoLoading() {
        // this.$erpInfoMessage.addClass('hidden');
        // this.config.$productPricesDataContainer.removeClass('hidden');
        this.config.container.addClass('loading');
        this.config.$productPricesContainer.addClass('loading');
    }

    function _endProductInfoLoading() {
        // this.config.$productPricesContainer.removeClass('loading');
        // this.config.container.removeClass('loading');
        this.checkNoErpInfo();
        this._productInfoRequest = false;
    }

    function _showWarningMessage(message) {
        _endProductInfoLoading.bind(this);
        // this.config.$productPricesDataContainer.addClass('hidden');
        // this.$quantityContainer.addClass('disabled');
        // this.$addToBasketBtn.addClass('disabled');
        // this.$addToBasketBtn.attr('disabled',true);
        // this.$quantityBoxInput.addClass('disabled');
        // this.$quantityBoxInput.attr('disabled',true);
        this.$addToBasketBtn.attr('title', message);
        this.$quantityBoxInput.attr('title', message);
        this.$erpInfoMessage.html(message);
        this.$erpInfoMessage.removeClass('hidden').removeClass('hide').addClass('show');
        $("#idbl_hto_wrapper").addClass("idbl_hto__wrapper--alert");
    }

    function showCylinderWizardModal() {
        $("#create-simple-special-button").click();
    }

    function goToCompareConfiguredPN() {
        console.log("[goToCompareConfiguredPN] init");
        partNumberToCompare = partNumberString;
        $('#compare_hto_wrapper .idbl_hto__partnumber__code_wrapper').attr('data-partnumber-code', partNumberToCompare);
        $('#compare_partnumber').html(partNumberToCompare);
        $('#compare_hto_wrapper').show();

        if ($('#standard_stocked_items_tab')) {
            $('#standard_stocked_items_tab').tab('show');
            $(document).trigger('smc.partNumber.compare');
        }
    }

    function checkNoErpInfo() {
        if ($("#idbl_hto_wrapper") !== undefined && $("#productConfiguratorContainer").is(':visible') && this.config.isConfiguratorPage) {
            let $idblHtoContentAddtobasketbar = $('.idbl_hto__content__addtobasketbar', '#idbl_hto_wrapper');
            if (this.config.$productPricesDataContainer.children(':visible').length === 0 && this.$erpInfoMessage.is(":hidden") && $('.idbl_hto__content__info ', '#idbl_hto_wrapper').children(':visible').length <= 1) {
                $idblHtoContentAddtobasketbar.addClass('idbl_hto__content__addtobasketbar--no_erp_info');
            } else {
                $idblHtoContentAddtobasketbar.removeClass('idbl_hto__content__addtobasketbar--no_erp_info');
            }
        }
    }

    window.smc.AddToBasketBar = AddToBasketBar;
})(window.smc);

