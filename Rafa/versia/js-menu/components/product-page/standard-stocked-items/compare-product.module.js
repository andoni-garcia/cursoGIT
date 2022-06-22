(function (globalConfig) {
    function CompareProducts(config) {
        this.selectedPartNumbers = [];
        this.id = config.id;
        // this.productId = config.productId;
        this.config = config;
        this.page = config.page;
        this.size = config.size;
    }

    CompareProducts.prototype.init = init;
    CompareProducts.prototype.initCompareProducts = initCompareProducts;
    CompareProducts.prototype.initLoading = initLoading;
    CompareProducts.prototype.endLoading = endLoading;
    CompareProducts.prototype.triggerPartNumberChangedEvent = triggerPartNumberChangedEvent;
    CompareProducts.prototype.getSelectedPartNumbers = getSelectedPartNumbers;

    function init() {
        console.debug('[CompareProducts]', 'init id=', this.id);

        this.templates = {
            spinnerTemplateHTML: document.getElementById('spinner-template').innerHTML
        };

        this.$addToBasketBtn = $('.add-to-basket-btn-js', this.config.container);
        this.$addToFavouritesBtn = $('.add-to-favourites-js', this.config.container);
        this.quantity = 1;


        this.initCompareProducts();
    }


    function initCompareProducts() {
        var _self = this;

        this.selectedPartNumbers.push(this.config.partNumber);
        //partNumber to basket
        this.triggerPartNumberChangedEvent.call(this);
    }


    function getSelectedPartNumbers() {
        return this.selectedPartNumbers;
    }


    function triggerPartNumberChangedEvent() {
        var changedEventId = ['smc.', this.config.id, '.selectedPartNumberChanged'];
        $(document).trigger(changedEventId.join(''), [this.getSelectedPartNumbers()]);
    }




    function initLoading($container) {
        $container.addClass('disabled');
        $('.loading-container-js', $container)
            .addClass('loading-container')
            .html(this.templates.spinnerTemplateHTML);
    }

    function endLoading($container) {
        $container.removeClass('disabled');
        $('.loading-container-js', $container)
            .removeClass('loading-container')
            .html('');
    }


    window.smc.CompareProducts = CompareProducts;
})(window.smc);