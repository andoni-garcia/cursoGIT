(function (globalConfig) {
    function FunctionalityComponent(config) {
        this.config = config;
    }

    FunctionalityComponent.prototype.init = init;
    FunctionalityComponent.prototype.initializeEvents = initializeEvents;
    FunctionalityComponent.prototype.showLastBlock = showLastBlock;
    
    // CylinderConfigurator.prototype.moveRodEndConfigurationRows = moveRodEndConfigurationRows;

    function init() {
        console.log("[FunctionalityComponent] Init");
        this.initializeEvents();
        this.showLastBlock();
    }

    function initializeEvents() {
        console.log("[FunctionalityComponent] initializeEvents");
        // var _self = this;
        // let data;
        // let nodes = [];
        // let searchData;
        // var currentUrl = new URL(window.location.href);
        // var urlNodes = currentUrl.searchParams.get("nodes");
        // if (urlNodes) {
        //     nodes = JSON.parse(decodeURIComponent(urlNodes));
        // }
        // var urlSearchData = currentUrl.searchParams.get("searchData");
        // if (urlSearchData) {
        //     searchData = JSON.parse(decodeURIComponent(urlSearchData));
        // }
        // let cardTemplateHtml = $("#cardTemplate").html();
        // for (let i=0;i<nodes.length;i++) {
        //     $("#accordion").append(cardTemplateHtml.replaceAll("cardId",nodes[i].nodeId).replaceAll("cardName",nodes[i].nodeName).replaceAll("cardParent",nodes[i].parent));
        // }

        // data = {
        //     nodes: nodes,
        //     searchData: searchData,
        // };
        // url = new URL(globalConfig.ssi.urls.showSsiInfo);
        // url.searchParams.set('partNumber', partialPartNumber);

    }

    function showLastBlock() {
        if (!($("#container_additionalParameters") && $("#container_additionalParameters").length > 0)) {
            let $card = $('.card').last();
            $('.fa-plus', $card).click();
        }
    }


    window.smc.FunctionalityComponent = FunctionalityComponent;
})(window.smc);

var ssi_columns = '';