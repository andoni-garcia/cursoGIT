var searchStartDate = null;
(function(globalConfig) {
    const DEFAULT_SWIFTYPE_LANGUAGE = 'en';

    function SwiftypeEngine(locale) {
        var locales = locale.split("_");
        var language = locales[0];
        var country = locales[1];

        this.locale = SwiftypeEngine.prototype.locale = locale;
        this.language = SwiftypeEngine.prototype.language = getSwitypeLanguage(language);
        this.country = SwiftypeEngine.prototype.country = country;
        this.languageProductCataloge = SwiftypeEngine.prototype.languageProductCataloge = this.language;
    }

    SwiftypeEngine.prototype.init = init;
    SwiftypeEngine.prototype.getEngines = getEngines;
    SwiftypeEngine.prototype.getSwitypeEngines = getSwitypeEngines;
    SwiftypeEngine.prototype.getProductCataloguePaginationConfig = getProductCataloguePaginationConfig;
    SwiftypeEngine.prototype.getWebContentPaginationConfig = getWebContentPaginationConfig;
    SwiftypeEngine.prototype.showProductCatalogueResults = showProductCatalogueResults;
    SwiftypeEngine.prototype.showWebContenDataResults = showWebContenDataResults;
    SwiftypeEngine.prototype.manageWebContentCategories = manageWebContentCategories;
    SwiftypeEngine.prototype.generateSearchResultHtmlForWebContent = generateSearchResultHtmlForWebContent;
    SwiftypeEngine.prototype.generateSearchResultHtml = generateSearchResultHtml;
    SwiftypeEngine.prototype.generateCatalogueProductRowHtml = generateCatalogueProductRowHtml;

    function init() {
        SwiftypeEngine.prototype.productCatalogueType = 'PRODUCT_CATALOGUE';
        SwiftypeEngine.prototype.webContentType = 'WEB_CONTENT';
        SwiftypeEngine.prototype.suggestDCObtained = false;
        SwiftypeEngine.prototype.suggestSMCWebObtained = false;
        SwiftypeEngine.prototype.lastSuggestContent = [];

        var catelogueProductRowTemplate = document.getElementById('catelogueProductRow');
        SwiftypeEngine.prototype.templates = {
            catelogueProductRow: catelogueProductRowTemplate && catelogueProductRowTemplate.innerHTML || ''
        };

        return fetchSwitypeEngines(this.locale);
    }

    function getEngines() {
        return {
            PRODUCT_CATALOGUE: SwiftypeEngine.prototype.switypeEngines,
            WEB_CONTENT: SwiftypeEngine.prototype.switypeEngines
        }
    }

    function getSwitypeEngines() {
        return SwiftypeEngine.prototype.switypeEngines;
    }

    function fetchSwitypeEngines(locale) {
        // var data = {
        //     language: locale
        // };
        // var url = globalConfig.swiftypeEngineComponent.urls.getEnginesData;
        // return $.getJSON(url, data)
        //     .then(function (response) {
        //         var engines = [];
        //         for(var i = 0; i < response.length; i++){
        //             engines[response[i].type]=response[i];
        //         }
        //         SwiftypeEngine.prototype.switypeEngines = engines;
        //
        //         var def = $.Deferred();
        //         def.resolve(engines);
        //         return def.promise();
        //     });

        var def = $.Deferred();
        def.resolve([]);
        return def.promise();
    }

    function manageWebContentCategories(searchType, config, categories) {
        var isWebContentSearch = true;
        if (isWebContentSearch) {
            searchType = searchType.toLocaleLowerCase();

            var $categoryContainer = $(config.categoryContainer);
            if (categories && config.categories.length === 0) {
                $categoryContainer.html('');

                var buttonContainer = "";
                Object.keys(categories).forEach(function (key, index) {
                    var button = '<button type="button" class="btn btn-outline-secondary ' + config.categorySelector + '"';
                    var txt = key !== '' ? key : 'Other';
                    if (txt !== "_any_~cfg" && txt !== "_any_~nav") {
                        button += 'data-engine="' + searchType + '" data-len="' + config.pageSize[searchType] + '" data-category="' + key + '">' + txt + ' (' + this[key] + ')';
                        button += '</button>';
                        buttonContainer += button;
                    }
                }, categories);
                //console.log(buttonContainer);
                $categoryContainer.html(buttonContainer);
                $(config.resetButtonContainer).hide();

            } else if (!categories) {
                $categoryContainer.html('');
                $(config.resetButtonContainer).hide();
            } else {
                $(config.resetButtonContainer).show();
            }
        }
    }

    function generateLog (term, resultType){
        var swiftypePc = SwiftypeEngine.prototype.lastSuggestContent[SwiftypeEngine.prototype.productCatalogueType].records.page;
        var swiftypeWc = SwiftypeEngine.prototype.lastSuggestContent[SwiftypeEngine.prototype.webContentType].records.page;
        var log =  {
            term:term,
            language: SwiftypeEngine.prototype.language,
            country: SwiftypeEngine.prototype.country,
            pnResultsType: resultType,
            hasPnResults: swiftypePc.length > 0,
            searchPnFromCache : true,
            pnResultsCount: swiftypePc.length,
            hasSwDcResults:false,
            swDcResultsCount:0,
            hasSwWebContentResults:swiftypeWc.length > 0,
            swWebContentResultsCount:swiftypeWc.length,
            hasSeeResults: false,
            seeResultsCount: 0,
            responseTime: 0,
            userProfile: 0,
            userName: "name"
        };
        return log;
    }

    function getProductCataloguePaginationConfig(config) {
        return {
            $paginationContainer: $('#' + config.productsContainer),
            $resultContainer: $('#' + config.productsContainerProducts),
            $initialPageNumberContainer: $(config.productTab + ' ' + config.initNumber),
            $finishPageNumberContainer: $(config.productTab + ' ' + config.finishPageNumber),
            $totalResultsContainer: $(config.productTab + ' ' + config.searchTotal),
            $tabContainer: $('#' + config.productNumber),
            renderItemsFunction: generateSearchResultHtml
        };
    }

    function getWebContentPaginationConfig(config) {
        return {
            $paginationContainer: $('#' + config.webContentContainer),
            $resultContainer: $('#' + config.webContentContainerProducts),
            $initialPageNumberContainer: $(config.webContentTab + ' ' + config.initNumber),
            $finishPageNumberContainer: $(config.webContentTab + ' ' + config.finishPageNumber),
            $totalResultsContainer: $(config.webContentTab + ' ' + config.searchTotal),
            $tabContainer: $('#' + config.webcontentNumber),
            renderItemsFunction: generateSearchResultHtmlForWebContent
        };
    }

    function showProductCatalogueResults(data, config, searchType, renderResultsFunction) {
        var resultSet = {
            searchType: searchType,
            searchTerm: data.info.page.query,
            items: data.records.page,
            totalResultCount: data.info.page['total_result_count'],
            categories: [],
            uniqueResultUrl: null
            //uniqueResultUrl: data.records.page[0] && data.records.page[0].url
        };

        var paginationElementsConfig = getProductCataloguePaginationConfig(config);
        renderResultsFunction(paginationElementsConfig, resultSet, config, this);
    }

    function showWebContenDataResults(data, config, searchType, renderResultsFunction) {
        var resultSet = {
            searchType: searchType,
            searchTerm: data.info.page.query,
            items: data.records.page,
            totalResultCount: data.info.page['total_result_count'],
            categories: data.info.page.facets['swiftype_page_submenu'],
            uniqueResultUrl: null
            //uniqueResultUrl: data.records.page[0] && data.records.page[0].url
        };

        var paginationElementsConfig = getWebContentPaginationConfig(config);
        renderResultsFunction(paginationElementsConfig, resultSet, config, this);
    }


    function generateSearchResultHtmlForWebContent(data, config) {//emptyImageRoute,categorySelector
        var txtHtml ='<div class="search_results">';
        for(var i = 0; i < data.length; i++){
            var record = data[i];
            var url =record.hasOwnProperty('url') ? record.url : '';
            var title = record.hasOwnProperty('highlight') && record.highlight.hasOwnProperty('title') ?  record.highlight.title : record.title;
            var productName = record.title;
            var imageUrl = config.emptyImageRoute;

            if (record.hasOwnProperty('image') && record.image!==''){
                imageUrl = record.image;
            }
            var body = record['swiftype_product_info'] || record.body || '';
            let pageNumber = $('.paginationjs-page.J-paginationjs-page.active').data("num");
            txtHtml += generateCatalogueProductRowHtml(url, imageUrl, productName, title, sanitizeJsonArrayFromWebContent(body), "WEB_CONTENT", pageNumber,i + 1);
        }

        txtHtml += '</div>';
        return txtHtml;
    }


    function sanitizeJsonArrayFromWebContent(body){
        if (body.indexOf('{"formData":') >= 0){
            body = body.substring(0, body.indexOf(" {\"formData\":"));
        }
        return body;
    }

    function generateSearchResultHtml(data, config) {//emptyImageRoute,categorySelector
        var txtHtml ='<div class="search_results">';
        console.log("SWIFTYPE SEARCH RESULTS");
        for(var i = 0; i < data.length; i++){
            var record = data[i];
            var url =record.hasOwnProperty('url') ? record.url : '';

            //FIX Ensure we have the correct channel url
            if (globalConfig.generalSearchEngine && globalConfig.generalSearchEngine.config && globalConfig.generalSearchEngine.config.isElasticPCSearchAvailable == "true") {
                // Don't fix
            } else {
                url = _fixDigitalCatalogueUrl(url);
            }

            var title = record.hasOwnProperty('highlight') && record.highlight.hasOwnProperty('title') ?  record.highlight.title : record.title;
            var productName = record.title;
            var imageUrl = config.emptyImageRoute;
            if (record.hasOwnProperty('image') && record.image!==''){
                imageUrl = record.image;
            }
            //check for multiple urls
            if (imageUrl !== undefined && imageUrl !== ""){
                var splittedImages = imageUrl.toString().split("http");
                if (splittedImages.length > 1){
                    imageUrl = imageUrl.toString().split(",http")[0];
                }
            }
            var body = record['swiftype_product_info'] || record.body || '';
            let pageNumber = $('.paginationjs-page.J-paginationjs-page.active').data("num");
            txtHtml += generateCatalogueProductRowHtml(url, imageUrl, productName, title, body, "PRODUCT_CATALOGUE", pageNumber, i + 1);
        }

        txtHtml += '</div>';
        return txtHtml;
    }

    function generateCatalogueProductRowHtml(url, imageUrl, productName, imageTitle, body, tabName, pageNumber, resultNumber) {
        if (body.toString().indexOf("_any_~cfg") === 0 || body.toString().indexOf("_any_~nav") === 0) {
            body = body.substring("_any_~cfg".length);
        }
        return SwiftypeEngine.prototype.templates.catelogueProductRow
            .replace(/{{url}}/gm, url)
            .replace(/{{imageUrl}}/gm, imageUrl)
            .replace(/{{title}}/gm, imageTitle)
            .replace(/{{productName}}/gm, productName)
            .replace(/{{body}}/gm, body)
            .replace(/{{tabName}}/gm, tabName)
            .replace(/{{pageNumber}}/gm, pageNumber)
            .replace(/{{resultNumber}}/gm, resultNumber)
            ;
    }

    function getSwitypeLanguage(language) {
        if (['de', 'es', 'it', 'fr', 'cs', 'ru', 'pl', 'hu'].indexOf(language) > -1) {
            return language;
        }

        if (language === 'sk') {
            return 'cs';
        }

        return DEFAULT_SWIFTYPE_LANGUAGE;
    }

    /**
     * FIX Ensure we have the correct channel url
     */
    function _fixDigitalCatalogueUrl(url) {
        //TODO Set al inmutable place to get the Product catalogue url from (/sv-se/produkter)
        var channelDigitalCatalogUrlPathname = new URL(document.getElementsByClassName('parent-item')[0].href).pathname;
        var fixedUrl = new URL(url);
        if (productsPageName !== undefined){
            var currentPathname = fixedUrl.pathname.split('/');
            currentPathname.shift();//get rid of empty slot
            currentPathname.shift();//get rid of /en-eu
            currentPathname.shift();//get rid of /products
            if (channelDigitalCatalogUrlPathname.indexOf("/site") < 0 ){
                fixedUrl.pathname =  channelDigitalCatalogUrlPathname.substr(0,6) + '/' +productsPageName + '/' + currentPathname;
            }else {
                fixedUrl.pathname =  channelDigitalCatalogUrlPathname.substr(5,6) + '/' +productsPageName + '/' + currentPathname;
            }
            return fixedUrl.toString().replace("/search/","/");

        }
        var fixedUrlStr = fixedUrl.toString().replace("/en-gb",channelDigitalCatalogUrlPathname.substr(0,6));
        return fixedUrlStr;
    }

    function isElasticSearch() {
        return true;
    }

    function isWebContentElasticSearch() {
        return true;
    }

    SwiftypeEngine.prototype.getResultsData =function(term, config, sectionId) {
        $(config.smcEquivalentLink).addClass('disabled');

        if(sectionId === null){
            return $.when(getSwiftypeSearchProductCatalogueResults(term), getSwiftypeSearchWebContentTypeResults(term, config));

        } else if(SwiftypeEngine.prototype.productCatalogueType === sectionId.toUpperCase()){
            // if (isElasticSearch()) {
            //     return $.when(getElasticSearchProductCatalogueResults(term), null);
            // } else {
            return $.when(getSwiftypeSearchProductCatalogueResults(term), null);
            // }

        } else if(SwiftypeEngine.prototype.webContentType === sectionId.toUpperCase()) {
            return $.when(null, getSwiftypeSearchWebContentTypeResults(term, config));
        }

        //----------Functions -------------//
        function getActiveCategoriesString(activeCategories) {
            var categoriesString = "";

            for(var i = 0; i < activeCategories.length; i++){
                categoriesString += "\"";
                categoriesString += activeCategories[i];
                categoriesString += "\"";
                if (i < activeCategories.length - 1) {
                    categoriesString += ","
                }
            }
            return categoriesString;
        }

        function getSwiftypeSearchProductCatalogueResults(term) {
            var params = {};
            var termAux = term;

            if (isElasticSearch()) {
                // Don't change term
            } else {
                if (term !== undefined && term.toString().indexOf("-") > -1){
                    termAux = "\"" + term + "\"";
                }
            }
            params['q'] = termAux;
            params['searchTerm'] = termAux;

            params['per_page'] = 100;//$('#rows_per_page').val();
            params['limit'] = 100;
            params['page'] = 1;
            params['filters'] = JSON.parse('{"page": {"swiftype_language": {"type": "and","values": ["' + SwiftypeEngine.prototype.languageProductCataloge + '"]}}}');
            params['fetch_fields'] = JSON.parse('{"page":["title", "image", "url", "swiftype_product_info", "body"]}');
            params['functional_boosts'] = JSON.parse('{"page":{"swiftype_boost_page" : "linear"}}');
            params['highlight_fields'] = JSON.parse('{"page":{"title": {"size": 100,"fallback": false}, "swiftype_product_info": {"size": 1500,"fallback": false}}}');

            //TODO (1/2) The Swift API has to be used page by page, not the entire register
            var result;
            return fetchAllSwiftypeSearchProductCatalogueResults(params, result, $.Deferred());
        }

        function getElasticSearchProductCatalogueResults(term) {
            var params = {};
            var termAux = term;

            if (term !== undefined && term.toString().indexOf("-") > -1){
                termAux = "\"" + term + "\"";
            }
            params['q'] = termAux;
            params['searchTerm'] = termAux;
            params['limit'] = $('#rows_per_page').val();
            params['page'] = 1;

            var result;
            return fetchAllSwiftypeSearchProductCatalogueResults(params, result, $.Deferred());
        }

        function fetchAllSwiftypeSearchProductCatalogueResults(params, result, def) {
            fetchSwiftypeSearchResults(params, 'PRODUCT_CATALOGUE')
                .then(function (data) {
                    if (result) {
                        result.records.page = result.records.page.concat(data.records.page);
                    } else {
                        result = data;
                    }

                    if (result.records.page.length < data.info.page['total_result_count']) {
                        params['page'] ++;
                        fetchAllSwiftypeSearchProductCatalogueResults(params, result, def);
                    } else {
                        def.resolve(result);
                    }
                });

            return def.promise();
        }

        function fetchSwiftypeSearchResults(params, engine) {
            var endpoint = 'https://api.swiftype.com/api/v1/public/engines/search.json';
            if (engine === 'PRODUCT_CATALOGUE' && isElasticSearch()) {
                endpoint = globalConfig.generalSearchEngine.urls.getProductCatalogueSearchResults;
                endpoint = getURLRemoveParam(endpoint, "searchTerm")
            } else if (engine === 'WEB_CONTENT') {
                endpoint = globalConfig.generalSearchEngine.urls.getWebContentSearchResults;
                endpoint = getURLRemoveParam(endpoint, "searchTerm")
            }
            return $.getJSON(endpoint, params);
        }

        function getURLRemoveParam(urlToChange, paramToRemove) {
            var url = new URL(urlToChange);
            var search_params = url.searchParams;

            // new value of "id" is set to "101"
            search_params.delete(paramToRemove);

            // change the search property of the main url
            url.search = search_params.toString();

            // the new url string
            return url.toString();
        }

        function sanitizeSearchTerm(searchTerm){
            if (searchTerm !== null && searchTerm !== undefined && searchTerm !== "undefined"){
                var re = new RegExp("([+\\-!\\(\\){}\\[\\]^\"~*?:\\\\]|[&\\|]{2})");
                searchTerm = searchTerm.replace(re,"\\\\$1");
            }
            return searchTerm;
        }

        function getSwiftypeSearchWebContentTypeResults(term,config) {
            var params = {};
            params['q'] = term;
            params['searchTerm'] = term;
            params['per_page'] = 100;//$('#rows_per_page').val();
            params['page'] = 1;

            params['search_fields'] = JSON.parse('{"page":["title", "body", "swiftype_page_keywords"]}');
            params['fetch_fields'] = JSON.parse('{"page":["title", "image", "url", "body"]}');
            if(config.categories.length > 0){
                var categoryFilter = '{"page": {"swiftype_page_submenu": [' +getActiveCategoriesString(config.categories) + ']}}';
                console.log(categoryFilter);
                params['filters'] = JSON.parse(categoryFilter);
            }
            params['facets'] = JSON.parse('{"page":["swiftype_page_submenu"]}');

            //TODO (1/2) The Swift API has to be used page by page, not the entire register
            var result;
            return fetchAllSwiftypeSearchWebContentTypeResults(params, result, $.Deferred());
        }

        function fetchAllSwiftypeSearchWebContentTypeResults(params, result, def) {
            fetchSwiftypeSearchResults(params, 'WEB_CONTENT')
                .then(function (data) {
                    if (result) {
                        result.records.page = result.records.page.concat(data.records.page);
                    } else {
                        result = data;
                    }

                    if (result.records.page.length < data.info.page['total_result_count'] && params.page < data.info.page["num_pages"]) {
                        params['page'] ++;
                        fetchAllSwiftypeSearchWebContentTypeResults(params, result, def);
                    } else {
                        def.resolve(result);
                    }
                });

            return def.promise();
        }
    };

    SwiftypeEngine.prototype.getAutoComplete = function (rawTerm, autocomplete, searchLogApi, searchApi, typeaheadConfig, loadingContainerSelector, language,
                                                         country) {
        console.debug('[SwiftypeEngine]', 'getAutoComplete', 'init');
        //se inicializa el componente vacio.
        initAutocomplete(autocomplete);
        typeaheadConfig = typeaheadConfig || {};

        var term = window.smc.StringTools.htmlEntities(rawTerm);

        var ssiProductsUrl = getSsiProductsUrl();
        $.getJSON(ssiProductsUrl, { searchTerm: term, lang: language, country: country })
            .then(function (response) {
                if (response.numElements > 0) {
                    showSsiSuggest(response);
                }
            });

        function showSsiSuggest(response) {
            autocomplete.parent().addClass('ssi-search-result').removeClass('swiftype-search-result');
            printSsiProductSuggestResults(response, autocomplete, searchApi, typeaheadConfig);
        }


        function getSwiftypeSuggestForKey(engine, term, autocomplete, searchLogApi, searchApi, typeaheadConfig) {
            var params = {};

            params['engine_key'] = engine.enginekey;
            params['q'] = window.smc.StringTools.encodeForUrl(term);
            params['searchTerm'] = window.smc.StringTools.encodeForUrl(term);
            params['page'] = "1";
            params['per_page'] = "5";
            params['limit'] = "5";
            params['fetch_fields'] = JSON.parse('{"page":["title", "url"]}');
            if(engine.type === SwiftypeEngine.prototype.productCatalogueType){
                params['functional_boosts'] = JSON.parse('{"page":{"swiftype_boost_page" : "linear"}}');
                params['filters'] = JSON.parse('{"page": {"swiftype_language": {"type": "and","values": ["' + SwiftypeEngine.prototype.languageProductCataloge + '"]}}}');
            }

            var endpoint = 'https://api.swiftype.com/api/v1/public/engines/suggest.json';
            if (engine.type  === 'PRODUCT_CATALOGUE' && isElasticSearch()) {
                endpoint = getSuggestUrl();
            } else if (engine.type  === 'WEB_CONTENT' && isWebContentElasticSearch()) {
                endpoint = getWcSuggestUrl();
            }
            $.getJSON(endpoint, params)
                .then(function (data) {

                    if(engine.type === SwiftypeEngine.prototype.productCatalogueType){
                        SwiftypeEngine.prototype.suggestDCObtained = true;
                    }
                    else if(engine.type === SwiftypeEngine.prototype.webContentType){
                        SwiftypeEngine.prototype.suggestSMCWebObtained = true;
                    }

                    if(SwiftypeEngine.prototype.suggestDCObtained && SwiftypeEngine.prototype.suggestSMCWebObtained){
                        SwiftypeEngine.prototype.lastSuggestContent[engine.type] = data;
                        SwiftypeEngine.prototype.suggestDCObtained = false;
                        SwiftypeEngine.prototype.suggestSMCWebObtained = false;


                        printSwiftypeSuggestResults(SwiftypeEngine.prototype.lastSuggestContent, autocomplete,searchApi,typeaheadConfig);
                        // var log = generateLog(term);
                        // searchLogApi.createLog(log);
                    } else{
                        SwiftypeEngine.prototype.lastSuggestContent[engine.type] = data;
                    }
                });
        }

        function initAutocomplete(component) {
            component.typeahead({
                source: [],
                autoSelect: true
            });
        }

        function formatData(swiftype_data, key) {
            var result = swiftype_data.map(function (item) {
                return {"name": item.title, "itemLink": item.url, type: key, searchApi: searchApi};
            });

            return result;
        }

        function formatSsiProductResult(ssiProduct) {
            return {
                name: ssiProduct.partNumber,
                itemLink: '',
                type: 'PRODUCT_CATALOGUE'
            }
        }

        function printSsiProductSuggestResults(response, autocomplete, searchApi, typeaheadConfig) {
            console.debug('[SwiftypeEngine]', 'printSsiProductSuggestResults', 'init');

            var data = [];
            response.content.forEach(function (result) {
                data.push(formatSsiProductResult(result));
            });

            typeaheadConfig.isSsiSearch = true;
            typeaheadConfig.followLinkOnSelect = false;

            printSuggestResults(data, autocomplete, searchApi, typeaheadConfig);
        }

        function printSwiftypeSuggestResults(returnedData, autocomplete, searchApi, typeaheadConfig) {
            console.debug('[SwiftypeEngine]', 'printSwiftypeSuggestResults', 'init');

            var swiftypePc = SwiftypeEngine.prototype.lastSuggestContent[SwiftypeEngine.prototype.productCatalogueType].records.page;
            var swiftypeWc = SwiftypeEngine.prototype.lastSuggestContent[SwiftypeEngine.prototype.webContentType].records.page;

            var products = (formatData(swiftypePc,SwiftypeEngine.prototype.productCatalogueType));
            products = products.concat(formatData(swiftypeWc,SwiftypeEngine.prototype.webContentType));
            typeaheadConfig.isSsiSearch = false;
            typeaheadConfig.followLinkOnSelect = true;
            typeaheadConfig.changeInputOnSelect = false;

            printSuggestResults(products, autocomplete, searchApi, typeaheadConfig);
        }

        function printSuggestResults(data, autocomplete, searchApi, typeaheadConfig) {
            console.debug('[SwiftypeEngine]', 'printSuggestResults', 'init');

            var typeahead = autocomplete.data('typeahead');
            if (data.length) {
                if (typeahead) {
                    typeahead.destroy();
                }

                var typeAheadConfig = {
                    source: data,
                    hint: typeaheadConfig !== null && typeaheadConfig.hasOwnProperty('hint') ? typeaheadConfig.hint : true,
                    highlight: typeaheadConfig !== null && typeaheadConfig.hasOwnProperty('highlight') ? typeaheadConfig.highlight : true,
                    fitToElement: typeaheadConfig !== null && typeaheadConfig.hasOwnProperty('fitToElement') ? typeaheadConfig.fitToElement : true,
                    selectOnBlur: typeaheadConfig !== null && typeaheadConfig.hasOwnProperty('selectOnBlur') ? typeaheadConfig.selectOnBlur : false,
                    autoSelect: typeaheadConfig !== null && typeaheadConfig.hasOwnProperty('autoSelect') ? typeaheadConfig.autoSelect : false,
                    items: typeaheadConfig !== null && typeaheadConfig.hasOwnProperty('items') ? typeaheadConfig.items : 10,
                    followLinkOnSelect: typeaheadConfig !== null && typeaheadConfig.hasOwnProperty('followLinkOnSelect') ? typeaheadConfig.followLinkOnSelect : false,
                    followLinkOnEnter: typeaheadConfig !== null && typeaheadConfig.hasOwnProperty('followLinkOnEnter') ? typeaheadConfig.followLinkOnEnter : true,
                    minLength: typeaheadConfig !== null && typeaheadConfig.hasOwnProperty('minLength') ? typeaheadConfig.minLength : 3,
                    changeInputOnMove: typeaheadConfig !== null && typeaheadConfig.hasOwnProperty('changeInputOnMove') ? typeaheadConfig.changeInputOnMove : true,
                    changeInputOnSelect: typeaheadConfig !== null && typeaheadConfig.hasOwnProperty('changeInputOnSelect') ? typeaheadConfig.changeInputOnSelect : true,
                    matcher: function (items) { return items; },//we already do the filter in Swiftype, so we disable typeahead match filter
                    sorter: function (items) { return items; }//we already do the sort in Swiftype, so we disable typeahead sorting filter
                };
                typeAheadConfig.afterSelect = typeAheadConfig.changeInputOnSelect ? doSwiftypeSearch : $.noop;
                console.debug('[SwiftypeEngine]', 'printSuggestResults', 'typeAheadConfig', typeAheadConfig);

                if (typeaheadConfig.isSsiSearch) {
                    typeAheadConfig.addItem = {
                        itemLink: '',
                        itemTitle: '',
                        name: searchApi.config.messages.ssiDisclaimer,
                        type: 'NOT_SELECTABLE'
                    }
                }

                autocomplete.typeahead(typeAheadConfig);
                autocomplete.typeahead("lookup");

                //Set Disabled Class
                typeahead = autocomplete.data('typeahead');
                if (typeaheadConfig.isSsiSearch) {
                    setTimeout(function () {
                        typeahead.$menu[0].lastChild.className += ' disabled ';
                    }, 250);
                }

            } else {
                if (typeahead) {
                    typeahead.destroy();
                }
            }
        }

        function doSwiftypeSearch(optionSelected) {
            term = optionSelected.name;
            searchStartDate = new Date();
            $(document).trigger('smc.generalsearch.dosearch', [term]);
        }

        function getSsiProductsUrl() {
            var getSsiProductsUrl = globalConfig.swiftypeEngineComponent.urls.getSsiProducts;
            getSsiProductsUrl = new URL(window.location.origin + getSsiProductsUrl);
            getSsiProductsUrl.searchParams.delete('searchTerm');
            return getSsiProductsUrl.toString();
        }

        function getSuggestUrl() {
            var getSuggestUrl = globalConfig.swiftypeEngineComponent.urls.getSuggest;
            getSuggestUrl = new URL(window.location.origin + getSuggestUrl);
            getSuggestUrl.searchParams.delete('searchTerm');
            return getSuggestUrl.toString();
        }

        function getWcSuggestUrl() {
            var getWcSuggestUrl = globalConfig.swiftypeEngineComponent.urls.getWcSuggest;
            getWcSuggestUrl = new URL(window.location.origin + getWcSuggestUrl);
            getWcSuggestUrl.searchParams.delete('searchTerm');
            return getWcSuggestUrl.toString();
        }
    };
    window.smc.SwiftypeEngine = SwiftypeEngine;
})(window.smc);