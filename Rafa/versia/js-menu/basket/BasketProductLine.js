/**
 *
 * @param basketProduct
 * @param prodLine
 * @param parentVm Need to be basketViewModel
 */
function BasketProductLine(basketProduct, prodLine, parentVm, preventPUpdate) {

    var self = this;
    self.parentVm = parentVm;
    self.basketProduct = basketProduct;

    // Line keypress update
    self.lineUpdatingKeyPress = false;
    self.lineQuantityValue = null;

    self.quantity = ko.observable(prodLine.quantity);

    self.previousQuantity = ko.observable(prodLine.quantity);
    self.remainingQuantityChange = false;

    var totalNetPrice = '0.00';
    if(prodLine.totalNetPrice) totalNetPrice = prodLine.totalNetPrice.toFixed(2);
    self.totalNetPrice = ko.observable(totalNetPrice);

    var totalListPrice = '0.00';
    if(prodLine.totalListPrice) totalListPrice = prodLine.totalListPrice.toFixed(2);
    self.totalListPrice = ko.observable(totalListPrice);

    self.deliveryDate = ko.observable(prodLine.deliveryDate);
    self.deliveryDateJson = ko.observable(prodLine.deliveryDate);
    self.customerRequestDate = ko.observable(basketProduct.preferredDeliveryDate());

    self.prevStatus = ko.observable('');
    self.status = ko.observable(basketProduct.status());

    var preventParentUpdate = false;
    self.quantity.subscribe(function(newValue) {
        if(self.lineUpdatingKeyPress) {
            self.lineUpdatingKeyPress = false;
            preventParentUpdate = true;
            self.quantity(parseInt(self.lineQuantityValue));
            preventParentUpdate = false;
        }

        if(!preventParentUpdate) {

            self.prevStatus(self.status());

            self.status(OrderStateTypeEnum.UPDATING);
            basketProduct.updateTotalQuantity();
            self.remainingQuantityChange = true;
        } else {
            preventParentUpdate = false;
        }
    });

    basketProduct.status.subscribe(function(newValue) {
        self.prevStatus(self.status());
        self.status(newValue);
    });

    self.customerRequestDate.subscribe(function(newValue) {
        console.log("[BasketProductLine customerRequestDate.subscribe]");
        self.prevStatus(self.status());
        basketProduct.status(OrderStateTypeEnum.UPDATING);
        self.parentVm.updatePreferredDeliveryDate(self.basketProduct.basketProductId, newValue);

    });

    self.confirmChange = function() {
        self.previousQuantity(self.quantity());
        self.prevStatus(self.status());
        self.status(OrderStateTypeEnum.UPDATED);
        self.remainingQuantityChange = false;
    }

    self.revertChange = function() {
        preventParentUpdate = true;
        self.quantity(self.previousQuantity());
        self.status(OrderStateTypeEnum.UPDATED);
        self.remainingQuantityChange = false;
    }

    self.checkQuantity = function(data, event) {
        self.lineUpdatingKeyPress = true;
        self.lineQuantityValue = event.currentTarget.value;
    }

    self.checkSapAvailability = function(availability) {

        let message = '';

        if(availability === '1') {
            message = BASKET_MESSAGES.sapAvailable;
        } else if(availability === '2') {
            message = BASKET_MESSAGES.sapPartialAvailable;
        } else {
            message = BASKET_MESSAGES.sapNotAvailable;
        }

        return message;
    }

}