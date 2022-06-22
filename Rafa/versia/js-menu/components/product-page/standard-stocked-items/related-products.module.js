(function(globalConfig) {

    function RelatedProducts(config) {
        this.selectedPartNumbers = [];
        this.config = config;
    }

    RelatedProducts.prototype.init = init;
    RelatedProducts.prototype.initializeEvents = initializeEvents;
    RelatedProducts.prototype.getSelectedPartNumbers = getSelectedPartNumbers;
    RelatedProducts.prototype.triggerPartNumberChangedEvent = triggerPartNumberChangedEvent;
    RelatedProducts.prototype.initAccessoryShowDetailsLinks = initAccessoryShowDetailsLinks;

    function init() {
        console.log('[RelatedProducts]', 'init');

        this.templates = {
            relatedProductItemTemplate: document.getElementById('relatedProductItemTemplate')
        };


        renderRelatedProduct.call(this, this.config.items);
        this.initializeEvents();
        $(document).trigger('smc.registercomponent', [this.id, this]);
    }

    function initializeEvents() {
        this.config.container.on('change', '.related-product-item-partnumber', onRelatedProductSelected.bind(this));

    }

    function onRelatedProductSelected(event) {
        var checkbox = event.target;

        if (checkbox.checked) {
            console.debug('[RelatedProducts]', 'Add_SpareAccessory_PartNumber', checkbox.value);
            this.selectedPartNumbers.push(checkbox.value);

            var addedEventId = ['smc.', this.config.id, '.addedPartNumber'];
            $(document).trigger(addedEventId.join(''), [checkbox.value]);

        } else {
            console.debug('[RelatedProducts]', 'Remove_SpareAccessory_PartNumber', checkbox.value);
            var index = this.selectedPartNumbers.indexOf(checkbox.value);
            if (index > -1) {
                this.selectedPartNumbers.splice(index, 1);
            }

            var removedEventId = ['smc.', this.config.id, '.removedPartNumber'];
            $(document).trigger(removedEventId.join(''), [checkbox.value]);
        }

        this.triggerPartNumberChangedEvent();
    }

    function getSelectedPartNumbers() {
        return this.selectedPartNumbers;
    }

    function getSpareAccessoryItemListHTML(itemList, renderItemsFunction) {
        return itemList.map(function (item, index) {
            return renderItemsFunction(item, index);
        });
    }



    function renderRelatedProduct(itemList) {
        var _self = this;
        var html = getSpareAccessoryItemListHTML(itemList, _generateRelatedProductItemHtml.bind(this));
        this.config.container.html(html);
        var isAcccessoryShowDetailsEnabled = $("#isAccessoryDetailsModalEnabled").val();
        if ("true" == isAcccessoryShowDetailsEnabled) {
            initAccessoryShowDetailsLinks(itemList, _initAccessoryShowDetailsLinks.bind(this));
        }
    }

    function triggerPartNumberChangedEvent() {
        var changedEventId = ['smc.', this.config.id, '.selectedPartNumberChanged'];
        $(document).trigger(changedEventId.join(''), [this.getSelectedPartNumbers()]);
    }



    function _generateRelatedProductItemHtml(data, index) {
        var template = this.templates.relatedProductItemTemplate.innerHTML;

        return template
            .replace(/{{index}}/g, index)
            .replace(/{{componentId}}/g, this.config.id)
            .replace(/{{partNumber}}/g, data.partNumber)
            .replace(/{{description}}/g, data.additionalInformation || data.description)
            .replace(/{{additionalInformation}}/g, data.additionalInformation)
            .replace(/{{imageUrl}}/g, data.imageUrl)
            .replace('{{withImage}}', data.imageUrl ? '' : 'hidden')
            .replace('{{withoutImage}}', data.imageUrl ? 'hidden' : '');
    }

    function initAccessoryShowDetailsLinks(itemList, renderItemsFunction) {
        return itemList.map(function (item, index) {
            renderItemsFunction(item, index);
        });
    }

    function _initAccessoryShowDetailsLinks(data, index) {
        var _self = this;
        var partNumber = data.partNumber;
        var showDetailsContainer = $('#accesoriesModal_' + _self.config.id + '_' + partNumber +'_' + index + '_ssi');
        var AccessoriesModal = window.smc.AccessoriesModal;
        var urls = {
            getAccessoryDetail: document.getElementById('getAccessoryDetailLink').href,
            hasAccessoryDetail: document.getElementById('hasAccessoryDetailLink').href
        };
        var config = {
            id: '' + 'accesoriesModal_' + this.config.id + '_ssi',
            container: showDetailsContainer,
            productId: 'accesoriesModal_' + _self.config.id + '_' + partNumber +'_' + index + '_ssi',
            partNumber: partNumber,
            renderMode: "from-ssi-series",
            urls : urls
        };
        var accessoriesModal = new AccessoriesModal(config);
        accessoriesModal.init();
    }

    window.smc.RelatedProducts = RelatedProducts;
})(window.smc);