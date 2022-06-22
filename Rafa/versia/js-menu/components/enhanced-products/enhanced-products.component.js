(function(globalConfig) {
    function EnhancedProducts(config) {
        this.id = config.id;
        this.config = config;

        this.filter = '';
    }

    EnhancedProducts.prototype.init = init;
    EnhancedProducts.prototype.prepareStatus = prepareStatus;
    EnhancedProducts.prototype.initializeEvents = initializeEvents;
    EnhancedProducts.prototype.getFamilies = getFamilies;
    EnhancedProducts.prototype.getSeries = getSeries;
    EnhancedProducts.prototype.getProducts = getProducts;
    EnhancedProducts.prototype.updateModel = updateModel;
    EnhancedProducts.prototype.updateStatus = updateStatus;

    function init() {
        console.debug('[EnhancedProducts]', 'init id=', this.id);
        if (!this.config.container) {
            throw new Error('"Container" is required');
        }
        
        this.$filterInput = $('#filter', this.config.container);
        this.$productItems = $('.product-item-js', this.config.container);
        this.$emptyResultsContainer = $('.empty-results', this.config.container);

        this.prepareStatus();
        this.updateModel();
        this.initializeEvents();
        $(document).trigger('smc.registercomponent', [this.id, this]);
    }

    function prepareStatus() {
        this.$filterInput.text('');
    }

    function initializeEvents() {
        this.$filterInput.on('keyup paste change', _onFilterInputChange.bind(this));
    }

    function getFamilies() {
        return this.config.familiesList;
    }

    function getSeries() {
        return this.config.seriesList;
    }

    function getProducts() {
        return this.config.productList;
    }

    function updateModel() {
        var series = this.getSeries();
        var products = this.getProducts();

        for (var productId in products) {
            var product = products[productId];
            var productSerie = series[product.seriesName];

            if (this.filter) {
                var match = false;

                if (!match && product) match = product.name.toLowerCase().indexOf(this.filter) > -1;
                if (!match && productSerie) match = productSerie.name.toLowerCase().indexOf(this.filter) > -1;

                product.active = match;

            } else {
                product.active = true;
            }
        }

        this.updateStatus();
    }
    
    function updateStatus() {
        _updateProductGrid.call(this);
    }

    //-----------
    function _updateProductGrid() {
        var products = this.getProducts();

        this.$productItems.each(function (i, productItem) {
            var $productItem = $(productItem);
            var productId = $productItem.data('id');
            if (productId && products[productId] && products[productId].active) {
                $productItem.removeClass('hidden')

            } else {
                $productItem.addClass('hidden');
            }
        });

        //Check empty result
        var isAnyProductActive = false;
        for (var productId in products) {
            if (!isAnyProductActive && products[productId].active) {
                isAnyProductActive = true;
            }
        }

        if (!isAnyProductActive) {
            //Show empty results message
            this.$emptyResultsContainer.show();
        } else {
            this.$emptyResultsContainer.hide();
        }
    }

    function _onFilterInputChange(event) {
        if (event) event.preventDefault();
        this.filter = event.target.value;
        this.filter = this.filter && this.filter.toLowerCase();
        this.updateModel();
    }

    window.smc.EnhancedProducts = EnhancedProducts;
})(window.smc);