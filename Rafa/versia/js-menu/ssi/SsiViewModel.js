var partnumberOrder = {
    text: orderByPartNumber,
    value: 'partnumber',
};

var descriptionOrder = {
    text: orderByDescription,
    value: 'name',
};

function SsiProductOrderValue(field, order) {
    this.field = field;
    this.order = order;
}

const SsiOrderFields = {
    PARTNUMBER: 'PARTNUMBER',
    NAME: 'NAME',
    FAMILY: 'FAMILY',
    SERIE: 'SERIE'
}

const SsiOrderType = {
    ASC: 'ASC',
    DESC: 'DESC'
}

function SsiViewModel() {
    var self = this;

    var defaultFamResponse = {
        families: [],
        subfamilies: []
    };
    var defaultFamily = {
        id: null,
        name: SSI_MESSAGES.allFamilies
    };

    const SsiProductOrderEnum = {
        PARTNUMBER: {
            order: {
                field: SsiOrderFields.PARTNUMBER,
                orderType: SsiOrderType.ASC
            },
            text: '▲ ' + orderByPartNumber
        },
        PARTNUMBER_DESC: {
            order: {
                field: SsiOrderFields.PARTNUMBER,
                orderType: SsiOrderType.DESC
            },
            text: '▼ ' + orderByPartNumber
        },
        NAME: {
            order: {
                field: SsiOrderFields.NAME,
                orderType: SsiOrderType.ASC
            },
            text: '▲ ' + orderByDescription
        },
        NAME_DESC: {
            order: {
                field: SsiOrderFields.NAME,
                orderType: SsiOrderType.DESC
            },
            text: '▼ ' + orderByDescription
        },
        FAMILY: {
            order: {
                field: SsiOrderFields.FAMILY,
                orderType: SsiOrderType.ASC
            },
            text: '▲ ' + orderByFamily
        },
        FAMILY_DESC: {
            order: {
                field: SsiOrderFields.FAMILY,
                orderType: SsiOrderType.DESC
            },
            text: '▼ ' + orderByFamily
        },
        SERIE: {
            order: {
                field: SsiOrderFields.SERIE,
                orderType: SsiOrderType.ASC
            },
            text: '▲ ' + orderBySerie
        },
        SERIE_DESC: {
            order: {
                field: SsiOrderFields.SERIE,
                orderType: SsiOrderType.DESC
            },
            text: '▼ ' + orderBySerie
        }
    }


    self.ssiOrders = [
        SsiProductOrderEnum.PARTNUMBER,
        SsiProductOrderEnum.PARTNUMBER_DESC,
        SsiProductOrderEnum.SERIE,
        SsiProductOrderEnum.SERIE_DESC,
        SsiProductOrderEnum.NAME,
        SsiProductOrderEnum.NAME_DESC,
        SsiProductOrderEnum.FAMILY,
        SsiProductOrderEnum.FAMILY_DESC
    ];
    self.ssiOrderType = SsiProductOrderEnum;

    ko.di.require({
        CONFIGURATION: "SsiConfigurationVariables",
        MESSAGES: "SsiMessages",
        REPOSITORY: "SsiRepository",
        DETAILS_SERVICE: "SsiModalDetails",
        PERMISSIONS: "Permissions",
        SMCURLs: "SMCURLs"
    }, self);
    ko.iketek.withSelectAll(self, "elements");

    self.families = ko.observableArray([]);
    self.subfamilies = ko.observableArray([]);
    self.filterFamily = ko.observable(defaultFamily);
    self.filterSubfamily = ko.observable(defaultFamily);
    self.filterPartnumber = ko.observable('');
    self.selectedOrder = ko.observable(SsiProductOrderEnum.PARTNUMBER.order);
    self.currentTooltip = ko.observable(-1);
    
    var SSI_CONSTANTS = {
        PARTNUMBER_DESCENDING: 0,
        PARTNUMBER_ASCENDING: 1,
        DESCRIPTION_DESCENDING: 2,
        DESCRIPTION_ASCENDING: 3,
    };

    var REPOSITORY = new SsiRepository();
    var BASKET_REPOSITORY = new BasketProductRepository();
    var MoreInfo = new MoreInfoComponent();

    /*
     * functions
     */

    self.normalizeDatatable = function (obj) {
        return {
            content: obj.content || [],
            iTotalDisplayRecords: obj.numElements || 0,
            foundElements: obj.numTotalElements || 0,
        };
    };

    self.resetAndSearch = function () {
        self.datatable.ssiFilterStatus('0');
        self.datatable.resetFilters();
        self.datatable.refresh();
    };

    self.addToBasket = function (product) {
        var product = new BasketPartnumberToAdd(product.partNumber(), product.quantity(), null, productPersonalizedInfo(product));
        basketViewModel.addToBasket(product, 'SSI PAGE', {
            success: function (data) {
                product.quantity(1);
            },
        })
    }

    self.getFamilies = function (familyId, familyName) {
        REPOSITORY.getFamilies(familyId, {
            success: function (res) {
                var parsedJSON = JSON.parse(res.trim()) || defaultFamResponse;
                var tmpfamilies = [defaultFamily];
                var tmpSubfamilies = [defaultFamily];

                self.families(tmpfamilies.concat(parsedJSON.families));
                self.subfamilies(tmpSubfamilies.concat(parsedJSON.subfamilies));
                self.filterFamily({
                    id: familyId || defaultFamily.id,
                    name: familyName || defaultFamily.name,
                });
                self.filterSubfamily(defaultFamily);
            }
        });
    }

    self.setSubfamilyFilter = function (id, name) {
        self.filterSubfamily({
            id: id,
            name: name,
        });
    }

    self.filterProducts = function () {
        
        self.sortProducts(buildOrderParam(self.selectedOrder()));
    }

    self.sortProducts = function (type) {
        var order = type || "partnumber";
        self.datatable.orderType(order);
        self.datatable.customFilters({
            family: self.filterFamily().id,
            subfamily: self.filterSubfamily().id,
            search: self.filterPartnumber(),
        });
        self.datatable.refresh();
    }

    self.getDetails = function (partnumber) {
        doGetDetails(partnumber);

        var stopInterval = setInterval(function () {
            if (partnumber.info() && (partnumber.status() === 'ERROR' || partnumber.status() === 'UPDATED')) {
                clearInterval(stopInterval);
            }

            doGetDetails(partnumber, function () {
                clearInterval(stopInterval);
            });

        }, 10000);
    }

    self.getProductMoreInfo = function(partNumber, index){
        MoreInfo.getTooltip(partNumber, index, "ssi");
    }

    var doGetDetails = function (partnumber, callback) {
        if (!partnumber || !partnumber.info() || !partnumber.info().partNumber || partnumber.status() === 'ERROR' || partnumber.status() === 'UPDATED') return;
        BASKET_REPOSITORY.doGetPartnumberDetails(
            partnumber.info().partNumber, {
                success: function (res) {
                    console.log(res)
                    try {
                        //var parsedJSON = JSON.parse(res);
                        if (res.status === 'UPDATED') {
                            var detailsSliceResult = slicePartnumberDetails(res.info[0].details);
                            var observableDetail = {
                                detailsPart1: detailsSliceResult[0],
                                detailsPart2: detailsSliceResult[1],
                            };
                            partnumber.details(observableDetail);
                        }

                        if ((res.status === 'UPDATED' || res.status === 'ERROR') && callback) callback(); //Stop running
                        partnumber.status(res.status);
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
        if(!order) {
            console.error('Not a valid order');
            order = SsiProductOrderEnum.PARTNUMBER.order;
        }
        var orderParam = order.field + "_" + order.orderType;
        return orderParam;
    }

    const productPersonalizedInfo = function(product) {
        const info = product.info();
        if(!product.isPersonalized() || !info) {
            return {};
        }
        
        return {
            mediumImage: info.mediumImage,
            smallImage: info.smallImage,
            extraSmallImage: info.extraSmallImage,
            serie: info.serie,
            familyName: (info.family)?info.family.name:null,
            catalogue: info.catalogue,
            preview: info.preview,
            productId: info.productId,
            cadenas: info.cadenas,
            name: info.name,
            partNumber: info.partNumber
        };
    }
    
    // Function to add checked elements to basket
    self.addToBasketItems = function () {
        var elements = self.checkedElements();

        if (elements.length == 0) {
			
			createSimpleModal('modal-nothing-selected');

		} else {
            var array = _.map(elements,
                function (obj) {
                    return new BasketPartnumberToAdd(obj.partNumber(), obj.quantity(), null, productPersonalizedInfo(obj));
                }
            );

            var i;
			var productsToAdd = [];
			array.forEach(function (elem, idx, arr) {
				var productToAdd = new BasketPartnumberToAdd(elem.partnumbercode, elem.quantity, elem.customerPartNumber, elem.details);
				productsToAdd.push(productToAdd);
			});

			basketViewModel.addToBasket(productsToAdd, 'SSI PAGE').then(function(){
				array.forEach(function (elem, idx, arr) {
					elements[idx].quantity(1);
				});
            });
            
        }

    }


    self.addToFavouriteSelecteds = function () {

        var selecteds = _.map(self.checkedElements(), function(element){
            const info = element && element.isPersonalized() ? element.info() : {};
            return new FavouriteToAdd(element.partNumber(), null, info);
        });

        if (selecteds.length == 0) {

            createConfirmDialog('modal-component', BASKET_MESSAGES.selection, BASKET_MESSAGES.selectAtLeastOne,
                BASKET_MESSAGES.close, null, false);

        } else {

            self.addToFavourites(selecteds);

        }

    }

    self.addToFavourites = function(favourites) {

        var deferred = $.Deferred();
        //If no loged in page redirect to login and reload with requested action
        if(typeof favouritesFoldersViewModel === 'undefined') {
            
            var originUrl = new URL(window.location.href);
            const codes = _.map(favourites, function(fav){
               return fav.partnumberCode; 
            });
            originUrl.searchParams.set('componentId', 'SsiViewModel');
            originUrl.searchParams.set('action', 'addToFavourites');
            originUrl.searchParams.set('actionParams', codes);
            var url = new URL(originUrl.origin + smc.channelPrefix + '/secured-resource');
            url.searchParams.set('resource', originUrl.toString().replace(originUrl.origin, ''));
            window.location = url;

            deferred.reject();

        } else {

            var modalDeferred = favouritesFoldersViewModel.show();
            modalDeferred.then(function (selectedFolder) {

                BASKET_REPOSITORY.doAddToFavourite(favourites, selectedFolder, 'SSI PAGE', {
                    success: function (res) {
                        deferred.resolve();
                        smc.NotifyComponent.info(SSI_MESSAGES.favouritesSuccess);
                    }, error: function(err) {
                        deferred.reject();
                        smc.NotifyComponent.error(SSI_MESSAGES.favouritesError);
                    }
                });

            }).catch(function(err) {
                deferred.reject(new BasketError(BASKET_ERROR_CODES.UI_MODAL_REJECTED));
            });
        
        }
        return deferred.promise();
    }

    self.exportFile = function(type){
        var selecteds = _.map(self.checkedElements(), function(element){
            const serie = element.hasInformation() ? element.info().serie : '';


            return {
                partNumber : element.partNumber(),
                serie: serie
            }
        });

        if(selecteds.length === 0){
            return smc.NotifyComponent.error(BASKET_MESSAGES.selectAtLeastOne);
        }

        REPOSITORY
            .doExportSsi(selecteds, type)
            .then(function(res){
                window.open(res);
            });
    }

    self.isEtechOnline = function () {
        return etech_online_status === 'on';
    }

    self.ssiOrderColumns = ko.observableArray([]);
    self.ssiOrderColumns.push({
        id: SSI_CONSTANTS.PARTNUMBER_ASCENDING,
        text: '&#9650; ' + self.MESSAGES['partNumberLbl'],
        selectedText: self.MESSAGES['orderByVarLbl'].replace('{$0}', '&#9650; ' + self.MESSAGES['partNumberLbl']),
        singleDir: true,
    });
    self.ssiOrderColumns.push({
        id: SSI_CONSTANTS.PARTNUMBER_DESCENDING,
        text: '&#9660; ' + self.MESSAGES['partNumberLbl'],
        selectedText: self.MESSAGES['orderByVarLbl'].replace('{$0}', '&#9660; ' + self.MESSAGES['partNumberLbl']),
        singleDir: true,
    });
    self.ssiOrderColumns.push({
        id: SSI_CONSTANTS.DESCRIPTION_ASCENDING,
        text: '&#9650; ' + self.MESSAGES['descriptionLbl'],
        selectedText: self.MESSAGES['orderByVarLbl'].replace('{$0}', '&#9650; ' + self.MESSAGES['descriptionLbl']),
        singleDir: true,
    });
    self.ssiOrderColumns.push({
        id: SSI_CONSTANTS.DESCRIPTION_ASCENDING,
        text: '&#9660; ' + self.MESSAGES['descriptionLbl'],
        selectedText: self.MESSAGES['orderByVarLbl'].replace('{$0}', '&#9660; ' + self.MESSAGES['descriptionLbl']),
        singleDir: true,
    });
    ko.iketek.withDatatable(self, {
        container: "ssiTable",
        extras: {
            showDetails: false,
            checked: false,
            detailsFetched: false,
        },
        elemCallback: function (obj) {
            obj.quantity = ko.observable(1);
            obj.details = ko.observable({});
            obj.status = ko.observable('');
            return obj;
        },
        postData: {
            token: token
        },
        data: "elements",
        url: ssiServerListUrl,
        info: self.MESSAGES["datatableInfoMessage"],
        recordsPerPage: self.MESSAGES["recordsPerPage"],
        recordsSelector: [10, 20, 50],
        orderColumns: self.ssiOrderColumns(),
        defaultOrderColumn: SSI_CONSTANTS.PARTNUMBER_ASCENDING,
        noElementsMsg: self.MESSAGES["noProductsAvailable"]
    });
    self.datatable.refresh();
    self.datatable.orderType(buildOrderParam(self.selectedOrder()));
    self.datatable.customFilters({
        family: self.filterFamily().id,
        subfamily: self.filterSubfamily().id,
        search: self.filterPartnumber(),
    });
    self.getFamilies();

    self.splitString = function (data, separator, part, includeSep) {
        return splitString(data, separator, part, includeSep);
    };



}