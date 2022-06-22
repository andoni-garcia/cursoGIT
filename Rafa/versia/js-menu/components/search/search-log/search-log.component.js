(function(globalConfig) {
    var lastLogId = 0;
    function SearchLog() {
    }
    SearchLog.prototype.init = function () {

    };
    SearchLog.prototype.createLog = function(log) {
        var url = globalConfig.logSearchComponent.urls.registerLog;
        console.log("Creating search log", log);
        $.getJSON(url, log).then(function (response) {
            console.log(response);
            lastLogId = response.id;
        });
    };

    SearchLog.prototype.createAction = function(action) {
        var url = globalConfig.logSearchComponent.urls.addAction;
        action["logId"] = lastLogId;
        console.log("Adding search action", action);
        $.getJSON(url, action).then(function (response) {
            console.log(response);
        });
    };
    window.smc.SearchLog = SearchLog;
})(window.smc);