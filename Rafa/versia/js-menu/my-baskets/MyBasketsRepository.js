function MyBasketsRepository() {
    var self = this;

    self.doGetBasketProducts = function (id, callback) {
        return $.ajaxHippo($.extend({
            type: 'POST',
            url: basketProductsListUrl + '&basket_id=' + id,
            async: true,
            data: {
                ids: JSON.stringify(array),
            },
        }, callback));
    }

    self.doUpdateBasket = function (id, params, callback) {
        return $.ajaxHippo($.extend({
            type: 'POST',
            url: mybasketUpdate,
            dataType: 'json',
            async: true,
            data: $.extend({
                basket_id: id,
            }, params),
        }, callback));
    }

    self.doDeleteMyBaskets = function (ids, callback) {
        return $.ajaxHippo($.extend({
            type: 'POST',
            url: mybasketDelete,
            dataType: 'json',
            async: true,
            data: {
                ids: JSON.stringify(ids),
            },
        }, callback));
    }

    self.doLoadMyBasket = function (id, callback) {
        return $.ajaxHippo($.extend({
            type: 'POST',
            url: mybasketLoad,
            dataType: 'json',
            async: true,
            data: {
                basket_id: id,
            },
        }, callback));
    }

    self.doShowAllMyBaskets = function () {
        var deferred = $.Deferred();
        return $.ajaxHippo({
            type: 'POST',
            url: mybasketShowAll,
            async: true,
            success: function (res) {
                return deferred.resolve(res);
            },
            error: function (err) {
                return deferred.reject(err);
            },
        });
    }

    self.doHideMyBaskets = function (ids) {
        var deferred = $.Deferred();
        return $.ajaxHippo({
            type: 'POST',
            url: mybasketsHide,
            async: true,
            dataType: 'json',
            data: {
                ids: JSON.stringify(ids),
            },
            success: function (res) {
                return deferred.resolve(res);
            },
            error: function (err) {
                return deferred.reject(err);
            },
        });
    }

    self.doCountHiddenMyBaskets = function (ids) {
        var deferred = $.Deferred();
        return $.ajaxHippo({
            type: 'POST',
            url: mybasketHiddenCount,
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