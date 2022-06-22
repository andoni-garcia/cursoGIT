function OrderDeliveryAddress(parent, address) {

    var self = this;
    self.parent = parent;

    self.addressId = ko.observable();
    self.customerName = ko.observable();
    self.customerAddress = ko.observableArray([]);
    self.deliveryAddress = ko.observableArray([]);

    self.loadedModel = ko.observable(false);

    if (address) {
        self.addressId(address.addressId);
        self.customerName(address.customerName);
        self.customerAddress(address.customerAddress);
        self.deliveryAddress(address.deliveryAddress);

        self.loadedModel(true);
    }

}