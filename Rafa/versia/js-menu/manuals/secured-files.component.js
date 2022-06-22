(function (globalConfig) {
    function SecuredFilesComponent(config) {
        this.config = config;
    }

    SecuredFilesComponent.prototype.init = init;
    SecuredFilesComponent.prototype.initializeEvents = initializeEvents;
    SecuredFilesComponent.prototype.reestructureLinks = reestructureLinks;
    SecuredFilesComponent.prototype.redirectToLogin = redirectToLogin;

    function init() {
        console.log("[SecuredFilesComponent] Init");
        var _self = this;
        _self.$documentTable = $(".tabla-descargas");
        _self.reestructureLinks();
        this.initializeEvents();
    }

    function initializeEvents() {
        console.log("[SecuredFilesComponent] initializeEvents");
    }

    function reestructureLinks() {
        var _self = this;
        $.each($('.tabla-descargas a'), function () {
            var oldHref = this.href;
            if (oldHref !== null && oldHref !== undefined && ""  !== oldHref) {
                this.href = "#";
                $(this).attr("data-url", oldHref);
                $(this).on('click', _self.redirectToLogin.bind(this));
            }
        });
    }

    function redirectToLogin(event) {
        if (event) event.preventDefault();
        var globalConfig = window.smc;
        if (!globalConfig.isAuthenticated){
            var url = window.location.href;
            var docUrl = $(this).attr("data-url");
            var showManualDownloadUrlStandaloneUrl = generateSecuredAction(url, [docUrl]);
            window.parent.location = showManualDownloadUrlStandaloneUrl;
            window.history.pushState({}, window.document.title, showManualDownloadUrlStandaloneUrl.toString());
            return;
        }
    }

    function generateSecuredAction(currentUrl, documentUrl) {
        var url = new URL(currentUrl);

        var keysIterator = url.searchParams.keys();
        var key = keysIterator.next();
        while (key && key.value) {
            if (key.value.indexOf('_hn') === 0 || key.value.indexOf('ajax') === 0) url.searchParams.delete(key.value);
            key = keysIterator.next();
        }
        if (documentUrl) {
            url.searchParams.set('documentUrl', Array.isArray(documentUrl) ? documentUrl.join(',') : documentUrl || '');
        }
        return secureResourceUrl(url);
    }

    function secureResourceUrl(url) {
        var securedResourceUrl = new URL(url.origin + '/secured-resource');
        securedResourceUrl.searchParams.set('resource', url.toString().replace(url.origin, ''));
        return securedResourceUrl;
    }

    window.smc.SecuredFilesComponent = SecuredFilesComponent;
})(window.smc);
