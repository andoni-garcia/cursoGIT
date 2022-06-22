(function (globalKoUtils) {

    const STEP_NUMBER = 4;
    const STEP = 'step-' + STEP_NUMBER;

    function WssStep4ViewModel(params, nodes) {
        var self = this;

        // --- Repository
        self.REPOSITORY = new WizardSimpleSpecialRepository();

        self.loading = ko.observable(true);
        var parentVm = params.parentVm;
        parentVm.stepComponents[STEP] = this;

        self.configFiles = {};
        self.configFiles.haveSyf = parentVm.configFiles.haveSyf;
        self.configFiles.havePdf = parentVm.configFiles.havePdf;
        self.configFiles.haveXls = parentVm.configFiles.haveXls;
        self.configFiles.haveCad = parentVm.configFiles.haveCad;

        var checkNext = function() {
            if(self.configFiles.haveSyf() || self.configFiles.havePdf() || self.configFiles.haveXls() || self.configFiles.haveCad()) {
                parentVm.disableNext(false);
            } else {
                parentVm.disableNext(true);
            }
        }

        parentVm.currentPage.subscribe(function(newValue) {
            if(newValue === STEP_NUMBER) {
                parentVm.minimunPage(STEP_NUMBER);
                parentVm.disableMove(false);
                checkNext();
            }
        });

        ko.computed(function () {

            ko.toJS(self.configFiles.haveSyf());
            ko.toJS(self.configFiles.havePdf());
            ko.toJS(self.configFiles.haveXls());
            ko.toJS(self.configFiles.haveCad());

            checkNext();

            parentVm.configFiles.haveSyf = self.configFiles.haveSyf;
            parentVm.configFiles.havePdf = self.configFiles.havePdf;
            parentVm.configFiles.haveXls = self.configFiles.haveXls;
            parentVm.configFiles.haveCad = self.configFiles.haveCad;

        }).extend({
            notify: 'always'
        });

        self.loading(false);

    }

    ko.components.register('smc-wss-step-4', {
        viewModel: {

            createViewModel: function (params, componentInfo) {
                return new WssStep4ViewModel(params, componentInfo.templateNodes);
            }

        },
        template: '<div data-bind="template: { nodes: $componentTemplateNodes }"></div>'
    });

})(window.koUtils)