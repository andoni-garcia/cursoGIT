ko.components.register('smc.eshop.download-cads', {

    viewModel: function (params) {

        var self = this;

        self.modalId = '#eshop-download-cads-modal';

        self.REPOSITORY = new EshopDownloadCadsRepository();
        self.INTERVAL = 200;
        self.internalInterval;

        self.selectedPartnumbers = params.partnumbers;

        self.processing = ko.observable(false);

        self.loading = ko.observable(true);
        self.cadOptions = ko.observable([]);

        self.loading(false);
        self.selectedCadOption = ko.observable(null);
        
        const getSelectedCadType = function getSelectedCadType(){
            const radios = document.getElementsByName('cad');
            var selectedRadio = null;

            for (var i = 0, length = radios.length; i < length; i++){
                if (radios[i].checked) {
                    selectedRadio = radios[i].value;
                    break;
                }
            }
            return selectedRadio;
        }

        self.changeCadOption = function changeCadOption(value) {
            self.selectedCadOption(value);
        }

        self.getCadOptions = function getCadOptions(){
            self.REPOSITORY.doGetCadOptions()
                .then(function(opts){
                    let parsedOptions = [];
                    console.log(opts)
                    for (var property in opts) {
                        if (opts.hasOwnProperty(property)) {
                            var group = {};
                            group.name = (property === 'type2d' ? type2DTitleLabel : type3DTitleLabel);
                            group.options = opts[property];
                            parsedOptions.push(group);
                        }
                    }

                    self.cadOptions(parsedOptions);
                });
        }

        self.process = function() {

            var selectedCadType = getSelectedCadType();
            console.log(selectedCadType);

            self.internalInterval = setInterval(function () {
                // Check if no updating partnumbers
                var noUpdatingPartnumbers = allAreUpdated();
                
                if(noUpdatingPartnumbers) {

                    stopInterval();
                    self.processing(true);

                    self.REPOSITORY.doProcess(extractInfo(self.selectedPartnumbers()), selectedCadType)
                    .then(function(resp) {
    
                        // Confirm alert
                        smc.NotifyComponent.info(ESHOP_DOWNLOAD_CADS_MESSAGES.requestProcessed);
    
                    }, function() {
    
                        // Error alert
                        smc.NotifyComponent.error(ESHOP_DOWNLOAD_CADS_MESSAGES.requestError);
    
                    }).always(function() {
                        // On process complete
                        self.processing(false);
                    });

                    $(self.modalId).modal('hide');

                }
            
            }, self.INTERVAL);

        }

        self.open = function open() {

            if(self.processing()) {
                return;
            }

            if(!allAreUpdated()) {
                smc.NotifyComponent.warn(ESHOP_DOWNLOAD_CADS_MESSAGES.productsNotUpdated);
                return;
            }

            if(self.selectedPartnumbers().length == 0) {
                smc.NotifyComponent.error(BASKET_MESSAGES.nothingSelected);
                return;
            }

            if(eshopDownloadCadMaxNumberOfProducts && self.selectedPartnumbers().length > eshopDownloadCadMaxNumberOfProducts) {
                var message = ESHOP_DOWNLOAD_CADS_MESSAGES.reachMaxProducts.replace("{0}", eshopDownloadCadMaxNumberOfProducts);
                smc.NotifyComponent.error(message);
                return;
            }

            setUpAndShowModal();
            self.getCadOptions();

        }

        self.closeModal = function() {

            stopInterval();
            $(self.modalId).modal('hide');

        }

        const extractInfo = function(objects) {

            var listParsed = [];
            objects.forEach(function (element) {
                var parsed = {
                    partnumber: element.partnumber(),
                    productId: element.productId()
                }
                listParsed.push(parsed);
            });
            return listParsed;

        }

        const allAreUpdated = function() {

            var areUpdated = true;
            self.selectedPartnumbers().forEach(function(element) {
                areUpdated &&= element.status() === "UPDATED" || element.status() === "ERROR";
            });
            
            return areUpdated;

        }

        const setUpAndShowModal = function() {

            $(self.modalId).modal({
                show: true,
                backdrop: 'static',
                keyboard: false
            });

            $(self.modalId).on('hidden.bs.modal', function () {
                stopInterval();
                $(self.modalId).modal('hide');
            });
        }

        const stopInterval = function() {
            if(typeof self.internalInterval !== 'undefined') {
                clearInterval(self.internalInterval);
            }
        }

    },

    template: '<div data-bind="template: { nodes: $componentTemplateNodes }"></div>'
});