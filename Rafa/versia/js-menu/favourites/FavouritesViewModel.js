var partnumberOrder = {
    text: orderByPartNumber,
    value: 'partnumberCode'
};

var descriptionOrder = {
    text: orderByDescription,
    value: 'info.name',
};

var customerPartNumberOrder = {
	text: orderByCustomerPartNumber,
	value: 'customerPartNumber',
}

const FavouritesOrderFields = {
    PARTNUMBER: 'partNumber',
    NAME: 'name',
    CUSTOMER_PARTNUMBER: 'customerPartNumber'
}

const FavouritesOrderType = {
    ASC: 'ASC',
    DESC: 'DESC'
}

function FavouriteToAdd(partNumber, customerPartNumber, info) {
	this.partnumberCode = partNumber;
    this.personalized = !!!$.isEmptyObject(info);
    this.customerPartNumber = customerPartNumber;
	this.info = info || {};
}

function FavouritesViewModel() {

	var self = this;

	const ProductsOrderEnum = {
        PARTNUMBER_ASC: {
            order: {
                field: FavouritesOrderFields.PARTNUMBER,
                orderType: FavouritesOrderType.ASC,
            },
            text: '▲ ' + orderByPartNumber,
        },
        PARTNUMBER_DESC: {
            order: {
                field: FavouritesOrderFields.PARTNUMBER,
                orderType: FavouritesOrderType.DESC,
            },
            text: '▼ ' + orderByPartNumber,
        },
        DESCRIPTION_ASC: {
            order: {
                field: FavouritesOrderFields.NAME,
                orderType: FavouritesOrderType.ASC,
            },
            text: '▲ ' + orderByDescription,
        },
        DESCRIPTION_DESC: {
            order: {
                field: FavouritesOrderFields.NAME,
                orderType: FavouritesOrderType.DESC,
            },
            text: '▼ ' + orderByDescription,
        },
        CUSTOMER_PARTNUMBER_ASC: {
            order: {
                field: FavouritesOrderFields.CUSTOMER_PARTNUMBER,
                orderType: FavouritesOrderType.ASC,
            },
            text: '▲ ' + orderByCustomerPartNumber,
        },
        CUSTOMER_PARTNUMBER_DESC: {
            order: {
                field: FavouritesOrderFields.CUSTOMER_PARTNUMBER,
                orderType: FavouritesOrderType.DESC,
            },
            text: '▼ ' + orderByCustomerPartNumber,
        }
    };


	ko.di.require({
		CONFIGURATION: "FavouritesConfigurationVariables",
		MESSAGES: "FavouritesMessages",
		REPOSITORY: "FavouritesRepository",
		DETAILS_SERVICE: "FavouritesModalDetails",
		PERMISSIONS: "Permissions",
		SMCURLs: "SMCURLs"
	}, self);

	ko.iketek.withSelectAll(self, "elements");

	var FAVOURITES_CONSTANTS = {
		PARTNUMBER_DESCENDING: 0,
		PARTNUMBER_ASCENDING: 1,
		CUSTOMER_PARTNUMBER_DESCENDING: 2,
		CUSTOMER_PARTNUMBER_ASCENDING: 3,
		DESCRIPTION_DESCENDING: 4,
		DESCRIPTION_ASCENDING: 5,
		FOLDER_DESCENDING: 6,
		FOLDER_ASCENDING: 7
	};

	self.orderTypes = [
		ProductsOrderEnum.PARTNUMBER_ASC,
		ProductsOrderEnum.PARTNUMBER_DESC,
		ProductsOrderEnum.DESCRIPTION_ASC,
		ProductsOrderEnum.DESCRIPTION_DESC,
		ProductsOrderEnum.CUSTOMER_PARTNUMBER_ASC,
		ProductsOrderEnum.CUSTOMER_PARTNUMBER_DESC
	];

	var REPOSITORY = new FavouritesRepository();
	var BASKET_REPOSITORY = new BasketProductRepository();
	var MoreInfo = new MoreInfoComponent();

	var GET_DETAILS_INTERVAL = 10000;

	self.filterSearch = ko.observable('');
	self.selectedOrder = ko.observable(ProductsOrderEnum.PARTNUMBER_ASC.order);
	self.folderList = ko.observableArray([]);

	/************************************************
	 ***************  	FUNCTIONS     ***************
	 *************************************************/

	self.normalizeDatatable = function (obj) {
		return {
			content: obj.favourites || [],
			iTotalDisplayRecords: obj.numElements || 0,
			foundElements: obj.foundElements || 0,
		};
	};

	self.resetAndSearch = function () {

		self.datatable.filter.favouritesFilterStatus("0");
		self.datatable.resetFilters();
		self.datatable.refresh();

	};

	self.filterFavourites = function() {
		self.datatable.orderType(buildOrderParam(self.selectedOrder()));
		self.datatable.filter.favouritesFilter(self.filterSearch());
		self.datatable.refresh();
	}
	
	// DELETE PRODUCT
	self.deleteFavourites = function () {

		var elements = self.checkedElements();
		if (elements.length == 0) {

			return smc.NotifyComponent.error(BASKET_MESSAGES.nothingSelected);

		} else {

			createConfirmDialog('modal-component', deleteTitle, self.MESSAGES["sureDeleteElements"],
				BASKET_MESSAGES.modalDeleteCancelButtonText, BASKET_MESSAGES.modalDeleteConfirmButtonText, true,
				function (confirm) {

					if (confirm) {

						var deleted = elements.length;

						REPOSITORY.doDelete(elements, {
							success: function (msg) {
								self.datatable.refresh();
								self.refreshTreeBox(-deleted);
							}
						});

					}

				});

		}

	};

	//ADD TO BASKET
	self.addToBasket = function (product) {
		var productToAdd = new BasketPartnumberToAdd(product.partnumberCode(), product.quantity(), product.customerPartNumber(), productPersonalizedInfo(product));
		productToAdd.setPersonalizedFields(product.personalizedPartnumber(), product.personalizedType());
		basketViewModel.addToBasket(productToAdd).then(function() {
			product.quantity(1);
		});

	}

	self.addToBasketItems = function () {

		var elements = self.checkedElements();

		if (elements.length == 0) {
			
			return smc.NotifyComponent.error(BASKET_MESSAGES.nothingSelected);

		} else {

			var array = elements.map(function (object) {
				return {
					partnumbercode: object.partnumberCode(),
					quantity: object.quantity(),
					customerPartNumber: object.customerPartNumber,
					details: productPersonalizedInfo(object),
					personalizedPartnumber: object.personalizedPartnumber(),
					personalizedType: object.personalizedType()
				};
			});


			var i;
			var productsToAdd = [];
			array.forEach(function (elem, idx, arr) {
				var productToAdd = new BasketPartnumberToAdd(elem.partnumbercode, elem.quantity, elem.customerPartNumber, elem.details);
				productToAdd.setPersonalizedFields(elem.personalizedPartnumber, elem.personalizedType);
				productsToAdd.push(productToAdd);
			});

			basketViewModel.addToBasket(productsToAdd, 'FAVOURITES').then(function(){
				array.forEach(function (elem, idx, arr) {
					elements[idx].quantity(1);
				});
			});

		}

	}
	
	// GET MoreInfo component
	self.getProductMoreInfo = function(partNumber, index){

		const type = this.personalizedType();
		const description = this.info() ? this.info().name : '';

        MoreInfo.getTooltip(partNumber, index, "fav", type, description);
    }

	// SEND TO BASKET
	self.sendToBasket = function () {};

	//Move products
	self.moveOrCopyProducts = function (isCopy) {

		var elements = self.checkedElements();

		if (elements.length == 0) {
			
			return smc.NotifyComponent.error(BASKET_MESSAGES.nothingSelected);

		} else {

			var deferred = favouritesFoldersViewModel.show();
			deferred.then(function (selectedFolder) {



				REPOSITORY.doMoveOrCopyFavourites(elements, currentFolder, selectedFolder, isCopy, {
					success: function () {
						//Number of elements moved
						var numberMovedElems = elements.length;

						//Update datatable
						self.datatable.refresh();

						//Update number of total elements
						if (!isCopy) self.refreshTreeBox(-numberMovedElems);
						self.refreshTreeBox(numberMovedElems, selectedFolder);
					}
				});

			}, function () {

				//TODO: Message of error??? modal?

			});

		}

	}

	self.refreshTreeBox = function (number, folderId) {

		var targetFolder = folderId;
		if (!folderId) {
			targetFolder = currentFolder;
		}

		var text = $('[data-refresh=' + targetFolder + ']').text();
		var value = parseInt(text);
		value += number;
		$('[data-refresh=' + targetFolder + ']').text(value);

	};
	
	self.importModal = function() {
        let fileInput = document.getElementById('importFavourites');
        var deferred = $.Deferred();

        createConfirmAsyncDialog('modal-fav-import', null, null, cancelBtn, importBtn, true, 'error-dialog-import',function(confirm){
            if(confirm){
              $(fileInput).trigger('click');
              
            }
            return deferred.resolve();
        });
           
    }

	self.uploadFile = function(){
        var deferred = $.Deferred();
        let fileInput = document.getElementById('importFavourites');
       

        const file = fileInput.files[0];

        if(!isValidImportFile(file)){
        
            return smc.NotifyComponent.error(FAVOURITES_MESSAGES.invalidFormatFile);
        }


        REPOSITORY.doImportFile(file, currentFolder)
            .then(function(e) {
                smc.NotifyComponent.info(FAVOURITES_MESSAGES.successImport);
            })
            .catch(function(e){
                smc.NotifyComponent.error(FAVOURITES_MESSAGES.errorImportFavourites);
            })
    }
    
    const isValidImportFile = function(file){
        try {
            if(!file || !file.name) return false;
            const validExtensions = ['xls', 'xlsx'];
            const fileParts = file.name.split('.');
            const extension = fileParts[fileParts.length - 1];

            return validExtensions.indexOf(extension) > -1;
        } catch (e) {
            return false;
        }
    }


	self.favouritesOrderColumns = ko.observableArray([]);
	self.favouritesOrderColumns.push({
		id: FAVOURITES_CONSTANTS.PARTNUMBER_ASCENDING,
		text: "&#9650; " + self.MESSAGES["partNumberLbl"],
		selectedText: self.MESSAGES["orderByVarLbl"].replace("{$0}", "&#9650; " + self.MESSAGES["partNumberLbl"]),
		singleDir: true
	});
	self.favouritesOrderColumns.push({
		id: FAVOURITES_CONSTANTS.PARTNUMBER_DESCENDING,
		text: "&#9660; " + self.MESSAGES["partNumberLbl"],
		selectedText: self.MESSAGES["orderByVarLbl"].replace("{$0}", "&#9660; " + self.MESSAGES["partNumberLbl"]),
		singleDir: true
	});
	self.favouritesOrderColumns.push({
		id: FAVOURITES_CONSTANTS.CUSTOMER_PARTNUMBER_ASCENDING,
		text: "&#9650; " + self.MESSAGES["customerPartNumberLbl"],
		selectedText: self.MESSAGES["orderByVarLbl"].replace("{$0}", "&#9650; " + self.MESSAGES["customerPartNumberLbl"]),
		singleDir: true
	});
	self.favouritesOrderColumns.push({
		id: FAVOURITES_CONSTANTS.CUSTOMER_PARTNUMBER_DESCENDING,
		text: "&#9660; " + self.MESSAGES["customerPartNumberLbl"],
		selectedText: self.MESSAGES["orderByVarLbl"].replace("{$0}", "&#9660; " + self.MESSAGES["customerPartNumberLbl"]),
		singleDir: true
	});
	self.favouritesOrderColumns.push({
		id: FAVOURITES_CONSTANTS.DESCRIPTION_ASCENDING,
		text: "&#9650; " + self.MESSAGES["descriptionLbl"],
		selectedText: self.MESSAGES["orderByVarLbl"].replace("{$0}", "&#9650; " + self.MESSAGES["descriptionLbl"]),
		singleDir: true
	});
	self.favouritesOrderColumns.push({
		id: FAVOURITES_CONSTANTS.DESCRIPTION_DESCENDING,
		text: "&#9660; " + self.MESSAGES["descriptionLbl"],
		selectedText: self.MESSAGES["orderByVarLbl"].replace("{$0}", "&#9660; " + self.MESSAGES["descriptionLbl"]),
		singleDir: true
	});
	if (self.CONFIGURATION['MODE'] == 'all') {
		self.favouritesOrderColumns.push({
			id: FAVOURITES_CONSTANTS.FOLDER_ASCENDING,
			text: "&#9650; " + self.MESSAGES["folderLbl"],
			selectedText: self.MESSAGES["orderByVarLbl"].replace("{$0}", "&#9650; " + self.MESSAGES["folderLbl"]),
			singleDir: true
		});
		self.favouritesOrderColumns.push({
			id: FAVOURITES_CONSTANTS.FOLDER_DESCENDING,
			text: "&#9660; " + self.MESSAGES["folderLbl"],
			selectedText: self.MESSAGES["orderByVarLbl"].replace("{$0}", "&#9660; " + self.MESSAGES["folderLbl"]),
			singleDir: true
		});
	}

	self.getDetails = function(partnumber) {
		doGetDetails(partnumber, function(){});

        var stopInterval = setInterval(function () {
            if (partnumber.info() && (!partnumber.status() || partnumber.status() === 'ERROR' || partnumber.status() === 'UPDATED')) {
				clearInterval(stopInterval);
            }

            doGetDetails(partnumber, function () {
                clearInterval(stopInterval);
            });

        }, GET_DETAILS_INTERVAL);
	}

	self.updateCustomerPartNumber = function(product){
		const favId = product.favouriteId();
		const customerPartNumber = product.customerPartNumber();
		REPOSITORY.doUpdateCustomerPartNumber(favId, customerPartNumber)
			.then(function(res){
				smc.NotifyComponent.info(FAVOURITES_MESSAGES.updateCustomerPartNumberSuccess);

			}).catch(function(err){
				smc.NotifyComponent.error(FAVOURITES_MESSAGES.updateCustomerPartNumberError);
			});
	}
	
	//Export Component
    self.exportFavourites = function(type){
		var elements = self.checkedElements();
		const selected = getExportlements(elements);
		
		if(!selected || selected.length === 0){
			smc.NotifyComponent.error(errorEmptyExport);
		}
		smc.NotifyComponent.info(FAVOURITES_MESSAGES.exportStart)
        REPOSITORY.doExportFavourites(selected, type).then(
            function(res){
                window.open(res);
            }
        )
        .catch(function(err){
            console.error(JSON.stringify(err))
            smc.NotifyComponent.error('can not export current basket');
        })
    }
    // -------------------
    // -------------------

	const doGetDetails = function (partnumber, callback) {
		if (partnumber.status() === 'ERROR' || partnumber.status() === 'UPDATED') return;
		if(!partnumber || !partnumber.partnumberCode()) return callback();
		BASKET_REPOSITORY.doGetPartnumberDetails(
			partnumber.partnumberCode(), {
				success: function (res) {
					try {
						
						if (res.status === 'UPDATED') {
							var detailsSliceResult = slicePartnumberDetails(res.info[0].details);
							var observableDetail = {
								detailsPart1: detailsSliceResult[0],
								detailsPart2: detailsSliceResult[1],
							};
							partnumber.details(observableDetail);
						}
						if(res && res.status) {
							partnumber.status(res.status);
						} else {
							partnumber.status('UPDATED'); 
						}
						
						if ((res.status === 'UPDATED' || res.status === 'ERROR') && callback) callback(); //Stop running
					} catch (e) {
						partnumber.status('ERROR');
						console.error('Error parsing' + partnumber.info().partNumber + 'details');
					}
				},
				error: function (err) {
					if (callback) callback();
					console.error('Error trying to retrieve partnumber details');
				}
			}
		);
	}

	const buildOrderParam = function(order){

		if(!order || !order.field || !order.orderType) return 
			FavouritesOrderFields.PARTNUMBER + "_" +
			FavouritesOrderType.ASC
		const field = order.field;
		const direction = order.orderType;
		return field + "_" + direction;
	}

	const productPersonalizedInfo = function(product) {
        const info = product.info();
        if(!product.personalized() || !info) {
            return {};
        }
        
        return {
            mediumImage: info.mediumImage,
            smallImage: info.smallImage,
            extraSmallImage: info.extraSmallImage,
            serie: info.serie,
            familyName: info.familyName,
            catalogue: info.catalogue,
			preview: info.preview,
			cadenas: info.cadenas,
            productId: info.productId,
            name: info.name,
            partNumber: info.partNumber
        };
	}
	
	const reverseListOfFolders = function(folders){
		let responseList = [];

		_.forEach(folders, function(parent) {
			let current = {
				folderId: parent.folderId,
				name: parent.name,
				parent: null
			};
			let childrens = childrenFolders(parent)
			responseList.push(current);
			responseList = responseList.concat(childrens);
		});
		self.folderList(responseList);
	}

	const childrenFolders = function(parent) {
		if(!parent) {
			return;
		}
		
		return _.map(parent.childrens, function(folder){
			return {
				parent: {
					folderId: parent.folderId,
					name: parent.name
				},
				name: folder.name,
				folderId: folder.folderId
			};
		});
	};

	const findFolder = function(folderId){
		try {

			return _.find(self.folderList(), function(folder) {
				return folder.folderId === folderId;
			});

		} catch (e){
			return {};
		}
	}
	
	/**
     * Creates an array of favourites elements to export
     */
    var getExportlements = function (elements) {
		

        return _(elements).filter(function(prod){
            return prod.checked();
        })
        .map(function(prod){
            
            return prod.id();
        });
    
    }
	
	/************************************************
	 ***************  	DATATABLE     ***************
	 *************************************************/

	ko.iketek.withDatatable(self, {
		container: "favouritesTable",
		extras: {
			showDetails: false,
			checked: false,
			detailsFetched: false,
		},
		elemCallback: function (obj) {
			let folder = findFolder(obj.folderId());
			obj.id = obj.favouriteId;
			obj.quantity = ko.observable(1);
			obj.details = ko.observable({});
			obj.status = ko.observable('');
			obj.customerPartNumber = ko.observable(obj.customerPartNumber() || '');
			obj.folder = folder || null;

			return obj;
		},
		postData: {
			folderId: self.CONFIGURATION['FOLDER_ID'],
			token: token
		},
		filters: ["favouritesFilter", "favouritesFilterStatus"],
		data: "elements",
		url: favouritesServerListUrl,
		info: self.MESSAGES["datatableInfoMessage"],
		recordsPerPage: self.MESSAGES["recordsPerPage"],
		recordsSelector: [10, 20, 50],
		orderColumns: self.favouritesOrderColumns(),
		defaultOrderColumn: FAVOURITES_CONSTANTS.PARTNUMBER_ASCENDING,
		noElementsMsg: self.MESSAGES["noProductsAvailable"]
	});
	self.datatable.orderType(buildOrderParam(self.selectedOrder()));
	self.datatable.refresh();
	reverseListOfFolders(listOfFolders);

	self.splitString = function (data, separator, part, includeSep) {
		return splitString(data, separator, part, includeSep);
	};


	

}