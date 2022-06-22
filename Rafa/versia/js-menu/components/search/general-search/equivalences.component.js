(function(globalConfig) {
    function SearchEquivalencesModule() {
    }

    SearchEquivalencesModule.prototype.init = init;
    SearchEquivalencesModule.prototype.activateTabs = activateTabs;


    function init(config) {
        console.log('[SearchEquivalencesModule]', 'init');
        this.config = config;
    }

    function activateTabs(config) {
        var _self = this;

        _self.config.$equivalentContainer = _self.config.$equivalentContainer || $("#" + _self.config.smcEquivalentContainerProducts);
        var $tabsLinks = $('.navigation-links-js', _self.config.$equivalentContainer);

        $($tabsLinks).on('click', 'a', function (e) {
            e.preventDefault();
            var $this = $(this);

            if (_self.config.device === 'DESKTOP') {
                var $tabSearchResult = $this.parents('#tabSearchResult');
                var $additionalInformationContainer = $this.parents('.additional-information-container');
                $tabSearchResult.addClass('active');
                $additionalInformationContainer.addClass('active');

                $this.tab('show');

            } else {
                //Remove all active nav links
                $('a', $tabsLinks).not($this).removeClass('active');

                $this.toggleClass('active');

                var target = $this.data("target");
                $(target).collapse('toggle');
            }
        });
    }

    window.smc.SearchEquivalencesModule = SearchEquivalencesModule;
})(window.smc);