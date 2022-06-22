<#include "../../include/imports.ftl">


<@hst.setBundle basename="Sistema"/>

<#if termsOfUse?? && privacyStatement??>
    <div class="container">
        <div class="cmseditlink">
            <@hst.manageContent hippobean=document/>
        </div>
        <div class="info-box info-box--blue">
            <div class="info-box__head">
                <h2 class="heading-07"><@fmt.message key="sistema.title" /></h2>
            </div>
            <div class="info-box__body text-01">
                <p>
                    <@fmt.message key="sistema.includedLanguages" />: ${paramsInfo.includedLanguages}
                    <br><@fmt.message key="sistema.fileType" />: ${paramsInfo.fileType}
                    <br><@fmt.message key="sistema.fileSize" />: ${paramsInfo.fileSize} MB
                    <br><@fmt.message key="sistema.lastUpdate" />: ${sistemaFileLastUpdate}
                </p>
                <div class="cta-box-list">
                    <div class="cta-box">
                        <#if mustAcceptTerms == true>
                            <button class="btn btn-secondary mr-10" data-toggle="modal" id="downloadSistemaFileButton"
                                    data-target="#sistema-modal"><@fmt.message key="sistema.download" /></button>
                        <#else>
                            <#if userIsLoggedIn == true>
                                <form id="downloadSistemaFileForm">
                                    <input type="hidden" name="action" value="download">
                                    <button id="downloadSistemaFileButton" type="submit" class="btn btn-secondary mr-10"
                                                onclick="downloadSistemaFile"><@fmt.message key="sistema.download" /></button>
                                </form>
                            <#else>
                                <button id="downloadSistemaFileButton" class="btn btn-secondary mr-10" onclick="downloadSistemaFile();"><@fmt.message key="sistema.download" /></button>
                            </#if>
                        </#if>
                    </div>
                </div>
            </div>
        </div>
        <div>
            <div class="hidden" data-swiftype-index='false'>
                <a id="askSistemaFinalPageLink" href="<@hst.link siteMapItemRefId='asksistema'/>"></a>
            </div>
            <p>
                <@fmt.message key="sistema.onlineRequestFormTip" />. <a
                        class="show-ask-sistema" id ="show-ask-sistema-link"  href="javascript:showAskSistema();"><@fmt.message key="sistema.onlineRequestForm" /></a>.
            </p>
        </div>
    </div>

    <#if mustAcceptTerms>
        <div class="modal ask-sistema-modal sistema-modal fade" id="sistema-modal" tabindex="-1" role="dialog"
             style="padding-right: 17px; display: none;">
            <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="sistema-modal-title"><@fmt.message key="sistema.title" /></h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="ask-sistema-page ask-sistema-component desktop">
                            <div class="asksistemaform sistema-modalform">
                                <form action="#" onsubmit="onAcceptTermsSubmit();">
                                    <#assign acceptTermsOfUseText><@fmt.message key="sistema.acceptTermsOfUse" /></#assign>
                                    <#assign acceptPrivacyStatementText><@fmt.message key="sistema.acceptPrivacyStatement" /></#assign>
                                    <label class="sistema-modal__label" for="agree-terms">
                                        <input class="sistema-modal__check" type="checkbox" name="termsOfUse"
                                               value="check" id="agree-terms"/><span
                                                class="sistema-modal__check-text"> ${acceptTermsOfUseText?replace("{{documentUrl}}", termsOfUseDocument)}</span>
                                    </label>
                                    <label class="sistema-modal__label" for="agree-privacy">
                                        <input class="sistema-modal__check" type="checkbox" name="privacyStatement"
                                               value="check" id="agree-privacy"/><span
                                                class="sistema-modal__check-text"> ${acceptPrivacyStatementText?replace("{{documentUrl}}", privacyStatementDocument)}</span>
                                    </label>
                                    <div class="sistema-modal__submit">
                                        <button type="submit" class="btn btn-primary ">
                                            <@fmt.message key="sistema.accept" />
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <style>
            .modal .asksistemaform.sistema-modalform form {
                display: flex;
                flex-direction: column;
            }

            .modal .asksistemaform.sistema-modalform .sistema-modal__label {
                display: flex;
                align-items: center;
                padding: 20px;
            }

            .modal .asksistemaform.sistema-modalform .sistema-modal__check {
            }

            .modal .asksistemaform.sistema-modalform .sistema-modal__check-text {
                flex: 1 0 auto;
                padding: 0 15px;
                max-width: 100%;
            }

            .modal .asksistemaform.sistema-modalform .sistema-modal__check-link {
            }

            .modal .asksistemaform.sistema-modalform .sistema-modal__submit {
                align-self: flex-end;
                padding: 20px;
            }

            .ask-sistema-modal.sistema-modal .modal-body {
                height: auto;
            }
        </style>

        <script id="acceptTermsScript" data-terms-accept-register-url="<@hst.resourceURL resourceId='createAcceptTermsRegister'/>">
            $(function () {
                var $thisAcceptTerms = document.getElementById("acceptTermsScript");
                window.smc = window.smc || {};
                smc.sistemaAjaxComponent = smc.sistemaAjaxComponent || {};
                var registerAcceptTermsUrl = $thisAcceptTerms.dataset.termsAcceptRegisterUrl;
                smc.sistemaAjaxComponent.urls = {
                    registerAcceptTerms: registerAcceptTermsUrl
                };

                <#if pushDownloadButton == true>
                $("#downloadSistemaFileButton").click();
                </#if>
            });

            function onAcceptTermsSubmit() {
                if (document.getElementById('agree-terms').checked && document.getElementById('agree-privacy').checked) {
                    return true;
                } else {
                    alert('<@fmt.message key="sistema.mustAcceptTerms" />');
                    return false;
                }
            }

        </script>
    <#else>
        <script>
            $(document).ready(function() {
                var fileS3Url = '${sistemaLibraryFileURL}';
                if (fileS3Url !== '') {
                    window.location.href = fileS3Url;
                }
            });

        </script>
    </#if>

    <script>
        function downloadSistemaFile() {
            if (!window.smc.isAuthenticated) {
                onSistemaLibraryDownloadForUnauthenticatedUser();
            }
        }

        function onSistemaLibraryDownloadForUnauthenticatedUser() {
            window.location = generateSistemaSecuredAction('', 'login-sistema-download', window.location.href);
        }

        function generateSistemaSecuredAction(componentId, actionName, currentUrl, actionParams) {
            var url = new URL(currentUrl);

            // [SMCD-471] Clear HippoCMS params to avoid Browser error
            var keysIterator = url.searchParams.keys();
            var key = keysIterator.next();
            while (key && key.value) {
                if (key.value.indexOf('_hn') === 0 || key.value.indexOf('ajax') === 0) url.searchParams.delete(key.value);
                key = keysIterator.next();
            }

            // url.searchParams.set('componentId', componentId);
            url.searchParams.set('action', actionName);
            if (actionParams) {
                url.searchParams.set('actionParams', Array.isArray(actionParams) ? actionParams.join(',') : actionParams || '');
            }
            return secureSistemaResourceUrl(url);
        }

        function secureSistemaResourceUrl(url) {
            var securedResourceUrl = new URL(url.origin + smc.channelPrefix + '/secured-resource');
            securedResourceUrl.searchParams.set('resource', url.toString().replace(url.origin, ''));
            return securedResourceUrl;
        }

        function showAskSistema(){
            var url  = document.getElementById('askSistemaFinalPageLink').href;
            var current = window.location.href;
            if (current.indexOf("https:") >= 0 ){
                if (url.toString().indexOf("http:") >= 0){
                    url = url.replace("http:","https:");
                    $('#askSistemaFinalPageLink').attr("href",url);
                }
            }
            var baseUrl = document.getElementById('askSistemaFinalPageLink').href;
            $("#askSistemaLoadingContainer").removeClass("hidden");
            $.get(baseUrl)
                .then(function (response) {
                    var $html = $(response);
                    //Remove old modal before creating a new one
                    $('.ask-sistema-modal').remove();
                    $html.modal('show');
                    $('.ask-sistema-modal').modal("show");
                    $("#askSistemaLoadingContainer").addClass("hidden");
                })
                .catch(function () {
                    // _self.endLoading(_self.links.showAskSmc);
                });
        }

    </script>
<#elseif editMode??>
    <h2 class="not-configured">Click to configure Sistema Library File</h2>
</#if>

