<#ftl encoding="UTF-8">
<#include "../../include/imports.ftl">

<@hst.setBundle basename="SearchPage,SearchBar"/>

<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/components/etools/porthole.js"/>" type="text/javascript"></script>
</@hst.headContribution>

<div class="container desktop" data-swiftype-index="false">
    <iframe
            id="vikFrame" name="vikFrame"
            src="https://etools.smc.at/config/vik/index.html?country=es&language=es"
            width="100%" height="1000px"
            style="border: 1px solid #000">
    </iframe>
</div>


<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript">
        window.onload = function () {
            windowProxy = new
            Porthole.WindowProxy('https://smc.etools.at/config/vik/proxy.html',
                'vikFrame');
            windowProxy.addEventListener(onMessage);
        };

        function onMessage(msg) {
            // get the data object of the message
            var data = msg.data;
            console.log("[eTools] onMessage()", msg)
            // check for any errors (data.error > 0)
            if (data.error > 0) {
                // handle error messages
                alert(data.message);
                return;
            }
            switch (data.cmd) {
                case 'ready': // tool is ready and accepts communication
            }
        }
    </script>
</@hst.headContribution>