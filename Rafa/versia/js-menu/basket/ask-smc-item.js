function AskToSmcItem (basketProduct, detailsParam) {
    this.partnumber = basketProduct.partnumber();
    this.name = basketProduct.name();
    this.quantity = basketProduct.quantity();
    this.days = basketProduct.toPreferredDeliveryDateDays();
    this.listPrice = window.koPrices.convertDoubleToStringI18n(basketProduct.listPrice());
    this.netPrice = window.koPrices.convertDoubleToStringI18n(basketProduct.netPrice());

    this.observation = basketProduct.askSmcObservation();
}