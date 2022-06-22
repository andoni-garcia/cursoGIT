(function (globalKoUtils) {

    const STEP_NUMBER = 3;
    const STEP = 'step-' + STEP_NUMBER;

    function WssStep3ViewModel(params, nodes) {
        var self = this;

        // --- Repository
        self.REPOSITORY = new WizardSimpleSpecialRepository();

        self.loading = ko.observable(true);
        var parentVm = params.parentVm;
        parentVm.stepComponents[STEP] = this;

        // --- Repository
        self.REPOSITORY = new WizardSimpleSpecialRepository();

        var passed = false;

        parentVm.currentPage.subscribe(function(newValue) {
            if(newValue === STEP_NUMBER) {
                parentVm.minimunPage(STEP_NUMBER);
                parentVm.disableNext(true);
                parentVm.creatingNewFolder(false);
                parentVm.disableMove(true);
            } else {
                parentVm.creatingNewFolder(null);
            }
        });

        // Go next event from parentVm
        parentVm.goingNext.subscribe(function(newValue) {
            if(newValue && parentVm.currentPage() === STEP_NUMBER && !passed) {
                console.log('Going next');
                passed = true;

                let syImageData = valveConfigurationViewModel.getImageData();

                self.REPOSITORY.doSendToFavourites(parentVm.selectedFolderId(), syImageData).then(function(res){
                    parentVm.disableMove(false);
                    parentVm.goToNext();
                },function(e){

                });

            }
        });

        /**
         * Called from root viewmodel
         */
        self.defaults = function() {
            self.selectedFolderId = ko.observable(null);
            passed = false;
        }

        self.loading(false);

    }

    ko.components.register('smc-wss-step-3', {
        viewModel: {

            createViewModel: function (params, componentInfo) {
                return new WssStep3ViewModel(params, componentInfo.templateNodes);
            }

        },
        template: '<div data-bind="template: { nodes: $componentTemplateNodes }"></div>'
    });

})(window.koUtils)