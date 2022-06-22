function SsiRepository() {
    var self = this;

    ko.di.register(self, 'SsiRepository');
    ko.di.require({ jq: 'jQuery' }, self);

    self.addToBasket = function(products, callback){
        return $.ajaxHippo($.extend({
            type: 'POST',
            url: addBasketProductUrl,
            async: true,
            data: {
                ids: JSON.stringify(array)
            }
        }));
    }

    self.getFamilies = function (subfamilyId, callback) {
        $.ajaxHippo($.extend(
            {
                url: ssiFamiliesListUrl + '&family=' + subfamilyId,
                method: 'POST'
            },
            callback
        ));
    }

    self.doExportSsi = function(products, type) {
		return $.ajaxHippo($.extend({
            url: ssiExportUrl,
			method: 'POST',
			dataType: 'json',
			data: {
                products: JSON.stringify(products),
                type: type
			}
		}));

	}
}