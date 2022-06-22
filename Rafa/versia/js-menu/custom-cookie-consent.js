
window.addEventListener("load", function(){
    var isGDPRCompliant = $("#cookie-consent-properties").data("isgdprcompliant");
    var cookieConsentValue = $("#cookie-consent-properties").data("cookieconsentvalue");
    var cookieConsentName = $("#cookie-consent-properties").data("cookieconsentname");

    var date = new Date();
    date.setTime(date.getTime() + (63072000000)); //same expiration date than the visitor id cookie

    //If the site is GDPR Compliant and the cookies weren't actively accepted, we need to delete de cookie consent and ask again
    if(isGDPRCompliant == true && $.cookie("activelyAcceptedCookies") != "true"){
        $.removeCookie(cookieConsentName, { path: '/' });
        window.cookieconsent.initialise({
            "palette": {
                "popup": {
                    "background": "#ffffff",
                    "text": "#0062cc"
                },
                "button": {
                    "background": "#0062cc",
                    "text": "#ffffff"
                }
            },
            "theme": "classic",
            "content": smc.cookieMessages
        });
    } else if($.cookie(cookieConsentName) != cookieConsentValue){
        //Otherwise we assume it's not a GDPR Compliant site, so we can automatically accept cookies
        $.cookie(cookieConsentName, cookieConsentValue, { expires: date }, { path: '/' });
    }

    $(".cc-dismiss").on("click", function(){
        $.cookie("activelyAcceptedCookies","true", { expires: date }, { path: '/' }); //Additional cookie to find out if the visitor has actively accepted cookies or not
    })

});