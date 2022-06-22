<#include "../../include/imports.ftl">
<#if (channelinfo?? && channelinfo.properties.googletagmanager?has_content) >
    <!-- Google Tag Manager -->
    <script>
        (function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
                new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
            j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
            'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
    })(window,document,'script','dataLayer','${channelinfo.properties.googletagmanager}');

        var __dispatched__ = {};

        /*
        First step is to register with the CM API to receive callbacks when a preference update
        occurs. You must wait for the CM API (PrivacyManagerAPI object) to exist on the page before
        registering.
        */

        var __i__ = self.postMessage && setInterval(function () {
            if (self.PrivacyManagerAPI && __i__) {
                var apiObject = {
                    PrivacyManagerAPI:
                        {
                            action: "getConsentDecision",
                            timestamp: new Date().getTime(),
                            self: self.location.host
                        }
                };
                self.top.postMessage(JSON.stringify(apiObject), "*");
                __i__ = clearInterval(__i__);
            }
        }, 50);

        /*
        Callbacks will occur in the form of a PostMessage event. This code listens for the
        appropriately formatted PostMessage event, gets the new consent decision, and then pushes
        the events into the GTM framework. Once the event is submitted, that consent decision is
        marked in the 'dispatched' map so it does not occur more than once.
        */

        self.addEventListener("message", function (e, d) {
            try {
                if (e.data && (d = JSON.parse(e.data)) &&
                    (d = d.PrivacyManagerAPI) && d.capabilities &&
                    d.action == "getConsentDecision") {
                    var newDecision =
                        self.PrivacyManagerAPI.callApi("getGDPRConsentDecision",
                            self.location.host).consentDecision;
                    newDecision && newDecision.forEach(function (label) {
                        if (!__dispatched__[label]) {
                            self.dataLayer && self.dataLayer.push({"event": "GDPR Pref Allows" + label});
                            __dispatched__[label] = 1;
                        }
                    });
                }
            } catch (error) {
                // Not a CM api message
            }

        });

    </script>
    <!-- End Google Tag Manager -->
</#if>