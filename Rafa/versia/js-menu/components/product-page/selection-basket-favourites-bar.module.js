(function (globalConfig) {

    function SelectionBasketFavouritesBar(config) {
        this.config = config;
        this.clearSelectedPartNumbers();
    }

    SelectionBasketFavouritesBar.prototype.init = init;
    SelectionBasketFavouritesBar.prototype.initializeEvents = initializeEvents;
    SelectionBasketFavouritesBar.prototype.updateStatus = updateStatus;
    SelectionBasketFavouritesBar.prototype.getSelectedPartNumbers = getSelectedPartNumbers;
    SelectionBasketFavouritesBar.prototype.clearSelectedPartNumbers = clearSelectedPartNumbers;
    SelectionBasketFavouritesBar.prototype.addToFavouritesURLPartNumbers = addToFavouritesURLPartNumbers;

    function init() {
        console.log('[SelectionBasketFavouritesBar]', 'init');
        this.id = this.id || this.config.id;
        console.log(this.id);

        if (this.config.checkBoxType === "relatedProducts") {
            this.srpContainer = $('#' + this.config.srpContainer);
        }

        this.$addToBasketBtn = $('.add-to-basket-btn-js', this.config.container);
        this.$addToFavouritesBtn = $('.add-to-favourites-js', this.config.container);
        this.$selectAllCheckBox = $('#selectAll_' + this.id, this.config.container);
        console.log('#selectAll_' + this.id, this.config.container);

        this.initializeEvents();
        this.updateStatus();
        $(document).trigger('smc.registercomponent', [this.id, this]);
    }

    function initializeEvents() {
        this.$addToBasketBtn.on('click', manageAddToBasket.bind(this));
        this.$addToFavouritesBtn.on('click', manageAddToFavourites.bind(this));

        this.config.selectionListComponentIds.forEach(function (componentId) {
            $(document).on(['smc.', componentId, '.selectedPartNumberChanged'].join(''), updateCurrentSelectedPartNumbers.bind(this, componentId));
        }.bind(this));

        if (this.config.selectAllCheckboxFeature) {
            if (this.config.checkBoxType === "relatedProducts") {
                this.$selectAllCheckBox.on('change', manageSparesRelatedSelectAllCheckboxFeature.bind(this));
                $(document).on('smc.sparesRelated.statusChanged', onStandardStockedItemsStatusChanged.bind(this));
            } else {
                this.$selectAllCheckBox.on('change', manageSelectAllCheckboxFeature.bind(this));
                $(document).on('smc.standardStockedItems.statusChanged', onStandardStockedItemsStatusChanged.bind(this));
            }
        }
    }

    function updateStatus() {
        if (this.config.selectAllCheckboxFeature) {
            var allProductsCheckboxList;
            var allProductsCheckboxListChecked;
            if (this.config.checkBoxType === "relatedProducts") {
                allProductsCheckboxList = $('.series-related-product-partnumber', this.srpContainer);
                allProductsCheckboxListChecked = $('.series-related-product-partnumber:checked', this.srpContainer);
            } else {
                allProductsCheckboxList = $('.ssi-item-partnumber', this.config.ssiContainer);
                allProductsCheckboxListChecked = $('.ssi-item-partnumber:checked', this.config.ssiContainer);
            }
            var allProductsAreChecked = allProductsCheckboxList.length > 0 &&
                allProductsCheckboxListChecked.length === allProductsCheckboxList.length;

            this.$selectAllCheckBox.prop('checked', allProductsAreChecked);
        }
    }

    function updateCurrentSelectedPartNumbers(componentId, event, selectedPartNumbers) {
        this.componentPartNumbersList[componentId] = selectedPartNumbers;
        var totalSelectedPartNumbers = this.getSelectedPartNumbers();

        if (totalSelectedPartNumbers && totalSelectedPartNumbers.length) {
            this.$addToBasketBtn.removeAttr('disabled');
            this.$addToFavouritesBtn.removeAttr('disabled');

        } else {
            this.$addToBasketBtn.attr('disabled', 'disabled');
            this.$addToFavouritesBtn.attr('disabled', 'disabled');
        }

        this.updateStatus();
    }

    function getSelectedPartNumbers() {
        var selectedPartNumbers = [];

        for (var id in this.componentPartNumbersList) {
            selectedPartNumbers = selectedPartNumbers.concat(this.componentPartNumbersList[id]);
        }

        return selectedPartNumbers;
    }

    function clearSelectedPartNumbers() {
        this.componentPartNumbersList = {};
    }

    function manageAddToBasket() {
        addToBasket.call(this)
            .then(successAddingProductToBasket.bind(this))
            .fail(errorAddingProductToBasket.bind(this))
            .always(this.clearSelectedPartNumbers)
    }

    function addToBasket() {
        console.log('[AddToBasketBar]', 'addToBasket');

        var partNumbers = [];

        if (!this.getSelectedPartNumbers()) {
            throw new Error('"partNumber" is required');
        }

        this.getSelectedPartNumbers().forEach(function (partNumber) {
            if (partNumber) {
                partNumbers.push(partNumber.split(';')[0]);
            }
        });

        var products = [];
        partNumbers.forEach(function (partNumber) {
            products.push({partnumbercode: partNumber, quantity: 1});
        });

        this.config.basketViewModel = this.config.basketViewModel || window.basketViewModel;
        if (!this.config.basketViewModel) {
            throw new Error('"basketViewModel" module is required');
        }

        return this.config.basketViewModel.addToBasket(products, this.config.statisticsSource);
    }

    function successAddingProductToBasket(product) {
        console.info('[AddToBasketBar]', 'addToBasket', 'successAddingProductToBasket', product);
    }

    function errorAddingProductToBasket(error) {
        console.error('[AddToBasketBar]', 'addToBasket', 'errorAddingProductToBasket', error);
    }

    function manageAddToFavourites() {
        var partNumbers = this.getSelectedPartNumbers();
        if (!partNumbers) {
            throw new Error('"partNumber" is required');
        }
        this.getSelectedPartNumbers().forEach(function (partNumber) {
            if (partNumber) {
                partNumbers.push(partNumber.split(';')[0]);
            }
        });

        var url = window.location.href;

        //Check for authenticated user
        if (!globalConfig.isAuthenticated) {
            var addToFavouritesUrl = generateSecuredAction(this.id, 'addToFavouritesURLPartNumbers', url, partNumbers);
            window.location = addToFavouritesUrl;
            return;
        }

        addToFavourites.call(this, partNumbers)
            .then(successAddingProductToFavourites.bind(this))
            .fail(errorAddingProductToFavourites.bind(this))
            .always(this.clearSelectedPartNumbers)
    }

    function addToFavourites(partNumbers) {
        console.log('[AddToBasketBar]', 'addToFavourites');

        if (!partNumbers) {
            throw new Error('"partNumber" is required');
        }

        this.config.basketViewModel = this.config.basketViewModel || window.basketViewModel;
        if (!this.config.basketViewModel) {
            throw new Error('"basketViewModel" module is required');
        }

        return this.config.basketViewModel.addToFavourites(partNumbers, this.config.statisticsSource);
    }

    function successAddingProductToFavourites(product) {
        console.info('[AddToBasketBar]', 'addToFavourites', 'successAddingProductToFavourites', product);
    }

    function errorAddingProductToFavourites(error) {
        console.error('[AddToBasketBar]', 'addToFavourites', 'errorAddingProductToFavourites', error);
    }

    function manageSelectAllCheckboxFeature() {
        var $productCheckboxList = $('.ssi-item-partnumber', this.config.ssiContainer);
        if (this.$selectAllCheckBox.prop('checked')) {
            $productCheckboxList.prop('checked', true);
            $(document).trigger('smc.standardStockedItems.allSelected');
        } else {
            $productCheckboxList.prop('checked', false);
            $(document).trigger('smc.standardStockedItems.unselectAll');
        }

        $productCheckboxList.trigger('change');
        var allProductsCheckboxListChecked = $('.ssi-item-partnumber:checked', this.config.ssiContainer);
        if (allProductsCheckboxListChecked.length === 0) {
            this.$addToBasketBtn.attr('disabled', 'disabled');
            this.$addToFavouritesBtn.attr('disabled', 'disabled');
        }
    }

    function manageSparesRelatedSelectAllCheckboxFeature() {
        var $productCheckboxList = $('.series-related-product-partnumber', this.srpContainer);
        if (this.$selectAllCheckBox.prop('checked')) {
            $productCheckboxList.prop('checked', true);
        } else {
            $productCheckboxList.prop('checked', false);
        }
        $productCheckboxList.trigger('change');
        var allProductsCheckboxListChecked = $('.series-related-product-partnumber:checked', this.srpContainer);
        if (allProductsCheckboxListChecked.length === 0) {
            this.$addToBasketBtn.attr('disabled', 'disabled');
            this.$addToFavouritesBtn.attr('disabled', 'disabled');
        }
    }

    function onStandardStockedItemsStatusChanged() {
        //Reset "All product sleection checkbox"
        if (this.config.selectAllCheckboxFeature) {
            this.$selectAllCheckBox.prop('checked', false);
        }
    }

    function addToFavouritesURLPartNumbers(partNumbersParam) {
        var partNumbers = partNumbersParam && partNumbersParam.split(',');

        if (!partNumbers) {
            throw new Error('"partNumber" is required');
        }
        this.getSelectedPartNumbers().forEach(function (partNumber) {
            if (partNumber) {
                partNumbers.push(partNumber.split(';')[0]);
            }
        });

        addToFavourites.call(this, partNumbers)
            .then(successAddingProductToFavourites.bind(this))
            .fail(errorAddingProductToFavourites.bind(this))
            .always(this.clearSelectedPartNumbers)
    }

    function generateSecuredAction(componentId, actionName, currentUrl, actionParams) {
        var url = new URL(currentUrl);

        // [SMCD-471] Clear HippoCMS params to avoid Browser error
        var keysIterator = url.searchParams.keys();
        var key = keysIterator.next();
        while (key && key.value) {
            if (key.value.indexOf('_hn') === 0) url.searchParams.delete(key.value);
            key = keysIterator.next();
        }

        url.searchParams.set('componentId', componentId.toString());
        url.searchParams.set('action', actionName);
        url.searchParams.set('actionParams', actionParams.join(','));
        return secureResourceUrl(url);
    }

    function secureResourceUrl(url) {
        var securedResourceUrl = new URL(url.origin + smc.channelPrefix + '/secured-resource');
        securedResourceUrl.searchParams.set('resource', url.toString().replace(url.origin, ''));
        return securedResourceUrl;
    }

    window.smc.SelectionBasketFavouritesBar = SelectionBasketFavouritesBar;
})(window.smc);