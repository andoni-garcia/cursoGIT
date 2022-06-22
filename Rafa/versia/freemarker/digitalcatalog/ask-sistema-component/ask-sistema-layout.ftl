<!doctype html>
<html lang="${lang}">
<head>
    <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/libs/jquery.min.js"/>"></script>
    <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/bootstrap.min.js"/>"></script>

    <meta charset="utf-8"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no">
    <#if hstRequest.requestContext.channelManagerPreviewRequest>
        <link rel="stylesheet" href="<@hst.webfile  path="/freemarker/versia/css-menu/cms-request.css"/>" type="text/css"/>
    </#if>
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
        <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/libs/extend/extend.js"/>"></script>
    <@hst.headContribution category="empty-layout">
        <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/forms/form-validator.js"/>"></script>
    </@hst.headContribution>
    <@hst.headContribution category="empty-layout">
        <script>
            $(function () {
                FormValidator.init();
            });
        </script>
    </@hst.headContribution>
</head>
<body>
    <!-- statistics -->
    <@hst.include ref="statistics" />
    <!-- END statistics -->
    <div class="container-fluid ask-sistema-page ask-sistema-component ${deviceInfo.deviceType?lower_case}">
        <div class="row">
            <div class="back-button back-button-js hidden" onclick="window.history.go(-${backStepsOnClose?long?c});"></div>
        </div>

        <@hst.include ref="asksistemaform"/>
        <@hst.include ref="form"/>
    </div>

    <@hst.headContributions categoryIncludes="empty-layout" xhtml=true/>
    <script>
        if (window.isIOS) {
            $('.back-button-js').removeClass('hidden');
        }
    </script>
</body>
</html>
