(function (globalKoUtils) {

    const STEP_NUMBER = 7;
    const STEP = 'step-' + STEP_NUMBER;

    function WssStep7ViewModel(params, nodes) {
        var self = this;

        // --- Repository
        self.REPOSITORY = new WizardSimpleSpecialRepository();
 
        self.loading = ko.observable(true);
        var parentVm = params.parentVm;
        parentVm.stepComponents[STEP] = this;

        parentVm.currentPage.subscribe(function(newValue) {
            
        });

        self.loading(false);

    }

    ko.components.register('smc-wss-step-7', {
        viewModel: {

            createViewModel: function (params, componentInfo) {
                return new WssStep7ViewModel(params, componentInfo.templateNodes);
            }

        },
        template: '<div data-bind="template: { nodes: $componentTemplateNodes }"></div>'
    });

})(window.koUtils)