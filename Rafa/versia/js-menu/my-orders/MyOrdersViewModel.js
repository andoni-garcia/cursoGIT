var dateOrder = {
    text: orderByDate,
    value: 'orderDate',
};

var smcOrderNumber = {
    text: orderBySmcOrderNumber,
    value: 'smcOrderNumber',
};

var customerOrderNumber = {
    text: orderByCustomerOrderNumber,
    value: 'customerOrderNumber',
};

const MyOrdersOrderFields = {
    DATE: 'orderDate',
    SMC_ORDER_NUMBER: 'smcOrderNumber',
    CUSTOMER_ORDER_NUMBER: 'customerOrderNumber'
};

const MyOrdersOrderType = {
    ASC: 'ASC',
    DESC: 'DESC'
}

function MyOrdersViewModel() {
    var self = this;

    const MyOrdersOrderEnum = {
        DATE_ASC: {
            order: {
                field: MyOrdersOrderFields.DATE,
                orderType: MyOrdersOrderType.ASC,
            },
            text: '▲ ' + orderByDate,
        },
        DATE_DESC: {
            order: {
                field: MyOrdersOrderFields.DATE,
                orderType: MyOrdersOrderType.DESC,
            },
            text: '▼ ' + orderByDate,
        },
        SMC_ORDER_NUMBER_ASC: {
            order: {
                field: MyOrdersOrderFields.SMC_ORDER_NUMBER,
                orderType: MyOrdersOrderType.ASC,
            },
            text: '▲ ' + orderBySmcOrderNumber,
        },
        SMC_ORDER_NUMBER_DESC: {
            order: {
                field: MyOrdersOrderFields.SMC_ORDER_NUMBER,
                orderType: MyOrdersOrderType.DESC,
            },
            text: '▼ ' + orderBySmcOrderNumber,
        },
        CUSTOMER_ORDER_NUMBER_ASC: {
            order: {
                field: MyOrdersOrderFields.CUSTOMER_ORDER_NUMBER,
                orderType: MyOrdersOrderType.ASC,
            },
            text: '▲ ' + orderByCustomerOrderNumber,
        },
        CUSTOMER_ORDER_NUMBER_DESC: {
            order: {
                field: MyOrdersOrderFields.CUSTOMER_ORDER_NUMBER,
                orderType: MyOrdersOrderType.DESC,
            },
            text: '▼ ' + orderByCustomerOrderNumber,
        }
    };



    ko.di.require({
        MESSAGES: "MyOrdersMessages",
        REPOSITORY: "MyOrdersRepository",
        SMCURLs: "SMCURLs"
    }, self);
    ko.iketek.withSelectAll(self, "elements");
    var REPOSITORY = new MyOrdersRepository();

    //Observables
    self.filterSearch = ko.observable('');
    self.hiddenCount = ko.observable('');
    self.selectedOrder = ko.observable(MyOrdersOrderEnum.DATE_ASC.order);

    self.orderTypes = [
        MyOrdersOrderEnum.DATE_ASC,
        MyOrdersOrderEnum.DATE_DESC,
        MyOrdersOrderEnum.CUSTOMER_ORDER_NUMBER_ASC,
        MyOrdersOrderEnum.CUSTOMER_ORDER_NUMBER_DESC,
        MyOrdersOrderEnum.SMC_ORDER_NUMBER_ASC,
        MyOrdersOrderEnum.SMC_ORDER_NUMBER_DESC
    ];

    //Main functions
    self.getOrderProducts = function (order) {
        REPOSITORY.doGetOrderProducts(order.id(), {
            success: function (data) {
                order.products(getOrderProducts(data));
                order.currency(getOrderCurrency(order));
                getTotalListPrice(order);
                getTotalNetPrice(order);
            }
        });
    }

    self.deleteMyOrders = function () {

        var checkedElements = self.checkedElements();
        var ids = _.map(checkedElements, function (element) {
            return element.id();
        });
        if (ids.length === 0) {
            return smc.NotifyComponent.error(deleteEmptyMssg);
        }
        return showDeleteModal(ids);

    }

    self.loadOrder = function (storedOrder) {
        var deferred = $.Deferred();
        createConfirmAsyncDialog('modal-myorders', loadTitle, loadMssg, cancelBtn, acceptBtn, true, 'error-dialog-load', function (confirm) {
            if (confirm) {
                return REPOSITORY.doLoadMyOrder(storedOrder.id(), {
                    success: function () {
                        basketViewModel.getBasketData();
                        smc.NotifyComponent.info(successLoadOrder);
                        return deferred.resolve();
                    },
                    error: function (err) {
                        smc.NotifyComponent.error(errorLoadOrder);

                        return deferred.reject(errorLoadOrder);
                    }
                });
            }
            return deferred.resolve();
        });
    }

    self.filterOrders = function () {
        self.datatable.orderType(buildOrderParam(self.selectedOrder()));
        self.datatable.customFilters({
            search: self.filterSearch(),
        })
        self.datatable.refresh();
    }

    self.setAllVisible = function () {
        REPOSITORY.doShowAll()
            .then(function (res) {
                self.datatable.refresh({

                });
                smc.NotifyComponent.info(showAllSuccessMssg);
                self.getHiddenCount();
            })
            .catch(function (err) {
                smc.NotifyComponent.error(showAllMssg);
            });
    }

    self.setHideMyOrders = function () {
        var checkedElements = self.checkedElements();
        var ids = _.map(checkedElements, function (element) {
            return element.id();
        });
        if (ids.length === 0) {
            return smc.NotifyComponent.error(hideEmptyMssg);
        }
        REPOSITORY.doHideOrders(ids)
            .then(function (res) {
                self.datatable.refresh({

                });
                self.getHiddenCount();
                smc.NotifyComponent.info(hideSuccessMssg);
            })
            .catch(function (err) {
                return smc.NotifyComponent.error(hideErrorMssg);
            });

    }

    //Datatable functions
    self.normalizeDatatable = function (obj) {
        return {
            content: obj.storedOrders || [],
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

    self.getHiddenCount = function () {
        REPOSITORY.doCountHiddenMyOrders()
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
            self.getOrderProducts(elem);
        }
    };

    ko.iketek.withDatatable(self, {
        container: "myOrdersTable",
        extras: {
            showDetails: false,
            checked: false,
            detailsFetched: false,
        },
        elemCallback: function (obj) {
            obj.totalOrderNetPrice = ko.observable(0);
            obj.totalOrderListPrice = ko.observable(0);
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
        url: myOrderListUrl,
        info: self.MESSAGES["datatableInfoMessage"],
        recordsPerPage: self.MESSAGES["recordsPerPage"],
        recordsSelector: [10, 20, 50],
        noElementsMsg: self.MESSAGES["noProductsAvailable"],
    });

    var getOrderCurrency = function (order) {
        var firstValidProduct = order.products().find(function (product) {
            return product.currency;
        });
        return firstValidProduct ? firstValidProduct.currency : '';
    }

    var showDeleteModal = function (ids) {
        var deferred = $.Deferred();

        createConfirmAsyncDialog('modal-myorders', deleteEmptyTitle, deleteMssg, cancelBtn, deleteBtn, true, 'error-dialog-delete', function (confirm) {
            if (confirm) {
                return REPOSITORY.doDeleteMyOrders(ids, {
                    success: function (res) {
                        self.datatable.refresh({

                        });
                        smc.NotifyComponent.info(successDeleteOrder);
                        return deferred.resolve();
                    },
                    error: function (err) {
                        smc.NotifyComponent.error(myOrderDeleteError);

                        return deferred.reject(myOrderDeleteError);
                    }
                });
            }

        });
    }


    var getTotalNetPrice = function (myBasket) {
        var currentPrice = 0;
        var totalNetPrice = _.reduce(myBasket.products(), function (prevSum, current, i, v) {
            currentPrice = roundPrice(current.totalNetPrice);
            return prevSum + currentPrice;
        }, 0);
        myBasket.totalOrderNetPrice(totalNetPrice.toFixed(2));
    }

    var getTotalListPrice = function (myBasket) {
        var currentPrice = 0;
        var totalListPrice = _.reduce(myBasket.products(), function (prevSum, current, i, v) {
            currentPrice = roundPrice(current.totalListPrice);
            return prevSum + currentPrice;
        }, 0);
        myBasket.totalOrderListPrice(totalListPrice.toFixed(2));
    }

    var getOrderProducts = function (products) {
        return _.map(products, function (prod) {
            return $.extend(prod, {
                listPrice: roundPrice(prod.listPrice),
                netPrice: roundPrice(prod.netPrice),
                currency: prod.currency || '',
                totalListPrice: roundPrice(prod.totalListPrice),
                totalNetPrice: roundPrice(prod.totalNetPrice),
                name: prod.name || '',
            });
        });
    }

    const buildOrderParam = function (order) {
        if (!order || !order.field || !order.orderType) {
            return MyOrdersOrderFields.DATE + "_" + MyOrdersOrderType.ASC;
        }
        const field = order.field;
        const direction = order.orderType;
        return field + "_" + direction;
    }

    
    const roundPrice = function roundPrice(price) {
        if(!price){
            return 0;
        }
        
        return parseFloat(price.toFixed(2))
    }

    //Load on orders on start
    self.datatable.orderType(buildOrderParam(self.selectedOrder()));
    self.datatable.customFilters({
        search: self.filterSearch(),
    });
    self.datatable.refresh({});
    self.getHiddenCount();

}