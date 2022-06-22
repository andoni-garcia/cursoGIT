
function CompetitorComparisonToolsMainViewModel() {
    var self = this;
    self.redirectSuccessStories=function(){
        var baseUrl = window.location;
        var channelPrefix = smc.channelPrefix;
        var securedPart = '/success-stories';
        var site = '/site';
        var localhost = 'localhost';
        var url;

        url = new URL(baseUrl.origin + site + channelPrefix + securedPart);

        url.searchParams.set('resource', baseUrl.toString().replace(baseUrl.origin, ''));
        window.location = url;
    }
    self.redirectComparisonMap=function(){
        console.log(window.vmcm);
    }
}

(function (window) {
    var cctmvm = new CompetitorComparisonToolsMainViewModel();
    ko.applyBindings(cctmvm, document.getElementById("CCTcontenedor"));
}(window));