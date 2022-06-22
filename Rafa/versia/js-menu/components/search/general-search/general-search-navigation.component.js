(function(globalConfig) {
    function GeneralSearchNavigation() {
        this.config = {};
    }

    GeneralSearchNavigation.prototype.init = init;

    function init(configuration) {
        this.config = configuration;
        $('#'+this.config.resultsContainer+' a').not($("#pitw-wrapper a ")).on("click",function (e) {
            e.preventDefault();
        });
        $('#'+this.config.tabMenuContainer).on("click",'a',function (e) {
            e.preventDefault();

            if ($('#'+configuration.resultsContainer).hasClass('desktop')) {
                $(this).tab('show');
            }
        });
    }

    window.smc.GeneralSearchNavigation = GeneralSearchNavigation;
})(window.smc);
