var dateOrder = {
    text: orderByDate,
    value: 'orderDate',
};

var descriptionOrder = {
    text: orderByDescription,
    value: 'description',
};

var senderOrder = {
    text: orderBySender,
    value: 'sender',
};

let ReceivedOrderFields = {
    DATE: 'orderDate',
    DESCRIPTION: 'description',
    SENDER: 'sender'
};

let ReceivedOrderType = {
    ASC: 'ASC',
    DESC: 'DESC'
}

function ReceivedViewModel() {
    var self = this;

    const ReceivedOrderEnum = {
        DATE_ASC: {
            order: {
                field: ReceivedOrderFields.DATE,
                orderType: ReceivedOrderType.ASC,
            },
            text: '▲ ' + orderByDate,
        },
        DATE_DESC: {
            order: {
                field: ReceivedOrderFields.DATE,
                orderType: ReceivedOrderType.DESC,
            },
            text: '▼ ' + orderByDate,
        },
        DESCRIPTION_ASC: {
            order: {
                field: ReceivedOrderFields.DESCRIPTION,
                orderType: ReceivedOrderType.ASC,
            },
            text: '▲ ' + orderByDescription,
        },
        DESCRIPTION_DESC: {
            order: {
                field: ReceivedOrderFields.DESCRIPTION,
                orderType: ReceivedOrderType.DESC,
            },
            text: '▼ ' + orderByDescription,
        },
        SENDER_ASC: {
            order: {
                field: ReceivedOrderFields.SENDER,
                orderType: ReceivedOrderType.ASC,
            },
            text: '▲ ' + orderBySender,
        },
        SENDER_DESC: {
            order: {
                field: ReceivedOrderFields.SENDER,
                orderType: ReceivedOrderType.DESC,
            },
            text: '▼ ' + orderBySender,
        }
    };

    ko.di.require({
        MESSAGES: "ReceivedMessages",
        REPOSITORY: "ReceivedRepository",
        SMCURLs: "SMCURLs"
    }, self);
    ko.iketek.withSelectAll(self, "elements");

    const REPOSITORY = new ReceivedRepository();

    //Observables
    self.selectedOrder = ko.observable(ReceivedOrderEnum.DATE_ASC.order);

    self.orderTypes = [
        ReceivedOrderEnum.DATE_ASC,
        ReceivedOrderEnum.DATE_DESC,
        ReceivedOrderEnum.DESCRIPTION_ASC,
        ReceivedOrderEnum.DESCRIPTION_DESC,
        ReceivedOrderEnum.SENDER_ASC,
        ReceivedOrderEnum.SENDER_DESC
    ];

    self.toggleDetails = function (elem) {
        elem.showDetails((elem.hasComments) ? !elem.showDetails() : false);
    }

    self.filterReceived = function () {
        self.datatable.orderType(buildOrderParam(self.selectedOrder()));
        self.datatable.refresh();
    }

    self.acceptReceived = function (elem) {
        createConfirmDialog('modal-component', acceptModalTitle, acceptOneModalMssg, cancelBtn, acceptBtn, true)
            .then(function () {
                _acceptBaskets([elem.id()]);
            })
    }

    self.acceptReceiveds = function () {

        var checkedElements = self.checkedElements();
        var ids = _.map(checkedElements, function (element) {
            return element.id();
        });
        if (ids.length === 0) {
            return smc.NotifyComponent.error(acceptEmptyMessage);

        }

        createConfirmDialog('modal-component', acceptModalTitle, acceptManyModalMssg, cancelBtn, acceptBtn, true)
            .then(function () {
                _acceptBaskets(ids);
            })
    }

    self.loadReceived = function (elem) {
        const id = elem.id();
        createConfirmDialog('modal-component', loadModalTitle, loadModalMssg, cancelBtn, acceptBtn, true)
            .then(function () {
                _saveAndLoad(id);
            })
    }

    self.deleteReceiveds = function () {
        var checkedElements = self.checkedElements();
        var ids = _.map(checkedElements, function (element) {
            return element.id();
        });

        if (ids.length === 0) {
            return smc.NotifyComponent.error(deletEmptyMessage);
        }

        createConfirmDialog('modal-component', acceptModalTitle, acceptManyModalMssg, cancelBtn, acceptBtn, true)
            .then(function () {
                _deleteReceiveds(ids);
            });

    }

    const _acceptBaskets = function (ids) {
        REPOSITORY.doAcceptReceived(ids)
            .then(function () {
                self.datatable.refresh({});
                smc.NotifyComponent.info(acceptSuccessMessage);
            })
            .catch(function (err) {
                smc.NotifyComponent.error(acceptErrorMessage);
            })
    }

    const _deleteReceiveds = function (ids) {
        REPOSITORY.doDeleteReceived(ids)
            .then(function () {
                self.datatable.refresh({});
                smc.NotifyComponent.info(deleteSuccessMessage);
            })
            .catch(function () {
                smc.NotifyComponent.error(deleteErrorMessage);

            })
    }

    const _saveAndLoad = function(id){

        REPOSITORY.doLoadReceived(id)
            .then(function () {
                basketViewModel.getBasketData();
                smc.NotifyComponent.info(loadSuccessMessage);
            })
            .catch(function (err) {
                console.log(err)
                smc.NotifyComponent.error(loadErrorMessage);
            })
    }

    //DATATABLE
    self.normalizeDatatable = function (obj) {
        return {
            content: obj.storedBaskets || [],
            iTotalDisplayRecords: obj.numElements || 0,
            foundElements: obj.foundElements || 0,
        };
    };

    self.resetAndSearch = function () {
        self.datatable.resetFilters();
        self.datatable.customFilters({});
        self.datatable.refresh({});
    };

    ko.iketek.withDatatable(self, {
        container: "myBasketsTable",
        extras: {
            showDetails: false,
            checked: false,
            detailsFetched: false,
        },
        elemCallback: function (obj) {
            obj.orderDate = window.koDate.requestDateObjectToFormat(obj.orderDate());
            obj.currency = ko.observable('');
            obj.loaded = ko.observable(false);
            obj.hasComments = obj.comments() && obj.comments() !== '';
            return obj;
        },
        postData: {
            token: token
        },
        data: "elements",
        url: receivedListUrl,
        info: self.MESSAGES["datatableInfoMessage"],
        recordsPerPage: self.MESSAGES["recordsPerPage"],
        recordsSelector: [10, 20, 50],
        noElementsMsg: self.MESSAGES["noProductsAvailable"]
    });


    //Helpers 
    const parseDate = function (date) {
        if (!date) return "";
        return date.dayOfMonth + "-" + date.monthValue + "-" + date.year;
    }

    const buildOrderParam = function (order) {
        if (!order || !order.field || !order.orderType) {
            return MyBasketsOrderFields.DATE + "_" + MyBasketsOrderType.ASC;
        }
        const field = order.field;
        const direction = order.orderType;
        return field + "_" + direction;
    }

    //On load
    self.datatable.refresh({});
    self.datatable.orderType(buildOrderParam(self.selectedOrder()));
    self.datatable.customFilters({});
}