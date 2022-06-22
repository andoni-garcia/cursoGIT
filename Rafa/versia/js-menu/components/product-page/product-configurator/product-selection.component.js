(function (window) {
    var globalConfig = window.smc;

    function ProductSelection(config) {
        this.id = config.id;
        this.config = config;
    }

    //Polyfill for IE CustomEvent
    (function () {

        if (typeof window.CustomEvent === "function") return false;

        function CustomEvent(event, params) {
            params = params || {bubbles: false, cancelable: false, detail: undefined};
            var evt = document.createEvent('CustomEvent');
            evt.initCustomEvent(event, params.bubbles, params.cancelable, params.detail);
            return evt;
        }

        CustomEvent.prototype = window.Event.prototype;

        window.CustomEvent = CustomEvent;
    })();

    //Polyfill for IE startsWith
    if (!String.prototype.startsWith) {
        Object.defineProperty(String.prototype, 'startsWith', {
            value: function (search, rawPos) {
                var pos = rawPos > 0 ? rawPos | 0 : 0;
                return this.substring(pos, pos + search.length) === search;
            }
        });
    }

    ProductSelection.prototype.init = init;
    ProductSelection.prototype.initialWorkflow = initialWorkflow;
    ProductSelection.prototype.initializeEvents = initializeEvents;
    ProductSelection.prototype.makeSearch = makeSearch;
    ProductSelection.prototype.getFilterValues = getFilterValues;
    ProductSelection.prototype.getFilterElements = getFilterElements;
    ProductSelection.prototype.updateFiltersWithConfiguration = updateFiltersWithConfiguration;
    ProductSelection.prototype.sendFilterValuesToConfigurator = sendFilterValuesToConfigurator;
    // ProductSelection.prototype.updateURLParams = updateURLParams;
    ProductSelection.prototype.getConfigFromUrl = getConfigFromUrl;
    ProductSelection.prototype.areAllSelectsWithValue = areAllSelectsWithValue;

    function init() {
        console.debug('[ProductSelection]', 'init id=', this.id);
        this.$configuratorContainer = $('#smc-psearch');
        this.$configurationArea = $('#configuration_area', this.$configuratorContainer);
        this.$configurationAreaSelects = $('select', this.$configurationArea);
        this.firstLoad = true;
        this.lastProductIdFound = "";
        if (getUrlParameter("productId") !== undefined) {
            this.lastProductIdFound = getUrlParameter("productId");
        }
        this.initialWorkflow();
        this.initializeEvents();
        $(".optionStatus img").addClass("hidden");
        this.reloadingFilterValues = false;
        if ($("#cpn_partnumber").text() !== undefined && $("#cpn_partnumber").text() !== "") {
            this.makeSearch();
        }
        this.getConfigFromUrl();
    }

    function initialWorkflow() {
        //Override values as necessary in calling document.
        window.gNoConstraintColor = '';
        window.gExcludedChoiceColor = "#FF191F";
        window.gHardConstraintColor = "#FF191F";
        window.gSoftConstraintColor = "#807000";

        //Activate Select2
        var _self = this;
        $('td.optionValue', this.$configurationArea).addClass('smc-select');
        var $selects = $('td.optionValue', this.$configurationArea).find('select');
        $('option:first', $selects).text(this.config.messages.selectPlaceholder);
        window.gConstraintFormID = 'form';
        //PATCH. [SMCD-494] Chech every x time if the value of 'gConstraintFormID' is correct
        [500, 1000, 2500, 5000, 10000].forEach(function (time) {
            setTimeout(function () {
                window.gConstraintFormID = 'form';
            }, time);
        });

        this.$configurationAreaSelects.each(function () {
            var maxElements = $("#" + this.id + " option").length;
            $(this).val("");
            $(this).attr("data-results", maxElements);
        });

        //Featured Options
        $selects.each(function (i, select) {
            var $select = $(select);
            var $emptyOption = $('option:first', $select);
            var $featuredOptions = $('option.is-preferred', $select);
            var featuredOptionsExists = $featuredOptions && $featuredOptions.length;
            if (featuredOptionsExists) {
                var featuredOptionsGroup = document.createElement('optgroup');
                featuredOptionsGroup.setAttribute('label', _self.config.messages.featuredOptions);
                var $featuredOptionsGroup = $(featuredOptionsGroup);
                $featuredOptionsGroup.append($featuredOptions);
                $featuredOptionsGroup.prependTo($select);
                $emptyOption.prependTo($select);
            }
        });

        //Initialize Rodend
        try {
            this.config.etech.Init();
        } catch (error) {
            console.error("[initializeEtech] error on this.config.etech.Init()", error);
        }

        /******/
        /** Select2 DropdownPosition */
        var Defaults = $.fn.select2.amd.require('select2/defaults');

        $.extend(Defaults.defaults, {
            dropdownPosition: 'auto'
        });

        var AttachBody = $.fn.select2.amd.require('select2/dropdown/attachBody');

        var _positionDropdown = AttachBody.prototype._positionDropdown;

        AttachBody.prototype._positionDropdown = function () {

            var $window = $(window);

            var isCurrentlyAbove = this.$dropdown.hasClass('select2-dropdown--above');
            var isCurrentlyBelow = this.$dropdown.hasClass('select2-dropdown--below');

            var newDirection = null;

            var offset = this.$container.offset();

            offset.bottom = offset.top + this.$container.outerHeight(false);

            var container = {
                height: this.$container.outerHeight(false)
            };

            container.top = offset.top;
            container.bottom = offset.top + container.height;

            var dropdown = {
                height: this.$dropdown.outerHeight(false)
            };

            var viewport = {
                top: $window.scrollTop(),
                bottom: $window.scrollTop() + $window.height()
            };

            var enoughRoomAbove = viewport.top < (offset.top - dropdown.height);
            var enoughRoomBelow = viewport.bottom > (offset.bottom + dropdown.height);

            var css = {
                left: offset.left,
                top: container.bottom
            };

            // Determine what the parent element is to use for calciulating the offset
            var $offsetParent = this.$dropdownParent;

            // For statically positoned elements, we need to get the element
            // that is determining the offset
            if ($offsetParent.css('position') === 'static') {
                $offsetParent = $offsetParent.offsetParent();
            }

            var parentOffset = $offsetParent.offset();

            css.top -= parentOffset.top
            css.left -= parentOffset.left;

            var dropdownPositionOption = this.options.get('dropdownPosition');

            if (dropdownPositionOption === 'above' || dropdownPositionOption === 'below') {
                newDirection = dropdownPositionOption;
            } else {

                if (!isCurrentlyAbove && !isCurrentlyBelow) {
                    newDirection = 'below';
                }

                if (!enoughRoomBelow && enoughRoomAbove && !isCurrentlyAbove) {
                    newDirection = 'above';
                } else if (!enoughRoomAbove && enoughRoomBelow && isCurrentlyAbove) {
                    newDirection = 'below';
                }

            }

            if (newDirection == 'above' ||
                (isCurrentlyAbove && newDirection !== 'below')) {
                css.top = container.top - parentOffset.top - dropdown.height;
            }

            if (newDirection != null) {
                this.$dropdown
                    .removeClass('select2-dropdown--below select2-dropdown--above')
                    .addClass('select2-dropdown--' + newDirection);
                this.$container
                    .removeClass('select2-container--below select2-container--above')
                    .addClass('select2-container--' + newDirection);
            }

            this.$dropdownContainer.css(css);

        };

        /** /Select2 DropdownPosition */

        $selects.select2({
            dropdownCssClass: 'smc-select',
            minimumResultsForSearch: 5,
            templateResult: formatSelect2Options,
            templateSelection: formatSelect2Options,
            dropdownPosition: 'below'
        });
        setTimeout(function () {
                $selects.each(function (i, select) {
                    var $select = $(this);
                    if (!$(this).hasClass("select2-hidden-accessible")) {
                        $select.select2({
                            dropdownCssClass: 'smc-select',
                            minimumResultsForSearch: 4,
                            templateResult: formatSelect2Options,
                            templateSelection: formatSelect2Options,
                            dropdownPosition: 'below'
                        });
                    }
                });
            }
            , 1000);
        $('.select2-container', this.$configurationArea).width('100%');
        //Proxy constraintuisupport.js 'getFormObject' function
        var etechGetFormObject = window.getFormObject;
        window.getFormObject = function () {
            window.gConstraintFormID = 'form';
            return etechGetFormObject.apply(this, arguments);
        };
        //End Proxy

        var rodEndConfigExists = !!$('.builder').length;
        if (rodEndConfigExists) {
            var etechSetDomainValue = window.setDomainValue;
            window.setDomainValue = function (formElementId, formElement) {
                etechSetDomainValue.apply(this, arguments);
                //Timeout to wait for Etech libra-***ries to update
                _refreshSelect2Status($(formElement).data('select2'), formElement.style.color);
            };
            //End Proxy
        }
    }

    function initializeEvents() {
        console.log("[Product-selection] initializeEvents init");
        var _self = this;
        this.$configuratorContainer.on('change', '.smc-select select', _self.makeSearch.bind(this));

        // Select2 hacking to Notify the change to the rest of Select2
        var $configurationAreaSelects = this.$configurationAreaSelects;
        $configurationAreaSelects.on('select2:select', function (event) {
            console.debug('[Product-selection]', 'initializeEvents', 'TRIGGER change:select');
            $configurationAreaSelects.trigger('change.select2');
        });
        var productId = getUrlParameter("productId");
        if (productId !== undefined && productId !== "") {
            var partNumber = getUrlParameter("partNumber");
            if (partNumber === undefined) {
                partNumber = "";
            }
            var filterValues = getFilterValues();
            var data = {
                selectedProductId: productId,
                selectedPartNumber: partNumber,
                selectedFilters: filterValues
            };
            var event = new CustomEvent('product.selection.productId.found', {detail: data});
            window.parent.document.dispatchEvent(event);
        }

        window.document.addEventListener('product.selection.communication.resetFilters', function (e) {
            console.log("[Product Selection] [iFrame] message received --> reset filters");
            restartSelects();
            _self.lastProductIdFound = "";
        });

        window.document.addEventListener('product.selection.communication.configUpdated', function (e) {
            console.log("[Product Selection] [iFrame] message received --> updateFiltersWithConfiguration", e);
            var elements = e.detail.selectedComponents;
            _self.updateFiltersWithConfiguration(elements);
        });

        window.document.addEventListener('product.selection.communication.askForFilters', function (e) {
            console.log("[Product Selection] [iFrame] message received --> updateFiltersWithConfiguration", e);
            _self.sendFilterValuesToConfigurator();
        });


        function spbHeight(plus) {
            return $('#searchParamsBox').height() + plus;
        }

        var spbHeightPlus = 45;
        var $iframeParent = window.parent.document.getElementById('product-selection-iframe-container');
        if ($iframeParent !== undefined && $iframeParent !== null) {
            $iframeParent.style.height = spbHeight(spbHeightPlus) + 'px';

            $(window).on('resize', function () {
                console.log('SPB height:', $('#searchParamsBox').height(), spbHeight(spbHeightPlus));
                if ($('body > .select2-container--open').length < 1) {
                    $iframeParent.style.height = spbHeight(spbHeightPlus) + 'px';
                }
            });

            $('#searchParamsBox').on('select2:open', '.select2-hidden-accessible', function () {
                var currentIframeParentHeight = $iframeParent.offsetHeight;
                if (currentIframeParentHeight !== spbHeight(spbHeightPlus)) {
                    $iframeParent.style.height = spbHeight(spbHeightPlus) + 'px';
                }
                var numResults = $(this).find('option').length;
                var resultsHeight = numResults * 32;
                var resultsTopPosition = $(this).next('.select2').offset().top + $(this).next('.select2').height();
                var newParentHeight = resultsTopPosition + resultsHeight + 40;
                $iframeParent.style.height = newParentHeight + 'px';
                if (newParentHeight > spbHeight(spbHeightPlus)) {
                    $iframeParent.style.height = newParentHeight + 'px';
                } else {
                    $iframeParent.style.height = spbHeight(spbHeightPlus) + 'px';
                }
            }).on('select2:close', '.select2-hidden-accessible', function () {
                if ($('body > .select2-container--open').length < 1) {
                    $iframeParent.style.height = spbHeight(spbHeightPlus) + 'px';
                }
            });
        }

        _self.getConfigFromUrl();
        $("#searchParamsBox #configuration_area .optionLabel").removeAttr("nowrap");
    }

    function updateFiltersWithConfiguration(configuredElements) {
        console.log("[Product-selection] updateFiltersWithConfiguration", configuredElements);
        var config = {};
        this.reloadingFilterValues = true;
        if (configuredElements !== undefined) {
            for (var filterIndex in configuredElements) {
                var currentFilter = configuredElements[filterIndex];
                if (currentFilter.code !== undefined) {
                    config[currentFilter.code] = currentFilter.value;
                }
            }
            if (configuredElements !== undefined) {
                updateEtechConfigurator(config);
            }
        }
        this.reloadingFilterValues = false;
        if (this.firstLoad) {
            //this is to avoid initialization error due to load URL with productSelection and productId
            //in this case, the load of the configurator comes before the load of the PS
            this.sendFilterValuesToConfigurator();
            this.firstLoad = false;
        }

    }


    function _refreshSelect2Status($select2, color) {
        if ($select2 && $select2.$container && $select2.$container[0]) {
            $select2.$container[0].getElementsByClassName('select2-selection__rendered')[0].style.color = color;
            $select2.$container[0].getElementsByClassName('select2-selection')[0].style['border-color'] = color;
        }
    }

    //Featured Options
    function formatSelect2Options(option, htmlElement) {
        var isSelecting = htmlElement && htmlElement.length;

        if (!option.id) {
            return option.text;
        }

        var isFeaturedOption = option.element.className.indexOf('is-preferred') > -1;
        return $('<div>', {
            id: option.id,
            css: {
                color: option.element.style.color
            },
            class: option.element.classList,
            html: isFeaturedOption && !isSelecting ? '<span><i class="image-star"></i> ' + option.text + '</span>' : option.text
        });
    }

    function getFilterValues() {
        console.log("[Product-selection] getFilterValues init");
        var selectedFilterList = [];
        var elementValues = getEtechConfigValues();
        for (var currentDomain in window.oDomains.domains) {
            var currentElement = window.oDomains.domains[currentDomain];
            var currentElementCode = currentElement.code;
            if (elementValues[currentDomain] !== undefined && elementValues[currentDomain] !== "&middot;") {
                var element = {code: currentElementCode, value: elementValues[currentDomain]};
                selectedFilterList.push(element);
            }
        }
        return selectedFilterList;
    }

    function getFilterElements() {
        console.log("[Product-selection] getFilterElements init");
        var selectedFilterList = [];
        var elementValues = getEtechConfigValues();
        for (var currentDomain in window.oDomains.domains) {
            var currentElement = window.oDomains.domains[currentDomain];
            var currentElementCode = currentElement.code;
            var currentElementValue = elementValues[currentDomain];
            if (currentElementValue !== undefined && currentElementValue !== "&middot;") {
                var element = {value: currentElementValue, id: currentDomain};
                selectedFilterList.push(element);
            }
        }
        return selectedFilterList;
    }

    function makeSearch() {
        console.log("[Product-selection] makeSearch init");
        var _self = this;
        _self.areAllSelectsWithValue();
        if (!this.reloadingFilterValues) {
            disableEveryFilter();
            var productId = _self.config.productId;
            var partNumber = $('#cpn_partnumber').text();
            var productSelectionId = _self.config.productSelectionId;
            var seriesProductId = _self.config.seriesProductId;
            var filterValues = getFilterValues();
            addSearchingSpinner("searchParamsBox");
            // var url = document.getElementById('searchSelectionLink').href;
            var url = new URL(document.getElementById('searchSelectionLink').href);
            url.searchParams.delete("productId");
            url.searchParams.delete("productSelectionId");
            url.searchParams.set("productId", productId);
            url.searchParams.set("partNumber", partNumber);
            url.searchParams.set("seriesProductId", seriesProductId);
            url.searchParams.set("productSelectionId", productSelectionId);
            // _self.updateURLParams();
            $.get(url)
                .then(function (response) {
                    //if there is a selectedProductId, we must notify the main window and load its configurator
                    if (response !== "" && response.selectedProductId !== undefined) {
                        var result = response;
                        //Then there is a selectedProductId, we must notify it to communications controller
                        console.log("[Product selection] search response, productIdFound", result.selectedProductId);
                        if (_self.lastProductIdFound !== result.selectedProductId) {
                            _self.lastProductIdFound = result.selectedProductId;
                            var data = {
                                productId: result.selectedProductId,
                                selectedPartNumber: result.selectedPartNumber,
                                selectedFilters: filterValues,
                            };
                            console.log("[Product Selection] [iFrame] message sent --> productSelection found", data);
                            var event = new CustomEvent('product.selection.productId.found', {detail: data});
                            window.parent.document.dispatchEvent(event);
                        }
                    } else if (response !== "") {
                        console.log("[Product selection] search response", response);
                        //there is more than one result, so we have to clear the configurator
                        _self.lastProductIdFound = "";
                        var data = {
                            response: response,
                            areAllSelectsWithValue: _self.areAllSelectsWithValue()
                        };
                        console.log("[Product Selection] [iFrame] message sent --> multiple productSelection found", response);
                        var event = new CustomEvent('product.selection.multiple.productId.found', {detail: data});
                        window.parent.document.dispatchEvent(event);
                    }
                })
                .catch(function (error) {
                    console.debug("[Product-selection] makeSearch" + error);
                }).always(function () {
                emptySearchingSpinner("searchParamsBox");
                enableEveryFilter();
                _self.sendFilterValuesToConfigurator();
            }.bind(this));
        }
    }

    function sendFilterValuesToConfigurator() {
        var filterValues = getFilterValues();
        if (filterValues === undefined) {
            return;
        }
        var data = {
            filterValues: filterValues
        };
        var event = new CustomEvent('product.selection.filters.updated', {detail: data});
        window.parent.document.dispatchEvent(event);
        console.log("[Product Selection] [iFrame] message sent --> updateFiltersInConfigurator", filterValues);
    }

    function addSearchingSpinner(containerId) {
        if ($("#" + containerId + " .pc__loading_spinner").is(":empty")) {
            $("#" + containerId + " .pc__loading_spinner").append(getSearchingSpinner());
        }
    }

    function getSearchingSpinner() {
        return document.getElementById('spinner-template').innerHTML;
    }

    function emptySearchingSpinner(containerId) {
        $("#" + containerId + " .pc__loading_spinner").empty();
    }

    function disableEveryFilter() {
        $(".select2-series").prop('disabled', true);
        $(".select2-series").addClass("noactive");
        $("#searchParamsBox .select2-selection").addClass("noactive");
        $("#searchParamsBox .select2-selection__rendered").addClass("noactive_text");
        if ($(".psearch-searching-container")) {
            $(".psearch-searching-container").show();
        }
    }

    function enableEveryFilter() {
        $(".select2-series").removeAttr("disabled");
        $(".select2-series").removeClass("noactive");
        $("#searchParamsBox .select2-selection").removeClass("noactive");
        $("#searchParamsBox .select2-selection__rendered").removeClass("noactive_text");
        if ($(".psearch-searching-container")) {
            $(".psearch-searching-container").hide();
        }
    }

    function getUrlParameter(sParam) {
        var sPageURL = window.location.search.substring(1),
            sURLVariables = sPageURL.split('&'),
            sParameterName,
            i;
        for (i = 0; i < sURLVariables.length; i++) {
            sParameterName = sURLVariables[i].substring(0, sURLVariables[i].indexOf("="));
            if (sParameterName === sParam) {
                return sURLVariables[i].replace(sParam + "=", "");
            }
        }
    }

    function restartSelects(currentSelect) {
        try {

            $("#smc-psearch .configurationRow .optionValue select").each(function () {
                // if (currentSelect === undefined){
                //no filter has changed, the user has pressed the RESET button
                $(this).val("");
                // }
                if (this !== undefined && this !== currentSelect) {
                    $(this).select2({
                        dropdownCssClass: 'smc-select',
                        minimumResultsForSearch: 5,
                        templateResult: formatSelect2Options,
                        templateSelection: formatSelect2Options,
                        dropdownPosition: 'below'
                    });
                }
                $(this).trigger('change.select2');
            });
        } catch (e) {
            console.error("[RESTART SELECTS]", e);
        }
    }

    // function updateURLParams(){
    //     var selectedFilters = getFilterValues();
    //     if (selectedFilters.length  > 0){
    //         var url = new URL(window.location.href);
    //         // url.searchParams.delete("selectedFilters");
    //         // url.searchParams.set("selectedFilters",encodeURIComponent(JSON.stringify(selectedFilters)));
    //         for (var filter in selectedFilters){
    //             var currElement = selectedFilters[filter];
    //             if (currElement.code !== undefined){
    //                 url.searchParams.delete("PSF_" +currElement.code);
    //                 url.searchParams.set("PSF_" + currElement.code, currElement.value);
    //             }
    //         }
    //         window.history.pushState({}, window.document.title, url.toString());
    //     }
    // }

    function getConfigFromUrl() {
        console.log("[Product Selection] getConfigFromUrl");
        var query = window.location.search.substring(1);
        var params = parse_query_string(query);
        var config = {};
        for (var p in params) {
            if (p.startsWith("PSF_")) {
                var key = p.substring(4);
                var value = params[p].split("+").join(" ");
                config[key] = value;
            }
        }
        updateEtechConfigurator(config);
    }

    function parse_query_string(query) {
        var vars = query.split("&");
        var query_string = {};
        for (var i = 0; i < vars.length; i++) {
            var pair = vars[i].split("=");
            var key = decodeURIComponent(pair[0]);
            var value = decodeURIComponent(pair[1]);
            // If first entry with this name
            if (typeof query_string[key] === "undefined") {
                query_string[key] = decodeURIComponent(value);
                // If second entry with this name
            } else if (typeof query_string[key] === "string") {
                var arr = [query_string[key], decodeURIComponent(value)];
                query_string[key] = arr;
                // If third or later entry with this name
            } else {
                query_string[key].push(decodeURIComponent(value));
            }
        }
        return query_string;
    }

    function areAllSelectsWithValue() {
        var allSelected = true;
        this.$configurationAreaSelects.each(function () {
            if ($(this).find(":selected").val() === "") {
                allSelected = false;
                //if default option is selected make sure that no check or error option are visible for this select
                var optionStatusContainer = $(this).parent().next();
                $(optionStatusContainer).find("span").hide();
            }
        });
        return allSelected;
    }

    window.smc.ProductSelection = ProductSelection;
})(window);
