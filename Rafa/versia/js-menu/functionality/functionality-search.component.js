(function (globalConfig) {
    function FunctionalitySearchComponent(config) {
        this.config = config;
    }

    FunctionalitySearchComponent.prototype.init = init;
    FunctionalitySearchComponent.prototype.initializeSearchData = initializeSearchData;
    FunctionalitySearchComponent.prototype.getActiveFilters = getActiveFilters;
    FunctionalitySearchComponent.prototype.initializeEvents = initializeEvents;
    // FunctionalitySearchComponent.prototype.initFunctionalitySearch = initFunctionalitySearch;

    function init() {
        console.log("[FunctionalitySearchComponent] Init");

        this.$filters = $("#container_additionalParameters select");
        this.$filters.selectpicker();
        // this.$functionality_reset_btn = $('#reset-btn');
        this.$functionality_partNumberFilter = $('#partNumberFilter');
        this.initializeSearchData();
        this.initializeEvents();
    }

    function initializeSearchData() {
        console.log("[FunctionalitySearchComponent] initializeEvents");
        var currentURL = new URL(window.location.href);
        var urlSearchData = currentURL.searchParams.get("searchData");
        if (urlSearchData) {
            var base64SearchData = base64DecodeUrl(urlSearchData);
            var searchData = JSON.parse(atob(base64SearchData));
            var selectedFilters = searchData.selectedValues;
            $("#container_additionalParameters .selectpicker").val("");
            this.$functionality_partNumberFilter.val(searchData.partNumber);
            for (var key in selectedFilters) {
                let $select = $("[data-filterid=" + key + "]");
                $select.selectpicker('val', selectedFilters[key]);
                $select.parents(".form-floating").children("label").addClass("float");
                $select.parents(".bootstrap-select").find(".filter-option-inner-inner").addClass("lowered");
            }
            $(".changelen.active").removeClass('active');
            $(".changelen[data-len=" + searchData.size + "]").addClass('active');
        }
        window.smc.standardStockedItemsComponent.init();
        this.firstLoad = false;
        $('.selectpicker').selectpicker('refresh');
    }


    function getActiveFilters(event) {
        console.log("[FunctionalitySearchComponent] getActiveFilters");
        var currentSelectPicker = $(event.target).find(".selectpicker")[0];
        var url = new URL(document.getElementById('getActiveFiltersLink').href);
        var _self = this;
        if (_self.isProcesing) {
            return;
        }
        _self.isProcesing = true;
        var partialPartNumber = _self.$functionality_partNumberFilter.val();
        var selectedValues = {};
        var filtersFound = false;
        var currentSelectedValue = $(currentSelectPicker).val();
        if (currentSelectedValue === "") {
            _self.isProcesing = false;
            return;
        }
        $("#container_additionalParameters .selectpicker").each(function () {
            if (this !== currentSelectPicker) {
                if ($(this).attr("data-filterId") && $(this).val() && $(this).val() !== "0" && $(this).val() !== "") {
                    selectedValues[$(this).attr("data-filterId")] = $(this).val();
                    filtersFound = true;
                }
            }
        });
        console.debug("getActiveFilters selected values: ",  selectedValues, filtersFound);
        if (!filtersFound) {
            $(currentSelectPicker).find("option").removeAttr("disabled");
            _self.isProcesing = false;
            $('.selectpicker').selectpicker('refresh');
            return;
        }
        var data = {
            selectedValues: selectedValues,
            categoryId: $("#functionality_categoryId").val(),
            language: this.config.defaultLanguage || 'en',
            partNumber: partialPartNumber
        };
        $.getJSON(url, data)
            .then(function (response) {
                if (response) {
                    console.debug("[getActiveFilters] response:", response);
                    var responseList = response.split(",");
                    $("#container_additionalParameters .selectpicker").each(function () {
                        $(".selectpicker option").removeAttr("disabled");
                    });
                    for (var i = 0 ; i < responseList.length; i++) {
                        var element = responseList[i];
                        if (element !== undefined && element !== "") {
                            $("#container_additionalParameters .selectpicker option[value='" + element + "']").prop('disabled', true);
                        }
                    }
                    $('.selectpicker').selectpicker('refresh');
                }
                _self.isProcesing = false;
            })
            .catch(function (error) {
                console.debug("[getActiveFilters] Functionality error", error);
                _self.isProcesing = false;
            });
    }


    function initializeEvents() {
        console.log("[FunctionalitySearchComponent] initializeEvents");
        $("#container_additionalParameters").on('show.bs.dropdown', this.getActiveFilters.bind(this));
    }

    function base64DecodeUrl(str) {
        return  str.split('-').join('+').split('_').join('/').split('.').join('=');
    }

    window.smc.FunctionalitySearchComponent = FunctionalitySearchComponent;
})
(window.smc);