<#include "_etools-help-modal_links.ftl">
<#macro etoolsHelpModal product boxTitle renderMode id >
    <@hst.setBundle basename="essentials.global,ProductConfigurator,ProductToolbar,AddToCartBar,StandardStockedItems,SearchPage,SparesAccessories,ETools"/>
    <#if renderMode == 'from-ssi-series'>
        <div id="${id}">
            <p class="alert alert-info text-center">
            <span><@fmt.message key="etools.expertsvalidateconfiguration"/>
                <a href="#" id="etoolsAskForHelp" onclick="" class="show-etools-help-modal" title="<@fmt.message key="etools.yesido"/>">
                    <strong><@fmt.message key="etools.yesido"/> </strong>
                </a>
            </span>
            </p>
        </div>
    </#if>
    <script>

        $(function () {
            var EtoolsHelpModal = window.smc.EtoolsHelpModal;
            var urls = {
                getEtoolsHelpModal: document.getElementById('getEtoolsHelpModalLink').href,
                sendEtoolsHelpModal: document.getElementById('sendEtoolsHelpModalLink').href,
                updateEtoolsHelpContact: document.getElementById('updateEtoolsHelpContactLink').href
            };
            var config = {
                id: '${id}',
                container: $('#${id}'),
                renderMode: '${renderMode}',
                urls: urls
            };
            var etoolsHelpModal = new EtoolsHelpModal(config);
            etoolsHelpModal.init();
        });
    </script>

</#macro>
