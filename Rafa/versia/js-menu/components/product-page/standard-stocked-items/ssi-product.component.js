var ssiLoadedPartNumber = [];
var ssiLoadingStartTime = [];
(function (globalConfig) {
    function SsiProduct(config) {
        this.id = config.id;
        this.productId = config.productId;
        this.config = config;
    }

    var isSeries = $("#isSeriesPage").val() === "true";
    SsiProduct.prototype.init = init;
    SsiProduct.prototype.initializeEvents = initializeEvents;
    SsiProduct.prototype.loadProductInfo = loadProductInfo;
    SsiProduct.prototype.initializeProductDetailTab = initializeProductDetailTab;
    SsiProduct.prototype.initializeSpareAndRelatedProductsTab = initializeSpareAndRelatedProductsTab;
    SsiProduct.prototype.initializeToolTab = initializeToolTab;
    SsiProduct.prototype.initializeCheckPricesTab = initializeCheckPricesTab;
    SsiProduct.prototype.initLoading = initLoading;
    SsiProduct.prototype.endLoading = endLoading;
    SsiProduct.prototype.showTabLine = showTabLine;
    SsiProduct.prototype.hideTabLine = hideTabLine;
    SsiProduct.prototype.activeProductLayout = activeProductLayout;
    SsiProduct.prototype.disabledProductLayout = disabledProductLayout;

    function init() {
        console.debug('[SsiProduct]', 'init id=', this.id);
        var _self = this;
        var attributeTemplateHtml = "";
        if (document.getElementById('attributeListItemTemplate') !== null) {
            attributeTemplateHtml = document.getElementById('attributeListItemTemplate').innerHTML;
        } else {
            attributeTemplateHtml = document.getElementById('configurationSummaryAttributeListItemTemplate').innerHTML;
        }
        this.templates = {
            spinnerTemplateHTML: document.getElementById('spinner-template').innerHTML,
            attributeListItemTemplateHTML: attributeTemplateHtml
        };

        this.$ssiContainer = $('#' + this.id);
        this.$ssiProductPreviewContainer = $('.product-preview-container-js', this.$ssiContainer);
        this.$ssiProductDetailNav = $("#ssi-detail-tab_" + this.config.partnumber.replaceAll("/", "_"));

        this.$spareAndRelatedProductsNav = $("#spares_related_products_tab_" + this.config.partnumber.replaceAll("/", "_"));
        this.$ssiProductDetailTab = $("#product_detail_" + this.config.partnumber.replaceAll("/", "_"));
        this.$ssiProductContent = this.$ssiProductDetailTab.find('.product-detail-content-js');
        this.$spareAndRelatedProductsTab = $("#spares_related_products_" + this.config.partnumber.replaceAll("/", "_"));
        this.$spareAndRelatedProductContent = this.$spareAndRelatedProductsTab.find('.spare-related-content-js');

        this.$toolNav = $("#tools_tab_" + this.config.partnumber.replaceAll("/", "_"));
        this.$toolTab = $("#tools_" + this.config.partnumber.replaceAll("/", "_"));

        this.$checkPricesNav = $("#check_prices_tab_" + this.config.partnumber.replaceAll("/", "_"));
        this.$checkPricesTab = $("#check_prices_" + this.config.partnumber.replaceAll("/", "_"));
        this.$checkPricesContent = this.$checkPricesTab.find('.check-prices-content-js');

        new Waypoint({
            element: this.$ssiContainer,
            handler: function () {
                globalConfig.ComponentManager.getETechOnlineStatus()
                    .then(function (response) {
                        _self.config.isEtechEnabled = !!(response || response[0]);
                    })
                    .then(function () {
                        _self.initializeEvents();
                    });

                this.destroy();
            },
            offset: '150%'
        });
    }

    function initializeEvents() {
        console.log('[SsiProduct]', 'InitializeEvents');

        if (ssi_columns !== undefined && $("#ssi_columns_series") !== undefined && $("#ssi_columns_series").val() !== undefined) {
            if (ssi_columns === "" || ssi_columns.length === 0 ||
                (ssi_columns.length === 1 && ssi_columns[0] === "")) {
                ssi_columns = $("#ssi_columns_series").val().split(",");
            }
        }
        this.loadProductInfo();
        this.initializeProductDetailTab();
        this.initializeSpareAndRelatedProductsTab();
        this.initializeToolTab();
        this.initializeCheckPricesTab();
    }

    function loadProductInfo() {
        var _self = this;
        if (this.$ssiProductPreviewContainer.length > 0) {
            //Progressive loading if waypoint enabled
            new Waypoint({
                element: this.$ssiProductPreviewContainer,
                handler: function () {
                    _loadProductInfo.call(_self);

                    this.destroy();
                },
                offset: '150%'
            });
        }
    }

    function _loadProductInfo() {
        if (ssiLoadedPartNumber[this.config.partnumber] === undefined && globalConfig.ssi) {
            if (ssiLoadingStartTime[this.config.partnumber] === undefined || ssiLoadingStartTime[this.config.partnumber] === 0) {
                ssiLoadingStartTime[this.config.partnumber] = (new Date()).getTime();
            }
            return getProductDetailInfo.call(this, globalConfig.ssi.urls.showProductDetailJSON, this.config.partnumber)
                .then(checkForUpdatedData.bind(this))
                .then(printProductInfoPreview.bind(this))
                .catch(handleProductDetailInfoError.bind(this));
        } else {
            $("#ssi-detail-tab_" + this.config.partnumber.replaceAll("/", "_")).removeClass("disabled");
            $("#ssi-detail-tab_" + this.config.partnumber.replaceAll("/", "_")).removeAttr("disabled");
            return printProductInfoPreview.call(this, ssiLoadedPartNumber[this.config.partnumber]);
        }
    }

    function initializeProductDetailTab() {
        var _self = this;

        if (this.config.isEtechEnabled) {
            this.$ssiProductDetailNav.removeAttr('disabled');
            this.$ssiProductDetailNav.removeClass('disabled');
        }
        if (isSeries) {
            if (_self.config.partnumberId) {
                this.$ssiProductDetailNav.click(techSpecs.bind(_self, _self.config.partnumberId));
            } else {
                this.$ssiProductDetailNav.click(techSpecs.bind(_self, _self.config.partnumber));
            }
        } else {
            this.$ssiProductDetailNav.click(productDetail.bind(_self, _self.config.partnumber));
        }
    }

    // function initializeTechSpecsTab() {
    //     var _self = this;
    //
    //     if (this.config.isEtechEnabled) {
    //         this.$ssiProductDetailNav.removeAttr('disabled');
    //         this.$ssiProductDetailNav.removeClass('disabled');
    //     }
    //     this.$ssiProductDetailNav.click(techSpecs.bind(_self, _self.config.partnumber));
    // }


    function initializeSpareAndRelatedProductsTab() {
        var _self = this;
        // var partNumber = _self.config.partnumber;
        // var url = replacePartNumber(partNumber, globalConfig.ssi.urls.hasSpareAndRelatedProducts);
        //
        // var data = {
        //     productId: this.productId,
        //     language: this.config.defaultLanguage || 'en',
        //     partNumber: partNumber,
        //     origin: 'ssi'
        // };
        //
        // $.get(url, data)
        //     .then(function (response) {
        //         var result = JSON.parse(response);
        //         manageTabVisibility.call(_self, result.hasSpares);
        //     })
        //     .catch(function (error) {
        //         console.debug("SpareAndRelatedProductsTab error" + error);
        //     });
        manageTabVisibility.call(_self, true);
    }

    function manageTabVisibility(hasSpares) {
        var _self = this;
        if (hasSpares) {
            if (isSeries) {
                _self.$spareAndRelatedProductsNav.click(spareAndRelatedProducts.bind(_self, _self.config.partnumber));
            } else {
                _self.$spareAndRelatedProductsNav.click(spareAndRelatedProducts.bind(_self, _self.config.partnumber));
            }
        } else {
            _self.$spareAndRelatedProductsNav.addClass('disabled');
        }
    }

    function initializeToolTab() {
        var _self = this;
        this.$toolNav.click(tools.bind(_self, _self.config.partnumber));
    }

    function initializeCheckPricesTab() {
        var _self = this;
        this.$checkPricesNav.click(checkPrices.bind(_self, _self.config.partnumber));
    }


    function replacePartNumber(partNumber, endpointUrl) {
        var url = new URL(endpointUrl);
        url.searchParams.set('partNumber', partNumber);
        return url;
    }

    function getProductDetailInfo(urlBase, partNumber) {
        var data = {
            componentId: this.id,
            productId: this.productId,
            language: this.config.defaultLanguage || 'en',
            partNumber: partNumber
        };
        this.activeProductLayout();
        var url = replacePartNumber(partNumber, urlBase);
        return $.get(url, data);
    }

    function productDetail(partNumber, event) {
        var _self = this;
        var $msgBody = _self.$ssiProductContent;

        var $container = _self.$ssiProductDetailTab;

        if (!$msgBody.is(':empty')) {
            $container.removeClass('d-flex');
            $container.removeClass('hidden');
            $container.removeClass('disabled');
            return;
        }

        $container.addClass('d-flex');
        this.initLoading($container);
        getProductDetailInfo.call(this, globalConfig.ssi.urls.showProductDetail, partNumber)
            .then(function (response) {
                $msgBody.append(response);
                _self.endLoading($container);
            })
            .catch(function () {
                _self.disabledProductLayout();
                _self.endLoading($container);
            });
    }

    function techSpecs(partNumber, event) {
        var _self = this;
        var $msgBody = _self.$ssiProductContent;

        var $container = _self.$ssiProductDetailTab;

        if (!$msgBody.is(':empty')) {
            $container.removeClass('d-flex');
            $container.removeClass('hidden');
            $container.removeClass('disabled');
            return;
        }

        $container.addClass('d-flex');
        this.initLoading($container);
        getProductDetailInfo.call(this, globalConfig.ssi.urls.showTechSpecs, partNumber)
            .then(function (response) {
                $msgBody.append(response);
                if ($container.closest('.spare-accessory-item__collapsed_details').find('.check-prices-data').length > 0) {
                    let eclassCode = $container.closest('.spare-accessory-item__collapsed_details').find('.check-prices-data .eclass-code .value').text();
                    if (eclassCode) {
                        $('.eclass-code .key-text-value', $msgBody).html(eclassCode);
                        $('.eclass-code', $msgBody).show();
                    }
                    else {
                        $('.eclass-code', $msgBody).hide();
                    }
                    let eclassVersion = $container.closest('.spare-accessory-item__collapsed_details').find('.check-prices-data .eclass-version .value').text();
                    if (eclassVersion) {
                        $('.eclass-version .key-text-value', $msgBody).html(eclassVersion);
                        $('.eclass-version', $msgBody).show();
                    } else {
                        $('.eclass-version', $msgBody).hide();
                    }
                    let unspscCode = $container.closest('.spare-accessory-item__collapsed_details').find('.check-prices-data .unspsc-number .value').text();
                    if (unspscCode) {
                        $('.unspsc-number .key-text-value', $msgBody).html(unspscCode);
                        $('.unspsc-number', $msgBody).show();
                    }
                    else {
                        $('.unspsc-number', $msgBody).hide();
                    }
                    let unspscVersion = $container.closest('.spare-accessory-item__collapsed_details').find('.check-prices-data .unspsc-version .value').text();
                    if (unspscVersion) {
                        $('.unspsc-version .key-text-value', $msgBody).html(unspscVersion);
                        $('.unspsc-version', $msgBody).show();
                    } else {
                        $('.unspsc-version', $msgBody).hide();
                    }
                }

                _self.endLoading($container);
            })
            .catch(function () {
                _self.disabledProductLayout();
                _self.endLoading($container);
            });
    }

    function putItToWork(event) {
        var _self = this;
        var $msgBody = _self.$ssiProductContent;

        var $container = _self.$ssiProductDetailTab;

        if (!$msgBody.is(':empty')) {
            $container.removeClass('d-flex');
            $container.removeClass('hidden');
            $container.removeClass('disabled');
            return;
        }

        $container.addClass('d-flex');
        this.initLoading($container);
        getProductDetailInfo.call(this, globalConfig.ssi.urls.showPutItToWork, partNumber)
            .then(function (response) {
                $msgBody.append(response);
                _self.endLoading($container);
            })
            .catch(function () {
                _self.disabledProductLayout();
                _self.endLoading($container);
            });
    }

    function tools(partNumber, event) {
        this.activeProductLayout();
    }

    function checkPrices(partNumber, event) {
        var _self = this;

        var $container = _self.$checkPricesTab;

        $container.addClass('d-flex');
        if (!$("#check_prices_" + this.config.partnumber.replaceAll("/", "_") + " .erp-info-message").hasClass("hidden") || !$("#check_prices_" + this.config.partnumber.replaceAll("/", "_") + " .product-prices").hasClass("hidden")) {
            $container.removeClass('d-flex');
            $container.removeClass('hidden');
            $container.removeClass('disabled');
            return;
        }
        $('.loading-container-js', $container).addClass('spinner-margin');
        $container.addClass('d-flex');
        this.initLoading($container);

        this.activeProductLayout();

        var addTobasketId = $('.add-to-basket-bar-component', this.$checkPricesTab.parents('.product-catalogue-item'))[0].id;
        var addToBasketComponent = window.smc.ComponentManager.getComponentById(addTobasketId);
        if (addToBasketComponent) {
            addToBasketComponent.updateProductPrices();
            addToBasketComponent.updateStatus();
        } else {
            addTobasketId = $('.idbl_hto__content__addtobasketbar', this.$checkPricesTab.parents('.product-catalogue-item'))[0].id;
            addToBasketComponent = window.smc.ComponentManager.getComponentById(addTobasketId);
            if (addToBasketComponent) {
                addToBasketComponent.updateProductPrices();
                addToBasketComponent.updateStatus();
            }
        }
    }

    function spareAndRelatedProducts(partNumber, event) {
        var _self = this;
        var $msgBody = _self.$spareAndRelatedProductContent;

        if (!$msgBody.is(':empty')) {
            return;
        }

        var data = {
            componentId: this.id,
            productId: this.productId,
            language: this.config.defaultLanguage || 'en',
            partNumber: partNumber
        };
        this.activeProductLayout();

        if (isSeries) {
            var url = replacePartNumber(partNumber, globalConfig.ssi.urls.showSeriesSpareAndRelatedProducts);
        } else {
            var url = replacePartNumber(partNumber, globalConfig.ssi.urls.showSpareAndRelatedProducts);
        }
        var $container = _self.$spareAndRelatedProductsTab;
        _self.initLoading($container);

        $.get(url, data)
            .then(function (response) {
                $msgBody.append($(response));
                _self.endLoading($container);
                if ($("#accessories_" + partNumber + "_products-result-container").is(":empty")) {
                    _self.$spareAndRelatedProductsNav.addClass('disabled');
                }
            })
            .catch(function () {
                _self.disabledProductLayout();
                _self.endLoading($container);
                _self.$spareAndRelatedProductsNav.addClass('disabled');
            });
        $container.removeClass('hidden');
    }

    function activeProductLayout() {
        this.showTabLine(this.config.partnumber);
        this.$ssiContainer.addClass('active-item');
    }

    function disabledProductLayout() {
        this.hideTabLine(this.config.partnumber);
        // this.$ssiContainer.removeClass('active-item');
    }

    function checkForUpdatedData(response) {
        var def = $.Deferred();
        if (response.status === 'UPDATED') {
            ssiLoadingStartTime[this.config.partnumber] = 0;
            ssiLoadedPartNumber[response.partNumber] = response;
            $("#ssi-detail-tab_" + response.partNumber.replaceAll("/", "_")).removeClass("disabled");
            $("#ssi-detail-tab_" + response.partNumber.replaceAll("/", "_")).removeAttr("disabled");
            def.resolve(response);
        } else if (response.status !== 'ERROR') {
            var currentTimeInMillic = (new Date()).getTime();
            if ((currentTimeInMillic - ssiLoadingStartTime[this.config.partnumber]) < 100000 && ssiLoadingStartTime[this.config.partnumber] !== 0) {
                //1 minute of max time for retries
                setTimeout(function () {
                    _loadProductInfo.call(this);
                }.bind(this), 3000);
            } else {
                $("#ssi-detail-tab_" + response.partNumber.replaceAll("/", "_")).addClass("disabled");
                $('.spinner-container', $("#productssi_" + response.partNumber.replaceAll("/", ""))).remove();
            }
        } else {
            ssiLoadingStartTime[this.config.partnumber] = 0;
            if (response !== undefined && response.partNumber !== undefined) {
                $("#ssi-detail-tab_" + response.partNumber.replaceAll("/", "_")).addClass("disabled");
                $('.spinner-container', $("#productssi_" + response.partNumber)).remove();
            }
        }

        return def.promise();
    }

    function printProductInfoPreview(response) {
        if (response === undefined || ssiLoadedPartNumber[this.config.partnumber] !== undefined) {
            response = ssiLoadedPartNumber[this.config.partnumber];
        }
        this.templates.attributeListItemTemplateHTML = this.templates.attributeListItemTemplateHTML || document.getElementById('attributeListItemTemplate').innerHTML;
        var attributeListItemTemplateHTML = this.templates.attributeListItemTemplateHTML;

        var attributesHTML = '';
        if (isSeries && ssi_columns !== "") {
            firstElement = true;
            ssi_columns.forEach(function (column, index) {
                var elementValue = response.data[column - 1];

                if (elementValue) {
                    attributesHTML += attributeListItemTemplateHTML
                        // .replace('{{attributeName}}', response.data[column-1].key)
                        .replace('{{attributeValue}}', elementValue.value)
                        .replace('{{attributeKey}}', elementValue.key);


                    if (firstElement) {
                        $("#column_" + column.toString()).html(elementValue.key);
                        if (index === ssi_columns.length - 1) {
                            firstElement = false;
                        }
                    }
                }
            })
        } else {
            response && response.data.forEach(function (attribute) {
                attributesHTML += attributeListItemTemplateHTML
                    .replace('{{attributeName}}', attribute.key)
                    .replace('{{attributeValue}}', attribute.value);
            });
        }
        this.$ssiContainer.addClass('active-item');
        $('.attribute-list', this.$ssiProductPreviewContainer).html(attributesHTML);

        $('.spinner-container', this.$ssiContainer).remove();
    }

    function handleProductDetailInfoError() {
        $('.spinner-container', this.$ssiContainer).remove();
    }

    function initLoading($container) {
        $container.addClass('disabled');
        $container.addClass('hidden');
        $('.loading-container-js', $container)
            .addClass('loading-container')
            .html(this.templates.spinnerTemplateHTML);
    }

    function endLoading($container) {
        $('.loading-container-js', $container)
            .removeClass('loading-container')
            .html('');
        $container.removeClass('disabled');
    }

    function showTabLine(partNumber) {
        $('.tab-line-' + partNumber.replaceAll("/", "_") + '-js').show();
    }

    function hideTabLine(partNumber) {
        $('.tab-line-' + partNumber.replaceAll("/", "_") + '-js').hide();
    }


    window.smc.SsiProduct = SsiProduct;
})(window.smc);