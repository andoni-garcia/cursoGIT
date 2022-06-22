function ReceivedRepository(){
    var self = this;

    self.doDeleteReceived = function (ids, callback) {
        return $.ajaxHippo($.extend({
            type: 'POST',
            url: receivedDelete,
            dataType: 'json',
            async: true,
            data: {
                ids: JSON.stringify(ids)
            }
        }, callback));
    };

    self.doAcceptReceived = function (ids, callback) {
        return $.ajaxHippo($.extend({
            type: 'POST',
            url: receivedAccept,
            dataType: 'json',
            async: true,
            data: {
                ids: JSON.stringify(ids)
            }
        }, callback));
    };

    self.doLoadReceived = function (id, callback) {
        console.log(receivedLoad, id)
        return $.ajaxHippo($.extend({
            type: 'POST',
            url: receivedLoad,
            dataType: 'json',
            async: true,
            data: {
                basket_id: id
            }
        }, callback));
    }
}