function OrderRepository() {
    var self = this;

    ko.di.register(self, "OrderRepository");
    ko.di.require({
        jq: "jQuery"
    }, self);

    self.doGetDeliveryAddresses = function (callbacks) {

        return $.ajaxHippo($.extend({
            type: 'POST',
            url: orderDeliveryAddressesServerUrl,
            dataType: 'json',
            async: true,
        }, callbacks));

    }

    self.doSetDeliveryAddress = function (addressId, callbacks) {

        return $.ajaxHippo($.extend({
            type: 'POST',
            url: orderSetDeliveryAddressServerUrl,
            dataType: 'json',
            data: {
                id: addressId
            },
            async: true
        }, callbacks));

    }

    self.doCheckCustomerOrderNumber = function(customerOrderNumber, callbacks) {

        return $.ajaxHippo($.extend({
            type: 'POST',
            url: orderCheckCustomerOrderNumberServerUrl,
            dataType: 'json',
            data: {
                customerOrderNumber: customerOrderNumber
            },
            async: true
        }, callbacks));

    }

    self.doConfirmOrder = function(customerOrderNumber, additionalComments, callbacks) {

        return $.ajaxHippo($.extend({
            type: 'POST',
            url: orderConfirmServerUrl,
            dataType: 'json',
            data: {
                customerOrderNumber: customerOrderNumber,
                comments: additionalComments
            },
            async: true
        }, callbacks));

    }

    self.doSetAllPreferredDeliveryDate = function (preferredDate, callbacks) {

		return $.ajaxHippo($.extend({
			type: 'POST',
			url: orderSetAllPreferredDeliveryDateUrl,
			dataType: 'json',
			data: {
				preferredDeliveryDate: preferredDate
			},
			async: true,
		}, callbacks));

	}

}