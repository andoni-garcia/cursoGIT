

function ProjectBookViewModel(){
    var self = this;
    const ProductsOrderFields = {
        PARTNUMBER: 'PARTNUMBER',
        DESCRIPTION: 'NAME',
        SERIE: 'SERIE',
        FAMILY: 'FAMILYNAME',
    };
    
    const ProductsOrderType = {
        ASC: 'ASC',
        DESC: 'DESC',
    };
    
    const showAllProducts = {
        text: PB_MESSAGES.showAllProducts, 
        value: 'all',
    };
    
    const showAditionalProducts = {
        text: PB_MESSAGES.showAdditionalProducts, 
        value: 'additional',
    };
    
    const showPBProducts = {
        text: PB_MESSAGES.showPBProducts, 
        value: 'pb',
    };
    
    const defaultFamily = {
        id: null,
        name: PB_MESSAGES.all,
    };
    
    const defaultShowTypes = {
        text: PB_MESSAGES.showAllProducts,
        value: 'all',
    };

    const defaultFamResponse = {
        families: [],
        subfamilies: []
    };

    const ProductsOrderEnum = {
        PARTNUMBER: {
            order: {
                field: ProductsOrderFields.PARTNUMBER,
                orderType: ProductsOrderType.ASC,
            },
            text: '▲ ' + orderByPartNumber,
        },
        PARTNUMBER_DESC: {
            order: {
                field: ProductsOrderFields.PARTNUMBER,
                orderType: ProductsOrderType.DESC,
            },
            text: '▼ ' + orderByPartNumber,
        },
        FAMILY: {
            order: {
                field: ProductsOrderFields.FAMILY,
                orderType: ProductsOrderType.ASC,
            },
            text: '▲ ' + orderByFamily,
        },
        FAMILY_DESC : {
            order: {
                field: ProductsOrderFields.FAMILY,
                orderType: ProductsOrderType.DESC,
            },
            text: '▼ ' + orderByFamily,
        },
        DESCRIPTION: {
            order: {
                field: ProductsOrderFields.DESCRIPTION,
                orderType: ProductsOrderType.ASC,
            },
            text: '▲ ' + orderByDescription,
        },
        DESCRIPTION_DESC: {
            order: {
                field: ProductsOrderFields.DESCRIPTION,
                orderType: ProductsOrderType.DESC,
            },
            text: '▼ ' + orderByDescription,
        },
        SERIE: {
            order: {
                field: ProductsOrderFields.SERIE,
                orderType: ProductsOrderType.ASC,
            },
            text: '▲ ' + orderBySerie,
        },
        SERIE_DESC: {
            order: {
                field: ProductsOrderFields.SERIE,
                orderType: ProductsOrderType.DESC,
            },
            text: '▼ ' + orderBySerie,
        }
    };

    ko.di.register(self, 'ProjectBookViewModel');
    ko.di.require({
        MESSAGES: 'ProjectBookMessages',
        REPOSITORY: 'ProjectBookRepository',

    }, self);
    ko.iketek.withSelectAll(self, "elements");

    var REPOSITORY = new ProjectBookRepository();
    var BASKET_REPOSITORY = new BasketProductRepository();
    var MoreInfo = new MoreInfoComponent();

    self.customField1 = projectBookCustomField1;
    self.customField2 = projectBookCustomField2;

    self.showTypes = [
        showAllProducts,
        showPBProducts,
        showAditionalProducts
    ];

    self.projectBookOrderList = [
        ProductsOrderEnum.PARTNUMBER,
        ProductsOrderEnum.PARTNUMBER_DESC,
        ProductsOrderEnum.DESCRIPTION,
        ProductsOrderEnum.DESCRIPTION_DESC,
        ProductsOrderEnum.FAMILY,
        ProductsOrderEnum.FAMILY_DESC,
        ProductsOrderEnum.SERIE,
        ProductsOrderEnum.SERIE_DESC,
    ];

    //Observables
    self.families = ko.observableArray([]);
    self.subfamilies = ko.observableArray([]);
    self.filterFamilies = ko.observable(defaultFamily);
    self.filterSubfamilies = ko.observable(defaultFamily);
    self.searchTerm = ko.observable('');
    self.filterShowAditional = ko.observable(self.showTypes[0]);
    self.selectedOrder = ko.observable(ProductsOrderEnum.PARTNUMBER.order);
    self.exporting = ko.observable(false);


    //Main functions

    self.addToBasket = function(product){
        var product = new BasketPartnumberToAdd(product.partNumber(), product.quantity(), null, productPersonalizedInfo(product));
        basketViewModel.addToBasket(product, 'PROJECT BOOKS',{
            success: function (data) {
            },
        })
    }

    self.addToFavouritesSelecteds = function(){
        
        var selecteds = _.map(self.checkedElements(), function(element){
            console.log(element)
            return new FavouriteToAdd(element.partNumber(), null, element.technicalInfo());
        });

        if (selecteds.length == 0) {

            return smc.NotifyComponent.error(BASKET_MESSAGES.nothingSelected);

        } else {

            self.addToFavourites(selecteds);

        }

    }

    self.addToFavourites = function(partnumbers) {

        var deferred = $.Deferred();

        //If no loged in page redirect to login and reload with requested action
        if(typeof favouritesFoldersViewModel === 'undefined') {
            
            var originUrl = new URL(window.location.href);
            originUrl.searchParams.set('componentId', 'SsiViewModel');
            originUrl.searchParams.set('action', 'addToFavourites');
            originUrl.searchParams.set('actionParams', partnumbers);

            var url = new URL(originUrl.origin + smc.channelPrefix + '/secured-resource');
            url.searchParams.set('resource', originUrl.toString().replace(originUrl.origin, ''));
            window.location = url;

            deferred.reject();

        } else {
            var modalDeferred = favouritesFoldersViewModel.show();
            modalDeferred.then(function (selectedFolder) {

                BASKET_REPOSITORY.doAddToFavourite(partnumbers, selectedFolder, 'PROJECT BOOKS', {
                    success: function (res) {
                        deferred.resolve();
                        smc.NotifyComponent.info(PB_MESSAGES.favouritesSuccess);
                    }, error: function(err) {
                        deferred.reject();
                        smc.NotifyComponent.error(PB_MESSAGES.favouritesError);
                    }
                });

            }).catch(function(err) {
                deferred.reject(new BasketError(BASKET_ERROR_CODES.UI_MODAL_REJECTED));
            });
        
        }

        return deferred.promise();

    }

    self.addToBasketItems = function(){
        var elements = self.checkedElements();

        if (elements.length == 0) {
            
            return smc.NotifyComponent.error(BASKET_MESSAGES.nothingSelected);

        } else {

            var productsToAdd = _.map(elements,
                function (obj) {
                    return new BasketPartnumberToAdd(obj.partNumber(), obj.quantity(), null, productPersonalizedInfo(obj));
                }
            );

            var i;
			basketViewModel.addToBasket(productsToAdd, 'PROJECT BOOKS').then(function(){
				array.forEach(function (elem, idx, arr) {
					elements[idx].quantity(1);
				});
            });

        }
    }

    self.getDetails = function(partnumber){
        if(partnumber.hasPersonalizedDetails) return;
        doGetDetails(partnumber);

        var stopInterval = setInterval(function () {
            if (partnumber.technicalInfo() && (partnumber.status() === 'ERROR' || partnumber.status() === 'UPDATED')) {
                clearInterval(stopInterval);
            }

            doGetDetails(partnumber, function () {
                clearInterval(stopInterval);
            });

        }, 10000);
    }

    self.getFamilies = function(familyId, familyName){
        const data = {
            family: familyId,
        };

        GlobalPartnumberInfo.getFamilies(data)
            .then(function(res){
                const parsedFamilies = JSON.parse(res);
                const tmpfamilies = [defaultFamily];
                const tmpSubfamilies = [defaultFamily];
                
                self.families(tmpfamilies.concat(parsedFamilies.families));
                self.subfamilies(tmpSubfamilies.concat(parsedFamilies.subfamilies));
                self.filterFamilies({
                    id: familyId || defaultFamily.id,
                    name: familyName || defaultFamily.name,
                });
                self.filterSubfamilies(defaultFamily);
            
            })
            .catch(function(err){
                smc.NotifyComponent.error("Error loading families");
            });
        
    }

    self.setSubfamilyFilter = function (id, name) {
        self.filterSubfamilies({
            id: id,
            name: name,
        });
    }

    self.unsubscribe = function(){
        var deferred = $.Deferred();

        createConfirmAsyncDialog('modal-pb-unsubscribe', PB_MESSAGES.unsubscribeTitle, PB_MESSAGES.unsubscribeMssg, cancelBtn, deleteBtn, true, 'error-dialog-delete',function(confirm){
            if(confirm){

               return REPOSITORY
                .doUnsubscribe(projectBookId)
                .then(function(res){
                    smc.NotifyComponent.info(PB_MESSAGES.successUnsubscribe);
                    window.location = myProjectBooksUrl;
                    return deferred.resolve();
                })
                .catch(function(){
                    smc.NotifyComponent.error(PB_MESSAGES.errorUnsubscribe);
                    return deferred.reject();
                });

            } 
             
        });
    }

    self.filterProducts = function () {
        self.sortProducts(buildOrderParam(self.selectedOrder()));
    }

    self.sortProducts = function (type) {
        console.log('[Sort products] Sorting', type);
        var order = type || buildOrderParam();
        self.datatable.orderType(order);
        self.datatable.customFilters({
            family: self.filterFamilies().id,
            subfamily: self.filterSubfamilies().id,
            search: self.searchTerm(),
            isAdditional: self.filterShowAditional(),
            projectBook: projectBookId,
            
        });
        self.datatable.refresh();
    }

    self.getProductMoreInfo = function(partNumber, index){
        MoreInfo.getTooltip(partNumber, index, "pb");
    }

    self.showAll = function(){
        self.filterFamilies(defaultFamily);
        self.filterSubfamilies(defaultFamily);
        self.filterShowAditional(defaultShowTypes.value);
        self.searchTerm('');
        self.filterProducts();

    }
    //Datatable functions
    self.normalizeDatatable = function (obj) {

        // SMC-608 Loop for documents and set first '_preview.jpg' as image if exists
        var result = [];
        var response = obj.content || [];
        for (var i = 0; i < response.length; i+=1) {
            let element = response[i];
            if( element.technicalInfo && element.documents ){
                for (var x = 0; x < element.documents.length; x+=1) {
                    let str = element.documents[x]
                    if( str.includes("_preview.jpg") ){
                        element.technicalInfo.image = str;
                        element.customImage = true;
                        break;
                    }
                }
            }
            result.push(element);
        }

        console.log("PB normalizeDatatable");
        console.log( result );
        // End

        return {
            //content: obj.content || [],
            content: result,
            iTotalDisplayRecords: obj.size || 0,
            foundElements: obj.totalElements || 0,
        };
    };


    self.resetAndSearch = function () {
        self.filterSearch('');
        self.datatable.resetFilters();
        self.datatable.refresh({
        });
    };

    ko.iketek.withDatatable(self, {
        container: "projectBookTable",
        extras: { showDetails: false, checked: false, detailsFetched: false, 
        },
        elemCallback: function (obj) {
            obj.quantity = ko.observable(1);
            obj.details = ko.observable({});
            obj.status = ko.observable('');
            obj.hasPersonalizedDetails = (obj.technicalInfo() && obj.technicalInfo().details && obj.technicalInfo().details.length > 0);
            obj.personalizedDetails = obj.hasPersonalizedDetails ? obj.technicalInfo().details : '';
            
            if(obj.hasPersonalizedDetails){


                var detailsSliceResult = slicePartnumberDetails(obj.personalizedDetails);
                var observableDetail = {
                    detailsPart1: detailsSliceResult[0],
                    detailsPart2: detailsSliceResult[1],
                };
                obj.details(observableDetail);
                obj.status('UPDATED');
            }


            return obj;
        },
        postData: {
            token: token,
            projectBook: projectBookId,
        },
        data: "elements",
        url: projectBookServerListUrl,
        info: self.MESSAGES["datatableInfoMessage"],
        recordsPerPage: self.MESSAGES["recordsPerPage"],
        recordsSelector: [10, 20, 50],
        noElementsMsg: self.MESSAGES["noProductsAvailable"],
    });

    self.exportPB = function(isEntirePb, type, isAdvanced) {

        var selecteds = _.map(self.checkedElements(), function(element){

            const serie = element.hasInformation() ? element.technicalInfo().serie : '';

            return {
                partNumber: element.partNumber(),
                serie: serie
            };
        });
        
        if(selecteds.length === 0 && !isEntirePb){
            return smc.NotifyComponent.error(BASKET_MESSAGES.selectAtLeastOne);
        }

        self.exporting(true);
        
        REPOSITORY.doExport(projectBookId, selecteds, isEntirePb, type, isAdvanced).then(function(res){
            window.koDownloadUtils.generateDownloadOpen(res, true);
            self.exporting(false);
        });
    }

    //Helpers
  
    self.splitString = function (data, separator, part, includeSep) {
        return splitString(data, separator, part, includeSep);
    };

    const doGetDetails = function (partnumber, callback) {
        if (!partnumber || !partnumber.technicalInfo() || !partnumber.partNumber() || partnumber.status() === 'ERROR' || partnumber.status() === 'UPDATED' ) return;
        BASKET_REPOSITORY.doGetPartnumberDetails(
            partnumber.partNumber(), {
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

                        if ((res.status === 'UPDATED' || res.status === 'ERROR') && callback) callback(); //Stop running
                        partnumber.status(res.status);
                    } catch (e) {
                        partnumber.status('ERROR');
                        console.error('Error parsing' + partnumber.technicalInfo().partNumber + 'details');
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
            order = ProductsOrderEnum.PARTNUMBER.order;
        }
        var orderParam = order.field + "_" + order.orderType;
        return orderParam;
    }


    const productPersonalizedInfo = function(product) {
        const info = product.technicalInfo();
        if(!product.personalized() || !info) {
            return {};
        }
        
        return {
            mediumImage: info.image,
            smallImage: info.smallImage,
            extraSmallImage: info.extraSmallImage,
            serie: info.serie,
            familyName: (info.family)?info.family.name:null,
            catalogue: info.catalogue,
			preview: info.preview,
			cadenas: info.cadenas,
            productId: info.productId,
            name: info.name,
            partNumber: info.partNumber
        };
    }

     //On load
     self.datatable.refresh();
     self.datatable.orderType(buildOrderParam(self.selectedOrder()));
     self.getFamilies();

}