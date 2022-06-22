var productsPageName = "";
var searchLog;

var cntrlIsPressed = false;
$(document).keydown(function (event) {
    if (event.which == "17") {
        cntrlIsPressed = true;
    }
});

$(document).keyup(function () {
    cntrlIsPressed = false;
});

(function (globalConfig) {

    var _term;
    var DEFAULTS = {
        NUMBER_REGISTER_PLACEHOLDER: ' ({{numberRegister}}) ',
        NUMBER_REGISTER: '{{numberRegister}}'
    };

    function GeneralSearch(configuration) {
        this.config = {
            searchTypes: {},
            templates: {
                spinner: document.getElementById('spinner-template').innerHTML
            },
            cache: {}
        };
        this.config = $.extend(this.config, configuration);
    }

    GeneralSearch.prototype.init = init;
    GeneralSearch.prototype.linkMakeSearch = linkMakeSearch;
    GeneralSearch.prototype.addEngine = addEngine;
    GeneralSearch.prototype.getEngine = getEngine;
    GeneralSearch.prototype.getResults = getResults;

    function init(configuration, swiftypeApiSearch) {
        this.config = $.extend(this.config, configuration);
        this.addEngine('GENERAL', this);

        swiftypeApiSearch.init()
            .then(linkMakeSearch.bind(this, swiftypeApiSearch));

        if (this.config.searchEquivalencesModule) {
            this.config.searchEquivalencesModule.init(this.config);
        }

        $(this.config.smcWebContentTabLink).on('click', onWebContentTabLinkClicked.bind(this));

        function logAction(e) {
            if (e.currentTarget.href) {
                var action;
                if (!cntrlIsPressed) {
                    e.preventDefault();
                    // console.log("element click");
                    action = generateAction("CLICK", e.currentTarget.href, $(e.currentTarget).data("page-number"), $(e.currentTarget).data("result-number"), $(e.currentTarget).data("tab-name"), false);
                } else {
                    // console.log("element click in new tab");
                    action = generateAction("CLICK", e.currentTarget.href, $(e.currentTarget).data("page-number"), $(e.currentTarget).data("result-number"), $(e.currentTarget).data("tab-name"), true);
                }

                searchLog.createAction(action);

                if (!cntrlIsPressed) {
                    window.location.href = e.currentTarget.href;
                }
            }
        }

        function logMiddleClickAction(e1, e2) {
            if (e1.which == 2 && e1.target == e2.target) {
                var e3 = $.event.fix(e2);
                e3.type = "middleclick";
                $(e2.target).trigger(e3);

                // console.log("middle click");
                var action = generateAction("CLICK", e2.target.href, $(e2.target).data("page-number"), $(e2.target).data("result-number"), $(e2.target).data("tab-name"), true);
                searchLog.createAction(action);
            }
        }

        $("body").on("click", ".search_results a", (function (e) {
            console.log("log click");
            logAction(e);
        }));

        $("body").on("click", ".equivalent-row .name-description a, .equivalent-row .part-number a", (function (e) {
            console.log("log click");
            logAction(e);
        }));

        $("body").on("mousedown", ".search_results a", function (e1) {
            $("body").one("mouseup", ".search_results a", function (e2) {
                console.log("log middle click");
                logMiddleClickAction(e1, e2);
            });
        });

        $("body").on("mousedown", ".equivalent-row .name-description a, .equivalent-row .part-number a", function (e1) {
            $("body").one("mouseup", ".equivalent-row .name-description a", function (e2) {
                console.log("log middle click");
                logMiddleClickAction(e1, e2);
            });
        });
    }

    function linkMakeSearch(swiftypeApiSearch) {
        var _self = this;
        var context = $(this)[0];
        if (context.config.hasOwnProperty('mobileCssMenuItem')) {
            $(this.config.mobileCssMenuItem).on('click', function (e) {
                if (!$(this).hasClass('disabled')) {
                    if ($(this).hasClass('active')) {
                        $(this).removeClass('active');

                    } else {
                        $(context.config.mobileCssMenuItem).removeClass('active');
                        $(this).addClass('active');
                    }
                    var target = $(this).data("target");
                    $(target).collapse('toggle');
                }
            });
        }

        var value = $(this.config.focusable).val();
        if (value && value !== '') {
            _self.getResults($(context.config.focusable).val(), context.config, swiftypeApiSearch, null);
        }

        $(this.config.enlageCategoriesButton).on('click', '', {context: context}, function (e) {
            var context = e.data.context;

            if ($(this).find('i').hasClass('fa-plus')) {
                $(this).find('i').removeClass('fa-plus');
                $(context.config.categoryContainer).addClass('categories-button-container-full');
                $(this).find('i').addClass('fa-minus');
            } else {
                $(this).find('i').removeClass('fa-minus');
                $(context.config.categoryContainer).removeClass('categories-button-container-full');
                $(this).find('i').addClass('fa-plus');
            }
        });

        $(this.config.focusable).keyup(function (e) {
            if (e.keyCode === 13) {
                $(context.config.mobileCssMenuItem).removeClass('active');
                $(context.config.mobileCssMenuItem).addClass('disabled');
                _self.getResults($(context.config.focusable).val(), context.config, swiftypeApiSearch, null);
                context.config.focusable.typeahead("destroy");
            }
        });

        $(this.config.clickable).on('click', '', {
            context: context,
            swiftypeApiSearch: swiftypeApiSearch
        }, function (e) {
            var context = e.data.context;
            var swiftypeApiSearch = e.data.swiftypeApiSearch;

            context.config.categories = [];
            $(context.config.mobileCssMenuItem).removeClass('active');
            $(context.config.mobileCssMenuItem).addClass('disabled');
            _self.getResults($(context.config.focusable).val(), context.config, swiftypeApiSearch, null);
        });

        $(this.config.resetButtonContainer).on('click', '', {
            context: context,
            swiftypeApiSearch: swiftypeApiSearch
        }, function (e) {
            var context = e.data.context;
            var swiftypeApiSearch = e.data.swiftypeApiSearch;

            var sectionId = $(this).data('section');
            context.config.categories = [];
            $('.' + context.config.categorySelector).removeClass('active');
            $(context.resetButtonContainer).hide();
            _self.getResults($(context.config.focusable).val(), context.config, swiftypeApiSearch, sectionId);
        });

        $(this.config.webContentTab).on('click', '.' + this.config.categorySelector, {
            context: context,
            swiftypeApiSearch: swiftypeApiSearch
        }, function (e) {
            var context = e.data.context;
            var swiftypeApiSearch = e.data.swiftypeApiSearch;

            var isActive = $(this).hasClass('active');
            var len = $(this).data('len');
            var sectionId = $(this).data('engine');
            context.config.pageSize[sectionId] = len;
            var categories = context.config.categories;
            var category = $(this).data('category');

            if (isActive) {
                $(this).removeClass('active');
                categories = categories.filter(function (cat) {
                    return cat !== category;
                });
            } else {
                $(this).addClass('active');
                categories.push(category);
            }

            context.config.categories = categories;
            console.log(context.config);
            _self.getResults($(context.config.focusable).val(), context.config, swiftypeApiSearch, sectionId);
        });

        $(this.config.changeLen).on('click', '', {
            context: context,
            swiftypeApiSearch: swiftypeApiSearch
        }, function (e) {
            var context = e.data.context;
            var swiftypeApiSearch = e.data.swiftypeApiSearch;

            var len = $(this).data('len');
            var sectionId = $(this).data('section');
            $('#' + sectionId + ' ' + context.config.changeLen).removeClass('active');
            $(this).addClass('active');
            context.config.pageSize[sectionId] = len;
            $("#searchbutton").click();
            // _self.getResults($(context.config.focusable).val(),context.config,swiftypeApiSearch,sectionId);
            // setTimeout(function(){
            //     $("#searchbutton").click();
            // },500);
        });
    }

    function addEngine(engineName, engine) {
        if (!this.config.searchTypes[engineName]) {
            this.config.searchTypes[engineName] = engine;
        }
    }

    function getEngine(key) {
        return this.config.searchTypes[key];
    }

    function manageTabActivation(productCatalogueResponse, webcontentResponse, searchResultResponse, config) {
        var hasProductCatalogueResults = (productCatalogueResponse && productCatalogueResponse['record_count'] > 0)
            || (searchResultResponse && searchResultResponse.length > 0);
        var hasWebContentResults = webcontentResponse && webcontentResponse['record_count'] > 0;
        if (!hasProductCatalogueResults && !hasWebContentResults) {
            $(config.paginationResultBar).addClass('hidden');
            $(config.paginationjs).addClass('hidden');
            $('#' + config.productsContainerProducts).html('<div class="text-center m-auto p-5">' + $('#' + config.searchResult).html() + '</div>');

        } else if (!hasProductCatalogueResults && hasWebContentResults) {
            if (config.device === 'DESKTOP') {
                $(config.smcWebContentTabLink).click();
            } else {
                //TODO Open in mobile devices
            }
        }
    }

    function renderResults(paginationElementsConfig, resultSet, config, engine) {
        var currentResultCount = resultSet.totalResultCount;
        var categories = resultSet.categories;
        var searchType = resultSet.searchType;
        var $tabContainer = paginationElementsConfig.$tabContainer;
        var $links = $(config.enableLink);
        var $searchResultText = $('#' + config.searchResultText);
        var $searchResultNumber = $('#' + config.searchResultNumber);
        var $searchResult = $('#' + config.searchResult);
        var searchTerm = window.smc.StringTools.decodeFromUrl(resultSet.searchTerm);
        var totalResults = config.totalResults === 0 ? currentResultCount || 0 : config.totalResults += currentResultCount;
        paginationElementsConfig.searchResults = currentResultCount || 0;

        if (totalResults === 1 && resultSet.uniqueResultUrl) {
            //TODO Check if this works on iOS
            window.location.href = resultSet.uniqueResultUrl;
            return;
        }

        var isNewSearch = config.searchId !== config.cache.searchId;
        if (isNewSearch) {
            $searchResultText.text(searchTerm);
            $searchResult.show();
            config.focusable.typeahead('destroy');
        }

        var currentTotalResults = $searchResultNumber.text();
        if (!currentTotalResults || currentTotalResults === '0') {
            $searchResultNumber.text(totalResults);
        }

        for (var i = 0; i < $links.length; i++) {
            var $link = $($links[i]);
            var section = $link[0].dataset.section;

            if (section.toLowerCase() === searchType.toLocaleLowerCase()) {
                if (currentResultCount > 0) {
                    $link.removeClass('disabled').removeAttr('disabled');
                    if (config.device === 'DESKTOP' && $link.hasClass(config.defaultShow)) {
                        $link.click();
                    }
                } else {
                    $link.addClass('disabled').attr('disabled', 'disabled');
                }
            }
        }

        paginationElementsConfig.totalResults = totalResults;

        $tabContainer.text($tabContainer.text().replace(DEFAULTS.NUMBER_REGISTER, currentResultCount.toString())).removeClass('hidden');

        config.totalResults = totalResults;
        if (config.totalResults > 0) {
            activatePagination(paginationElementsConfig, resultSet.items, categories, config, engine, searchType);
        }
    }

    function activatePagination(paginationElementsConfig, items, categories, config, engine, searchType) {
        var $paginationContainer = paginationElementsConfig.$paginationContainer;
        var $resultContainer = paginationElementsConfig.$resultContainer;
        var $initialPageNumberContainer = paginationElementsConfig.$initialPageNumberContainer;
        var $finishPageNumberContainer = paginationElementsConfig.$finishPageNumberContainer;
        var $totalResultsContainer = paginationElementsConfig.$totalResultsContainer;
        var searchResults = paginationElementsConfig.searchResults;
        var renderItemsFunction = paginationElementsConfig.renderItemsFunction;
        $(config.paginationResultBar).removeClass('hidden');
        $(config.paginationjs).removeClass('hidden');
        if (config.pageSize[searchType.toLocaleLowerCase()] === undefined) {
            config.pageSize[searchType.toLocaleLowerCase()] = 10;
        }
        $paginationContainer.pagination({
            dataSource: items,
            className: 'row justify-content-center',
            prevText: '<i class="icon-arrow-single-left" style="font-size: 14px;"></i>',
            nextText: '<i class="icon-arrow-single-right" style="font-size: 14px;"></i>',
            firstText: '<i class="icon-arrow-double-left"></i>',
            lastText: '<i class="icon-arrow-double-right"></i>',
            pageRange: 2,
            pageSize: config.pageSize[searchType.toLocaleLowerCase()],
            callback: function (data, pagination) {
                var initNumber = (pagination.pageSize * (pagination.pageNumber - 1) + 1);
                $initialPageNumberContainer.text(initNumber);

                var lastRegisterNumber = data.length < pagination.pageSize ? ((pagination.pageSize * pagination.pageNumber) - pagination.pageSize + data.length) : pagination.pageSize * pagination.pageNumber;
                $finishPageNumberContainer.text(lastRegisterNumber);
                $totalResultsContainer.text(searchResults);

                if (data && data.length) {
                    var html = renderItemsFunction(data, config);
                    $resultContainer.html(html);

                    if (engine.manageWebContentCategories) {
                        engine.manageWebContentCategories(searchType, config, categories);
                    }

                    $('.js-substring').succinct({
                        ignore: false,
                        size: config.device === 'DESKTOP' ? 500 : 120
                    });
                }
            }
        });

        $paginationContainer.addHook('beforePaging', beforePaging);
    }

    function beforePaging(page) {
        scrollToTop();
    }

    function scrollToTop() {
        $('html, body').animate({scrollTop: 0}, 'slow');
    }

    function showEquivalenceResults(data, config) {
        $('#' + config.searchResultText).text(data.searchvalue);
        $('#' + config.searchResultNumber).text(data.pnsearchresultsnumber);
        $('#' + config.productNumber).text('(' + 0 + ')');
        $('#' + config.webcontentNumber).text('(' + 0 + ')');

        config.$equivalentContainer = $("#" + config.smcEquivalentContainerProducts);
        generateEquivalencesHtml(data, config);
    }

    function showPNResults(data, config) {
        $(config.resultsContainer).addClass('loading searching');
        $('#' + config.searchResultText).text(data.searchvalue);
        $('#' + config.searchResultNumber).text(data.pnsearchresultsnumber);
        $('#' + config.searchResult).show();

        $(config.webContentTab).find(config.paginationResultBar).addClass('hidden');
        $(".paginationjs.container").addClass('hidden');
        // $(config.smcEquivalentLink).removeClass('disabled hidden').removeAttr('disabled');
        //$(config.enableLink).addClass('disabled').attr('disabled', 'disabled');

        // if (config.device ==='DESKTOP') {
        //     // $(config.smcEquivalentLink).click();
        // } else {
        //     //TODO Open in mobile devices
        // }
        config.$equivalentContainer = $("#" + config.productsContainer);
        generatePNResultsHtml(data, config)
            .then(function (response) {
                config.$equivalentContainer.find(".content").html(response);
                $(".image-disclaimer").hide();
                // config.searchEquivalencesModule.activateTabs();
            });
    }

    function generateEquivalencesHtml(data, config) {
        var deferred = $.Deferred();
        var htmlText = '';
        var msgHeader = document.getElementById('equivalentHeaderTemplate').innerHTML.replace('{{term}}', data.searchvalue);

        var $msgBody =
            $("<div class='equivalent-result-container equivalent-result-container-js'>" +
                config.templates.spinner +
                "</div>");

        var requests = [];
        var buildEquivalentResultRowUrl = new URL(globalConfig.generalSearchEngine.urls.buildEquivalentResultRowUrl);
        if (!data.pnsearchresults.length) data.pnsearchresults.push(data.seesearchpartnumber);//To maintain multiple match
        data.pnsearchresults.forEach(function (result, index) {
            requests.push((function (productId, partNumber, locale) {
                buildEquivalentResultRowUrl.searchParams.set('productId', productId !== undefined ? productId : "");
                buildEquivalentResultRowUrl.searchParams.set('partNumber', partNumber);
                buildEquivalentResultRowUrl.searchParams.set('locale', locale);
                buildEquivalentResultRowUrl.searchParams.set('resultNumber', index);
                buildEquivalentResultRowUrl.searchParams.set('tabName', 'SMC_EQUIVALENT');
                return $.get(buildEquivalentResultRowUrl.toString());
            })(result.productid, data.seesearchpartnumber, config.lang));
        });

        var msgFooter = document.getElementById('equivalentFooterTemplate').innerHTML;
        $.when.apply($, requests)
            .then(function () {
                var results = Array.prototype.slice.call(arguments, 0, requests.length);
                $msgBody.text('');
                results.forEach(function (row) {
                    $msgBody.append($(row));
                });
                htmlText += msgHeader;
                htmlText += $msgBody[0].outerHTML;
                htmlText += msgFooter;
                if (htmlText !== undefined && htmlText !== "") {
                    $(config.smcEquivalentLink).removeClass('disabled hidden').removeAttr('disabled');
                    $(config.enableLink).addClass('disabled').attr('disabled', 'disabled');
                    config.$equivalentContainer.html(htmlText);
                    config.searchEquivalencesModule.activateTabs();
                    if (config.device === 'DESKTOP') {
                        $(config.smcEquivalentLink).click();
                    } else {
                        //TODO Open in mobile devices
                    }
                }
            });

        return deferred.promise();
    }

    function generatePNResultsHtml(data, config) {
        var deferred = $.Deferred();
        var htmlText = '';
        var msgHeader = '';

        // Only show unrecognized part message
        if (data.pnsearchmessage.length > 0 && data.searchvalue.indexOf(data.pnsearchunrecognizedchain) > -1) {
            msgHeader = document.getElementById('partialMatchHeaderTemplate').innerHTML.replace('{{message}}', data.pnsearchmessage);
        }

        $(config.resultsContainer).addClass('loading searching');
        $(config.paginationjs).addClass('hidden');
        var $msgBody =
            $("<div class='equivalent-result-container equivalent-result-container-js'>" +
                config.templates.spinner +
                "</div>");
        config.$equivalentContainer.find(".content").html($msgBody);
        var requests = [];
        var buildPartialMatchResultRowUrl = new URL(globalConfig.generalSearchEngine.urls.buildPartialMatchResultRowUrl);

        if (!data.pnsearchresults.length) data.pnsearchresults.push(data.searchvalue);//To maintain multiple match
        data.pnsearchresults.forEach(function (result, index) {
            requests.push((function (productId, partNumber, locale) {
                buildPartialMatchResultRowUrl.searchParams.set('productId', productId);
                buildPartialMatchResultRowUrl.searchParams.set('partNumber', partNumber);
                buildPartialMatchResultRowUrl.searchParams.set('locale', locale);
                buildPartialMatchResultRowUrl.searchParams.set('resultNumber', index);
                buildPartialMatchResultRowUrl.searchParams.set('tabName', 'PRODUCT_CATALOGUE');
                return $.get(buildPartialMatchResultRowUrl.toString());
            })(result.productid, data.searchvalue, config.lang));
        });
        $.when.apply($, requests)
            .then(function () {
                var results = Array.prototype.slice.call(arguments, 0, requests.length);
                $msgBody.text('');
                results.forEach(function (row) {
                    if (row !== undefined && row !== "") {
                        if (Array.isArray(row)) {
                            $msgBody.html($msgBody.html() + row[0]);
                        } else {
                            $msgBody.html($msgBody.html() + row);
                        }
                    }
                });

                htmlText += msgHeader;

                htmlText += $msgBody[0].outerHTML;
                $(config.resultsContainer).removeClass('loading searching');
                deferred.resolve(htmlText);
            });

        return deferred.promise();
    }

    function showProductCatalogueResults(data, config, searchType, swiftypeApi) {
        $('#' + config.productNumber).text('(' + data.length + ')').removeClass('hidden');
        $('#' + config.searchResult).show();

        $(config.productTab + ' ' + config.initNumber).text(1);
        $(config.productTab + ' ' + config.finishPageNumber).text(data.length);
        $(config.productTab + ' ' + config.searchTotal).text(data.length);
        $(config.smcProductCatalogueTabLink).removeClass('disabled').removeAttr('disabled');
        //Hide Pagination container because we don't have any pags
        $(config.paginationjs).addClass('hidden');
        //TODO Add pagination without removing already printed HTML code
        /* $('#' + config.productsContainer).pagination({
            className:'row justify-content-center',
            prevText:'<i class="icon-arrow-single-left" style="font-size: 14px;"></i>',
            nextText:'<i class="icon-arrow-single-right" style="font-size: 14px;"></i>',
            firstText:'<i class="icon-arrow-double-left"></i>',
            lastText:'<i class="icon-arrow-double-right"></i>',
            pageRange: 2,
            pageSize: config.pageSize[searchType.toLocaleLowerCase()]
        });*/

        config.$equivalentContainer = $("#" + config.productsContainer);
        generateProductCatalogueResultsHtml(data, config, swiftypeApi)
            .then(function (response) {
                config.$equivalentContainer.find(".content").html(response);
                // config.searchEquivalencesModule.activateTabs();
            });
    }

    function generateProductCatalogueResultsHtml(data, config, swiftypeApi) {
        var deferred = $.Deferred();
        var txtHtml = '<div class="search_results">';
        data && data.forEach(function (dataRow) {
            var url = dataRow.url;
            var imageUrl = dataRow.node.images[0] && dataRow.node.images[0].url;
            //check for multiple urls
            if (imageUrl !== undefined && imageUrl !== "") {
                var splittedImages = imageUrl.toString().split("http");
                if (splittedImages.length > 1) {
                    imageUrl = imageUrl.toString().split(",http")[0];
                }
            }
            var imageTitle = dataRow.node.images[0] && dataRow.node.images[0].title;
            var productName = dataRow.node.name;
            var body = dataRow.node.description;
            txtHtml += swiftypeApi.generateCatalogueProductRowHtml(url, imageUrl, productName, imageTitle, body)
        });
        txtHtml += '</div>';
        deferred.resolve(txtHtml);

        return deferred.promise();
    }

    function getResults(term, config, swiftypeApi, sectionId) {
        console.log('[GeneralSearch]', 'getResults', 'term=', term);
        setupNewSearch(term, config, swiftypeApi, sectionId)
            .then(doSearch.bind(this, term, config, swiftypeApi, sectionId))
            .always(endSearch.bind(this, config));
    }

    function setupNewSearch(term, config, swiftypeApi, sectionId) {
        var def = $.Deferred();
        startLoading(config, sectionId);
        updateURLParams(term);

        var isNewSearch = term !== _term;
        if (isNewSearch) {
            config.searchId = Date.now();
            config.categories = [];
            _term = term;

            resetTabsStatus(config, swiftypeApi);
        }
        config.totalResults = 0;
        config.sectionId = sectionId;

        def.resolve();
        return def.promise();
    }

    function generateLog(term, resultType, pnResults, swDcResults, webContentResults, comesFromCache, seeResults, traceId, logStack, logId) {
        var hasSeeResults = false;
        if (seeResults === undefined) {
            seeResults = "0";
            hasSeeResults = false;
        } else {
            hasSeeResults = seeResults.length > 0;
        }
        var log = {
            term: term,
            language: "",
            country: "",
            pnResultsType: resultType,
            hasPnResults: pnResults > 0,
            searchPnFromCache: comesFromCache,
            pnResultsCount: pnResults,
            hasSwDcResults: swDcResults > 0,
            swDcResultsCount: swDcResults,
            hasSwWebContentResults: webContentResults > 0,
            swWebContentResultsCount: webContentResults,
            hasSeeResults: hasSeeResults,
            seeResultsCount: seeResults,
            responseTime: ((new Date()).getTime() - searchStartDate.getTime()),
            userProfile: 0,
            userName: "",
            logStack: JSON.stringify(logStack),
            traceId: traceId,
            logId: logId
        };
        return log;
    }

    function generateAction(type, url, pageNumber, resultNumber, tab, isNewTab) {
        var action = {
            type: type ? type : "CLICK",
            pageNumber: pageNumber,
            resultNumber: resultNumber,
            resultUrl: url,
            resultTab: tab,
            isNewTab: isNewTab
        };

        return action;
    }

    function doSearch(term, config, swiftypeApi, sectionId) {
        const url = globalConfig.generalSearchEngine.urls.getDataResults;
        let lang = config.lang;
        let traceId = $('#traceId').val();

        const isElasticSearch = getParameterByName("elasticSearch", window.location.href);
        if (isElasticSearch && isElasticSearch === 'true') {
            lang = "test_" + lang;
        }
        searchStartDate = new Date();
        if (config.oldRearchResultResponse) {
            let resultResponse = config.oldRearchResultResponse;
            config.oldRearchResultResponse = "";
            return manageSearchResult(resultResponse, traceId, config.productsPageName, config.products);
        }
        else {
            const data = {
                searchTerm: term,
                lang: lang,
                pageSize: config.pageSize[sectionId],
                traceId: traceId
            };
            return $.getJSON(url, data)
                .then(function (response) {
                    manageSearchResult(response.searchResultResponse, response.traceId, response.productsPageName, response.products);
                })
        }

        function manageSearchResult(searchResultResponse, traceId, responseProductsPageName, products) {
            let log;
            var SearchLog = window.smc.SearchLog;
            if (!searchLog) {
                searchLog = new SearchLog();
            }
            var def = $.Deferred();
            $('#traceId').val(traceId);
            productsPageName = responseProductsPageName;
            var pnSize = searchResultResponse.pnsearchresultsnumber;
            var pnSearchWithWarning = searchResultResponse.pnsearchmessage !== '';
            var searchType = getPnSearchType(pnSize, pnSearchWithWarning);
            var swDcSize = 0;
            var webContentSize = 0;
            var totalResultsInSearch = 0;
            var comesFromCache = searchResultResponse.pnsearchfromcache;
            var isPartNumberResult = searchResultResponse.searchresultssource === 'PN';
            var isStandardStockedItemsResult = searchResultResponse.searchresultssource === 'SEE'
                && searchResultResponse.seesearchpartnumber;
            var seeResults = searchResultResponse.seesearchpartnumber;
            let logStack = [];
            if (seeResults === undefined) {
                seeResults = "";
            }
            let unrecognizedMessage = !(searchResultResponse.pnsearchmessage === '' || searchResultResponse.pnsearchmessage === undefined);
            let frontMultipleSWLogRequired = false;
            let shortTerm = term.length <= 5 || (term.length - 3) <= searchResultResponse.pnsearchunrecognizedchain;
            let logId = searchResultResponse.logId;

            //Logs TraceId
            if (isPartNumberResult) {
                logStack.push(generateLogToStack(traceId, term, lang, "FRONT_PN_SOURCE", "true"));
                if (!unrecognizedMessage) {
                    logStack.push(generateLogToStack(traceId, term, lang, "FRONT_UNRECOGNIZED_MSG", "false"));
                    if (products && products.length === 1) {
                        logStack.push(generateLogToStack(traceId, term, lang, "FRONT_UNIQUE_RESULT", "true"));
                    } else {
                        logStack.push(generateLogToStack(traceId, term, lang, "FRONT_UNIQUE_RESULT", "false"));
                        frontMultipleSWLogRequired = true;
                    }
                } else {
                    logStack.push(generateLogToStack(traceId, term, lang, "FRONT_UNRECOGNIZED_MSG", "true"));
                    if (shortTerm) {
                        logStack.push(generateLogToStack(traceId, term, lang, "FRONT_UNRECOGNIZED_SHORT_SIM", "true"));
                    } else {
                        logStack.push(generateLogToStack(traceId, term, lang, "FRONT_UNRECOGNIZED_SHORT_SIM", "false"));
                    }
                }
            } else {
                logStack.push(generateLogToStack(traceId, term, lang, "FRONT_PN_SOURCE", "false"));
                if (isStandardStockedItemsResult) {
                    logStack.push(generateLogToStack(traceId, term, lang, "FRONT_SEE_SOURCE", "true"));

                } else {
                    logStack.push(generateLogToStack(traceId, term, lang, "FRONT_SEE_SOURCE", "false"));
                }
            }

            if (/*isPartNumberResult &&*/ products && products.length === 1
                && (searchResultResponse.pnsearchmessage === '' || searchResultResponse.pnsearchmessage === undefined)) {
                log = generateLog(term, searchType, pnSize, swDcSize, webContentSize, comesFromCache, seeResults, traceId, logStack, logId);
                searchLog.createLog(log);
                setTimeout(function () {
                    //Do redirect like it were "searchresultssource === 'PN' && pnsearchresultsnumber === 1"
                    window.location.href = products[0].url;
                }, 1000);
                def.resolve();
            } else if (isPartNumberResult && searchResultResponse.pnsearchresultsnumber > 0
                && searchResultResponse.pnsearchmessage !== ''
                && searchResultResponse.pnsearchmessage !== undefined) {
                // One result with message --> Show single result
                showPNResults(searchResultResponse, config);
                def.resolve();
                log = generateLog(term, searchType, pnSize, swDcSize, webContentSize, comesFromCache, seeResults, traceId, logStack, logId);
                searchLog.createLog(log);
            } else if (isStandardStockedItemsResult) {
                showEquivalenceResults(searchResultResponse, config);
                def.resolve();
                log = generateLog(term, searchType, pnSize, swDcSize, webContentSize, comesFromCache, seeResults, traceId, logStack, logId);
                searchLog.createLog(log);
            } else {
                var hasProductCatalogueResults = products && products.length > 0;
                swiftypeApi.getResultsData(term, config, sectionId)
                    .then(function (productCatalogueResponse, webContentResponse) {
                        let totalResults;
                        let currentResultCount;
                        let log;
                        const isSameSearch = config.searchId === config.cache.searchId;
                        if (!webContentResponse) {
                            //We sum the results to maintain coherent counter when filtering in "Web Content" tab
                            if (isSameSearch && config.cache.webContentResponse) {
                                config.totalResults += config.cache.webContentResponse.info.page['total_result_count'];
                                totalResultsInSearch += config.cache.webContentResponse.info.page['total_result_count'];
                            }
                        }
                        if (productCatalogueResponse !== null && productCatalogueResponse !== undefined) {
                            config.cache.productCatalogueResponse = productCatalogueResponse;
                            swDcSize = config.cache.productCatalogueResponse.info.page['total_result_count'];
                            currentResultCount = config.cache.productCatalogueResponse.totalResultCount;
                            totalResults = config.totalResults === 0 ? currentResultCount || 0 : config.totalResults += currentResultCount;
                            totalResultsInSearch += config.cache.productCatalogueResponse.info.page['total_result_count'];
                            if (totalResults === 1 && config.cache.productCatalogueResponse.uniqueResultUrl) {
                                if (frontMultipleSWLogRequired) {
                                    logStack.push(generateLogToStack(traceId, term, lang, "FRONT_MULTIPLE_SW", "true"));
                                }
                                log = generateLog(term, searchType, pnSize, swDcSize, webContentSize, comesFromCache, seeResults, traceId, logStack, logId);
                                searchLog.createLog(log);
                            }
                            swiftypeApi.showProductCatalogueResults(config.cache.productCatalogueResponse, config, 'PRODUCT_CATALOGUE', renderResults);
                            config.cache.searchId = config.searchId;
                        }
                        if (!productCatalogueResponse) {
                            //We sum the results to maintain coherent counter when filtering in "Web Content" tab
                            if (isSameSearch && config.cache.productCatalogueResponse) {
                                totalResultsInSearch += config.cache.webContentResponse.info.page['total_result_count'];
                                config.totalResults += config.cache.webContentResponse.info.page['total_result_count'];
                            }
                        }
                        //[SMCD-713] Show PN results when no Swiftype's Product Catalogue results returned
                        if (config.cache.productCatalogueResponse !== undefined && config.cache.productCatalogueResponse['record_count'] === 0 && hasProductCatalogueResults) {
                            config.totalResults += products && products.length || 0;
                            showProductCatalogueResults(products, config, 'PRODUCT_CATALOGUE', swiftypeApi);
                            totalResultsInSearch += products.length;
                        }
                        if (webContentResponse) {
                            config.cache.webContentResponse = webContentResponse;
                            swiftypeApi.showWebContenDataResults(config.cache.webContentResponse, config, 'WEB_CONTENT', renderResults);
                            config.cache.searchId = config.searchId;
                            totalResultsInSearch += config.cache.webContentResponse.info.page['total_result_count'];
                            webContentSize = config.cache.webContentResponse.info.page['total_result_count'];
                            currentResultCount = config.cache.productCatalogueResponse.totalResultCount;
                            totalResults = config.totalResults === 0 ? currentResultCount || 0 : config.totalResults += currentResultCount;
                            if (totalResults === 1 && config.cache.productCatalogueResponse.uniqueResultUrl) {
                                if (frontMultipleSWLogRequired) {
                                    logStack.push(generateLogToStack(traceId, term, lang, "FRONT_MULTIPLE_SW", "true"));
                                }
                                log = generateLog(term, searchType, pnSize, swDcSize, webContentSize, comesFromCache, seeResults, traceId, logStack, logId);
                                searchLog.createLog(log);
                            }
                            swiftypeApi.showWebContenDataResults(config.cache.webContentResponse, config, 'WEB_CONTENT', renderResults);
                            config.cache.searchId = config.searchId;
                        }
                        config.totalResults = totalResultsInSearch;
                        $('#' + config.searchResultNumber).text("" + totalResultsInSearch);
                        def.resolve();
                        manageTabActivation(config.cache.productCatalogueResponse, config.cache.webContentResponse, products, config);
                        if (frontMultipleSWLogRequired) {
                            if (totalResultsInSearch > 0) {
                                logStack.push(generateLogToStack(traceId, term, lang, "FRONT_MULTIPLE_SW", "true"));
                            } else {
                                logStack.push(generateLogToStack(traceId, term, lang, "FRONT_MULTIPLE_SW", "false"));
                            }
                        }
                        log = generateLog(term, searchType, pnSize, swDcSize, webContentSize, comesFromCache, seeResults, traceId, logStack, logId);
                        searchLog.createLog(log);

                    });
            }
            return def.promise();
        }
    }



    function generateLogToStack(traceId, term, lang, phase, result) {
        return {
            info: "",
            language: lang,
            phase: phase,
            result: result,
            term: term,
            traceId: traceId
        }
    }

    function getPnSearchType(pnSize, withWarning) {
        var searchType = "NO_RESULTS";
        if (pnSize == 1) {
            if (withWarning) {
                searchType = "UNIQUE_WITH_WARNING";
            } else {
                searchType = "UNIQUE";
            }
        } else if (pnSize > 1) {
            if (withWarning) {
                searchType = "MULTIPLE_WITH_WARNING";
            } else {
                searchType = "MULTIPLE";
            }
        }
        return searchType;
    }

    function endSearch(config) {
        endLoading(config);
    }

    function startLoading(config, sectionId) {
        $(config.resultsContainer).addClass('loading searching');

        var $smcProductCatalogueTabLink = $(config.smcProductCatalogueTabLink);
        if (!sectionId && config.device === 'DESKTOP' && $($smcProductCatalogueTabLink).hasClass(config.defaultShow)) {
            $smcProductCatalogueTabLink.removeClass('disabled').click();
            $(config.smcEquivalentLink).addClass('hidden');
        }
    }

    function endLoading(config) {
        $(config.resultsContainer).removeClass('loading searching');
        reviewPortalUrls();
    }

    function updateURLParams(term) {
        var url = new URL(window.location.href);
        url.searchParams.set('searchTerm', window.smc.StringTools.encodeForUrl(term));

        window.history.pushState({}, window.document.title, url.toString());
    }

    function resetTabsStatus(config, swiftypeApi) {
        //Reset tab counters
        swiftypeApi.getProductCataloguePaginationConfig(config).$tabContainer.addClass('hidden').text(DEFAULTS.NUMBER_REGISTER_PLACEHOLDER);
        swiftypeApi.getWebContentPaginationConfig(config).$tabContainer.addClass('hidden').text(DEFAULTS.NUMBER_REGISTER_PLACEHOLDER);

        $('#' + config.searchResultNumber).text('0');

        if (config.device === 'PHONE' || config.device === 'TABLET') {
            ['.js-product-catalogue-link', '.js-web-content-link'].forEach(function (selector) {
                var target = $(selector).data('target');
                $(target).collapse('hide');
            });
        }
    }

    function onWebContentTabLinkClicked(e) {
        if (e) e.preventDefault();

        var $categoryContainer = $(this.config.categoryContainer);
        setTimeout(function () {
            var $enlargeCategoriesButton = $(this.config.enlageCategoriesButton);
            var isContentHidden = $categoryContainer[0].scrollHeight > $categoryContainer[0].clientHeight;
            if (isContentHidden) {
                $enlargeCategoriesButton.show();

            } else if (!isContentHidden && !$categoryContainer.hasClass('categories-button-container-full')) {
                $enlargeCategoriesButton.hide();
            }
        }.bind(this), 0);
    }

    function reviewPortalUrls() {
        var initialUrl = "";
        var link = $(".search_results .d-flex .col-3 a").first();
        if (link !== undefined && link !== null) {
            initialUrl = $(link).attr("href");
            if (initialUrl !== undefined) {
                initialUrl = initialUrl.substr(0, initialUrl.lastIndexOf("/"));
            }
        }
        if (initialUrl !== undefined) {
            $(".search_results .js-substring a").each(function () {
                var currentHref = $(this).attr("href");
                if (currentHref.indexOf("dc_product_id=") > 0) {
                    var productId = currentHref.substr((currentHref.indexOf("dc_product_id=") + "dc_product_id=".length));
                    var productName = $(this).text();
                    productName = productName.replace(" ", "-").replace(",", "");
                    var currentReplacedURL = initialUrl + "/" + productName + "~" + productId + "~cfg";
                    $(this).attr("href", currentReplacedURL);
                }
            });
        }
    }

    GeneralSearch.prototype.redirect = function (term) {
        var url = globalConfig.generalSearchEngine.urls.makeRedirect;
        window.location.href = url + "?searchTerm=" + window.smc.StringTools.encodeForUrl(term);
    };
    window.smc.GeneralSearch = GeneralSearch;
})(window.smc);


window.smc.StringTools = {

    /**
     * Encodes value in order to be valid for URLs
     *
     * @param value String
     * @returns {string} URL-compliant value
     */
    encodeForUrl: function (value) {
        /*if (decodeURIComponent(value) !== value) {
            console.log("VALUE: " + value);
            return value;
        }*/
        return encodeURIComponent(window.smc.StringTools.htmlEntities(value));
    },


    decodeFromUrl: function (value) {
        return decodeURIComponent(value).replace("[pl]", "+");
    },

    /**
     * Encodes value as HTML entities
     *
     * @param str String
     * @returns {string} Encoded value
     */
    htmlEntities: function (str) {
        return String(str).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;').replace("+", "[pl]");
    }

}

function getParameterByName(name, url) {
    name = name.replace(/[\[\]]/g, '\\$&');
    var regex = new RegExp('[?&]' + name + '(=([^&#]*)|&|#|$)'),
        results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, ' '));
}

