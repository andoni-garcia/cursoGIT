(function (globalKoUtils) {

    const STEP_NUMBER = 6;
    const STEP = 'step-' + STEP_NUMBER;

    function WssStep6ViewModel(params, nodes) {
        var self = this;

        // --- Repository
        self.REPOSITORY = new WizardSimpleSpecialRepository();

        self.loading = ko.observable(true);
        self.cadOptions = ko.observable([]);

        var parentVm = params.parentVm;
        parentVm.stepComponents[STEP] = this;

        parentVm.currentPage.subscribe(function(newValue) {
            if(newValue === STEP_NUMBER){
                //parentVm.disableNext(true);
                checkNext();
            }
        });

        self.loading(false);
        self.selectedCadOption = ko.observable(null);
        
        const checkNext = function() {
            if(self.selectedCadOption()) {
                parentVm.disableNext(false);
            } else {
                parentVm.disableNext(true);
            }
        }

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
            parentVm.selectedCadOption(value);
            checkNext();
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

        self.getCadOptions();
    }

    ko.components.register('smc-wss-step-6', {
        viewModel: {

            createViewModel: function (params, componentInfo) {
                return new WssStep6ViewModel(params, componentInfo.templateNodes);
            }

        },
        template: '<div data-bind="template: { nodes: $componentTemplateNodes }"></div>'
    });

})(window.koUtils)