var dateOrder = {
    text: orderByDate,
    value: 'orderDate',
};

var descriptionOrder = {
    text: orderByDescription,
    value: 'description',
};

var commentsOrder = {
    text: orderByComments,
    value: 'comments',
};


const MyBasketsOrderFields = {
    DATE: 'orderDate',
    DESCRIPTION: 'description',
    COMMENTS: 'comments'
};

const MyBasketsOrderType = {
    ASC: 'ASC',
    DESC: 'DESC'
}

function MyBasketsViewModel() {
    var self = this;

    const MyBasketsOrderEnum = {
        DATE_ASC: {
            order: {
                field: MyBasketsOrderFields.DATE,
                orderType: MyBasketsOrderType.ASC,
            },
            text: '▲ ' + orderByDate,
        },
        DATE_DESC: {
            order: {
                field: MyBasketsOrderFields.DATE,
                orderType: MyBasketsOrderType.DESC,
            },
            text: '▼ ' + orderByDate,
        },
        DESCRIPTION_ASC: {
            order: {
                field: MyBasketsOrderFields.DESCRIPTION,
                orderType: MyBasketsOrderType.ASC,
            },
            text: '▲ ' + orderByDescription,
        },
        DESCRIPTION_DESC: {
            order: {
                field: MyBasketsOrderFields.DESCRIPTION,
                orderType: MyBasketsOrderType.DESC,
            },
            text: '▼ ' + orderByDescription,
        },
        COMMENTS_ASC: {
            order: {
                field: MyBasketsOrderFields.COMMENTS,
                orderType: MyBasketsOrderType.ASC,
            },
            text: '▲ ' + orderByComments,
        },
        COMMENTS_DESC: {
            order: {
                field: MyBasketsOrderFields.COMMENTS,
                orderType: MyBasketsOrderType.DESC,
            },
            text: '▼ ' + orderByComments,
        }
    };

    ko.di.require({
        MESSAGES: "MyBasketsMessages",
        REPOSITORY: "MyBasketsRepository",
        SMCURLs: "SMCURLs"
    }, self);
    ko.iketek.withSelectAll(self, "elements");

    var REPOSITORY = new MyBasketsRepository();

    self.filterSearch = ko.observable('');
    self.currentBasketDescription = ko.observable('');
    self.currentBasketComments = ko.observable('');
    self.hiddenCount = ko.observable('');
    self.selectedOrder = ko.observable(MyBasketsOrderEnum.DATE_ASC.order);

    self.orderTypes = [
        MyBasketsOrderEnum.DATE_ASC,
        MyBasketsOrderEnum.DATE_DESC,
        MyBasketsOrderEnum.DESCRIPTION_ASC,
        MyBasketsOrderEnum.DESCRIPTION_DESC,
        MyBasketsOrderEnum.COMMENTS_ASC,
        MyBasketsOrderEnum.COMMENTS_DESC
    ];

    self.normalizeDatatable = function (obj) {
        return {
            content: obj.storedBaskets || [],
            iTotalDisplayRecords: obj.numElements || 0,
            foundElements: obj.foundElements || 0,
        };
    };

    self.resetAndSearch = function () {
        self.filterSearch('');
        self.datatable.resetFilters();
        self.datatable.customFilters({});
        self.datatable.refresh({

        });
    };

    self.getLines = function (basket) {
        REPOSITORY.doGetBasketProducts(basket.id(), {
            success: function (data) {
                var json = JSON.parse(data);
                    
                basket.products(parseProducts(json));
                basket.currency(getBasketCurrency(basket));
                self.getTotalListPrice(basket);
                self.getTotalNetPrice(basket);
                basket.loaded(true);
            }
        });
    }

    self.filterBaskets = function () {
        self.datatable.orderType(buildOrderParam(self.selectedOrder()));
        self.datatable.customFilters({
            search: self.filterSearch(),
        });
        self.datatable.refresh();
    }

    self.getTotalNetPrice = function (myBasket) {
        var currentPrice = 0;
        var totalNetPrice = _.reduce(myBasket.products(), function (prevSum, current, i, v) {
            currentPrice = roundPrice(current.totalNetPrice);
            return prevSum + currentPrice;
        }, 0);
        myBasket.totalBasketNetPrice(totalNetPrice.toFixed(2));
    }

    self.getTotalListPrice = function (myBasket) {
        var currentPrice = 0;
        var totalListPrice = _.reduce(myBasket.products(), function (prevSum, current, i, v) {
            currentPrice = roundPrice(current.totalListPrice);
            return prevSum + currentPrice;
        }, 0);
        myBasket.totalBasketListPrice(totalListPrice.toFixed(2));
    }

    self.deleteMyBaskets = function () {
        var checkedElements = self.checkedElements();
        var ids = _.map(checkedElements, function (element) {
            return element.id();
        });
        if (ids.length === 0) {
            return smc.NotifyComponent.error(deleteEmptyMssg);

        }
        return self.showDeleteModal(ids);
    }

    self.orderMyBaskets = function (orderType) {
        self.filterBaskets();

    }

    self.getHiddenCount = function () {
        REPOSITORY.doCountHiddenMyBaskets()
            .then(function (count) {
                if (count !== '') {
                    self.hiddenCount('(' + count + ')');
                }
            });
    }

    // TABLE
    self.toggleDetails = function (elem) {
        elem.showDetails(!elem.showDetails());
        if (!elem.loaded()) {
            self.getLines(elem);
        }
    };

    ko.iketek.withDatatable(self, {
        container: "myBasketsTable",
        extras: {
            showDetails: false,
            checked: false,
            detailsFetched: false,
        },
        elemCallback: function (obj) {
            obj.totalBasketNetPrice = ko.observable(0);
            obj.totalBasketListPrice = ko.observable(0);
            obj.products = ko.observable([]);
            obj.orderDate = window.koDate.requestDateObjectToFormat(obj.orderDate());
            obj.currency = ko.observable('');
            obj.loaded = ko.observable(false);
            return obj;
        },
        postData: {
            token: token
        },
        data: "elements",
        url: myBasketsListUrl,
        info: self.MESSAGES["datatableInfoMessage"],
        recordsPerPage: self.MESSAGES["recordsPerPage"],
        recordsSelector: [10, 20, 50],
        noElementsMsg: self.MESSAGES["noProductsAvailable"]
    });


    self.showDeleteModal = function (ids) {
        var deferred = $.Deferred();
        createConfirmAsyncDialog('modal-mybaskets', deleteTitle, deleteMssg, cancelBtn, deleteBtn, true, 'error-dialog-delete', function (confirm) {
            if (confirm) {
                return REPOSITORY.doDeleteMyBaskets(ids, {
                    success: function (res) {
                        self.datatable.refresh({

                        });
                        smc.NotifyComponent.info(myBasketDeleteSuccess);
                        return deferred.resolve();
                    },
                    error: function (err) {
                        return deferred.reject(myBasketDeleteError);
                    }
                });
            }

        });
    }

    self.showEmptyModal = function (title, mssg) {
        createConfirmDialog('modal-mybaskets-empty', title, mssg, acceptBtn, null, true, null);
    }

    self.showEditModal = function (myBasket) {

        self.currentBasketComments(myBasket.comments());
        self.currentBasketDescription(myBasket.description());
        var deferred = $.Deferred();
        createConfirmAsyncDialog('modal-edit-mybaskets', null, null, cancelBtn, saveBtn, true, 'error-dialog-edit', function (confirm) {
            if (confirm) {
                var params = {
                    comments: self.currentBasketComments(),
                    description: self.currentBasketDescription(),
                };
                return REPOSITORY.doUpdateBasket(myBasket.id(), params, {
                    success: function (data) {

                        self.currentBasketComments('');
                        self.currentBasketDescription('');
                        self.datatable.refresh({

                        });
                        smc.NotifyComponent.info(myBasketEditSuccess);
                        return deferred.resolve(myBasketEditSuccess);
                    },
                    error: function () {
                        return deferred.reject(myBasketEditError);
                    }
                })
            }
            return deferred.resolve();
        });
    }

    self.loadBasket = function (storedBasket) {
        var deferred = $.Deferred();

        createConfirmAsyncDialog('modal-mybaskets', loadBasketTitle, loadBasketMssg, cancelBtn, acceptBtn, true, 'error-dialog-load', function (confirm) {
            if (confirm) {
                return REPOSITORY.doLoadMyBasket(storedBasket.id(), {
                    success: function () {
                        basketViewModel.getBasketData();
                        smc.NotifyComponent.info(successLoadBasket);
                        return deferred.resolve();
                    },
                    error: function (err) {
                        smc.NotifyComponent.error(errorLoadBasket);
                        return deferred.reject(errorLoadBasket);
                    }
                });
            }
            return deferred.resolve();
        });
    }

    self.showAllMyBaskets = function () {
        REPOSITORY.doShowAllMyBaskets().then(function (res) {
                self.datatable.refresh({

                });
                self.getHiddenCount();
                return smc.NotifyComponent.info(showAllSuccess);
            })
            .catch(function (err) {
                return smc.NotifyComponent.error(showAllMssg);
            });
    }

    self.setHideMyBaskets = function () {
        var checkedElements = self.checkedElements();
        var ids = _.map(checkedElements, function (element) {
            return element.id();
        });
        if (ids.length === 0) {
            return smc.NotifyComponent.error(hideEmptyMssg);
        }
        REPOSITORY.doHideMyBaskets(ids)
            .then(function (res) {
                self.datatable.refresh({

                });
                self.getHiddenCount();
                return smc.NotifyComponent.info(hideSuccess)
            })
            .catch(function (err) {
                return smc.NotifyComponent.error(hideErrorMssg);
            });

    }


    // Helpers

    var getBasketCurrency = function (basket) {
        var firstValidProduct = basket.products().find(function (product) {
            return product.currency;
        });
        return firstValidProduct ? firstValidProduct.currency : '';
    }

    const buildOrderParam = function (order) {
        if (!order || !order.field || !order.orderType) {
            return MyBasketsOrderFields.DATE + "_" + MyBasketsOrderType.ASC;
        }
        const field = order.field;
        const direction = order.orderType;
        return field + "_" + direction;
    }

    const parseProducts = function(products){
        if(!products || typeof products !== typeof []) return [];
        return _.map(products, function(product) {
            return $.extend(product, {
                netPrice: roundPrice(product.netPrice),
                currency: product.currency || '',
                listPrice: roundPrice(product.listPrice),
                totalListPrice: roundPrice(product.totalListPrice),
                totalNetPrice: roundPrice(product.totalNetPrice)
            });
        });
    }

    const roundPrice = function roundPrice(price) {
        if(!price){
            return 0;
        }
        
        return parseFloat(price.toFixed(2))
    }
    //On load
    self.datatable.refresh({});
    self.datatable.orderType(buildOrderParam(self.selectedOrder()));
    self.datatable.customFilters({
        search: self.filterSearch(),
    });
    self.getHiddenCount();
}
