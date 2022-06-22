function EshopDownloadCadsRepository() {
    var self = this;

    ko.di.require({
        jq: "jQuery"
    }, self);

    self.doGetCadOptions = function (callbacks) {

        return $.ajaxHippo($.extend({
            type: 'POST',
            url: eshopDownloadCadGetCadOptionsUrl,
            dataType: 'json',
            async: true
        }, callbacks));

    }

    self.doProcess = function(products, format, callbacks) {

        return $.ajaxHippo($.extend({
            type: 'POST',
            url: eshopDownloadProcessCadsUrl,
            data: { 
				products: JSON.stringify(products),
                format: format
			},
            dataType: 'json',
            async: true
        }, callbacks));

    }

}
