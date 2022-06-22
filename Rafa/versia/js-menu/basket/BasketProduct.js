//Basket product model
// ALL CONSTANTS DEFINED FOR OLD BROWSERS
function BasketProduct(parent, prod) {

    var self = this;
    self.parent = parent;
    self.prevObject = null;
    self.currentObject = null;
    self.updatedInfo = false;
    self.updatingQty = false;

    //Private attributes
    var preventSubscribeQuantity = false;

    ko.di.require({
        REPOSITORY: "BasketProductRepository"
    }, self);
    var REPOSITORY = new BasketProductRepository();

    //BasketProduct main data
    self.partnumber = ko.observable('');
    self.basketProductId = prod.id;

    //Selectable checkbox
    self.selected = ko.observable(false);

    // Attempts
    self.attempts = 0;

    //Quantity
    self.quantityOld = ko.observable(1);
    self.quantity = ko.observable(1);
    self.originalQuantity = ko.observable(1);
    self.originalPartnumberCode = ko.observable(null);
    self.errorQty = ko.observable(null);

    //Prices & currency
    self.netPrice = ko.observable(0);
    self.listPrice = ko.observable(0);
    self.totalNetPrice = ko.observable(0);
    self.totalListPrice = ko.observable(0);
    self.currency = ko.observable('');

    //Partnumber data
    self.details = ko.observable({});
    self.name = ko.observable('');
    self.mediumImage = ko.observable('');
    self.productId = ko.observable(0);
    self.serie = ko.observable('');
    self.familyName = ko.observable('');

    //Status
    self.status = ko.observable('');
    self.partnumberStatus = ko.observable('');
    self.prevStatus = ko.observable('');
    self.prevPartnumberStatus = ko.observable('');
    self.valid = ko.observable(false);
    self.purchasable = ko.observable(false);
    self.quantityChanged = ko.observable(null);
    self.partnumberCodeReplaced = ko.observable(false);
    self.haveTechnicalInformation = ko.observable(false);
    self.haveExtraTechnicalInformation = ko.observable(false);
    self.outOfStock = ko.observable(false);
    self.availability = ko.observable('1');

    //DYNAMICS variables
    self.outOfStockWithFewPieces = ko.observable(false);
    self.outOfStockDefinitely = ko.observable(false);
    self.haveCustomerPartNumber = ko.observable(false);
    self.morePiecesThanMaximunOffered = ko.observable(false);


    //Taric, countryoforigin, ...
    self.taricCode = ko.observable(null);
    self.countryOfOrigin = ko.observable(null);
    self.eclass = ko.observable(null);
    self.eclassVersion = ko.observable(null);
    self.unspscNumber = ko.observable(null);
    self.unspscVersion = ko.observable(null);
    self.measurementUnit = ko.observable(null);

    self.quantityChangedMessage = ko.observable('');
    self.partnumberCodeReplacedMessage = ko.observable('');
    self.outOfStockWithPiecesMessage = ko.observable('');
    self.moreThanMaximunOfferedMessage = ko.observable('');

    //Customer partnumber
    self.customerPartnumberInput = ko.observable('');
    self.customerPartnumber = ko.observable('');
    self.updatingCpn = ko.observable(false);

    //Best achievable delivery date
    self.bestAchievableDeliveryDate = ko.observable('');
    self.preferredDeliveryDate = ko.observable('');
    self.toPreferredDeliveryDateDays = ko.observable(new Date());

    //Personalized data
    self.personalizedPartnumber = ko.observable(null);
    self.personalizedType = ko.observable(null);
    self.leadTime = ko.observable(null);
    self.sentDatalayer = ko.observable(false);

    self.lines = ko.observableArray([]);

    //AskSMC
    self.askSmcObservation = ko.observable('');

    // --- Private methods ---
    const checkUpdatingStatuses = function () {
        if ((self.currentObject != null &&
                (self.currentObject.status === OrderStateTypeEnum.UPDATING ||
                    self.currentObject.partnumberStatus === OrderStateTypeEnum.UPDATING)) ||
            (self.prevObject != null &&
                (self.prevObject.status === OrderStateTypeEnum.UPDATING ||
                    self.prevObject.partnumberStatus === OrderStateTypeEnum.UPDATING))) {
            return true;
        }
        return false;
    }

    const checkUpdatingQuantityErp = function() {
        return self.currentObject != null &&
            self.currentObject.status === OrderStateTypeEnum.UPDATING &&
            self.quantity() !== self.quantityOld();
    }

    const quantityMessageReplacer = function () {
        let quantityChangedMessage = BASKET_MESSAGES.messageQuantityChanged;
        quantityChangedMessage = quantityChangedMessage.replace('{0}', self.originalQuantity());
        quantityChangedMessage = quantityChangedMessage.replace('{1}', self.quantity());
        self.quantityChangedMessage(quantityChangedMessage);
    }

    const partnumberCodeMessageReplacer = function () {
        let partnumberCodeReplacedMessage = BASKET_MESSAGES.messagePartnumberCodeReplaced;
        partnumberCodeReplacedMessage = partnumberCodeReplacedMessage.replace('{0}', self.originalPartnumberCode());
        partnumberCodeReplacedMessage = partnumberCodeReplacedMessage.replace('{1}', self.partnumber());
        self.partnumberCodeReplacedMessage(partnumberCodeReplacedMessage);
    }
    
    
    const outOfStockWithPiecesMessageReplacer = function () {
        let outOfStockWithPiecesMessage = BASKET_MESSAGES.messageOutOfStockWithFewPieces;
        outOfStockWithPiecesMessage = outOfStockWithPiecesMessage.replace('{0}', self.originalQuantity());
        outOfStockWithPiecesMessage = outOfStockWithPiecesMessage.replace('{1}', self.quantity());
        self.outOfStockWithPiecesMessage(outOfStockWithPiecesMessage);
    }
    
    const moreThanMaximunOfferedMessageReplacer = function () {
        let moreThanMaximunOfferedMessage = BASKET_MESSAGES.messageMoreThanMaximunOffered;
        moreThanMaximunOfferedMessage = moreThanMaximunOfferedMessage.replace('{0}', self.originalQuantity());
        moreThanMaximunOfferedMessage = moreThanMaximunOfferedMessage.replace('{1}', self.quantity());
        self.moreThanMaximunOfferedMessage(moreThanMaximunOfferedMessage);
    }

    self.updateTotalQuantity = function () {

        self.attempts = 0;
        let totalQuantity = 0;
        for (let i = 0; i < self.lines().length; i++) {
            totalQuantity += parseInt(self.lines()[i].quantity());
        }
        self.quantity(totalQuantity);
        self.status(OrderStateTypeEnum.UPDATING);

    }

    self.quantityLinesChanges = function (confirmation) {
        for (var i = 0; i < self.lines().length; i++) {
            if (self.lines()[i].remainingQuantityChange) {
                if (confirmation) {
                    self.lines()[i].confirmChange();
                } else {
                    self.lines()[i].revertChange();
                }
            }
        }
    }

    //Quantity subscribe
    self.quantity.subscribe(function (newValue) {

        if (!preventSubscribeQuantity) {

            self.attempts = 0;
            self.prevStatus(self.status());

            self.status(OrderStateTypeEnum.UPDATING);

            self.updatingQty = true;
            REPOSITORY.doUpdateBasketQuantity(self.basketProductId, newValue, {
                success: function (data) {
                    //Update entire basket
                    self.parent.getBasketData(true);
                },
                error: function (error) {
                    self.quantityLinesChanges(false);
                }
            }).always(function () {
                console.log("[BasketProduct] updated quantity of product with basketProductId: " + self.basketProductId);
            });

        }

    });

    /*self.status.subscribe(function (newValue) {
        console.log("[BasketProduct] Product with [basketProductId:" + self.basketProductId + "] changed to erp status [" + newValue + "]");

        console.log("------------------------");
        console.log(window.dataLayer && newValue === OrderStateTypeEnum.UPDATED && self.prevStatus() === OrderStateTypeEnum.UPDATING && self.sentDatalayer() === false);
        console.log(newValue);
        console.log(self.prevStatus());
        console.log(self.sentDatalayer());
        console.log("------------------------");

        console.log(self);

        if(window.dataLayer && newValue === OrderStateTypeEnum.UPDATED && self.sentDatalayer() === false) {
            // Send datalayer data
            window.dataLayer.push({
                'event': 'addToCart',
                'ecommerce': {
                'currencyCode': self.currency(),
                'add': {
                    'products': [{
                        'name': self.name(),
                        'id': self.partnumber(),
                        'price': self.netPrice(),
                        'category': '{{product category}}',
                        'quantity': self.quantity()
                        }]
                    }
                }
            });

            // Update status of datalayer sent
            // Endpoint
            REPOSITORY.doUpdateSentDatalayer(self.basketProductId, {
                success: function (data) {
                    // Update datalayer sent model data
                    self.sentDatalayer(true);
                    console.log("UPDATED datalayer [" + self.basketProductId + "]");
                }
            });

        }

    });*/

    self.status.subscribe(function (newValue) {

        self.datalayerProduct();

    });

    self.partnumberStatus.subscribe(function (newValue) {

        self.datalayerProduct();

    });

    self.datalayerProduct = function() {

        console.log("[BasketProduct] Product with [basketProductId:" + self.basketProductId + "] changed to erp status [" + status + "]");

        var status = self.status() === OrderStateTypeEnum.UPDATED || self.status() === OrderStateTypeEnum.ERROR;
        var otherStatus = self.partnumberStatus() === OrderStateTypeEnum.UPDATED || self.partnumberStatus() === OrderStateTypeEnum.ERROR;

        if(window.dataLayer && status && otherStatus && self.sentDatalayer() === false) {
            // Send datalayer data
            window.dataLayer.push({
                'event': 'addToCart',
                'ecommerce': {
                'currencyCode': self.currency(),
                'add': {
                    'products': [{
                        'name': self.name(),
                        'id': self.partnumber(),
                        'price': self.netPrice(),
                        'category': self.serie(),
                        'quantity': self.quantity()
                        }]
                    }
                }
            });

            // Update status of datalayer sent
            // Endpoint
            REPOSITORY.doUpdateSentDatalayer(self.basketProductId, {
                success: function (data) {
                    // Update datalayer sent model data
                    self.sentDatalayer(true);
                    console.log("UPDATED datalayer [" + self.basketProductId + "]");
                }
            });

        }

    };

    self.customerPartnumber.subscribe(function (newValue) {

        if (!preventSubscribeQuantity) {

            console.log("[BasketProduct] Product with [basketProductId:"
                + self.basketProductId + "] updated customer partnumber [" + newValue + "]");

        }

    });

    /**
     * Update customerPartnumber with updatable field for that in each product
     */
    self.updateCustomerPartnumber = function () {
        if(self.customerPartnumberInput() === '' || self.customerPartnumberInput() === null) {
            return;
        }
        if (self.status() === OrderStateTypeEnum.UPDATED && self.updatingCpn() === false) {
            self.updatingCpn(true);
            parent.addAliasWithProduct(self);
        }
    }

    self.updateLightCustomerPartnumber = function () {
        const basketProductId = self.basketProductId;
        const alias = self.customerPartnumber();
        parent.addAlias(alias, basketProductId)
            .then(function () {
                smc.NotifyComponent.info(BASKET_MESSAGES.updatedCustomerPartNumber);
            })
            .catch(function () {
                self.customerPartnumber('');
                smc.NotifyComponent.error(BASKET_MESSAGES.updatedCustomerPartNumberError);
            });
    }
    // --- Private functions ---
    self.updateBasketProductData = function (prod) {

        self.prevObject = self.currentObject;
        self.currentObject = prod;

        self.sentDatalayer(prod.sentDatalayer);

        // Update serie if data is updated for datalayer
        if(prod.status === OrderStateTypeEnum.UPDATED) {
            self.serie(prod.serie);
        }

        self.prevStatus(self.status());
        self.status(prod.status);
        self.prevPartnumberStatus(self.partnumberStatus());
        self.partnumberStatus(prod.partnumberStatus);

        if(self.updatingCpn() === false) {
            self.customerPartnumberInput(prod.customerPartnumber);
        }

        if (checkUpdatingStatuses()) {
            self.attempts++;
        }

        if (self.prevObject == null || self.prevObject.partnumberStatus === OrderStateTypeEnum.UPDATING
            || self.prevObject.partnumberStatus !== self.currentObject.partnumberStatus || self.prevPartnumberStatus() === OrderStateTypeEnum.UPDATING) {
            self.haveTechnicalInformation(prod.technicalInformation);
        }

        if (self.prevObject == null || self.prevObject.status === OrderStateTypeEnum.UPDATING
            || self.prevObject.status !== self.currentObject.status || self.prevStatus() === OrderStateTypeEnum.UPDATING) {

            self.updatedInfo = false;

            preventSubscribeQuantity = true;
            self.partnumber(prod.partnumberCode);

            self.name(prod.name);
            self.mediumImage(prod.mediumImage);
            self.productId(prod.productId);
            self.valid(prod.valid);
            self.purchasable(prod.purchasable);
            self.quantityChanged(prod.quantityChanged);
            self.partnumberCodeReplaced(prod.partnumberCodeReplaced);
            self.outOfStock(prod.outOfStock);
            self.familyName(prod.familyName);
            self.serie(prod.serie);

            // Customer partnumber
            self.customerPartnumber(prod.customerPartnumber);
            if(prod.customerPartnumber != null && prod.customerPartnumber != '' && prod.customerPartnumber != undefined){
            	self.haveCustomerPartNumber(true);
            }
          
            // Dates
            self.bestAchievableDeliveryDate(prod.bestAchievableDeliveryDate);
            self.preferredDeliveryDate(prod.preferredDeliveryDate);

            if(!checkUpdatingQuantityErp()) {
                // Quantity and Not modified quantity
                self.quantityOld(prod.quantity);
                self.quantity(prod.quantity);
                self.originalQuantity(prod.originalQuantity);
                self.originalPartnumberCode(prod.originalPartnumberCode);
            }

            // Availability for SAP
            if(self.currentObject.status !== OrderStateTypeEnum.UPDATING) {
                self.availability(prod.availability);
                if(prod.availability === '2') {
                    self.errorQty(self.quantity());
                }
            }

            // Extra info
            self.taricCode(prod.taricCode);
            self.countryOfOrigin(prod.countryOfOrigin);
            self.eclass(prod.eclass);
            self.eclassVersion(prod.eclassVersion);
            self.unspscNumber(prod.unspscNumber);
            self.unspscVersion(prod.unspscVersion);
            self.measurementUnit(prod.measurementUnit);

            // Have extra technical info
            if (self.taricCode() || self.countryOfOrigin()) {
                self.haveExtraTechnicalInformation(true);
            }

            if (!self.updatingQty && (self.currentObject != null &&
                    self.currentObject.status !== OrderStateTypeEnum.UPDATING )) {

                console.log("[BasketProduct] Product with [basketProductId:" + self.basketProductId + "] -> Updating lines");

                var lines = [];
                for (var i = 0; i < prod.lines.length; i++) {
                    var basketProductLine = new BasketProductLine(self, prod.lines[i], parent, true);
                    lines.push(basketProductLine);
                }

                self.lines(lines);

                if (self.lines().length > 0) {
                    var linesSize = self.lines().length;
                    self.hasLines = true;
                    var lastDate = self.lines()[linesSize - 1].deliveryDateJson();
                    var datePreferredDays = null;
                    if (lastDate != null) {
                        datePreferredDays = window.koDate.requestDateFormatted(lastDate);
                    }
                    var dateToday = new Date();
                    if (datePreferredDays != null) {
                        self.toPreferredDeliveryDateDays(window.koDate.dateDaysDiff(dateToday, datePreferredDays));
                    }
                }

            }
            
            // Dynamics control
            
            // out of stock with few pieces
            if(prod.originalQuantity!='' && self.outOfStock() && prod.quantity>0){
            	outOfStockWithPiecesMessageReplacer();
            	self.outOfStockWithFewPieces(true);
            }
            
            if (self.partnumberCodeReplaced() && (prod.originalPartnumberCode=="" || prod.originalPartnumberCode==null || prod.originalPartnumberCode==undefined)) {
            	moreThanMaximunOfferedMessageReplacer();
            	self.morePiecesThanMaximunOffered(true);
            } else {
            	self.morePiecesThanMaximunOffered(false);
            }
            

            if(prod.currency) {
                self.currency(prod.currency);
            }

            if (prod.netPrice) {
                self.netPrice(prod.netPrice.toFixed(2));
            }

            if (prod.listPrice) {
                self.listPrice(prod.listPrice.toFixed(2));
            }

            //Total prices
            if (prod.totalNetPrice) {
                self.totalNetPrice(prod.totalNetPrice.toFixed(2));
            }
            if (prod.totalListPrice) {
                self.totalListPrice(prod.totalListPrice.toFixed(2));
            }

            preventSubscribeQuantity = false;

            if (self.quantityChanged) {
                quantityMessageReplacer();
            }

            if (self.partnumberCodeReplaced) {
                partnumberCodeMessageReplacer();
            }

            self.personalizedPartnumber(prod.personalizedPartnumber);
            self.personalizedType(prod.personalizedType);
            self.leadTime(prod.leadTime);

            if (!self.updatedInfo && self.currentObject.status !== OrderStateTypeEnum.UPDATING) {
                self.updatedInfo = true;
            }

        }

    }

    self.sapOutOfStockMessage = function() {
        let message = BASKET_MESSAGES.sapPartialAvailableWarningMessage;
        message = message.replace('{0}', self.originalQuantity());
        message = message.replace('{1}', self.errorQty());
        return message;
    }

    self.warningMessage = function(){

        let message = '';

        if(self.quantityChanged()) {
            message += self.quantityChangedMessage();
            message += ".";
        } 
        
        if(self.partnumberCodeReplaced()) {
            message += (message.length === 0) ? self.partnumberCodeReplacedMessage() : ' ' + self.partnumberCodeReplacedMessage()
            message += ".";
        }

        if(self.outOfStock()) {
            message += (message.length === 0) ? BASKET_MESSAGES.labelOutOfStock : ' ' + BASKET_MESSAGES.labelOutOfStock;
            message += ".";
        }
        if(selectedErp && (selectedErp !== 'MOVEX' && selectedErp !== DYNAMICS_ERP ) && basketViewModel.loadedViewModel() && self.availability() === '2'){
            message += (message.length === 0) ? this.sapOutOfStockMessage() : ' ' + this.sapOutOfStockMessage();
            message += ".";
        }
        
        if(selectedErp == DYNAMICS_ERP && self.outOfStockWithFewPieces()){
        	message += self.outOfStockWithPiecesMessage();
            message += ".";
        }

        return message;
    }
    self.showWarning = function(){
        return self.quantityChanged() || self.partnumberCodeReplaced() || self.outOfStock() || (selectedErp && (selectedErp !== 'MOVEX' && selectedErp !== DYNAMICS_ERP ) && basketViewModel.loadedViewModel() && self.availability() === '2' || (selectedErp == DYNAMICS_ERP && self.outOfStockWithFewPieces()));
    }

    //Initialization
    self.updateBasketProductData(prod);

}