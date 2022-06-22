(function(globalConfig) {

    function SparesAccessories(config) {
        this.selectedPartNumbers = [];
        this.config = config;
    }

    SparesAccessories.prototype.init = init;
    SparesAccessories.prototype.initializeEvents = initializeEvents;
    SparesAccessories.prototype.getSelectedPartNumbers = getSelectedPartNumbers;
    SparesAccessories.prototype.getItems = getItems;
    SparesAccessories.prototype.triggerPartNumberChangedEvent = triggerPartNumberChangedEvent;

    function init() {
        console.log('[SparesAccessories]', 'init');
        this.id = this.id || this.config.id;

        this.$resultsContainer = $('.spares-accessories-result-container', this.config.container);
        this.templates = {
            spareAccessoryItemTemplate: document.getElementById('spareAccessoryItemTemplate')
        };

        if (this.config.paginateResults) {
            this.paginationElementsConfig = {
                $paginationContainer: this.config.container,
                $resultContainer: $('.spares-accessories-result-container', this.config.container),
                $initialPageNumberContainer: $('.js-search-init-page-number', this.config.container),
                $finishPageNumberContainer: $('.js-search-finish-page-number', this.config.container),
                $totalResultsContainer: $('.js-search-total', this.config.container),
                renderItemsFunction: _generateSpareAccessoryItemHtml.bind(this),
                renderAccessoryItemsFunction: _initAccessoryShowDetailsLinks().bind(this)
            };

            activatePagination.call(this);
        } else {
            renderSpareAccessoryWithoutPagination.call(this, this.config.items);
        }

        this.initializeEvents();
        $(document).trigger('smc.registercomponent', [this.id, this]);
    }

    function initializeEvents() {
        this.config.container.on('change', '.spare-accessory-item-partnumber', onSpareAccessorySelected.bind(this));

        $('.changelen', this.config.container).click(function (event) {
            if (event) event.preventDefault();

            var linkItem = event.target;
            var pageSize = linkItem.dataset.pageSize;
            $('.changelen', this.config.container).removeClass('active');
            $(linkItem).addClass('active');
            this.config.pageSize = pageSize;
            activatePagination.call(this);

        }.bind(this));
    }

    function onSpareAccessorySelected(event) {
        var checkbox = event.target;

        if (checkbox.checked) {
            console.debug('[SparesAccessories]', 'Add_SpareAccessory_PartNumber', checkbox.value);
            this.selectedPartNumbers.push(checkbox.value);

            var addedEventId = ['smc.', this.config.id, '.addedPartNumber'];
            $(document).trigger(addedEventId.join(''), [checkbox.value]);

        } else {
            console.debug('[SparesAccessories]', 'Remove_SpareAccessory_PartNumber', checkbox.value);
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

    function getItems() {
        return this.config.items;
    }

    function getSpareAccessoryItemListHTML(itemList, renderItemsFunction) {
        return itemList.map(function (item, index) {
            return renderItemsFunction(item, index);
        });
    }

    function activatePagination() {
        var _self = this;
        var totalResults = (this.config.items && this.config.items.length) || 0;
        if (totalResults === 0 || !this.config.paginateResults) return;

        var paginationElementsConfig = this.paginationElementsConfig;
        paginationElementsConfig.$paginationContainer.pagination({
            dataSource: this.config.items,
            className: 'row justify-content-center',
            prevText: '<i class="icon-arrow-single-left" style="font-size: 14px;"></i>',
            nextText: '<i class="icon-arrow-single-right" style="font-size: 14px;"></i>',
            firstText: '<i class="icon-arrow-double-left"></i>',
            lastText: '<i class="icon-arrow-double-right"></i>',
            pageRange: 2,
            pageSize: this.config.pageSize || 10,
            callback: function (data, pagination) {
                var initNumber = (pagination.pageSize * (pagination.pageNumber - 1) + 1);
                paginationElementsConfig.$initialPageNumberContainer.text(initNumber);

                var lastRegisterNumber = data.length < pagination.pageSize ? ((pagination.pageSize * pagination.pageNumber) - pagination.pageSize + data.length) : pagination.pageSize * pagination.pageNumber;
                paginationElementsConfig.$finishPageNumberContainer.text(lastRegisterNumber);
                paginationElementsConfig.$totalResultsContainer.text(totalResults);

                var html = getSpareAccessoryItemListHTML(data, paginationElementsConfig.renderItemsFunction);
                paginationElementsConfig.$resultContainer.html(html);
                initAccessoryShowDetailsLinks(data, paginationElementsConfig.renderAccessoryItemsFunction);

            }
        });

        paginationElementsConfig.$paginationContainer.addHook('beforePaging', _beforePaging.bind(this));
    }

    function renderSpareAccessoryWithoutPagination(itemList) {
        var html = getSpareAccessoryItemListHTML(itemList, _generateSpareAccessoryItemHtml.bind(this));
        this.$resultsContainer.html(html);
        var isAcccessoryShowDetailsEnabled = $("#isAccessoryDetailsModalEnabled").val();
        if ("true" == isAcccessoryShowDetailsEnabled) {
            initAccessoryShowDetailsLinks(itemList, _initAccessoryShowDetailsLinks.bind(this));
        }
    }

    function triggerPartNumberChangedEvent() {
        var changedEventId = ['smc.', this.config.id, '.selectedPartNumberChanged'];
        $(document).trigger(changedEventId.join(''), [this.getSelectedPartNumbers()]);
    }

    function _beforePaging(page) {
        this.selectedPartNumbers = [];
        this.triggerPartNumberChangedEvent();
    }

    function _generateSpareAccessoryItemHtml(data, index) {
        var template = this.templates.spareAccessoryItemTemplate.innerHTML;

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
        itemList.map(function (item, index) {
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

    window.smc.SparesAccessories = SparesAccessories;
})(window.smc);