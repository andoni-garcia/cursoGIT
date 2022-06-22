var psearchDebug = true;
var psearchShowSearchButton = false;
var psearchUnusedSearch = true;

var npSearchFormOrder = {
    "SERIEINFO": [6, 5, 4, 3, 2, 1, 0]
};

var psearchAjaxRequest;

var psearchMultiDefaultValues = {};

var selectAsCombo = true;

// Resources

var npSearchAttrSet = "SERIEINFO";
var npStatusKey = "boolean_2883911";
var npInternalStatusKey = "boolean_2883947";

var npFamiliesKey = "select_2883959";
var npIndustriesKey = "select_2883960";
var npDateKey = "datemin_2883958,max_2883958";
var npSerieKey = "select_2883792";

var searchParamsBoxName = "#np_search";

var newProductsListViewModel;

var psearchLanguage = "en";

var seriesIndexUrl ="";
// var currentUrl = "${currentUrl?string}";
if (currentUrl !== undefined){
    currentUrl+"?limit=10&sort=index&sortDir=asc&page=1";
}

$(document).ready(function () {
    showNPSearchIfPresent();

    if ($("#np_search")) {
        getSearchForm(npSearchAttrSet)
    }

    // if (isSeriesIndex){
    //     $("#search-type").val(npSerieKey).change();
    //     $("#SerieIndexElement").show();
    // }

    // if ($("#search-type").val() != "-1") {
    //     if ($(this).val() === npSerieKey) {
    //         $("#SerieIndexElement").show();
    //         //$("#SerieIndexShowAll").show();
    //         $(".reset").val(smc.newproducts.messages["newproducts.showall"]);
    //         $("#emptyDiv").hide();
    //     } else {
    //         $("#" + $(this).val()).show();
    //         $(".reset").val(smc.newproducts.messages["psearch.restart"]);
    //         $("#emptyDiv").hide();
    //     }
    // }

    $('.product-toolbar-title-js').on('click', function(e){
        e.stopPropagation();
        var current = $(this).next('.product-toolbar-content-js');
        $('.product-toolbar-item .product-toolbar-content-js.opened').not(current).removeClass('opened').hide();
    });
});


function addSearchingSpinner() {
    $(".dc_products").append(getSearchingSpinner());
}

function showNPSearchIfPresent() {
    if ($("#np_search")) {
        $("#np_search").show();
        initializePSearchDropdown();
    }
}

function getSearchForm(attrSet) {
    var data;
    if (formJson) {
        data = JSON.parse(formJson);
        psearchDebug ? console.debug('[getPSearchForm] From server', data) : "";
        printSearchTypes(data);
        printSearchForm(data);
        $(".bloque-formu").hide();
        $(".bloque-formu > label").hide();
        $(".botonera").show();
        initFormValues();

    } else {
        data = {
            lang: psearchLanguage,
            attrset: attrSet,
            underfolder: ""
        };

        $.getJSON(smc.psearchurls.getPSearchForm, data).then(function (data) {
            psearchDebug ? console.debug('[getPSearchForm]', data) : "";
            printSearchTypes(data);
            printSearchForm(data);
            $(".bloque-formu").hide();
            $(".bloque-formu > label").hide();
            $(".botonera").show();
            initFormValues();

        });
    }
}

function printSearchTypes(data) {
    var formElements = data.searchattformresult.extraformdata;

    var values = [];

    if (npSearchAttrSet in npSearchFormOrder && npSearchFormOrder[npSearchAttrSet].length == formElements.length) {
        $.each(npSearchFormOrder[npSearchAttrSet], function (index, value) {
            var formElement = formElements[value];
            if (formElement.formname === npDateKey) {
                values.push(formElement.formname.replace(",", "-") + "," + smc.newproducts.messages["newproducts.date"]); // Date
            } else if (formElement.formname == npSerieKey) {
                values.push(formElement.formname + "," + smc.newproducts.messages["newproducts.seriesindex"]); // Series Index
            } else if (formElement.formname == npFamiliesKey) {
                values.push(formElement.formname + "," + smc.newproducts.messages["newproducts.family"]); // Family
            } else if (formElement.formname == npIndustriesKey) {
                values.push(formElement.formname + "," + smc.newproducts.messages["newproducts.industry"]); // Industry
            }
        });
    } else {
        $.each(formElements, function (index, element) {
            if (element.formname === npDateKey) {
                values.push(element.formname.replace(",", "-") + "," + smc.newproducts.messages["newproducts.date"]); // Date
            } else if (element.formname == npSerieKey) {
                values.push(element.formname + "," + smc.newproducts.messages["newproducts.seriesindex"]); // Series Index
            } else if (element.formname == npFamiliesKey) {
                values.push(element.formname + "," + smc.newproducts.messages["newproducts.family"]); // Family
            } else if (element.formname == npIndustriesKey) {
                values.push(element.formname + "," + smc.newproducts.messages["newproducts.industry"]); // Industry
            }
        });
    }

    var searchTypeHTML = "";
    searchTypeHTML = searchTypeHTML + "<select id=\"search-type\" class=\"form-control query filter-spacing\" data-value=\"-1\">";
    searchTypeHTML = searchTypeHTML + getSelectOptionsForMulti(values, smc.newproducts.messages["newproducts.selectoption"]); // Select option...
    searchTypeHTML = searchTypeHTML + "</select>";
    searchTypeHTML = searchTypeHTML + "</div>";
    searchTypeHTML = searchTypeHTML + "</div>";
    $("#searchNPType").html(searchTypeHTML);

    $("#search-type").unbind("change").bind("change", function () {
        restartForm();
        $(".bloque-formu").hide();
        $(".botonera").show();
        if ($(this).val() != "-1") {
            if ($(this).val() === npSerieKey) {

                $("#SerieIndexElement").show();
                $("#resetButton").val(smc.newproducts.messages["newproducts.showall"]);
                $("#emptyDiv").hide();
                // if(!isSeriesIndex) {
                //     window.location.href = seriesIndexUrl;
                // }
            } else {
                $("#" + $(this).val()).show();
                $("#resetButton").val(smc.newproducts.messages["newproducts.restart"]);
                $("#emptyDiv").hide();
                // if(isSeriesIndex) {
                //     window.location.href = currentUrl;
                // }
            }
        } else {
            $("#resetButton").val(smc.newproducts.messages["newproducts.restart"]);
            $("#emptyDiv").show();
            // if(isSeriesIndex) {
            //     window.location.href = currentUrl;
            // }
        }
    });

}

function printSearchForm(data) {
    var formElements = data.searchattformresult.extraformdata;
    var attDefinitions = data.attdefinitions;

    psearchDebug ? console.log(formElements) : "";

    // Contenedor que impide pulsar sobre cualquier opciÃ³n mientras se realiza una bÃºsqueda
    $(searchParamsBoxName).append("<div class=\"psearch-searching-container\"></div>");

    $.each(formElements, function (index, element) {
        var elementInfo = attDefinitions[index];
        printElement(element, elementInfo);
    });

    // var buttonsHTML = getButtonsElement();
    // $(searchParamsBoxName).append(buttonsHTML);

    initButtons();
}

function printElement(element, elementInfo) {
    var elementHTML = "";

    if (element.formtype == "dropdown") {
        if (element.formname.indexOf("select") > -1) {
            if (element.formname.indexOf(npSerieKey) > -1) {
                elementHTML = getSerieIndexFormElement(element, elementInfo);
                elementHTML = elementHTML + getSelectComboFormElement(element, elementInfo);
            } else {
                if (selectAsCombo) {
                    elementHTML = getSelectComboFormElement(element, elementInfo);
                } else {
                    elementHTML = getSelectFormElement(element, elementInfo);
                }
            }
        } else if (element.formname.indexOf("multi") > -1) {
            elementHTML = getMultiFormElement(element, elementInfo);
        }
    } else if (element.formtype == "range") {
        if (element.formname.indexOf("inrange") > -1) {
            elementHTML = getRangeFormElement(element, elementInfo);
        }
    } else if (element.formtype == "text") {
        if (element.formname.indexOf("datemin") > -1) {
            elementHTML = getDateFormElement(element, elementInfo);
        } else {
            elementHTML = getTextFormElement(element, elementInfo);
        }
    }

    if (elementHTML != "") {
        $(searchParamsBoxName).append(elementHTML);

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

    html = html + "<div class=\"radios clearfix\">";

    var values = element.formvalues;
    $.each(values, function (index, value) {
        var value_text = value.split(",");

        if (psearchUnusedSearch == true && value_text[0].indexOf("NOT_USED") > -1) {
            html = html + "<div class=\"psearch-select-element\">";
            html = html + "<div class=\"psearch-select-checkbox\">";
            html = html + "<input id=\"" + element.formname + "-" + index + "\" type=\"checkbox\" value=\"" + value_text[0].replace("~NOT_USED~", "") + "\" disabled data-default=\"disabled\">";
            html = html + "</div>";
            html = html + "<div class=\"psearch-select-label\">";
            html = html + "<label for=\"" + element.formname + "-" + index + "\" class=\"disabled\" value=\"" + value_text[0].replace("~NOT_USED~", "") + "\" data-default=\"disabled\">";
            html = html + value_text[1];
            html = html + "</label>";
            html = html + "</div>";
            html = html + "</div>";
        } else {
            html = html + "<div class=\"psearch-select-element\">";
            html = html + "<div class=\"psearch-select-checkbox\">";
            html = html + "<input id=\"" + element.formname + "-" + index + "\" type=\"checkbox\" value=\"" + value_text[0].replace("~NOT_USED~", "") + "\" data-default=\"enabled\">";
            html = html + "</div>";
            html = html + "<div class=\"psearch-select-label\">";
            html = html + "<label for=\"" + element.formname + "-" + index + "\" value=\"" + value_text[0].replace("~NOT_USED~", "") + "\" data-default=\"enabled\">";
            html = html + value_text[1];
            html = html + "</label>";
            html = html + "</div>";
            html = html + "</div>";
        }

    });

    html = html + "</div>";
    html = html + "</div>";

    return html;
}

function getSelectComboFormElement(element, elementInfo) {
    var html = "";

    html = html + "<div class=\"bloque-formu grid_6\" id=\"" + element.formname + "\">";

    // Label
    html = html + "<label>";
    html = html + element.name;
    html = html + "</label>";


    var values = element.formvalues;

    // From select
    html = html + "<div class=\"ikSelectContainer grid_2 first\">";
    html = html + "<select id=\"" + element.formname + "-combo\" class=\"form-control query filter-spacing\" data-value=\"-1\">";
    html = html + getSelectOptionsForMulti(values, smc.newproducts.messages["newproducts.selectoption"]); // Select option...
    html = html + "</select>";
    html = html + "</div>";
    html = html + "</div>";

    return html;
}

function getMultiFormElement(element, elementInfo) {
    var values = element.formvalues;

    psearchMultiDefaultValues[element.formname] = values;

    var html = "";

    html = html + "<div class=\"bloque-formu\" id=\"" + element.formname + "\">";

    // Label
    html = html + "<label>";
    html = html + element.name + " (" + elementInfo.uom + ")";
    html = html + "</label>";

    // From select
    html = html + "<div class=\"combobox2\">";
    html = html + "<select id=\"" + element.formname + "-from\" class=\"form-control query filter-spacing\" data-value=\"-1\">";
    html = html + getSelectOptionsForMulti(values, smc.newproducts.messages["psearch.from"]);
    html = html + "</select>";
    html = html + "</div>";

    // To select
    html = html + "<div class=\"combobox2\">";
    html = html + "<select id=\"" + element.formname + "-to\" class=\"form-control query filter-spacing\" data-value=\"-1\">";
    html = html + getSelectOptionsForMulti(values, smc.newproducts.messages["psearch.to"]);
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
            html = html + "<option value=\"" + value_text[0] + "\" disabled>";
        } else {
            html = html + "<option value=\"" + value_text[0] + "\">";
        }
        html = html + (value_text[1] != undefined ? value_text[1] : value_text[0]);
        html = html + "</option>";
    });

    return html;
}

function getRangeFormElement(element, elementInfo) {
    var min = element.formvalues[0];
    var max = element.formvalues[1];

    var html = "";

    html = html + "<div class=\"bloque-formu\" id=\"" + element.formname + "\">";

    // Label
    html = html + "<label>";
    html = html + element.name;
    html = html + "</label>";

    // Slider
    html = html + "<div class=\"valores\">";
    html = html + "<input class=\"val-min\" type=\"text\" id=\"" + element.formname + "-val-min\" data-min=\"" + min + "\" data-min-default=\"" + min + "\">";
    html = html + "<input class=\"val-max\" type=\"text\" id=\"" + element.formname + "-val-max\" data-max=\"" + max + "\" data-max-default=\"" + max + "\">";
    html = html + "</div>";
    html = html + "<div class=\"psearch-slider\" id=\"" + element.formname + "-slider\" data-uom=\"" + elementInfo.uom + "\">";
    html = html + "</div>";

    html = html + "</div>";

    return html;
}

function getTextFormElement(element, elementInfo) {
    var html = "";

    html = html + "<div class=\"bloque-formu\" id=\"" + element.formname + "\">";

    // Label
    html = html + "<label>";
    html = html + element.name;
    html = html + "</label>";

    // Slider
    html = html + "<input type=\"text\" id=\"" + element.formname + "-text\">";

    html = html + "</div>";

    return html;
}

function getDateFormElement(element, elementInfo) {
    var html = "";

    var elementName = element.formname.replace(",", "-");

    html = html + "<div class=\"bloque-formu grid_6\" id=\"" + elementName + "\">";

    // Label
    html = html + "<label>";
    html = html + element.name;
    html = html + "</label>";

    // Selects
    html = html + "<input type=\"hidden\" id=\"" + elementName + "-text\">";

    html = html + "<div class=\"grid_2 first ikFormElement\">";
    html = html + "<div class=\"ikSelectContainer\">";
    html = html + "<select id=\"" + elementName + "-date-range\" class=\"form-control new-products-date-range query filter-spacing\" data-value=\"-1\">";
    html = html + getSelectOptionsForMulti(["quarterly," + smc.newproducts.messages["newproducts.quarterly"], "yearly," + smc.newproducts.messages["newproducts.yearly"]], smc.newproducts.messages["newproducts.selectdate"]); // Quarterly, Yearly, Select date...
    html = html + "</select>";
    html = html + "</div>";
    html = html + "</div>";

    html = html + "<div class=\"grid_2 last ikFormElement\">";
    html = html + "<div class=\"ikSelectContainer\">";
    html = html + "<select id=\"" + elementName + "-date-value\" class=\"form-control new-products-date-value query filter-spacing\" data-value=\"-1\">";
    html = html + getSelectOptionsForMulti([], smc.newproducts.messages["newproducts.selectperiod"]); // Select period...
    html = html + "</select>";
    html = html + "</div>";
    html = html + "</div>";

    html = html + "</div>";

    return html;
}

function getSerieIndexFormElement(element, elementInfo) {
    var html = "";

    html = html + "<div class=\"bloque-formu grid_6 serie-index-element\" id=\"SerieIndexElement\">";

    // Label
    html = html + "<label>";
    html = html + element.name;
    html = html + "</label>";

    var values = element.formvalues;

    //// From select
    html = html + "<div class=\"indexRow ikFormElement\">";

    var alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".split("");
    $.each(alphabet, function (index, letter) {
        var existsResult = false;
        $.each(values, function (index, value) {
            var value_text = value.split(",");
            if (letter === value_text[0]) {
                existsResult = true;
            }
        });

        if (existsResult) {
            html = html + "<a class=\"indexElement enabled\" value=\"" + letter + "\">";
            html = html + letter;
            html = html + "</a>";
        } else {
            html = html + "<span href=\"#\" class=\"indexElement disabled\" value=\"" + letter + "\">";
            html = html + letter;
            html = html + "</span>";
        }

        if (index < alphabet.length - 1) {
            html = html + "<span class=\"indexLetterSeparator\"> | </span>";
        }
    });

    html = html + "</div>";
    html = html + "</div>";

    html = html + "</div>";

    return html;
}

// Initializers
function initElement(element, elementInfo) {
    if (element.formtype == "dropdown") {
        if (element.formname.indexOf("multi") > -1) {
            initFromTo(element.formname);
        } else if (element.formname.indexOf("select") > -1) {
            if (element.formname.indexOf(npSerieKey) > -1) {
                initSerieIndexElement(element, elementInfo);
            } else {
                if (selectAsCombo) {
                    initSelectCombos(element, elementInfo);
                } else {
                    initCheckboxes(element, elementInfo);
                }
            }
        }
    } else if (element.formtype == "range") {
        if (element.formname.indexOf("inrange") > -1) {
            initSlider(element, elementInfo);
        }
    } else if (element.formtype == "text") {
        if (element.formname.indexOf("datemin") > -1) {
            initDateInput(element, elementInfo);
        }
        initTextInput(element, elementInfo);
    }
}

function initCheckboxes(element, elementInfo) {
    $("#" + element.formname).find("input").unbind('change').bind('change', function () {
        if (!psearchShowSearchButton) {
            makeSearch();
        }
    });
}

function initTextInput(element, elementInfo) {
    $("#" + element.formname).unbind('focusout').bind('focusout', function () {
        if (!psearchShowSearchButton) {
            makeSearch();
        }
    });
}

function initDateInput(element, elementInfo) {
    var elementName = element.formname.replace(",", "-");
    $("#" + elementName + "-date-range").unbind('change').bind('change', function () {
        var dateValueElement = $("#" + elementName + "-date-value");
        dateValueElement.unbind('change');
        if ($(this).val() == "yearly") {
            var currentYear = new Date().getFullYear();
            dateValueElement.html(getSelectOptionsForMulti([currentYear + ", " + currentYear, (currentYear - 1) + ", " + (currentYear - 1), (currentYear - 2) + ", " + (currentYear - 2), (currentYear - 3) + ", " + (currentYear - 3)], "Select year..."))
        } else if ($(this).val() == "quarterly") {
            var q1 = "";
            var q2 = "";
            var q3 = "";
            var q4 = "";

            var date = new Date();
            var currentYear = date.getFullYear();
            var currentMonth = date.getMonth() + 1;

            var q1Text = smc.newproducts.messages["newproducts.firstquarter"];// First quarter
            var q2Text = smc.newproducts.messages["newproducts.secondquarter"];// Second quarter
            var q3Text = smc.newproducts.messages["newproducts.thirdquarter"]; // Third quarter
            var q4Text = smc.newproducts.messages["newproducts.fourthquarter"]; // Fourth quarter

            if (1 <= currentMonth && currentMonth <= 3) {
                q4 = q4 + q1Text + " " + currentYear;
                q3 = q3 + q4Text + " " + (currentYear - 1);
                q2 = q2 + q3Text + " " + (currentYear - 1);
                q1 = q1 + q2Text + " " + (currentYear - 1);
            } else if (4 <= currentMonth && currentMonth <= 6) {
                q4 = q4 + q2Text + " " + currentYear;
                q3 = q3 + q1Text + " " + currentYear;
                q2 = q2 + q4Text + " " + (currentYear - 1);
                q1 = q1 + q3Text + " " + (currentYear - 1);
            } else if (7 <= currentMonth && currentMonth <= 9) {
                q4 = q4 + q3Text + " " + currentYear;
                q3 = q3 + q2Text + " " + currentYear;
                q2 = q2 + q1Text + " " + currentYear;
                q1 = q1 + q4Text + " " + (currentYear - 1);
            } else if (10 <= currentMonth && currentMonth <= 12) {
                q4 = q4 + q4Text + " " + currentYear;
                q3 = q3 + q3Text + " " + currentYear;
                q2 = q2 + q2Text + " " + currentYear;
                q1 = q1 + q1Text + " " + currentYear;
            }

            dateValueElement.html(getSelectOptionsForMulti(["4, " + q4, "3, " + q3, "2, " + q2, "1, " + q1], smc.newproducts.messages["newproducts.selectquarter"])); // Select quarter...
        } else {
            dateValueElement.html(getSelectOptionsForMulti([], smc.newproducts.messages["newproducts.selectperiod"])); // Select period...
            makeSearch();
        }

        $("#" + elementName + "-date-value").unbind('change').bind('change', function () {
            if (!psearchShowSearchButton) {
                makeSearch();
            }
        });
    });

    $("#" + elementName + "-date-value").unbind('change').bind('change', function () {
        if (!psearchShowSearchButton) {
            makeSearch();
        }
    });
}

function initSerieIndexElement(element, elementInfo) {
    $(".indexElement.enabled").unbind("click").bind("click", function () {
        $(".indexElement").attr("style", "font-weight: normal;");
        $(this).attr("style", "font-weight: bold;");

        $(this).attr("value");
        $("#" + element.formname + "-combo").val($(this).attr("value"));
        makeSearch();
    });
}

function initSelectCombos(element, elementInfo) {
    var jQueryElement = $("#" + element.formname + "-combo");
    jQueryElement.unbind('change').bind('change', function () {
        jQueryElement.attr("data-value", jQueryElement.val());
        if (!psearchShowSearchButton) {
            makeSearch();
        }
    });
}

function initFromTo(name) {
    var fromElement = $("#" + name + "-from");
    var toElement = $("#" + name + "-to");

    fromElement.unbind('change').bind('change', function () {
        var fromValue = Number(fromElement.val());
        var toValue = Number(toElement.val());
        if (fromValue != -1 && toValue != -1 && fromValue > toValue) {
            toElement.val(fromValue);
        }

        fromElement.attr("data-value", fromElement.val());
        toElement.attr("data-value", toElement.val());

        if (!psearchShowSearchButton) {
            makeSearch();
        }
    });

    toElement.unbind('change').bind('change', function () {
        var fromValue = Number(fromElement.val());
        var toValue = Number(toElement.val());
        if (fromValue != -1 && toValue != -1 && fromValue > toValue) {
            fromElement.val(toValue);
        }

        fromElement.attr("data-value", fromElement.val());
        toElement.attr("data-value", toElement.val());

        if (!psearchShowSearchButton) {
            makeSearch();
        }
    });
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
    var domElement = $("#" + paramName + "-slider");
    var valMinDomElement = $("#" + paramName + "-val-min");
    var valMaxDomElement = $("#" + paramName + "-val-max");
    var unit = $("#" + paramName + "-slider").attr("data-uom");

    domElement.slider({
        range: true,
        min: min,
        max: max,
        values: [min, max],
        slide: function (event, ui) {
            valMinDomElement.val(ui.values[0] + " " + unit);
            valMaxDomElement.val(ui.values[1] + " " + unit);
        }
    });
    valMinDomElement.val(domElement.slider("values", 0) + " " + unit);
    valMaxDomElement.val(domElement.slider("values", 1) + " " + unit);
    return domElement;
}

function setSliderValues(paramName, valMin, valMax) {
    var valMinDomElement = $("#" + paramName + "-val-min");
    var valMaxDomElement = $("#" + paramName + "-val-max");

    var sliderElement = $("#" + paramName + "-slider");

    sliderElement.slider("values", [valMin, valMax]);

    valMinDomElement.val(valMin + " " + sliderElement.attr("data-uom"));
    valMaxDomElement.val(valMax + " " + sliderElement.attr("data-uom"));
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
        // restartForm();
        // Reload page with no params
        if( $("#search-type").val() != npSerieKey) {
            window.location.href = window.location.protocol + "//" + window.location.host + window.location.pathname;
        }
        else {
            window.location.href = seriesIndexUrl
        }
    });

    if (psearchShowSearchButton) {
        $(".search").unbind('click').bind('click', function () {
            makeSearch();
        });
    }
}

function restartForm() {
    $(".bloque-formu").each(function (index, element) {

        var paramName = $(this).attr("id");
        if (paramName) {
            if (paramName.indexOf("select") > -1) {
                if (paramName.indexOf(npSerieKey) > -1) {
                    $(".indexElement").attr("style", "font-weight: normal;");
                }

                if (selectAsCombo) {
                    $("#" + paramName + "-combo").val(-1);
                    $("#" + paramName + "-combo").attr("data-value", -1);
                } else {
                    $(this).find("input:checked").each(function (index, element) {
                        $(this).attr('checked', false);
                    });
                }
            } else if (paramName.indexOf("multi") > -1) {
                $("#" + paramName + "-from").val(-1);
                $("#" + paramName + "-from").attr("data-value", -1);
                $("#" + paramName + "-to").val(-1);
                $("#" + paramName + "-to").attr("data-value", -1);
            } else if (paramName.indexOf("inrange") > -1) {
                var valMin = $("#" + paramName + "-val-min").attr("data-min");
                var valMax = $("#" + paramName + "-val-max").attr("data-max");

                setSliderValues(paramName, valMin, valMax);
            } else if (paramName.indexOf("edit") > -1) {
                if (paramName.indexOf("datemin" > -1)) {
                    $("#" + paramName + "-date-range").val(-1);
                    $("#" + paramName + "-date-value").val(-1);
                }

                $("#" + paramName + "-text").val("");
            } else if (paramName.indexOf("datemin") > -1) {
                if (paramName.indexOf("datemin" > -1)) {
                    $("#" + paramName + "-date-range").val(-1);
                    $("#" + paramName + "-date-value").val(-1);
                }
            }
        }
    });

    makeSearch();
}

function initFormValues() {
    var queryParams = getQueryParamsFromUrl();
    var filterIsDate = false;
    psearchDebug ? console.log(queryParams) : "";
    for (var param in queryParams) {
        psearchDebug ? console.log(param) : "";
        $(".bloque-formu").each(function (index, element) {
            var paramName = $(this).attr("id");
            if (paramName != "" && param != "" && (param.indexOf(paramName) > -1 || paramName.indexOf(param) > -1 )) {
                var filtersId = "";
                if (paramName.indexOf("select") > -1) {
                    filtersId = paramName;
                    if (param.indexOf(npSerieKey) > -1) {
                        $(".indexElement[value=" + queryParams[param] + "]").attr("style", "font-weight: bold;")
                    }
                    if (selectAsCombo) {
                        $("#" + paramName + "-combo").val(queryParams[param]);
                        //$("#" + paramName + "-combo").val(param);
                        //$("#" + paramName + "-combo [value=" + queryParams[param] + "]").val(param);
                    } else {
                        $(this).find("input[value=" + queryParams[param] + "]").each(function (index, element) {
                            $(this).attr('checked', true);
                        });
                    }
                } else if (paramName.indexOf("multi") > -1) {
                    filtersId = paramName;
                    var value = Number(queryParams[param]);
                    updateMultiValues(paramName, value);
                } else if (paramName.indexOf("inrange") > -1) {
                    filtersId = paramName;
                    var values = queryParams[param].split(",");
                    setSliderValues(paramName, values[0], values[1]);
                } else if (paramName.indexOf("edit") > -1) {
                    filtersId = paramName;
                    $("#" + paramName + "-text").val(queryParams[param]);
                } else if (paramName.indexOf("datemin") > -1) {
                    psearchDebug ? console.log("[NewProdcutsSearch] Initialize date selects.") : "";
                    var dateFiltersId = $("#search-type [value*=datemin]").val();
                    $("#search-type").val(dateFiltersId);
                    $(".bloque-formu#" + dateFiltersId).show();
                    filtersId = paramName;
                    filterIsDate = true;
                }

                // Mostrar opciÃ³n de bÃºsqueda
                if ($("#search-type") != undefined) {
                    $("#search-type").val(filtersId);

                    //$("#search-type").triggerHandler("change");
                    if (param.indexOf(npSerieKey) > -1) {
                        $("#SerieIndexElement").show();
                    } else {
                        $("#" + filtersId).show();
                    }
                }
            }
        });
    }
    if (filterIsDate){
        $("#search-type option").each(function(){
            if (this.value.indexOf("datemin_") >=0){
                $("#search-type").val(this.value);
            }
        });
        reviewDateLoads(queryParams);
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
        // query = window.location.hash;
        query = window.location.search;

    var urlParams = {};
    var i = 0;
    while (match = search.exec(query)) {
        urlParams[decode(match[1].replace("?", ""))] = decode(match[2]);
        i++;
    }

    return urlParams;

}

function makeSearch() {
    var query = getQueryStringFromForm();

    psearchDebug ? console.log("Query string: " + query) : "";

    if (psearchAjaxRequest != undefined) {
        psearchAjaxRequest.abort();
    }

    if (query != "") {
        getSearchResults(query);
    } else {
        showAllResults();
        // TODO: FIX
        // enableDefaultFormOptions();
    }

    location.hash = "s" + query;
}

function getQueryStringFromForm() {
    var queryString = "";

    $(".bloque-formu").each(function (index, element) {
        var paramName = $(this).attr("id");
        if (paramName) {

            if (paramName.indexOf("select") > -1) {
                if (selectAsCombo) {
                    if ($(this).find("#" + paramName + "-combo").val() != "-1") {
                        queryString = queryString + "&" + paramName + "[]=" + $(this).find("#" + paramName + "-combo").val();
                    }
                } else {
                    $(this).find("input:checked").each(function (index, element) {
                        queryString = queryString + "&" + paramName + "[]=" + $(this).val();
                    });
                }
            } else if (paramName.indexOf("multi") > -1) {
                var fromValue = Number($("#" + paramName + "-from").val());
                var toValue = Number($("#" + paramName + "-to").val());

                if (fromValue > -1 && toValue > -1) {
                    $("#" + paramName + "-from option").each(function (index, element) {
                        if (Number($(this).val()) >= fromValue && Number($(this).val()) <= toValue) {
                            queryString = queryString + "&" + paramName + "[]=" + $(this).val();
                        }
                    });
                } else if (fromValue > -1 && toValue == -1) {
                    // From 'from' to max
                    $("#" + paramName + "-from option").each(function (index, element) {
                        if (Number($(this).val()) >= fromValue) {
                            queryString = queryString + "&" + paramName + "[]=" + $(this).val();
                        }
                    });
                } else if (fromValue == -1 && toValue > -1) {
                    // From 'to' to min
                    $("#" + paramName + "-from option").each(function (index, element) {
                        if (Number($(this).val()) <= toValue && Number($(this).val()) != -1) {
                            queryString = queryString + "&" + paramName + "[]=" + $(this).val();
                        }
                    });
                }

            } else if (paramName.indexOf("inrange") > -1) {
                var values = $("#" + paramName + "-slider").slider("option", "values");

                if (values[0] > $(this).find("input.val-min").attr("data-min") || values[1] < $(this).find("input.val-max").attr("data-max")) {
                    $("#" + paramName + "-slider > a.ui-slider-handle").addClass("value-selected");

                    queryString = queryString + "&" + paramName + "=" + values[0] + "," + values[1];
                } else {
                    $("#" + paramName + "-slider > a.ui-slider-handle").removeClass("value-selected");
                }
            } else if (paramName.indexOf("edit") > -1) {
                if ($(this).find("#" + paramName + "-text").val() != "") {
                    queryString = queryString + "&" + paramName + "=" + $(this).find("#" + paramName + "-text").val();
                }
            } else if (paramName.indexOf("datemin") > -1) {
                var dateParams = paramName.split("-");
                if (dateParams.length > 1) {
                    var dateRangeElement = $("#" + paramName + "-date-range");
                    var dateValueElement = $("#" + paramName + "-date-value");

                    if (dateRangeElement.val() === "yearly") {
                        var selectedYear = dateValueElement.val();
                        if (selectedYear > -1) {
                            queryString = queryString + "&" + dateParams[0] + "[]=01/01/" + selectedYear;
                            queryString = queryString + "&" + dateParams[1] + "[]=12/31/" + selectedYear;
                        }
                    } else if (dateRangeElement.val() === "quarterly") {
                        var selectedQuarter = Number(dateValueElement.val());
                        if (selectedQuarter > -1) {
                            var date = new Date();
                            var currentYear = date.getFullYear();
                            var currentMonth = date.getMonth() + 1;

                            var dateRangeMinQ1 = "01/01/";
                            var dateRangeMaxQ1 = "03/31/";
                            var dateRangeMinQ2 = "04/01/";
                            var dateRangeMaxQ2 = "06/30/";
                            var dateRangeMinQ3 = "07/01/";
                            var dateRangeMaxQ3 = "09/30/";
                            var dateRangeMinQ4 = "10/01/";
                            var dateRangeMaxQ4 = "12/31/";

                            var dateRangeMin = "";
                            var dateRangeMax = "";

                            if (1 <= currentMonth && currentMonth <= 3) {
                                switch (selectedQuarter) {
                                    case 4:
                                        dateRangeMin = dateRangeMinQ1 + currentYear;
                                        dateRangeMax = dateRangeMaxQ1 + currentYear;
                                        break;
                                    case 3:
                                        dateRangeMin = dateRangeMinQ4 + (currentYear - 1);
                                        dateRangeMax = dateRangeMaxQ4 + (currentYear - 1);
                                        break;
                                    case 2:
                                        dateRangeMin = dateRangeMinQ3 + (currentYear - 1);
                                        dateRangeMax = dateRangeMaxQ3 + (currentYear - 1);
                                        break;
                                    case 1:
                                        dateRangeMin = dateRangeMinQ2 + (currentYear - 1);
                                        dateRangeMax = dateRangeMaxQ2 + (currentYear - 1);
                                        break;
                                }
                            } else if (4 <= currentMonth && currentMonth <= 6) {
                                switch (selectedQuarter) {
                                    case 4:
                                        dateRangeMin = dateRangeMinQ2 + currentYear;
                                        dateRangeMax = dateRangeMaxQ2 + currentYear;
                                        break;
                                    case 3:
                                        dateRangeMin = dateRangeMinQ1 + currentYear;
                                        dateRangeMax = dateRangeMaxQ1 + currentYear;
                                        break;
                                    case 2:
                                        dateRangeMin = dateRangeMinQ4 + (currentYear - 1);
                                        dateRangeMax = dateRangeMaxQ4 + (currentYear - 1);
                                        break;
                                    case 1:
                                        dateRangeMin = dateRangeMinQ3 + (currentYear - 1);
                                        dateRangeMax = dateRangeMaxQ3 + (currentYear - 1);
                                        break;
                                }
                            } else if (7 <= currentMonth && currentMonth <= 9) {
                                switch (selectedQuarter) {
                                    case 4:
                                        dateRangeMin = dateRangeMinQ3 + currentYear;
                                        dateRangeMax = dateRangeMaxQ3 + currentYear;
                                        break;
                                    case 3:
                                        dateRangeMin = dateRangeMinQ2 + currentYear;
                                        dateRangeMax = dateRangeMaxQ2 + currentYear;
                                        break;
                                    case 2:
                                        dateRangeMin = dateRangeMinQ1 + currentYear;
                                        dateRangeMax = dateRangeMaxQ1 + currentYear;
                                        break;
                                    case 1:
                                        dateRangeMin = dateRangeMinQ4 + (currentYear - 1);
                                        dateRangeMax = dateRangeMaxQ4 + (currentYear - 1);
                                        break;
                                }
                            } else if (10 <= currentMonth && currentMonth <= 12) {
                                switch (selectedQuarter) {
                                    case 4:
                                        dateRangeMin = dateRangeMinQ4 + currentYear;
                                        dateRangeMax = dateRangeMaxQ4 + currentYear;
                                        break;
                                    case 3:
                                        dateRangeMin = dateRangeMinQ3 + currentYear;
                                        dateRangeMax = dateRangeMaxQ3 + currentYear;
                                        break;
                                    case 2:
                                        dateRangeMin = dateRangeMinQ2 + currentYear;
                                        dateRangeMax = dateRangeMaxQ2 + currentYear;
                                        break;
                                    case 1:
                                        dateRangeMin = dateRangeMinQ1 + currentYear;
                                        dateRangeMax = dateRangeMaxQ1 + currentYear;
                                        break;
                                }
                            }

                            queryString = queryString + "&" + dateParams[0] + "[]=" + dateRangeMin;
                            queryString = queryString + "&" + dateParams[1] + "[]=" + dateRangeMax;
                        }
                    }
                }
            }
        }
    });

    return queryString;
}

function enableDefaultFormOptions() {
    // Default selects
    $("label.disabled[data-default=enabled]").removeClass("disabled");
    $("input:disabled[data-default=enabled]").enable();

    // Default sliders
    $(".bloque-formu").each(function (index, element) {
        if ($(this).attr("id").indexOf("inrange") > -1) {
            if ($(this).find(".val-min").attr("data-min") != $(this).find(".val-min").attr("data-min-default") ||
                $(this).find(".val-max").attr("data-max") != $(this).find(".val-max").attr("data-max-default")) {
                reinitSlider($(this).attr("id"), $(this).find(".val-min").attr("data-min-default"), $(this).find(".val-max").attr("data-max-default"));
            }
        }
    });

    // Default multis
    $(".bloque-formu").each(function (index, element) {
        if ($(this).attr("id").indexOf("multi") > -1) {
            configureMulti($(this).attr("id"), psearchMultiDefaultValues[$(this).attr("id")]);
        }
    });

}

function getSearchResults(query) {
    window.location.href = window.location.origin + window.location.pathname + "?" + query.replace("[]", "").replace("[]", "");
}

function reinitSlider(name, min, max) {
    var slider = $("#" + name + "-slider");

    var previousMin = $("#" + name).find("input.val-min").attr("data-min");
    var previousMax = $("#" + name).find("input.val-max").attr("data-max");

    var sliderMinVal = slider.slider("option", "values")[0];
    var sliderMaxVal = slider.slider("option", "values")[1];

    if (sliderMinVal == previousMin) {
        sliderMinVal = min;
    }
    if (sliderMaxVal == previousMax) {
        sliderMaxVal = max;
    }

    $("#" + name).find("input.val-min").attr("data-min", min);
    $("#" + name).find("input.val-max").attr("data-max", max);

    slider.slider().unbind('slidechange');

    initSliderValues(name, Number(min), Number(max));
    setSliderValues(name, sliderMinVal, sliderMaxVal);

    $("#" + name + "-slider").slider().unbind('slidechange').bind('slidechange', function () {
        if (!psearchShowSearchButton) {
            makeSearch();
        }
    });
}

function showAllResults() {
    console.log("SHOWALL")
    // var endpoint = "";
    // if (npUserType != undefined && npUserType != "" && npUserType != "null") {
    //     endpoint = newProductsApiDomain + 'np/nodes/' + psearchLanguage + '/attset/' + npSearchAttrSet + "?" + "ts=" + new Date().getTime() + "&userType=" + npUserType + "&" + npStatusKey;
    // } else {
    //     endpoint = newProductsApiDomain + 'np/nodes/' + psearchLanguage + '/attset/' + npSearchAttrSet + "?" + "ts=" + new Date().getTime() + "&" + npStatusKey;
    // }
    //
    // psearchDebug ? console.log(endpoint) : "";
    // addResultsToDom(endpoint);
}

// TOUCHED
function addResultsToDom(endpoint) {
    var applyBinding = false;

    if (newProductsListViewModel == undefined) {
        applyBinding = true;
        newProductsListViewModel = new NewProductsViewModel(endpoint);
    } else {
        newProductsListViewModel.refreshNPViewModelDatatable(self, endpoint);
    }


    if (applyBinding) {
        ko.applyBindings(newProductsListViewModel, document.getElementById("grid_table"));
    }

}


function getUsedValuesFromUnusedForMulti(name, values) {
    var allValues = psearchMultiDefaultValues[name];

    var usedValues = [];
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

    return usedValues;
}

function configureMulti(name, values) {
    var from = $("#" + name + "-from").attr("data-value");
    var to = $("#" + name + "-to").attr("data-value");

    psearchDebug ? console.log("ConfigureMulti - From: " + from + " To: " + to + " Values: " + values) : "";

    if (values.length > 0) {
        $("#" + name + "-from").unbind('change');
        $("#" + name + "-to").unbind('change');

        $("#" + name + "-from").html(getSelectOptionsForMulti(values, smc.newproducts.messages["psearch.from"]));
        $("#" + name + "-to").html(getSelectOptionsForMulti(values, smc.newproducts.messages["psearch.to"]));

        $("#" + name + "-from").val(Number(from));
        $("#" + name + "-to").val(Number(to));

        initFromTo(name);
    }
}

function reviewDateLoads(queryParams){
    var currentUrl = window.location.href;
    if (currentUrl.indexOf("datemin_") > 0){
        //then the filter is for date
        if (currentUrl.indexOf("01/01/") > 0 && currentUrl.indexOf("12/31/") > 0){
            //then we are filtering by year
            console.log("[reviewDateLoads] - filter is by year");
            $(".new-products-date-range").val("yearly");
            $(".new-products-date-range").trigger("change");
            for (var param in queryParams) {
                var paramName = param;
                if (paramName.indexOf("datemin") > -1){
                    var paramsFromUrl = currentUrl.substring(currentUrl.indexOf(paramName)+paramName.length);
                    var searchYear = paramsFromUrl.substring(1, paramsFromUrl.indexOf("&"));
                    searchYear = searchYear.replace("01/01/","");
                    $(".new-products-date-value").val(searchYear);
                }
            }
        }else {
            //then we are filtering by quarter
            console.log("[reviewDateLoads] - filter is by quarter");
            $(".new-products-date-range").val("quarterly");
            $(".new-products-date-range").trigger("change");
            for (var param in queryParams) {
                var paramName = param;
                if (paramName.indexOf("datemin") > -1){
                    var paramsFromUrl = currentUrl.substring(currentUrl.indexOf(paramName)+paramName.length);
                    var searchMonth = parseInt(paramsFromUrl.substring(1, paramsFromUrl.indexOf("/")));
                    var searchYear = parseInt(paramsFromUrl.substring(paramsFromUrl.length - 4));
                    var selectedText = "";
                    var q1Text = smc.newproducts.messages["newproducts.firstquarter"];// First quarter
                    var q2Text = smc.newproducts.messages["newproducts.secondquarter"];// Second quarter
                    var q3Text = smc.newproducts.messages["newproducts.thirdquarter"]; // Third quarter
                    var q4Text = smc.newproducts.messages["newproducts.fourthquarter"]; // Fourth quarter
                    if (searchMonth >=1  && searchMonth <= 3){
                        selectedText = q1Text+" "+searchYear;
                    }else if (searchMonth >=4  && searchMonth <= 6){
                        selectedText = q2Text+" "+searchYear;
                    }else if (searchMonth >=7  && searchMonth <= 9){
                        selectedText = q3Text+" "+searchYear;
                    }else if (searchMonth >=10  && searchMonth <= 12){
                        selectedText = q4Text+" "+searchYear;
                    }
                    $(".new-products-date-value option").each(function(){
                        if (this.text === selectedText){
                            $(".new-products-date-value").val(this.value);
                        }
                    });
                }
            }
        }
    }
}

