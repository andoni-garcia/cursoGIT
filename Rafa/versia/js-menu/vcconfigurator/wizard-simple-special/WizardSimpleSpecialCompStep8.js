(function (globalKoUtils) {

    const STEP_NUMBER = 8;
    const STEP = 'step-' + STEP_NUMBER;

    function WssStep8ViewModel(params, nodes) {
        var self = this;

        // --- Repository
        self.REPOSITORY = new WizardSimpleSpecialRepository();

        self.loading = ko.observable(true);
        var parentVm = params.parentVm;
        parentVm.stepComponents[STEP] = this;
        
        // Need to be a observable
        var simpleSpecial = parentVm.simpleSpecial;

        simpleSpecial.subscribe(function (newValue) {
            var innerText = $('#wss-step8-simplespecial-message').html();
            innerText = innerText.replace('{$0}', newValue.simpleSpecialCode());
            $('#wss-step8-simplespecial-message').html(innerText);
        });

        self.generatingZipFile = parentVm.generatingZipFile;
        self.noFile = parentVm.noFile;

        parentVm.disableNext(true);

        parentVm.currentPage.subscribe(function(newValue) {

            if(newValue === STEP_NUMBER) {

                let syImageData = valveConfigurationViewModel.getImageData();

                //doGenerateZip
                if(parentVm.noFile() == true) {
                    parentVm.generatingZipFile(false);
                    parentVm.disableNext(false);
                } else {

                    const cadOptions = {
                        selectedCadOption : parentVm.selectedCadOption(),
                        partNumber: parentVm.simpleSpecial().simpleSpecialCode()
                    }

                    self.REPOSITORY.doGenerateZip(parentVm.configFiles, parentVm.pdfConfig.getJsonObject(), cadOptions, syImageData).then(function(res) {
                        window.koDownloadUtils.generateDownloadOpen(res.response, true);
                    }, function(err) {
                        console.log(err);
                    }).always(function(){
                        parentVm.generatingZipFile(false);
                        parentVm.disableNext(false);
                    });

                }

            }
        });

        self.loading(false);

    }

    ko.components.register('smc-wss-step-8', {
        viewModel: {

            createViewModel: function (params, componentInfo) {
                return new WssStep8ViewModel(params, componentInfo.templateNodes);
            }

        },
        template: '<div data-bind="template: { nodes: $componentTemplateNodes }"></div>'
    });

})(window.koUtils)