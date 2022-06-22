function MyOrdersRepository() {
    var self = this;

    self.doGetOrderProducts = function (id, callback) {
        return $.ajaxHippo($.extend({
            type: 'POST',
            url: orderProductsListUrl,
            dataType: 'json',
            async: true,
            data: {
                basket_id: id,
            },
        }, callback));
    }

    self.doDeleteMyOrders = function (ids, callback) {
        return $.ajaxHippo($.extend({
            type: 'POST',
            url: myorderDelete,
            dataType: 'json',
            async: true,
            data: {
                ids: JSON.stringify(ids),
            },
        }, callback));
    }

    self.doLoadMyOrder = function (id, callback) {
        return $.ajaxHippo($.extend({
            type: 'POST',
            url: myorderLoad,
            dataType: 'json',
            async: true,
            data: {
                basket_id: id,
            },
        }, callback));
    }

    self.doShowAll = function (callback) {
        var deferred = $.Deferred();
        return $.ajaxHippo({
            type: 'POST',
            url: myorderShowAll,
            success: function (res) {
                return deferred.resolve(res);
            },
            error: function (err) {
                return deferred.reject(err);
            }
        });

    }

    self.doHideOrders = function (ids, callback) {
        var deferred = $.Deferred();

        return $.ajaxHippo({
            type: 'POST',
            url: myorderHide,
            dataType: 'json',
            async: true,
            data: {
                ids: JSON.stringify(ids),
            },
            success: function (res) {
                return deferred.resolve(res);
            },
            error: function (err) {
                return deferred.reject(err);
            }
        });
    }
    self.doCountHiddenMyOrders = function (ids) {
        var deferred = $.Deferred();
        return $.ajaxHippo({
            type: 'POST',
            url: myorderHiddenCount,
            async: true,
            success: function (res) {
                return deferred.resolve(res);
            },
            error: function (err) {
                return deferred.reject(err);
            },
        });
    }
}