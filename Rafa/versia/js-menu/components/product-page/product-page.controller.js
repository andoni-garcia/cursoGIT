(function(globalConfig) {
    var TABS = {
        SSI_TAB: 'standard_stocked_items_tab',
        FREE_CONFIG_TAB: 'free_configuration_tab'
    };

    function ProductPage(config) {
        this.id = config.id;
        this.config = config;
    }

    ProductPage.prototype.init = init;

    function init() {
        console.debug('[ProductPage]', 'init id=', this.id);

        this.$container = $('.productconfigurator-component');
        this.templates = {};

        if (window.isIOS) {
            $('.back-button-js').parent().removeClass('hidden');
        }
        _activateTabs.call(this);
        _initialWorkflow.call(this);
        _initializeEvents.call(this);
        $(document).trigger('smc.registercomponent', [this.id, this]);
        $('body').trigger('dc-component-loaded');
        fixRefreshDataBannerPosition();
        reviewDescriptionUrls();
    }

    function _activateTabs() {
        var _self = this;
        var $tabsLinks = $('.navigation-links-js', _self.config.container);

        $($tabsLinks).on('click', 'a', function (e) {
            e.preventDefault();
            var $this = $(this);

            if (_self.config.device !== 'DESKTOP') {
                //Remove all active nav links
                $('a', $tabsLinks).not($this).removeClass('active');

                $this.toggleClass('active');

                var target = $this.data("target");
                $(target).collapse('toggle');

            }
        });
    }

    function _initialWorkflow() {
        var _self = this;

        _componentLoaded.call(this);

        if (this.config.showOnlyFreeConfigurationTab) {
            handleProductConfiguratorTabActivation.call(this);

        } else {
            var currentUrl = new URL(window.location.href);

            //avoid change the tab if you coming for other site page
            if (window.document.referrer !== "" && window.document.referrer !== currentUrl.toString()
                && _self.config.cookieConsentComponent !== undefined && _self.config.cookieConsentComponent.functionalCookiesAllowed()) {
                    window.localStorage.setItem('productPage.lastVisitedTabId', TABS.SSI_TAB);
            }

            //If Part number detected in URL, go to Free Configuration Tab
            var partNumber = currentUrl.searchParams.get('partNumber');
            if (partNumber
                && _self.config.cookieConsentComponent !== undefined && _self.config.cookieConsentComponent.functionalCookiesAllowed() ) {
                window.localStorage.setItem('productPage.lastVisitedTabId', TABS.FREE_CONFIG_TAB);
            }

            var lastVisitedTabId = window.localStorage.getItem('productPage.lastVisitedTabId');

            if (lastVisitedTabId === ""
                && _self.config.cookieConsentComponent !== undefined && _self.config.cookieConsentComponent.functionalCookiesAllowed()) {
                lastVisitedTabId = TABS.SSI_TAB;
                window.localStorage.setItem('productPage.lastVisitedTabId', lastVisitedTabId);
            }

            var $tab = $('#' + lastVisitedTabId);
            if (!lastVisitedTabId || lastVisitedTabId === TABS.SSI_TAB) {
                if(_self.config.device === 'DESKTOP') {
                    $tab.tab('show');
                } else {
                    $tab.click();
                }

                handleTabActivation.call(this, lastVisitedTabId);

            } else if (lastVisitedTabId === TABS.FREE_CONFIG_TAB) {
                if(_self.config.device === 'DESKTOP') {
                    $tab.tab('show');
                } else {
                    $tab.click();
                }

                $tab.on('shown.bs.tab', function (e) {
                    handleTabActivation.call(_self, lastVisitedTabId);
                });
            }
        }
    }

    function _componentLoaded() {
        if (window.parent) {
            //Emit event when the page is ready.
            window.parent.postMessage('page-loaded', '*');
        }

        // Tab ready to
        $('#' + TABS.FREE_CONFIG_TAB).removeClass('disabled');
    }

    function _initializeEvents() {
        var _self = this;
        $('.main-tabs a[data-toggle="tab"]', _self.$container).on('shown.bs.tab', function (e) {
            var tabId = e.target.id;
            console.debug('[ProductPage]', 'showing tabId=', tabId);
            if ( _self.config.cookieConsentComponent !== undefined && _self.config.cookieConsentComponent.functionalCookiesAllowed()) {
                window.localStorage.setItem('productPage.lastVisitedTabId', tabId);
            }

            handleTabActivation.call(_self, tabId);
        });

        $('a.js-accordion-mobile', _self.$container).on('click', function (e) {
            var tabId = e.currentTarget.dataset.section;
            console.debug('[ProductPage]', 'showing (mobile) tabId=', tabId);
            if ( _self.config.cookieConsentComponent !== undefined && _self.config.cookieConsentComponent.functionalCookiesAllowed()) {
                window.localStorage.setItem('productPage.lastVisitedTabId', tabId);
            }

            handleTabActivation.call(_self, tabId);
        });

        //$('#' + TABS.FREE_CONFIG_TAB).removeClass('disabled');
    }

    function handleTabActivation(tabId) {
        if (!tabId || tabId === TABS.SSI_TAB) {
            handleStandardStockedItemsTabActivation.call(this);

        } else if (tabId === TABS.FREE_CONFIG_TAB) {
            handleProductConfiguratorTabActivation.call(this);

        } else {
            console.error('Loaded ProductPage with a new TAB¿?')
        }
    }

    function handleStandardStockedItemsTabActivation() {
        if (!this.standardStockedItemsTabInitialized) {
            if (this.config.standardStockedItemsComponent) {
                this.config.standardStockedItemsComponent.init();
                this.standardStockedItemsTabInitialized = true;
            }
        }

        //[Floating PartNumber] Adjust Footer height
        $('.secondary-footer.main-footer__bottom:first-of-type').css('padding-bottom', '13px');
    }

    function handleProductConfiguratorTabActivation() {
        if (!this.productConfiguratorTabInitialized) {
            if (this.config.productConfiguratorComponent) {
                this.config.productConfiguratorComponent.init();
                this.productConfiguratorTabInitialized = true;
            }
        }

        //[Floating PartNumber] Adjust Footer height
        $('.secondary-footer.main-footer__bottom:first-of-type').css('height', '120px');
    }


    function reviewDescriptionUrls(){
        try{
            var initialUrl = "";
            initialUrl = window.location.href;
            initialUrl = initialUrl.substr(0, initialUrl.lastIndexOf("/"));
            $(".productconfigurator-component .description a").each(function(){
                var currentHref = $(this).attr("href");
                if (currentHref.indexOf("dc_product_id=") > 0){
                    var productId = currentHref.substr((currentHref.indexOf("dc_product_id=") + "dc_product_id=".length) );
                    var productName = $(this).text();
                    productName = productName.replace(" ","-").replace(",","");
                    var currentReplacedURL = initialUrl+ "/" +productName+"~"+productId+"~cfg";
                    $(this).attr("href",currentReplacedURL);
                }
            });
        }catch(error){
            console.log("reviewDescriptionUrls",error);
        }
    }

    function fixRefreshDataBannerPosition () {
        let $refreshDataBanner = $("#refresh-data-banner");
        if ($refreshDataBanner && $refreshDataBanner.length > 0) {
            $refreshDataBanner.insertBefore($(".dc-bc").parent().parent());
            // $refreshDataBanner.addClass("margin-top-menu");
        }
    }

    window.smc.ProductPage = ProductPage;
})(window.globalConfig);

