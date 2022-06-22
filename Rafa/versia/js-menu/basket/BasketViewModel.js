// ALL ENUMS DEFINED FOR OLD BROWSERS
// ALL CONSTANTS DEFINED FOR OLD BROWSERS
const OrderStateTypeEnum = {
    UPDATING: 'UPDATING',
    UPDATED: 'UPDATED',
    ERROR: 'ERROR'
};

const PartnumberTypeEnum = {
    ANY: 'ANY',
    PARTNUMBER: 'PARTNUMBER',
    CUSTOMER_PARTNUMBER: 'CUSTOMER_PARTNUMBER'
};

function BasketProductOrderValue(field, order) {
    this.field = field;
    this.order = order;
}

const BasketOrderFields = {
    DATE_ADDED: 'DATE_ADDED',
    DESCRIPTION: 'DESCRIPTION',
    PARTNUMBER: 'PARTNUMBER'
};

const BasketOrderType = {
    ASC: 'ASC',
    DESC: 'DESC'
}

function BasketError(errorCode, errorMessage) {
    this.errorCode = errorCode;
    this.errorMessage = errorMessage;
}

const BASKET_ERROR_CODES = {
    INTERNAL_SERVICE_ERROR: 'ERROR_BSK_0500',
    PRODUCTS_ALREADY_INSERTED_ALL: 'ERROR_BSK_04091',
    PRODUCTS_ALREADY_INSERTED_SOME: 'ERROR_BSK_04092',
    ADD_TO_BASKET_ALREADY_WORKING: 'ERROR_BKS_04291',
    UI_MODAL_REJECTED: 'ERROR_BSK_1001',
    IMPORT_ERROR: 'ERROR_BSK_05004',
    IMPORT_FORMAT_ERROR: 'ERROR_BSK_04000'
};

function BasketPartnumberToAdd(partnumber, quantity, customerPartnumber, personalized) {
    this.partnumbercode = partnumber;
    this.quantity = quantity;
    this.customerPartnumber = customerPartnumber;
    //Personalized values
    this.personalizedProduct = !$.isEmptyObject(personalized);
    personalized = personalized || {};
    this.personalizedPartnumber = null;
    this.personalizedType = null;
    $.extend(this, personalized);
}

BasketPartnumberToAdd.prototype.setPersonalizedFields = function(personalizedPartnumber, personalizedType) {
    this.personalizedPartnumber = personalizedPartnumber;
    this.personalizedType = personalizedType;
};


function FavouriteToAdd(partNumber, customerPartNumber, info) {
	this.partnumberCode = partNumber;
    this.personalized = !!!$.isEmptyObject(info);
    this.personalizedPartnumber = null;
    this.personalizedType = null;
    this.customerPartNumber = customerPartNumber;
	this.info = info || {};
}

FavouriteToAdd.prototype.setPersonalizedFields = function(personalizedPartnumber, personalizedType, name) {
    this.personalized = this.personalized == false && personalizedPartnumber != null && personalizedType != null ? true : false;
    this.info.name = name;
    this.personalizedPartnumber = personalizedPartnumber;
    this.personalizedType = personalizedType;
}

function BasketViewModel() {

    var self = this;

    //---------------------------
    // -- Constants & 'Enums' --
    //---------------------------
    const INTERVAL_TIMER_MS = 2000;
    const MAX_NUMBER_OF_ATTEMPTS = 20;

    const BasketProductOrderEnum = {
        DATE_ADDED: {
            order: {
                field: BasketOrderFields.DATE_ADDED,
                orderType: BasketOrderType.ASC
            },
            name: '▲ ' + BASKET_MESSAGES.orderByInsertion
        },
        DATE_ADDED_DESC: {
            order: {
                field: BasketOrderFields.DATE_ADDED,
                orderType: BasketOrderType.DESC
            },
            name: '▼ ' + BASKET_MESSAGES.orderByInsertion
        },
        DESCRIPTION: {
            order: {
                field: BasketOrderFields.DESCRIPTION,
                orderType: BasketOrderType.ASC
            },
            name: '▲ ' + BASKET_MESSAGES.orderByDescription
        },
        DESCRIPTION_DESC: {
            order: {
                field: BasketOrderFields.DESCRIPTION,
                orderType: BasketOrderType.DESC
            },
            name: '▼ ' + BASKET_MESSAGES.orderByDescription
        },
        PARTNUMBER: {
            order: {
                field: BasketOrderFields.PARTNUMBER,
                orderType: BasketOrderType.ASC
            },
            name: '▲ ' + BASKET_MESSAGES.orderByPartnumber
        },
        PARTNUMBER_DESC: {
            order: {
                field: BasketOrderFields.PARTNUMBER,
                orderType: BasketOrderType.DESC
            },
            name: '▼ ' + BASKET_MESSAGES.orderByPartnumber
        }
    }

    self.StateType = OrderStateTypeEnum;
    self.PartnumberType = PartnumberTypeEnum;
    self.BasketProductOrderType = BasketProductOrderEnum;
    self.basketProductOrderArr = [
        BasketProductOrderEnum.DATE_ADDED,
        BasketProductOrderEnum.DATE_ADDED_DESC,
        BasketProductOrderEnum.PARTNUMBER,
        BasketProductOrderEnum.PARTNUMBER_DESC,
        BasketProductOrderEnum.DESCRIPTION,
        BasketProductOrderEnum.DESCRIPTION_DESC
    ];

    //---------------------------
    //---------------------------


    self.loadedViewModel = ko.observable(false);
    self.dataLoaded = $.Deferred();

    ko.di.register(self, 'BasketViewModel');
    ko.di.require({
        MESSAGES: 'BasketMessages',
        REPOSITORY: 'BasketProductRepository',
        CONFIGURATION: 'ConfigurationVariables'
    }, self);

    //--------------------------
    // -- Private attributes --
    //--------------------------
    var preventSubscribePartnumber = false;

    // --- Repository
    var REPOSITORY = new BasketProductRepository();
    //--------------------------
    //--------------------------

    // --- Filter and selection
    self.selectAll = ko.observable(false);
    self.filter = ko.observable('');
    self.order = ko.observable('');
    self.basketId = ko.observable('');

    // --- inputs and confs

    self.boxInputPartnumber = ko.observable('');
    self.boxInputPartnumberLayer = ko.observable('');
    self.boxInputQuantity = ko.observable(1);
    self.selectPartnumberType = ko.observable(PartnumberTypeEnum.ANY);

    // --- Basket Data ---
    self._products = [];
    self.products = ko.observableArray([]);
    self.productsFilter = ko.observableArray([]);
    self.totalListPrice = ko.observable(0);
    self.totalNetPrice = ko.observable(0);
    self.totalListPriceWithCharges = ko.observable(0);
    self.totalNetPriceWithCharges = ko.observable(0);
    self.orderCharges = ko.observable(0);
    self.currency = ko.observable('');
    self.erpUnaffordableRemovableProducts = ko.observable(false);
    self.description = ko.observable('');
    self.comments = ko.observable('');

    // --- Attempts for getting data of products       ---
    // --- Reset attemps when call getBasketData again ---
    self.productsAttempts = [];

    // --- States ---
    self.firstDataLoad = ko.observable(false);
    self.updating = ko.observable(false);
    self.addingItem = ko.observable(false);


    // --- Autocomplete things
    self.autcompSource = getMatchingPartnumbers;
    self.listOfMatches = ko.observableArray([]);
    self.enabledAutocomplete = ko.observable(true);

    self.quantitySelected = -1;

    // --- More info component ---
    var MoreInfo = new MoreInfoComponent();
    var Oci = new OciComponent();

    /**
     * Go to orders
     */
    self.goToOrder = function (source) {

        if (isAnyProductErpUpdating()) return;

        var deferred = $.Deferred();

        if (self.erpUnaffordableRemovableProducts() && hasInvalidProducts()) {
            deferred = createConfirmDialog('modal-component', BASKET_MESSAGES.modalInvalidProductsTitle, BASKET_MESSAGES.modalInvalidProductsMessage,
                BASKET_MESSAGES.modalDeleteCancelButtonText, BASKET_MESSAGES.modalDeleteConfirmButtonText, true);
        } else {
            deferred.resolve();
        }

        deferred.then(function(){
            //Log go to order
            REPOSITORY.doGoToBasketLog(source, {
                success: function(){
                    if(self.erpUnaffordableRemovableProducts()) {
                        self.deleteInvalidProducts().then(function (res) {
                            window.location.href = orderPageRelativePath;
                        }, function (error) {});
                    } else {
                        window.location.href = orderPageRelativePath;
                    }
                }, error: function(err) {
                    console.log(err);
                }
            });
        }, function(err){
            console.log(err);
        });

    }

    self.goToOrderMenu = function (data, e) {
        if (!isAnyProductErpUpdating() && self._products.length > 0) {
            e.preventDefault();
            self.goToOrder('BASKET LAYER');
        }
    }

    self.confirmOci = function(){
        if (isAnyProductErpUpdating()) return;

        if (hasInvalidProducts()) {

            createConfirmDialog('modal-component', BASKET_MESSAGES.modalInvalidProductsTitle, BASKET_MESSAGES.modalInvalidProductsMessage,
                BASKET_MESSAGES.modalDeleteCancelButtonText, BASKET_MESSAGES.modalDeleteConfirmButtonText, true,
                function (confirm) {

                    if (confirm) {
                        self.deleteInvalidProducts().then(function (res) {
                            if (res) {
                                Oci.confirmOciOrder();
                            }
                        }, function (error) {});

                    }

                });

        } else {
            Oci.confirmOciOrder();
        }


    }

    self.confirmSapariba = function() {
        REPOSITORY.doGenerateSaparibaXml().then(function(res){

            if(res.response != null) {
                self.deleteForceAll().always(function(){
                    $('#cxml-urlencoded').val(res.response);
                    $('#sapariba-form').attr('action', saparibaFormPostUrl);
                    $('#sapariba-form').submit();
                });
            }

        }, function(err){
            console.log(err);
        });
    }

    //Operacion para añadir un partnumber en funcion del select
    self.addToBasketSubmit = function (partnumberToAdd, partnumberType, source) {

        var internalDeferred = $.Deferred();

        if(self.addingItem()) {

            internalDeferred.reject();

        } else {

            var partnumberToAdd = self.boxInputPartnumber();
            if(partnumberToAdd.trim() === '') {
                return;
            }
            if (partnumberType === PartnumberTypeEnum.PARTNUMBER) {

                internalDeferred.resolve(partnumberToAdd);

            } else if (partnumberType === PartnumberTypeEnum.CUSTOMER_PARTNUMBER) {

                //Add customer partnumber
                REPOSITORY.doIsAliasExists(partnumberToAdd, {
                    success: function (res) {
                        if (res == null) {
                            //Call to create new customer partnumber
                            if(selectedErp===DYNAMICS_ERP){
                                internalDeferred.resolve(partnumberToAdd);
                            }else{
                                showModalCPN(partnumberToAdd);
                            }
                        } else {
                            internalDeferred.resolve(res.partnumber);
                        }
                    },
                    error: function (err) {
                        internalDeferred.reject();
                    }
                });

            } else {

                REPOSITORY.doIsPartnumberExists(partnumberToAdd, {
                    success: function (res) {
                        if (res.response == true) {
                            internalDeferred.resolve(partnumberToAdd);
                        } else {
                            self.isAliasExists(internalDeferred, partnumberToAdd);
                        }
                    },
                    error: function (err) {
                        self.isAliasExists(internalDeferred, partnumberToAdd);
                    }
                });

            }

        }

        internalDeferred.then(function (res) {
            self.addToBasket([new BasketPartnumberToAdd(res, self.boxInputQuantity())], source).catch(function(err) {
                console.log("[addToBasketSubmit] addToBasket deferred: productAlreadyAdded or general error");
            });
        }).always(function () {
            self.boxInputPartnumber('');
            self.boxInputQuantity(1);
        });

    };

    self.isAliasExists = function(internalDeferred, partnumberToAdd) {

        REPOSITORY.doIsAliasExists(partnumberToAdd, {
            success: function (res) {
                if (res == null) {
                    internalDeferred.resolve(partnumberToAdd);
                } else {
                    internalDeferred.resolve(res.partnumber);
                }
            },
            error: function (err) {
                internalDeferred.resolve(partnumberToAdd);
            }
        });

    }

    self.addToBasketSimpleSubmit = function (source) {

        if(self.boxInputPartnumberLayer().trim() === '') {
            return;
        }

        self.addToBasket([new BasketPartnumberToAdd(self.boxInputPartnumberLayer(), 1)], source).done(function() {
            self.boxInputPartnumberLayer('');
        });
    }

    //DELETE FROM KO PRODUCT LIST
    self.deleteFromObservableProducts = function (ids) {
        for (var i = 0; i < ids.length; i++) {
            var index = self.products().map(function(x) {
                return x.basketProductId;
            }).indexOf(ids[i]);
            self.products.splice(index, 1);
            self.productsFilter.splice(index, 1);
            self._products = copyArray(self.products());
        }
    }

    //DELETE PRODUCTS FROM KO LIST AND SERVICE
    self.deleteFromBasket = function (ids, source) {

		if (!ids || ids.length == 0) {

            return smc.NotifyComponent.error(BASKET_MESSAGES.nothingSelected);

		} else {

            var message;
            if(ids.length == self.products().length) {
                message = BASKET_MESSAGES.modalEmptyDeleteMessage;
            } else {
                message = BASKET_MESSAGES.modalDeleteMessage;
            }

            var deferred = createConfirmDialog('modal-component', BASKET_MESSAGES.modalDeleteTitle, message,
                BASKET_MESSAGES.modalDeleteCancelButtonText, BASKET_MESSAGES.modalDeleteConfirmButtonText, true);

            deferred.then(function() {
                ids = checkIfNotArrayParam(ids);

                putProductsLoading(ids);

                REPOSITORY.doDeleteBasket(ids, source, null, {
                    success: function (data) {
                        self.deleteFromObservableProducts(ids);
                        updateCartNumber();
                    },
                    error: function (error) {
                        console.log(error);
                    }
                });
            });

        }

    };

    self.deleteFromBasketAll = function (source) {

        var ids = [];
        if (self.products().length > 0) {
            for (var i = 0; i < self.products().length; i++) {
                ids.push(self.products()[i].basketProductId);
            }

            self.deleteFromBasket(ids, source);
        }

    };

    self.deleteForceAll = function() {

        var deferred = $.Deferred();

        var ids = [];
        if (self.products().length > 0) {
            for (var i = 0; i < self.products().length; i++) {
                ids.push(self.products()[i].basketProductId);
            }

            REPOSITORY.doDeleteBasket(ids, null, false, {
                success: function (data) {
                    self.deleteFromObservableProducts(ids);
                    updateCartNumber();
                    deferred.resolve();
                },
                error: function (error) {
                    console.log(error);
                    deferred.reject();
                }
            });
        } else {
            deferred.reject();
        }

        return deferred.promise();
    }

    self.deleteSelected = function (source) {
        var selectedIds = getSelectedItemsField('basketProductId');
        self.deleteFromBasket(selectedIds, source);
    }

    //Return deferred with result when resolved else on error rejected
    self.deleteInvalidProducts = function () {

        var deferred = $.Deferred();

        var ids = getInvalidProducts();
        ids = checkIfNotArrayParam(ids);

        if (ids.length > 0) {
            REPOSITORY.doDeleteBasket(ids, null, null, {
                success: function (data) {
                    self.deleteFromObservableProducts(ids);
                    updateCartNumber();
                    deferred.resolve(true);
                },
                error: function (error) {
                    console.log(error);
                    deferred.reject();
                }
            });
        } else {
            deferred.resolve(false);
        }

        return deferred.promise();
    }

    self.addToBasket = function (basketPartnumberToAddArr, source) {

        if ($.isArray(basketPartnumberToAddArr)){
            var filtered = basketPartnumberToAddArr.filter(function(value, index, arr){
                return value.partnumbercode.trim() !== '';
            });
            basketPartnumberToAddArr = filtered;
        }

        var deferred = $.Deferred();

        //Prevents multiple calls
        if(self.addingItem()) {
            console.log('Add to basket cancelled. Due work in progress');
            deferred.reject(new BasketError(BASKET_ERROR_CODES.ADD_TO_BASKET_ALREADY_WORKING));
            return deferred.promise();
        }

        self.addingItem(true);

        REPOSITORY.doAddToBasket(basketPartnumberToAddArr, source).then(function(res) {
                if (res.errorCode === BASKET_ERROR_CODES.PRODUCTS_ALREADY_INSERTED_ALL) {
                    var message = BASKET_MESSAGES.allProductsAlreadyAdded;
                    if(basketPartnumberToAddArr.length === 1) {
                        message = BASKET_MESSAGES.productAlreadyAdded;
                    }
                    smc.NotifyComponent.error(message);
                    deferred.reject(new BasketError(BASKET_ERROR_CODES.PRODUCTS_ALREADY_INSERTED_ALL));
                } else {
                    self.updating(true);

                    if(res.body) {
                        // Reset attempts for products


                        for(var i=0; i<res.body.length; i++) {
                            self._products.push(new BasketProduct(self, res.body[i]));
                        }
                        self.products(self._products);
                        orderAndFilter();
                    }

                    self.getBasketData();

                    if (res.errorCode === BASKET_ERROR_CODES.PRODUCTS_ALREADY_INSERTED_SOME) {
                        smc.NotifyComponent.warn(BASKET_MESSAGES.someProductsAdded);
                    } else {
                        var message = BASKET_MESSAGES.productsAdded;
                        if(basketPartnumberToAddArr.length == 1) {
                            message = BASKET_MESSAGES.productAdded;
                        }
                        smc.NotifyComponent.info(message);
                    }

                }
                deferred.resolve(res.body);
                updateCartNumber();

            }).catch(function(err) {
                // Some products not added to basket
                smc.NotifyComponent.error(BASKET_MESSAGES.someProductsAdded);
                deferred.reject(new BasketError(BASKET_ERROR_CODES.INTERNAL_SERVICE_ERROR));
            }).always(function() {
                self.addingItem(false);
            });

        return deferred.promise();

    };

    self.importModal = function() {
        let fileInput = document.getElementById('importBasket');
        var deferred = $.Deferred();

        createConfirmAsyncDialog('modal-bsk-import', null, null, cancelBtn, importBtn, true, 'error-dialog-import',function(confirm){
            if(confirm){
                $(fileInput).trigger('click');

            }
            return deferred.resolve();
        });

    }



    self.uploadFile = function(){
        var deferred = $.Deferred();
        let fileInput = document.getElementById('importBasket');
        //Prevents multiple calls
        if(self.addingItem()) {
            console.log('Add to basket cancelled. Due work in progress');
            deferred.reject(new BasketError(BASKET_ERROR_CODES.ADD_TO_BASKET_ALREADY_WORKING));
            return deferred.promise();
        }

        self.addingItem(true);

        const file = fileInput.files[0];

        if(!isValidImportFile(file)){
            self.addingItem(false);
            return smc.NotifyComponent.error(BASKET_MESSAGES.invalidFormatFile);
        }

        smc.NotifyComponent.info(BASKET_MESSAGES.startImportBasket);
        REPOSITORY.doImportFile(file)
            .then(function(e) {
                addToBasketCallback(e, deferred);
            })
            .catch(function(e){
                deferred.reject(new BasketError(BASKET_ERROR_CODES.INTERNAL_SERVICE_ERROR));
                self.addingItem(false);
                smc.NotifyComponent.error(BASKET_MESSAGES.errorImportBasket);
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

    self.addToFavouriteSelecteds = function () {

        var selecteds = getFavouriteElements();
        /*selecteds = _.map(selecteds, function(selected){
            return new FavouriteToAdd(selected, null, {});
        });*/
        if (selecteds.length == 0) {

            return smc.NotifyComponent.error(BASKET_MESSAGES.nothingSelected);
            
        } else {

            self.addToFavourites(selecteds);

        }

    }

    self.addToFavourites = function(favourites, source) {

        var deferred = $.Deferred();

        //If no loged in page redirect to login and reload with requested action
        if(typeof favouritesFoldersViewModel === 'undefined') {
            let joins = favourites;

            var dataToSend = [];
            dataToSend.push(joins);
            dataToSend.push(source);

            var dataToSendString = JSON.stringify(dataToSend);
            dataToSendString = encodeURI(dataToSendString);

            var originUrl = new URL(window.location.href);
            originUrl.searchParams.set('componentId', 'BasketViewModel');
            originUrl.searchParams.set('action', 'addToFavourites');
            originUrl.searchParams.set('actionParams', dataToSendString);

            var url = new URL(originUrl.origin + '/secured-resource');
            url.searchParams.set('resource', originUrl.toString().replace(originUrl.origin, ''));
            window.location = url;

            deferred.reject();

        } else {

            //Check if favourites isnt array
            if (!($.isArray(favourites))){
                favourites = favourites.split(',');
            }

            var modalDeferred = favouritesFoldersViewModel.show();
            modalDeferred.then(function (selectedFolder) {

                REPOSITORY.doAddToFavourite(favourites, selectedFolder, 'BASKET', {
                    success: function (res) {
                        deferred.resolve();
                        smc.NotifyComponent.info(BASKET_MESSAGES.favouritesSuccess);
                    }, error: function(err) {
                        deferred.reject();
                        smc.NotifyComponent.error(BASKET_MESSAGES.favouritesError);
                    }
                });

            }).catch(function(err) {
                deferred.reject(new BasketError(BASKET_ERROR_CODES.UI_MODAL_REJECTED));
            });

        }

        return deferred.promise();

    }

    //TODO: METER ESTO DENTRO DEL BASKET PRODUCT
    self.getDetails = function (partnumber, basketProduct) {

        REPOSITORY.doGetPartnumberDetails(
            partnumber(), {
                success: function (res) {
                    try {
                        if (!res || res.status === 'ERROR' || !res.info || res.info.length === 0) return;
                        var detailsSliceResult = slicePartnumberDetails(res.info[0].details);
                        var observableDetail = {
                            detailsPart1: detailsSliceResult[0],
                            detailsPart2: detailsSliceResult[1],
                        };
                        basketProduct.details(observableDetail);
                    } catch (e) {
                        console.error('Error retrieving details', e);
                    }
                }
            }
        )
    }

    self.clearFilter = function() {
        self.filter('');
    }

    self.changeQuantity = function () {}

    let xhrBasketData = null;
    self.getBasketData = function (updatingQty) {

        if(xhrBasketData && updatingQty) {
            xhrBasketData.abort();
        }

        let tempXhrBasketData = REPOSITORY.doGetBasketData(self.selectBasketOrder(), {
            success: function (data) {

                self.totalListPrice(data.totalListPrice);
                self.totalNetPrice(data.totalNetPrice);
                self.totalListPriceWithCharges(data.totalListPriceWithCharges.toFixed(2));
                self.totalNetPriceWithCharges(data.totalNetPriceWithCharges.toFixed(2));
                self.orderCharges(data.orderCharges.toFixed(2));
                //self.updating(data.updating);
                self.currency(data.currency);
                self.erpUnaffordableRemovableProducts(data.erpUnaffordableRemovableProducts);
                self.basketId(data.basketId);

                var bProducts = [];
                if (self.firstDataLoad()) {

                    bProducts = copyArray(self._products);
                    let bProductsResult = [];

                    for (var i = 0; i < data.basketProducts.length; i++) {
                        var bProduct = data.basketProducts[i];

                        var bProductExists = checkIfProductExistsInBasket(bProduct);
                        if (bProduct.status !== self.StateType.UPDATING || bProduct.partnumberStatus !== self.StateType.UPDATING) {

                            if (bProductExists) {
                                if(bProductExists.updatingQty && bProduct.status !== self.StateType.UPDATING) {
                                    bProductExists.updatingQty = false;
                                }
                                bProductExists.updateBasketProductData(bProduct);
                                bProductsResult.push(bProductExists);
                            } else {
                                bProductExists = new BasketProduct(self, bProduct);
                                bProductsResult.push(bProductExists);
                            }

                        } else {

                            if (bProductExists) {
                                bProductsResult.push(bProductExists);
                            }

                        }
                    }

                    bProducts = copyArray(bProductsResult);

                } else {

                    for (var i = 0; i < data.basketProducts.length; i++) {
                        var bProduct = new BasketProduct(self, data.basketProducts[i]);
                        bProducts.push(bProduct);
                    }

                }
                self._products = copyArray(bProducts);
                self.products(bProducts);
                self.productsFilter(bProducts);
                orderAndFilter();

                updateCartNumber();

                self.updating(isAnyProductUpdating());

                if (!self.firstDataLoad()) {
                    self.dataLoaded.resolve();
                    self.firstDataLoad(true);
                }

            },
            error: function (error) {
                console.log(error);
                self.firstDataLoad(true);
                self.dataLoaded.reject();
            }
        }).always(function() {
            // Set self.updatingQuantity to false in products

        });

        if(updatingQty) {
            xhrBasketData = tempXhrBasketData;
        }

    }

    self.updatePreferredDeliveryDate = function (productId, date) {

        var deferred = $.Deferred();

        date = window.koDate.requestDateStringFormatted(date);

        REPOSITORY.doSetPreferredDeliveryDate(productId, date, {
            success: function (res) {
                self.getBasketData();
                deferred.resolve();
            },
            error: function (err) {
                deferred.reject();
            }
        });

        return deferred.promise();

    }

    // ---- Autocomplete ----
    var xhr;

    self.getMatches = function (searchTerm, sourceArray) {

        if (xhr) xhr.abort();

        try {

            xhr = REPOSITORY.doPartnumbersMatching(searchTerm, {
                success: function (data) {

                    var result = [];
                    for (var i = 0; i < data.length; i++) {
                        var item = {
                            value: data[i]
                        };
                        result.push(item);
                    }
                    sourceArray(result);

                }
            });

        } catch (err) {}

    }

    //TODO: REDUCE COMPLEXITY
    self.addAliasWithProduct = function (basketProduct) {

        var customerPartnumberInput = basketProduct.customerPartnumberInput();
        var basketProductId = basketProduct.basketProductId;

        if (customerPartnumberInput !== '') {

            REPOSITORY.doGetCustomerPartnumber(basketProduct.partnumber(), {
                success: function (res) {

                    //TODO COMprobar que existe
                    // Mensaje anterior ->> 'Do you want to associate partnumber \'' + basketProduct.partnumber + '\' with alias \'' + basketProduct.customerPartnumberInput()
                    createConfirmDialog('modal-component', BASKET_MESSAGES.modalAssociatePnCpnTitle, BASKET_MESSAGES.modalAssociatePnCpnMessage,
                        BASKET_MESSAGES.cancel, BASKET_MESSAGES.accept, true,
                        function (confirm) {
                            if (confirm) {

                                REPOSITORY.doAddCustomerPartnumberToProduct(customerPartnumberInput, basketProductId, {
                                    success: function (resInt) {
                                        console.log("Updating with " + customerPartnumberInput + " product " + basketProduct.partnumber());
                                        basketProduct.customerPartnumber(customerPartnumberInput);
                                        basketProduct.status(OrderStateTypeEnum.UPDATING);
                                        self.getBasketData();
                                    },
                                    error: function (err) {
                                        console.log("Error asociating CPN");
                                        showInvalidCpnDialog();
                                        basketProduct.customerPartnumberInput('');
                                    }
                                }).always(function () {
                                    basketProduct.status(OrderStateTypeEnum.UPDATED);
                                    basketProduct.updatingCpn(false);
                                });

                            } else {
                                basketProduct.customerPartnumberInput('');
                                basketProduct.status(OrderStateTypeEnum.UPDATED);
                                basketProduct.updatingCpn(false);
                            }
                        });

                },
                error: function (err) {
                    showInvalidCpnDialog();
                    basketProduct.customerPartnumberInput('');
                    basketProduct.status(OrderStateTypeEnum.UPDATED);
                    basketProduct.updatingCpn(false);
                }

            });

        }

    }

    self.addAlias = function (alias, basketProductId) {

        var deferred = $.Deferred();

        REPOSITORY.doAddCustomerPartnumberToProduct(alias, basketProductId, {
            success: function (res) {
                deferred.resolve(res);
            },
            error: function (err) {
                // Enhace error handling
                deferred.reject(BASKET_ERROR_CODES.INTERNAL_SERVICE_ERROR);
            }
        });

        return deferred.promise();

    }


    self.saveBasket = function(){
        var deferred = $.Deferred();
        if(self.products().length === 0){
            return createConfirmDialog('modal-save-empty-basket', null, null, acceptBtn, null, true, null);
        }
        createConfirmAsyncDialog('modal-save-mybaskets', null, null, cancelBtn, saveBtn, true, 'error-dialog-save',function(confirm){
            if(confirm){
                if(!self.description() || self.description().length === 0) {
                    return deferred.reject(basketSaveEmptyDescription);
                }
                return REPOSITORY.doSaveBasket(self.description(), self.comments(), {
                    success: function(data){
                        self.comments('');
                        self.description('');
                        document.getElementById('descriptionInput').classList = 'form-control';
                        smc.NotifyComponent.info(BASKET_MESSAGES.successSaveBasket);

                        return deferred.resolve();
                    },
                    error: function(){
                        smc.NotifyComponent.error(errorSaveBasket);

                        return deferred.reject(basketSaveError);
                    }
                })
            }
            return deferred.resolve();
        });

    }

    //BasketViewModel first load complete deferred
    self.getDeferredFirstLoad = function () {
        return self.dataLoaded.promise();
    }

    // -------------------
    // --- Subscribers ---
    // -------------------
    self.selectAll.subscribeChanged(function (newValue, oldValue) {
        ko.utils.arrayForEach(self.products(), function (prod) {
            prod.selected(newValue);
        });
    });

    self.updating.subscribe(function (newValue) {
        if (newValue) {
            if (!prevInterval) {
                setTimer();
            }
        } else {
            clearTimer();
        }
    });

    self.products.subscribe(function (newValue, oldValue) {
        updateTotalPrices(newValue);
    });

    self.selectPartnumberType.subscribe(function (newValue) {
        self.enabledAutocomplete(newValue !== PartnumberTypeEnum.CUSTOMER_PARTNUMBER);
    });

    self.filter.subscribeChanged(function () {
        orderAndFilter();
    });

    self.order.subscribeChanged(function () {
        orderAndFilter();
    });

    self.boxInputPartnumber.subscribe(function (newValue) {
        if (!preventSubscribePartnumber) {
            preventSubscribePartnumber = true;
            self.boxInputPartnumberLayer(newValue);
            preventSubscribePartnumber = false;
        }
    });

    self.boxInputPartnumberLayer.subscribe(function (newValue) {
        if (!preventSubscribePartnumber) {
            preventSubscribePartnumber = true;
            self.boxInputPartnumber(newValue);
            preventSubscribePartnumber = false;
        }
    });

    self.askToSmcGeneralInput = ko.observable('');

    self.getEntireSelected = ko.computed(function() {
        var selecteds = [];
        ko.utils.arrayForEach(self.products(), function (prod) {
            if (prod.selected()) {
                selecteds.push(prod);
            }
        });
        return selecteds;
    });

    self.showAskSmcModal = function() {
        var selecteds = getSelectedItemsField('partnumber', true);
        if (selecteds.length == 0) {
            return smc.NotifyComponent.error(BASKET_MESSAGES.nothingSelected);
        } else {
            $('#ask-smc-modal').modal('show');
        }
    }

    self.askSmc = function() {

        var selecteds = self.getEntireSelected();
        var items = [];
        for(var i = 0; i < selecteds.length; i++) {
            var currentItem = new AskToSmcItem(selecteds[i]);
            items.push(currentItem);
        }
        REPOSITORY.doAskToSmc(items, self.askToSmcGeneralInput(),{
            success: function(res) {}, error: function() {
                smc.NotifyComponent.error(BASKET_MESSAGES.errorSendingAskToSmc);
            }
        });

        $('#ask-smc-modal').modal('hide');
        clearAskSmcForm();

    }

    // More Info component
    self.getProductMoreInfo = function(partNumber, index, type, description){
        MoreInfo.getTooltip(partNumber, index, "bsk", type, description);
    }

    self.getLayerMoreInfo = function(product){
        MoreInfo.getIconTooltip(product.partnumber(), "bsklayer", product.personalizedType(), product.name());

    }

    //Import component
    self.importBasket = function(){

    }

    //Export Component
    self.exportBasket = function(format, type){
        const selected = getExportElements();
        
        if(selected.length === 0) {
            return smc.NotifyComponent.error(BASKET_MESSAGES.labelExportNotSelected);
        }


        REPOSITORY.doExportBasket(selected, format, type).then(
            function(res){
                window.open(res);
            }
        )
        .catch(function(err){
            console.error(JSON.stringify(err))
            smc.NotifyComponent.error(BASKET_MESSAGES.labelExportError);
        });
    }

    // Obtain selected items info
    self.getSelected = function() {
        return self.getEntireSelected();
    }

    // -------------------
    // -------------------


    self.splitString = function (data, separator, part, includeSep) {
        return splitString(data, separator, part, includeSep);
    };

    // -------------------
    // --Private methods--
    // -------------------

    /**
     * Clear ask smc form
     */
    var clearAskSmcForm = function() {
        var selecteds = self.getEntireSelected();
        for(var i = 0; i < selecteds.length; i++) {
            selecteds[i].askSmcObservation('');
        }
        self.askToSmcGeneralInput('');
    }

    /**
     * Checks if product exists into current basket
     * @param basketProduct 
     */
    var checkIfProductExistsInBasket = function (basketProduct) {

        for (var i = 0; i < self._products.length; i++) {

            if (self._products[i].basketProductId === basketProduct.id) {
                return self._products[i];
            }

        }

        return null;

    }

    /**
     * Put list of products by id to status loading
     * @param ids array of ids of products
     */
    var putProductsLoading = function(ids) {

        for(let i = 0; i < ids.length; i++) {

            let product = checkIfProductExistsInBasket({id: ids[i]});
            product.status(OrderStateTypeEnum.UPDATING);

        }

    }

    /**
     * Creates an simple array of elements for specified field of objects in source array
     * @param fieldName Field name to select
     */
    var getSelectedItemsField = function (fieldName, observable) {

        var selectedIds = [];
        ko.utils.arrayForEach(self.products(), function (prod) {
            if (prod.selected()) {
                var getValue = Object.byString(prod, fieldName);
                if(observable) {
                    selectedIds.push(getValue());
                } else {
                    selectedIds.push(getValue);
                }
            }
        });
        return selectedIds;

    }

    /**
     * Creates an array of favourite elements
     */
    var getFavouriteElements = function () {

        return _(self.products()).filter(function(prod){
            return prod.selected();
        })
        .map(function(prod){
            let favouriteToAdd = new FavouriteToAdd(prod.partnumber(), prod.customerPartnumber(), {});
            favouriteToAdd.setPersonalizedFields(prod.personalizedPartnumber(), prod.personalizedType(), prod.name());
            return favouriteToAdd;
        });

    }


    const exportProduct = function exportProduct(product){
        return {
            partnumbercode: product.partnumber(),
            customerPartnumber: product.customerPartnumber(),
            serie: product.serie(),
            familyName:product.familyName(),
            description: product.name(),
            image: product.mediumImage(),
            netPrice: product.netPrice(),
            listPrice: product.listPrice(),
            currency: product.currency(),
            measurementUnit: product.measurementUnit(),
            quantity: product.quantity() || 0
        };
    };

    const exportLines = function(product){
        return _(product.lines()).map(function(line){
            return {
                partnumbercode: product.partnumber(),
                quantity: line.quantity(),
                customerPartnumber: product.customerPartnumber(),
                serie: product.serie(),
                familyName:product.familyName(),
                description: product.name(),
                image: product.mediumImage(),
                netPrice: product.netPrice(),
                listPrice: product.listPrice(),
                totalNetPrice: line.totalNetPrice(),
                totalListPrice: line.totalListPrice(),
                deliveryDate: line.deliveryDate(),
                currency: product.currency(),
                measurementUnit: product.measurementUnit()
            };
        });
   }

      /**
     * Creates an array of basket elements to export
     */
    var getExportElements = function () {

        let products = _(self.products()).filter(function(prod){
            return prod.selected();
        });

        let contactenatedLinesArray = [];
        _(products).map(function(element){
            if(isLightUser || isTechnicalUser || !element.lines() || element.lines().length === 0){
                return exportProduct(element); //[exportProduct(element)]
            } else {
                return exportLines(element);
            }

        }).forEach(function(lineArray){
            contactenatedLinesArray = contactenatedLinesArray.concat(lineArray);
        });

        return contactenatedLinesArray;

    }

    /**
     * Check if param is not array
     * @param arr param to check
     */
    var checkIfNotArrayParam = function (arr) {

        var result = arr;

        if (!($.isArray(arr))) {
            result = [arr];
        }

        return result;

    };

    /**
     * Update del numero del carro
     */
    var updateCartNumber = function () {
        $('.main-header__cart__amount').text(self.products().length);
    };

    var prevInterval = null;

    /**
     * Sets timer for recover data from basket service
     */
    var setTimer = function () {
        clearTimer();
        prevInterval = setInterval(function () {
            self.getBasketData();
        }, INTERVAL_TIMER_MS);
    };

    /**
     * Clears timer for stop getting data from basket service
     */
    var clearTimer = function () {
        if (prevInterval) {
            clearInterval(prevInterval);
            prevInterval = null;
        }
    };

    /**
     * Checks if basket have invalid products
     */
    var hasInvalidProducts = function () {
        return getInvalidProducts().length > 0;
    }

    /**
     * Gets basket invalid products
     */
    var getInvalidProducts = function () {
 
        var ids = [];

        for (var i = 0; i < self.products().length; i++) {
            if (self.products()[i].valid() === false && self.products()[i].status() !== self.StateType.UPDATING) {
                ids.push(self.products()[i].basketProductId);
            }
        }

        return ids;
    }

    /**
     * Order and filter basket products
     */
    var orderAndFilter = function () {

        var newArray = self._products.filter(function (el) {

            var foundPartnumber = !el.partnumber() || el.partnumber() == '' ? false : el.partnumber().indexOf(self.filter().toUpperCase()) > -1;
            var foundCustomerPartnumber = !el.customerPartnumber() || el.customerPartnumber() == '' ? false : el.customerPartnumber().toUpperCase().indexOf(self.filter().toUpperCase()) > -1;
            var foundDescription = !el.name() || el.name() == '' ? false : el.name().toUpperCase().indexOf(self.filter().toUpperCase()) > -1;

            var found;
            if(!self.filter() || self.filter() === '') {
                found = true;
            } else {
                found = foundPartnumber || foundCustomerPartnumber || foundDescription;
            }

            return found;
        });
        self.productsFilter(newArray);
    }

    /**
     * Shows modal for invalid customer partnumber
     */
    var showInvalidCpnDialog = function () {
        createConfirmDialog('modal-component', 'Invalid customer partnumber', 'Inserted partnumber already exists',
            closeBtn, null, false);
    }

    var updateTotalPrices = function (data) {
        var totalListPrice = 0,
            totalNetPrice = 0;

        for (var i = 0; i < data.length; i++) {
            totalNetPrice += parseFloat(data[i].totalNetPrice());
            totalListPrice += parseFloat(data[i].totalListPrice());
        }

        self.totalListPrice(totalListPrice.toFixed(2));
        self.totalNetPrice(totalNetPrice.toFixed(2));

        if( data.length > 0 ){
            totalNetPrice += parseFloat(self.orderCharges());
            totalListPrice += parseFloat(self.orderCharges());

            self.totalNetPriceWithCharges(totalNetPrice.toFixed(2));
            self.totalListPriceWithCharges(totalListPrice.toFixed(2));
        } else {
            var zero_temp = 0;
            self.totalNetPriceWithCharges(zero_temp.toFixed(2));
            self.totalListPriceWithCharges(zero_temp.toFixed(2));
        }
    }

    var selectOrderIntoSelectorArray = function (field, orderType) {

        var selectedOption = self.basketProductOrderArr[0];
        for (var i = 0; i < self.basketProductOrderArr.length; i++) {
            if (self.basketProductOrderArr[i].order.field === field && self.basketProductOrderArr[i].order.orderType === orderType) {
                selectedOption = self.basketProductOrderArr[i];
            }
        }
        return selectedOption;

    }

    const resetProductsAttempts = function() {
        self.products().forEach(function(element) {
            element.attempts = 0;
        });
    }

    const isAnyProductErpUpdating = function() {
        let found = false;
        self.products().forEach(function(element) {
            if(element.status() === self.StateType.UPDATING) {
                found = true;
            }
        });
        return found;
    }

    const isAnyProductUpdating = function() {
        let found = false;
        self.products().forEach(function(element) {
            if(element.attempts <= MAX_NUMBER_OF_ATTEMPTS && (element.status() === self.StateType.UPDATING || element.partnumberStatus() === self.StateType.UPDATING)) {
                found = true;
            }
        });
        return found;
    }

    const addToBasketCallback = function(res, deferred) {
        if (res.errorCode === BASKET_ERROR_CODES.PRODUCTS_ALREADY_INSERTED_ALL
                || res.errorCode === BASKET_ERROR_CODES.IMPORT_ERROR
                || res.errorCode === BASKET_ERROR_CODES.IMPORT_FORMAT_ERROR
                ) {
            var message = getErrorMessage(res.errorCode);

            createConfirmDialog('modal-component', BASKET_MESSAGES.basketTitle, message,
            closeBtn, null, false);
            deferred.reject(new BasketError(res.errorCode));
        } else {
            self.updating(true);

            if(res.body) {
                resetProductsAttempts();
                for(var i=0; i<res.body.length; i++) {
                    self._products.push(new BasketProduct(self, res.body[i]));
                }
                self.products(self._products);
                orderAndFilter();
            }

            self.getBasketData();

            if (res.errorCode === BASKET_ERROR_CODES.PRODUCTS_ALREADY_INSERTED_SOME) {
                smc.NotifyComponent.warn(BASKET_MESSAGES.someProductsAdded);
            } else {
                var message = BASKET_MESSAGES.productsAdded;
                smc.NotifyComponent.info(message);
            }

        }
        deferred.resolve(res.body);
        updateCartNumber();
        self.addingItem(false);
    }

    const getErrorMessage = function(code){
        switch(code){
            case BASKET_ERROR_CODES.IMPORT_ERROR:
                return BASKET_MESSAGES.errorImportBasket;
            case BASKET_ERROR_CODES.IMPORT_FORMAT_ERROR:
                return BASKET_MESSAGES.invalidFormatFile;
            default:
                return BASKET_MESSAGES.allProductsAlreadyAdded;

        }
    }

    // -------------------
    // -------------------

    //----------------------------------------
    // --- Modal customer partnumber logic ---
    // Defined at the end of view
    // model for prevent undefined
    // attributes
    //----------------------------------------
    //-- Modal attributes
    self.createCustomerPartnumberPN = ko.observable('');
    self.createCustomerPartnumberCPN = ko.observable('');
    self.createCustomerPartnumberError = ko.observable('');
    self.customerPnModalIsVisible = ko.observable(false);

    //-- Modal private functions
    var addAliasModal = function () {

        var deferred = $.Deferred();

        REPOSITORY.doAddCustomerPartnumber(self.createCustomerPartnumberCPN(), self.createCustomerPartnumberPN(), {
            success: function (resInt) {
                deferred.resolve();
                var partnumberUpdate = self.createCustomerPartnumberPN();
                self.addingItem(true);
                self.addToBasket([new BasketPartnumberToAdd(partnumberUpdate, self.boxInputQuantity())]).catch(function(){
                    REPOSITORY.doUpdatePartnumbers([partnumberUpdate]).then(function(){
                        self.getBasketData();
                    });
                });
                clearCpnModalVars();
                self.boxInputPartnumber('');
                self.boxInputQuantity(1);
            },
            error: function (err) {
                self.createCustomerPartnumberError('Asociation to this partnumber already exists.');
                //REPOSITORY.doUpdatePartnumbers([self.createCustomerPartnumberPN()]);
                deferred.reject();
            }
        }).always(function() {

        });

        return deferred.promise();

    }

    var clearCpnModalVars = function () {
        self.createCustomerPartnumberPN('');
        self.createCustomerPartnumberCPN('');
        self.createCustomerPartnumberError('');
    }

    var showModalCPN = function (partnumberToAdd) {
        self.createCustomerPartnumberCPN(partnumberToAdd);
        self.customerPnModalIsVisible(true);
    }

    self.customerPnModalIsVisible.subscribe(function (newValue) {
        if (newValue) {
            self.createCustomerPartnumberPN('');
            self.createCustomerPartnumberError('');
        }
    });

    //-- Modal options
    self.customerPartnumberOptions = {
        acceptLabel: BASKET_MESSAGES.assign,
        cancelLabel: BASKET_MESSAGES.cancel,
        htmlId: 'partnumber-component',
        title: BASKET_MESSAGES.modalAssociatePnCpnTitle,
        deferredFn: addAliasModal,
        isVisible: self.customerPnModalIsVisible
    };
    //----------------------------------------


    //Initialization
    // -- If session have values for order then select specified
    if (basketOrderField && basketOrderType) {
        var selectedOption = selectOrderIntoSelectorArray(basketOrderField, basketOrderType);
        self.selectBasketOrder = ko.observable(selectedOption.order);
        //self.selectBasketOrder = ko.observable({field: basketOrderField, order: basketOrderType});
    } else {
        self.selectBasketOrder = ko.observable(BasketProductOrderEnum.DESCRIPTION);
    }

    // -- Subscribe for selectBasketOrder
    // -- Is here because else is undefined in body of viewmodel
    self.selectBasketOrder.subscribe(function (newValue) {
        //TODO: Call getproducts with new order
        if (self.loadedViewModel()) {
            self.getBasketData();
        }
    });

    self.getBasketData();
    self.loadedViewModel(true);
    $(document).trigger('smc.registercomponent', ['BasketViewModel', self]);

    //Autocomplete configuration
    $(document).ready(function () {
        $("#add-to-cart-partnumber").autocomplete({
            source: self.boxInputPartnumber(),
            minLength: 3
        });
    });

}

//Handle messages
function receiveBasketMessage(event) {
    if(typeof event.data.type !== "undefined" && event.data.type === "1") {
        basketViewModel.addToBasket([new BasketPartnumberToAdd(event.data.partnumber, event.data.quantity)], 'BASKET LAYER').done(function () {
            basketViewModel.boxInputPartnumberLayer('');
        });
    }
}

window.addEventListener('message', receiveBasketMessage, false);
