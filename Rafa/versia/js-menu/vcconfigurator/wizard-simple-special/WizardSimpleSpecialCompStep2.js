(function (globalKoUtils) {

    const STEP_NUMBER = 2;
    const STEP = 'step-' + STEP_NUMBER;

    function WssStep2ViewModel(params, nodes) {
        var self = this;

        // --- Repository
        self.REPOSITORY = new WizardSimpleSpecialRepository();

        self.loading = ko.observable(true);
        self.loadingData = ko.observable(true);

        var parentVm = params.parentVm;

        self.error = ko.observable(null);
        self.simpleSpecial = ko.observable(null);
        self.simpleSpecialPartNumber = parentVm.simpleSpecialPartNumber;

        // Need to be a observable
        var simpleSpecial = parentVm.simpleSpecial;

        parentVm.currentPage.subscribe(function(newValue) {

            self.loadingData(true);

            // When current page in parent vm is this component
            if(newValue === STEP_NUMBER) {
                parentVm.minimunPage(STEP_NUMBER);

                // Disable next step
                parentVm.disableNext(true);

                let syImageData = valveConfigurationViewModel.getImageData();

                self.REPOSITORY.doCreateSimpleSpecial(parentVm.selectedCustomerNumber(), parentVm.selectedCustomerName(), self.simpleSpecialPartNumber(), syImageData).then(function(res){
                    self.loadingData(false);
                    if (res == null || res.response == null) {
                        parentVm.closeWizard();
                        smc.NotifyComponent && smc.NotifyComponent.error(createSSCreationErrorLabel);
                    } else {
                        let simpleSpecialData = new SimpleSpecialData(res.response.simpleSpecial, res.response.errorCode);
                        simpleSpecial(simpleSpecialData);
                        stateMachine.controllers.tabs.afterUndoRedo();
                        valveConfigurationViewModel.creatingProcess(false);
                        valveConfigurationViewModel.loadSimpleSpecial(true);
                        var element = document.getElementById("sendVcToFavourites");
                        element.setAttribute('data-configuration', 'valid');
                    }
                }, function() {
                    parentVm.closeWizard();
                    smc.NotifyComponent && smc.NotifyComponent.error(createSSCreationErrorLabel);
                }).always(function(){
                    parentVm.disableNext(false);
                    self.loadingData(false);
                });

            }
        });

        self.loading(false);

    }

    ko.components.register('smc-wss-step-2', {
        viewModel: {

            createViewModel: function (params, componentInfo) {
                return new WssStep2ViewModel(params, componentInfo.templateNodes);
            }

        },
        template: '<div data-bind="template: { nodes: $componentTemplateNodes }"></div>'
    });

})(window.koUtils)