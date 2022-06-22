(function(globalConfig) {

    function CookieConsentComponent() {
    }

    CookieConsentComponent.prototype.init = init;
    CookieConsentComponent.prototype.getCookie = getCookie;
    CookieConsentComponent.prototype.functionalCookiesAllowed = functionalCookiesAllowed;

    window.smc.CookieConsentComponent = CookieConsentComponent;

    function init(){
        this.validFunctionalCookieValues=["C0003:1"];
        this.functionalCookieName="OptanonConsent";
    }


    function getCookie(cname) {
        var name = cname + "=";
        var decodedCookie = decodeURIComponent(document.cookie);
        var ca = decodedCookie.split(';');
        for(var i = 0; i <ca.length; i++) {
            var c = ca[i];
            while (c.charAt(0) == ' ') {
                c = c.substring(1);
            }
            if (c.indexOf(name) == 0) {
                return c.substring(name.length, c.length);
            }
        }
        return "";
    }

    function functionalCookiesAllowed(){
        var validCookieFound = false;
        var functionalCookieValue = this.getCookie(this.functionalCookieName);
        if (functionalCookieValue !== undefined && functionalCookieValue !== ""){
            console.log("[functionalCookiesAllowed] value:",functionalCookieValue);
            if (this.validFunctionalCookieValues.includes(functionalCookieValue)){
                validCookieFound = true;
            } else if (functionalCookieValue.indexOf(this.validFunctionalCookieValues[0]) > 0) {
                validCookieFound = true;
            }
        }
        console.log("[functionalCookiesAllowed]",validCookieFound);
        return validCookieFound;
    }

    function requiredCookiesAllowed(){

    }

    function analyticalCookiesAllowed(){

    }

    window.smc.CookieConsentComponent = CookieConsentComponent;
})(window.smc);
