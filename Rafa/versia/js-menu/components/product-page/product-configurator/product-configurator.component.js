var modalShowed = false;
var configuratorOptionsEnabled = true;

(function (window) {
    var globalConfig = window.smc;

    //IE polyfill entries
    if (!Object.entries) {
        Object.entries = function (obj) {
            var ownProps = Object.keys(obj),
                i = ownProps.length,
                resArray = new Array(i); // preallocate the Array
            while (i--)
                resArray[i] = [ownProps[i], obj[ownProps[i]]];

            return resArray;
        };
    }

    function ProductConfigurator(config) {
        this.id = config.id;
        this.config = config;
    }

    var isSeries = !!$("#isSeriesPage").val();
    ProductConfigurator.prototype.init = init;
    ProductConfigurator.prototype.initialWorkflow = initialWorkflow;
    ProductConfigurator.prototype.initializeEvents = initializeEvents;
    ProductConfigurator.prototype.initializeEtech = initializeEtech;
    ProductConfigurator.prototype.updateProjectSummary = $.debounce(50, updateProjectSummary);
    ProductConfigurator.prototype.getPartNumber = getPartNumber;
    ProductConfigurator.prototype.getConfigurationStatus = getConfigurationStatus;
    ProductConfigurator.prototype.isValidConfiguration = isValidConfiguration;
    ProductConfigurator.prototype.getProductConfiguration = getProductConfiguration;
    ProductConfigurator.prototype.getRodEndModificationConfigurationList = getRodEndModificationConfigurationList;
    ProductConfigurator.prototype.getRodEndModificationConfiguration = getRodEndModificationConfiguration;
    ProductConfigurator.prototype.getRodEndModificationConfigurationValues = getRodEndModificationConfigurationValues;
    ProductConfigurator.prototype.getRodEndModificationConfigurationValuesInString = getRodEndModificationConfigurationValuesInString;
    ProductConfigurator.prototype.hasDefaultRodEndModificationConfiguration = hasDefaultRodEndModificationConfiguration;
    ProductConfigurator.prototype.updateURLParams = $.debounce(50, updateURLParams);
    ProductConfigurator.prototype.updatePartNumberContainerStatus = $.debounce(25, updatePartNumberContainerStatus);
    ProductConfigurator.prototype.focusProjectInformation = focusProjectInformation;
    ProductConfigurator.prototype.showProductConfiguratorCadDownload = showProductConfiguratorCadDownload;
    ProductConfigurator.prototype.initializeTechSpecsTab = initializeTechSpecsTab;
    ProductConfigurator.prototype.updateSparesRelated = updateSparesRelated;
    ProductConfigurator.prototype.spareAndRelatedProducts = spareAndRelatedProducts;
    ProductConfigurator.prototype.initLoading = initLoading;
    ProductConfigurator.prototype.endLoading = endLoading;
    ProductConfigurator.prototype.techSpecsPC = techSpecsPC;
    ProductConfigurator.prototype.enableCylinderPartNumberExtrasIfNeeded = enableCylinderPartNumberExtrasIfNeeded;
    ProductConfigurator.prototype.cylinderSwitchToggle = cylinderSwitchToggle;
    ProductConfigurator.prototype.checkPartNumberHoverLength = checkPartNumberHoverLength;
    ProductConfigurator.prototype.getStandardValues = getStandardValues;
    ProductConfigurator.prototype.checkStandardMessage = checkStandardMessage;
    ProductConfigurator.prototype.hasStandardValues = hasStandardValues;

    // ProductConfigurator.prototype.checkAdvancedOptions=checkAdvancedOptions;

    function init() {
        ShowPartNumber = smcShowPartNumber;

        console.debug('[ProductConfigurator]', 'init id=', this.id);
        if (!this.config.etech) {
            throw new Error('"Etech libraries" are required');
        }
        if (externalUrl) {
            console.log("[ProductConfigurator] opening externalUrl: " + externalUrl);
            openInNewTab(externalUrl);
            // Reset filters
            $(".btn-reset-filters").click();
        }

        this.$configuratorContainer = $('.configurator-container');
        this.$configurationArea = $('#configuration_area', this.$configuratorContainer);
        this.$copyToClipBoardBtn = $('#copyToClipBoard_btn');
        this.$partNumberState = $('#cpn_state');
        this.$configurationAreaSelects = $('select', this.$configurationArea);
        this.$configurationAreaInputs = $('input', this.$configurationArea);
        this.$relatedProductsContainer = $('.related-products-container');
        this.$rodEndOptionsSwitchToggle = $('#rodEndOptionsSwitchToggle');
        this.$rodEndCylinderSwitchToggle = $('#accesoriesAndRodEndOptionsSwitchToggle');
        this.$rodEndCylinderSwitchToggle.addClass("disabled");
        this.$rodEndCylinderSwitchToggle.prop('disabled', true);
        this.templates = {
            rodEndOptionsSubtitle: document.getElementById('rodEndOptionsSubtitle'),
            rodEndOptionsSwitch: document.getElementById('rodEndOptionsSwitch'),
            spinnerTemplateHTML: document.getElementById('spinner-template').innerHTML
        };
        this.$standardValuesMap = new Map();
        this.initialWorkflow();
        this.initializeEvents();
        $(document).trigger('smc.productConfiguratorComponent.created', [this]);
        $(document).trigger('smc.registercomponent', [this.id, this]);
        this.initializeTechSpecsTab();
        var partNumber = this.getPartNumber();
        $("#product-info-container__partnumber_title").text(partNumber);
        this.enableCylinderPartNumberExtrasIfNeeded();
        if (isSeries) {
            var cadOrigin = getUrlParameter("seriesCadOrigin");
            var opened = getUrlParameter("opened");
            if (cadOrigin !== undefined && $(".cad-download-modal").length == 0) { //then we came from login
                if (cadOrigin === "pc") {
                    console.log("SHOW CAD MODAL");
                    if (opened === undefined || "" === opened) {
                        var url = new URL(window.location.href);
                        url.searchParams.set('opened', "true");
                        window.history.pushState({}, window.document.title, url.toString());
                    } else {
                        $("#producttoolbar_" + this.config.productId + "_free_configurator .show-cad-download").first().click();
                    }
                }
            }

            if ($("#rodEndOptionsSwitchToggle").is(":checked")) {
                $(".project-alert-container").removeClass("hidden");
                $("#project-section").removeClass("hidden");
                $("#project-section-buttons").removeClass("hidden");
            }
            if ($("#accesoriesAndRodEndOptionsSwitchToggle") !== undefined && $("#accesoriesAndRodEndOptionsSwitchToggle").size() > 0) {
                $("#rodEndOptionsSubtitle").addClass("hidden");
                $(".rodEndOptionsSwitch_container").addClass("hidden");
                // $("#divFormFakeButton").addClass("hidden");
            }
            if ($("#product-info-container__switch") !== undefined) {
                $("#product-info-container__switch").click();
            }
        }
        // $('table.config').css('min-width', $('#cpn_partnumber > table tr').width("auto"));
        window.addEventListener('resize', function () {
            if (window.innerWidth > 767 && window.innerWidth < 1200 && $('#cpn_partnumber > table tr td').length < 5) {
                $('table.config').css('min-width', $('#cpn_partnumber > table tr').width());
            } else {
                $('table.config').css('min-width', '');
            }
        });
        this.cylinderSwitchToggle();
        var $codeWrapper = $('#idbl_hto__partnumber__code_wrapper');
        if ($codeWrapper !== undefined) {
            var codeShowTimeout = false;
            $codeWrapper.on('click touchend', function () {
                if ($codeWrapper.hasClass('code_show')) {
                    $codeWrapper.removeClass('code_show');
                    if (codeShowTimeout !== false) {
                        clearTimeout(codeShowTimeout);
                        codeShowTimeout = false;
                    }
                } else {
                    $codeWrapper.addClass('code_show');
                    if (window.matchMedia("(max-width: 767px)").matches) {
                        codeShowTimeout = setTimeout(function () {
                            $codeWrapper.removeClass('code_show');
                        }, 10000);
                    }
                }
            });
        }

        $(".smc-select--radios__option__label").each(function () {
            try {
                $(this).parent().next().first().css("align-items", "center");
            } catch (error) {
                console.log("[ProductConfigurator] init. Error centering radio checks", this);
            }
        });
        var _self = this;
        $('#idbl_hto__partnumber__code_wrapper').on('mouseenter touchenter', function () {
            _self.checkPartNumberHoverLength();
        });

        hideRodEndConfIfNotEnabled();
    }

    function hideRodEndConfIfNotEnabled() {
        setTimeout(function () {
            if ($("#showRodEndConfiguration").val() === "false") {
                $(".builder").hide();
                $(".project-section-block").hide();
                hideRodEndConfIfNotEnabled();
            }
        }, 200);
    }

    function openInNewTab(href) {
        Object.assign(document.createElement('a'), {
            target: '_blank',
            href: href,
        }).click();
    }

    function initialWorkflow() {
        /* FLOATING PART NUMBER */
        var ProductInfoContainer = function () {
            var that = this;
            this.$container = $('.dc_partnumberContainer');
            this.$switch = $('#product-info-container__switch');

            this.checkSwitch = function () {
                if (that.$switch.attr('data-collapsed') === 'true') {
                    that.open();
                    that.$switch.attr('data-collapsed', 'false');
                } else {
                    that.close();
                    that.$switch.attr('data-collapsed', 'true');
                }
            };
            this.close = function () {
                that.$container.css('height', '0').css('opacity', '0');
            };
            this.open = function () {
                that.$container.css('height', 'auto').css('opacity', '1');
            };
        };

        var $productInfoContainer = $('.product-info-container');
        if (!$($productInfoContainer).hasClass("series-container")) {
            $productInfoContainer.prepend('<div id="product-info-container__toggle"><span id="product-info-container__switch" data-collapsed="false"></span></div>');
        }
        var productInfoContainer = new ProductInfoContainer();
        productInfoContainer.open();
        if ($("#product-info-container__switch").attr("data-collapsed") === "false") {
            if (window.screen.availWidth >= 992) {
                $(".back-to-top").css("margin-bottom", "9.7rem");
            } else {
                $(".back-to-top").css("margin-bottom", "12.5rem");
            }
        } else {
            $(".back-to-top").css("margin-bottom", "3.5rem");
        }
        $productInfoContainer.on('click', '#product-info-container__switch', function (e) {
            e.preventDefault();
            if (!$($productInfoContainer).hasClass("series-container")) {
                productInfoContainer.checkSwitch();
            }
            if ($("#product-info-container__switch").attr("data-collapsed") === "false" || $("#product-info-container__switch").attr("aria-expanded") === "false") {
                if (window.screen.availWidth >= 992) {
                    $(".back-to-top").css("margin-bottom", "10rem");
                } else {
                    setTimeout(function () {
                        $(".back-to-top").css("margin-bottom", "" + $("#series-configurator-taco").height() + "px");
                    }, 500);
                }
            } else {
                $(".back-to-top").css("margin-bottom", "3.5rem");
            }
        });

        if ($("#rodEndOptionsSwitchToggle").is(":checked") && !$(".builder").is(":visible")) {
            $(".builder").attr("style", "");
            $(".project-alert-container").removeClass("hidden");
            $("#project-section").removeClass("hidden");
            $("#project-section-buttons").removeClass("hidden");
        }
        /* END FLOATING PART NUMBER */
    }

    function initializeTechSpecsTab() {
        var _self = this;
        if (this.$ssiProductDetailNav !== undefined) {
            if (this.config.isEtechEnabled) {
                this.$ssiProductDetailNav.removeAttr('disabled');
                this.$ssiProductDetailNav.removeClass('disabled');
            }
            this.$ssiProductDetailNav.click(techSpecs.bind(_self, _self.config.partnumber));
        }
    }

    function initializeEvents() {
        var _self = this;
        var $document = $(document);
        var sparesAccessoriesModuleAvailable = this.config.sparesAccessoriesModule
            && this.config.sparesAccessoriesModule.getItems()
            && this.config.sparesAccessoriesModule.getItems().length > 0;
        this.rodEndModificationConfiguration = this.rodEndModificationConfiguration || {};

        var $relatedProductsContainer = $('.related-products-container');
        if (!this.config.isStandalonePage && $.fn.slick && $.fn.waypoint && !this.sliderLoaded && $relatedProductsContainer.length) {
            try {
                new Waypoint({
                    element: $relatedProductsContainer,
                    handler: function () {
                        try {
                            console.debug('[ProductConfigurator]', 'initializing_RelatedProducts_Slider:Waypoint');
                            $('.related-products-slider').slick(getSliderConfiguration(_self.config.relatedProductsCount));
                            _self.sliderLoaded = true;

                            this.destroy();
                        } catch (error) {
                            console.error('[ProductConfigurator]', error);
                        }
                    },
                    offset: '150%'
                });
            } catch (e) {
                console.warn('[ProductConfigurator]', 'initializeEvents', 'Loading:$relatedProductsContainer', e);

                console.debug('[ProductConfigurator]', 'initializing_RelatedProducts_Slider:Manually');
                $('.related-products-slider').slick(getSliderConfiguration(_self.config.relatedProductsCount));
                _self.sliderLoaded = true;
            }
        }

        window.userInitVars = this.config.rodEndConf;
        try {
            var etechInitialized = !!window.rodEndBuildForm;
            if (etechInitialized) {
                this.initializeEtech();

            } else {
                //Wait for ETech libraries to start
                while (!etechInitialized) {
                    if (etechInitialized) {
                        this.initializeEtech();
                    }
                    etechInitialized = !!window.rodEndBuildForm;
                }
            }
        } catch (e) {
            console.error('[ProductConfigurator]', 'initializeEvents', 'initializeEtech', e);
        }

        //Spares && Accessories
        var $sparesAccessoriesContainer = $('.spares-accessories-container');
        if (sparesAccessoriesModuleAvailable && $sparesAccessoriesContainer.length) {
            new Waypoint({
                element: $sparesAccessoriesContainer,
                handler: function () {
                    _self.config.sparesAccessoriesModule.init();

                    this.destroy();
                },
                offset: '150%'
            });
        }

        // Copy to clipboard
        this.$copyToClipBoardBtn.click(copyPartNumberToClipboard.bind(this));

        // Select2 hacking to Notify the change to the rest of Select2
        var $configurationAreaSelects = this.$configurationAreaSelects;
        $configurationAreaSelects.on('select2:select', function (event) {
            console.debug('[ProductConfigurator]', 'initializeEvents', 'TRIGGER change:select');
            $configurationAreaSelects.trigger('change.select2');
            $(document).trigger('smc.partNumber.changed');

            // Only trigger if changed parameter is not a builder (rod end configuration option)
            if ($(this).parents('.builder').length == 0) {
                $(document).trigger('smc.product.config.changed');
            }
        });

        var $configurationAreaInputs = this.$configurationAreaInputs;
        $configurationAreaInputs.change(function () {
            console.debug('[ProductConfigurator]', 'initializeEvents', 'TRIGGER change:input');
            $(document).trigger('smc.partNumber.changed');

            // Only trigger if changed parameter is not a builder (rod end configuration option)
            if ($(this).parents('.builder').length == 0) {
                $(document).trigger('smc.product.config.changed');
            }
        });

        this.$relatedProductsContainer.on('click', '.show-product-configurator-js', onRelatedProductConfiguration.bind(this));

        $document.on('smc.partNumber.changed', function (e, partNumber) {
            _self.updateURLParams();
            _self.updateProjectSummary();
            _self.updatePartNumberContainerStatus();
            if ($("#idbl_hto__partnumber__code_wrapper") !== undefined && $("#idbl_hto__partnumber__code_wrapper").length > 0) {
                $("#idbl_hto__partnumber__code_wrapper").attr("data-partnumber-code", _self.getPartNumber());
            }
            checkPartNumberWrapperOverflow();
            if (_self.getPartNumber() !== "" && _self.isValidConfiguration()) {
                $(".dc_productConfiguratorForm .select2-selection").each(function () {
                    $(this).css("border-color", "#cccccc");
                    $(this).find("div").css("color", "#4D4D4D");
                    if ($("#cylindersConfigurator") !== undefined) {
                        $("#cylindersConfigurator").removeClass("hidden");
                        var currentSimpleSpecialCodeInUrl = getUrlParameter("simpleSpecialCode");
                        if (currentSimpleSpecialCodeInUrl === undefined || currentSimpleSpecialCodeInUrl === "") {
                            if ($("#accessoriesPermission").val() == "true") {
                                $("#cylindersConfigurator_beforeRodEnd").removeClass("hidden");
                            } else {
                                // $("#aareo_configuration_part_modifyRodEnd").click();
                            }
                        }
                    }
                });
            } else {
                /*if ($("#rodEndOptionsSwitchToggle").is(":checked")){
                    $("#rodEndOptionsSwitchToggle").prop("checked",false);
                    $("#rodEndOptionsSwitchToggle").attr("disabled",true);
                }*/
                if ($("#rodEndOptionsSwitchToggle").is(":checked")) {
                    $(".builder").show();
                }

                if ($("#cylindersConfigurator") !== undefined && $("#cylindersConfigurator").length > 0) {
                    $("#cylindersConfigurator").addClass("hidden");
                    $(".show-cylinder-wizard-btn-js").addClass("hidden");
                }
                if (!$("#accesoriesAndRodEndOptionsSwitchToggle").is(":checked")) {
                    $("#cylindersConfigurator_beforeRodEnd").addClass("hidden");
                }
            }
            // checkRodEndComboSelection();
            if ($("#cylindersConfigurator") !== undefined) {
                $(document).trigger('smc.reload.summary');
            }
            _self.getStandardValues();
        });
        // setTimeout(function(){
        // $(".image_sel_class_selected").click();
        // rodEndBuildForm();
        // },500);

        var $copyToClipBoardBtn = this.$copyToClipBoardBtn;
        $document.on('smc.partNumber.copyToClipboard', function (e) {
            $copyToClipBoardBtn.click();
        });

        function checkRodEndChangesForChanges() {
            try {
                // Sometimes when we load the rod end type, the configuration is valid with default values but rod end
                // variable is not correct (empty values)
                // We need to complete the valid configuration updating the rod end
                hideOldRodEndSelector();
                if (currentRodEndStatus === true) {
                    var updateRodEnd = false;
                    Object.entries(rodendUserValues).forEach(function (element) {
                        if (element[1] == '') {
                            updateRodEnd = true;
                        }
                    });

                    if (updateRodEnd) {
                        rodEndChange();
                    }

                    setTimeout(checkRodEndChangesForChanges, 1000);
                } else {
                    setTimeout(checkRodEndChangesForChanges, 100);
                }
            } catch (e) {
                console.log("Error checking rod end changes")
            }

        }

        function checkPitwIsLoaded() {
            try {
                // Heights in high resolutions need to be compensated at high resolutions
                // but we can not do it until PITW is loaded
                var pitwIsLoaded = $("#pitw-wrapper").is(":visible")
                if (pitwIsLoaded) {
                    stickySidebarHeightCompensation();
                } else {
                    setTimeout(checkPitwIsLoaded, 100);
                }
            } catch (e) {
                console.log("Error checking ChangesInConfigurator")
            }
        }

        checkRodEndChangesForChanges();
        checkPitwIsLoaded();
        // _self.checkAdvancedOptions();
    }

    // function checkRodEndComboSelection(){
    //     if ($(".re_image.XRodImage.image_sel_class_selected").length > 0 && $(".re_image.XRodImage.image_sel_class_selected").attr("id").split("_").length > 1){
    //         var currentValue =$("#dom_"+$(".re_image.XRodImage.image_sel_class_selected").attr("id").split("_")[1]).val();
    //         $("#dom_"+$(".re_image.XRodImage.image_sel_class_selected").attr("id").split("_")[1]+" option").each(function(){
    //             console.log(this.value,currentValue,this.value===currentValue,$(this).attr("selected"));
    //             if (currentValue === this.value && $(this).attr("selected") === undefined){
    //                 $("#dom_"+$(".re_image.XRodImage.image_sel_class_selected").attr("id").split("_")[1]).select2().trigger('change');
    //             }
    //         });
    //     }
    // }

    function checkPartNumberWrapperOverflow() {
        var $htoWrapper = $('#idbl_hto_wrapper');
        if ($htoWrapper !== undefined) {
            var $code = $('#idbl_hto__partnumber__code');
            var $codeWrapper = $('#idbl_hto__partnumber__code_wrapper');
            // var codeValues = $('.idbl_hto__partnumber__code_value');
            var codeValues = $('#cpn_partnumber span');
            var codeValuesWidth = 18;
            // for (var item in  codeValues) {
            for (var i = 0; i < codeValues.length; i++) {
                var item = codeValues[i];
                codeValuesWidth += $(item).outerWidth();
            }
            if ($($codeWrapper).outerWidth() < codeValuesWidth) {
                $codeWrapper.addClass('idbl_hto__partnumber__code_wrapper--overflow')
            } else {
                $codeWrapper.removeClass('idbl_hto__partnumber__code_wrapper--overflow')
            }
        }
    }

    // function checkAdvancedOptions(){
    //     console.log("[checkAdvancedOptions] init");
    //     var checked = false;
    //     var _self = this;
    //     $(".adv_option .optionValue input").each(function(){
    //         if ($(this).is(":checked") && _self.isValidConfiguration()){
    //             checked = true;
    //         }
    //     });
    //     if (checked){
    //         $(".adv_option").css("display","");
    //     }
    // }

    //TODO [FeaturedOptions] Remove after featured options is using statification featured options
    function getRandomInt(min, max) {
        min = Math.ceil(min);
        max = Math.floor(max);
        return Math.floor(Math.random() * (max - min + 1)) + min;
    }

    function initializeEtech() {
        console.debug('[ProductConfigurator]', 'initializeEtech', 'init');
        var _self = this;
        var $document = $(document);

        if (!$.fn.select2) console.error('[ProductConfigurator]', 'initializeEtech', 'Select2.js not loaded');
        if (!$.fn.slick) console.error('[ProductConfigurator]', 'initializeEtech', 'Slick.js not loaded');
        if (!$.fn.waypoint) console.error('[ProductConfigurator]', 'initializeEtech', 'Waypoint.js not loaded');

        //Used to identify the <form> element ID of the Product configurator
        window.gConstraintFormID = 'form';

        //PATCH. [SMCD-494] Chech every x time if the value of 'gConstraintFormID' is correct
        [500, 1000, 2500, 5000, 10000].forEach(function (time) {
            setTimeout(function () {
                window.gConstraintFormID = 'form';
            }, time);
        });

        var partNumberChangedDebounced = $.debounce(50, function () {
            $document.trigger('smc.partNumber.changed', [_self.getPartNumber()])
        });

        //Override values as necessary in calling document.
        window.gNoConstraintColor = '';
        window.gExcludedChoiceColor = "#FF191F";
        window.gHardConstraintColor = "#FF191F";
        window.gSoftConstraintColor = "#807000";
        window.ccServer = "https://www.smcetech.com";
        //TODO [RodEndConf] These vars have to be past on backend side to api-products, and api-products to 'ws_catalog.getConfigurableDataEU2V3'
        //window.userInitVars = {'h':'30','de':'10'};
        window.userInitVars = this.config.rodEndConf;

        // Empty Status images
        $('.optionStatus span', this.$configurationArea).html('');

        //Remove nowrap attr
        $('td.optionLabel').removeAttr('nowrap');

        //Activate Select2
        $('td.optionValue', this.$configurationArea).addClass('smc-select');
        var $selects = $('td.optionValue', this.$configurationArea).find('select');
        $('option:first', $selects).text(this.config.messages.selectPlaceholder);

        //Featured Options
        $selects.each(function (i, select) {
            var $select = $(select);
            var $emptyOption = $('option:first', $select);
            var $featuredOptions = $('option.is-preferred', $select);
            var featuredOptionsExists = $featuredOptions && $featuredOptions.length;
            if (featuredOptionsExists) {
                var featuredOptionsGroup = document.createElement('optgroup');
                featuredOptionsGroup.setAttribute('label', _self.config.messages.featuredOptions);
                var $featuredOptionsGroup = $(featuredOptionsGroup);
                $featuredOptionsGroup.append($featuredOptions);

                $featuredOptionsGroup.prependTo($select);
                $emptyOption.prependTo($select);
            }
        });

        $selects.select2({
            dropdownCssClass: 'smc-select',
            templateResult: formatSelect2Options,
            templateSelection: formatSelect2Options
        });
        setTimeout(function () {
                $selects.each(function (i, select) {
                    var $select = $(this);
                    if (!$(this).hasClass("select2-hidden-accessible")) {
                        $select.select2({
                            dropdownCssClass: 'smc-select',
                            templateResult: formatSelect2Options,
                            templateSelection: formatSelect2Options
                        });
                    }
                });
            }
            , 1000);
        $('.select2-container', this.$configurationArea).width('100%');

        $('table,label', this.$configurationArea).removeClass('small');

        //Adjusts "Type of modification" label
        $('tr.builder .optionLabel:hidden').next().css('width', '100%');

        //Initialize Rodend
        try {
            this.config.etech.Init();
        } catch (error) {
            console.error("[initializeEtech] error on this.config.etech.Init()", error);
        }

        //Override Partnumber validation images
        //<img src="/ok.png" />
        this.config.etech.oStateMessages['Complete'] = '<span class="part-number-state part-number-state-ok"></span>';
        this.config.etech.oStateMessages['Partial'] = '<span class="part-number-state part-number-state-partial"></span>';
        this.config.etech.oStateMessages['Invalid'] = '<span class="part-number-state part-number-state-invalid"></span>';
        this.$partNumberState.html(this.config.etech.oStateMessages['Partial']);
        $('img', this.$partNumberState).css('display', 'block');
        $('#cpn_partnumber').addClass('status-partial');

        //Add .btn .btn-primary to all buttons
        $('button,input[type="button"]', this.$configurationArea).addClass('btn btn-primary');

        this.$builder = $('.builder', this.$configurationArea);
        this.$rodEndSelect = $('select', this.$builder);
        this.$rodEndSelect.css('display', 'none');
        var rodEndSelect2 = this.$rodEndSelect.data('select2');
        if (rodEndSelect2) rodEndSelect2.destroy();

        var $selectImageArrow = $('<i>', {
            class: 'icon-arrow-right rotate-90-before blue',
            click: function () {
                $(this).next().toggle();
                var inputBox = $(this).prev();
                $(this).next().mouseleave(function () {
                    $(inputBox).trigger("blur");
                });
            }
        });
        $('.selectBoxArrow').replaceWith($selectImageArrow);

        var rodEndConfigExists = !!$('.builder').length;
        // if (rodEndConfigExists && $("#isCylinderSeriesConfigurationFlag").val() !== "true" && !$("#isCylinderSeriesConfigurationFlag").val() )  {
        if (rodEndConfigExists) {
            productConfiguratorInitFinishNotifyForRodEnd.call(this);
            //Proxy constraintuisupport.js 'setDomainValue' function
            var etechSetDomainValue = window.setDomainValue;
            window.setDomainValue = function (formElementId, formElement) {
                etechSetDomainValue.apply(this, arguments);

                var domainElement = window.oDomains.domains[formElementId];
                if (domainElement && domainElement.code === 'XROD_ENDS') {
                    $document.trigger('smc.rodEndModificationConfig.changed', [domainElement]);
                }

                //Timeout to wait for Etech libra-***ries to update
                _refreshSelect2Status($(formElement).data('select2'), formElement.style.color);
                partNumberChangedDebounced();
            };
            //End Proxy

            //Proxy xrod.eu.js 'rodEndChange' function
            var etechRodEndChange = window.rodEndChange;
            window.rodEndChange = function () {
                if (_self.isValidConfiguration()) {
                    nonBuilderComplete = true;
                }
                etechRodEndChange.apply(this, arguments);
                $document.trigger('smc.rodEndModificationConfig.changed', []);
                partNumberChangedDebounced();
            };
            //End Proxy

            //Proxy constraintuisupport.js 'setDomainValue' function
            var etechIsRodEndInputsComplete = window.isRodEndInputsComplete;
            window.isRodEndInputsComplete = function () {
                _applyRodEndInputsCompleteHack();
                etechIsRodEndInputsComplete.apply(this, arguments);
            };
            //End Proxy

            //Proxy xrod_eu.js 'rodEndDesignView(bTF)' function

            var etechRodEndDesignView = window.rodEndDesignView;
            window.rodEndDesignView = function () {
                etechRodEndDesignView.apply(this, arguments);

                _handleProjectSection.call(_self);
            };

            if (window.bConfigInit && !window.isRodEndNone()) {
                _handleProjectSection.call(_self);
            }
            //End Proxy

            //Proxy constraintuisupport.js 'getFormObject' function
            var etechGetFormObject = window.getFormObject;
            window.getFormObject = function () {
                window.gConstraintFormID = 'form';
                return etechGetFormObject.apply(this, arguments);
            };
            //End Proxy

            //Proxy
            var etechSetRodEndModButtonDisabled = window.setRodEndModButtonDisabled;
            window.setRodEndModButtonDisabled = function (active) {
                etechSetRodEndModButtonDisabled.apply(this, arguments);
                if (active && $(_self.$rodEndOptionsSwitchToggle).is(":checked") && !_self.isValidConfiguration()) {
                    if (!$(".builder").is(":visible")) {
                        $(_self.$rodEndOptionsSwitchToggle).click();
                    }
                } else if (!active && !$(_self.$rodEndOptionsSwitchToggle).is(":checked") && _self.isValidConfiguration() && isSomeRodEndConfSet()) {
                    $(_self.$rodEndOptionsSwitchToggle).click();
                }
                _self.$rodEndOptionsSwitchToggle.prop('disabled', active);
                if ($("#rodEndOptionsSwitchToggle").is(":checked") && !$(".builder").is(":visible")) {
                    $(".builder").attr("style", "");
                    $(".project-alert-container").removeClass("hidden");
                    $("#project-section").removeClass("hidden");
                    $("#project-section-buttons").removeClass("hidden");
                }
            };
            //End Proxy
        }

        this.config.projectInformationModule.init();

        this.$configurationAreaSelects.trigger('change.select2');
        partNumberChangedDebounced();
        $('.optionLabel').css("display", "flex");
        console.debug('[ProductConfigurator]', 'initializeEtech', 'end');
    }

    function isSomeRodEndConfSet() {
        var isSet = false;
        $(".xoption").each(function () {
            if ($(this).hasClass("partnumber_variable_chain") && $(this).text() !== "") {
                isSet = true;
            }
        });
        return isSet;
    }

    function updateProjectSummary() {
        this.$projectSummaryAttributeList = this.$projectSummaryAttributeList || $('.project-summary-attribute-list-js');
        var domTemplateConfigurationSummaryAttributeList = document.getElementById('configurationSummaryAttributeListItemTemplate');
        this.templates.configurationSummaryAttributeListItemTemplateHTML = this.templates.configurationSummaryAttributeListItemTemplateHTML ||
            (domTemplateConfigurationSummaryAttributeList && domTemplateConfigurationSummaryAttributeList.innerHTML);
        var configurationSummaryAttributeListItemTemplateHTML = this.templates.configurationSummaryAttributeListItemTemplateHTML;

        if (configurationSummaryAttributeListItemTemplateHTML) {
            var config = this.getProductConfiguration(true);

            var summaryHTML = '';
            config.forEach(function (domain) {
                var selectedValue = domain['aDSV'][0];
                var selectedValueMember = domain.getMember(selectedValue) || {value: ''};
                var selectedValueMemberValue = selectedValueMember.value;
                if (domain['dtype'] === 'D_INTEGER_RANGE') {
                    selectedValueMemberValue = domain['inputval'];
                }
                summaryHTML += configurationSummaryAttributeListItemTemplateHTML
                    .replace('{{attributeName}}', domain.label)
                    .replace('{{attributeValue}}', selectedValueMemberValue);
            });

            // Add accessories to summary if any
            var $accessoriesSummary = $(".project-summary-attribute-list-js .attribute-list-row.aareo_accesory");
            $accessoriesSummary.each(function () {
                summaryHTML += this.outerHTML;
            });

            this.$projectSummaryAttributeList.html(summaryHTML);
        }
    }

    function updatePartNumberContainerStatus() {
        var status = this.getConfigurationStatus();
        $('#cpn_partnumber')
            .removeClass('status-completed')
            .removeClass('status-invalid')
            .removeClass('status-partial')
            .addClass('status-' + status);

        $('#idbl_hto__partnumber__code_wrapper')
            .removeClass('idbl_hto__partnumber__code_wrapper--status-complete')
            .removeClass('idbl_hto__partnumber__code_wrapper--status-invalid')
            .removeClass('idbl_hto__partnumber__code_wrapper--status-partial')
            .addClass('idbl_hto__partnumber__code_wrapper--status-' + status);
        var partNumber = this.getPartNumber();
        if ((partNumber === undefined || partNumber === "undefined") && $("#cpn_partnumber") !== undefined) {
            partNumber = $("#cpn_partnumber").text();
        }
        $("#product-info-container__partnumber_title").text(partNumber);
        if ($("#cylinder-info-container__partnumber_title__cylinder") !== undefined) {
            $("#cylinder-info-container__partnumber_title__cylinder").text(partNumber);
        }
        this.enableCylinderPartNumberExtrasIfNeeded();

        if (window.dataLayer && status === "complete") {
            sendDatalayer();
        }

    }

    function getPartNumber() {
        return clearPartNumber("----" + window.partNumberString + "----");
    }

    function sendDatalayer() {
        var partnumber = getPartNumber();
        var name = $("h2.heading-02").text();
        var category = $('meta[name=product_series]').attr('content');

        dataLayer.push({
            'event': 'productDetail',
            'ecommerce': {
                'detail': {
                    'products': [{
                        'name': name,
                        'id': partnumber,
                        'category': category
                    }]
                }
            }
        });
    }

    function getProductConfiguration(withRodEndConfig) {
        return this.config.etech.oDomains.cpcarray.filter(function (domain) {
            if (domain.domainFuncType === 'OPTION' && domain.label !== '-') return true;
            if (withRodEndConfig && domain.domainFuncType === 'BUILDER' && domain.code === 'XROD_ENDS') return true;
        });
    }

    function getConfigurationStatus() {
        if (this.config.etech.oDomains === undefined) {
            return "";
        }
        return this.config.etech.oDomains.getConstraintEngineState().toLowerCase();
    }

    function getRodEndModificationConfigurationList() {
        var productConfig = this.getProductConfiguration(true);

        return productConfig.find(function (configAttribute) {
            return configAttribute.code === 'XROD_ENDS';
        });
    }

    function getRodEndModificationConfiguration() {
        var rodEndDomain = this.getRodEndModificationConfigurationList();
        if (rodEndDomain !== undefined) {
            var selectedValue = rodEndDomain['aDSV'][0];
            return rodEndDomain.getMember(selectedValue);
        }
    }

    function getRodEndModificationConfigurationValues() {
        return window.rodendUserValues;
    }

    function getRodEndModificationConfigurationValuesInString() {
        var props = "";

        var rodEndModificationConfiguration = this.getRodEndModificationConfigurationValues();
        for (var propertyName in rodEndModificationConfiguration) {
            props += propertyName + '=' + rodEndModificationConfiguration[propertyName] + ';';
        }

        return props;
    }

    function hasDefaultRodEndModificationConfiguration() {
        var currentRodEndModificationConfiguration = this.getRodEndModificationConfiguration();
        return currentRodEndModificationConfiguration && currentRodEndModificationConfiguration.code === '';
    }

    function isValidConfiguration(checkRodEndConfig) {
        var status = this.getConfigurationStatus();

        if (checkRodEndConfig) {
            //If the Standard rodend configuration is selected, the configuration is OK.
            if (this.hasDefaultRodEndModificationConfiguration()) {
                resetRodEndConf();
                return status === 'complete';
            }

            return status === 'complete' && window.currentRodEndStatus;
        }

        return status === 'complete';
    }

    function _refreshSelect2Status($select2, color) {
        if ($select2 && $select2.$container && $select2.$container[0]) {
            $select2.$container[0].getElementsByClassName('select2-selection__rendered')[0].style.color = color;
            $select2.$container[0].getElementsByClassName('select2-selection')[0].style['border-color'] = color;
        }
    }

    //Featured Options
    function formatSelect2Options(option, htmlElement) {
        var isSelecting = htmlElement && htmlElement.length;

        if (!option.id) {
            return option.text;
        }

        var isFeaturedOption = option.element.className.indexOf('is-preferred') > -1;
        return $('<div>', {
            id: option.id,
            css: {
                color: option.element.style.color
            },
            class: option.element.classList,
            html: isFeaturedOption && !isSelecting ? '<span><i class="image-star"></i> ' + option.text + '</span>' : option.text
        });
    }

    function copyPartNumberToClipboard(event) {
        if (event) event.preventDefault();

        var partNumber = this.getPartNumber();
        console.debug('[ProductConfigurator]', 'copyPartNumberToClipboard', 'partNumber=', partNumber);
        if (!partNumber) return;

        var $temp = $("<input>");
        $("body").append($temp);
        $temp.val(partNumber).select();
        document.execCommand("copy");
        $temp.remove();

        smc.NotifyComponent && smc.NotifyComponent.info(this.config.messages.partNumberCopied);
    }

    function clearPartNumber(partNumber) {
        if (partNumber !== undefined && partNumber !== "") {
            if (partNumber.toString().indexOf("-") === 0) {
                partNumber = partNumber.toString().substring(1);
                partNumber = clearPartNumber(partNumber);
            }
            if (partNumber.toString().endsWith("-")) {
                partNumber = partNumber.toString().substring(0, partNumber.length - 1);
                partNumber = clearPartNumber(partNumber);
            }
        }
        return partNumber;
    }

    function onRelatedProductConfiguration(event) {
        if (event) event.preventDefault();
        var _self = this;
        var relatedProduct = event.target;
        if (relatedProduct.nodeName !== 'A') relatedProduct = relatedProduct.parentElement;
        var productId = relatedProduct.dataset.id;
        var productName = relatedProduct.dataset.name;
        var productUrl = relatedProduct.dataset.url;

        openRelatedProductConfiguration.call(this, productId, productName, productUrl);
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


    function openRelatedProductConfiguration(productId, productName, productUrlBase) {
        var _self = this;
        var def = $.Deferred();
        var currentUrl = window.location.href;
        var currentPartNumber = "";
        var url = new URL(window.location.href);
        if (currentUrl.indexOf("partNumber=") > 0) {
            //We already have the product configurated before open a related one
            //We have to keep this partNumber as param
            var currentPartNumber = getUrlParameter("partNumber");
            if (currentPartNumber) {
                url.searchParams.set('currentPartNumber', currentPartNumber);
                window.history.pushState({}, window.document.title, url.toString());
            }
        }
        var productUrl = _createProductStandaloneUrl(productUrlBase);
        if (window.location.href.indexOf("modalProductPartNumber") > 0) {
            if (productUrl.indexOf("?") > 0) {
                productUrl += "&";
            } else {
                productUrl += "?";
            }
            productUrl += "partNumber=" + getUrlParameter("modalProductPartNumber");
        }
        if (currentPartNumber && currentPartNumber !== "") {
            if (productUrl.indexOf("?") > 0) {
                productUrl += "&";
            } else {
                productUrl += "?";
            }
            productUrl += "currentPartNumber=" + currentPartNumber;
        }
        if (window.isIOS) {
            window.location.href = productUrl;
            return;
        }
        var template = this.templates.productConfigurationModalTemplate || document.getElementById('productConfigurationModalTemplate').innerHTML;
        var $modalTemplate = $(template
            .replace('{{productName}}', productName));
        var $iframe;
        $modalTemplate.on('shown.bs.modal', function () {
            $iframe = $('<iframe>', {
                id: 'productConfiguratorRelatedProductIframe',
                frameBorder: '0',
                class: 'hidden',
                html: _self.config.messages.browserNotCompatibleLbl,
                src: productUrl
            });

            $(window).on('message onmessage', function (event) {
                if (event && event.originalEvent && event.originalEvent.data === 'page-loaded') {
                    $('.spinner-container', $modalTemplate).remove();
                    $iframe.removeClass('hidden');
                    window.productConfiguratorRelatedProductIframe.contentWindow.gConstraintFormID = window.gConstraintFormID;
                    def.resolve();
                }
            });

            $('.modal-body', $modalTemplate).append($iframe);
            $iframe.attr('width', '100%');
            $iframe.attr('height', '100%');
            window.productConfiguratorRelatedProductIframe = $iframe[0];
            // window.history.pushState({}, window.document.title, url.toString());
        });

        $modalTemplate.on('hide.bs.modal', function () {
            $iframe.remove();
            window.productConfiguratorRelatedProductIframe = null;
        });

        $modalTemplate.modal('show');

        return def.promise();
    }

    function updateURLParams() {
        if (this.isValidConfiguration()) {
            var url = new URL(window.location.href);

            var partNumber = this.getPartNumber();
            if ((partNumber === undefined || partNumber === "undefined" || partNumber === "") && $("#cpn_partnumber") !== undefined) {
                partNumber = $("#cpn_partnumber").text();
            }
            $("#product-info-container__partnumber_title").text(partNumber);
            this.enableCylinderPartNumberExtrasIfNeeded();
            console.debug('[ProductConfigurator]', 'partNumber=', partNumber);
            if (partNumber) {
                url.searchParams.set('partNumber', partNumber);
                window.history.replaceState({}, window.document.title, url.toString());
            }
            // if ($("#cylindersConfigurator") === undefined){
            var rodEndConf = this.getRodEndModificationConfigurationValuesInString();
            if (rodEndConf === "") {
                var url = new URL(window.location.href);
                url.searchParams.delete('rodEndConf');
                window.history.replaceState({}, window.document.title, url.toString());
            }
            if (rodEndConf) {
                url.searchParams.set('rodEndConf', encodeURI(rodEndConf));
                setTimeout(function () {
                    if ($(".rodEndRow .formStatusNO_OK").length === 0) {
                        $(document).trigger('smc.reload.summary');
                    } else if ($("#cylindersConfigurator") !== undefined) {
                        $("#aareo__create-single-special").addClass("hidden");
                    }
                }, 1500);
            }
            // }
            this.techSpecsPC();
            if (isSeries) {
                this.updateSparesRelated();
                this.updateProjectSummary();
                if ($("#cylindersConfigurator") !== undefined) {
                    this.$rodEndCylinderSwitchToggle.prop('disabled', false);
                }
            }
            window.history.pushState({}, window.document.title, url.toString());
        } else if (isSeries) {
            if ($("#cylindersConfigurator") !== undefined) {
                this.$rodEndCylinderSwitchToggle.prop('disabled', true);
                $("#aareo__create-single-special").addClass("hidden");
            }
        }
    }

    function enableCylinderPartNumberExtrasIfNeeded() {
        if ($("#isCylinderSeriesConfigurationFlag") !== undefined && $("#isCylinderSeriesConfigurationFlag").val() === "true") {
            var partNumber = this.getPartNumber();
            $("#product-info-container__partnumber_title-for-cylinder").text(partNumber);
            $(".product-info-sub-container__content-for-cylinder").removeClass("hidden");
            $(".cylinder-taco-extra").removeClass("hidden");
            $(document).trigger('smc.reload.summary');
        }
    }

    function focusProjectInformation() {
        setTimeout(function () {
            //Scroll
            $('html, body').animate({
                scrollTop: $('#project-section-container').offset().top
            }, 500, 'linear');

            //Show the Tab
            $('#project-information-tab').tab('show');
        }, 250);

    }

    function showProductConfiguratorCadDownload(actionParams) {
        var _self = this;

        var relatedProductId = actionParams.split(',')[0];
        var relatedProductPartNumber = actionParams.split(',')[1];
        var selector = '.show-product-configurator-js[data-id="{{productId}}"]'.replace('{{productId}}', relatedProductId);
        var $configuratorModal = $(selector);

        var productId = $configuratorModal[0].dataset.id;
        var productName = $configuratorModal[0].dataset.name;
        var productUrl = new URL(window.location.origin + $configuratorModal[0].dataset.url);
        productUrl.searchParams.set('relatedProductPartNumber', relatedProductPartNumber);

        openRelatedProductConfiguration.call(this, productId, productName, productUrl.pathname)
            .then(function () {
                var productToolbar = window.smc.ComponentManager.getComponentById(_self.config.productToolbarForFreeConfiguratorId);

                if (productToolbar) {
                    productToolbar.showCadDownload();
                }
            });
    }

    function _applyRodEndInputsCompleteHack() {
        //Set first RodEnd Option
        if (window.rodEndFormData && window.rodEndFormData.rodends) {
            window.rodEndFormData.rodends['none'] = window.rodEndFormData.rodends['none'] || {
                'input': [],
                'input_trunnion': []
            };
        }
    }

    function getSliderConfiguration(relatedProductsCount) {
        return {
            dots: false,
            infinite: false,
            speed: 300,
            slidesToShow: relatedProductsCount > 5 ? 5 : relatedProductsCount,
            slidesToScroll: relatedProductsCount > 5 ? 5 : relatedProductsCount,
            responsive: [
                {
                    breakpoint: 1400,
                    settings: {
                        slidesToShow: relatedProductsCount > 4 ? 4 : relatedProductsCount,
                        slidesToScroll: relatedProductsCount > 4 ? 4 : relatedProductsCount
                    }
                },
                {
                    breakpoint: 1200,
                    settings: {
                        slidesToShow: relatedProductsCount > 3 ? 3 : relatedProductsCount,
                        slidesToScroll: relatedProductsCount > 3 ? 3 : relatedProductsCount
                    }
                },
                {
                    breakpoint: 800,
                    settings: {
                        slidesToShow: relatedProductsCount > 2.5 ? 2 : relatedProductsCount,
                        slidesToScroll: relatedProductsCount > 2 ? 2 : relatedProductsCount
                    }
                },
                {
                    breakpoint: 540,
                    settings: {
                        slidesToShow: relatedProductsCount > 1 ? 1.5 : relatedProductsCount,
                        slidesToScroll: relatedProductsCount > 1 ? 1 : relatedProductsCount,
                        arrows: false
                    }
                }
                // You can unslick at a given breakpoint now by adding:
                // settings: "unslick"
                // instead of a settings object
            ]
        };
    }

    function _handleProjectSection() {
        this.$projectAlertContainer = this.$projectAlertContainer || $('.project-alert-container');
        this.$projectSection = this.$projectSection || $('#project-section');

        this.$projectSectionButtons = this.$projectSectionButtons || $('#project-section-buttons');


        var isConfigurationVisible = $('.builder', this.$configurationArea).first().is(':visible');
        if (isConfigurationVisible) {
            this.$projectAlertContainer.removeClass('hidden');
            this.$projectSection.removeClass('hidden');
            this.$projectSectionButtons.removeClass('hidden');

            this.updateProjectSummary();
            //this.config.projectInformationModule.init();
        } else {
            this.$projectAlertContainer.addClass('hidden');
            this.$projectSection.addClass('hidden');
            this.$projectSectionButtons.addClass('hidden');
        }
    }

    /**
     * Transforms /en-eu/products/... to /en-eu/products-standalone/...
     */
    function _createProductStandaloneUrl(productUrlBase) {
        if (productUrlBase === undefined || productUrlBase === "undefined" || productUrlBase === null) {
            return "";
        }
        return productUrlBase.split('/').map(function (pathSlot, i) {
            var isProductPathSlot = i === 2;// Is "products|productos|produkte|produits"
            if (isProductPathSlot) {
                return 'products-standalone';
            } else {
                return pathSlot;
            }
        }).join('/').replace('~nav', '~cfg');
    }

    function updateSparesRelated() {
        var _self = this;
        $("#free_configuration_spares_container").empty();
        var partNumber = _self.getPartNumber();
        _self.spareAndRelatedProducts(partNumber);
        // var url = replacePartNumber(partNumber,globalConfig.pc.urls.hasSpareAndRelatedProducts);
        //
        // var data = {
        //     productId: this.productId,
        //     partNumber: partNumber,
        //     origin: 'PC'
        // };
        // $("#freeConfiguration-spares-related").addClass("hidden");
        // $.get(url, data)
        //     .then(function (response) {
        //         var result = JSON.parse(response);
        //         if (!result.hasSpares){
        //             return;
        //         }
        //         _self.spareAndRelatedProducts(partNumber);
        //     })
        //     .catch(function (error) {
        //         console.debug("SpareAndRelatedProductsTab error" + error);
        //     });//MGPL16-100Z

    }

    function replacePartNumber(partNumber, endpointUrl) {
        var url = new URL(endpointUrl);
        url.searchParams.set('partNumber', partNumber);
        return url;
    }

    function spareAndRelatedProducts(partNumber) {
        var _self = this;
        var $msgBody = $("#free_configuration_spares_container");
        if (_self.getPartNumber() !== "" && _self.isValidConfiguration()) {
            var data = {
                componentId: this.id,
                productId: this.productId,
                partNumber: partNumber
            };
            var url = replacePartNumber(partNumber, globalConfig.pc.urls.showSeriesSpareAndRelatedProducts);
            var $container = $("#free_configuration_spares_tab");
            initLoading($container, this.templates.spinnerTemplateHTML);
            $.get(url, data)
                .then(function (response) {
                    $msgBody.empty();
                    $msgBody.append($(response));
                    if ($(".related-products-result-container").length > 0) {
                        $container.removeClass('hidden');
                        $("#freeConfiguration-spares-related").removeClass("hidden");
                        $("#free_configuration_spares_container .spare-accessory-item").css("display", "");
                        $("#free_configuration_spares_container .accessories-products-result-container").css("display", "");
                    }
                    endLoading($container);
                    if (isSeries) {
                        var cadOrigin = getUrlParameter("seriesCadOrigin");
                        if (cadOrigin !== undefined) { //then we came from login
                            if (cadOrigin === "pc-spares") {
                                var spareGroup = getUrlParameter("seriesSelectedGroup");
                                if (spareGroup !== undefined) {
                                    setTimeout(function () {
                                        $("#" + spareGroup).click();
                                        var selectedSpareCad = getUrlParameter("seriesCadPartNumber");
                                        // if (!$(".cad-download-modal").is(":visible")){
                                        //     $("#producttoolbar_"+selectedSpareCad+"_desktop .show-cad-download").first().click();
                                        // }
                                    }, 800);
                                }
                            }
                        }
                    }
                })
                .catch(function () {
                    endLoading($container);
                });
        }
    }

    function initLoading($container, spinnerTemplateHTML) {
        $container.addClass('disabled');
        $container.addClass('hidden');
        $('.loading-container-js', $container)
            .addClass('loading-container')
            .html(spinnerTemplateHTML);
    }

    function endLoading($container) {
        $('.loading-container-js', $container)
            .removeClass('loading-container')
            .html('');
        $container.removeClass('disabled');
    }

    //From loac_cc_button.jsp
    function productConfiguratorInitFinishNotifyForRodEnd() {
        $("#divFormFakeButton").remove(); //we delete the last button just in case, to avoid any problem

        var lblButton = this.config.messages['clickheretoloadrodendproject'];
        if ($("#aareo_cylinderConfigurator_loadProject_text") !== undefined && $("#aareo_cylinderConfigurator_loadProject_text").text() !== "" && $("#rodEndOptionsSwitch") !== undefined && $("#rodEndOptionsSwitch").length > 0) {
            lblButton = $("#aareo_cylinderConfigurator_loadProject_text").text();
        }

        //we add the "open ccf" button
        var $rodEndModButton = $("#rodEndModButton");
        var $rodEndModButtonParent = $rodEndModButton.parent();
        $rodEndModButtonParent.addClass('position-relative');
        // if (($("#showRodEndConfiguration").val() === "true" ||  $("#showRodEndConfiguration").val() ) && ($("#mustShowCompleteCylinderSeries").val() !== "true" ) ){
        // if ($("#showRodEndConfiguration").val() === "true" && ($("#cylindersConfigurator_beforeRodEnd") === undefined  || $("#cylindersConfigurator_beforeRodEnd").length === 0)){
        if ($("#showRodEndConfiguration").val() === "true" && ($("#aareo_switch_container") === undefined || $("#aareo_switch_container").length === 0)) {
            $rodEndModButtonParent
                .prepend("<div id=\"divFormFakeButton\"><div id=\"divForm\" style=\"display: none;\"><form id=\"loadProjectFileForm\"><input type=\"file\" name=\"myFile\" id=\"fileOriginal\" /><input type=\"submit\" value = \"Open file*\" id =\"fileSubmit\"/></form></div><input type=\"button\" class=\"smc_button_8 btn btn-primary\" id=\"ccSubmitFileButton\"  value=\"" + lblButton + "\" /></div>");
        } else if ($("#showRodEndConfiguration").val() === "true") {
            $("#aareo_switch_container")
                .append("<div id=\"divFormFakeButton\"><div id=\"divForm\" style=\"display: none;\"><form id=\"loadProjectFileForm\"><input type=\"file\" name=\"myFile\" id=\"fileOriginal\" /><input type=\"submit\" value = \"Open file*\" id =\"fileSubmit\"/></form></div><input type=\"button\" class=\"smc_button_8 btn btn-primary\" id=\"ccSubmitFileButton\"  value=\"" + lblButton + "\" /></div>");
        }
        //Show
        this.templates.rodEndOptionsSwitch.className = this.templates.rodEndOptionsSwitch.className.replace('hidden', '');
        this.templates.rodEndOptionsSubtitle.className = this.templates.rodEndOptionsSubtitle.className.replace('hidden', '');

        $rodEndModButtonParent.prepend(this.templates.rodEndOptionsSwitch);
        $rodEndModButtonParent.prepend(this.templates.rodEndOptionsSubtitle);
        $rodEndModButtonParent.prepend($('<hr class="section-separator mb-5" />')[0]);

        var rodEndConfigOpened = $('.builder').is(':visible');
        if (rodEndConfigOpened) {
            this.$rodEndOptionsSwitchToggle.removeAttr('disabled').prop('checked', true);
        } else {
            var rodEndConf = getUrlParameter("rodEndConf");
            if (rodEndConf !== undefined && rodEndConf !== "") {
                this.$rodEndOptionsSwitchToggle.removeAttr('disabled').prop('checked', true);
            }
        }

        this.$rodEndOptionsSwitchToggle.on('change', function () {
            if (!this.$rodEndOptionsSwitchToggle.is(':checked') && !rodEndConfigOpened) {
                window.rodEndDesignView();
            } else {
                window.rodEndDesignView();
            }
        }.bind(this));

        if (this.$rodEndCylinderSwitchToggle !== undefined) {
            this.$rodEndCylinderSwitchToggle.on('change', function () {
                this.cylinderSwitchToggle();
            }.bind(this));
        }
        this.cylinderSwitchToggle();

        var loadProjectFileForm = document.getElementById('loadProjectFileForm');
        $(loadProjectFileForm).submit(function () {
            //get file here
            var file = this.elements.fileOriginal.files[0];

            var fileReader = new FileReader();
            fileReader.onload = function (e) {
                file.content = e.target.result;
                $(document).trigger('smc.productConfiguratorComponent.loadProjectFile', file);
            };
            fileReader.readAsText(file);
            return false;
        });

        var loadCylinderProjectFileForm = document.getElementById('cylinderConfiguratorLoadProjectFile');
        if (loadCylinderProjectFileForm !== undefined) {
            $(loadCylinderProjectFileForm).submit(function () {
                //get file here
                var file = this.elements.fileOriginal.files[0];

                var fileReader = new FileReader();
                fileReader.onload = function (e) {
                    file.content = e.target.result;
                    $(document).trigger('smc.productConfiguratorComponent.loadProjectFile', file);
                };
                fileReader.readAsText(file);
                return false;
            });
        }

        var fileOriginal = document.getElementById('fileOriginal');
        if (fileOriginal) {
            fileOriginal.onchange = onChange;
        }

        function onChange(e) {
            var splits = $(fileOriginal).val().split("\\");
            var uploadedFile = splits [splits.length - 1];

            if (uploadedFile.substring(uploadedFile.length - 3) === uploadedFile.substring(0, 3) && uploadedFile.substring(0, 3) === "CCF") {
                $("#fileSubmit").click();
            }
        }

        $("#ccSubmitFileButton").click(function () {
            $(fileOriginal).click();
        });
        if ($("#cylinderConfiguratorLoadProjectFile") !== undefined) {
            $("#cylinderConfiguratorLoadProjectFile").click(function () {
                $(fileOriginal).click();
            });
        }
    }

    function cylinderSwitchToggle() {
        if (!this.$rodEndCylinderSwitchToggle.is(':checked')) {
            $(".aareo_configuration_part").addClass("hidden");
            $(".project-alert-container").addClass("hidden");
            $("#project-section").addClass("hidden");
            $("#project-section-buttons").addClass("hidden");
            $("#rodEndOptionsSwitchToggle").removeAttr("checked");
            $("#rodEndOptionsSwitchToggle").prop("checked", false);
        } else {
            $(".aareo__cylinder__part_rodEnd a").click();
            if ($("#accessoriesPermission").val() == "true") {
                $(".aareo_configuration_part").removeClass("hidden");
            } else {
                $("#aareo_configuration_part_modifyRodEnd").click();
            }
            $(".project-alert-container").removeClass("hidden");
            $("#project-section").removeClass("hidden");
            $("#project-section-buttons").removeClass("hidden");
            $(".aareo__choose-add-modify").addClass("hidden");
            if ($(".aareo__cylinder__part_rodEnd a ").each(function () {
                if ($(this).hasClass("selected")) {
                    $(".aareo__choose-add-modify").removeClass("hidden");
                }
            })) ;
            if ($(".aareo__cylinder__part_rodEnd .aareo__cylinder__part_position_js .selected") !== undefined
                && $(".aareo__cylinder__part_rodEnd .aareo__cylinder__part_position_js.selected").length > 0) {
                $("#aareo__choose-accesory").addClass("hidden");
            }
        }
    }

    // Series techspecs
    function techSpecsPC() {
        var $container = $("#series-techspecs");
        if ($container.length < 1) {
            return;
        }
        var _self = this;
        var partNumber = _self.getPartNumber();
        var productId = _self.config.productId;
        var $msgBody = $container.find('.product-detail-content-js');
        $msgBody.empty();

        initLoading($container, this.templates.spinnerTemplateHTML);

        getProductDetailInfo.call(this, globalConfig.pc.urls.showTechSpecs, partNumber, productId)
            .then(function (response) {
                $msgBody.empty();
                $msgBody.append(response);
                let $techSpectsTable = $('.detail-table', '#tech_specs_list');
                addEClassInfoInTechSpecs(window['eclass-code'], '.eclass-code', $techSpectsTable);
                addEClassInfoInTechSpecs(window['eclass-version'], '.eclass-version', $techSpectsTable);
                addEClassInfoInTechSpecs(window['unspsc-number'], '.unspsc-number', $techSpectsTable);
                addEClassInfoInTechSpecs(window['unspsc-version'], '.unspsc-version', $techSpectsTable);
                endLoading($container);
                $container.removeClass('hidden');
            })
            .catch(function () {
                endLoading($container);
            });
    }

    function addEClassInfoInTechSpecs(value, className, $techSpectsTable) {
        if (value) {
            $(className + ' .attribute-value', $techSpectsTable).html(value);
            $(className, $techSpectsTable).show();
            $(className, $techSpectsTable).removeClass("hidden-important");
            delete window[className.substring(1)];
        }
    }

    function getProductDetailInfo(urlBase, partNumber, productId) {

        var data = {
            componentId: this.id,
            productId: this.productId,
            language: this.config.defaultLanguage || 'en',
            partNumber: partNumber,
            productId: productId
        };
        var url = replacePartNumber(partNumber, urlBase);
        return $.get(url, data);
    }

    function resetRodEndConf() {
        $(".partnumber_optdash_chain.xoption").each(function () {
            if ($(this).text() === "X") {
                $(this).text("");
            }
        });
        $(".builder input[type='checkbox']").removeAttr("checked");
        $(".rod_sel_images_container img").first().click();
    }

    function checkPartNumberHoverLength() {
        $('#idbl_hto__partnumber__code_wrapper').on('mouseenter touchenter', function () {
            console.log('!! >> pn tooltip:')
            let bodyWidth = $('body').width();
            let pnBoxWidth = $('#cpn_partnumber').width();
            let pnStyle = "<style id='pn_tooltip_custom_width'>#idbl_hto__partnumber__code_wrapper:after {";
            let pnWidth = pnBoxWidth + 20; // pn + padding + border
            let pnOffset = $('#idbl_hto__partnumber__code_wrapper').offset();
            if (window.matchMedia("(min-width: 768px)").matches && bodyWidth > pnWidth) {
                pnStyle += 'width:' + pnWidth + 'px;';
                pnStyle += 'max-width:' + pnWidth + 'px;';
            } else {
                pnStyle += 'width: 80vw;';
                pnStyle += 'max-width:80vw;';
                pnStyle += 'left:calc(50vw - ' + pnOffset.left + 'px)';
            }
            pnStyle += "}</style>";
            $('#idbl_hto__partnumber__code_wrapper').prepend(pnStyle);
        });
        $('#idbl_hto__partnumber__code_wrapper').on('mouseleave touchleave', function () {
            $('#pn_tooltip_custom_width').remove();
        });
    }

    function stickySidebarHeightCompensation() {
        let $stickySidebar = $('#free_configuration .cylinders_configurator_container > .sticky-sidebar');
        let stickySidebarHeight = $stickySidebar.height();
        let configurationRowsHeight = 0;
        $('.productconfigurator-component .free_configuration--cylinder .configurator-container #configuration_area tr.configurationRow:not(.builder)').map(function (row) {
            configurationRowsHeight += $(this).height()
        })

        if (configurationRowsHeight < stickySidebarHeight) {
            $('.productconfigurator-component .free_configuration--cylinder .configurator-container #configuration_area tr.configurationRow:not(.builder)').last().css('margin-bottom', stickySidebarHeight - configurationRowsHeight);
        }
    }

    function hideOldRodEndSelector() {
        let $builderConfigurationRow = $(".builder.configurationRow").last()
        if ($(".select2-container", $builderConfigurationRow).length > 1) {
            $(".select2-container", $builderConfigurationRow).first().hide()
            $(".optionStatus", $builderConfigurationRow).first().hide()
            $(".optionLabel", $builderConfigurationRow).first().hide()
        }
    }

    function getFailedAttributes() {
        var oFullfilledRules = oDomains.oFullfilledRules;
        var oEvaluatedRules = oDomains.oEvaluatedRules;
        var failedAttributes = [];
        console.log(oFullfilledRules);
        for (var key in oFullfilledRules) {
            var evaluatedRule = oEvaluatedRules[key];
            for (var member in evaluatedRule.members) {
                var conflictingAttributeDomain = oDomains.domains[member];
                if (failedAttributes.indexOf(conflictingAttributeDomain.code) == -1) {
                    failedAttributes.push(conflictingAttributeDomain.code);
                }
            }
        }

        return failedAttributes;
    }

    function getStandardValues() {
        var _self = this;
        //we load the values, if XA is present
        if (_self.getPartNumber().indexOf("-XA") > 0) {
            var partNumberWithoutRodEnd = _self.getPartNumber().substring(0, _self.getPartNumber().indexOf("-XA"));
            if (_self.$standardValuesMap.get(partNumberWithoutRodEnd) === undefined) {
                console.log("getStandardValues - call to server", _self.getPartNumber());
                _self.$standardValuesMap.set(partNumberWithoutRodEnd, "");
                var data = {
                    productId: _self.productId,
                    partNumberWithoutRodEnd: partNumberWithoutRodEnd
                };
                var url = globalConfig.pc.urls.getStandardValues;
                $.get(url, data)
                    .then(function (response) {
                        if (response !== undefined) {
                            _self.$standardValuesMap.set(partNumberWithoutRodEnd, response);
                            _self.checkStandardMessage(partNumberWithoutRodEnd);
                        }
                    })
                    .catch(function (error){
                        _self.$standardValuesMap.delete(partNumberWithoutRodEnd);
                        console.log("getStandardValues Error", error);
                    });
            } else {
                console.log("getStandardValues - data in map", _self.getPartNumber());
                _self.checkStandardMessage(partNumberWithoutRodEnd);
            }
        }
    }

    function checkStandardMessage(partNumberWithoutRodEnd) {
        console.log("checkStandardMessage", this.$standardValuesMap);
        $(".standardMessageContainer").remove();
        var _self = this;
        var $standardValuesList = undefined;
        if (_self.$standardValuesMap.get(partNumberWithoutRodEnd) !== undefined) {
            $standardValuesList = _self.$standardValuesMap.get(partNumberWithoutRodEnd);
        }
        if ($standardValuesList !== undefined && _self.getPartNumber().indexOf("-XA") > 0) {
            var rodEndPartNumberPart = _self.getPartNumber().substring(_self.getPartNumber().indexOf("-XA") + 1);
            for (var standardIndex in $standardValuesList) {
                var currentConfiguration = $standardValuesList[standardIndex];
                if (currentConfiguration instanceof  Object && currentConfiguration.name === rodEndPartNumberPart) {
                    if (_self.hasStandardValues(currentConfiguration.confValues)) {
                        var standardMessage = this.config.messages['standardMessage'];
                        $(".rodEndTable").parent().append("<div class = 'standardMessageContainer'>" + standardMessage +"</div>");
                    }
                    return;
                }
            }
        }
    }

    function hasStandardValues(standardValueList) {
        console.log("hasStandardValues", standardValueList);
        var _self = this;
        var rodEndConfValues = _self.getRodEndModificationConfigurationValues();
        var somethingFound = false;
        for (var rodEndKey in rodEndConfValues) {
            var currentValue = rodEndConfValues[rodEndKey];
            var standardPair = getEquivalentStandardValuePair(rodEndKey, standardValueList);
            if (standardPair === undefined){
                return false;
            }
            somethingFound = true;
            if (currentValue !== standardPair.value) {
                return false;
            }
        }
        if (!somethingFound) {
            return false;
        }
        return true;
    }

    function getEquivalentStandardValuePair(key, standardValueList) {
        for (var index in standardValueList) {
            var currentPair = standardValueList[index];
            if (currentPair.key !== undefined && key.toString().toUpperCase() === currentPair.key.toString().toUpperCase()) {
                return currentPair;
            }
        }
        return undefined;
    }

    window.smc.ProductConfigurator = ProductConfigurator;
})(window);

function partnumberChangeFinishNotify() {
    $(document).trigger('smc.productSelection.partNumber.changed', [partNumberString]);
}

function rodEndChangeFinishNotify() {
    console.log("Rod end changed. Status: " + currentRodEndStatus, rodendUserValues);
    $(document).trigger('smc.rodEndUpdate.reload', currentRodEndStatus);

}