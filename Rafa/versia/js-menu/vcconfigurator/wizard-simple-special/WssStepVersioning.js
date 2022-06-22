(function (globalKoUtils) {

    function WssStepVersioningViewModel(params, nodes) {

        const SS_TYPE_NEW = "new";
        const SS_TYPE_EXISTING = "existing";

        var self = this;

        var rootVm = params.rootVm;
        var parentVm = params.parentVm;
        rootVm.stepComponents["Versioning"] = this;

        // --- Repository
        self.REPOSITORY = new WizardSimpleSpecialRepository();

        self.loading = ko.observable(true);

        self.ssType = ko.observable("new");
        self.existingValid = ko.observable(false);
        self.simpleSpecialPartnumber = ko.observable('');
        self.simpleSpecialPartnumberVersion = ko.observable('');

        console.log(rootVm);
        console.log(parentVm);

        self.getNewSimpleSpecial = function() {
            if(self.simpleSpecialPartnumber() !== '') {
                self.REPOSITORY.doGetVersioning(self.simpleSpecialPartnumber(), rootVm.selectedCustomerNumber()).then(function(res){
                    if(res !== null) {
                        self.simpleSpecialPartnumberVersion(res);
                        rootVm.simpleSpecialPartNumber(res);
                        self.existingValid(true);
                        parentVm.validation();
                    } else {
                        smc.NotifyComponent.error(SS_VERSIONING_MESSAGES.errorVersioning);
                    }
                }, function(err){
                    smc.NotifyComponent.error(SS_VERSIONING_MESSAGES.errorVersioning);
                });
            } else {
                // Mandatory field
                smc.NotifyComponent.error(SS_VERSIONING_MESSAGES.errorVersioningEmpty);
            }
        }

        self.validation = function() {
            return self.ssType() === SS_TYPE_EXISTING && self.existingValid() === false;
        }

        parentVm.versioningChildComponent = this;
        parentVm.validation();

        /**
         * Called from root viewmodel
         */
        self.defaults = function() {
            self.loadingData(false);
        }

        self.ssType.subscribe(function(newValue) {
            parentVm.validation();
        });

        self.loading(false);

    }

    ko.components.register('smc-wss-versioning', {
        viewModel: {

            createViewModel: function(params, componentInfo) {
                return new WssStepVersioningViewModel(params, componentInfo.templateNodes);
            }

        },
        template: '<div data-bind="template: { nodes: $componentTemplateNodes }"></div>'
    });

})(window.koUtils)