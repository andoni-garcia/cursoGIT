<#include "../../include/imports.ftl">
<@hst.setBundle basename="Sistema"/>

<#if (backStepsOnClose > 1) >
    <head>
        <link rel="stylesheet" href="<@hst.webfile  path="/freemarker/versia/css-menu/main.css"/>" type="text/css"/>
        <link rel="stylesheet" href="<@hst.webfile  path="/freemarker/versia/css-menu/osudio-main.css"/>" type="text/css"/>
        <link rel="stylesheet" href="<@hst.webfile  path="/freemarker/versia/css-menu/osudio-icons.css"/>" type="text/css"/>
        <link rel="stylesheet" href="<@hst.webfile  path="/freemarker/versia/css-menu/custom_main.css"/>" type="text/css"/>
        <link rel="shortcut icon" href="<@hst.webfile  path="/images/favicon.ico"/>"/>
        <link rel="icon" type="image/gif" href="<@hst.webfile  path="/images/favicon.gif"/>"/>
        <link rel="stylesheet" href="<@hst.webfile path="/freemarker/versia/css-menu/fontawesome/css/fontawesome.css"/>" type="text/css"/>
        <link rel="stylesheet" href="<@hst.webfile path="/freemarker/versia/css-menu/lks.css"/>" type="text/css"/>
        <link rel="stylesheet" href="<@hst.webfile path="/freemarker/versia/css-menu/components/ask-smc/ask-smc.component.css"/>" type="text/css"/>
        <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/libs/jquery.min.js"/>"></script>
    </head>
    <script>
        $(document).ready(function() {
            try {
                $('#_askSistemaModal').show();
                $('#_askSistemaModal').removeClass('fade');
                $('.modal').attr("display","block");
            } catch(error){

            }
        });
    </script>
    <div class="container-fluid ask-smc-page ask-smc-component desktop">
        <div class="row">
            <div class="back-button back-button-js hidden" onclick="window.history.go(-${backStepsOnClose});"></div>
        </div>
        <div class="row asksmcform">
            <div class="container-fluid">
                <p class="content-p">
                    <span><@fmt.message key="sistema.asksistema.done" /></span>
                    <br/><br/>
                    <span><@fmt.message key="sistema.asksistema.done.post" /></span>
                </p>
            </div>
        </div>
    </div>
<#else >
    <div class="modal ask-sistema-modal" id="_askSistemaModal" tabindex="-1" role="dialog" aria-labelledby="_askSistemaModalTitle" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                        <h5 class="modal-title" id="_askSistemaModalTitle"><@fmt.message key="sistema.asksistema" /></h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div id ="askSistemaLoadingContainer" class="hidden">
                        <#include "../../include/spinner.ftl">
                    </div>

                    <@hst.include ref="asksistemaform"/>
                    <@hst.include ref="form"/>
                </div>
            </div>
        </div>
    </div>
</#if>
