var oStateMessages = new Object();
// State Messages will be provided in page onload action
var oStrokeMessages = new Object();

function smcShowPartNumber() {
    var oCPNString = document.getElementById('cpn_partnumber');
    var isDashField = false;
    var xOptionClass = "";
    partNumberString = "";
    partCode = '';
    var stateClass = '';
    //partArray = oDomains.getPartNumber();
    //partNumberString = oDomains.getPartNumber().join("");
    for (var i = 0; i < oDomains.cpcarray.length; i++) {
        partBlock = '';
        partBackColor = 'FFFFFF';
        stateClass = '';
        oDom = oDomains.cpcarray[i];
        isDashField = false;
        switch (oDom.dtype) {
            case Domain.Constant:
                //It is a constant - user can't pick
                partBlock = oDom.label;
                partBackColor = 'FFFFFF';
                break;
            case Domain.List:
                //If oDom.label == 'dash' then user cannot pick it is autoset.
                //code will either be '-' or empty string.
                partBackColor = 'B8CCFF';
                if (oDom.label == '-') {
                    //optional dash fields
                    partBackColor = 'FFFFFF';
                    isDashField = true;
                }
                if ((i + 1) < oDomains.cpcarray.length && oDomains.cpcarray[i + 1].domainFuncType == "BUILDER" && isDashField) {
                    xOptionClass = " xoption";
                }
                if (oDom.state == Domain.NotSet) {
                    partBlock = '';
                } else {
                    partBlock = oDom.selectionString();
                }
                break;
            case Domain.Mixed:
                partBackColor = 'B8CCFF';
                partBlock = (oDom.hasSelection()) ? oDom.inputval : '';
                break;
            case Domain.IntegerRange:
                partBackColor = 'B8CCFF';
                partBlock = (oDom.hasSelection()) ? oDom.inputval : '';
                break;
            case Domain.DecimalRange:
                partBackColor = 'B8CCFF';
                partBlock = (oDom.hasSelection()) ? oDom.inputval : '';
                break;
            default:
                alert('Domain (' + oDom.label + ') is an unsupported datatype (' + oDom.dtype + ')');
                break;
        }
        if (oDom.contype == Rule.HardConstraint) {
            partBackColor = 'FF0000';
            stateClass = 'partnumber_error';
        }
        if (oDom.contype == Rule.SoftConstraint) {
            stateClass = 'partnumber_warning';
        }
        partNumberString = partNumberString + partBlock;
        if (typeof euStylePNTable !== "undefined" && euStylePNTable) {
            if (isDashField) {
                partCode = partCode + '<span class="partnumber_optdash_chain' + xOptionClass + '">' + partBlock + '</span>';
            } else if (oDom.dtype == Domain.Constant) {
                partCode = partCode + '<span class="partnumber_constant_chain' + xOptionClass + '">' + partBlock + '</span>';
            } else {
                partCode = partCode + '<span class="partnumber_variable_chain ' + stateClass + xOptionClass + '">' + partBlock + '</span>';
            }
        } else {
            if (partBlock == '') {
                partCode = partCode + '<span nowrap bgcolor="#' + partBackColor + '">' + '&nbsp;&nbsp;' + '</span>';
            } else {
                partCode = partCode + '<span nowrap bgcolor="#' + partBackColor + '">' + partBlock + '</span>';
            }
        }
    }

    oCPNString.innerHTML = partCode;

    // Remove trailing X if configurator has rod end
    if (partNumberString.charAt(partNumberString.length - 1) === 'X' && $("#cpn_partnumber .xoption").length > 0) {
        $(oCPNString).find(".xoption").html("");
        partNumberString = partNumberString.substr(0, partNumberString.length - 1);
    }

    var oCPNState = document.getElementById('cpn_state');
    var sState = oDomains.getConstraintEngineState();
    /*
    switch(sState) {
    case 'Partial':
        oCPNState.style.color = '#CCAA00';
        break;
    case 'Complete':
        oCPNState.style.color = '#00A000';
        break;
    case 'Invalid':
        oCPNState.style.color = '#AA0000';
        break;
    }
    */
    oCPNState.innerHTML = oStateMessages[sState];
}

var validRodEnds = true;
var nonBuilderComplete = false;

function isRodEndNone() {
    // return true if
    for (var domid in oDomains.domains) {
        if (oDomains.domains.hasOwnProperty(domid)) {
            var oDom = oDomains.domains[domid];
            if (oDom.dtype != "D_CONSTANT" && oDom.dtype != "") {
                if (oDom.hasSelection()) {
                    if ("XROD_ENDS" == oDom.code) {
                        rodDesc = (oDom.dtype == Domain.List) ? oDom.selectionString() : DomInputValProcessor(oDom);
                        return rodDesc.trim() === "";
                    }
                }
            }
        }
    }
}

function customFormChange(nTriggerDomain) {
    stdFormChange(nTriggerDomain);
    var domStruct = {};
    var rodDesc = "";
    var isRodEndSelectedValid = true;
    nonBuilderComplete = true;
    for (var domid in oDomains.domains) {
        if (oDomains.domains.hasOwnProperty(domid)) {
            oDom = oDomains.domains[domid];
            if (oDom.dtype != "D_CONSTANT" && oDom.dtype != "") {
                if (oDom.hasSelection()) {
                    if ("XROD_ENDS" == oDom.code) {
                        rodDesc = (oDom.dtype == Domain.List) ? oDom.selectionString() : DomInputValProcessor(oDom);
                        if (oDom.members.hasOwnProperty(oDom.aDSV[0])) {
                            rodDesc = oDom.members[oDom.aDSV[0]].value;
                        }
                        // if dom is valid look to see if all are disabled
                        isRodEndSelectedValid = oDom.contype != Rule.HardConstraint;
                        if (oDom.contype != Rule.NoConstraint) {
                            validRodEnds = true;
                        } else {
                            var oDomFormEle = getFormObject(domid);
                            validRodEnds = false;
                            for (var i = 0; i < oDomFormEle.options.length - 1; i++) {
                                var choiceid = oDomFormEle.options[i + 1].value;
                                if (oDom.members[choiceid].state != Domain.ChoiceRestricted && oDom.members[choiceid].code != "") {
                                    validRodEnds = true;
                                    break;
                                }
                            }
                        }
                    }
                    // create simple domStruct for eu rod end
                    domStruct[oDom.code] = (oDom.dtype == Domain.List) ? oDom.selectionString() : DomInputValProcessor(oDom);

                    oStroke = document.getElementById('stroke_' + domid);

                    if (oStroke) {
                        switch (oDom.contype) {
                            case Rule.NoConstraint:
                                oStroke.style.color = gNoConstraintColor;
                                break;
                            case Rule.SoftConstraint:
                                oStroke.style.color = gSoftConstraintColor;
                                break;
                            case Rule.HardConstraint:
                                oStroke.style.color = gHardConstraintColor;
                                break;
                        }
                    }
                } else {
                    if (oDom.domainFuncType != "BUILDER") {
                        nonBuilderComplete = false;
                    }
                }
                if (oDom.code.slice(0, 6) == 'STROKE') {
                    stroke_size = oDom.hasSelection() ? DomInputValProcessor(oDom) : "";

                    // Calculate the current valid range(s).

                    var elem = document.getElementById("stroke_" + domid + "_range");

                    if (elem) {
                        var endpoints = [];

                        for (var key in oDom.members) {
                            var member = oDom.members[key];

                            if (member.state != Domain.ChoiceRestricted) {
                                var sRange = member.value;
                                if (sRange.charAt(0) == '['
                                    && sRange.charAt(sRange.length - 1) == ']') {
                                    var aRange = sRange.slice(1, -1).split(',');
                                    if (aRange.length > 0) {
                                        aRangeSpec = aRange[0].split('-', 3);
                                        if (aRangeSpec.length >= 2) {
                                            var nMin = parseFloat(aRangeSpec[0]);
                                            var nMax = parseFloat(aRangeSpec[1]);
                                            if (!isNaN(nMin) && !isNaN(nMax)) {
                                                endpoints.push({num: nMin, isMin: true});
                                                endpoints.push({num: nMax, isMin: false});
                                            }
                                        }
                                    }
                                }
                            }
                        }

                        endpoints.sort(function (endpoint1, endpoint2) {
                            var num1 = endpoint1.num;
                            var num2 = endpoint2.num;

                            if (num1 == num2) {
                                if (num1.isMin && !num2.isMin) return -1;
                                if (num2.isMin && !num1.isMin) return 1;

                                return 0;
                            }

                            if (num1 < num2) return -1;
                            return 1;
                        });

                        var ranges = [];
                        var counter = 0;
                        var currentRange = null;

                        for (var i = 0; i < endpoints.length; i++) {
                            var endpoint = endpoints[i];

                            if (endpoint.isMin) {
                                if (currentRange == null) {
                                    currentRange = {min: endpoint.num};
                                }

                                counter = counter + 1;
                            } else {
                                counter = counter - 1;
                            }

                            if (counter == 0) {
                                if ((i >= endpoints.length - 1) || (endpoints[i + 1].num > endpoint.num + 1)) {
                                    currentRange.max = endpoint.num;
                                    ranges.push(currentRange);
                                    currentRange = null;
                                }
                            }
                        }

                        var oUnit = document.forms['form']["stroke_" + domid + '_unit'];
                        var unit = (oUnit[0].checked) ? "inch" : "mm";

                        var separator = ((typeof (oStrokeMessages) == "object") && ("config_valid_stroke_separator" in oStrokeMessages)) ? oStrokeMessages.config_valid_stroke_separator : "";
                        if (!separator) separator = "-";
                        var steptext = ((typeof (oStrokeMessages) == "object") && ("config_stroke_increment" in oStrokeMessages)) ? oStrokeMessages.config_stroke_increment : "";
                        if (!steptext) steptext = " by ";

                        var textRanges = [];

                        for (var i = 0; i < ranges.length; i++) {
                            var minv = unit == "mm" ? formatStroke(ranges[i].min, 4) : formatStroke(ranges[i].min / 25.4, 3);
                            var maxv = unit == "mm" ? formatStroke(ranges[i].max, 4) : formatStroke(ranges[i].max / 25.4, 3);

                            textRanges.push(minv + " mm " + separator + " " + maxv + " mm");
                        }
                        if (aRangeSpec.length == 3) {
                            // increment
                            elem.innerHTML = "[" + textRanges.join(", ") + "] " + steptext + " " + aRangeSpec[2];
                        } else {
                            elem.innerHTML = "[" + textRanges.join(", ") + "]";
                        }
                    }
                }
            }
        }
    }
    // check for a rod end
    if (typeof window["selectXRod"] === "function" && domStruct.hasOwnProperty("XROD_ENDS")) {
        selectXRod(domid, domStruct["XROD_ENDS"], rodDesc, domStruct, oDomains.getConstraintEngineState(), isRodEndSelectedValid);
    }

    if (typeof partnumberChangeFinishNotify === "function") {
        partnumberChangeFinishNotify();
    }

    // Stroke info hover
        let $strokes = $(".configurationRow span[id^='stroke_']");
        if ($strokes.length > 0) {
            $strokes.each(function () {
                let title = $(this).html();
                let $selectBox = $(this).closest("tr").find(".selectBox");
                if (!title || title.includes("icon-info")) {
                    return;
                }
                $(this).html("");
                let icon = "<i class='icon-info' title='" + title + "' style='font-size: 1.5em;'></i>";
                if ($selectBox.length > 0) {
                    let $selectBoxSpan = $selectBox.find("span");
                    if ($selectBoxSpan.length === 0) {
                        let strokeSpan = '<span class="small"></span>';
                        $selectBox.append(strokeSpan);
                    }
                    $selectBoxSpan.html(icon);
                } else {
                    $strokes.html(icon);
                }
            });
        }

}

function isRodEndConfigurationValid() {
    return Object.keys(rodendUserValues).length === 0 || (Object.keys(rodendUserValues).length > 0 && currentRodEndStatus === true);
}

function isConfigurationValid() {
    return isRodEndConfigurationValid() && isConfigurationComplete();
}

function isConfigurationComplete() {
    return oDomains.getConstraintEngineState() === "Complete";
}


ShowPartNumber = smcShowPartNumber;