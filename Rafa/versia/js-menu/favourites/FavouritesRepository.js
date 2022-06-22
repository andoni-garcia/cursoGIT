function FavouritesRepository(){
	var self = this;

	ko.di.register(self,"FavouritesRepository");
	ko.di.require({jq : "jQuery"},self);

	//DELETE PRODUCT
	self.doDelete = function(elements,callbacks){
		var elemIds;
		if ($.isArray(elements)){
			//TODO: Send array not string joined by comma
			elemIds = elements.map(function(object) { return object.checkboxId; }).join(',');
		} else {
			elemIds = elements.favouriteId;
		}
		$.ajaxHippo($.extend({
			type : "POST",
			url : favouritesDeleteUrl,
			async : true,
			data : {ids: elemIds}
		},callbacks));
	};

	/**
	 * Copy or move favourites from folder to other one
	 */
	self.doMoveOrCopyFavourites = function(elements, srcFolderId, dstFolderId, isCopy, callbacks) {

		var requestUrl = favouritesMoveUrl;
		if(isCopy) {
			requestUrl = favouritesCopyUrl;
		}

		var elemIds;
		if ($.isArray(elements)){
			elemIds = convertComplexArrayToSimpleArray(elements, 'checkboxId');
		} else {
			elemIds = elements.favouriteId;
		}

		return $.ajaxHippo($.extend({
			type : 'POST',
			url : requestUrl,
			dataType : 'json',
			data: { 
				ids: JSON.stringify(elemIds),
				srcId: srcFolderId,
				dstId: dstFolderId
			},
			async : true,
		},callbacks));

	}

	self.doUpdateCustomerPartNumber = function(favId, customerPartNumber){
		let deferred = $.Deferred();

        return $.ajaxHippo({
            method: 'POST',
            url: updateCustomerPartNumber,
            async: true,
            data: {
				id: favId,
				customerPartNumber: customerPartNumber
            },
            success: function (res) {
                return deferred.resolve(res);
            },
            error: function (err) {
                return deferred.reject(err);
            },
        });
	}
	
	self.doExportFavourites = function(favouritesIds, type) {
		return $.ajaxHippo($.extend({
            url: exportFavouritesUrl,
			method: 'POST',
			dataType: 'json',
			data: {
				source: '',
				ids: JSON.stringify(favouritesIds),
				type: type
			}
		}));

	}

	self.doImportFile = function(file, dstId) {

        let formData = new FormData();

        formData.append("importFile", file);
        
        let opts = {
            url: importFileUrl + "&dstId="+dstId,
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

}
