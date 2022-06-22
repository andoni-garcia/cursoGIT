<#ftl encoding="UTF-8">

<#include "../../include/imports.ftl">
<#include "../catalog-macros.ftl">

<@hst.setBundle basename="essentials.global,AskSMC"/>
<#assign componentId = .now?long?c>

<div id="${componentId}" class="row asksmcform">
    <@hst.include ref="form"/>
</div>

<@hst.headContribution category="empty-layout">
<script type="text/javascript">
    var smc = window.smc || {};
    smc.askSmc = smc.askSmc || {};

    var countryList = [];
    <#list countryList as country>
        countryList.push({
            value: '${country.getCode()}',
            text: "${country.getDescription()}"
        });
    </#list>
</script>
</@hst.headContribution>

<@hst.headContribution category="empty-layout">
<script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/components/ask-smc/ask-smc.component.js"/>"></script>
</@hst.headContribution>
<@hst.headContribution category="empty-layout">
<script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/components/statistics.component.js"/>"></script>
</@hst.headContribution>

<@hst.headContribution category="empty-layout">
    <script>
        $(function() {
            var AskSmc = window.smc.AskSmc;
            var config = {
                id: ${componentId},
                container: $('#${componentId}'),
                countryList: countryList,
                userCountry: '${userCountry}',
                messages: {
                    'other_country_key': 'Other countries',
                    'other_country_text': "<@fmt.message key="asksmc.othercountry.text" />"
                }
            };
            var askSmc = new AskSmc(config);
            askSmc.init();

            var $form = $('.smc-form');
            $form.on('submit', function () {
                $(document).trigger('smc.logAction', {
                    statAction: 'EMAIL REQUEST',
                    statSource: '${source}'
                });

                if (window.parent.dataLayer) {
                    window.parent.dataLayer.push({
                        'event': 'productRequest',
                        'productRequest_productName': $(".product-name").text()
                    });
                }

            });
        });
    </script>
</@hst.headContribution>