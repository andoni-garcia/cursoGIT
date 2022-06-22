var currentXRodChoice = "";
var currentTrunnionChoice = "";
var currentConfigState = "";
var currentConfigValues = {};
var currentUserValues = {};
var rodendUserValues = {};
var trunnionUserValues = {};
var currentDefaultValues = {};
var currentCADenasValues = "";
var currentMovexValues = "";
var currentRodEndStatus = false;
var currentMinThread = "";
var currentMaxThread = "";
var rodEndFormHasTrunnion = false;
var trunnionImage = "";
var rodEndFormData = null;
var rodEndFormThreadSelect = null;
var rodEndFormLoaded = false;
var rodEndFormRequestInProgress = false;
var rodEndFormImagePath = "";
var rodEndDebug = false;

function showRodOpts(bTF) {
    /*
    $('#scroll_div_' + rodEndDom).find('img').each(function () {
        $(this).css('display', bTF ? "" : "none");
    });
    $('.pickImageLabel').css('display', bTF ? "" : "none");

    $('#dom_' + rodEndDom + "_ph").css('display', bTF ? "none" : "");
    $('#rodend_filter').css('display', bTF ? "" : "none");
    */
    // hide the rod end form area if the rod selection is visable
    //if (bTF) {
    //	$('#xRodFormArea').hide();
    //} else {
    //	$('#xRodFormArea').show();
    //}
}

function rodEndFilter(type) {
    if (rodEndProps.hasOwnProperty("rod_end_class")) {
        $(".re_image").each(function (index) {
            var code = $(this).attr("re_code").toLowerCase();
            if (code == "" || type == "All" || (rodEndProps.rod_end_class.hasOwnProperty(code)
                && rodEndProps.rod_end_class[code].toUpperCase() === type.toUpperCase())) {
                if ($(this).hasClass("image_sel_class_prohibit") || $(this).hasClass("image_sel_class_invalid")) {
                    // only show if not invalid or prohibited
                } else {
                    $(this).show();
                }
            } else {
                $(this).hide();
            }
        });
    }
}

function getDomByCode(code) {
    for (var domid in oDomains.domains) {
        if (oDomains.domains.hasOwnProperty(domid)) {
            oDom = oDomains.domains[domid];
            if (code == oDom.code) {
                return oDom;
            }
        }
    }
    return null;
}
function getOptionByCode(oDom, code) {
    for (var key in oDom.members) {
        var member = oDom.members[key];
        if (code == member.code) {
            return member;
        }
    }
    return null;
}

function selectXRod(domid, rodType, rodTypeDesc, domStruct, configState, isRodEndSelectedValid) {
    // called every time configration is updated
    $('#xRodFormError').empty(); // clear possible error messages
    $('#xTrunnionFormError').empty(); // clear possible error messages
    currentConfigState = configState;
    currentConfigValues = domStruct;
    // check for invalid XROD_END
    if (!isRodEndSelectedValid) {
        //force selection to none
        var oDom = getDomByCode("XROD_ENDS");
        setTimeout("selImage('" + oDom.did + "',1);");
        return;
    }
    var oDom = getDomByCode("TRUNNION");
    currentTrunnionChoice = "";
    if (typeof oDom !== typeof undefined) {
        if (oDom != null && oDom.hasSelection()) {
            currentTrunnionChoice = oDom.selectionString();
        }
    }
    // check for too many builder options
    var bcount = 0;
    for (var domid in oDomains.domains) {
        if (oDomains.domains.hasOwnProperty(domid)) {
            oDom = oDomains.domains[domid];
            if (oDom.domainFuncType == "BUILDER" && oDom.hasSelection() && oDom.selectionString() != "") {
                bcount++;
                if (bcount > maxXRodChoices) {
                    oDomains.setDomain(oDom.did, getOptionByCode(oDom, "").id, Domain.UserSet);
                    // set the select
                    $('#dom_' + oDom.did).val(getOptionByCode(oDom, "").id);
                    var t = $('#dom_' + oDom.did).val();
                    alert(re_msg_too_many_choices);
                    setTimeout("$('#dom_" + oDom.did + "')[0].checked = false;setDomainValue(" + oDom.did + ", $('#dom_" + oDom.did + "')[0]); formChange(" + oDom.did + ");");
                }
            }
        }
    }
    if (bcount == 0) {
        // hide the part number fields that relate to the builder options
        $('.xoption').hide(); // hides
    } else {
        // show the part number fields that relate to the builder options
        $('.xoption').show(); // Shows
    }
    if ($('#dom_' + rodEndDom + "_ph").length) {
        // place holder select exists ... set it
        //$('#dom_'+rodEndDom+"_ph").find('option').eq(0).text(rodType);
        // place holder input exists ... set it
        $('#dom_' + rodEndDom + "_ph").val(rodTypeDesc);
        showRodOpts(false);
    }

    // AJAX call services to get parameters for this form
    if (rodEndFormData == null) {
        currentXRodChoice = rodType.toLowerCase(); // lowercase to match data
        rodEndFormData = {};
        getXRodForm();
        return;
    } else if (currentXRodChoice == rodType.toLowerCase()) {
        // already selected, nothing to do just drop through
        // to next section and see if config has changed
    } else {
        currentXRodChoice = rodType.toLowerCase();
        rodEndBuildForm();
    }

    rodEndChange();
}

function updateThreadSelect() {
    if (rodEndFormThreadSelect != null) {
        var userSetVal = currentUserValues.hasOwnProperty("mm") ? currentUserValues["mm"] : "";

        // update the dropdown for threads
        var threadsOK = false;
        rodEndFormThreadSelect.empty();
        rodEndFormThreadSelect.append($('<option>').attr({ 'value': '' }).text("Select Thread"));
        $.each(rodEndFormData.threads, function (i, thread) {
            if (!threadsOK && thread == currentMinThread) {
                threadsOK = true;
            }
            if (threadsOK) {
                // add the option in...
                rodEndFormThreadSelect.append($('<option>').attr({ 'value': thread }).text(thread));
            }
            if (thread == currentMaxThread) {
                threadsOK = false;
            }
        });
        // userSetVal is from the user select try it first
        if (userSetVal != "") {
            userSetVal = userSetVal.replace("%20"," ");
            rodEndFormThreadSelect.val(userSetVal);
            $(".rodInputValue [vname='mm']").val(userSetVal);
        }
        var defaultVal = currentDefaultValues.hasOwnProperty("mm") ? currentDefaultValues["mm"] : "";
        if (defaultVal != "" && (userSetVal != "" && rodEndFormThreadSelect.val() != userSetVal)) {
            // setting it failed...
            rodEndFormThreadSelect.val(defaultVal);
            $(".rodInputValue [vname='mm']").val(defaultVal);
        }

    }
    // for jquery mobile you need to rebuild
    try {
        if (rodEndFormThreadSelect != null && $.isFunction(rodEndFormThreadSelect.selectmenu)) {
            rodEndFormThreadSelect.selectmenu('refresh', true);
        }
    } catch(e) {
        console.log(e);
    }
}

function setRodEndModButtonDisabled(btf) {
    try {
        $('#rodEndModButton').prop("disabled", btf);
    } catch (ex) {
        try {
            // older version jquery...
            $('#rodEndModButton').attr("disabled", btf ? "disabled" : "");
        } catch (ex) {
        }
    }
}

function rodEndChange() {
    // look at the latest change and update the status if ready...
    // see if the parameters have changed for AJAX call to update
    // the state of the Rod End.
    // configuration must be a complete / valid but Rod End design can be partial / invalid
    currentRodEndStatus = false;
    var showRodEndArea = true;
    if (typeof window["setRodEndDesignStatus"] === "function") setRodEndDesignStatus(false);
    $('#rodEndStatus').removeClass("rodDesignOK").removeClass("rodDesignFail");
    if (currentConfigState == 'Complete') {
        setRodEndModButtonDisabled(false);
        var complete = isRodEndInputsComplete();
        $('#rodEndStatus').html(re_msg_checking);
        getXRodEvaluate();
        /* this seems to be replaces with later UI requests
        if (!validRodEnds) {
            // no valid rod ends hide the rod end area and disable the button
            setRodEndModButtonDisabled( true );
            showRodEndArea = false;
        }
        */
    } else if (currentConfigState == 'Partial') {
        if (nonBuilderComplete) {
            setRodEndModButtonDisabled(false);
        } else {
            setRodEndModButtonDisabled(true);
            showRodEndArea = false;
        }
    } else { //'Invalid'
        setRodEndModButtonDisabled(true);
        $('#rodEndStatus').html(re_msg_valid_config);
    }
    if (showRodEndArea) {
        // don't do anything, only show hide with button
        //$('#xRodFormArea').show();
        //rodEndDesignView(true);
    } else {
        rodEndDesignView(false);
    }
}

function rodEndBuildForm() {
    rodEndFormLoaded = true;
    var isUserInit = false;
    if (rodEndFormData == null || !rodEndFormData.hasOwnProperty('rodends')) {
        return;
    }
    if (!rodEndFormData.rodends.hasOwnProperty(currentXRodChoice==""?"none":currentXRodChoice)) {
        // display an error where the form would go, you could also use an alert or custom message pop up.
        $('#xRodFormArea').html("Rod End " + currentXRodChoice.toUpperCase() + " not found in spreadsheet.");
        return;
    }
    // delete the user variable mm so the default will be used instead
    // delete currentUserValues.mm;

    if (userInitVars!== "" && Object.keys(userInitVars).length) {
        // first time only init with user keys from XML config
        currentUserValues = userInitVars;
        userInitVars = "";
        isUserInit = true;
    }

    var oRodEnd = rodEndFormData.rodends[currentXRodChoice==""?"none":currentXRodChoice];
    rodEndFormThreadSelect = null;
    // Use JQUERY to create an input form.
    var table = $('<table>', { 'class': 'builder' }); // Image & form container
    // rodEndDefText row
    table.append($('<tr>', {}).append($('<td>', { 'colspan': '2' }).append($('<span/>').attr({ id: 'rodEndDefText' }))));
    var tr1 = $('<tr>', {});
    table.append(tr1);
    var tablef = $('<table>', { 'class': 'rodEndTable' }); // form container
    tr1.append($('<td>', {}).append(tablef));
    tr1.append($('<td>', { id: 'rodEndLargeImage' }).html("&nbsp;"));
    $('#xRodFormArea').empty();
    $('#xRodFormArea').append(table);
    // top status row
    var tr = $('<tr>', { 'class': 'rodEndStatusRow' });
    tr.append($('<td>').html("&nbsp;").attr({ 'class': 'rodEndStatusRow', id: 'rodEndStatus', 'colspan': '4' }));
    tablef.append(tr);
    // input rows
    $.each(oRodEnd.input, function (index, oInput) {
        // looping through input fields
        var tr = $('<tr>', { 'class': 'rodEndRow' });
        var tdLab = $('<td>', { 'class': 'rodInputLabel' }).text(oInput.label);
        var defaultVal = currentUserValues.hasOwnProperty(oInput.label.toLowerCase()) ? currentUserValues[oInput.label.toLowerCase()] : "";
        var tdInput;
        if (typeof formAddInputClasses === typeof undefined) formAddInputClasses = "";
        if (typeof formAddSelectClasses === typeof undefined) formAddSelectClasses = "";
        if (oInput.variable.toLowerCase() == "mm") {
            // MM designated as the thread size replace input with select
            var threadSel = $('<select>').attr({
                'class': 'rodInputValue ' + formAddSelectClasses, id: 'rodInput_' + index, 'vname': oInput.variable.toLowerCase(),
                'data-native-menu': false
            }); // for mobile
            threadSel.append($('<option>').attr({ 'value': '' }).text("Select Thread"));
            $.each(rodEndFormData.threads, function (i, thread) {
                // looping through options
                thread = thread.replace("%20"," ").replace("%2520"," ");
                threadSel.append($('<option>').attr({ 'value': thread }).text(thread));
            });
            tdInput = $('<td>', { 'class': 'rodInputValue' }).append(threadSel);
            rodEndFormThreadSelect = threadSel;
            if (defaultVal != "") {
                rodEndFormThreadSelect.val(defaultVal);
                $(".rodInputValue [vname='mm']").val(defaultVal);
                if (isUserInit) {
                    rodEndFormThreadSelect.attr('userset', '1');
                }
            }
            try {
                tdInput.on("change", function () {
                    rodEndFormThreadSelect.attr('userset', (rodEndFormThreadSelect.val() == "" ? '0' : '1'));
                    rodEndChange();
                });
            } catch (ex) {
                // for older version of jquery
                tdInput.bind("change", function (e) {
                    rodEndFormThreadSelect.attr('userset', (rodEndFormThreadSelect.val() == "" ? '0' : '1'));
                    rodEndChange();
                    e.stopPropagation();
                });
            }
        } else {
            var tInput = $('<input/>')
                .attr({ 'class': 'rodInputValue ' + formAddInputClasses, type: 'text', id: 'rodInput_' + index, 'vname': oInput.variable.toLowerCase() });
            tdInput = $('<td>', { 'class': 'rodInputValue' }).append(tInput);
            tInput.val(defaultVal);
            try {
                tdInput.on("change", function () {
                    rodEndChange();
                });
            } catch (ex) {
                // for older version of jquery
                tdInput.bind("change", function (e) {
                    rodEndChange();
                    e.stopPropagation();
                });
            }
        }

        var tdMsg = $('<td>', { 'class': 'rodInputMessage', id: 'rodInputMsg_' + index }).html("&nbsp;");
        var tdStatus = $('<td>', { 'class': 'formStatusNO_OK', id: 'rodInputStatus_' + index }).html("&nbsp;");
        tr.append(tdLab);
        tr.append(tdInput);
        tr.append(tdStatus);
        tr.append(tdMsg);
        tablef.append(tr);
    });
    var tr = $('<tr>', { 'class': 'rodEndRow' });
    tablef.append(tr).append($('<td>').html("&nbsp;")).append($('<td>').html("&nbsp;"));
    $.each(oRodEnd.output, function (index, oOutput) {
        // looping through output fields
        var tr = $('<tr>', { 'class': 'rodEndRow' });
        if (oOutput.label != "") {
            // var = value row
            var tdLab = $('<td>', { 'class': 'rodOutputLabel' }).text(oOutput.label + "=");
            var tdOutput = $('<td>', { 'class': 'rodOutputValue', 'colspan': '2' }).append($('<span/>').attr({ id: 'rodOutput_' + index }));
            tr.append(tdLab);
            tr.append(tdOutput);
        } else {
            // message row
            var tdLab = $('<td>', { 'colspan': '4' }).append($('<div/>').attr({ 'class': 'rodOutputMessage', 'id': 'rodOutput_' + index }));
            tr.append(tdLab);
        }
        tablef.append(tr);
    });
    checkSelectedComboOptions();
    // set image
    $('#rodEndLargeImage').empty();
    var code = currentXRodChoice.toLowerCase();
    if (rodEndProps.hasOwnProperty("rod_end_def_image")
        && rodEndProps.rod_end_def_image.hasOwnProperty(code)) {
        var img = rodEndFormImagePath + rodEndProps.rod_end_def_image[code];
        $('#rodEndLargeImage').append($('<img>', { 'class': 'rodEndLargeImage', 'src': img }));
    } else {
        $('#rodEndLargeImage').html("&nbsp;");
    }








    if (rodEndFormHasTrunnion) {
        // Use JQUERY to create an input form.
        var ttable = $('<table>', { 'class': 'builder' }); // Image & form container
        var tr1 = $('<tr>', {});
        ttable.append(tr1);
        var tablef = $('<table>', { 'class': 'rodEndTable' }); // form container
        tr1.append($('<td>', {}).append(tablef));
        tr1.append($('<td>', { id: 'trunnionLargeImage' }).html("&nbsp;"));
        $('#xTrunnionFormArea').empty();
        $('#xTrunnionFormArea').append(ttable);
        // top status row
        var tr = $('<tr>', { 'class': 'rodEndStatusRow' });
        tr.append($('<td>').html("&nbsp;").attr({ 'class': 'rodEndStatusRow', id: 'trunnionStatus', 'colspan': '4' }));
        tablef.append(tr);
        // input rows
        $.each(oRodEnd.input_trunnion, function (index, oInput) {
            // looping through input fields
            var tr = $('<tr>', { 'class': 'rodEndRow' });
            var tdLab = $('<td>', { 'class': 'rodInputLabel' }).text(oInput.label);
            var defaultVal = currentUserValues.hasOwnProperty(oInput.label.toLowerCase()) ? currentUserValues[oInput.label.toLowerCase()] : "";
            var tdInput;
            if (typeof formAddInputClasses === typeof undefined) formAddInputClasses = "";
            if (typeof formAddSelectClasses === typeof undefined) formAddSelectClasses = "";
            var tInput = $('<input/>')
                .attr({ 'class': 'rodInputValue ' + formAddInputClasses, type: 'text', id: 'trunnionInput_' + index, 'vname': oInput.variable.toLowerCase() });
            tdInput = $('<td>', { 'class': 'rodInputValue' }).append(tInput);
            tInput.val(defaultVal);
            try {
                tdInput.on("change", function () {
                    rodEndChange();
                });
            } catch (ex) {
                // for older version of jquery
                tdInput.bind("change", function (e) {
                    rodEndChange();
                    e.stopPropagation();
                });
            }

            var tdMsg = $('<td>', { 'class': 'rodInputMessage', id: 'trunnionInputMsg_' + index }).html("&nbsp;");
            var tdStatus = $('<td>', { 'class': 'formStatusNO_OK', id: 'trunnionInputStatus_' + index }).html("&nbsp;");
            tr.append(tdLab);
            tr.append(tdInput);
            tr.append(tdStatus);
            tr.append(tdMsg);
            tablef.append(tr);
        });
        var tr = $('<tr>', { 'class': 'rodEndRow' });
        tablef.append(tr).append($('<td>').html("&nbsp;")).append($('<td>').html("&nbsp;"));
        $.each(oRodEnd.output_trunnion, function (index, oOutput) {
            // looping through output fields
            var tr = $('<tr>', { 'class': 'rodEndRow' });
            if (oOutput.label != "") {
                // var = value row
                var tdLab = $('<td>', { 'class': 'rodOutputLabel' }).text(oOutput.label + "=");
                var tdOutput = $('<td>', { 'class': 'rodOutputValue', 'colspan': '2' }).append($('<span/>').attr({ id: 'trunnionOutput_' + index }));
                tr.append(tdLab);
                tr.append(tdOutput);
            } else {
                // message row
                var tdLab = $('<td>', { 'colspan': '4' }).append($('<div/>').attr({ 'class': 'rodOutputMessage', 'id': 'trunnionOutput_' + index }));
                tr.append(tdLab);
            }
            tablef.append(tr);
        });

        ttable.trigger("create");

    }





    table.trigger("create");
    rodEndChange();
    $('#rodEndDefText').html(getRodEndDefText(currentXRodChoice==""?"none":currentXRodChoice));
}

function isRodEndInputsComplete() {
    // check that all input fields are
    if (rodEndFormData == null || !rodEndFormData.hasOwnProperty("rodends")) {
        //|| !rodEndFormData.rodends.hasOwnProperty(currentXRodChoice==""?"none":currentXRodChoice)
        return false;
    }
    var complete = true;
    currentUserValues = {};
    rodendUserValues = {};
    trunnionUserValues = {};
    var oRodEnd = rodEndFormData.rodends[currentXRodChoice==""?"none":currentXRodChoice];
    $.each(oRodEnd.input, function (index, oInput) {
        // looping through input fields
        if ($('#rodInput_' + index).val() == "") {
            complete = false;
        }
        currentUserValues[$('#rodInput_' + index).attr("vname")] = $('#rodInput_' + index).val();
        rodendUserValues[$('#rodInput_' + index).attr("vname")] = $('#rodInput_' + index).val();
    });

    $.each(oRodEnd.input_trunnion, function (index, oInput) {
        // looping through input fields
        if ($('#trunnionInput_' + index).val() == "") {
            complete = false;
        }
        currentUserValues[$('#trunnionInput_' + index).attr("vname")] = $('#trunnionInput_' + index).val();
        trunnionUserValues[$('#trunnionInput_' + index).attr("vname")] = $('#trunnionInput_' + index).val();
    });
    // load the user input into the extra attributes of the dom to get written out in favorite XML
    for (var domid in oDomains.domains) {
        if (oDomains.domains.hasOwnProperty(domid)) {
            var oDom = oDomains.domains[domid];
            if (oDom.code == 'XROD_ENDS') {
                var userAtt = {};
                $.each(rodendUserValues, function (key, data) {
                    userAtt["user_" + key] = euNumberParse(data);
                });
                oDom.extraAttributes = userAtt;
            }
            if (oDom.code == 'TRUNNION') {
                var userAtt = {};
                $.each(trunnionUserValues, function (key, data) {
                    userAtt["user_" + key] = euNumberParse(data);
                });
                oDom.extraAttributes = userAtt;
            }
        }
    }
    return complete;
}

function getXRodForm() {
    var ajaxurl = ccServer + "/cc_host/pages/public/custom/smc/services/getRodFormData.cfm";
    $('#xRodFormError').empty();
    $('#xTrunnionFormError').empty(); // clear possible error messages
    if (rodEndFormRequestInProgress) return;
    rodEndFormRequestInProgress = true; // will remain true on success - only need to be called once
    showLoading(true);
    $.ajax({
            type: "POST"
            , url: ajaxurl
            , dataType: "json"
            , data: {
                product_id: product_id
                , rod_end: currentXRodChoice
                , catalog_code: catalog_code
                , locale_code: locale_code
                , debug: rodEndDebug
            }
            , success: function (data) {
                if (data === null && typeof data !== 'object') {
                    $('#xRodFormError').html("Getting rod end form failed. data return invalid. data= " + data);
                    return;
                }
                if (data.status) {
                    // create user input form in container xRodFormArea
                    rodEndFormData = data;
                    rodEndBuildForm();
                    showLoading(false);
                    rodEndChange();
                } else {
                    // display an error where the form would go, you could also use an alert or custom message pop up.
                    $('#xRodFormError').html("Getting rod end form failed: " + data.failure_message);
                    showLoading(false);
                    rodEndFormRequestInProgress = false;
                }
            }
            , error: function (xhr, textStatus, thrownError) {
                rodEndFormRequestInProgress = false;
                showLoading(false);
                ajaxError(xhr, textStatus, thrownError);
            }
        }
    );
}

function getXRodEvaluate() {
    if (!rodEndFormLoaded) return;
    // evaluate the user input and get the design results back
    var ajaxurl = ccServer + "/cc_host/pages/public/custom/smc/services/evalRodFormData.cfm";
    $('#xRodFormError').empty();
    $('#xTrunnionFormError').empty(); // clear possible error messages
    // comment out below so will continue with a 'None" sheet to get movex
    //if (currentXRodChoice == "") return;
    // get the current data values
    var dataValues = {};
    if (rodEndFormData === undefined || rodEndFormData.rodends  === undefined){
        return;
    }
    var oRodEnd = rodEndFormData.rodends[currentXRodChoice==""?"none":currentXRodChoice];
    $.each(oRodEnd.input, function (index, oInput) {
        // looping through input fields
        dataValues[$('#rodInput_' + index).attr("vname")] = euNumberParse($('#rodInput_' + index).val());
    });
    $.each(oRodEnd.input_trunnion, function (index, oInput) {
        // looping through input fields
        dataValues[$('#trunnionInput_' + index).attr("vname")] = euNumberParse($('#trunnionInput_' + index).val());
    });
    showLoading(true);
    // hide or show based on choices
    setRodEndAreaVisibility();
    $.ajax({
            type: "POST"
            , url: ajaxurl
            , dataType: "json"
            , data: {
                product_id: product_id
                , rod_end: currentXRodChoice==""?"none":currentXRodChoice
                , configuration: JSON.stringify(currentConfigValues)
                , user_input: JSON.stringify(dataValues)
                , catalog_code: catalog_code
                , logcat_code: logcat_code
                , locale_code: locale_code
                , debug: rodEndDebug
            }
            , success: function (data) {
                showLoading(false);
                if (data === null && typeof data !== 'object') {
                    $('#xRodFormError').html("Evaluating rod end form failed. data return invalid. data= " + data);
                    return;
                }
                $('#rodEndStatus').html("");
                if (data.status && typeof data.rodend_status === typeof undefined) {
                    data.status = false;
                    data.failure_message = "Rod End Status was not defined, check spreadsheet.";
                }
                if ($("#product_series_code") !== undefined && data.movex !== undefined && data.movex.serie !== undefined){
                    $("#product_series_code").val(data.movex.serie);
                }
                $('#trunnionStatus').html("");
                if (data.status) { // request status
                    // clear rod end status
                    $('#rodEndStatus').removeClass("rodDesignOK").removeClass("rodDesignFail");
                    currentRodEndStatus = false;
                    if (data.rodend_status.code.trim() != "") {
                        // special processing for the status row
                        $('#rodEndStatus').html(data.rodend_status.message);
                        if (data.rodend_status.code.toLowerCase() == "re_msg_ok" || data.rodend_status.code.toLowerCase() == "ok") {
                            // design OK
                            $('#rodEndStatus').addClass("rodDesignOK");
                            if (typeof window["setRodEndDesignStatus"] === "function") setRodEndDesignStatus(true);
                            currentRodEndStatus = true;
                        } else {
                            // design failed
                            $('#rodEndStatus').addClass("rodDesignFail");
                        }
                    } else {
                        if (currentConfigState == 'Complete') {
                            var complete = isRodEndInputsComplete();
                            if (!complete) {
                                $('#rodEndStatus').html(re_msg_fill_form);
                            }
                        } else {
                            $('#rodEndStatus').html(re_msg_valid_config);
                        }
                    }


                    if (data.trunnion_status.code.trim() != "") {
                        // special processing for the status row
                        $('#trunnionStatus').html(data.trunnion_status.message);
                        if (data.trunnion_status.code.toLowerCase() == "re_msg_ok" || data.trunnion_status.code.toLowerCase() == "ok") {
                            // design OK
                            $('#trunnionStatus').removeClass("rodDesignFail");
                            $('#trunnionStatus').addClass("rodDesignOK");
                            if (typeof window["setRodEndDesignStatus"] === "function") setRodEndDesignStatus(true);
                            currentRodEndStatus = true;
                        } else {
                            // design failed
                            $('#trunnionStatus').removeClass("rodDesignOK");
                            $('#trunnionStatus').addClass("rodDesignFail");
                        }
                    }



                    // get the trunnion image if selected
                    for (var domid in oDomains.domains) {
                        if (oDomains.domains.hasOwnProperty(domid)) {
                            var oDom = oDomains.domains[domid];
                            if (oDom.hint != '' && oDom.hint.search("TRUNNION")>=0) {
                                trunnionImage = oDom.members[oDom.aDSV[0]].image.trim();
                                if (trunnionImage != "") {
                                    trunnionImage = trunnionImage.substr(("/"+trunnionImage).lastIndexOf('/'));
                                    trunnionImage = rodEndFormImagePath + trunnionImage;
                                }
                                break;
                            }
                        }
                    }
                    // set image
                    $('#trunnionLargeImage').empty();
                    if (trunnionImage == "") {
                        $('#trunnionLargeImage').html("&nbsp;")
                    } else {
                        $('#trunnionLargeImage').append($('<img>', { 'class': 'rodEndLargeImage', 'src': trunnionImage }));
                    }

                    // update thread select
                    currentMinThread = data.thread.hasOwnProperty("min") ? data.thread.min : "";
                    currentMaxThread = data.thread.hasOwnProperty("max") ? data.thread.max : "";
                    updateThreadSelect();

                    // fill in output
                    $.each(data.output, function (index, oOutput) {
                        // looping through output fields
                        if (oOutput.value != "" || oOutput.label != "") {
                            $('#rodOutput_' + index).text(oOutput.value);
                        } else {
                            $('#rodOutput_' + index).text(oOutput.message);
                        }
                    });

                    // fill in input
                    currentDefaultValues = {};
                    $.each(data.input, function (index, oInput) {
                        // looping through input fields
                        $('#rodInput_' + index).attr("placeholder", oInput.default);
                        $('#rodInputMsg_' + index).text(oInput.message);
                        // set the status icon (Change to move OK icon to message TD)
                        $('#rodInputStatus_' + index).removeClass("formStatusOK");
                        $('#rodInputStatus_' + index).removeClass("formStatusNO_OK");
                        $('#rodInputMsg_' + index).removeClass("formStatusOK");
                        if (oInput.rkey.toLowerCase().indexOf("re_msg_ok") == 0 || oInput.rkey.toLowerCase() == "ok") {
                            //$('#rodInputStatus_' + index).addClass("formStatusOK");
                            // per Gorka hide the message and replace it with a checkbox (class: formStatusOK)
                            $('#rodInputMsg_' + index).text("");
                            $('#rodInputStatus_' + index).addClass("formStatusOK");
                        } else {
                            $('#rodInputStatus_' + index).addClass("formStatusNO_OK");
                        }
                        if (oInput.variable == "MM") {
                            if ($('#rodInput_' + index).attr("userset") == '1') {
                                currentDefaultValues[oInput.variable] = oInput.value;
                            } else {
                                currentDefaultValues[oInput.variable] = oInput.default;
                                // set the select to the default
                                $('#rodInput_' + index).val(oInput.default);
                            }
                        } else {
                            currentDefaultValues[oInput.variable] = oInput.value;
                            // set the input to the formatted value
                            $('#rodInput_' + index).val(euNumberFormat(oInput.value));
                        }
                    });

                    $.each(data.input_trunnion, function (index, oInput) {
                        // looping through input fields
                        $('#trunnionInput_' + index).attr("placeholder", oInput.default);
                        $('#trunnionInputMsg_' + index).text(oInput.message);
                        // set the status icon (Change to move OK icon to message TD)
                        $('#trunnionInputStatus_' + index).removeClass("formStatusOK");
                        $('#trunnionInputStatus_' + index).removeClass("formStatusNO_OK");
                        $('#trunnionInputMsg_' + index).removeClass("formStatusOK");
                        if (oInput.rkey.toLowerCase().indexOf("re_msg_ok") == 0 || oInput.rkey.toLowerCase() == "ok") {
                            //$('#rodInputStatus_' + index).addClass("formStatusOK");
                            // per Gorka hide the message and replace it with a checkbox (class: formStatusOK)
                            $('#trunnionInputMsg_' + index).text("");
                            $('#trunnionInputStatus_' + index).addClass("formStatusOK");
                        } else {
                            $('#trunnionInputStatus_' + index).addClass("formStatusNO_OK");
                        }
                        currentDefaultValues[oInput.variable] = oInput.value;
                        // set the input to the formatted value
                        $('#trunnionInput_' + index).val(euNumberFormat(oInput.value));
                    });
                    // format the cadenas variables string
                    currentCADenasValues = "";
                    $.each(data.cadenas, function (index, oCadenas) {
                        currentCADenasValues += (currentCADenasValues == "" ? "" : ",") + "{" + oCadenas.variable + "=" + oCadenas.value + "}";
                    });
                    // format the movex sting
                    currentMovexValues = JSON.stringify(data.movex);

                } else {
                    showLoading(false);
                    // display an error where the form would go, you could also use an alert
                    // or custom message pop up.
                    $('#xRodFormError').html("Evaluating rod end form failed: " + data.failure_message);
                }
                if (typeof rodEndChangeFinishNotify === "function") {
                    rodEndChangeFinishNotify();
                }

            }
            , error: function (xhr, textStatus, thrownError) {
                showLoading(false);
                ajaxError(xhr, textStatus, thrownError);
            }
        }
    );
}

function setRodEndAreaVisibility() {
    // hide or show based on choices
    if (currentXRodChoice=="") {
        $("#xRodFormError").hide();
        $("#xRodFormArea").hide();
    } else {
        $("#xRodFormError").show();
        $("#xRodFormArea").show();
    }
    if (currentTrunnionChoice=="") {
        $("#xTrunnionFormError").hide();
        $("#xTrunnionFormArea").hide();
    } else {
        $("#xTrunnionFormError").show();
        $("#xTrunnionFormArea").show();
    }
}

function ajaxError(xhr, textStatus, thrownError) {
    showLoading(false);
    $('#xRodFormError').html("AJAX Error: " + textStatus + " - " + thrownError);//+ " - " + xhr.responseText
}

function showLoading(btf) {
    if ($('#loading').length) {
        if (btf) {
            $('#loading').show();
        } else {
            if (rodEndFormLoaded) {
                $('#loading').hide();
            }
        }
    }
}

function rodEndDesignView(bTF) {
    // if bTF is undefined then toggle the view
    var builderObjs = $("tr.builder");
    if (builderObjs.size() == 0) {
        builderObjs = $("div.builder");
    }
    var vis = true;
    if (typeof bTF !== typeof undefined) {
        vis = bTF;
    } else {
        // toggle
        vis = builderObjs.size() > 0 && builderObjs.eq(0).is(":visible");
        vis = !vis;
    }
    if (vis) {
        // hide or show based on choices
        setRodEndAreaVisibility();
        builderObjs.each(function () {
            $(this).css("display", "");
            $(this).show();
        });
    } else {
        $("#xRodFormError").hide();
        $("#xRodFormArea").hide();
        $("#xTrunnionFormError").hide();
        $("#xTrunnionFormArea").hide();

        builderObjs.each(function () {
            $(this).css("display", "");
            $(this).hide();
        });
    }

    if (typeof specialConfOptionsViewFinishNotify === "function") {
        specialConfOptionsViewFinishNotify(vis);
    }
}

function initPropertyImages() {
    var path = "";
    if (rodImagePath.hasOwnProperty("rod_end_sel_image")) {
        path = rodImagePath["rod_end_sel_image"];
    }
    if (rodEndProps.hasOwnProperty("rod_end_sel_image")) {
        $(".re_image").each(function (index) {
            var code = $(this).attr("re_code").toLowerCase();
            if (rodEndProps.rod_end_sel_image.hasOwnProperty(code)) {
                $(this).attr('src', path + rodEndProps.rod_end_sel_image[code]);
                $(this).attr('data-image', rodEndProps.rod_end_sel_image[code]);

            }
        });
    }
    rodEndFormImagePath = "";
    if (rodImagePath.hasOwnProperty("rod_end_def_image")) {
        rodEndFormImagePath = rodImagePath["rod_end_def_image"];
    }
}

function getRodEndDefText(code) {
    var txt = "";
    if (rodEndProps.hasOwnProperty("rod_end_def_text")) {
        txt = rodEndProps.rod_end_def_text[code];
    }
    return txt;
}

function rodEndDesignInit() {
    if (!isEURodEnd) {
        return;
    }

    // reset images if properties used to define them
    initPropertyImages();

    // inject the button, find the div with the class "builder" and insert
    // a new div above with the button "Rod End Modification" (re_rod_end_mod_button)
    var button = $('<input>', { 'type': 'button', 'id': 'rodEndModButton', 'class': 'rodEndModButton', 'value': re_rod_end_mod_button });
    // this is for the mobile page...
    var builderObjs = $("div.builder");
    if (builderObjs.size() > 0) {
        // inject the button
        builderObjs.eq(0).before(button);
    } else {
        // this is for the desktop page...
        builderObjs = $("tr.builder");
        if (builderObjs.size() > 0) {
            // inject the button
            var bRow = $("<tr></tr>").append($("<td>", { "colspan": "3" }).append(button));
            builderObjs.eq(0).before(bRow);
        }
    }

    // move the XROD_ENDS dom row to the end of the table
    var rodtr = null;
    if (builderObjs.size() > 0) {
        rodtr = builderObjs.first();
        if (builderObjs.size() > 1) {
            rodtr.insertAfter(builderObjs.last());
        }
    }

    // create a new row at the end of the table and move the images into it.
    builderObjs = $("tr.builder");
    var tdimages = $("<td>", { "colspan": "3" });
    tdimages.append($("<span>", { 'class': 'pickImageLabel' }).append(re_msg_select_rodend_mod + "<br/>").css('display', "none"));
    var bRow = $("<tr>", { 'class': 'builder' }).append(tdimages);
    builderObjs.last().after(bRow);

    $(".rod_sel_images_container").appendTo(tdimages);

    // switch ID to new TD
    $('#scroll_div_' + rodEndDom).attr('id', '');
    tdimages.attr('id', 'scroll_div_' + rodEndDom);
    // move the divs xRodFormError & xRodFormArea into the table
    bRow = $("<tr>", { 'class': 'builder' }).append($("<td>", { "colspan": "3" }).append($("#xRodFormError")).append($("#xRodFormArea")));
    $("tr.builder").last().after(bRow);
    builderObjs = $("tr.builder");
    for (var domid in oDomains.domains) {
        if (oDomains.domains.hasOwnProperty(domid)) {
            var oDom = oDomains.domains[domid];
            if (oDom.hint != '' && oDom.hint.search("TRUNNION")>=0) {
                $("#CROW_"+oDom.did).insertAfter(builderObjs.last());
                rodEndFormHasTrunnion = true;

            }
        }
    }
    // add in divs for the post trunnion area
    bRow = $("<tr>", { 'class': 'builder' });
    var bTd = $("<td>", { "colspan": "3" });
    bRow.append(bTd)
    bTd.append($("<div>", { 'id':'xTrunnionFormError'}).text(""));
    bTd.append($("<div>", { 'id':'xTrunnionFormArea'}).text(""));
    $("tr.builder").last().after(bRow);
    if (rodEndFormHasTrunnion) {
        $("#xTrunnionFormError").show();
        $("#xTrunnionFormArea").show();
    } else {
        $("#xTrunnionFormError").hide();
        $("#xTrunnionFormArea").hide();
    }

    // add the event handler for the button
    button.click(
        function () {
            rodEndDesignView();
        });
    if (typeof bConfigInit === typeof undefined) {
        bConfigInit = false;
    }
    if (bConfigInit && !isRodEndNone()) {
        // start with everything visable...
        setRodEndModButtonDisabled(false);
        rodEndDesignView(true);
    } else {
        // start with everything hidden...
        setRodEndModButtonDisabled(true);
        rodEndDesignView(false);
    }
    getXRodForm();
    // change apperance of rod end selection for SMC EU
    if (rodtr != null) {
        // this is for the desktop page...
        rodtr.find('td:first').css('display', 'none');
        rodtr.find('.closeFilter').css('display', 'none');
        rodtr.find('td:nth-child(2)').attr('colspan', '2');
        $('#scroll_div_' + rodEndDom).find('img').each(function () {
            $(this).css('display', '');
        });
        $('.pickImageLabel').css('display', '');

        $('#dom_' + rodEndDom + "_ph").css('display', 'none');
        $('#rodend_filter').css('display', '');
        $('#re_filter_select').attr('style', '');
    }
    $('.optionLabel').each(function () {
        $(this).removeAttr('nowrap');
    });
    $('#cpn_partnumber').removeAttr('class', '');
    $(".rod_sel_images_container img").each(function(){
        $(this).click(function(){
            setTimeout(function(){
                $(".rodInputValue").first().trigger('change');
            },1000);
        });
    });

}

function euNumberFormat(num) {
    // to one decimal place and use a "," instead of a "."
    if (String(num).trim() == "") {
        return "";
    }

    // start making sure the number has a "." not a ","
    var snum = (""+num).replace(",", ".");
    if (isNaN(snum)) {
        return num;
    }
    // make one decimal place
    var nnum = Math.round(Number(snum)*10)/10;
    snum = (""+nnum).replace(".", ",");
    snum = snum.replace(",0", "");
    return snum;
}

function euNumberParse(num) {
    // convert euNumberFormat to standard
    // start making sure the number has a "." not a ","
    var snum = (""+num).replace(",", ".");
    if (isNaN(snum)) {
        return num;
    }
    return snum;
}


function checkSelectedComboOptions(){
    $(".rodEndRow .rodInputValue select").each(function(){
        var vName = $(this).attr("vname");
        var vNameValue = currentUserValues[vName];
        if (vNameValue !== null &&  vNameValue !== undefined && vNameValue !== ""){
            vNameValue = vNameValue.replace("%20"," ");
            $(this).val(vNameValue);
        }
    });
}