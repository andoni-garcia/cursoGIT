
<#assign security=JspTaglibs["http://www.springframework.org/security/tags"] />
<#include "../../include/imports.ftl">

<script src="https://browser.sentry-cdn.com/6.13.2/bundle.min.js" crossorigin="anonymous"></script>
<script>
    try {
        if (sentryEnabled){
            (function() {
                var isLocalhost = window.location.hostname === 'localhost';

                if (window.Sentry && !isLocalhost) {
                    function decodeHTML(string) {
                        return string.replace(/&#(\d+);/gm, decodeHTMLRegex);
                    }
                    function decodeHTMLRegex(stack, match) {
                        return stack && match ? String.fromCharCode(match) : stack;
                    }

                    var sentryUrl = 'https://{{key}}@sentry.io/{{project}}'
                        .replace('{{key}}', 'd4546080580e42e1827e47685bc18963')
                        .replace('{{project}}', '1458454');
                    window.Sentry.init({
                        dsn: sentryUrl,
                        environment: window.location.hostname
                    });

                    <@security.authorize access="isAuthenticated()">

                    var username = '<@security.authentication property="principal.name" />';
                    var role     = '<@security.authentication property="authorities[0]" />';
                    window.Sentry.configureScope(function(scope) {
                        scope.setUser({ 'username': decodeHTML(username) });
                        scope.setExtra('role', decodeHTML(role));
                    });
                    </@security.authorize>
                }
            })();
        } else {
            console.log('Sentry not enabled');
        }
    } catch (e) {
        console.warn('Unable to load Sentry', e);
    }
</script>