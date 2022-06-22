(function (globalConfig) {
    function StandardStockedItems(config) {
        this.selectedPartNumbers = [];
        this.id = config.id;
        this.productId = config.productId;
        this.config = config;
        this.pageNumber = config.pageNumber;
        this.pageSize = config.pageSize;
        this.isFunctionality = config.isFunctionality || false;
        this.isEtools = config.isEtools || false;

        //An Array per page size
        this.data = {
            10: [],
            20: [],
            50: [],
            100: []
        };
    }

    StandardStockedItems.prototype.init = init;
    StandardStockedItems.prototype.initializeFilter = initializeFilter;
    StandardStockedItems.prototype.initSsi = initSsi;
    StandardStockedItems.prototype.initLoading = initLoading;
    StandardStockedItems.prototype.endLoading = endLoading;
    StandardStockedItems.prototype.triggerPartNumberChangedEvent = triggerPartNumberChangedEvent;
    StandardStockedItems.prototype.getSelectedPartNumbers = getSelectedPartNumbers;
    StandardStockedItems.prototype.updateStatus = updateStatus;

    function init() {
        console.debug('[StandardStockedItems]', 'init id=', this.id);
        this.links = {
            showCompareProduct: $('.compare-product-button', this.config.container),
            // showSsi: $('.ssi-load', this.config.container)
            showSsi: $('.ssi-load')
        };
        this.templates = {
            spinnerTemplateHTML: document.getElementById('spinner-template').innerHTML
        };

        this.allSsiPartNumbers = null;
        this.allFilterVisible = false;
        this.resetFilter = false;
        this.ssiComparePartNumbers = [];
        this.$ssiFilter = $('#ssi-filter');
        this.$ssiContainer = $('#ssi-container');
        this.$ssiProductContent = $('#ssi-content');
        this.$ssiFiltersContainer = $('#ssi-filters-container');
        this.$ssiPaginationContainer = $('.pagination-container-js');
        this.$partNumberFilter = $('#partNumberFilter');
        this.$buttonfilterVisibility = $('.ssi-filter-btn-show-js');
        this.$buttonCleanSelection = $('.ssi-filter-btn-all-js');
        this.$buttonCompareProducts = $('.compare-product-button');
        this.$compareNumber = $('.compare-number-js');
        this.initializeFilter();
        this.initSsi();
    }


    function initializeFilter() {
        var _self = this;
        if (!_self.isFunctionality && !_self.isEtools) {
            //generate ssi filter
            _self.$ssiFilter.html(getSSIFilter(false));

            initSelects(_self);
            initInputs(_self);

            //initialize show more filter button
            _self.$buttonfilterVisibility.click(manageFilterVisibility.bind(_self));

            //initialize events
            $('.search-option-js').change(ssiUpdateFilterPartNumber.bind(_self));

            //initialize input text search

            // _self.$partNumberFilter.change(ssiSearch.bind(_self));

            _self.$buttonCleanSelection.click(resetSsiFilters.bind(_self));
            disableSearchInvalidOptions();
        } else if (_self.isFunctionality) {
            $('#reset-btn').on('click', functionalityResetAll.bind(_self));
            $("#container_additionalParameters select").change($.debounce(200, function (event) {
                _self.pageNumber = 1;
                manageGetSsiProducts.call(_self)
                    .then(function (data) {
                        var $paginateContainer = _self.paginationElementsConfig.$paginationContainer;
                        var paginateJs = $paginateContainer.data('pagination');
                        _callbackPaginationJs.call(_self, _self.paginationElementsConfig, data, paginateJs.model, paginateJs);
                    });
            }));
        } else {

        }


        $(document).on('smc.partNumber.changed', function (e) {
            if (partNumberToCompare) {
                $('#compare_hto_wrapper').hide();

                var index = _self.ssiComparePartNumbers.indexOf(partNumberToCompare);
                if (index > -1) {
                    _self.ssiComparePartNumbers.splice(index, 1);
                }

                partNumberToCompare = '';

                _self.updateStatus();
            }
        });

        $(document).on('smc.partNumber.compare', function (e) {
            _self.updateStatus();
        });

        $(document).on('click', '#compareCopyToClipBoard_btn', function (e) {
            $(document).trigger('smc.partNumber.copyToClipboard');
        });

        $(document).on('smc.standardStockedItems.allSelected', function (e) {
            $("#ssi-content .ssi-item-partnumber[type='checkbox']").each(function () {
                if ($(this).prop("checked") || $(this).prop("checked") === "true") {
                    var partNumberAux = $(this).val();
                    if (!_self.ssiComparePartNumbers.includes(partNumberAux)) {
                        _self.ssiComparePartNumbers.push($(this).val());
                    }
                }
            });
            _self.updateStatus();
        });

        $(document).on('smc.standardStockedItems.unselectAll', function (e) {
            _self.ssiComparePartNumbers = [];
            _self.updateStatus();
        });
    }

    function initSsi() {
        var _self = this;

        //checkbox to basket
        this.config.container.on('change', '.ssi-item-partnumber', onSsiSelected.bind(this));

        $(document).on('click', '.' + _self.config.ssiCheckboxClass, function () {
            updateCompareProductsData.call(this, _self);
        });

        this.$buttonCompareProducts.click(loadCompareProductData.bind(_self));

        if (this.config.isEtechEnabled) {
            this.$compareNumber.removeAttr('disabled');
        }

        this.paginationElementsConfig = {
            $paginationContainer: this.$ssiPaginationContainer,
            $resultContainer: this.$ssiProductContent,
            $initialPageNumberContainer: $('.js-search-init-page-number', this.config.container),
            $finishPageNumberContainer: $('.js-search-finish-page-number', this.config.container),
            $totalResultsContainer: $('.js-search-total', this.config.container)
        };

        this._pageNumber = this.config.pageNumber;
        Object.defineProperty(this, 'pageNumber', {
            get: function () {
                return this._pageNumber;
            }.bind(this),
            set: function (pageNumber) {
                this._pageNumber = pageNumber;

                var $paginateContainer = this.paginationElementsConfig.$paginationContainer;
                var paginateJs = $paginateContainer.data('pagination');
                if (paginateJs) {
                    paginateJs.model.pageNumber = pageNumber;
                    paginateJs.attributes.pageNumber = pageNumber;
                }
            }.bind(this)
        });

        this._pageSize = this.config.pageSize;
        Object.defineProperty(this, 'pageSize', {
            get: function () {
                return this._pageSize;
            }.bind(this),
            set: function (pageSize) {
                this._pageSize = pageSize;

                var $paginateContainer = this.paginationElementsConfig.$paginationContainer;
                var paginateJs = $paginateContainer.data('pagination');
                if (paginateJs) {
                    paginateJs.model.pageSize = pageSize;
                    paginateJs.attributes.pageSize = pageSize;
                }
            }.bind(this)
        });

        activatePagination.call(this);
    }

    function loadCompareProductData(event) {
        if (event) event.preventDefault();

        var _self = this;
        console.debug('[StandardStockedItems]', 'loadCompareProductData partNumbers=', this.ssiComparePartNumbers);

        if (this.ssiComparePartNumbers.length < 2) return;

        var data = {
            componentId: this.id,
            categoryId: this.config.categoryId,
            productId: this.config.productId,
            language: this.config.defaultLanguage || 'en',
            partNumbers: this.ssiComparePartNumbers.toString()
        };
        this.initLoading(_self.links.showCompareProduct);

        $.get(globalConfig.ssi.urls.showCompareProduct, data)
            .then(function (response) {
                _self.endLoading(_self.links.showCompareProduct);
                var $compareTabJs = $('.compare-tab-js');
                $compareTabJs.html(response);
                $compareTabJs.removeClass('hidden');
                $('#' + _self.config.id + '_compareProductModal').modal('show');
            })
            .catch(function () {
                _self.endLoading(_self.links.showCompareProduct);
            });
    }

    function updateStatus() {
        _updateButtonStatus.call(this);
        $(document).trigger('smc.standardStockedItems.statusChanged');
    }

    function _updateButtonStatus() {
        if (partNumberToCompare && !this.ssiComparePartNumbers.includes(partNumberToCompare)) {
            this.ssiComparePartNumbers.unshift(partNumberToCompare);
        }

        var size = this.ssiComparePartNumbers.length;

        if (this.config.isEtechEnabled && size > 0) {
            this.$compareNumber.removeClass('hidden');
        } else {
            this.$compareNumber.addClass('hidden');
        }

        this.$compareNumber.html(size);

        if (this.config.isEtechEnabled && size > 1 && size < 4) {
            this.$buttonCompareProducts.removeClass('disabled');
            this.$buttonCompareProducts.prop("disabled", false);
        } else {
            this.$buttonCompareProducts.addClass('disabled');
            this.$buttonCompareProducts.prop("disabled", true);
        }
    }

    function updateCompareProductsData(_self) {
        var partNumber = $(this).val();

        if (!_self.ssiComparePartNumbers.includes(partNumber)) {
            _self.ssiComparePartNumbers.push($(this).val());
        } else {
            var index = _self.ssiComparePartNumbers.indexOf(partNumber);
            if (index > -1) {
                _self.ssiComparePartNumbers.splice(index, 1);
            }
        }

        _self.updateStatus();
    }

    function manageFilterVisibility(event) {
        var _self = this;
        event.preventDefault();

        if (_self.allFilterVisible) {
            this.$ssiFiltersContainer.removeClass('open');

        } else {
            this.$ssiFiltersContainer.addClass('open');
            initSelects(_self);
        }

        _self.allFilterVisible = !_self.allFilterVisible;
    }

    function initSelects(_self) {
        var $selects = _self.$ssiFilter.find('.select2-selection-js');
        $selects.select2({
            templateResult: formatSelect2Options
        });
    }

    function initInputs(_self) {
        var $filterInputs = _self.$ssiFilter.find("input:text.search-option");
        $filterInputs.each(function () {
            $(this).keypress(isNumberKey.bind(_self));
        });
    }

    function onPageSizeChanged(_self, event) {
        event.preventDefault();
        reloadDisplayData.call(this, _self);
        manageGetSsiProducts.call(_self)
            .then(function (data) {
                var $paginateContainer = _self.paginationElementsConfig.$paginationContainer;
                var paginateJs = $paginateContainer.data('pagination');
                _callbackPaginationJs.call(_self, _self.paginationElementsConfig, data, paginateJs.model, paginateJs);
            });
    }

    function reloadDisplayData(_self) {
        _self.pageNumber = 1;
        _self.pageSize = $(this).data('len');
        $(this).data('len');
        $(".changelen.active").removeClass('active');
        $(this).addClass("active");
    }

    function onSsiSelected(event) {
        var checkbox = event.target;

        if (checkbox.checked) {
            console.debug('[SsiProduct]', 'Add_Ssi_PartNumber', checkbox.value);
            this.selectedPartNumbers.push(checkbox.value);

            var addedEventId = ['smc.', this.config.id, '.addedPartNumber'];
            $(document).trigger(addedEventId.join(''), [checkbox.value]);

        } else {
            console.debug('[SsiProduct]', 'Remove_Ssi_PartNumber', checkbox.value);
            var index = this.selectedPartNumbers.indexOf(checkbox.value);
            if (index > -1) {
                this.selectedPartNumbers.splice(index, 1);
            }

            var removedEventId = ['smc.', this.config.id, '.removedPartNumber'];
            $(document).trigger(removedEventId.join(''), [checkbox.value]);
        }

        this.triggerPartNumberChangedEvent();
    }

    function getSelectedPartNumbers() {
        return this.selectedPartNumbers;
    }


    function triggerPartNumberChangedEvent() {
        var changedEventId = ['smc.', this.config.id, '.selectedPartNumberChanged'];
        $(document).trigger(changedEventId.join(''), [this.getSelectedPartNumbers()]);
    }

    //from standardStockedItems.js
    function getSSIFilter(encoded) {
        var count = 0;
        var searchHtml = "";
        var first = true;
        var done = false;
        var countFilters = 0;
        if (oDomains !== undefined) {
            oDomains.cpcarray.forEach(function (element) {

                if (element.domainFuncType == "OPTION" && element.label != "-") {
                    countFilters++;
                    var html = "";
                    if (!first && !done) {
                        html = html + "<div id='secondPartFilter' class=''>";
                        done = true;
                    }
                    if (count == 0) {
                        html = html + "<div class='row'>";
                    }


                    html = html + "<div class='col-lg-3 mb-2 mb-md-0 p-6 p-md-2'>";

                    if (element.dtype == "D_LIST") {
                        html = html + '<select id="search_' + element.did + '" class="form-control search-option search-option-js select2-selection select2-selection-js select2-selection--single">';
                        html = html + '<option value="no_selection">' + element.label + '</option>';
                        var members = element.members;
                        for (var key in members) {
                            var member = members[key];
                            html = html + '<option value="' + member.code + '">';
                            html = html + member.value;
                            html = html + '</option>';
                        }

                        html = html + '</select>';
                    }
                    if (element.dtype == "D_INTEGER_RANGE") {

                        var members = element.members;
                        var rangeMin;
                        var rangeMax;
                        var step = 1;

                        for (var key in members) {
                            var valueSplit = members[key].value.split("-");
                            step = Number(valueSplit[valueSplit.length - 1].replace("]", ""));
                            members[key].code.split("-").forEach(function (element) {
                                if (rangeMin == undefined || Number(element) < rangeMin) rangeMin = Number(element);
                                if (rangeMax == undefined || Number(element) > rangeMax) rangeMax = Number(element);
                            });
                        }

                        var rangeTip = "[" + rangeMin + " mm - " + rangeMax + " mm] by " + step;
                        html = html + '<input type="text"  id="search_' + element.did + '" class="form-control search-option search-option-js" placeholder="' + rangeTip + '"  maxlength="' + rangeMax.toString().length + '">';

                        console.log(rangeTip);

                    }
                    html = html + '</div>';

                    if (count !== 3) {
                        count++;
                    } else {
                        count = 0;

                        if (first) {
                            first = false;
                        }

                        html = html + '</div>';
                    }

                    searchHtml = searchHtml + html;
                }
            });
        }
        searchHtml = searchHtml + "</div></div>";

        manageVisibilityShowMoreFilters(countFilters);
        return searchHtml;
    }

    function manageVisibilityShowMoreFilters(numberOfFilters) {
        if (numberOfFilters <= 4) {
            $('.ssi-filter-btn-show-js').addClass('hidden');
        }
    }

    function formatSelect2Options(option, li) {
        if (!option.id) {
            return option.text;
        }

        return $('<div>', {
            id: option.id,
            css: {
                color: option.element.style.color
            },
            class: option.element.classList,
            text: option.text
        })
    }

    function ssiUpdateFilterPartNumber(event) {
        var _self = this;
        if (_self.resetFilter) return;
        setFilterValue(_self, getSearchPartNumber());
    }

    function initLoading($container) {
        if (!$container.hasClass("ssi-load")) {
            $container.addClass('disabled');
            $('.loading-container-ssi-js', $container)
                .addClass('loading-container');
        }
        $('.loading-container-ssi-js').show();
        $('.loading-container-ssi-js', $container)
            .html(this.templates.spinnerTemplateHTML);
    }

    function endLoading($container) {
        $container.removeClass('disabled');
        $('.loading-container-ssi-js', $container)
            .removeClass('loading-container')
            .html('');
    }

    function getSearchPartNumber() {
        var searchPartNumber = "";
        var optionalDash = false;
        oDomains.cpcarray.forEach(function (element, index) {
            var $element = $("#search_" + element.did);

            if (element.dtype === "D_CONSTANT") searchPartNumber = searchPartNumber + element.label;

            if (element.domainFuncType === "OPTION") {
                if (element.label === "-") {
                    optionalDash = true;

                    element = oDomains.cpcarray[index + 1];

                    if ($element in window) {
                        if ($element.val() !== "no_selection" && ($element[0].tagName === "SELECT" || $element.val() !== ""))
                            searchPartNumber = searchPartNumber + element.label;
                    }
                } else {
                    if ($element.val() !== "no_selection" && ($element[0].tagName === "SELECT" || $element.val() !== "")) {
                        searchPartNumber = searchPartNumber + ((optionalDash && $element.val()) ? "-" : "") + $element.val()
                    } else if (searchPartNumber.slice(-1) !== "*")
                        searchPartNumber = searchPartNumber + "*";

                    optionalDash = false;
                }
            }
        });
        return searchPartNumber;
    }


    function _afterInitPaginationJs(paginationContainer) {
        var _self = this;
        _self.$partNumberFilter.change($.debounce(200, function (event) {
            _self.pageNumber = 1;
            manageGetSsiProducts.call(_self)
                .then(function (data) {
                    var $paginateContainer = _self.paginationElementsConfig.$paginationContainer;
                    var paginateJs = $paginateContainer.data('pagination');
                    _callbackPaginationJs.call(_self, _self.paginationElementsConfig, data, paginateJs.model, paginateJs);
                });
        }));

        $(".changelen").each(function (index) {
            $(this).click(onPageSizeChanged.bind(this, _self));
        });
    }

    function functionalityResetAll() {
        console.debug("[functionalityResetAll]");
        let $selectpickers = $(".selectpicker");
        $('.selectpicker option').prop('disabled', false);
        $selectpickers.val('');
        $selectpickers.selectpicker("refresh");
        $('#partNumberFilter').val("");
        $selectpickers.trigger('change');
    }

    function setFunctionalityColumns(functionalityColumns) {
        console.debug("[setFunctionalityColumns]");
        if (functionalityColumns) {
            $('#navColumn0').text(functionalityColumns[0]);
            $('#navColumn1').text(functionalityColumns[1]);
        }
    }

    function functionalityDisableFilters(disabledFilters, removedFilters) {
        console.debug("[functionalityDisableFilters]");
        $('.selectpicker option').prop('disabled', false);
        if (removedFilters) {
            removedFilters.forEach(function (valueId) {
                $(".selectpicker option[value='" + valueId + "']").hide();
            });
        }
        if (disabledFilters) {
            disabledFilters.forEach(function (valueId) {
                $(".selectpicker option[value='" + valueId + "']").prop('disabled', true);
            });
        }
        $('.selectpicker').selectpicker('refresh');
    }

    function functionalityCheckRequiredFilters(requiredFilters) {
        console.debug("[functionalityCheckRequiredFilters]");
        $('.selectpicker + .dropdown-toggle').removeClass('required-filter');
        if (requiredFilters) {
            requiredFilters.forEach(function (filterId) {
                $(".selectpicker[data-filterid='" + filterId + "'] + .dropdown-toggle").addClass('required-filter');
            });
        }
    }

    function displayLoadSpinner(_self) {
        _self.config.component.addClass('loading');
        $('.loading-container-ssi-js', _self.links.showSsi)
            .addClass('loading');
        _self.initLoading(_self.links.showSsi);
    }

    function removeLoadSpinner(_self) {
        _self.endLoading(_self.links.showSsi);
        $('.loading-container-ssi-js', _self.links.showSsi)
            .removeClass('loading');
        _self.config.component.removeClass('loading');
    }

    function _paginateButtonActionPaginationJs(event) {
        var _self = this;
        var current = $(event.currentTarget);
        var pageNumber = $.trim(current.attr('data-num'));
        if (pageNumber) pageNumber = parseInt(pageNumber, 10);

        if (this.pageNumber === pageNumber) return;
        this.pageNumber = pageNumber;
        manageGetSsiProducts.call(_self)
            .then(function (data) {
                var $paginateContainer = _self.paginationElementsConfig.$paginationContainer;
                var paginateJs = $paginateContainer.data('pagination');
                _callbackPaginationJs.call(_self, _self.paginationElementsConfig, data, paginateJs.model, paginateJs);
            });
    }

    function _beforePagingPaginationJs(page) {
        this.selectedPartNumbers = [];
        this.triggerPartNumberChangedEvent();
    }

    //from standardStockedItems.js
    function disableSearchInvalidOptions() {
        if (!this.allSsiPartNumbers) {
            //Load all ssi partnumbers
            this.allSsiPartNumbers = window.smc.ssiAllPartNumbers || [];
        }

        if (this.allSsiPartNumbers) {
            disabledAllOptions();
            this.allSsiPartNumbers.forEach(function (part_number) {

                var tempPartNumber = part_number.part_number;
                oDomains.cpcarray.forEach(function (element, index) {

                    if (tempPartNumber !== "") {
                        if (element.dtype === "D_CONSTANT") {
                            if (tempPartNumber.indexOf(element.label) === 0) {
                                tempPartNumber = tempPartNumber.replace(element.label, "");
                            }
                        }

                        if (element.domainFuncType === "OPTION") {
                            if (element.label === "-") {
                                if (tempPartNumber.indexOf(element.label) === 0) tempPartNumber = tempPartNumber.replace(element.label, "");
                            } else {
                                if (element.dtype === "D_LIST") {
                                    var members = element.members;
                                    var lastMemberValue = "";
                                    for (var key in members) {
                                        var member = members[key];

                                        //console.log("Checking code: " + member.code);
                                        if (tempPartNumber.indexOf(member.code) === 0) {
                                            if (lastMemberValue === "" || member.code !== "") {
                                                lastMemberValue = member.code;
                                            }
                                        }
                                    }
                                    if (lastMemberValue !== "") {
                                        enableOption(element.did, lastMemberValue);
                                        if (oDomains.cpcarray.length > index + 1 && oDomains.cpcarray[index + 1].dtype === "D_LIST") {
                                            // Es posible que un partnumber tenga dos D_LIST seguidos opcionales y que el primero enmascare al segundo
                                            // Si el siguiente list contiene el elemento que se va a eliminar, y encima no hay dos elementos iguales seguidos en tempPartNumber, se mantiene el elemento
                                            if (tempPartNumber.replace(lastMemberValue, "").indexOf(lastMemberValue) === 0) {
                                                tempPartNumber = tempPartNumber.replace(lastMemberValue, "");
                                            } else {
                                                var nextListContainsValue = false;
                                                var nextMembers = oDomains.cpcarray[index + 1].members;
                                                for (var nextMembersKey in nextMembers) {
                                                    var nextMember = nextMembers[nextMembersKey];
                                                    if (nextMember.code !== "" && tempPartNumber.indexOf(nextMember.code) === 0) nextListContainsValue = true;
                                                }
                                                if (!nextListContainsValue) {
                                                    tempPartNumber = tempPartNumber.replace(lastMemberValue, "");
                                                } else {
                                                    // Se mantiene tempPartNumber para el siguiente valor de lista
                                                    // Escenarios: AA- o A- // DD100- DB100-
                                                    var tempPartNumberAux = tempPartNumber.replace(lastMemberValue, "");
                                                    if (tempPartNumberAux.indexOf("-") !== 0) {
                                                        tempPartNumber = tempPartNumber.replace(lastMemberValue, "");
                                                    }
                                                }
                                            }
                                        } else {
                                            tempPartNumber = tempPartNumber.replace(lastMemberValue, "");
                                        }
                                    }
                                }
                                if (element.dtype === "D_INTEGER_RANGE") {
                                    // No es un select por lo que se elimina del part number. se comprueban los caracteres uno a uno para ver cuando deja de ser un número
                                    String.prototype.isNumber = function () {
                                        return /^\d+$/.test(this);
                                    };
                                    var i = 0;
                                    do {
                                        i++;
                                        var subPartNumber = tempPartNumber.substring(0, i);
                                    }
                                    while (subPartNumber.isNumber() && tempPartNumber.length > i - 1);
                                    tempPartNumber = tempPartNumber.replace(tempPartNumber.substring(0, i - 1), "");
                                }
                            }
                        }
                    }
                });

            });
        }
    }

    function enableOption(id, value) {
        $("#search_" + id + " option[value='" + value + "']").attr("disabled", false);
    }

    function activatePagination() {
        var _self = this;
        var paginationElementsConfig = this.paginationElementsConfig;
        var paginationJSConfig = {
            dataSource: function (done) {
                manageGetSsiProducts.call(_self)
                    .then(done)
                    .catch(function () {
                        console.warn('[StandardStockedItems]', 'Error fetching, Using old data');
                        done(_self.data[_self.pageSize]);
                    });
            },
            className: 'row justify-content-center',
            prevText: '<i class="icon-arrow-single-left" style="font-size: 14px;"></i>',
            nextText: '<i class="icon-arrow-single-right" style="font-size: 14px;"></i>',
            firstText: '<i class="icon-arrow-double-left"></i>',
            lastText: '<i class="icon-arrow-double-right"></i>',
            pageRange: 2,
            pageNumber: this.pageNumber || 1,
            pageSize: this.pageSize || 10,
            callback: _callbackPaginationJs.bind(this, paginationElementsConfig)
        };
        paginationElementsConfig.$paginationContainer.pagination(paginationJSConfig);
        paginationElementsConfig.$paginationContainer.addHook('afterInit', _afterInitPaginationJs.bind(this));
        paginationElementsConfig.$paginationContainer.addHook('beforePageOnClick', _paginateButtonActionPaginationJs.bind(this));
        paginationElementsConfig.$paginationContainer.addHook('beforePreviousOnClick', _paginateButtonActionPaginationJs.bind(this));
        paginationElementsConfig.$paginationContainer.addHook('beforeNextOnClick', _paginateButtonActionPaginationJs.bind(this));
        paginationElementsConfig.$paginationContainer.addHook('beforePaging', _beforePagingPaginationJs.bind(this));
    }


    function _callbackPaginationJs(paginationElementsConfig, data, pagination, paginateJs) {
        var _self = this;

        var pageStartIndex = this.pageSize * (this.pageNumber - 1);
        var html = data[pageStartIndex];

        if (html) {
            paginationElementsConfig.$resultContainer.html(html);
        } else {
            //No data available but show page 0 content if any
            html = data[0];

            if (html) {
                paginationElementsConfig.$resultContainer.html(html);
            } else {
                paginationElementsConfig.$resultContainer.empty();
            }
        }

        //reset compare buttons
        _self.ssiComparePartNumbers = [];
        this.updateStatus();

        var initPageIndex = _self.pageSize * (pagination.pageNumber - 1);
        var initNumber = initPageIndex + 1;
        var elements = parseInt($('#numElements').val(), 10);
        var lastRegisterNumber = elements < pagination.pageSize ? (initPageIndex + elements) : initPageIndex + pagination.pageSize;

        var numTotalElements = parseInt($('#numTotalElements').val(), 10);
        numTotalElements = isNaN(numTotalElements) ? 0 : numTotalElements;
        if (numTotalElements === 0) {
            initNumber = 0;
            _self.$ssiContainer.addClass('empty-results');
        } else {
            _self.$ssiContainer.removeClass('empty-results');
        }

        paginationElementsConfig.$initialPageNumberContainer.text(initNumber);
        paginationElementsConfig.$finishPageNumberContainer.text(lastRegisterNumber);
        paginationElementsConfig.$totalResultsContainer.text(_self.config ? _self.config.paginateResults : pagination.totalNumber);

        if (paginateJs) {
            paginateJs.refreshPagination();
        }
    }

    function getSsiProducts() {
        var _self = this;
        let data;
        let url;
        this.$ssiContainer.removeClass('empty-results');
        if (_self.isFunctionality) {
            console.debug("[FunctionalitySearch - getSsiProducts]");
            url = new URL(document.getElementById('functionalitySearchLink').href);
            let partialPartNumber = this.$partNumberFilter.val();
            let selectedValues = {};
            $("#container_additionalParameters select").each(function () {
                if ($(this).attr("data-filterId") && $(this).val() && $(this).val() !== "0") {
                    console.log($(this).attr("data-filterId") + '-' + $(this).val());
                    selectedValues[$(this).attr("data-filterId")] = $(this).val()
                }
            });
            data = {
                selectedValues: selectedValues,
                categoryId: this.config.categoryId,
                language: this.config.defaultLanguage || 'en',
                partNumber: partialPartNumber,
                page: this.pageNumber,
                size: this.pageSize
            };
            let currentUrl = new URL(window.location.href);
            let urlSearchData = currentUrl.searchParams.get("searchData");
            _self.isFunctionalityFirstLoad = !urlSearchData;
            let encodedSearchData = base64EncodeUrl(btoa(JSON.stringify(data)));
            currentUrl.searchParams.set("searchData", encodedSearchData);

            window.history.replaceState({}, window.document.title, currentUrl.toString());
            url.searchParams.delete('nodes');
            url.searchParams.delete('searchData');
            url.searchParams.delete('removedFilters');

        } else if (_self.isEtools) {
            console.debug("[EtoolsTable - getSsiProducts]");
            url = new URL(document.getElementById('generateSummaryTabLink').href);
            data = {
                partNumber: window.partNumberList.join(),
                language: this.config.defaultLanguage || 'en',
                page: this.pageNumber,
                size: this.pageSize
            };
        } else {

            let partialPartNumber = this.$partNumberFilter.val();
            // If no wildcard is found. Search by contains
            if (partialPartNumber.indexOf("*") === -1) {
                partialPartNumber = "*" + partialPartNumber + "*";
            }

            data = {
                componentId: this.id,
                productId: this.productId,
                language: this.config.defaultLanguage || 'en',
                partNumber: partialPartNumber,
                page: this.pageNumber,
                size: this.pageSize
            };
            url = new URL(globalConfig.ssi.urls.showSsiInfo);
            url.searchParams.set('partNumber', partialPartNumber);
        }
        return $.get(url, data);
    }

    function manageGetSsiProducts() {
        var _self = this;
        var def = $.Deferred();
        var $paginateContainer = _self.paginationElementsConfig.$paginationContainer;
        var paginateJs = $paginateContainer.data('pagination');
        var pageStartIndex = _self.pageSize * (_self.pageNumber - 1);
        displayLoadSpinner(this);

        //Cached data
        /*if (_self.data[_self.pageSize][pageStartIndex]) {
            def.resolve(_self.data[_self.pageSize]);
            removeLoadSpinner(_self);
            return def.promise();
        }*/

        getSsiProducts.call(this)
            .then(function (response) {
                removeLoadSpinner(_self);
                var total = parseInt($('#numTotalElements', response).val(), 10);
                let hideSearchResult = false;
                if (_self.isFunctionality) {
                    if ($('#functionalityColumns', response).val()) {
                        var functionalityColumns = $('#functionalityColumns', response).val().split(",");
                    }
                    if ($('#functionalityDisabledFilters', response).val()) {
                        var functionalityDisabledFilters = $('#functionalityDisabledFilters', response).val().split(",");
                    }
                    if ($('#functionalityRequiredFilters', response).val()) {
                        var functionalityRequiredFilters = $('#functionalityRequiredFilters', response).val().split(",");
                    }
                    let removedFilters;
                    let currentURL = new URL(window.location.href);
                    if (_self.isFunctionalityFirstLoad) {
                        _self.isFunctionalityFirstLoad = false;
                        hideSearchResult = true;
                        removedFilters = functionalityDisabledFilters;
                        if (removedFilters) {
                            let encodedRemovedFilters = base64EncodeUrl(btoa(JSON.stringify(removedFilters)));
                            currentURL.searchParams.set("removedFilters", encodedRemovedFilters);
                            window.history.replaceState({}, window.document.title, currentURL.toString());
                        }
                    } else {
                        let urlRemovedFilters = currentURL.searchParams.get("removedFilters");
                        if (urlRemovedFilters) {
                            let base64RemovedFilters = base64DecodeUrl(urlRemovedFilters);
                            removedFilters = JSON.parse(atob(base64RemovedFilters));
                        }
                    }
                    setFunctionalityColumns(functionalityColumns);
                    functionalityDisableFilters(functionalityDisabledFilters, removedFilters);
                    functionalityCheckRequiredFilters(functionalityRequiredFilters);
                    if (total > 0) {
                        $("#container_additionalParameters_modal_selection").removeClass("hidden");
                    } else {
                        $("#container_additionalParameters_modal_selection").addClass("hidden");
                    }
                }
                if (total > 0) {
                    _self.data[_self.pageSize][total - 1] = null; // This is to ensure that the pagination count is correctly done
                    _self.data[_self.pageSize].splice(pageStartIndex, 1, response);//Put the data at the exact index where it going to be getted at
                }

                if (paginateJs && paginateJs.model) {
                    paginateJs.model.totalNumber = total > 0 ? total : total + 1; // this is to fix pagination load numbers with 0 reset the last value
                }
                if (total === 0) {
                    $(".pagination_showing").hide();
                    $(".paginationjs").hide();
                    $(".selection-basket-favourites-bar-container").hide();
                    $("#ssi-content").hide();
                    $(".no-results-js").removeClass("hidden");
                    $(".no-results-js").show();
                } else {
                    $(".pagination_showing").show();
                    $(".paginationjs").show();
                    $(".selection-basket-favourites-bar-container").show();
                    $("#ssi-content").show();
                    $(".no-results-js").addClass("hidden");
                    $(".no-results-js").hide();
                }
                if (!hideSearchResult) {
                    $("#container_bestItems").show();
                }
                _self.config.paginateResults = total;
                def.resolve(_self.data[_self.pageSize]);

            }).catch(function (response) {
            removeLoadSpinner(_self);
            //var result = [0];//Pagination.js needs an Array
            //_self.config.paginateResults = 0;

            def.reject(_self.data[_self.pageSize]);
        });

        return def.promise();
    }

    function resetSsiFilters(event) {
        event.preventDefault();

        var _self = this;

        if (_self.$partNumberFilter.val() === '') return;

        _self.resetFilter = true;
        this.$ssiFilter.find('.select2-selection-js').each(function () {
            $(this).val("no_selection").trigger('change');
        });
        this.$ssiFilter.find("input.search-option").each(function () {
            $(this).val("");
        });
        setFilterValue(_self, "");
        _self.resetFilter = false;
    }

    function setFilterValue(_self, value) {
        _self.pageNumber = 1;
        _self.data[_self.pageSize] = [];
        _self.$partNumberFilter.val(value);
        _self.$partNumberFilter.trigger("change");
    }

    function disabledAllOptions() {
        $(".search-option-js option").each(function () {
            if ($(this).attr("value") != "no_selection" && $(this).attr("value") != "") $(this).attr("disabled", true);
        })
    }

    function isNumberKey(evt) {
        var charCode = (evt.which) ? evt.which : event.keyCode;
        return !(charCode > 31 && (charCode < 48 || charCode > 57));
    }

    function base64EncodeUrl(str) {
        return str.split('+').join('-').split('/').join('_').split('=').join('.');
    }

    function base64DecodeUrl(str) {
        return str.split('-').join('+').split('_').join('/').split('.').join('=');
    }

    window.smc.StandardStockedItems = StandardStockedItems;
})
(window.smc);

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
