(function (globalConfig) {
    var MAX_TIMEOUT_RETRIES = 3;

    function AccessoriesModal(config) {
        this.id = config.id;
        this.config = config;
        this.partNumber = config.partNumber;
        this.productId = config.productId;
    }

    AccessoriesModal.prototype.init = init;
    AccessoriesModal.prototype.initializeEvents = initializeEvents;
    AccessoriesModal.prototype.isModalAvailable = isModalAvailable;
    AccessoriesModal.prototype.showModal = showModal;
    AccessoriesModal.prototype.initLoading = initLoading;
    AccessoriesModal.prototype.endLoading = endLoading;
    AccessoriesModal.prototype.checkForEmptyContainer = checkForEmptyContainer;

    function init() {
        console.debug('[AccessoriesModal]', 'init id=', this.id);
        if (!this.config.container) {
            throw new Error('"Container" is required');
        }
        this.templates = {
            spinnerTemplateHTML: document.getElementById('spinner-template').innerHTML
        };
        this.links = {
            showModalLink: $('.show-accessory-modal', this.config.container)
        };
        this.initializeEvents();
    }

    function initializeEvents() {
        var _self = this;
        $('.show-accessory-modal', this.config.container).on('click', function () {
            _self.showModal();
        });
        _self.isModalAvailable();
    }

    function isModalAvailable() {
        console.debug("[AccessoryModal] isModalAvailable init");
        var _self = this;
        var data = {
            accessoryProductId : _self.productId,
            accessoryPartNumber : _self.partNumber
        };
        $.get(_self.config.urls.hasAccessoryDetail, data)
            .then(function (response) {
                if (response == true) {
                    $('.accessory-modal-container', _self.config.container).removeClass('hidden');
                    _self.checkForEmptyContainer();
                } else {
                    $('.accessory-modal-container', _self.config.container).addClass('hidden');
                }
            })
            .catch(function (error) {
                $('.accessory-modal-container', _self.config.container).addClass('hidden');
                console.log("[AccessoryModal] error", error);
            });
    }

    function showModal() {
        var _self = this;
        if ( $('.show-accessory-modal', this.config.container).attr("disabled") !== undefined) {
            console.log("already disabled");
            return;
        }
        $(".show-accessory-modal").attr("disabled", "disabled");
        console.debug("[AccessoryModal] showModal init", _self.config.container);
        $('.accessories-details-modal').remove();
        $("#accessoryModal_main_container").empty();
        this.initLoading(_self.links.showModalLink);
        var data = {
            accessoryProductId : _self.productId,
            accessoryPartNumber : _self.partNumber
        };
        $.get(_self.config.urls.getAccessoryDetail, data)
            .then(function (response) {
                console.debug("[AccessoryModal] showModal response");
                $("#accessoryModal_main_container").html(response);
                $("#_showAccessoryModal").modal('show');
                _self.endLoading(_self.links.showModalLink);
                $(".show-accessory-modal").removeAttr("disabled");
            })
            .catch(function (error) {
                console.log("[AccessoryModal] error", error);
                _self.endLoading(_self.links.showModalLink);
                $(".show-accessory-modal").removeAttr("disabled");
            });
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

    function checkForEmptyContainer() {
        var previousElement = this.config.container.prev();
        if (previousElement === undefined) {
            return;
        }
        if (previousElement.text() == "-" ) {
            previousElement.addClass("hidden");
        }
    }

    window.smc.AccessoriesModal = AccessoriesModal;
})(window.smc);
