// var cadOnLoad = false;

(function (globalConfig) {
    var MAX_TIMEOUT_RETRIES = 3;

    function ProductToolbar(config) {
        this.id = config.id;
        this.config = config;
        this.isFirstLoading = true;
        this.preview3DLoading = false;
        this.cadAvailable = true;
    }

    ProductToolbar.prototype.init = init;
    ProductToolbar.prototype.initializeEvents = initializeEvents;
    ProductToolbar.prototype.updateStatus = updateStatus;
    ProductToolbar.prototype.dispose = dispose;
    ProductToolbar.prototype.initLoading = initLoading;
    ProductToolbar.prototype.endLoading = endLoading;
    ProductToolbar.prototype.getPartNumber = getPartNumber;
    ProductToolbar.prototype.isValidConfiguration = isValidConfiguration;
    ProductToolbar.prototype.showCadDownload = _checkServiceAvailability(showCadDownload);
    ProductToolbar.prototype.getDatasheet = _checkServiceAvailability(getDatasheet);
    ProductToolbar.prototype.getSalesDocument = _checkServiceAvailability(getSalesDocument);
    ProductToolbar.prototype.show3dPreview = _checkServiceAvailability(show3dPreview);
    ProductToolbar.prototype.make3DPreviewCall = make3DPreviewCall;
    ProductToolbar.prototype.reload3DPreview = $.debounce(100, _checkServiceAvailability(reload3DPreview));
    ProductToolbar.prototype.generateURLFor = generateURLFor;
    ProductToolbar.prototype.updateServiceAvailability = updateServiceAvailability;
    ProductToolbar.prototype.isDatasheetAvailableInCache = isDatasheetAvailableInCache;
    ProductToolbar.prototype.isCADAvailableInCache = isCADAvailableInCache;

    function init() {
        console.debug('[ProductToolbar]', 'init id=', this.id);
        if (!this.config.container) {
            throw new Error('"Container" is required');
        }
        $(".aument-preview-link").addClass("hidden");
        this.templates = {
            spinnerTemplateHTML: document.getElementById('spinner-template').innerHTML
        };
        this.links = {
            showFeatureCatalogues: $('.show-feature-catalogues', this.config.container),
            showSeriesCatalogues: $('.show-series-catalogues', this.config.container),
            showMultilingualDocuments: $('.show-multilingual-documents', this.config.container),
            showTechnicalDocumentation: $('.show-technical-documentation', this.config.container),
            show3dPreview: $('.show-3d-preview', this.config.container),
            aument3dPreview: $('.aument-preview-link', this.config.container),
            showCadDownload: $('.show-cad-download', this.config.container),
            showDatasheet: $('.show-datasheet', this.config.container),
            showAskSmc: $('.show-ask-smc', this.config.container),
            showAskSmcStock: $('#idbl_hto__content__data_contact_smc'),
            showShareYourSuccess: $('.show-share-your-success', this.config.container),
            showVideo: $('.show-video', this.config.container),
            showImages: $('.show-images', this.config.container),
            showSalesDocument: $('.show-sales-document', this.config.container),
            showPressRelease: $('.show-press-release', this.config.container),
            isDatasheetAvailableInCache: $('.is-datasheet-available-in-cache', this.config.container),
            isCADAvailableInCache: $('.is-CAD-available-in-cache', this.config.container),
            showAdditionalContent: $('.show-additional-content', this.config.container)
        };
        this.languageTemplates = {
            'featuresCatalogue': document.getElementById('feature-catalogues-language-item-template').innerHTML,
            'seriesCatalogue': document.getElementById('series-catalogues-language-item-template').innerHTML,
            'technicalDocumentation': document.getElementById('technical-document-language-item-template').innerHTML,
            'multilingualDocuments': document.getElementById('multilingual-documents-language-item-template').innerHTML
        };

        if (this.config.renderingMode === '3d-preview') {
            var $toolTab = $("#tools_tab_" + this.getPartNumber());
            var self_ = this;
            $toolTab.click(function () {
                if (!$toolTab.hasClass("preview-unloaded-js")) {
                    return;
                }
                self_.reload3DPreview();
                $toolTab.removeClass("preview-unloaded-js")

            });
        }
        _loadDependencies.call(this)
            .then(function () {
                if ($("#valve-configurator-container") !== undefined || $("#valve-configurator-container").length !== 0) {
                    this.links.showFeatureCatalogues.removeAttr('disabled');
                }
                this.initializeEvents();
                this.updateStatus(this.isFirstLoading);
                $(document).trigger('smc.registercomponent', [this.id, this]);
                this.isFirstLoading = false;
            }.bind(this));
    }

    function initializeEvents() {
        var _self = this;

        //Show content By Click in toolbar-hover
        $('.product-toolbar-title-js', this.config.container).on('click', function () {

            var $container = $(this).closest('.product-toolbar-item').find('.product-toolbar-content-js').first();
            if (!isReloadingData && !_closeContainerWhenVisible.call(this, $container)) {
                return;
            }
            $container.addClass('opened').show();

            if (_self.config.renderingMode === 'dropdown-category-item') {
                $(_self.config.container).closest('.category-tile-wrapper').addClass('category-tile-product-toolbar-opened');
            }
        });

        //Close Button
        $(this.config.container).on('click', '.close-btn-js', function () {
            var $container = $(this).closest('.product-toolbar-content-js');
            $container.removeClass('opened').hide();
            $container.closest('li').removeClass('opened');
        });
        $(this.config.container).on('click', '.close-btn-main-js', function () {
            if (_self.config.renderingMode === 'dropdown-category-item') {
                $(_self.config.container).closest('.category-tile-wrapper').removeClass('category-tile-product-toolbar-opened');
            }
        });

        var isReloadingData = false;
        this.links.showFeatureCatalogues.on("click", showFeatureCatalogues.bind(this, this.config.language || this.config.defaultLanguage, isReloadingData, false));
        this.links.showSeriesCatalogues.on("click", showSeriesCatalogues.bind(this, this.config.language || this.config.defaultLanguage, isReloadingData, false, null));
        this.links.showMultilingualDocuments.on("click", showMultilingualDocuments.bind(this, this.config.language || this.config.defaultLanguage, isReloadingData));
        this.links.showTechnicalDocumentation.on("click", showTechnicalDocumentation.bind(this, this.config.language || this.config.defaultLanguage, isReloadingData));
        this.links.show3dPreview.on("click", _self.show3dPreview.bind(_self));
        this.links.aument3dPreview.on("click", _self.show3dPreview.bind(_self));
        this.links.showCadDownload.unbind('click').on("click", _self.showCadDownload.bind(_self));
        this.links.showDatasheet.on("click", _self.getDatasheet.bind(_self));
        this.links.showAskSmc.on("click", showAskSMC.bind(this));
        if (this.links.showAskSmcStock !== undefined) {
            if (this.config.partNumber.toString() === "") {
                this.links.showAskSmcStock.unbind('click');
                this.links.showAskSmcStock.on("click", showAskSMC.bind(this));
            }
        }
        this.links.showShareYourSuccess.on("click", showShareYourSuccess.bind(this));
        this.links.showVideo.on("click", showVideo.bind(this));
        this.links.showImages.on("click", showImages.bind(this));
        this.links.showSalesDocument.on("click", _self.getSalesDocument.bind(_self));
        this.links.showPressRelease.on("click", showPressRelease.bind(this));
        this.links.showAdditionalContent.on("click", showAdditionalContent.bind(_self));

        $(document).on('smc.productConfiguratorComponent.created', updateProductConfiguratorComponent.bind(this));
        $(document).on('smc.partNumber.changed', onPartNumberChanged.bind(this));

        //Valve configurator
        $(document).on('smc.productToolbar.3dPreview.enable', preview3dEnable.bind(this));
        $(document).on('smc.productToolbar.3dPreview.disable', preview3dDisable.bind(this));
        $(document).on('smc.productToolbar.cadDownload.enable', cadDownloadEnable.bind(this));
        $(document).on('smc.productToolbar.cadDownload.disable', cadDownloadDisable.bind(this));
        $(document).on('smc.productToolbar.datasheetDownload.enable', datasheetDownloadEnable.bind(this));
        $(document).on('smc.productToolbar.datasheetDownload.disable', datasheetDownloadDisable.bind(this));
        $(document).on('smc.productToolbar.salesDocumentDownload.enable', salesDocumentDownloadEnable.bind(this));
        $(document).on('smc.productToolbar.salesDocumentDownload.disable', salesDocumentDownloadDisable.bind(this));
        $(document).on('smc.productToolbar.reloadPreview', reload3DPreview.bind(this));
        //
        // if (window.location.href.indexOf("openCad") > 0 && !cadOnLoad ) {
        //     cadOnLoad = true;
        //     setTimeout(function(){
        //         _self.showCadDownload();
        //         removeExtraUrlVar("openCad");
        //     },2000);
        // }
    }

    // function removeExtraUrlVar(varName){
    //     var currentUrl = window.location.href;
    //     if (window.location.href.indexOf(varName) > 0){
    //         var url = new URL(currentUrl);
    //         url.searchParams.delete(varName);
    //         window.history.pushState({}, window.document.title, url.toString());
    //     }
    // }


    function updateStatus(isFirstLoading) {
        this.updateServiceAvailability()
            .then(_updateStatus.bind(this, isFirstLoading))
            .then(_handleProductToolbarVisibility.bind(this, isFirstLoading));
    }

    function _updateStatus(isFirstLoading) {
        return $.when(
            _activateFeatureCatalogue.call(this, isFirstLoading),
            _activateTechnicalDocumentation.call(this, isFirstLoading),
            _activateCadDownload.call(this, isFirstLoading),
            _activateGetDatasheet.call(this, isFirstLoading),
            _activateGetCAD.call(this, isFirstLoading),
            _activate3DPreview.call(this, isFirstLoading),
            _activateAskSMC.call(this, isFirstLoading),
            _activateVideo.call(this, isFirstLoading));
    }

    function _activateFeatureCatalogue(isFirstLoading) {
        var def = $.Deferred();
        var _self = this;

        var isLinkActive = !!(this.links.showFeatureCatalogues && this.links.showFeatureCatalogues.length);
        if (isLinkActive) {
            var data = {
                productId: this.config.productId,
                language: this.config.language || this.config.defaultLanguage
            };

            new Waypoint({
                element: this.links.showFeatureCatalogues,
                context: this.config.container,
                handler: function () {
                    //Activate FeatureCatalogue only if there are documents available
                    _getFeatureCatalogues(data)
                        .then(function (response) {
                            def.resolve(!!(response.availableLanguages) && (response.items && response.items.length));
                        }.bind(_self))
                        .catch(function () {
                            def.resolve(false);
                        });

                    this.destroy();
                },
                offset: '75%'
            });
        } else {
            def.resolve(false);
        }

        return def.promise();
    }

    function _activateTechnicalDocumentation(isFirstLoading) {
        var def = $.Deferred();
        var _self = this;

        var isLinkActive = !!(this.links.showTechnicalDocumentation && this.links.showTechnicalDocumentation.length);
        if (isLinkActive) {
            var data = {
                productId: this.config.productId,
                language: this.config.language || this.config.defaultLanguage
            };

            new Waypoint({
                element: this.links.showTechnicalDocumentation,
                context: this.config.container,
                handler: function () {
                    //Activate TechnicalDocumentation only if there are documents available
                    _getTechnicalDocumentation(data)
                        .then(function (response) {
                            def.resolve(!!(response.availableLanguages));
                        }.bind(_self))
                        .catch(function () {
                            def.resolve(false);
                        });

                    this.destroy();
                },
                offset: '75%'
            });
        } else {
            def.resolve(false);
        }

        return def.promise();
    }

    function _activateCadDownload() {
        var def = $.Deferred();
        def.resolve(!!(this.getPartNumber() && this.isValidConfiguration()));
        // def.resolve(!!(this.config.isEtechEnabled && this.getPartNumber() && this.isValidConfiguration()));

        return def.promise();
    }

    function _activateGetDatasheet() {
        var def = $.Deferred();
        var _self = this;

        // def.resolve(!!(this.config.isEtechEnabled && this.getPartNumber() && this.isValidConfiguration()));
        // console.debug("[_activateGetDatasheet]_DATASHEET",this.links.showDatasheet);
        if (_self.getPartNumber() === "" || !(_self.isValidConfiguration())) {
            // console.log("_activateGetDatasheet():: No part number | no valid config",_self.getPartNumber(), _self.isValidConfiguration());
            def.resolve(false);
        }
        if (this.links.showDatasheet.length > 0 && (_self.getPartNumber() !== "") && _self.isValidConfiguration()) {
            _self.isDatasheetAvailableInCache()
                .then(function (response) {
                    def.resolve(!!(response.available && _self.getPartNumber() && _self.isValidConfiguration()));
                }).catch(function () {
                def.resolve(false);
            });
        } else {
            def.resolve(false);
        }
        return def.promise();
    }

    function _activateGetCAD() {
        var def = $.Deferred();
        var _self = this;
        if ($("#valve-configurator-container") === undefined || $("#valve-configurator-container").length === 0) {
            if (_self.getPartNumber() === "" || !(_self.isValidConfiguration())) {
                def.resolve(false);
            }
            if (this.links.showCadDownload.length > 0 && (_self.getPartNumber() !== "") && _self.isValidConfiguration()) {
                _self.isCADAvailableInCache()
                    .then(function (response) {
                        def.resolve(!!(response.available && _self.getPartNumber() && _self.isValidConfiguration()));
                    }).catch(function () {
                    def.resolve(false);
                });
            } else {
                def.resolve(false);
            }
        }
        return def.promise();
    }

    function _activate3DPreview() {
        var def = $.Deferred();
        if ($("#valve-configurator-container") !== undefined || $("#valve-configurator-container").length === 0) {
            if (!this.isValidConfiguration()) {
                $(".aument-preview-link").addClass("hidden");
            }
            if (this.config.renderingMode !== '3d-preview') {
                if (!(this.links.show3dPreview && this.links.show3dPreview.length)) {
                    def.resolve(false);
                }

                if (!!(this.links.show3dPreview.attr('disabled'))) {
                    def.resolve(false);
                }
            }
            def.resolve(this.config.isCadenasEnabled);
        }
        // def.resolve(this.config.isEtechEnabled && this.config.isCadenasEnabled);

        return def.promise();
    }

    function _activateAskSMC() {
        var def = $.Deferred();

        var askSmcLink = this.links.showAskSmc.not('.category-tile__footer__mailIcon');
        def.resolve(!!(askSmcLink && askSmcLink.length));

        return def.promise();
    }

    function _activateVideo() {
        var def = $.Deferred();

        def.resolve(!(this.links.showVideo.attr('disabled')));

        return def.promise();
    }

    function establishPreview3DVisibility(_self, isFirstLoading, fromCadAvailable) {
        if (parseAccesories().length > 0 && fromCadAvailable === undefined) {
            // Wait to cad available response when accesories
        } else {
            var cadAvailable = true;
            if (fromCadAvailable && fromCadAvailable == true) {
                cadAvailable = _self.cadAvailable;
            }
            if (cadAvailable && _self.config.renderingMode === '3d-preview' && _self.config.isCadenasEnabled
                && (isFirstLoading && (_self.getPartNumber() && _self.isValidConfiguration()))) {
                _self.reload3DPreview();
            } else if (cadAvailable && _self.config.renderingMode === '3d-preview' && _self.config.isCadenasEnabled
                && (!isFirstLoading && (_self.getPartNumber() && _self.isValidConfiguration()))) {
                _self.reload3DPreview();
            } else {
                _self.$3dPreviewIframe = $('.preview-3d-iframe', _self.config.container);
                if (_self.isValidConfiguration()) {
                    _self.$3dPreviewIframe.html('<p class="no-preview-3D-message">{{noPreview3DAvailable}}</p>'
                        .replace('{{noPreview3DAvailable}}', _self.config.messages.noPreview3DFound));
                } else {
                    _self.$3dPreviewIframe.html('<p class="no-preview-3D-message">{{noPreview3DAvailable}}</p>'
                        .replace('{{noPreview3DAvailable}}', _self.config.messages.noPreview3DAvailable));
                }
            }
        }

    }

    function _handleProductToolbarVisibility(isFirstLoading, featuresCatalogue, technicalDocumentation, cadDownload, getDatasheet, preview3D, askSMC, video) {
        // console.log("[_handleProductToolbarVisibility]",isFirstLoading, featuresCatalogue, technicalDocumentation, cadDownload, getDatasheet, preview3D, askSMC, video);
        var _self = this;

        establishPreview3DVisibility.call(this, _self, isFirstLoading);

        if (featuresCatalogue) {
            this.links.showFeatureCatalogues.removeAttr('disabled');
        } else {
            this.links.showFeatureCatalogues.attr('disabled', 'disabled');
        }

        if (technicalDocumentation) {
            this.links.showTechnicalDocumentation.removeAttr('hidden');
        } else {
            this.links.showTechnicalDocumentation.attr('hidden', 'hidden');
        }

        if (this.links.showDatasheet.length > 0) {
            var doesNotHasDatasheet = $("#show-datasheet-link").hasClass("no-datasheet");
            console.debug("[_handleProductToolbarVisibility]_DATASHEET", _self);
            if (_self.getPartNumber() && _self.isValidConfiguration()) {
                _self.isDatasheetAvailableInCache()
                    .then(function (response) {
                        if (response.available && getDatasheet && !doesNotHasDatasheet) {
                            _self.links.showDatasheet.removeClass('hidden');
                        } else {
                            _self.links.showDatasheet.addClass('hidden');
                        }

                        if (response.available && _self.getPartNumber() && _self.isValidConfiguration()) {
                            _self.links.showDatasheet.removeClass('hidden');
                            _self.links.showDatasheet.removeAttr('disabled');
                        } else {
                            _self.links.showDatasheet.attr('disabled', 'disabled');
                        }
                    }).catch(function (err) {
                    console.error('isDatasheetAvailableInCache', err);
                });
            } else {
                _self.links.showDatasheet.attr('disabled', 'disabled');
            }
        } else {
            _self.links.showDatasheet.addClass('hidden');
        }

        if (this.links.showCadDownload.length > 0) {
            console.debug("[_handleProductToolbarVisibility]_CAD");
            if (_self.getPartNumber() && _self.isValidConfiguration()) {
                _self.isCADAvailableInCache()
                    .then(function (response) {
                        _self.cadAvailable = response.available;

                        establishPreview3DVisibility.call(this, _self, isFirstLoading, true);

                        if (response.available && cadDownload) {
                            _self.links.showCadDownload.removeAttr('disabled');
                        } else {
                            _self.links.showCadDownload.attr('disabled', 'disabled');
                        }
                        if (response.available && _self.getPartNumber() && _self.isValidConfiguration()) {
                            _self.links.showCadDownload.removeAttr('disabled');
                        } else {
                            _self.links.showCadDownload.attr('disabled', 'disabled');
                        }
                    }).catch(function (err) {
                    console.error('isCADAvailableInCache', err);
                });
            } else {
                _self.links.showCadDownload.attr('disabled', 'disabled');
            }
        } else {
            _self.links.showCadDownload.attr('disabled', 'disabled');
        }

        if (preview3D) {
            this.links.show3dPreview.removeAttr('disabled');
            this.links.aument3dPreview.removeAttr('disabled');
        } else {
            this.links.show3dPreview.attr('disabled', 'disabled');
            this.links.aument3dPreview.attr('disabled', 'disabled');
            this.$3dPreviewIframe = this.$3dPreviewIframe || $('.preview-3d-iframe', this.config.container);
            var errorMessage = this.config.isEtechEnabled ? this.config.messages.noPreview3DAvailable : this.config.messages.functionalityNotAvailable;
            if (this.isValidConfiguration()) {
                errorMessage = this.config.isEtechEnabled ? this.config.messages.noPreview3DFound : this.config.messages.functionalityNotAvailable;
            }
            this.$3dPreviewIframe.html('<p class="no-preview-3D-message">{{message}}</p>'
                .replace('{{message}}', errorMessage));
        }


        var functionalities = Array.prototype.slice.call(arguments, 1);
        var allFunctionalitiesDisabled = functionalities.every(function (available) {
            return !available;
        });
        if (allFunctionalitiesDisabled) {
            //Dispose Product toolbar
            this.dispose();
        }
    }

    function dispose() {
        //TODO Dispose event listeners

        $(this.config.container).next('script').remove();
        this.config.container.html('<p class="hidden">Removed due to no functionality enabled detected</p>');
        this.config.container[0].className = '';
        $(document).trigger('smc.deregistercomponent', [this.id]);
    }

    function initLoading($container) {
        $container.attr('disabled', 'disabled');
        $('.loading-container-js', $container)
            .addClass('loading-container')
            .html(this.templates.spinnerTemplateHTML);
    }

    function endLoading($container) {
        $container.removeAttr('disabled');
        $('.loading-container-js', $container)
            .removeClass('loading-container')
            .html('');
    }

    function getPartNumber() {
        var partNumber = this.config.partNumber;
        if (this.config.isManualPartNumber) {
            return partNumber;
        }

        if (this.config.productConfiguratorComponent) {
            partNumber = this.config.productConfiguratorComponent.getPartNumber();
        }

        if (partNumber == null) {
            partNumber = getUrlParameter("partNumber");
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

    function showFeatureCatalogues(language, isReloadingData, isDownload, event) {
        if (event) event.preventDefault();
        isReloadingData = isReloadingData !== undefined ? isReloadingData : false;
        var _self = this;
        var $featureCataloguesAdditionalContent = $('.feature-catalogues-additional-content-js', _self.config.container);
        if (!isReloadingData && !_closeContainerWhenVisible.call(this, $featureCataloguesAdditionalContent)) {
            return;
        }
        var data = {
            productId: this.config.productId,
            language: language
        };
        //Activate loading state
        $featureCataloguesAdditionalContent
            .html(this.templates.spinnerTemplateHTML)
            .closest('li').addClass('opened');
        $featureCataloguesAdditionalContent.show();
        _getFeatureCatalogues(data)
            .then(function (response) {
                console.debug('[showFeatureCatalogues]', response);
                var availableLanguages = response.availableLanguages.map(function (lang) {
                    return lang.toLowerCase();
                });

                var featureCataloguesTemplateHTML = document.getElementById('feature-catalogues-template').innerHTML
                    .replace(/{{id}}/gm, _self.id);

                var $featureCatalogTemplateHTML = $(featureCataloguesTemplateHTML);
                if (!(availableLanguages && availableLanguages.length) || !(response.items && response.items.length)) {
                    //Show no results message
                    $featureCatalogTemplateHTML.find('.no-results-js').removeClass('hidden');

                } else {
                    var featureCatalogueItemTemplateHTML = document.getElementById('feature-catalogues-item-template').innerHTML
                        .replace('{{fileUrl}}', response.items[0].url)
                        .replace('{{language}}', language)
                        .replace('{{localeName}}', globalConfig.languages[language] || globalConfig.languages['en'])//TODO get from global properties
                        .replace('{{statisticsSource}}', _self.config.statisticsSource);
                    $('.content-body-js', $featureCatalogTemplateHTML).append($(featureCatalogueItemTemplateHTML));
                    $featureCataloguesAdditionalContent.html($featureCatalogTemplateHTML.html());

                    if (isDownload) {
                        $('#download-feature-catalogues').get(0).click();
                        $('.feature-catalogues-additional-content.feature-catalogues-additional-content-js.product-toolbar-content-js.opened').hide();
                        $('.show-feature-catalogues.iconed-text.additional-content-dropdown').click();
                    }
                    let orderedAvailableLanguages = orderDocumentLanguages(availableLanguages, _self.config.defaultLanguage);
                    var $otherLanguages = $('.other-languages-js', $featureCataloguesAdditionalContent).show();
                    var fillLanguages = _fillLanguages.bind(_self, $featureCataloguesAdditionalContent, orderedAvailableLanguages, 'featuresCatalogue');
                    fillLanguages();
                }
                if (!isDownload) {
                    //Open container
                    $featureCataloguesAdditionalContent
                        .addClass('opened')
                        .find('.feature-catalogues-template-content-js')
                        .first()
                        .show();
                }
            }).catch(function (err) {
            console.error('showFeatureCatalogues', err);
            $featureCataloguesAdditionalContent.hide();
        });
    }

    function showSeriesCatalogues(language, isReloadingData, isDownload, catalogueId, event) {
        if (event) event.preventDefault();
        isReloadingData = isReloadingData !== undefined ? isReloadingData : false;
        var _self = this;
        if (!catalogueId) {
            catalogueId = event.target.dataset.id;
        }
        var $seriesCataloguesAdditionalContent = $($('.series-catalogues-additional-content-js', _self.config.container).get(catalogueId));
        // if (!isReloadingData && !_closeContainerWhenVisible.call(this, $seriesCataloguesAdditionalContent)) {
        //     return;
        // }


        var data = {
            nodeId: this.config.nodeId,
            language: language
        };
        //Activate loading state
        $seriesCataloguesAdditionalContent
            .html(this.templates.spinnerTemplateHTML)
            .closest('li').addClass('opened');
        $seriesCataloguesAdditionalContent.show();
        _getSeriesCatalogues(data)
            .then(function (response) {
                console.debug('[showSeriesCatalogues]', response);
                var availableLanguages = response.availableLanguages.map(function (lang) {
                    return lang.toLowerCase();
                });

                var seriesCataloguesTemplateHTML = document.getElementById('series-catalogues-template').innerHTML
                    .replace(/{{id}}/gm, _self.id);

                var $seriesCataloguesTemplateHTML = $(seriesCataloguesTemplateHTML);
                if (!(availableLanguages && availableLanguages.length) || !(response.items && response.items.length)) {
                    //Show no results message
                    $seriesCataloguesTemplateHTML.find('.no-results-js').removeClass('hidden');

                } else {
                    var seriesCataloguesItemTemplateHTML = document.getElementById('series-catalogues-item-template').innerHTML
                        .replace('{{fileUrl}}', response.items[catalogueId].url)
                        .replace('{{language}}', language)
                        .replace('{{catalogueId}}', catalogueId)
                        .replace('{{localeName}}', globalConfig.languages[language] || globalConfig.languages['en'])//TODO get from global properties
                        .replace('{{statisticsSource}}', _self.config.statisticsSource);
                    $('.content-body-js', $seriesCataloguesTemplateHTML).append($(seriesCataloguesItemTemplateHTML));
                    $seriesCataloguesAdditionalContent.html($seriesCataloguesTemplateHTML.html());

                    if (isDownload) {
                        $('#download-series-catalogues').get(0).click();
                    }
                    let orderedAvailableLanguages = orderDocumentLanguages(availableLanguages, _self.config.defaultLanguage);
                    var $otherLanguages = $('.other-languages-js', $seriesCataloguesAdditionalContent).show();
                    var fillLanguages = _fillLanguages.bind(_self, $seriesCataloguesAdditionalContent, orderedAvailableLanguages, 'seriesCatalogue', null, catalogueId);
                    fillLanguages();
                }
                if (!isDownload) {
                    //Open container
                    $seriesCataloguesAdditionalContent
                        .addClass('opened')
                        .find('.series-catalogues-template-content-js')
                        .first()
                        .show();
                }

            }).catch(function (err) {
            console.error('showSeriesCatalogues', err);
            $seriesCataloguesAdditionalContent.hide();
        });
    }

    function orderDocumentLanguages(availableLanguages, defaultLanguage) {
        let orderedAvailableLanguages = [];
        let mainLanguage;
        const globalLanguages = globalConfig && globalConfig.languages;

        //FIX for IE
        // let orderedGlobalLanguages = Object.entries(globalLanguages).sort(([, a], [, b]) => a.localeCompare(b)).map(arr => arr[0]);
        var _slicedToArray = function () { function sliceIterator(arr, i) { var _arr = []; var _n = true; var _d = false; var _e = undefined; try { for (var _i = arr[Symbol.iterator](), _s; !(_n = (_s = _i.next()).done); _n = true) { _arr.push(_s.value); if (i && _arr.length === i) break; } } catch (err) { _d = true; _e = err; } finally { try { if (!_n && _i["return"]) _i["return"](); } finally { if (_d) throw _e; } } return _arr; } return function (arr, i) { if (Array.isArray(arr)) { return arr; } else if (Symbol.iterator in Object(arr)) { return sliceIterator(arr, i); } else { throw new TypeError("Invalid attempt to destructure non-iterable instance"); } }; }();
        var orderedGlobalLanguages = Object.entries(globalLanguages).sort(function (_ref, _ref2) {
            var _ref4 = _slicedToArray(_ref, 2);

            var a = _ref4[1];

            var _ref3 = _slicedToArray(_ref2, 2);

            var b = _ref3[1];
            return a.localeCompare(b);
        }).map(function (arr) {
            return arr[0];
        });
        for (let i = 0; i < orderedGlobalLanguages.length; i++) {
            if (availableLanguages.indexOf(orderedGlobalLanguages[i]) !== -1) {
                if (defaultLanguage === orderedGlobalLanguages[i]) {
                    mainLanguage = orderedGlobalLanguages[i];
                } else {
                    if (orderedGlobalLanguages[i] === 'en') {
                        orderedAvailableLanguages.unshift(orderedGlobalLanguages[i]);
                    }
                    else {
                        orderedAvailableLanguages.push(orderedGlobalLanguages[i]);
                    }
                }
            }
        }
        if (mainLanguage) {
            orderedAvailableLanguages.unshift(mainLanguage);
        }
        return orderedAvailableLanguages;
    }


    function showAdditionalContent(event) {
        var $additionalContentContainer = $('.additional-content-additional-content-js', this.config.container);
        //Open container
        $additionalContentContainer.removeClass("hidden");
        $additionalContentContainer.show();
        $additionalContentContainer
            .addClass('opened')
            .find('.additional-content-additional-content-js')
            .first()
            .show();
    }

    function showMultilingualDocuments(language, isReloadingData, event) {
        if (event) event.preventDefault();
        isReloadingData = isReloadingData !== undefined ? isReloadingData : false;
        var _self = this;

        var $multilingualDocumentsAdditionalContent = $(event.target).closest("li").find(".multilingual-documents-additional-content-js");

        if (!isReloadingData && !_closeContainerWhenVisible.call(this, $multilingualDocumentsAdditionalContent)) {
            return;
        }

        var documentType = $multilingualDocumentsAdditionalContent.data("document-type");
        var documentTypeTitle = $multilingualDocumentsAdditionalContent.data("document-type-title");

        var data = {
            productId: this.config.productId,
            language: language,
            documentType: documentType
        };

        //Activate loading state
        $multilingualDocumentsAdditionalContent
            .html(this.templates.spinnerTemplateHTML)
            .closest('li').addClass('opened');
        $multilingualDocumentsAdditionalContent.show();

        _getMultilingualDocuments(data)
            .then(function (response) {
                console.debug('[showMultilingualDocuments]', response);
                var availableLanguages = response.availableLanguages.map(function (lang) {
                    return lang.toLowerCase();
                });

                var multilingualDocumentsTemplateHTML = document.getElementById('multilingual-documents-template').innerHTML
                    .replace(/{{id}}/gm, _self.id);

                var $multilingualDocumentsTemplateHTML = $(multilingualDocumentsTemplateHTML);
                if (!(availableLanguages && availableLanguages.length) || !(response.documents && response.documents.length)) {
                    //Show no results message
                    $multilingualDocumentsTemplateHTML.find('.no-results-js').removeClass('hidden');

                } else {
                    var multilingualDocumentsItemTemplateHTML = document.getElementById('multilingual-documents-item-template').innerHTML
                        .replace('{{fileUrl}}', response.documents[0].url)
                        .replace('{{language}}', language)
                        .replace('{{localeName}}', globalConfig.languages[language] || globalConfig.languages['en'])
                        .replace('{{documentType}}', documentType)
                        .replace('{{documentTypeTitle}}', documentTypeTitle)
                    ;

                    $('.content-body-js', $multilingualDocumentsTemplateHTML).append($(multilingualDocumentsItemTemplateHTML));
                    $multilingualDocumentsAdditionalContent.html($multilingualDocumentsTemplateHTML.html());

                    var $otherLanguages = $('.other-languages-js', $multilingualDocumentsAdditionalContent).show();
                    $otherLanguages
                        .on('click', _fillLanguages.bind(_self, $multilingualDocumentsAdditionalContent, availableLanguages, 'multilingualDocuments'));
                }

                $multilingualDocumentsAdditionalContent.find(".heading span").html(documentTypeTitle);

                //Open container
                $multilingualDocumentsAdditionalContent
                    .addClass('opened')
                    .find('.multilingual-documents-template-content-js')
                    .first()
                    .show();
            }).catch(function (err) {
            console.error('showMultilingualDocuments', err);
            $multilingualDocumentsAdditionalContent.hide();
        });

    }

    function showTechnicalDocumentation(language, isReloadingData, event) {
        if (event) event.preventDefault();
        isReloadingData = isReloadingData !== undefined ? isReloadingData : false;
        var _self = this;
        var type = $(event.target).data("type");

        var $technicalDocumentationAdditionalContent = $('.technical-documentation-additional-content-js', _self.config.container)

        if (type !== undefined && type !== '') {
            $technicalDocumentationAdditionalContent = $('.technical-documentation-additional-content-js[type=' + type + ']', _self.config.container);
        }

        if (!isReloadingData && !_closeContainerWhenVisible.call(this, $technicalDocumentationAdditionalContent)) {
            return;
        }

        var data = {
            productId: this.config.productId,
            language: language
        };

        //Activate loading state
        $technicalDocumentationAdditionalContent
            .html(this.templates.spinnerTemplateHTML)
            .closest('li').addClass('opened');
        $technicalDocumentationAdditionalContent.show();

        _getTechnicalDocumentation(data)
            .then(function (response) {
                console.debug('showTechnicalDocumentation', response, event.target);

                var technicalDocumentationTemplateHTML = document.getElementById('technical-documentation-template').innerHTML
                    .replace(/{{id}}/gm, _self.id);
                var $technicalDocumentationTemplateHTML = $(technicalDocumentationTemplateHTML);
                var technicalDocumentTemplateHTML = document.getElementById('technical-document-item-template').innerHTML;
                var comesFromSeries = $(event.target).hasClass("series-pitw");
                //Operation Manuals
                if ((type === undefined || type === '' || type === "operation-manuals") && (!comesFromSeries || $(event.target).hasClass("opmm-doc"))) {
                    if (!(response.opms && response.opms.length)) {
                        $technicalDocumentationTemplateHTML.find('.operation-manuals-js li.no-results-js').removeClass('hidden');
                    }
                    response.opms && response.opms.forEach(function (document) {
                        var $technicalDocumentItem = $(technicalDocumentTemplateHTML
                            .replace('{{language}}', document.language)
                            .replace('{{fileName}}', document.name || document.url)
                            .replace('{{fileUrl}}', document.url)
                            .replace('{{statisticsSource}}', _self.config.statisticsSource)
                            .replace('{{statisticsProductType}}', 'OPERATION MANUAL'));
                        $('.operation-manuals-js .list-items-js', $technicalDocumentationTemplateHTML).append($technicalDocumentItem);
                    });
                } else {
                    $technicalDocumentationTemplateHTML.find('.operation-manuals-js').addClass('hidden');
                }

                //Instructions Maintenance
                if ((type === undefined || type === '' || type === "installation-manuals") && (!comesFromSeries || $(event.target).hasClass("imms-doc"))) {
                    if (!(response.imms && response.imms.length)) {
                        $technicalDocumentationTemplateHTML.find('.instructions-maintenance-js li.no-results-js').removeClass('hidden');
                    }
                    response.imms && response.imms.forEach(function (document) {
                        var $technicalDocumentItem = $(technicalDocumentTemplateHTML
                            .replace('{{language}}', document.language)
                            .replace('{{fileName}}', document.name || document.url)
                            .replace('{{fileUrl}}', document.url)
                            .replace('{{statisticsSource}}', _self.config.statisticsSource)
                            .replace('{{statisticsProductType}}', 'INSTRUCTIONS MAINTENANCE'));
                        $('.instructions-maintenance-js .list-items-js', $technicalDocumentationTemplateHTML).append($technicalDocumentItem);
                    });
                } else {
                    $technicalDocumentationTemplateHTML.find('.instructions-maintenance-js').addClass('hidden');
                }

                //CE-Certificates
                if ((type === undefined || type === '' || type === "ce-certificates") && (!comesFromSeries || $(event.target).hasClass("cecertificates-doc"))) {
                    var ceCertificates = [].concat(response.docs).concat(response.docsOld).filter(function (doc) {
                        return !!doc;
                    });
                    if (!(ceCertificates && ceCertificates.length)) {
                        $technicalDocumentationTemplateHTML.find('.ce-certificates-js li.no-results-js').removeClass('hidden');
                    }
                    ceCertificates && ceCertificates.forEach(function (document) {
                        var $technicalDocumentItem = $(technicalDocumentTemplateHTML
                            .replace('{{language}}', document.language)
                            .replace('{{fileName}}', document.name || document.url)
                            .replace('{{fileUrl}}', document.url)
                            .replace('{{statisticsSource}}', _self.config.statisticsSource)
                            .replace('{{statisticsProductType}}', 'CE CERTIFICATE'));
                        $('.ce-certificates-js .list-items-js', $technicalDocumentationTemplateHTML).append($technicalDocumentItem);
                    });
                } else {
                    $technicalDocumentationTemplateHTML.find('.ce-certificates-js').addClass('hidden');
                }

                //Write all HTML content
                $technicalDocumentationAdditionalContent.html($technicalDocumentationTemplateHTML.html());

                //Add Event listeners
                var $otherLanguages = $('.other-languages-js', $technicalDocumentationAdditionalContent).show();
                $otherLanguages
                    .on('click', _fillLanguages.bind(_self, $technicalDocumentationAdditionalContent, response.availableLanguages, 'technicalDocumentation', type));

                //Open container
                $technicalDocumentationAdditionalContent.closest('li').addClass('opened');
                $technicalDocumentationAdditionalContent
                    .addClass('opened')
                    .find('.technical-documentation-template-content-js')
                    .first()
                    .show();
            }).catch(function (err) {
            console.error('showTechnicalDocumentation', err);
            $technicalDocumentationAdditionalContent.hide();
        });
    }

    function load3dPreview(event) {
        if (event) event.preventDefault();
        var _self = this;
    }

    function show3dPreview(event) {
        if (event) event.preventDefault();
        var _self = this;
        if (!this.preview3DLoading && (!$(".preview-3d-modal").is(":visible") || $(".preview-3d-modal") === undefined || $(".preview-3d-modal").length === 0)) {
            this.preview3DLoading = true;
            if (!this.config.isCadenasEnabled) {
                this.preview3DLoading = false;
                smc.NotifyComponent && smc.NotifyComponent.error(this.config.messages.functionalityNotAvailable);
                return;
            }
            if (!$("#free_configuration").is("visible") || (this.getPartNumber() && this.isValidConfiguration())) {
                var url = this.generateURLFor(globalConfig.productToolbar.urls.show3dPreview);
                this.initLoading(_self.links.show3dPreview);
                $.get(url.url, url.data)
                    .then(function (response) {
                        _self.endLoading(_self.links.show3dPreview);
                        $('.preview-3d-modal').remove();
                        $(response).modal('show');
                        _self.preview3DLoading = false;
                    })
                    .catch(function () {
                        _self.endLoading(_self.links.show3dPreview);
                        _self.preview3DLoading = false;
                    });
            } else {
                this.preview3DLoading = false;
            }
        }
    }


    function replaceUrlParameter(paramKey, paramValue) {
        var current = window.location.href;
        if (current.indexOf(paramKey + "=") > 0) {//replace
            current = current.replace("/(paramKey=).*?(&)/", '$1' + paramValue + '$2');
        } else {//add
            if (current.indexOf("?") > 0) {
                current += "&";
            } else {
                current += "?";
            }
            current += paramKey + "=" + paramValue;
        }
        window.history.pushState({}, window.document.title, current.toString());
    }

    function showCadDownload(event) {
        if (event && event.preventDefault) event.preventDefault();
        var _self = this;
        if (!this.config.isCadenasEnabled) {
            smc.NotifyComponent && smc.NotifyComponent.error(this.config.messages.functionalityNotAvailable);
            return;
        }

        var url = this.generateURLFor(globalConfig.productToolbar.urls.showCadDownload);
        //Check for authenticated user
        if (!globalConfig.isAuthenticated && this.config.productConfiguratorComponent && inIframe()) {
            url = this.generateURLFor(window.parent.smc.productToolbar.urls.showCadDownload);
            var productConfiguratorComponentId = 'productConfigurator_{{productId}}'
                .replace('{{productId}}', window.parent.smc.productConfiguratorComponent.config.productId);
            var currentPartNumber = "";
            if (window.location.href.indexOf("currentPartNumber") > 0) {
                currentPartNumber = getUrlParameter("currentPartNumber");
                url.url.searchParams.set("currentPartNumber", currentPartNumber);
                // replaceUrlParameter("currentPartNumber", currentPartNumber);
            }
            if (window.location.href.indexOf("rodEndConf") > 0) {
                var curRodEnd = getUrlParameter("rodEndConf");
                url.url.searchParams.set("rodEndConf", encodeURI(curRodEnd));
                // replaceUrlParameter("rodEndConf", curRodEnd);
            }
            url.url.searchParams.set("modalProductId", this.config.productId);
            replaceUrlParameter("modalProductId", this.config.productId);
            var showCadDownloadUrlStandaloneUrl = generateSecuredAction(productConfiguratorComponentId, 'showProductConfiguratorCadDownload', url.url, [this.config.productId, this.getPartNumber()]);
            showCadDownloadUrlStandaloneUrl.searchParams.set('modalProductId', this.config.productId);
            // console.log("STANDALONE URL : ",showCadDownloadUrlStandaloneUrl.toString());
            window.parent.location = showCadDownloadUrlStandaloneUrl;
            window.history.pushState({}, window.document.title, showCadDownloadUrlStandaloneUrl.toString());
            return;

        } else if (!globalConfig.isAuthenticated) {
            url.url.searchParams.set("openMainCad", "true");
            if (window.location.href.indexOf("nodes") > 0) {
                const curNodes = getUrlParameter("nodes");
                url.url.searchParams.set("nodes", curNodes);
            }
            if (window.location.href.indexOf("searchData") > 0) {
                const curSearchData = getUrlParameter("searchData");
                url.url.searchParams.set("searchData", curSearchData);
            }
            if (window.location.href.indexOf("rodEndConf") > 0) {
                var curRodEnd = getUrlParameter("rodEndConf");
                url.url.searchParams.set("rodEndConf", encodeURI(curRodEnd));
                // replaceUrlParameter("rodEndConf", encodeURI(curRodEnd));
            }
            if ($(".series-container").length > 0) {
                var seriesProductId = getUrlParameter("productId");
                if (seriesProductId !== undefined) {
                    url.url.searchParams.set("seriesProductId", encodeURI(seriesProductId));
                    url.url.searchParams.set("productId", encodeURI(seriesProductId));
                }
                url.url.searchParams.set("partNumber", getUrlParameter("currentPartNumber"));
                var seriesPartNumber = getUrlParameter("partNumber");
                if (seriesPartNumber === undefined) {
                    seriesPartNumber = "";
                }
                url.url.searchParams.set("seriesPartNumber", encodeURI(seriesPartNumber));
                if ($("#free_configuration").is(":visible")) {
                    if (this.config.partNumber === seriesPartNumber) {
                        //then we have clicked on the PC, not spares part
                        url.url.searchParams.set("seriesCadOrigin", "pc");
                        url.url.searchParams.set("seriesSelectedGroup", "");
                        url.url.searchParams.set("seriesCadPartNumber", "");
                    } else {
                        var selectedGroupId = $("#free_configuration .group-filter[aria-selected='true']").attr("id");
                        url.url.searchParams.set("seriesSelectedGroup", selectedGroupId);
                        url.url.searchParams.set("seriesCadOrigin", "pc-spares");
                        url.url.searchParams.set("seriesCadPartNumber", this.config.partNumber);
                    }
                } else {
                    url.url.searchParams.set("seriesCadOrigin", "ssi");
                    url.url.searchParams.set("seriesSelectedGroup", "");
                    url.url.searchParams.set("seriesCadPartNumber", "");
                }
            }
            var showCadDownloadUrl = generateSecuredAction(this.id, 'showCadDownload', url.url);
            window.history.pushState({}, window.document.title, window.location.href);
            window.location = showCadDownloadUrl;
            return;
        }

        if (window.location.href.indexOf("rodEndConf") > 0) {
            var curRodEnd = getUrlParameter("rodEndConf");
            var currProductId = getUrlParameter("productId");
            if (currProductId === this.config.productId) {
                url.url.searchParams.set("rodEndConf", encodeURI(curRodEnd));
            }
        }
        if (!$(".cad-download-modal").is(":visible")) {
            _self.initLoading(_self.links.showCadDownload);
            return $.get(url.url, url.data)
                .then(function (response) {
                    _self.endLoading(_self.links.showCadDownload);
                    if ($('.cad-download-modal').length > 0) {
                        $('.cad-download-modal').remove();
                        $(".modal-backdrop").first().remove();
                    }

                    if (!$(".cad-download-modal").is(":visible")) {
                        var $modal = $(response);
                        $modal.modal('show');
                        if ($(".cad-download-modal").length > 1) {
                            $(".cad-download-modal").first().remove();
                            $(".modal-backdrop").first().remove();
                        }
                    }
                })
                .catch(function () {
                    _self.endLoading(_self.links.showCadDownload);
                }).finally(function (){
                    if ($(".cad-download-modal").length > 1) {
                        $(".cad-download-modal").first().remove();
                        $(".modal-backdrop").first().remove();
                    }
                });
        }
    }

    function getUrlParameter(sParam) {
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

    function getDatasheet(event) {
        if (event && event.preventDefault) event.preventDefault();
        var _self = this;

        if (!this.config.isCadenasEnabled) {
            smc.NotifyComponent && smc.NotifyComponent.error(this.config.messages.functionalityNotAvailable);
            return;
        }

        var url = this.generateURLFor(globalConfig.productToolbar.urls.getDatasheet);

        this.initLoading(_self.links.showDatasheet);
        this.getDatasheetOpenReference = this.getDatasheetOpenReference || window.open(smc.channelPrefix + '/loading-page', '_blank');

        this.getDatasheetRetryCount = this.getDatasheetRetryCount || 0;
        if (this.getDatasheetRetryCount > MAX_TIMEOUT_RETRIES) {
            //Stop after 3 retries
            console.error('[ProductToolbar]', 'Stop after ' + MAX_TIMEOUT_RETRIES + ' retries', 'getDatasheetRetryCount=', this.getDatasheetRetryCount);

            this.getDatasheetOpenReference.close();
            smc.NotifyComponent && smc.NotifyComponent.error(globalConfig.messages.generalError);
            _self.endLoading(_self.links.showDatasheet);
            this.getDatasheetRetryCount = 0;//Reset the counter
            return;
        }

        return $.getJSON(url.url, url.data)
            .then(function (response) {
                console.debug('[ProductToolbar]', 'getDatasheet=', response);
                _self.endLoading(_self.links.showDatasheet);

                //Remove spinner & set File Ready
                $('.loading', _self.getDatasheetOpenReference.document).hide();
                $('.loaded ', _self.getDatasheetOpenReference.document).show();
                _self.getDatasheetOpenReference.location = response.url;
            })
            .catch(function (error) {
                _self.getDatasheetRetryCount++;
                return _self.getDatasheet();
            })
            .always(function () {
                _self.getDatasheetOpenReference = null;
            });
    }

    function getSalesDocument(event) {
        if (event && event.preventDefault) event.preventDefault();
        var _self = this;

        var url = this.generateURLFor(globalConfig.productToolbar.urls.getSalesDocument);

        this.initLoading(_self.links.showSalesDocument);
        this.getSalesDocumentOpenReference = this.getSalesDocumentOpenReference || window.open(smc.channelPrefix + '/loading-page', '_blank');

        this.getSalesDocumentRetryCount = this.getSalesDocumentRetryCount || 0;
        if (this.getSalesDocumentRetryCount > MAX_TIMEOUT_RETRIES) {
            //Stop after 3 retries
            console.error('[ProductToolbar]', 'Stop after ' + MAX_TIMEOUT_RETRIES + ' retries', 'getSalesDocumentRetryCount=', this.getSalesDocumentRetryCount);

            this.getSalesDocumentOpenReference.close();
            smc.NotifyComponent && smc.NotifyComponent.error(globalConfig.messages.generalError);
            _self.endLoading(_self.links.showSalesDocument);
            this.getSalesDocumentRetryCount = 0;//Reset the counter
            return;
        }

        return $.getJSON(url.url, url.data)
            .then(function (response) {
                console.debug('[ProductToolbar]', 'getSalesDocument=', response);
                _self.endLoading(_self.links.showSalesDocument);

                //Remove spinner & set File Ready
                $('.loading', _self.getSalesDocumentOpenReference.document).hide();
                $('.loaded ', _self.getSalesDocumentOpenReference.document).show();
                _self.getSalesDocumentOpenReference.location = response.url;
            })
            .catch(function (error) {
                _self.getSalesDocumentRetryCount++;
                return _self.getSalesDocument();
            })
            .always(function () {
                _self.getSalesDocumentOpenReference = null;
            });
    }

    function showAskSMC(event) {
        if (event) event.preventDefault();
        var _self = this;

        var url = this.generateURLFor(globalConfig.productToolbar.urls.showAskSMC);
        this.initLoading(_self.links.showAskSmc);
        if (window.isIOS) {
            var baseUrl = globalConfig.productToolbar.urls.askSMCFinalPageLink;

            var askSMCUrl = new URL(baseUrl);
            askSMCUrl.searchParams.set('productId', this.config.productId);
            askSMCUrl.searchParams.set('partNumber', this.getPartNumber());

            window.location.href = askSMCUrl.toString();
            _self.endLoading(_self.links.showAskSmc);
            return;
        }

        $.get(url.url, url.data)
            .then(function (response) {
                _self.endLoading(_self.links.showAskSmc);

                var $html = $(response);
                var $iframe = $('iframe', $html);

                $(window).on('message onmessage', function (event) {
                    if (event && event.originalEvent && event.originalEvent.data === 'page-loaded') {
                        $('.spinner-container', $html).remove();
                        $iframe.removeClass('hidden');
                    }
                });

                //Remove old modal before creating a new one
                $('.ask-smc-modal').remove();
                $html.modal('show');
            })
            .catch(function () {
                _self.endLoading(_self.links.showAskSmc);
            });
    }

    function showShareYourSuccess(event) {
        if (event) event.preventDefault();
        var _self = this;

        var url = this.generateURLFor(globalConfig.productToolbar.urls.showShareYourSuccess);

        this.initLoading(_self.links.showShareYourSuccess);
        if (window.isIOS) {
            var baseUrl = globalConfig.productToolbar.urls.askSMCFinalPageLink;

            var shareYourSuccessURL = new URL(baseUrl);
            shareYourSuccessURL.searchParams.set('productId', this.config.productId);
            shareYourSuccessURL.searchParams.set('partNumber', this.getPartNumber());

            window.location.href = shareYourSuccessURL.toString();
            _self.endLoading(_self.links.showShareYourSuccess);
            return;
        }

        $.get(url.url, url.data)
            .then(function (response) {
                _self.endLoading(_self.links.showShareYourSuccess);

                var $html = $(response);
                var $iframe = $('iframe', $html);

                $(window).on('message onmessage', function (event) {
                    if (event && event.originalEvent && event.originalEvent.data === 'page-loaded') {
                        $('.spinner-container', $html).remove();
                        $iframe.removeClass('hidden');
                    }
                });

                //Remove old modal before creating a new one
                $('.ask-smc-modal').remove();
                $html.modal('show');
            })
            .catch(function () {
                _self.endLoading(_self.links.showShareYourSuccess);
            });
    }

    function showVideo(event) {
        if (event) event.preventDefault();
        var _self = this;

        var url = this.generateURLFor(globalConfig.productToolbar.urls.showVideo);

        this.initLoading(_self.links.showVideo);
        $.get(url.url, url.data)
            .then(function (response) {
                _self.endLoading(_self.links.showVideo);
                $('.pt-video-modal').remove();
                var $videoModal = $(response).modal('show');
                onVideoModalHideEvent($videoModal);
            })
            .catch(function () {
                _self.endLoading(_self.links.showVideo);
            });
    }

    function showImages(event) {
        if (event) event.preventDefault();
        var _self = this;

        var $imagesAdditionalContent = $('.show-images-additional-content-js', _self.config.container);

        $imagesAdditionalContent.show();

        var imagesTemplateHTML = document.getElementById('images-template').innerHTML
            .replace(/{{id}}/gm, _self.id);

        var $imagesTemplateHTML = $(imagesTemplateHTML);

        var featureCatalogueItemTemplateHTML = document.getElementById('images-item-template').innerHTML
            .replace('{{imageChURL}}', $imagesAdditionalContent.data("image-ch"))
            .replace('{{imageClURL}}', $imagesAdditionalContent.data("image-cl"))
            .replace('{{imageBwURL}}', $imagesAdditionalContent.data("image-bw"));

        $('.content-body-js', $imagesTemplateHTML).append($(featureCatalogueItemTemplateHTML));
        $imagesAdditionalContent.html($imagesTemplateHTML.html());


        //Open container
        $imagesAdditionalContent
            .addClass('opened')
            .find('.images-template-content-js')
            .first()
            .show();

    }


    function showPressRelease(event) {
        if (event) event.preventDefault();
        var _self = this;

        var url = this.generateURLFor(globalConfig.productToolbar.urls.showPressRelease);

        this.initLoading(_self.links.showPressRelease);
        $.get(url.url, url.data)
            .then(function (response) {
                _self.endLoading(_self.links.showPressRelease);
                $('.pt-press-release-modal').remove();
                var $pressReleaseModal = $(response).modal('show');
            })
            .catch(function () {
                _self.endLoading(_self.links.showPressRelease);
            });
    }

    function parseAccesories() {
        var accessories = [];
        $("#aareo_configuration-summary_accesory_summary-list .aareo_accesory_summary_element").each(function () {
            var partNumber = $(this).attr("partnumber-value");
            var currentZone = $(this).attr("zone-value");
            var currentDescription = $(this).find(".aareo_accesory_summary_row_description").text();
            var accessory = {partNumber: partNumber, currentZone: currentZone, currentDescription: currentDescription};
            accessories.push(accessory);
        });
        $("#aareo_configuration-summary_accesory_no_position_summary-list .aareo_accesory_no_position_row").each(function () {
            var partNumber = $(this).attr("partnumber-value");
            var currentZone = $(this).attr("zone-value");
            var currentDescription = $(this).find(".aareo_accesory_summary_row_description").text();
            var currentQuantity = $(this).find(".aareo_accesory_summary_row_quantity").text();
            for (i = 0; i < parseInt(currentQuantity); i++) {
                var accessory = {
                    partNumber: partNumber,
                    currentZone: currentZone,
                    currentDescription: currentDescription
                };
                accessories.push(accessory);
            }
        });
        return accessories;
    }

    function make3DPreviewCall() {
        var _self = this;
        this.$3dPreviewIframe = this.$3dPreviewIframe || $('.preview-3d-iframe', this.config.container);
        var url = this.generateURLFor(globalConfig.productToolbar.urls.get3dPreview);
        //Init loading
        this.$3dPreviewIframe.html(this.templates.spinnerTemplateHTML);
        $.getJSON(url.url, url.data)
            .then(function (response) {
                var preview3DURL = response.preview3dURL && response.preview3dURL.url;
                if (preview3DURL) {
                    // if (currentIFrames > 1){
                    $(".preview-3d-iframe").each(function () {
                        $(this).html('<iframe src="{{preview3DURL}}" width="100%" height="100%" frameBorder="0">{{browserNotCompatible}}</iframe>'
                            .replace('{{preview3DURL}}', preview3DURL)
                            .replace('{{browserNotCompatible}}', _self.config.messages.iframeBrowserNotCompatible));
                    });
                    /*}else {
                        _self.$3dPreviewIframe.html('<iframe src="{{preview3DURL}}" width="100%" height="100%" frameBorder="0">{{browserNotCompatible}}</iframe>'
                            .replace('{{preview3DURL}}', preview3DURL)
                            .replace('{{browserNotCompatible}}', _self.config.messages.iframeBrowserNotCompatible));
                    }*/
                    $(".aument-preview-link").removeClass("hidden");
                } else {
                    if (_self.isValidConfiguration()) {
                        _self.$3dPreviewIframe.html('<p class="no-preview-3D-message">{{noPreview3DAvailable}}</p>'
                            .replace('{{noPreview3DAvailable}}', _self.config.messages.noPreview3DFound));
                    } else {
                        _self.$3dPreviewIframe.html('<p class="no-preview-3D-message">{{noPreview3DAvailable}}</p>'
                            .replace('{{noPreview3DAvailable}}', _self.config.messages.noPreview3DAvailable));
                    }
                    $(".aument-preview-link").addClass("hidden");
                }
            })
            .catch(function () {
                if (_self.isValidConfiguration()) {
                    _self.$3dPreviewIframe.html('<p class="no-preview-3D-message">{{noPreview3DAvailable}}</p>'
                        .replace('{{noPreview3DAvailable}}', _self.config.messages.noPreview3DFound));
                } else {
                    _self.$3dPreviewIframe.html('<p class="no-preview-3D-message">{{noPreview3DAvailable}}</p>'
                        .replace('{{noPreview3DAvailable}}', _self.config.messages.noPreview3DAvailable));
                }
                $(".aument-preview-link").addClass("hidden");
            });
    }

    function reload3DPreview() {
        var _self = this;
        this.$3dPreviewIframe = this.$3dPreviewIframe || $("#" + _self.id + ' .preview-3d-iframe', this.config.container);

        if (this.config.renderingMode === "3d-preview") {
            if (_self.isValidConfiguration()) {
                $("#" + _self.id + " .preview-3d-iframe").each(function () {
                    $(this).html('<a href="javascript:void(0);" class="no-preview-3D-message click-to-load-3d">{{noPreview3DAvailable}}</a>'
                        .replace('{{noPreview3DAvailable}}', _self.config.messages.clickToView3DPreview));
                });
                $("#" + _self.id + " .click-to-load-3d").click(function () {
                    _self.make3DPreviewCall();
                })
            }
            return;
        }

    }

    function onVideoModalHideEvent($videoModal) {
        $videoModal.on("hidden.bs.modal", function () {
            var video = $('video', $videoModal)[0];
            video.pause();
        });
    }

    function updateProductConfiguratorComponent(event, productConfiguratorComponent) {
        this.config.productConfiguratorComponent = productConfiguratorComponent;
    }

    function onPartNumberChanged(event, partNumber) {
        if (!this.config.isManualPartNumber) {
            this.config.partNumber = partNumber;

            this.updateStatus();
        }
    }

    function _fillLanguages($container, availableLanguages, fromSource, contentType, catalogueId) {
        var _self = this;
        var globalLanguages = globalConfig && globalConfig.languages;

        if (availableLanguages && availableLanguages.length) {
            var languageTemplateHTML = _self.languageTemplates[fromSource];
            var languageListHTML = document.createDocumentFragment();
            availableLanguages.forEach(function (localeKey) {
                localeKey = localeKey.toLowerCase();
                if (globalLanguages[localeKey]) {
                    var languageItemHTML = languageTemplateHTML
                        .replace('{{locale}}', localeKey)
                        .replace('{{catalogueId}}', catalogueId)
                        .replace('{{localeName}}', globalLanguages[localeKey])
                        .replace('{{contentType}}', contentType !== undefined ? contentType : '');
                    languageListHTML.appendChild($(languageItemHTML)[0]);
                }
            });

            //Hide "other languages" button
            $('.other-languages-js', $container).hide();

            var $contentBody = $('.content-body-js', $container);
            $contentBody.html(languageListHTML.childNodes);

            //Add Event Listeners to Language links
            var isReloadingData = true;
            $('.technical-documentation-change-language-js', $contentBody).each(function (i, elem) {
                $(elem).on('click', showTechnicalDocumentation.bind(_self, elem.getAttribute('data-language'), isReloadingData));
            });
            $('.feature-catalogues-change-language-js', $contentBody).each(function (i, elem) {
                $(elem).on('click', showFeatureCatalogues.bind(_self, elem.getAttribute('data-language'), isReloadingData, true));
            });
            $('.multilingual-documents-change-language-js', $contentBody).each(function (i, elem) {
                $(elem).on('click', showMultilingualDocuments.bind(_self, elem.getAttribute('data-language'), isReloadingData));
            });
            $('.series-catalogues-change-language-js', $contentBody).each(function (i, elem) {
                $(elem).on('click', showSeriesCatalogues.bind(_self, elem.getAttribute('data-language'), isReloadingData, true, elem.getAttribute('data-catalogueid')));
            });
        }
    }

    function _getFeatureCatalogues(data) {
        return $.getJSON(globalConfig.productToolbar.urls.showFeatureCatalogues, data);
    }

    function _getSeriesCatalogues(data) {
        return $.getJSON(globalConfig.productToolbar.urls.showSeriesCatalogues, data);
    }

    function isDatasheetAvailableInCache() {
        var url = this.generateURLFor(globalConfig.productToolbar.urls.isDatasheetAvailableInCache);
        return $.getJSON(url.url, url.data);
    }

    function isCADAvailableInCache() {
        var url = this.generateURLFor(globalConfig.productToolbar.urls.isCADAvailableInCache);
        return $.getJSON(url.url, url.data);
    }

    function _getMultilingualDocuments(data) {
        return $.getJSON(globalConfig.productToolbar.urls.showMultilingualDocuments, data);
    }

    function _getTechnicalDocumentation(data) {
        return $.getJSON(globalConfig.productToolbar.urls.showTechnicalDocumentation, data);
    }

    /**
     * Manual function to wait for components dependencies. i.e.: productConfiguratorComponent
     * @private
     */
    function _loadDependencies() {
        var def = $.Deferred();

        if (!this.config.inConfigurationPage) {
            def.resolve();
            return def.promise();
        }

        var intervalId = window.setInterval(function () {
            if (this.config.productConfiguratorComponent) {
                def.resolve();
                window.clearInterval(intervalId);
            }
        }.bind(this), 50);

        return def.promise();
    }

    function _closeContainerWhenVisible($container) {

        if ($container.is(':visible')) {
            $container.closest('li').removeClass('opened');
            $container.hide();
            return false;
        }

        return true;
    }

    function generateSecuredAction(componentId, actionName, currentUrl, actionParams) {
        var url = new URL(currentUrl);

        // [SMCD-471] Clear HippoCMS params to avoid Browser error
        var keysIterator = url.searchParams.keys();
        var key = keysIterator.next();
        while (key && key.value) {
            if (key.value.indexOf('_hn') === 0 || key.value.indexOf('ajax') === 0) url.searchParams.delete(key.value);
            key = keysIterator.next();
        }

        url.searchParams.set('componentId', componentId.toString());
        url.searchParams.set('action', actionName);
        if (actionParams) {
            url.searchParams.set('actionParams', Array.isArray(actionParams) ? actionParams.join(',') : actionParams || '');
        }
        return secureResourceUrl(url);
    }

    function secureResourceUrl(url) {
        var securedResourceUrl = new URL(url.origin + '/secured-resource');
        securedResourceUrl.searchParams.set('resource', url.toString().replace(url.origin, ''));
        return securedResourceUrl;
    }

    function generateURLFor(baseUrl) {
        var url = new URL(baseUrl);

        //Reset params
        url.searchParams.delete('componentId');
        url.searchParams.delete('productId');
        url.searchParams.delete('partNumber');
        url.searchParams.delete('language');
        url.searchParams.delete('specList');
        url.searchParams.delete('rodEndConf');
        url.searchParams.delete('simpleSpecialCode');
        var productId = this.config.productId;
        var data = {};

        if (this.config.statisticsSource == 'SPARE PARTS AND ACCESSORIES') {
            // For spare parts and accessories, only partnumber and productId is needed
            data = {
                componentId: this.id,
                partNumber: this.getPartNumber(),
                productId: productId,
                language: this.config.defaultLanguage || 'en',
                inValveConfiguratorPage: false,
                isValidConfiguration: true,
                statisticsSource: this.config.statisticsSource
            };
        } else {
            data = {
                componentId: this.id,
                partNumber: this.getPartNumber(),
                productId: productId,
                language: this.config.defaultLanguage || 'en',
                inValveConfiguratorPage: this.config.inValveConfiguratorPage,
                isValidConfiguration: this.config.inValveConfiguratorPage ? true : this.isValidConfiguration(),
                statisticsSource: this.config.statisticsSource,
                accesories: (this.config.inConfigurationPage && $("#aareo_switch_container") != undefined && $("#aareo_switch_container").is(":visible")) ? JSON.stringify(parseAccesories()) : "",
                simpleSpecialCode: (this.config.inConfigurationPage && $("#aareo_switch_container") != undefined && $("#aareo_switch_container").is(":visible")) ? $("#series_hto_simple_special").text() : ""
            };

            var isCadDownload = baseUrl.indexOf("showCadDownload") > -1;

            try {
                if (isCadDownload && window.buildSpecList) {
                    data.specList = window.buildSpecList();
                }
            } catch (error) {
                console.log("[generateURLFor] error in window.buildSpecList", error);
            }

            if (this.config.productConfiguratorComponent) {
                data.rodEndConf = this.config.productConfiguratorComponent.getRodEndModificationConfigurationValuesInString();
            } else if (this.config.rodEndConf) {
                data.rodEndConf = this.config.rodEndConf;
            }
        }

        return {url: url, data: data};
    }

    function updateServiceAvailability() {
        var def = $.Deferred();

        return $.when(globalConfig.ComponentManager.getETechOnlineStatus(), globalConfig.ComponentManager.getCadenasOnlineStatus())
            .then(function (etechResponse, cadenasResponse) {
                this.config.isEtechEnabled = !!(etechResponse || etechResponse[0]);
                this.config.isCadenasEnabled = !!(cadenasResponse || cadenasResponse[0]);
                def.resolve();

                return def.promise();
            }.bind(this));
    }

    /**
     * Wrapper to allow a function to be executed after another
     * @param func
     * @returns {Function}
     * @private
     */
    function _checkServiceAvailability(func) {
        return function () {
            return this.updateServiceAvailability()
                .then(func.bind(this));
        };
    }

    function inIframe() {
        try {
            return window.self !== window.top;
        } catch (e) {
            return true;
        }
    }

    function preview3dEnable() {
        this.links.show3dPreview.removeAttr('disabled');
        this.links.aument3dPreview.removeAttr('disabled');
    }

    function preview3dDisable() {
        this.links.show3dPreview.attr('disabled', 'disabled');
        this.links.aument3dPreview.attr('disabled', 'disabled');
    }

    function cadDownloadEnable() {
        this.links.showCadDownload.removeAttr('disabled');
    }

    function cadDownloadDisable() {
        this.links.showCadDownload.attr('disabled', 'disabled');
    }

    function datasheetDownloadEnable() {
        this.links.showDatasheet.removeAttr('hidden');
    }

    function datasheetDownloadDisable() {
        this.links.showDatasheet.attr('hidden');
    }

    function salesDocumentDownloadEnable() {
        this.links.showSalesDocument.removeAttr('disabled');
    }

    function salesDocumentDownloadDisable() {
        this.links.showSalesDocument.attr('disabled', 'disabled');
    }

    window.smc.ProductToolbar = ProductToolbar;
})(window.smc);