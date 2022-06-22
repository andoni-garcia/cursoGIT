var smc = smc || {};
smc.psearch = smc.psearch || {};

var psearchLoaded = false;
var psearchLanguage = 'en';//By default, override later with user's language
var i18nPSearch = {
    "70_lbl_002": "No results found that matches your search criteria",
    "70_lbl_003": "From",
    "70_lbl_004": "To",
    "70_lbl_005": "Reset",
    "70_lbl_006": "Search"
};

$(document).on('psearch.config.loaded', function () {
    smc.psearch.functions.handleDcComponentLoaded();
});

var $dcProducts;

console.log('[psearch-component]');
smc.psearch.functions =  {
    handleDcComponentLoaded: function (e, component) {
        var $component = $(component);

        if (!psearchLoaded) {
            psearchLoaded = true;

            $dcProducts = $('#dc_products');
            var $dcProductsChildren = $('#dc_product_children');
            $dcProductsChildren.hide();
            var attrset = $dcProducts.data("attrset");
            var childrenType = $dcProducts.data("childrentype");
            var underfolder = $dcProducts.data("underfolder");

            if (attrset) {
                $("#smc-psearch").show();
                initializeParametricSearch();
            }

        }
    },
    config: function (config) {
        psearchLanguage = config.psearchLanguage;
        i18nPSearch = {
            "70_lbl_002": config.messages['psearch.noresultsfound'],
            "70_lbl_003": config.messages['psearch.from'],
            "70_lbl_004": config.messages['psearch.to'],
            "70_lbl_005": config.messages['psearch.reset'],
            "70_lbl_006": config.messages['psearch.search'],
            "70_lbl_007": "-- " + config.messages['psearch.chooseanoption'] + " --"
        };
    }

};


// TraducciÃƒÂ³n de literales <%getPropertyText("web_ho_00_title", "Home", rb_webCommon)%>

//var psearchActive = "{VIPDEPLOYMENT_TYPE}" != "PROD";
var psearchActive = true;
var psearchDebug = false;
var psearchClassicButtons = false;
var psearchShowSearchButton = false;
var psearchUnusedSearch = true;
//TEST
var psearchFormOrder = {
    "PS_ISO_CYLINDERS": [0, 2, 3, 4, 1, 7, 5, 6, 8],
    // "PS_FITTINGS": [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13],
};

//var psearchApiDomain = "http://localhost:8080/";
// var psearchApiDomain = "https://tst-tomcat.smcaws.eu/api-products/" ;
var psearchApiDomain = "http://localhost:8081/smc-api-products/";
// var psearchApiDomain = "http://evx4405946.sys.ntt.eu/psearch/";

// Resources
var psearchSpinnerUrl = "http://evx4405946.sys.ntt.eu/portal_edit/WebTemplate/images/psearch-loading.gif";
var psearchNoResultsImageUrl = "http://evx4405946.sys.ntt.eu/portal_edit/WebTemplate/images/psearch-warning.gif";

// Display texts
//var textNoResultsFound = "No results found that matches your search criteria"; -> 70_lbl_002
//var textFrom = "From..."; -> 70_lbl_003
//var textTo = "To..."; -> 70_lbl_004
//var textReset = "Reset"; -> 70_lbl_005
//var textSearch = "Search"; -> 70_lbl_006
var psearchReset = false;
var psearchAttrSet;
var psearchChildrenType;
var psearchUnderFolder;

var psearchDataContainers = {};
var psearchDataContainersOrder = [];
var psearchDescriptionDataContainers = {};
var psearchDescriptionDataContainersOrder = [];

var psearchAjaxRequest;

var psearchMultiDefaultValues = {};

var selectListName = "_SELECT-LIST";
var psearchSliderValues = {};

function initializeParametricSearch() {
    if (psearchActive) {
        // if (psearchActive && etech_online_status == "on") {
        psearchAttrSet = $dcProducts.attr("data-attrset");
        psearchChildrenType = $dcProducts.attr("data-childrentype");
        psearchUnderFolder = $dcProducts.attr("data-underfolder");
        psearchDebug ? console.log("pSearch: " + psearchAttrSet + " " + psearchChildrenType + " " + psearchUnderFolder) : "";

        if (psearchAttrSet != undefined && psearchChildrenType != undefined && psearchUnderFolder != undefined
            && psearchAttrSet != "" && psearchChildrenType != "" && psearchUnderFolder != "") {

            readDataContainers();

            addSearchingSpinner();

            showPSearchIfPresent();

            if ($("#smc-psearch")) {
                getSearchForm(psearchAttrSet);
            }
        }
    }
}


function getUrlParameter(sParam) {
    var sPageURL = window.location.search.substring(1),
        sURLVariables = sPageURL.split('&'),
        sParameterName,
        i;
    for (i = 0; i < sURLVariables.length; i++) {
        sParameterName = sURLVariables[i].split('=');
        if (sParameterName[0] === sParam) {
            return sParameterName[1] === undefined ? true : decodeURIComponent(sParameterName[1]);
        }
    }
}

function readDataContainers() {
    if ($(".dc_products .dc_rowContainer.psearch-subclass>.dc_dataContainer").length > 0) {
        $(".dc_products .dc_rowContainer.psearch-subclass>.dc_dataContainer").each(function (index, element) {
            var id = $(this).attr("id");
            psearchDataContainers[id] = $(this);
            psearchDataContainersOrder.push(id)
        });
        $(".dc_products .dc_rowContainer.psearch-description .dc_dataContainer").each(function (index, element) {
            var id = $(this).attr("id");
            psearchDescriptionDataContainers[id] = $(this);
            psearchDescriptionDataContainersOrder.push(id)
        });
    } else {
        $(".dc_products .dc_rowContainer .dc_dataContainer").each(function (index, element) {
            var id = $(this).attr("id");
            psearchDataContainers[id] = $(this);
            psearchDataContainersOrder.push(id)
        });
    }

}

function addSearchingSpinner() {
    $(".dc_products").append(getSearchingSpinner());
}

function showPSearchIfPresent() {
    if ($("#box_dc_av_search")) {
        $("#box_dc_av_search").show();
        initializePSearchDropdown();
    }
}

function showLoading() {
    $("#searchParamsBox").addClass('loading');
    $dcProducts.parent().removeClass('smc-filters-column');
    $dcProducts.addClass('loading');
    $('.psearch-no-results').hide();
    //$("#searchParamsBox").html(document.getElementById('spinner-template').innerHTML);
}

function hideLoading() {
    $("#searchParamsBox").removeClass('loading');
    $dcProducts.parent().addClass('smc-filters-column');
    $dcProducts.removeClass('loading');
    $("#searchParamsBox .cms-component").remove();
}

function showSearching() {
    $(".series-loading-container").html(document.getElementById('spinner-template').innerHTML);
    if ($(".psearch-searching-container")) {
        $(".psearch-searching-container").show();
        // $(".psearch-searching-container").css("opacity", psearchSearchingOpacity);
    }
}

function hideSearching() {
    if ($(".psearch-searching-container")) {
        $(".psearch-searching-container").hide();
        // $(".psearch-searching-container").css("opacity", 1.0);
    }
}

function initializePSearchDropdown() {
    $(".boxTitle").unbind('click').bind('click', function () {
        if ($(this).hasClass("close")) {
            $(this).removeClass("close");
            $("#searchParamsBox").show()
        } else {
            $(this).addClass("close");
            $("#searchParamsBox").hide()
        }
    });

    $("#searchParamsBox").append(getSearchingSpinner());
}

function getSearchForm(attrSet) {
    showLoading();

    var data = {
        lang: psearchLanguage,
        attrset: attrSet,
        underfolder: psearchUnderFolder.replace("/", "+")
    };

    $.getJSON(smc.psearchurls.getPSearchForm, data).then(function (data) {
        psearchDebug ? console.debug('[getPSearchForm]', data) : "";
        printSearchForm(data);

        hideLoading();
        hideSearching();
        var urlProductIdParam = getUrlParameter("productId");
        if (urlProductIdParam !== undefined && getUrlParameter("productId") !== ""){
            disableEveryFilter();
        }
    });

}
function resetFilters(){
    $("#productconfigurator-component__section").empty();
    restartSelects();
    enableDefaultFormOptions();
    $(".select2-series").prop('disabled', false);
    $(".select2-series").removeClass("noactive");
    $("#searchParamsBox .select2-selection").removeClass("noactive");
    $("#searchParamsBox .select2-selection__rendered").removeClass("noactive_text");
    var url = new URL(window.location.href).toString();
    if (url.indexOf("?") > 0){
        url = url.substring(0, url.indexOf("?"));
        window.history.pushState({}, window.document.title, url.toString());
    }
}

function disableEveryFilter(){
    $(".select2-series").prop('disabled', true);
    $(".select2-series").addClass("noactive");
    $("#searchParamsBox .select2-selection").addClass("noactive");
    $("#searchParamsBox .select2-selection__rendered").addClass("noactive_text");
}


function getAttDefinitionForFormElement(element, attDefinitions) {
    var attDefinition;
    $.each(attDefinitions, function (index, value) {
        if (element.name === value.name) {
            attDefinition = value;
        }
    });

    if (attDefinition) {
        return attDefinition;
    } else {
        return attDefinitions[0];
    }
}

function printSearchForm(data) {
    var formElements = data.searchattformresult.extraformdata;
    var attDefinitions = data.attdefinitions;

    psearchDebug ? console.log(formElements) : "";
    psearchDebug ? console.log(attDefinitions) : "";

    // Contenedor que impide pulsar sobre cualquier opciÃƒÂ³n mientras se realiza una bÃƒÂºsqueda
    $("#searchParamsBox").append("<div class=\"psearch-searching-container\"></div>");

    if (psearchAttrSet in psearchFormOrder) {
        //if (psearchAttrSet in psearchFormOrder && psearchFormOrder[psearchAttrSet].length == formElements.length) {
        $.each(psearchFormOrder[psearchAttrSet], function (index, value) {
            printElement(formElements[value], getAttDefinitionForFormElement(formElements[value], attDefinitions));
        });
    } else {
        $.each(formElements, function (index, element) {
            var elementInfo = getAttDefinitionForFormElement(element, attDefinitions);
            printElement(element, elementInfo);
        });
    }

    var buttonsHTML = getButtonsElement();
    $("#searchParamsBox").append(buttonsHTML);

    initButtons();

    initFormValues();
}

function printElement(element, elementInfo) {
    var elementHTML = "";

    if (element.formtype == "dropdown") {
        if (element.formname.indexOf("select") > -1) {
            elementHTML = getSelectFormElement(element, elementInfo);
        } else if (element.formname.indexOf("multi") > -1) {
            // elementHTML = getMultiFormElement(element, elementInfo);
            elementHTML = getSelectFormElement(element, elementInfo);
        }
    } else if (element.formtype == "range") {
        //FIXME -- Hide, we are not supposed to show this here
        // if (element.formname.indexOf("inrange") > -1) {
        //     elementHTML = getRangeFormElement(element, elementInfo);
        // }
    }

    if (elementHTML != "") {
        $("#searchParamsBox").append(elementHTML);

        initElement(element, elementInfo);

    }
}

function getSelectFormElement(element, elementInfo) {
    var html = "";

    html = html + "<div class=\"bloque-formu\" id=\"" + element.formname + "\">";

    // Label
    html = html + "<label>";
    html = html + element.name;
    html = html + "</label>";

    var values = element.formvalues;

    // if(elementInfo.code.indexOf(selectListName) > -1){
    html = html + "<div class=\"clearfix\">";

    html = html + "<div class=\"combobox\">";
    html = html + "<select id=\"" + element.formname + "-select\" data-value=\"-1\" class='select2-series'>";
    html = html + getSelectOptionsForMulti(values, i18nPSearch["70_lbl_007"]);
    html = html + "</select>";
    html = html + "</div>";
    html = html + "</div>";
    // }else{
    //     html = html + "<div class=\"radios clearfix\">";
    //
    //     $.each(values, function (index, value) {
    //         var value_text = value.split(",");
    //
    //         if (psearchUnusedSearch == true && value_text[0].indexOf("NOT_USED") > -1) {
    //             html = html + "<div class=\"psearch-select-element\">";
    //             html = html + "<div class=\"psearch-select-checkbox\">";
    //             html = html + "<input id=\"" + element.formname + "-" + index + "\" type=\"checkbox\" value=\"" + value_text[0].replace("~NOT_USED~", "") + "\" disabled data-default=\"disabled\">";
    //             html = html + "</div>";
    //             html = html + "<div class=\"psearch-select-label\">";
    //             html = html + "<label for=\"" + element.formname + "-" + index + "\" class=\"disabled\" value=\"" + value_text[0].replace("~NOT_USED~", "") + "\" data-default=\"disabled\">";
    //             html = html + value_text[1];
    //             html = html + "</label>";
    //             html = html + "</div>";
    //             html = html + "</div>";
    //         } else {
    //             html = html + "<div class=\"psearch-select-element\">";
    //             html = html + "<div class=\"psearch-select-checkbox\">";
    //             html = html + "<input id=\"" + element.formname + "-" + index + "\" type=\"checkbox\" value=\"" + value_text[0].replace("~NOT_USED~", "") + "\" data-default=\"enabled\">";
    //             html = html + "</div>";
    //             html = html + "<div class=\"psearch-select-label\">";
    //             html = html + "<label for=\"" + element.formname + "-" + index + "\" value=\"" + value_text[0].replace("~NOT_USED~", "") + "\" data-default=\"enabled\">";
    //             html = html + value_text[1];
    //             html = html + "</label>";
    //             html = html + "</div>";
    //             html = html + "</div>";
    //         }
    //
    //     });
    //     html = html + "</div>";
    //     html = html + "</div>";
    //
    // }


    return html;
}

function getMultiFormElement(element, elementInfo) {
    var values = element.formvalues;

    psearchMultiDefaultValues[element.formname] = values;

    var html = "";

    html = html + "<div class=\"bloque-formu\" id=\"" + element.formname + "\">";

    // Label
    if (elementInfo.uom != "" && elementInfo.uom != null && elementInfo.uom != " ") {
        html = html + "<label>";
        html = html + element.name + " (" + elementInfo.uom + ")";
        html = html + "</label>";
    } else {
        html = html + "<label>";
        html = html + element.name;
        html = html + "</label>";
    }
    // values = orderValues(values);
    // From select
    html = html + "<div class=\"from-to-label\">" + i18nPSearch["70_lbl_003"] + "</div>";
    html = html + "<div class=\"combobox2\">";
    html = html + "<select id=\"" + element.formname + "-from\" data-value=\"-1\">";
    html = html + getSelectOptionsForMulti(values, i18nPSearch["70_lbl_007"]);
    html = html + "</select>";
    html = html + "</div>";

    // To select
    html = html + "<div class=\"from-to-label\">" + i18nPSearch["70_lbl_004"] + "</div>";
    html = html + "<div class=\"combobox2\">";
    html = html + "<select id=\"" + element.formname + "-to\" data-value=\"-1\">";
    html = html + getSelectOptionsForMulti(values, i18nPSearch["70_lbl_007"]);
    html = html + "<select>";
    html = html + "</div>";

    html = html + "</div>";

    return html;
}

function getSelectOptionsForMulti(values, emptyText) {
    var html = "";
    html = html + "<option value=\"-1\">";
    html = html + emptyText;
    html = html + "</option>";
    $.each(values, function (index, value) {
        var value_text = value.split(",");
        if (value_text[0].indexOf("~NOT_USED~") > -1) {
            if (value_text[0].indexOf("\"") > 0) {
                html = html + "<option value='" + value_text[0] + "' disabled data-default='disabled'>";
            } else {
                html = html + "<option value=\"" + value_text[0] + "\" disabled data-default='disabled'>";
            }
        } else {
            if (value_text[0].indexOf("\"") > 0) {
                html = html + "<option value='" + value_text[0] + "' data-default='enabled'>";
            } else {
                html = html + "<option value=\"" + value_text[0] + "\" data-default='enabled'>";
            }
        }
        html = html + (value_text[1] != undefined ? value_text[1] : value_text[0]);
        html = html + "</option>";
    });

    return html;
}

function orderValues(array){
    psearchDebug ? console.log(array) : "";
    array.sort(function(a, b) {
        // return Number(a.split(",")[0]) - Number(b.split(",")[0]);
        var valA = Number(a.split(",")[0]);
        var valB = Number(b.split(",")[0]);

        valA = calculateFormToValue(valA, a.split(",")[0]);
        valB = calculateFormToValue(valB, b.split(",")[0]);

        if (isNaN(valA)==false && isNaN(valB) ==false) {
            //comprobar > <
            if (valA > valB) {
                return 1;
            } else if (valA < valB)
                return -1;
            return 0;
        }

        if (isNaN(valA) && !isNaN(valB)){
            return 1;
        }

        if (!isNaN(valA) && isNaN(valB)){
            return -1;
        }
        return 0;

    });

    return array;
}

function getRangeFormElement(element, elementInfo) {
    var min = element.formvalues[0];
    var max = element.formvalues[1];
    var paramName = element.formname;

    psearchDebug ? console.log("getRangeFormElement() - min: " + min + " max: " + max) : "";

    obtainSliderValues(paramName, min, max);

    var html = "";
    html = html + "<div class=\"bloque-formu inrange \" id=\"" + paramName + "\">";

    // Label
    html = html + "<label>";
    html = html + element.name;
    html = html + "</label>";

    // Slider
    html = html + "<div class=\"valores\">";
    html = html + "<input class=\"val-min\" type=\"text\" id=\"" + paramName + "-val-min\" data-min=\"" + 0 + "\" data-min-default=\"" + min + "\" data-selected=\"" + min + "\" maxlength=\"10\">";
    html = html + "<input class=\"val-max\" type=\"text\" id=\"" + paramName + "-val-max\" data-max=\"" + (psearchSliderValues[paramName].length - 1) + "\" data-max-default=\"" + max + "\" data-selected=\"" + max + "\" maxlength=\"10\">";
    html = html + "</div>";
    html = html + "<div class=\"psearch-slider\" id=\"" + paramName + "-slider\" data-uom=\"" + elementInfo.uom + "\">";
    html = html + "</div>";

    html = html + "</div>";

    return html;
}

function getButtonsElement() {
    var html = "";

    if (psearchClassicButtons) {
        html = html + "<div class=\"bloque-formu botonera-classic\">";
    } else {
        html = html + "<div class=\"bloque-formu botonera\">";
    }

    // FIXME: Fix reset button
    html = html + "<input type=\"button\" class=\"reset btn btn-primary\" value=\"" + i18nPSearch["70_lbl_005"] + "\">";
    if (psearchShowSearchButton) {
        html = html + "<input type=\"button\" class=\"search\" value=\"" + i18nPSearch["70_lbl_006"] + "\">";
    }
    html = html + "</div>";

    return html;
}

// Initializers

function initElement(element, elementInfo) {
    if (element.formtype == "dropdown") {
        if (element.formname.indexOf("multi") > -1) {
            initFromTo(element.formname);
        } else if (element.formname.indexOf("select") > -1) {

            if(elementInfo.code.indexOf(selectListName) > -1){
                initSelects(element, elementInfo);
            }else{
                initSelects(element, elementInfo);
            }
        }
    } else if (element.formtype == "range") {
        if (element.formname.indexOf("inrange") > -1) {
            initSlider(element, elementInfo);
        }
    }
}

function initCheckboxes(element, elementInfo) {
    $("#" + element.formname).find("input").unbind('change').bind('change', function () {
        if (!psearchShowSearchButton) {
            makeSearch();
        }
    });
}

function initSelects(element, elementInfo) {
    if (serie_config_values) {
        serie_config_values.forEach(function(item){
            if (item.key === elementInfo.code) {
                if ($("#" + element.formname + "-select option[value='" + item.value + "']").length > 0) {
                    $("#" + element.formname + "-select").val(item.value);
                } else {
                    $("#" + element.formname + "-select option").each(function() {
                        if ($(this).html() === item.value) {
                            $("#" + element.formname + "-select").val($(this).val());
                        }
                    });
                }
            }
        });
    }

    var $select = $("#" + element.formname + "-select");
    $select.unbind('change').bind('change', function () {
        var currId =$select.attr("id");
        if ($("#"+currId+" option").filter(":selected").hasClass("invalid-option")){
            $("#select2-"+currId+"-container").css("color","#FF0000");
            return;
        }else if (areSearchOptionsInvalid()){
            return;
        }else {
            $("#select2-"+currId+"-container").css("color","#444444");
        }
        restoreSelectValues(this);
        // restartSelects(this);
        $(this).blur();
        if (!psearchShowSearchButton) {
            updateSelectValues().then(function(){
                makeFilteredSearch(this);
                reviewIfSelectedElementsAreValid();
            });
        }
    });
    $select.select2({
        templateResult: formatSelect2Options
    });
}


function areSearchOptionsInvalid(){
    $(".select2-series option:selected").each(function(){
        if ($(this).hasClass("invalid-option")){
            return true;
        }
    });
    return false;
}

function reviewIfSelectedElementsAreValid(){

    $(".select2-series option:selected").each(function(){
        var selectedOption = this;
        var currSelectId = $(selectedOption).parent().attr("id");
        if ($(selectedOption).hasClass("invalid-option")){
            $("#select2-"+currSelectId+"-container").css("color","red");
        }else {
            $("#select2-"+currSelectId+"-container").css("color","#444");
        }
    });
}


function formatSelect2Options(option, htmlElement) {
    var isSelecting = htmlElement && htmlElement.length;
    if (!option.id) {
        return option.text;
    }
    var currColor = option.element.style.color;
    var currClass = option.element.classList;
    var isFeaturedOption = option.element.className.indexOf('is-preferred') > -1;
    if ($(option).hasClass("invalid-option")){
        currColor = "red";
        currClass+=" invalid-option";
    }
    return  $('<div>', {
        id: option.id,
        css: {
            color: currColor
        },
        class: currClass,
        html: isFeaturedOption && !isSelecting ? '<span><i class="image-star"></i> ' + option.text + '</span>' : option.text
    });
}

function restartSelects(currentSelect){
    try{
        $(".invalid-option").each(function (){
            $(this).removeClass("invalid-option");
        });
        $(".select2-series").each(function(){
            if (currentSelect === undefined){
                //no filter has changed, the user has pressed the RESET button
                $(this).val(-1);
            }
            if (this !== undefined && this !== currentSelect){
                $(this).select2({
                    templateResult: formatSelect2Options
                });
            }
        });
    }catch (e) {
        console.error("[RESTART SELECTS]",e);
    }
}

function initFromTo(name) {
    var fromElement = $("#" + name + "-from");
    var toElement = $("#" + name + "-to");

    fromElement.unbind('change').bind('change', function () {

        $(this).blur();

        var fromValue = fromElement.val();
        var toValue = toElement.val();

        // fromValue = calculateFormToValue(fromValue, fromElement.val());
        // toValue = calculateFormToValue(toValue, toElement.val());
        var indexForm = fromElement[0].selectedIndex;
        var indexTo = toElement[0].selectedIndex;

        psearchDebug ? console.log("Valor from " + fromValue) : "";
        // if (fromValue != -1 && toValue != -1 && fromValue > toValue) {
        //   toElement.val(fromElement.val());
        // }

        if(fromValue != -1 && toValue != -1 && indexForm > indexTo){
            toElement.val(fromElement.val());
        }

        fromElement.attr("data-value", fromElement.val());
        toElement.attr("data-value", toElement.val());

        if (!psearchShowSearchButton) {
            makeSearch();
        }
    });

    toElement.unbind('change').bind('change', function () {

        $(this).blur();

        var fromValue = Number(fromElement.val());
        var toValue = Number(toElement.val());

        // fromValue = calculateFormToValue(fromValue, fromElement.val());
        // toValue = calculateFormToValue(toValue, toElement.val());
        //
        // if (fromValue != -1 && toValue != -1 && fromValue > toValue) {
        //   fromElement.val(toElement.val());
        // }

        var indexForm = fromElement[0].selectedIndex;
        var indexTo = toElement[0].selectedIndex;


        if(fromValue != -1 && toValue != -1 && indexForm > indexTo){
            fromElement.val( toElement.val());
        }

        fromElement.attr("data-value", fromElement.val());
        toElement.attr("data-value", toElement.val());

        if (!psearchShowSearchButton) {
            makeSearch();
        }
    });
}

function calculateFormToValue(lastValue, element) {
    // format 1/4
    if (/^[0-9]+\/[0-9]+$/.test(element)) {
        lastValue = splitFractionNumber(element, "/");
    }

    // format 1/4"
    if (/^[0-9]+\/[0-9]+\"$/.test(element)) {
        var newValue = element.slice(0, -1);
        lastValue = splitFractionNumber(newValue, "/");
    }

    // format 6 mm or 1 1/4
    if (/^\d+(\.\d{1,3})? .*$/.test(element)) {
        lastValue = splitNumberwithChar(element, " ");
    }

    // format 0.086"
    if (/^\d+(\.\d{1,3})?\"$/.test(element)) {
        lastValue = splitNumberwithChar(element, "\"");
    }

    return lastValue;
}

function splitNumberwithChar(value, split) {
    var arrayValFromElement = value.split(split);
    var fromValue = Number(arrayValFromElement[0]);
    psearchDebug ? console.log(arrayValFromElement) : "";
    return fromValue;
}

function splitFractionNumber(value, split) {
    var arrayValFromElement = value.split(split);
    var fromValue = Number(arrayValFromElement[0] / arrayValFromElement[1]);
    psearchDebug ? console.log(arrayValFromElement) : "";
    return fromValue;
}

function initSlider(element, elementInfo) {
    var min = element.formvalues[0];
    var max = element.formvalues[1];

    var formname = element.formname;

    var domElement = initSliderValues(formname, min, max);

    domElement.slider().unbind('slidechange').bind('slidechange', function () {
        if (!psearchShowSearchButton) {
            makeSearch();
        }
    });
}

function initSliderValues(paramName, min, max) {
    psearchDebug ? console.log("initSliderValues() - paramName: " + paramName + " min: " + min + " max: " + max) : "";

    var domElement = $("#" + paramName + "-slider");
    var valMinDomElement = $("#" + paramName + "-val-min");
    var valMaxDomElement = $("#" + paramName + "-val-max");
    var unit = $("#" + paramName + "-slider").attr("data-uom");

    // DefiniciÃƒÂ³n cliente
    // Hasta 100:  que si haya decimales como hasta ahora
    // Entre min : 100 y max : 1000: paso de 1
    // Entre min : 1000 y max : 10000: paso de 5
    // A partir de min: 10000: paso de 10
    obtainSliderValues(paramName, min, max);

    var step = 1;
    var sliderMin = 0;
    var sliderMax = psearchSliderValues[paramName].length - 1;

    domElement.slider({
        range: true,
        min: sliderMin,
        max: sliderMax,
        values: [sliderMin, sliderMax],
        step: step, // specify decimals numbers
        slide: function (event, ui) {
            var selectedMin = psearchSliderValues[paramName][ui.values[0]];
            var selectedMax = psearchSliderValues[paramName][ui.values[1]];
            valMinDomElement.val(selectedMin + " " + unit);
            valMinDomElement.attr("data-selected", selectedMin);

            valMaxDomElement.val(selectedMax + " " + unit);
            valMaxDomElement.attr("data-selected", selectedMax);
        }
    });
    valMinDomElement.unbind('blur').bind('blur',function () {
        minInputSlider($(this));
    });

    valMinDomElement.unbind('keyup').bind('keyup', function (e) {
        if (e.keyCode == 13) {
            minInputSlider($(this));
        }
    });
    valMaxDomElement.unbind('blur').bind('blur', function () {
        maxInputSlider($(this));
    });
    valMaxDomElement.unbind('keyup').bind('keyup', function (e) {
        if (e.keyCode == 13) {
            maxInputSlider($(this));
        }
    });

    var selectedMin = psearchSliderValues[paramName][domElement.slider("values", 0)];
    valMinDomElement.val(selectedMin + " " + unit);
    valMinDomElement.attr("data-selected", selectedMin);

    var selectedMax = psearchSliderValues[paramName][domElement.slider("values", 1)];
    valMaxDomElement.val(selectedMax + " " + unit);
    valMaxDomElement.attr("data-selected", selectedMax);
    return domElement;
}

function getSliderValuesArray(min, max, step) {
    psearchDebug ? console.log("getSliderValuesArray() - step: " + step + " min: " + min + " max: " + max) : "";

    var sliderValues = [];
    min = Number(min);
    max = Number(max);
    if (min < max) {
        for (var i = min; i < max; i = i + step) {
            if (step < 1) {
                sliderValues.push(Math.round(i * 10) / 10);
            } else {
                sliderValues.push(i);
            }
        }
    }
    sliderValues.push(max);

    return sliderValues;
}

function obtainSliderValues(paramName, min, max) {
    psearchDebug ? console.log("obtainSliderValues() - paramName: " + paramName + " min: " + min + " max: " + max) : "";

    var valueRange = max - min;
    var step = 0.1;

    // Sacar array de valores posibles
    if (valueRange <= 100) {
        step = 0.1;
    } else if (valueRange > 100 && valueRange <= 1000) {
        step = 1;
    } else if (valueRange > 1000 && valueRange <= 10000) {
        step = 5;
    } else if (valueRange > 10000) {
        step = 10;
    }

    psearchSliderValues[paramName] = getSliderValuesArray(min, max, step);

    psearchDebug ? console.log("obtainSliderValues() finish - paramName: " + paramName + " step: " + step) : "";

}

function findSliderArrayIndex(psearchSliderValueArray, number) {
    var indexes = $.map(psearchSliderValueArray, function(obj, index) {
        if(obj == number) {
            return index;
        }
    });

    return indexes[0];
}

function findNearerSliderArrayIndex(psearchSliderValueArray, number) {
    psearchDebug ? console.log("findNearerSliderArrayIndex() - number: " + number + " array: " + psearchSliderValueArray) : "";

    var index = 0;

    if (number > psearchSliderValueArray[psearchSliderValueArray.length - 1]) {
        index = psearchSliderValueArray.length - 1;
    }

    if (number >= psearchSliderValueArray[0] && number <= psearchSliderValueArray[psearchSliderValueArray.length - 1]) {
        for (var i = 0; i < psearchSliderValueArray.length; i++) {
            if (psearchSliderValueArray[i] == number) {
                index = i;
                break;
            } else if (psearchSliderValueArray[i] > number) {
                if (psearchSliderValueArray[i] - number < number - psearchSliderValueArray[i - 1]) {
                    index = i;
                } else {
                    index = i - 1;
                }

                break;
            }
        }
    }

    psearchDebug ? console.log("findNearerSliderArrayIndex() - index: " + index) : "";

    return index;
}

function maxInputSlider(element) {
    psearchDebug ? console.log("maxInputSlider()") : "";

    var paramName = element.attr('id').split("-val-max")[0];

    var valMax = findSliderArrayIndex(psearchSliderValues[paramName], Number(element.val().split(" ")[0].replace(",", ".")));
    var maxDefault = Number(element.attr('data-max'));
    var valMin = findSliderArrayIndex(psearchSliderValues[paramName], Number($("#" + paramName + "-val-min").val().split(" ")[0]));

    if (valMax <= maxDefault && valMax >= valMin) {
        setSliderValues(paramName, valMin, valMax);
    } else {
        setSliderValues(paramName, valMin, maxDefault);
    }
}

function minInputSlider(element) {
    psearchDebug ? console.log("minInputSlider()") : "";
    var paramName = element.attr('id').split("-val-min")[0];
    var valMin = findSliderArrayIndex(psearchSliderValues[paramName], Number(element.val().split(" ")[0].replace(",", ".")));
    var minDefault = Number(element.attr('data-min'));
    var valMax = findSliderArrayIndex(psearchSliderValues[paramName], Number($("#" + paramName + "-val-max").val().split(" ")[0]));

    if (valMin >= minDefault && valMin <= valMax) {
        setSliderValues(paramName, valMin, valMax);
    } else {
        setSliderValues(paramName, minDefault, valMax);
    }
}

function setSliderValues(paramName, valMin, valMax) {
    psearchDebug ? console.log("setSliderValues() - paramName: " + paramName + " valMin: " + valMin + " valMax: " + valMax) : "";

    var valMinDomElement = $("#" + paramName + "-val-min");
    var valMaxDomElement = $("#" + paramName + "-val-max");

    var sliderElement = $("#" + paramName + "-slider");

    sliderElement.slider("values", [valMin, valMax]);

    valMinDomElement.val(psearchSliderValues[paramName][valMin] + " " + sliderElement.attr("data-uom"));
    valMaxDomElement.val(psearchSliderValues[paramName][valMax]  + " " + sliderElement.attr("data-uom"));
    valMinDomElement.attr("data-selected", psearchSliderValues[paramName][valMin]);
    valMaxDomElement.attr("data-selected", psearchSliderValues[paramName][valMax]);
}

function updateMultiValues(paramName, value) {
    var fromElementValue = Number($("#" + paramName + "-from").val());
    var toElementValue = Number($("#" + paramName + "-to").val());

    if (fromElementValue == -1 || fromElementValue > value) {
        $("#" + paramName + "-from").val(value);
        $("#" + paramName + "-from").attr("data-value", value);
    }
    if (toElementValue == -1 || toElementValue < value) {
        $("#" + paramName + "-to").val(value);
        $("#" + paramName + "-to").attr("data-value", value);
    }
}

function initButtons() {
    $(".reset").unbind('click').bind('click', function () {
        psearchReset = true;
        $(".bloque-formu").each(function (index, element) {

            var paramName = $(this).attr("id");
            if (paramName) {
                if (paramName.indexOf("select") > -1) {
                    $(this).find("input:checked").each(function (index, element) {
                        $(this).prop('checked', false);
                    });
                    $(this).find("select").each(function (index, element) {
                        $("#" + paramName + "-select").val(-1);
                        $("#" + paramName + "-select").attr("data-value", -1);
                    });
                } else if (paramName.indexOf("multi") > -1) {
                    $("#" + paramName + "-from").val(-1);
                    $("#" + paramName + "-from").attr("data-value", -1);
                    $("#" + paramName + "-to").val(-1);
                    $("#" + paramName + "-to").attr("data-value", -1);
                } else if (paramName.indexOf("inrange") > -1) {
                    var valMin = $("#" + paramName + "-val-min").attr("data-min");
                    var valMax = $("#" + paramName + "-val-max").attr("data-max");

                    setSliderValues(paramName, valMin, valMax);
                }
            }
        });

        makeSearch();

    });

    if (psearchShowSearchButton) {
        $(".search").unbind('click').bind('click', function () {
            makeSearch();
        });
    }


}

function initFormValues() {
    var queryParams = getQueryParamsFromUrl();

    for (var param in queryParams) {
        psearchDebug ? console.log(param) : "";
        $(".bloque-formu").each(function (index, element) {
            var paramName = $(this).attr("id");
            if (param.indexOf(paramName) > -1) {
                if (paramName.indexOf("select") > -1) {
                    $(this).find("input").filter(function() {
                        return this.value == queryParams[param];
                    }).each(function (index, element) {
                        $(this).prop('checked', true);
                    });

                    $(this).find("option").filter(function() {
                        return this.value == queryParams[param];
                    }).each(function (index, element) {
                        $(this).attr('selected', true);
                    });

                } else if (paramName.indexOf("multi") > -1) {
                    var value = Number(queryParams[param]);
                    updateMultiValues(paramName, value);
                } else if (paramName.indexOf("inrange") > -1) {
                    var values = queryParams[param].split(",");
                    setSliderValues(paramName, findSliderArrayIndex(psearchSliderValues[paramName], values[0]), findSliderArrayIndex(psearchSliderValues[paramName], values[1]));
                }
            }
        });
    }

    // makeSearch();
}

function getQueryParamsFromUrl() {
    var match,
        pl = /\+/g,  // Regex for replacing addition symbol with a space
        search = /([^&=]+)=?([^&]*)/g,
        decode = function (s) {
            return decodeURIComponent(s.replace(pl, " "));
        },
        query = window.location.hash;

    var urlParams = {};
    var i = 0;
    while (match = search.exec(query)) {
        urlParams[decode(match[1]) + "_" + i] = decode(match[2]);
        i++;
    }

    return urlParams;

}

function makeSearch() {
    makeFilteredSearch(undefined);
}

function makeFilteredSearch(changedFilter) {
    showLoading();
    ssi_columns = "";
    enableDefaultFormOptions();
    var query = getQueryStringFromForm();
    psearchDebug ? console.log("Query string: " + query[0]) : "";

    // FIXME: How to do with current ajax call?
    // if (psearchAjaxRequest != undefined) {
    //     psearchAjaxRequest.abort();
    // }
    if (query[0] != "") {
        currentXRodChoice = "";
        if ($("#xRodFormArea") !== undefined){
            $("#xRodFormArea").hide();
        }
        getSearchResults(query[0], changedFilter);
    } else {
        showAllResults();
        // enableDefaultFormOptions();
        hideLoading();
        hideSearching();
        psearchReset = false;
    }
    location.hash = "s" + query[1];
    removeSelectParamsFromURL();
}

function removeSelectParamsFromURL(){
    var url = new URL(window.location.href);
    $(".select2-series").each(function(){
        var currId = this.id;
        currId = currId.replace("-select","");
        url = removeParam(currId,url);
    });
    window.history.pushState({}, window.document.title, url.toString());
}

function removeParam(key, sourceURL) {
    var rtn = sourceURL.toString().split("#s")[0],
        param,
        params_arr = [],
        queryString = (sourceURL.toString().indexOf("#s") !== -1) ? sourceURL.toString().split("#s")[1] : "";
    if (queryString !== "") {
        params_arr = queryString.split("&");
        var found = false;
        for (var i = params_arr.length - 1; i >= 0; i -= 1) {
            param = params_arr[i].split("=")[0];
            if (param === key) {
                params_arr.splice(i, 1);
                found = true;
            }
        }
        if (params_arr.length > 0 &&  params_arr.join("&") !== "" &&  params_arr.join("&") !== "&" ){
            rtn = rtn + "#s" + params_arr.join("&");
        }
    }
    return rtn;
}


function encodeParam(value) {
    var encodedValue = encodeURI(value);
    if (encodedValue.indexOf("%E2%80%9D")) {
        return encodedValue.replace("%E2%80%9D", "%22");
    } else {
        return encodedValue
    }
}

function restoreSelectValues(currentSelect){
    $(".select2-series option").each(function (){
        if(/*$(this).parent() !== currentSelect && */$(this).parent().val() === $(this).val() &&  !$(this).hasClass("invalid-option")){
            $(this).removeAttr("disabled");
            $(this).removeClass("invalid-option");
        }
    });
}

function updateSelectValues(){
    var deferred = $.Deferred();
    $(".select2-series").each(function(){
        $("#"+this.id+" .invalid-option").each(function(){
            $(this).removeClass("invalid-option");
        });
    });
    $("#smc-psearch .select2-selection__rendered").each(function (index, element) {
        var paramId = this.id.replace("select2-","").replace("-container","");
        var paramValue = $(this).text();
        var equivalentSelect = $("#"+paramId);
        $("#"+paramId+" option").each(function(){
            if (this.value === paramValue){
                $(this).attr("selected","true");
            }
        });
    });
    return deferred.resolve(true);
}

function getQueryStringFromForm() {
    var queryString = "";
    var noEncodequeryString ="";

    $(".bloque-formu").each(function (index, element) {
        var paramName = $(this).attr("id");
        if (paramName) {
            if (paramName.indexOf("select") > -1) {
                $(this).find("input:checked").each(function (index, element) {
                    queryString = queryString + "&" + paramName + "[]=" + encodeParam($(this).val());
                    noEncodequeryString = noEncodequeryString + "&" + paramName + "[]=" + $(this).val();
                });
                $(this).find("select").each(function (index, element) {
                    if ($(this).val() != undefined && $(this).val() != "" && $(this).val() != "-1") {
                        queryString = queryString + "&" + paramName + "=" + encodeParam($(this).val());
                        noEncodequeryString = noEncodequeryString + "&" + paramName + "=" + $(this).val();
                    }else {
                        var defaultOption = "";
                        $("#"+this.id+" option").each(function(){
                            if (this.value === "-1"){
                                defaultOption = $(this).text();
                            }
                        });
                        var spannedRelatedOption = $("#select2-"+this.id+"-container").text();
                        var selected = $("#"+this.id+" option:selected");
                        if (selected !== undefined && selected !== "" && selected !== spannedRelatedOption && spannedRelatedOption !== defaultOption){
                            queryString = queryString + "&" + paramName + "=" + encodeParam(spannedRelatedOption);
                            noEncodequeryString = noEncodequeryString + "&" + paramName + "=" + spannedRelatedOption;
                        }
                    }
                });
            } else if (paramName.indexOf("multi") > -1) {
                var fromElement = $("#" + paramName + "-from");
                var fromElementOptions = fromElement.find("option");
                var toElement = $("#" + paramName + "-to");
                var fromValue = Number(fromElement.val());
                var toValue = Number(toElement.val());

                fromValue = calculateFormToValue(fromValue, fromElement.val());
                toValue = calculateFormToValue(toValue, toElement.val());
                var value;
                // if (fromValue > -1 && toValue > -1) {
                //   fromElementOptions.each(function (index, element) {
                //     value = "";
                //     value = Number(calculateFormToValue(value, $(this).val()));
                //     if (value >= fromValue && value <= toValue) {
                //       queryString = queryString + "&" + paramName + "[]=" + encodeURI($(this).val());
                //       noEncodequeryString = noEncodequeryString + "&" + paramName + "[]=" + $(this).val();
                //     }
                //   });
                // } else if (fromValue > -1 && toValue == -1) {
                //   // From 'from' to max
                //   fromElementOptions.each(function (index, element) {
                //     value = "";
                //     value = Number(calculateFormToValue(value, $(this).val()));
                //     if (value >= fromValue) {
                //       queryString = queryString + "&" + paramName + "[]=" + encodeURI($(this).val());
                //       noEncodequeryString = noEncodequeryString + "&" + paramName + "[]=" + $(this).val();
                //     }
                //   });
                // } else if (fromValue == -1 && toValue > -1) {
                //   // From 'to' to min
                //   fromElementOptions.each(function (index, element) {
                //     value = "";
                //     value = Number(calculateFormToValue(value, $(this).val()));
                //     if (value <= toValue && value != -1) {
                //       queryString = queryString + "&" + paramName + "[]=" + encodeURI($(this).val());
                //       noEncodequeryString = noEncodequeryString + "&" + paramName + "[]=" +$(this).val();
                //     }
                //   });
                // }
                var find = false;
                // if (isNaN(fromValue) || isNaN(toValue)) {
                fromElementOptions.each(function (index, element) {
                    if ($(this).val() == fromElement.val()) {
                        find = true;
                    }
                    if($(this).val() == toElement.val()) {
                        find = false;
                    }
                    if ((find || toElement[0].selectedIndex == index)&& $(this).val() != -1 ) {
                        queryString = queryString + "&" + paramName + "[]=" + encodeParam($(this).val());
                        noEncodequeryString = noEncodequeryString + "&" + paramName + "[]=" + $(this).val();
                    }

                });
                // }

            } else if (paramName.indexOf("inrange") > -1) {
                var values = $("#" + paramName + "-slider").slider("option", "values");

                if (values[0] > $(this).find("input.val-min").attr("data-min") || values[1] < $(this).find("input.val-max").attr("data-max")) {
                    $("#" + paramName + "-slider > .ui-slider-handle").addClass("value-selected");

                    queryString = queryString + "&" + paramName + "=" + psearchSliderValues[paramName][values[0]] + "," + psearchSliderValues[paramName][values[1]];
                    noEncodequeryString = noEncodequeryString + "&" + paramName + "=" + psearchSliderValues[paramName][values[0]] + "," + psearchSliderValues[paramName][values[1]];
                } else {
                    $("#" + paramName + "-slider > .ui-slider-handle").removeClass("value-selected");
                }
            }
        }
    });

    return [queryString, noEncodequeryString];
}

function enableDefaultFormOptions() {
    // Default selects
    $("label.disabled[data-default=enabled]").removeClass("disabled");
    $("input:disabled[data-default=enabled]").attr("disabled", false);
    $("option:disabled[data-default=enabled]").attr("disabled", false);
    // $("input:disabled[data-default=enabled]").enable();
    // $("option:disabled[data-default=enabled]").enable();

    // Default sliders
    $(".bloque-formu").each(function (index, element) {
        var paramName = $(this).attr("id");
        if (paramName && paramName.indexOf("inrange") > -1) {
            if ($(this).find(".val-min").attr("data-min") != $(this).find(".val-min").attr("data-min-default") ||
                $(this).find(".val-max").attr("data-max") != $(this).find(".val-max").attr("data-max-default")) {
                reinitSlider($(this).attr("id"), $(this).find(".val-min").attr("data-min-default"), $(this).find(".val-max").attr("data-max-default"));
            }
        }
    });

    // Default multis
    $(".bloque-formu").each(function (index, element) {
        var paramName = $(this).attr("id");

        if (paramName && paramName.indexOf("multi") > -1) {
            configureMulti($(this).attr("id"), psearchMultiDefaultValues[$(this).attr("id")]);
        }
    });

}

function getSearchResults(query, changedFilter) {
    if (psearchReset) return;
    showSearching();
    query = query.replace(new RegExp("%C2","g"),"");
    query = query.replace(new RegExp('\\+',"g"),"%2B");
    var params = {};
    //http://localhost:8080/search/PS_ISO_CYLINDERS/ACT_EU+NODE_133464?select_3604785[]=ISO6431&select_3604785[]=ISO6432
    var endpoint = "";
    if (psearchChildrenType == "PRODUCT") {
        endpoint = psearchApiDomain + 'search/' + psearchAttrSet + '/' + psearchUnderFolder.replace("/", "+") + "?" + "ts=" + new Date().getTime() + "&" + query;
    } else {
        endpoint = psearchApiDomain + 'search/' + psearchAttrSet + '/' + psearchUnderFolder.replace("/", "+") + "/parents?" + "ts=" + new Date().getTime() + "&" + query;
    }
    //FIXME internet explorer url Ã‚Â± error, no escapa los caracteres | encodeURIComponent(str);
    //select_3998123[]=Ãƒâ€šÃ‚Â±0.01 Ãƒâ€šÃ‚Â°C

    var data = {
        attrset: psearchAttrSet,
        underfolder: psearchUnderFolder.replace("/", "+"),
        queryString: "&ts=" + new Date().getTime() + "&" + query
    };

    psearchDebug ? console.log("Search Children Type: " + psearchChildrenType) : "";
    psearchDebug ? console.log("Search: " + endpoint) : "";


    psearchAjaxRequest = $.getJSON(smc.psearchurls.getPSearchResult, data).then(function (data) {
        psearchDebug ? console.debug('[getPSearchResult]', data) : "";
        psearchDebug ? console.log(data) : "";
        $('.psearch-no-results').hide();
        if (data != null && data.resultIds != null) {
            var resultIds = data.resultIds;
            var currProductId = window.location.search.split("=")[1];
            if (currProductId !== undefined && currProductId.indexOf("&") > 0){
                currProductId = currProductId.split("&")[0];
            }
            var redirectIsNeeded = resultIds.length === 1 && currProductId !== resultIds[0];
            if (redirectIsNeeded) {
                //window.location.href = window.location.protocol + "//" + window.location.host + window.location.pathname + '?productId=' + resultIds[0];
                $("#productConfiguratorContainer").hide();
                $(".builder").hide();
                $("#rodEndOptionsSwitchToggle").attr("disabled",true);
                restartSelects(this);
                loadProduct(resultIds[0], "");
            }

            psearchDebug ? console.log(resultIds) : "";
            // Show matching results
            $(".dc_product").hide();
            if (resultIds != undefined && resultIds.length > 0) {
                resultIds.forEach(function (productId) {
                    var $product = $("#" + productId);
                    if (!$product.length) return;

                    var originalHref = $product.data('href');
                    var url = [originalHref, '#', query].join('');

                    $('.category-tile__image > a', $product).attr('href', url);
                    $('.category-tile__text > a', $product).attr('href', url);


                    var $children = $(".dc_product_children");
                    if ($children.length > 0) {
                        $product = $(".dc_product_children#" + productId);
                    }

                    $product.show();
                });

                if (psearchUnusedSearch == true && data.unused != null) {
                    processUnused(data, changedFilter);
                }
            } else {
                $('.psearch-no-results').show();
            }
        } else {
            // Show all results
            showAllResults();
        }
        $(".series-loading-container").html("");
        hideSearching();
        hideLoading();
    });
}

function reinitSlider(name, min, max) {
    psearchDebug ? console.log("reinitSlider() - name: " + name + " min: " + min + " max: " + max) : "";

    obtainSliderValues(name, min, max);

    var minIndex = 0;

    var slider = $("#" + name + "-slider");

    var minInput = $("#" + name).find("input.val-min");
    var previousMin = Number(minInput.attr("data-min"));
    var maxInput = $("#" + name).find("input.val-max");
    var previousMax = Number(maxInput.attr("data-max"));

    var sliderMinVal = Number(slider.slider("option", "values")[0]);
    var sliderMaxVal = Number(slider.slider("option", "values")[1]);

    var selectedMin = Number(minInput.attr("data-selected"));
    var selectedMax = Number(maxInput.attr("data-selected"));

    psearchDebug ? console.log("reinitSlider() - previousMin: " + previousMin + " previousMax: " + previousMax + " sliderMinVal: " + sliderMinVal + " sliderMaxVal: " + sliderMaxVal + " selectedMin: " + selectedMin + " selectedMax: " + selectedMax) : "";

    if (sliderMinVal === previousMin || selectedMin < psearchSliderValues[name][0]) {
        sliderMinVal = 0;
    } else {
        sliderMinVal = findNearerSliderArrayIndex(psearchSliderValues[name], selectedMin);
    }

    if (sliderMaxVal === previousMax || selectedMax > psearchSliderValues[name][psearchSliderValues[name].length - 1]) {
        sliderMaxVal = psearchSliderValues[name].length - 1;
    } else {
        sliderMaxVal = findNearerSliderArrayIndex(psearchSliderValues[name], selectedMax);
    }
    // if (sliderMinVal === previousMin) {
    //   sliderMinVal = 0;
    // }
    //
    // if (sliderMaxVal === previousMax) {
    //   sliderMaxVal = psearchSliderValues[name].length - 1;
    // } else {
    //   FIXME: Cargar valor mas cercano al valor representado anteriormente
    // sliderMaxVal = psearchSliderValues[name].length - 1;
    // }

    minInput.attr("data-min", 0);
    maxInput.attr("data-max", psearchSliderValues[name].length - 1);
    // $("#" + name).find("input.val-min").attr("data-min", min);
    // $("#" + name).find("input.val-max").attr("data-max", max);

    slider.slider().unbind('slidechange');

    psearchDebug ? console.log("reinitSlider() - sliderMinVal: " + sliderMinVal + " sliderMaxVal: " + sliderMaxVal) : "";

    initSliderValues(name, Number(min), Number(max));
    setSliderValues(name, sliderMinVal, sliderMaxVal);

    $("#" + name + "-slider").slider().unbind('slidechange').bind('slidechange', function () {
        if (!psearchShowSearchButton) {
            makeSearch();
            removeSelectParamsFromURL();
        }
    });
}

function getProductListHtml(data, psearchDataContainers, psearchDataContainersOrder) {
    var resultsHTML = "";
    var resultsAdded = 0;
    var idsAdded = [];
    var isAdded = false;

    psearchDataContainersOrder.forEach(function (dataContainerElementId) {
        data.forEach(function (productId) {
            isAdded = false;
            if (productId == dataContainerElementId) {

                idsAdded.forEach(function(element) {
                    if(element === dataContainerElementId){
                        isAdded = true;
                    }
                });

                if(!isAdded){
                    if (resultsAdded % 3 == 0 && resultsAdded > 0) {
                        resultsHTML = resultsHTML + "</div>";
                    }

                    if (resultsAdded % 3 == 0) {
                        resultsHTML = resultsHTML + "<div class=\"dc_rowContainer\">";
                    }

                    resultsHTML = resultsHTML + "<div id=\"" + dataContainerElementId + "\" class=\"dc_dataContainer\" style=\"width: 33%\">";
                    resultsHTML = resultsHTML + psearchDataContainers[dataContainerElementId].html();
                    resultsHTML = resultsHTML + "</div>";

                    resultsAdded++;
                    idsAdded.push(dataContainerElementId);

                    if (resultsAdded % 3 == 0) {
                        resultsHTML = resultsHTML + "</div>";
                    }
                }

            }
        });
    });

    if (resultsAdded > 0 && resultsAdded % 3 != 0) {
        resultsHTML = resultsHTML + "</div>";
    }

    return resultsHTML;
}
function getResultsElement(data) {
    var resultsHTML = "";
    if (data != undefined) {
        if (data.length > 0) {
            if (getQueryStringFromForm()[0] == "") {
                resultsHTML = getProductListHtml(data, psearchDataContainers, psearchDataContainersOrder);
            } else {
                if (psearchDescriptionDataContainersOrder.length > 0) {
                    resultsHTML = getProductListHtml(data, psearchDescriptionDataContainers, psearchDescriptionDataContainersOrder);
                } else {
                    resultsHTML = getProductListHtml(data, psearchDataContainers, psearchDataContainersOrder);

                }
            }


        } else {
            resultsHTML = resultsHTML + "<div class=\"dc_rowContainer psearch-no-results\" style=\"width: 100%\">";
            resultsHTML = resultsHTML + "<img src=\"" + psearchNoResultsImageUrl + "\"/>";
            resultsHTML = resultsHTML + "<span>" + i18nPSearch["70_lbl_002"] + "</span>";
            resultsHTML = resultsHTML + "</div>";

        }
    }

    return resultsHTML;
}

function showAllResults() {
    var $results = $(".dc_product");
    var $children = $(".dc_product_children");
    _resetAllLinks($results);
    $results.show();
    $children.hide();
    $('.psearch-no-results').hide();
}

function _resetAllLinks($results) {
    $results.each(function (i, product) {
        var $product = $(product);

        var originalHref = $product.data('href');
        $('.category-tile__image > a', $product).attr('href', originalHref);
        $('.category-tile__text > a', $product).attr('href', originalHref);
    });
}

function getSearchingSpinner() {
    return document.getElementById('spinner-template').innerHTML;
}

function updateLinks() {
    var query = getQueryStringFromForm()[1];
    if (query != "") {
        $(".dc_productName a").each(function () {
            $(this).attr("href", $(this).attr("href") + "#" + query)

        });
        $(".dc_product a").each(function () {
            $(this).attr("href", $(this).attr("href") + "#" + query)
        });

        $('div[name="dc_product"] a').each(function () {
            $(this).attr("href", $(this).attr("href") + "#" + query)

        });
    }
}

function processUnused(data, changedFilter) {
    psearchDebug ? console.log(data.unused) : "";

    enableDefaultFormOptions();

    data.unused.forEach(function (unusedElement) {

        var paramName = unusedElement.name;
        if (changedFilter !== undefined && paramName+"-select" === changedFilter){
            return;
        }
        if (unusedElement.type == "range") {

            var previousMin = $("#" + paramName).find("input.val-min").attr("data-min");
            var previousMax = $("#" + paramName).find("input.val-max").attr("data-max");

            var newMin = unusedElement.usedMin;
            var newMax = unusedElement.usedMax;

            obtainSliderValues(paramName, newMin, newMax);

            var newMinIndex = findSliderArrayIndex(psearchSliderValues[paramName], newMin);
            var newMaxIndex = findSliderArrayIndex(psearchSliderValues[paramName], newMax);

            psearchDebug ? console.log("processUnused() range - paramName: " + paramName + " previousMin: " + previousMin + " previousMax: " + previousMax + " newMinIndex: " + newMinIndex + " newMaxIndex: " + newMaxIndex) : "";

            if (previousMin != newMinIndex || previousMax != newMaxIndex ) {
                reinitSlider(paramName, newMin, newMax);
            }

        } else {
            if (paramName.indexOf("multi") > -1) {
                var usedValues = getUsedValuesFromUnusedForMulti(paramName, unusedElement.options);
                // configureMulti(unusedElement.name, usedValues);
            } else if (paramName.indexOf("select") > -1) {
                $("#" + paramName + " input").each(function (index, element) {
                    var that = $(this);

                    unusedElement.options.forEach(function (unusedValue) {
                        if (that.attr('value') == unusedValue) {
                            that.attr('disabled', true);
                            that.addClass('invalid-option');
                        }
                    });
                });

                $("#" + paramName + " label").each(function (index, element) {
                    var that = $(this);

                    unusedElement.options.forEach(function (unusedValue) {
                        if (that.attr('value') == unusedValue) {
                            that.addClass('disabled');
                            that.addClass('invalid-option');
                        }
                    });
                });

                $("#" + paramName + " option").each(function (index, element) {
                    var that = $(this);

                    unusedElement.options.forEach(function (unusedValue) {
                        if (that.attr('value') == unusedValue) {
                            that.attr('disabled', true);
                            that.addClass('invalid-option');
                        }
                    });
                });
            }
        }

    });
}

function getUsedValuesFromUnusedForMulti(name, values) {
    var allValues = psearchMultiDefaultValues[name];

    var usedValues = [];
    if (allValues != undefined) {
        $.each(allValues, function (index, allValue) {
            var defaultKey = allValue.split(',')[0];
            var unused = false;
            $.each(values, function (index, value) {
                if (value == defaultKey) {
                    unused = true;
                }
            });

            if (unused == false) {
                usedValues.push(allValue);
            }
        });
    }

    return usedValues;
}

function configureMulti(name, values) {
    var from = $("#" + name + "-from").attr("data-value");
    var to = $("#" + name + "-to").attr("data-value");

    psearchDebug ? console.log("ConfigureMulti - From: " + from + " To: " + to + " Values: " + values) : "";

    if (values && values.length > 0) {
        $("#" + name + "-from").unbind('change');
        $("#" + name + "-to").unbind('change');

        $("#" + name + "-from").html(getSelectOptionsForMulti(values, i18nPSearch["70_lbl_007"]));
        $("#" + name + "-to").html(getSelectOptionsForMulti(values, i18nPSearch["70_lbl_007"]));

        $("#" + name + "-from").val(from);
        $("#" + name + "-to").val(to);

        initFromTo(name);
    }
}

function setEqualHeightsForProducts(){
    var row_max_height = 0;
    $(".dc_product").each(function(element) {
        row_max_height = $(this).height() > row_max_height ? $(this).height() : row_max_height;
    });

    var final_height = row_max_height + 10 > 200 ? row_max_height + 10 : 200;
    $(".dc_product").height(final_height);

}

function replaceUrlParam(url, paramName, paramValue)
{
    if (paramValue == null) {
        paramValue = '';
    }
    var pattern = new RegExp('\\b('+paramName+'=).*?(&|#|$)');
    if (url.search(pattern)>=0) {
        return url.replace(pattern,'$1' + paramValue + '$2');
    }
    url = url.replace(/[?#]$/,'');
    return url + (url.indexOf('?')>0 ? '&' : '?') + paramName + '=' + paramValue;
}

function loadProduct(productId, partNumber) {
    disableEveryFilter();
    $("#productconfigurator-component__section").html(getSearchingSpinner());
    var urlString = window.location.protocol + "//" + window.location.host + window.location.pathname + '?productId=' + productId;
    window.history.pushState({}, window.document.title, urlString);

    smc.psearchurls.getProductConfiguratorComponent = replaceUrlParam(smc.psearchurls.getProductConfiguratorComponent, "productId", productId);
    smc.psearchurls.getProductConfiguratorComponent = replaceUrlParam(smc.psearchurls.getProductConfiguratorComponent, "partNumber", partNumber);

    // Get ajax product configurator
    $.get(smc.psearchurls.getProductConfiguratorComponent).then(function (data) {
        resetConfiguratorStatus();

        $("#productconfigurator-component__section").html(data);
        $(".series-loading-container").html("");

        setTimeout(function(){
            $('#free_configuration').show();
            if ($(".loading-container-ssi-js") !== undefined){
                $(".loading-container-ssi-js").empty();
            }
            $('#free_configuration_trigger').click();
            $("#productConfiguratorContainer").show();
            $('#free_configuration').css("display","");
            $("#rodEndOptionsSwitchToggle").attr("disabled",true);
            if ($("#rodEndOptionsSwitchToggle").is(":checked")){
                $(".builder").attr("style","");
                $(".project-alert-container").removeClass("hidden");
                $("#project-section").removeClass("hidden");
                $("#project-section-buttons").removeClass("hidden");
            }
        },1000);
    });
}

function resetConfiguratorStatus() {
    delete window.smc.pc;
    delete window.smc.projectInformationModule;
    delete window.smc.ssiAllPartNumbers;
    delete window.smc.standardStockedItemsComponent;
    delete window.smc.productConfiguratorComponent;
    delete window.smc.productPageController;
}