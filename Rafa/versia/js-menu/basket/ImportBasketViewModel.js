function ImportBasketViewModel() {

    var self = this;

    const StepsEnum = {

        FILE: 0,
        COMPLETE: 1,
        SUMMARY: 2,
        LAST: 3

    };

    const ProductStatus = {

        OK: 'OK',
        ALIAS_NOT_MATCH: 'ALIAS_NOT_MATCH',
        EMPTY_PART_NUMBER: 'EMPTY_PART_NUMBER',
        ALREADY_EXISTS: 'ALREADY_EXISTS',
        ERROR: 'ERROR'

    };

    const BASKET_REPO = new BasketProductRepository();
    const modal = $('#modal-import-baskets');
    let fileInput = document.getElementById('importBasket');


    //Helpers
    const isValidImportFile = function (file) {
        try {
            if (!file || !file.name) return false;
            const validExtensions = ['xls', 'xlsx'];
            const fileParts = file.name.split('.');
            const extension = fileParts[fileParts.length - 1];

            return validExtensions.indexOf(extension) > -1;
        } catch (e) {
            return false;
        }
    };


    const readListOfProducts = function (products) {

        if (!products || typeof products !== typeof []) {
            return smc.NotifyComponent.error("Invalid server response");
        }

        _.each(products, function (prod) {


            if (!prod || !prod.status || prod.status === ProductStatus.ERROR) return;
            else if (prod.status === ProductStatus.EMPTY_PART_NUMBER) {
                let emptyProd = prod;
                emptyProd.valid = true;
                self.emptyPartNumberProducts(self.emptyPartNumberProducts().concat([emptyProd]));
            } else self.validatedProducts(self.validatedProducts().concat([prod]));

        });


    };

    const moveFromFileSelectorStep = function () {

        if (self.validatedProducts().length === 0 && self.emptyPartNumberProducts().length === 0) {
            modal.modal('hide');
            return smc.NotifyComponent.error("No hay productos validos en el fichero");
        } else if (self.emptyPartNumberProducts().length > 0) {
            self.currentPage(StepsEnum.COMPLETE);
            self.loading(false);
        } else {
            self.currentPage(StepsEnum.SUMMARY);
            self.loading(false);
        }


    };

    const checkNextToSummaryEnabled = function () {
        const size = self.emptyPartNumberProducts().length;
        for (var index = 0; index < size; index++) {
            var element = self.emptyPartNumberProducts()[index];
            if (element.status !== 'OK') {
                return false;
            }

        }
        return true;
    };

    const updateProductWithPartNumber = function (customerPartNumber, partNumber, status) {
        const size = self.emptyPartNumberProducts().length;
        for (var index = 0; index < size; index++) {
            var element = Object.assign({}, self.emptyPartNumberProducts()[index]);
            if (element.customerPartNumber === customerPartNumber) {

                element.partNumber = partNumber;
                element.status = status;
                element.valid = status === ProductStatus.OK;

                self.emptyPartNumberProducts.splice(index, 1, element);
                console.log("Updating", element, status);
                break;
            }

        }

    };


    const errorImport = function(e){
        self.errorOnImport(true);
        self.loading(false);
        self.currentPage(StepsEnum.LAST);
        console.error(e);
    };

    const endImport = function(products) {
        self.importedProducts(products.successBasketProducts);
        self.errorImportedProducts(products.errorBasketProducts);
        self.errorAliasImportedProducts(products.errorAliasBasketProducts);
        self.currentPage(StepsEnum.LAST);
        self.errorOnImport(false);
        self.loading(false);
        basketViewModel.getBasketData();
    }

    //Observables
    self.currentPage = ko.observable(StepsEnum.FILE);
    self.validatedProducts = ko.observableArray([]);
    self.loading = ko.observable(false);
    self.emptyPartNumberProducts = ko.observableArray([]);
    self.nextToSummaryEnabled = ko.observable(false);
    self.importedProducts = ko.observableArray([]);
    self.errorImportedProducts = ko.observableArray([]);
    self.errorAliasImportedProducts = ko.observableArray([]);
    self.errorOnImport = ko.observable(false);

    self.init = function () {

        self.currentPage(StepsEnum.FILE);
        self.loading(false);
        self.validatedProducts([]);
        self.emptyPartNumberProducts([]);
        self.nextToSummaryEnabled(false);
        self.importedProducts([]);
        self.errorImportedProducts([]);
        self.errorAliasImportedProducts([]);
        self.errorOnImport(false);
        //fileInput.value = ''; 
        
        modal.modal('show');
    
    };

    self.close = function(){
        modal.modal('hide');
    }

    self.nextPage = function () {
        if (self.currentPage() === StepsEnum.COMPLETE) {
            _.each(self.emptyPartNumberProducts(), function (prod) {
                if (prod.status === ProductStatus.OK) {
                    self.validatedProducts().push(prod);
                    self.currentPage(StepsEnum.SUMMARY);
                } 
            })
        }

    };

    self.checkAlias = function (data, e) {

        if (e.keyCode === 13) {
            e.target.blur();
        } else if (e.type === 'blur') {

            const partNumber = data.partNumber;
            const customerPartNumber = data.customerPartNumber;

            self.loading(true);
            return BASKET_REPO.doCheckAlias(partNumber, customerPartNumber)
                .then(function (res) {
                    self.loading(false);
                    updateProductWithPartNumber(customerPartNumber, partNumber, res);

                    self.nextToSummaryEnabled(checkNextToSummaryEnabled());
                    
                })
                .catch(errorImport);

        }
    };

    self.validateFile = function () {
        let file = document.getElementById('importBasket').files[0];
        document.getElementById('importForm').reset();

        if (!isValidImportFile(file)) {
            return smc.NotifyComponent.error(BASKET_MESSAGES.invalidFormatFile);
        }

        self.loading(true);
        BASKET_REPO.doImportFile(file)
            .then(readListOfProducts)
            .then(moveFromFileSelectorStep)
            .catch(errorImport)
    }

    self.removeProduct = function () {
        const data = this;

        self.emptyPartNumberProducts.remove(function (prod) {
            return prod.customerPartNumber === data.customerPartNumber;
        });

        self.nextToSummaryEnabled(checkNextToSummaryEnabled());

        if (self.nextToSummaryEnabled()) {
            self.currentPage(StepsEnum.SUMMARY);
        }

    }

    self.confirmProducs = function () {
        self.loading(true);
        
        const basketProducts = [];

        _.each(self.validatedProducts(), function(prod){
            if(prod.status === ProductStatus.OK) {
                basketProducts.push(new BasketPartnumberToAdd(prod.partNumber, prod.quantity, prod.customerPartNumber, {}));
            }
        });
        
        BASKET_REPO.doImportProducts(basketProducts)
            .then(endImport)
            .catch(errorImport)


    };

    self.itemNumber = function(index) {
        return index + 1;
    }

	self.doExportImportBasketTemplate = function() {
		$.ajaxHippo(
		    $.extend({
                url: exportImportBasketTemplateUrl,
			    method: 'POST',
			    dataType: 'json',
			    data: {}
		    })
		).then(
		    function(res){
                window.open(res);
            }
        ).catch(
            function(err){
                console.error(JSON.stringify(err))
                smc.NotifyComponent.error(BASKET_MESSAGES.labelExportError);
            }
        )
	}
}