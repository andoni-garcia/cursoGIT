function OrderViewModel() {

    const MODAL_PARAGRAPH_MARGIN_CLASS = 'mb-4';
    const MODAL_PARAGRAPH_INTER_MARGIN_CLASS = "mb-2";

    var self = this;

    self.StateType = OrderStateTypeEnum;

    // --- Repository
    var REPOSITORY = new OrderRepository();

    self.loadedViewModel = false;
    self.orderProducts = ko.observableArray([]);

    self.deliveryAddresses = ko.observableArray([]);
    self.loadingDeliveryAddresses = ko.observable(false);

    self.selectedAddressData = ko.observable(new OrderDeliveryAddress(self));
    self.lastSelectedAddressId = ko.observable();
    self.selectedAddressId = ko.observable();

    self.customerOrderNumberInput = ko.observable('');
    self.isValidCustomerOrderNumber = ko.observable(false);

    self.additionalComments = ko.observable('');

    self.totalListPrice = ko.observable(0); // totalListPrice + transportCharges
    self.totalNetPrice = ko.observable(0); // totalNetPrice + transportCharges
    self.orderCharges = ko.observable(0);
    self.currency = ko.observable('');
    self.updating = ko.observable(false);

    self.requestDateForAll = ko.observable('');

    // --- States ---
    self.processingConfirmation = ko.observable(false);
    self.isCustomerOrderNumberChanging = ko.observable(false);
    self.isCustomerOrderNumberChecking = ko.observable(false)
    self.acceptedTerms = ko.observable(!areTermsActivated);
    self.showTermsText = ko.observable(false);


    // -----------------------
    // --- Private Methods ---
    // -----------------------
    const changeOrderProductsState = function(state) {
        for(var i=0; i<self.orderProducts().length; i++) {
            var basketProduct = self.orderProducts()[i];
            basketProduct.prevStatus(basketProduct.status());
            basketProduct.status(state);
        }
    }

    const constructParagraph = function(message, style) {
        let initialPar = '<p>';
        if(style) {
            initialPar = '<p class="' + style + '">'
        }
        return initialPar + message + '</p>';
    }

    const constructConfirmedMessage = function(erp) {
        let message = '';
        if(erp === 'MOVEX') {
            message = constructParagraph(ORDER_MESSAGES.modalConfirmationMessageConfirmed1, MODAL_PARAGRAPH_MARGIN_CLASS);
            message += constructParagraph(ORDER_MESSAGES.modalConfirmationMessageConfirmed2, MODAL_PARAGRAPH_INTER_MARGIN_CLASS);
            message += constructParagraph(ORDER_MESSAGES.modalConfirmationMessageConfirmed3, MODAL_PARAGRAPH_INTER_MARGIN_CLASS);
            message += constructParagraph(ORDER_MESSAGES.modalConfirmationMessageConfirmed4, MODAL_PARAGRAPH_MARGIN_CLASS);
            message += constructParagraph(ORDER_MESSAGES.modalConfirmationMessageConfirmed5);
        } 
        else if(erp === DYNAMICS_ERP) {
        	 message = constructParagraph(ORDER_MESSAGES.modalConfirmationMessageConfirmed1, MODAL_PARAGRAPH_MARGIN_CLASS);
             message += constructParagraph(ORDER_MESSAGES.modalConfirmationMessageConfirmed3, MODAL_PARAGRAPH_MARGIN_CLASS);
             message += constructParagraph(ORDER_MESSAGES.modalConfirmationMessageConfirmed4, MODAL_PARAGRAPH_MARGIN_CLASS);
             message += constructParagraph(ORDER_MESSAGES.modalConfirmationMessageConfirmed5);
        }
        else {
            message = constructParagraph(ORDER_MESSAGES.modalSapConfirmationMessageConfirmed1, MODAL_PARAGRAPH_INTER_MARGIN_CLASS);
            message += constructParagraph(ORDER_MESSAGES.modalSapConfirmationMessageConfirmed2, MODAL_PARAGRAPH_INTER_MARGIN_CLASS);
            message += constructParagraph(ORDER_MESSAGES.modalSapConfirmationMessageConfirmed3, MODAL_PARAGRAPH_INTER_MARGIN_CLASS);
            message += constructParagraph(ORDER_MESSAGES.modalSapConfirmationMessageConfirmed4, MODAL_PARAGRAPH_INTER_MARGIN_CLASS);
        }
        return message;
    }

    const constructConfirmedBlockedMessage = function() {
        let message = constructParagraph(ORDER_MESSAGES.modalConfirmationMessageConfirmed1, MODAL_PARAGRAPH_MARGIN_CLASS);
        message += constructParagraph(ORDER_MESSAGES.modalConfirmationMessageConfirmedBlocked1, MODAL_PARAGRAPH_INTER_MARGIN_CLASS);
        message += constructParagraph(ORDER_MESSAGES.modalConfirmationMessageConfirmedBlocked2, MODAL_PARAGRAPH_INTER_MARGIN_CLASS);
        message += constructParagraph(ORDER_MESSAGES.modalConfirmationMessageConfirmed4, MODAL_PARAGRAPH_MARGIN_CLASS);
        message += constructParagraph(ORDER_MESSAGES.modalConfirmationMessageConfirmed5);
        return message;
    }

    const updatePartialInfo = function(originalProduct) {

    }
    // -----------------------

    self.getValidProductList = function () {
        basketViewModel.getDeferredFirstLoad().then(function () {
            let basketProducts = basketViewModel.products();
            OrderUtils.deleteNotFoundProducts(self.orderProducts, basketViewModel.products);
            for (let i = 0; i < basketProducts.length; i++) {
                if (!basketViewModel.erpUnaffordableRemovableProducts() || basketProducts[i].valid()) {
                    let productFound = OrderUtils.checkIfProductInList(self.orderProducts, basketProducts[i]);
                    if(productFound) {
                        // Update
                        updatePartialInfo(basketProducts[i]);
                    } else {
                        // Insert
                        self.orderProducts.push(basketProducts[i]);
                    }

                    if(OrderUtils.areDeorderedOrderProducts(self.orderProducts, basketViewModel.products)) {
                        self.orderProducts(basketProducts);
                    }
                }
            }

            let areDeletedInvalidsDeferred;
            if(basketViewModel.erpUnaffordableRemovableProducts()) {
                areDeletedInvalidsDeferred = basketViewModel.deleteInvalidProducts();
            } else {
                areDeletedInvalidsDeferred = $.Deferred().resolve(false);
            }

            areDeletedInvalidsDeferred.then(function (res) {
                if (res) {
                    createConfirmDialog('modal-component', ORDER_MESSAGES.modalInvalidProductsTitle, ORDER_MESSAGES.modalInvalidProductsMessage,
                        ORDER_MESSAGES.close, null, false);
                }
            }, function (error) {});

        }, function () {});
    }

    self.getDeliveryAddresses = function () {

        var deferred = $.Deferred();

        self.loadingDeliveryAddresses(false);

        REPOSITORY.doGetDeliveryAddresses({
            success: function (res) {
                self.deliveryAddresses(res);
                self.loadingDeliveryAddresses(true);
                deferred.resolve(res);
            },
            error: function (err) {
                deferred.reject();
            }
        });

        return deferred.promise();

    }

    self.selectDeliveryAddress = function () {

        self.getDeliveryAddresses().then(function (res) {
            createConfirmDialog('modal-delivery-addresses', null, null, null, null, true,
                function (confirmModal) {

                    if (confirmModal) {
                        self.lastSelectedAddressId(self.selectedAddressId());

                        var selectedAddressValue;
                        for (var i = 0; i < self.deliveryAddresses().length; i++) {
                            if (self.deliveryAddresses()[i].addressId && self.deliveryAddresses()[i].addressId === self.selectedAddressId()) {
                                selectedAddressValue = self.deliveryAddresses()[i];
                            }
                        }
                        if (selectedAddressValue) {
                            self.selectedAddressData(new OrderDeliveryAddress(self, selectedAddressValue));

                            REPOSITORY.doSetDeliveryAddress(self.selectedAddressId(), {
                                success: function (res) {

                                },
                                error: function (err) {}
                            });

                        }

                    } else {
                        self.selectedAddressId(self.lastSelectedAddressId());
                    }

                });
        }, function () {

        });

    }

    self.checkCustomerOrderNumber = function () {

        var deferred = $.Deferred();

        if(self.customerOrderNumberInput() === '') {

            deferred.reject(false);

        } else {

            self.isCustomerOrderNumberChecking(true);
            self.isValidCustomerOrderNumber(false);
            self.isCustomerOrderNumberChanging(true);

            REPOSITORY.doCheckCustomerOrderNumber(self.customerOrderNumberInput(), {
                success: function (res) {
                    if (res.response) {
                        createConfirmDialog('modal-component', ORDER_MESSAGES.modalInvalidCustomerOrderNumberTitle, ORDER_MESSAGES.modalInvalidCustomerOrderNumberMessage,
                            ORDER_MESSAGES.close, null, false).then(function(){
                                deferred.reject(false);
                            });
                    } else {
                        self.isValidCustomerOrderNumber(true);
                        deferred.resolve();
                    }

                },
                error: function (err) {
                    deferred.reject(true);
                }
            }).always(function() {
                self.isCustomerOrderNumberChanging(false);
                self.isCustomerOrderNumberChecking(false);
            });

        }

        return deferred.promise();

    }

    self.goToBasket = function () {
        window.location.href = basketPageRelativePath;
    }

    self.openTerms = function() {
        self.showTermsText(!self.showTermsText());
    }

    self.confirmOrder = function(erp) {

        if(checkAgree && !self.acceptedTerms()) {
            return smc.NotifyComponent.warn(ORDER_MESSAGES.acceptAlert);
        }

        if(self.processingConfirmation()) {
            return false;
        }

        if(self.updating() || self.isCustomerOrderNumberChecking()) {
            return false;
        }

        if(self.customerOrderNumberInput() === '') {
            createConfirmDialog('modal-component',
                ORDER_MESSAGES.modalInvalidCustomerOrderNumberTitle, ORDER_MESSAGES.modalEmptyCustomerOrderNumberMessage,
                ORDER_MESSAGES.close, null, false);
            return false;
        }

        self.isCustomerOrderNumberChecking(true);
        self.checkCustomerOrderNumber().then(function() {

            if(self.isValidCustomerOrderNumber() && !self.isCustomerOrderNumberChanging()) {

                createConfirmDialog('modal-order-accept', ORDER_MESSAGES.modalConfirmTitle, ORDER_MESSAGES.modalConfirmMessage, ORDER_MESSAGES.cancel, ORDER_MESSAGES.accept, true)
                .then(function(){
                    self.processingConfirmation(true);

                    REPOSITORY.doConfirmOrder(self.customerOrderNumberInput(), self.additionalComments(), {
                        success: function(res) {

                            if (res.code !== 'UNKNOWN') {

                                var message = constructConfirmedMessage(selectedErp);
                                if(res.code === 'BLOCKED') {
                                    message = constructConfirmedBlockedMessage();
                                }

                                createConfirmDialog('modal-order-confirmation', null, message,
                                    ORDER_MESSAGES.confirm, null, false)
                                .then(function() {
                                    window.location.href = basketPageRelativePath
                                });
                            } else {
                                createConfirmDialog('modal-order-confirmation', null, ORDER_MESSAGES.modalConfirmationMessageHaveErrors,
                                    ORDER_MESSAGES.close, null, false);
                            }

                            //self.processingConfirmation(false);
                            
                            if(window.dataLayer) {

                                var products = [];
                                ko.utils.arrayForEach(basketViewModel.products(), function (prod) {
                                    var product = {
                                        'name': prod.name(),
                                        'id': prod.partnumber(),
                                        'price': prod.netPrice(),
                                        'quantity': prod.quantity(),
                                        'category': prod.serie()
                                    };
                                    products.push(product);
                                });

                                window.dataLayer.push({
                                    'event': 'purchase',
                                    'ecommerce': {
                                        'purchase': {
                                            'actionField': {
                                                'id': res.orderNumber,
                                                'revenue': basketViewModel.totalNetPrice(),
                                                'status': res.code,
                                            },
                                            'products': products
                                        }
                                    }
                                });
                            }

                            if(window._ss && window.smc.user) {

                                _ss.push(['_setTransaction', {
                                    'transactionID': basketViewModel.basketId(),
                                    'storeName': res.orderNumber,
                                    'total': basketViewModel.totalNetPrice(),
                                    'tax': '',
                                    'shipping': '',
                                    'city': '',
                                    'state': '',
                                    'zipcode': '',
                                    'country': window.smc.user.country,
                                    // the following params can be used for creating/updating
                                    // a contact in the context of the supplied transaction data.
                                    // if this data is omitted, the underlying contact/tracking data
                                    // associated with the visitors browser session is used automatically.
                                    'firstName' : window.smc.user.firstName, // optional parameter
                                    'lastName' : window.smc.user.lastName, // optional parameter
                                    'emailAddress' : window.smc.user.email, // optional parameter
                                    'cartUrl': '' // optional parameter
                                }]);

                                ko.utils.arrayForEach(basketViewModel.products(), function (prod) {

                                    _ss.push(['_addTransactionItem', {
                                        'transactionID': basketViewModel.basketId(),
                                        'itemCode': prod.partnumber(),
                                        'productName': prod.name(),
                                        'category': prod.serie(),
                                        'price': prod.netPrice(),
                                        'quantity': prod.quantity(),
                                        'productURL': '?', // optional parameter
                                        'imagePath' : '?' // optional parameter
                                    }]);

                                });

                                _ss.push(['_completeTransaction', {
                                    'transactionID': basketViewModel.basketId()
                                }]);

                            }

                        }, error: function(err) {
                            console.log(err);
                            self.processingConfirmation(false);
                            createConfirmDialog('modal-component', null, ORDER_MESSAGES.serviceUnavailable,
                                ORDER_MESSAGES.close, null, false);
                        }
                    });
                },function(){
                    self.processingConfirmation(false);
                });

            } else {

                createConfirmDialog('modal-component',
                    ORDER_MESSAGES.modalInvalidCustomerOrderNumberTitle, ORDER_MESSAGES.modalInvalidCustomerOrderNumberMessage,
                    ORDER_MESSAGES.close, null, false);
                self.processingConfirmation(false);

            }

        }, function(err) {

            if(!err) {
                createConfirmDialog('modal-component',
                    ORDER_MESSAGES.modalInvalidCustomerOrderNumberTitle, ORDER_MESSAGES.modalInvalidCustomerOrderNumberMessage,
                    ORDER_MESSAGES.close, null, false);
            } else {
                createConfirmDialog('modal-component',
                    ORDER_MESSAGES.modalServiceErrorTitle, ORDER_MESSAGES.serviceUnavailable, ORDER_MESSAGES.close, null, false);
            }

            self.processingConfirmation(false);

        });

    }

    // -- Subscribers --

    self.customerOrderNumberInput.subscribe(function(newValue) {
        self.isCustomerOrderNumberChanging(true);
    });

    self.requestDateForAll.subscribe(function(newValue) {

        if(newValue === '') return;

        changeOrderProductsState(OrderStateTypeEnum.UPDATING);

        var date = window.koDate.requestDateStringFormatted(self.requestDateForAll());

        REPOSITORY.doSetAllPreferredDeliveryDate(date,{
            success: function(res) {
                basketViewModel.getBasketData();
            }, error: function(err) {
                changeOrderProductsState(OrderStateTypeEnum.UPDATED);
            }
        });

    });

    basketViewModel.products.subscribe(function (newValue) {
        self.getValidProductList();
    });

    basketViewModel.totalListPriceWithCharges.subscribe(function (newValue) {
        self.totalListPrice(newValue);
    });

    basketViewModel.totalNetPriceWithCharges.subscribe(function (newValue) {
        self.totalNetPrice(newValue);
    });

    basketViewModel.orderCharges.subscribe(function (newValue) {
        self.orderCharges(newValue);
    });

    basketViewModel.currency.subscribe(function (newValue) {
        self.currency(newValue);
    });

    basketViewModel.updating.subscribe(function (newValue) {
        self.updating(newValue);
    });

    self.loadedViewModel = true;

    basketViewModel.getBasketData(true);
}