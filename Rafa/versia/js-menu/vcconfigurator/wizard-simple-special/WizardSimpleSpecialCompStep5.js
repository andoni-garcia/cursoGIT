(function(globalKoUtils) {

	const STEP_NUMBER = 5;
	const STEP = 'step-' + STEP_NUMBER;

	function WssStep5ViewModel(params, nodes) {
		var self = this;

		// --- Repository
		self.REPOSITORY = new WizardSimpleSpecialRepository();

		self.loading = ko.observable(true);
		var parentVm = params.parentVm;
		console.log(parentVm);

		self.pdfConfig = {};

		self.pdfConfig.designerContact = parentVm.pdfConfig.designerContact;
		self.pdfConfig.customerContact = parentVm.pdfConfig.customerContact;
		self.pdfConfig.sellingPrice = parentVm.pdfConfig.sellingPrice;
		self.pdfConfig.listPrice = parentVm.pdfConfig.listPrice;
		self.pdfConfig.bom = parentVm.pdfConfig.bom;
		self.pdfConfig.leadTime = parentVm.pdfConfig.leadTime;
		self.pdfConfig.leadListPriceDetails = parentVm.pdfConfig.leadListPriceDetails;

		parentVm.currentPage.subscribe(function(newValue) {
			if (newValue === STEP_NUMBER) {
				parentVm.disableNext(false);
			}
		});

		ko.computed(function() {


		}).extend({
			notify : 'always'
		});

		self.loading(false);

	}

	ko.components
			.register(
					'smc-wss-step-5',
					{
						viewModel : {

							createViewModel : function(params, componentInfo) {
								return new WssStep5ViewModel(params,
										componentInfo.templateNodes);
							}

						},
						template : '<div data-bind="template: { nodes: $componentTemplateNodes }"></div>'
					});

})(window.koUtils)