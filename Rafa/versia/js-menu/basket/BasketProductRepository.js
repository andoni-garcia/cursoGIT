function BasketProductRepository() {
	var self = this;

	ko.di.register(self, 'BasketProductRepository');
	ko.di.require({
		viewModel: 'BasketViewModel',
		jq: 'jQuery',
		CONFIGURATION: 'ConfigurationVariables'
	}, self);

	self.processing = ko.observable(false);

	/**
	 * 
	 * Add a product to basket
	 * 
	 * @param pn        partnumbercode of product to add
	 * @param qty       quantity of products
	 * @param callbacks ajax callback functions (success, error ...)
	 * 
	 */
	self.doAddToBasket = function (basketPartnumbers, sourceParam, callbacks) {

		if (!($.isArray(basketPartnumbers))){
			basketPartnumbers = [basketPartnumbers];
		}

		return $.ajaxHippo($.extend({
			type: 'POST',
			url: addBasketProductUrl,
			dataType: 'json',
			data: {
				ids: JSON.stringify(basketPartnumbers),
				source: sourceParam
			},
			async: true
		}, callbacks));
	}

	/**
	 * 
	 * Adds partnumberCodes to specific favourites folder
	 * 
	 * @param partnumberCodes    list of the partnumbers to add
	 * @param destinationFolder  favourites folder destination Id
	 * @param callbacks          ajax callback functions (success, error ...)
	 * 
	 */
	self.doAddToFavourite = function (partnumbersCodes, destinationFolder, sourceParam, callbacks) {

		return $.ajaxHippo($.extend({
			type: 'POST',
			url: addToFavouriteBasketProduct,
			dataType: 'json',
			data: {
				ids: JSON.stringify(partnumbersCodes),
				dstId: destinationFolder,
				source: sourceParam
			}
		}, callbacks));

	}

	/**
	 * 
	 * Get list of products
	 * 
	 * @param callbacks ajax callback functions (success, error ...)
	 * 
	 */
	self.doGetBasketData = function (order, callbacks) {

		return $.ajaxHippo($.extend({
			type: 'POST',
			url: getBasketProductsUrl,
			dataType: 'json',
			data: {
				productsOrderField: order.field,
				productsOrderType: order.orderType
			},
			async: true
		}, callbacks));

	}

	/**
	 * 
	 * Updates quantity of specific product
	 * 
	 * @param bpId       Product to update quantity
	 * @param bpQty      Quantity to update
	 * @param callbacks  ajax callback functions (success, error ...)
	 * 
	 */
	self.doUpdateBasketQuantity = function (bpId, bpQty, callbacks) {

		return $.ajaxHippo($.extend({
			type: 'POST',
			url: updateBasketQuantityUrl,
			dataType: 'json',
			data: {
				id: bpId,
				qty: bpQty
			},
			async: true
		}, callbacks));

	}

	/**
	 * 
	 * Delete list of products
	 * 
	 * @param ids       Need to receive Array of elements
	 * @param callbacks ajax callback functions (success, error ...)
	 * 
	 */
	self.doDeleteBasket = function (ids, sourceParam, disableLogParam, callbacks) {

		return $.ajaxHippo($.extend({
			type: 'POST',
			url: deleteBasketProductUrl,
			dataType: 'json',
			data: {
				ids: JSON.stringify(ids),
				source: sourceParam,
				disableLog: disableLogParam
			},
			async: true
		}, callbacks));

	}
 
	/**
	 * 
	 * Search's partial text for professional users
	 * 
	 * @param partialSearch  partial text for search
	 * @param callbacks      ajax callback functions (success, error ...)
	 * 
	 */
	self.doPartnumbersMatching = function (partialSearch, callbacks) {

		return $.ajaxHippo($.extend({
			type: 'GET',
			url: getMatchingPartnumbers,
			dataType: 'json',
			data: {
				search: partialSearch,
				noRedirect: true
			},
			async: true
		}, callbacks));

	}

	/**
	 * Update's delivery date for specific product
	 * Derived from order view
	 */
	self.doSetPreferredDeliveryDate = function (productId, preferredDate, callbacks) {

		return $.ajaxHippo($.extend({
			type: 'POST',
			url: orderSetPreferredDeliveryDateUrl,
			dataType: 'json',
			data: {
				id: productId,
				preferredDeliveryDate: preferredDate
			},
			async: true
		}, callbacks));

	}

	self.doGetPartnumberDetails = function(partnumber, cb) {
		$.ajaxHippo($.extend(
            {
                url: partnumberDetailsUrl + '&partnumber=' + partnumber,
                method: 'POST',
            },
            cb
        ));
	}

	/**
	 * Check's if alias exists
	 */
	self.doGetCustomerPartnumber = function(partnumberCode, callbacks) {

		return $.ajaxHippo($.extend({
            url: getAliasBasketUrl,
			method: 'POST',
			dataType: 'json',
			data: {
				partnumber: partnumberCode
			}
		}, callbacks));

	}

	/**
	 * Asociate alias to partnumber
	 */
	self.doAddCustomerPartnumberToProduct = function(customerPartnumber, basketProductId, callbacks) {

		return $.ajaxHippo($.extend({
            url: addAliasToProductBasketUrl,
			method: 'POST',
			dataType: 'json',
			data: {
				alias: customerPartnumber,
				productId: basketProductId
			}
		}, callbacks));

	}

	self.doAddCustomerPartnumber = function(customerPartnumber, partnumberCode, callbacks) {

		return $.ajaxHippo($.extend({
            url: addAliasBasketUrl,
			method: 'POST',
			dataType: 'json',
			data: {
				alias: customerPartnumber,
				partnumber: partnumberCode
			}
		}, callbacks));

	}

	/**
	 * Checks if partnumber exists
	 */
	self.doIsPartnumberExists = function(partnumberCode, callbacks) {

		return $.ajaxHippo($.extend({
            url: isPartnumberExistsUrl,
			method: 'POST',
			dataType: 'json',
			data: {
				partnumber: partnumberCode
			}
		}, callbacks));

	}

	self.doIsAliasExists = function(aliasCode, callbacks) {

		return $.ajaxHippo($.extend({
            url: isAliasExistsUrl,
			method: 'POST',
			dataType: 'json',
			data: {
				alias: aliasCode
			}
		}, callbacks));

	}

	self.doUpdatePartnumbers = function(partnumberCodes, callbacks) {

		return $.ajaxHippo($.extend({
			type: 'POST',
			url: updatePartnumbersUrl,
			dataType: 'json',
			data: {
				partnumbers: JSON.stringify(partnumberCodes)
			}
		}, callbacks));

	}

	self.doSaveBasket = function(description, comments, callback) {
		return $.ajaxHippo($.extend({
			url: saveBasketUrl,
			method: 'POST',
			dataType: 'json',
			data: {
				comments: comments,
				description: description,
			},
		}, callback));
	}

	self.doAskToSmc = function(listOfItems, generalMsg, callbacks) {

		return $.ajaxHippo($.extend({
            url: askToSmcUrl,
			method: 'POST',
			dataType: 'json',
			data: {
				askSmcMessageItems: JSON.stringify(listOfItems),
				askSmcMessage: generalMsg
			}
		}, callbacks));

	}

	self.doGoToBasketLog = function(sourceParam, callbacks) {
		return $.ajaxHippo($.extend({
            url: goToBasketLogUrl,
			method: 'POST',
			dataType: 'json',
			data: {
				source: sourceParam
			}
		}, callbacks));

	}
	
	self.doExportBasket = function(selected, format, type) {
		return $.ajaxHippo($.extend({
            url: exportBasketUrl,
			method: 'POST',
			dataType: 'json',
			data: {
				ids: JSON.stringify(selected),
				type: type,
				format: format
			}
		}));

	}

	self.doImportFile = function(file) {

        let formData = new FormData();

        formData.append("importFile", file);
        
        let opts = {
            url: importFileUrl,
            type: 'POST',
            data: formData,
            cache: false,
            contentType: false,
            processData: false,
            method: 'POST'
        };

        if(formData.fake) {
            // Make sure no text encoding stuff is done by xhr
            opts.xhr = function() { var xhr = jQuery.ajaxSettings.xhr(); xhr.send = xhr.sendAsBinary; return xhr; }
            opts.contentType = "multipart/form-data; boundary="+formData.boundary;
            opts.data = formData.toString();
        } 

        return $.ajaxHippo(opts);
	}

	self.doLoadContacts = function() {
		return $.ajaxHippo($.extend({
            url: loadContactsUrl,
			method: 'POST',
			dataType: 'json',
		}));

	}
	
	self.doSendBasket = function(basket_id, friendId, description, comments) {
		return $.ajaxHippo($.extend({
            url: sendBasketUrl,
			method: 'POST',
			dataType: 'json',
			data: {
				basket_id: basket_id,
				friendId: friendId,
				description: description,
				comments: comments

			}
		}));

	}

	self.doGenerateSaparibaXml = function() {
		return $.ajaxHippo($.extend({
            url: generateSaparibaUrl,
			method: 'POST',
			dataType: 'json'
		}));
	}

	self.doCheckAlias = function(partNumber, customerPartnumber) {
		return $.ajaxHippo($.extend({
            url: checkAliasUrl,
			method: 'POST',
			dataType: 'json',
			data: {
				partNumber: partNumber,
				customerPartNumber: customerPartnumber
			}
		}));
	}

	self.doImportProducts = function (basketPartnumbers, callbacks) {

		if (!($.isArray(basketPartnumbers))){
			basketPartnumbers = [basketPartnumbers];
		}

		return $.ajaxHippo($.extend({
			type: 'POST',
			url: importProductsUrl,
			dataType: 'json',
			data: {
				ids: JSON.stringify(basketPartnumbers)
			},
			async: true
		}, callbacks));
	}

	self.doUpdateSentDatalayer = function(productId) {
		return $.ajaxHippo($.extend({
            url: updateSentDatalayerUrl,
			method: 'POST',
			dataType: 'json',
			data: {
				id: productId
			}
		}));
	}
}
