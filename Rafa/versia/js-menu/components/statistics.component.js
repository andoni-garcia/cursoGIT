(function(globalConfig) {

    function Statistics() {}

    Statistics.init = init;
    Statistics.logAction = logAction;

    function init() {
        console.debug('[Statistics]', 'init');
        initializeEvents();
        $(document).trigger('smc.registercomponent', ['statistics_component', this]);
    }

    function initializeEvents() {
        var $document = $(document);
        var $logElements = $('[smc-statistic-action]');

        $document.on('smc.logAction', logActionFromEvent);

        //Log event using metas
        $document.on('click', '[smc-statistic-action]', logActionFromHtmlEvent);

        //Log events of other types (Other types handler)
        $logElements.each(function (i, element) {
            var $element = $(element);
            var eventType = $element.attr('smc-statistic-on');
            if (eventType && eventType !== 'click') {
                $element.on(eventType, logActionFromHtmlEvent);
            }
        });
    }

    function logAction(logData) {
        if (logData.statAction) {
            if (!logData.data1) {
                //Try to get Part Number
                if (typeof partNumberString != 'undefined' && partNumberString) {
                    logData.statData1 = partNumberString;
                } else {
                    var url = new URL(window.location.href);
                    logData.statData1 = url.searchParams.get('partNumber');
                }
            }

            if (logData.statData3 == 'CAD FILE') {
                if (!logData.data4) {
                    //Try to get cad file format
                    logData.statData4 = window.localStorage.getItem('cadDownload.lastUsedFormat');
                }
            }

            if ($("#product_seriesAttrValue") !== undefined && $("#product_seriesAttrValue").length > 0){
                logData.statData2 = $("#product_seriesAttrValue").val();
            } else if ($('meta[name=product_series]') !== undefined && $('meta[name=product_series]').attr('content') !== '') {
                logData.statData2 = $('meta[name=product_series]').attr('content');
            }

            _logAction(logData);
        }
    }

    function logActionFromEvent(event, logData) {
        logAction(logData);
    }

    function logActionFromHtmlEvent(event) {
        console.log("logActionFromHtmlEvent");
        var $element = $(event.target);
        var isStatisticActions =  !!$element.attr('smc-statistic-action');
        if (!isStatisticActions) {
            $element = $element.closest('[smc-statistic-action]');
        }
        if (!$element) return;

        var eventType = $element.attr('smc-statistic-on');
        if (eventType && eventType !== event.type) return;//This event is retricted to this type of event

        var logData = {
            statAction: $element.attr('smc-statistic-action'),
            statSource: $element.attr('smc-statistic-source'),
            statData1: $element.attr('smc-statistic-data1'),
            statData2: $element.attr('smc-statistic-data2'),
            statData3: $element.attr('smc-statistic-data3'),
            statData4: $element.attr('smc-statistic-data4'),
            statData5: $element.attr('smc-statistic-data5')
        };
        logAction(logData);
    }

    function _logAction(logData) {
        return $.get(globalConfig.statistics.urls.logAction, logData);
    }

    Statistics.init();

    globalConfig.Statistics = globalConfig.Statistics || Statistics;
})(window.smc);

function contentlogAction($element, logUrl) {
    console.log("[contentlogAction] init");
    // var $element = $(event.target);

    var logData = {
        statAction: $element.attr('smc-content-statistic-action'),
        statSource: $element.attr('smc-statistic-source'),
        statData1: $element.attr('smc-statistic-data1'),
        statData2: $element.attr('smc-statistic-data2'),
        statData3: $element.attr('smc-statistic-data3'),
        statData4: $element.attr('smc-statistic-data4'),
        statData5: $element.attr('smc-statistic-data5')
    };
    console.log("LOG DATA: ", logData);
    if (logData.statAction) {
        return $.get(logUrl, logData);
    }
}