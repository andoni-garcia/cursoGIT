let OrderUtils = (function () {

    return {

        /**
         * Delete products in orderProducts if not exists in basketProducts
         * @param orderProducts Order products list (Observable array)
         * @param basketProducts Basket products list (Observable array)
         */
        deleteNotFoundProducts: function (orderProducts, basketProducts) {

            if (basketProducts) {
                let listToRemove = [];
                orderProducts().forEach(function (element, index) {
                    let found = false;
                    basketProducts().forEach(function (subElement) {
                        if (element.basketProductId === subElement.basketProductId) {
                            found = true;
                        }
                    });

                    if (!found) {
                        listToRemove.push(index);
                    }
                });

                listToRemove.forEach(function (indexToRemove) {
                    orderProducts.splice(indexToRemove, 1);
                });
            }
        },

        /**
         * Check if product with specific basketProductId is in product list of orders
         * @param orderProducts Order products list (Observable array)
         * @param basketProduct Basket Product to check
         */
        checkIfProductInList: function(orderProducts, basketProduct) {
            let found = null;
            orderProducts().forEach(function(element) {
                if(element.basketProductId === basketProduct.basketProductId) {
                    found = element;
                }
            });
            return found;
        },

        /**
         * Check if order products are deordered with basket products
         * @param orderProducts Order products list (Observable array)
         * @param basketProducts Basket products list (Observable array)
         */
        areDeorderedOrderProducts: function(orderProducts, basketProducts) {
            let foundDeordered = false;
            let extenalCounter = 0;
            while(extenalCounter < orderProducts().length && !foundDeordered) {
                let internalCounter = 0;
                while(internalCounter < basketProducts().length && !foundDeordered) {
                    if(basketProducts()[internalCounter].basketProductId === orderProducts()[extenalCounter].basketProductId
                    && extenalCounter !== internalCounter) {
                        foundDeordered = true;
                    }
                    internalCounter++;
                }
                extenalCounter++;
            }
            return foundDeordered;
        }
    }

}())