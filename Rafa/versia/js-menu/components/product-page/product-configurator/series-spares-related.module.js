(function (globalConfig) {

    function SeriesRelatedProducts(config) {
        this.selectedPartNumbers = [];
        this.config = config;
    }

    SeriesRelatedProducts.prototype.init = init;
    SeriesRelatedProducts.prototype.initializeEvents = initializeEvents;
    SeriesRelatedProducts.prototype.getSelectedPartNumbers = getSelectedPartNumbers;
    SeriesRelatedProducts.prototype.triggerPartNumberChangedEvent = triggerPartNumberChangedEvent;
    SeriesRelatedProducts.prototype.updateStatus = updateStatus;

    function init() {
        console.log('[SeriesRelatedProducts]', 'init');
        this.$selectAllCheckBox = $('#selectAll_' + this.id, this.config.container);

        this.initializeEvents();
        // $(document).trigger('smc.registercomponent', [this.id, this]);
    }

    function initializeEvents() {
        this.config.container.on('change', '.series-related-product-partnumber', onRelatedProductSelected.bind(this));
        $('.group-filter').on('click', filterByGroup.bind(this));

    }


    function filterByGroup(event) {
        event.preventDefault();
        var $thisButton = $(event.currentTarget);
        console.log("[filterByGroup] init",this.config.containerId,$("#"+this.config.containerId.id+" .group-filter"));
        var group = $thisButton.data('group');
        if ($thisButton.attr("aria-selected") === "true") {
            return;
        }
        var $buttons =  $(".group-filter", this.config.containerId);
        console.log("[filterByGroup] buttons",$buttons);
        if ($("#free_configuration").is(":visible") && $("#free_configuration").hasClass("active")){
            if ($("#sscw_spares-accessories-result-container") !== undefined && $("#sscw_spares-accessories-result-container").length > 0){
                $buttons = $(".group-filter", $("#sscw_spares-accessories-result-container"));
            }else {
                $buttons = $(".group-filter", $("#free_configuration_spares_tab"));
            }
        }
        $buttons.attr("aria-selected","false");
        $thisButton.attr("aria-selected","true");
        if ($("#free_configuration").is(":visible") && $("#free_configuration").hasClass("active")){
            $(".spare-accessory-item", $("#free_configuration_spares_container")).hide();
            $(".spare-accessory-item", $("#sscw_spares-accessories-result-container")).hide();
            $(this.config.seriesAccessoryClass + group, $("#free_configuration_spares_container")).fadeIn();
            $(this.config.seriesAccessoryClass + group, $("#sscw_spares-accessories-result-container")).fadeIn();
        }else {
            $(".spare-accessory-item", this.config.containerId).hide();
            $(".spare-accessory-item", $("#sscw_spares-accessories-result-container")).hide();
            $(this.config.seriesAccessoryClass + group, this.config.containerId).fadeIn();
        }
    }

    function onRelatedProductSelected(event) {
        var checkbox = event.target;

        if (checkbox.checked) {
            console.debug('[SeriesRelatedProducts]', 'Add_SpareAccessory_PartNumber', checkbox.value);
            this.selectedPartNumbers.push(checkbox.value);

            var addedEventId = ['smc.', this.config.id, '.addedPartNumber'];
            $(document).trigger(addedEventId.join(''), [checkbox.value]);

        } else {
            console.debug('[SeriesRelatedProducts]', 'Remove_SpareAccessory_PartNumber', checkbox.value);
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


    function triggerPartNumberChangedEvent() {
        var changedEventId = ['smc.', this.config.id, '.selectedPartNumberChanged'];
        $(document).trigger(changedEventId.join(''), [this.getSelectedPartNumbers()]);
    }


    function updateStatus() {
        _updateButtonStatus.call(this);
        $(document).trigger('smc.sparesRelated.statusChanged');
    }

    function _updateButtonStatus() {
        var size = this.ssiComparePartNumbers.length;

        if (this.config.isEtechEnabled && size > 0) {
            this.$compareNumber.removeClass('hidden');
        } else {
            this.$compareNumber.addClass('hidden');
        }

        this.$compareNumber.html(size);

        if (this.config.isEtechEnabled && size > 1 && size < 4) {
            this.$buttonCompareProducts.removeClass('disabled');
            this.$buttonCompareProducts.prop("disabled", false);
        } else {
            this.$buttonCompareProducts.addClass('disabled');
            this.$buttonCompareProducts.prop("disabled", true);
        }
    }

    window.smc.SeriesRelatedProducts = SeriesRelatedProducts;
})(window.smc);