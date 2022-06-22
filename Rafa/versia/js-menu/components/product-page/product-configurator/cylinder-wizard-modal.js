(function(globalConfig) {
    function CylinderWizardModal(config) {
        this.id = config.id;
        this.config = config;
    }

    CylinderWizardModal.prototype.init = init;
    CylinderWizardModal.prototype.initializeEvents = initializeEvents;
    CylinderWizardModal.prototype.resetWizard = resetWizard;
    CylinderWizardModal.prototype.nextTab = nextTab;
    CylinderWizardModal.prototype.previousTab = previousTab;
    // CylinderWizardModal.prototype.finishWizard = finishWizard;
    CylinderWizardModal.prototype.skipTab = skipTab;
    CylinderWizardModal.prototype.removeActive = removeActive;
    CylinderWizardModal.prototype.addActive = addActive;
    CylinderWizardModal.prototype.getCurrentTab = getCurrentTab;
    CylinderWizardModal.prototype.getNextTabId = getNextTabId;
    CylinderWizardModal.prototype.getPreviousTabId = getPreviousTabId;
    CylinderWizardModal.prototype.searchCustomers = searchCustomers;
    CylinderWizardModal.prototype.checkForSubmit = checkForSubmit;
    CylinderWizardModal.prototype.checkIfTabInfoCompleted = checkIfTabInfoCompleted;
    CylinderWizardModal.prototype.createSimpleSpecialOptions = createSimpleSpecialOptions;
    CylinderWizardModal.prototype.checkCustomerInputStatus = checkCustomerInputStatus;
    CylinderWizardModal.prototype.changeTab = changeTab;
    // CylinderWizardModal.prototype.loadSummary = loadSummary;
    // CylinderWizardModal.prototype.loadSummaryZipContent = loadSummaryZipContent;
    // CylinderWizardModal.prototype.zipDownload = zipDownload;
    CylinderWizardModal.prototype.zipDownload = downloadAndFinish;
    CylinderWizardModal.prototype.enableElement = enableElement;
    CylinderWizardModal.prototype.disableElement = disableElement;
    CylinderWizardModal.prototype._prepareLoading = _prepareLoading;
    CylinderWizardModal.prototype._prepareUnloading = _prepareUnloading;
    CylinderWizardModal.prototype.hideError = hideError;
    CylinderWizardModal.prototype.showError = showError;
    CylinderWizardModal.prototype.hideAlert= hideAlert;
    CylinderWizardModal.prototype.showAlert = showAlert;
    CylinderWizardModal.prototype.showConfirmationModal = showConfirmationModal;
    CylinderWizardModal.prototype.showWizardModal = showWizardModal;
    CylinderWizardModal.prototype.showSummaryModal = showSummaryModal;
    CylinderWizardModal.prototype.loadPricesConfirmDataTable = loadPricesConfirmDataTable;
    CylinderWizardModal.prototype.finishActions = finishActions;
    CylinderWizardModal.prototype.disableConfiguratorOptions = disableConfiguratorOptions;
    CylinderWizardModal.prototype.acceptSimplePartNumberCreation = acceptSimplePartNumberCreation;
    CylinderWizardModal.prototype.checkWizardButtonsVisibility = checkWizardButtonsVisibility;
    CylinderWizardModal.prototype.parseAccesories = parseAccesories;
    CylinderWizardModal.prototype.loadSummaryBySimpleSpecial = loadSummaryBySimpleSpecial;
    CylinderWizardModal.prototype.closeWizard = closeWizard;

    function init() {
        console.log("[Cylinder-wizard-modal] Init");
        this.$nextButton = $('#btn-next');
        this.$backButton = $('#btn-back');
        this.$finishButton = $('#btn-finish');
        this.$finishSummaryButton = $('#btn-summary-finish');
        this.$finishConfirmButton = $('#btn-confirm-finish');
        this.$closeButton = $("#btn-close");
        this.$resetButton = $('#btn-reset-selection');
        this.$skipButton = $('#btn-skip');
        this.$searchCustomerButton=$("#btn-search-customer");
        // this.$acceptButton=$("#btn-accept");
        this.$cancelButton=$("#simpleSpecialCreationWizardModal #btn-return");
        // this.$zipDownloadButton=$("#btn-submit-download-sscw-zip");
        this.$simpleSpecialPartNumberInput = $("#simple_special_part_number");
        // this.$aliasInput = $("#alias");
        this.templates = {
            spinnerTemplateHTML: document.getElementById('spinner-template').innerHTML
        };
        this.initializeEvents();
        this.resetWizard();
        $(".sscw__create_simple_special__option").bind("click",createSimpleSpecialOptions);
        // getCadOptions();
        var currentSimpleSpecialCodeInUrl = getUrlParameter("simpleSpecialCode");
        if (currentSimpleSpecialCodeInUrl !== undefined && currentSimpleSpecialCodeInUrl !== ""){
            this.disableConfiguratorOptions();
        }
        this.zipError = false;
    }

    function initializeEvents() {
        console.log("[Cylinder-wizard-modal] initializeEvents");
        var _self = this;
        var $document = $(document);
        this.$finishSummaryButton.click(this.showConfirmationModal.bind(this));
        this.$finishConfirmButton.click(this.showWizardModal.bind(this));
        this.$nextButton.click(this.nextTab.bind(this));
        this.$backButton.click(previousTab.bind(this));
        // this.$finishButton.click(finishWizard.bind(this));
        this.$finishButton.click(downloadAndFinish.bind(this));
        this.$closeButton.click(closeWizard.bind(this));
        this.$resetButton.click(resetWizard.bind(this));
        this.$skipButton.click(skipTab.bind(this));
        this.$searchCustomerButton.click(searchCustomers.bind(this));
        // this.$acceptButton.click(acceptSimplePartNumberCreation.bind(this));
        // this.$zipDownloadButton.click(zipDownload.bind(this));
        this.$customerNameInput = $("#customer_name");
        this.$customerNameInput.keyup(checkCustomerInputStatus.bind(this));
        this.$customerNameInput.keypress(checkForSubmit.bind(this));
        this.$customerNumberInput = $("#customer_number");
        this.$customerNumberInput.keyup(checkCustomerInputStatus.bind(this));
        this.$customerNumberInput.keypress(checkForSubmit.bind(this));
        this.$simpleSpecialPartNumberInput.keyup(function(){
            if (_self.$simpleSpecialPartNumberInput.val() !== "" && _self.$simpleSpecialPartNumberInput.val().length >= 3){
                // enableElement(_self.$acceptButton);
                enableElement(_self.$nextButton);
            }else {
                // disableElement(_self.$acceptButton);
                disableElement(_self.$nextButton);
            }
        });
        $("#new").click(function (){
            if ($("#new").is(":checked")){
                $("#new_version_label").addClass("hidden");
                $("#new_ss_label").removeClass("hidden");
                // enableElement(_self.$simpleSpecialPartNumberInput);
                // enableElement(_self.$acceptButton);
                // enableElement(_self.$nextButton);
                enableElement(_self.$nextButton);
                disableElement(_self.$simpleSpecialPartNumberInput);
            }
        });
        $("#new_version").click(function (){
            if ($("#new_version").is(":checked")){
                _self.$simpleSpecialPartNumberInput.removeClass("disabled");
                _self.$simpleSpecialPartNumberInput.removeAttr("disabled");
                $("#new_version_label").removeClass("hidden");
                $("#new_ss_label").addClass("hidden");
                enableElement(_self.$simpleSpecialPartNumberInput);
                if (_self.$simpleSpecialPartNumberInput.val() !== "" && _self.$simpleSpecialPartNumberInput.val().length >=3){
                    // enableElement(_self.$acceptButton);
                    enableElement(_self.$nextButton);
                }else {
                    // disableElement(_self.$acceptButton);
                    disableElement(_self.$nextButton);
                }
            }
        });
        // this.$aliasInput.keyup(function(){
        //     if (_self.$aliasInput.val()!== "" && _self.$aliasInput.val().length >= 3){
        //         enableElement(_self.$nextButton);
        //     }else {
        //         disableElement(_self.$nextButton);
        //     }
        // });
        $document.on('smc.disable.cylinderConfigurator',function(e) {
            _self.disableConfiguratorOptions();
            _self.loadSummaryBySimpleSpecial();
        });


        $(".documentation-option-checkbox").each(function (){
            var _option = this;
            var child = $(".sscw_summary_"+_option.id+"_list_sub");
            if (child !== undefined && child.length > 0){
                $(_option).click(function (){
                    if ($(_option).is(":checked")){
                        $(".sscw_summary_"+_option.id+"_list_sub").removeClass("hidden");
                    }else {
                        $(".sscw_summary_"+_option.id+"_list_sub").addClass("hidden");
                        $(".sscw_summary_"+_option.id+"_list_sub input[type='checkbox']").prop("checked",false);
                        $(".sscw_summary_"+_option.id+"_list_sub input[type='checkbox']").removeAttr("checked");
                    }
                });
            }
        });
        $("#cad").click(function(){
            if ($(this).is(":checked")){
                $("#cad__formats__container").removeClass("hidden");
                $(".cad__formats_label").removeClass("hidden");
            }else {
                $("#cad__formats__container").addClass("hidden");
                $(".cad__formats_label").addClass("hidden");
            }
        });

        $(".open-closed-configuration-js").click(function() {
            enableConfiguratorOptions();

            var currentUrl = window.location.href;
            var url = new URL(window.location.href);
            if (currentUrl.indexOf("=") > 0){
                //Remove simpleSpecialCode from URL
                url.searchParams.delete('simpleSpecialCode');
                window.history.pushState({}, window.document.title, url.toString());
            }

            $(document).trigger('smc.reload.summary');

            // Hide simple special info from summary view
            $(".cylinder-info-container__configuration_details__info").addClass("hidden");

            // Update HTO
            showMainHTO();
        });
    }

    function showConfirmationModal() {
        $("#cylinder-info-container").addClass("hidden");
        $("#btn-summary-return").click();
        setTimeout(function (){
            $("#cylinder-info-container").removeClass("hidden");
            var continueModal = $("#createSimpleEspecialContinueConfirmModal");
            continueModal.modal({backdrop: 'static', keyboard: true}, 'show');
        },400);
    }

    function showWizardModal(){
        $("#cylinder-info-container").addClass("hidden");
        $("#btn-confirm-return").click();
        setTimeout(function (){
            $("#cylinder-info-container").removeClass("hidden");
            var wizardModal = $("#simpleSpecialCreationWizardModal");
            $("#wizard-error-message").html("");
            $(".sscw-message-error").addClass("hidden");
            wizardModal.modal({backdrop: 'static', keyboard: true}, 'show');
        },400);
    }

    function showSummaryModal(){
        $(document).trigger('smc.reload.summary');
        var confirm = $("#createSimpleEspecialPricesConfirmModal");
        confirm.modal({backdrop: 'static', keyboard: true}, 'show');
    }

    function loadPricesConfirmDataTable(){
        console.log("[loadPricesConfirmDataTable]");
        //remove old data
        $("#sscw__selection_table_pricesConfirm .sscw__selection_table__register").each(function(){
            if (this.id === "sscw__selection_table__summatory"){ //last file, the summary one
                //then we remove the total numbers
                $("#"+this.id+" .sscw__selection_table__cell__value").text("");
            }else {
                //remove register file
                $(this).remove();
            }
        });
        //Load new Data, right now we do not have accesories, so only main product
        var rowTemplate = $("#sscw__selection_table__register_template").html().toString();
        var partNumber = getUrlParameter("partNumber");
        var description = "";
        var qty="1";
        var inStock = "";
        var unitPrice = "";
        var totalPrice = "";
        var localStock = "";
        var ecwStock = "";
        rowTemplate = rowTemplate.replace("{{sscw__partNumber}}",partNumber);
        rowTemplate = rowTemplate.replace("{{sscw__description}}",description);
        rowTemplate = rowTemplate.replace("{{sscw__quantity}}",qty);
        rowTemplate = rowTemplate.replace("{{sscw__inStock}}",inStock);
        rowTemplate = rowTemplate.replace("{{sscw__unitPrice}}",unitPrice);
        rowTemplate = rowTemplate.replace("{{sscw__totalPrice}}",totalPrice);
        rowTemplate = rowTemplate.replace("{{sscw__localStock}}",localStock);
        rowTemplate = rowTemplate.replace("{{sscw__ecwStock}}",ecwStock);
        $("#sscw__selection_table__headings_main").after(rowTemplate);
    }


    function resetWizard(){
        console.log("[Cylinder-wizard-modal] resetWizard");
        this.hideError();
        this.$backButton.addClass("hidden");
        this.$skipButton.addClass("hidden");
        this.$finishButton.addClass("hidden");
        this.$closeButton.addClass("hidden");
        this.$nextButton.removeClass("hidden");
        this.$cancelButton.removeClass("hidden");
        $(".sscw-message-error").addClass("hidden");
        $("#sscw__create_simple_special_configuration").removeClass("hidden");
        $("#sscw__create_simple_special_created").addClass("hidden");
        $("#sscw__create_simple_special_creation_failed").addClass("hidden");
        // $("#sscw__summary_confirmation_data_container").removeClass("hidden");
        $("#sscw__summary_confirmation_zip_created").addClass("hidden");
        $("#sscw__summary_confirmation_zip_creation_failed").addClass("hidden");
        $("#wizard-error-message").text("");
        $("#customer_number").val("");
        $("#customer_name").val("");
        $(".sscw__customer__list_header").addClass("hidden");
        $(".sscw__customer__list").empty();
        $(".sscw__nav__item").removeClass("active");
        $(".wizard_article").addClass("hidden");
        // $(".sscw_summary_fields_include_list_sub").addClass("hidden");
        $("#simple_special_part_number").val("");
        $("#new_version_text").text("");
        $(".sscw_summary_configurationSummary_container").addClass("hidden");
        $(".sscw_summary_fields_include_list_sub").addClass("hidden");
        $("#cad__formats__container").addClass("hidden");
        $(".cad__formats_label").addClass("hidden");
        $("#simpleSpecialCreationWizardModal input[type='checkbox']").prop("checked",false);
        $("#new_version").removeAttr("checked");
        addActive("sscw__customer_selection");
        disableElement(this.$nextButton);
        // disableElement(this.$acceptButton);
        disableElement(this.$finishButton);
        disableElement(this.$simpleSpecialPartNumberInput);
        $(".smc-radio-input").prop("checked",false);
        $(".sscw__create_simple_special__option").prop("checked",false);
        $(".sscw__create_simple_special__option").val(false);
        $(".sscw__radio").each(function(){
            $(this).prop("checked",false);
            $(this).val(false);
        });
        // this.$aliasInput.val("");
        $("#sscw__info_table_customerNumber").text("");
        $("#sscw__info_table_customerName").text("");
        $("#sscw__info_table_customerAddress").text("");
        $("#sscw__info_table_simpleSpecialReference").text("");
        if ($("#cylinder-info-container__partnumber_title__accesories").is(":empty")){
            $("#mounted_summary").prop("checked", false);
            $("#mounted").prop("checked",false);
            $(".sscw__create_simple_special__mounted").addClass("hidden");
        }else {
            $(".sscw__create_simple_special__mounted").removeClass("hidden");
            if ($("#mounted_summary").is(":checked")){
                $("#mounted").prop("checked",true);
            }else {
                $("#mounted").prop("checked",false);
            }
        }
        disableElement(this.$searchCustomerButton);

        if ($("#accessoriesPermission").val() == "true") {
            $("#cylindersConfigurator_beforeRodEnd").removeClass("hidden");
        }
        $("#sscw__zip_file .documentation-option-checkbox").removeAttr("checked");
        $("#sscw__zip_file .documentation-option-checkbox").prop("checked",false);
        $("#sscw__zip_file .smc-checkbox__label").each(function(){
            $(this).click();
        });
        $("#cad").removeAttr("checked");
        $("#cad").prop("checked",false);
        $(".sscw_summary_fields_include_list_sub").removeClass("hidden");
    }

    function nextTab(){
        console.log("[Cylinder-wizard-modal] nextTab");
        this.hideError();
        $(".sscw-message-error").addClass("hidden");
        $("#wizard-error-message").text("");
        if (this.$nextButton.hasClass("disabled")){
            return;
        }
        var currentTab = getCurrentTab();
        if (currentTab.id === "sscw__create_simple_special" && !$("#sscw__create_simple_special_created").is(":visible")){
            this.acceptSimplePartNumberCreation();
        }else if (this.checkIfTabInfoCompleted(currentTab)){
            this.changeTab(currentTab);
        }else {
            //TODO display tab incomplete message?
        }
    }

    function previousTab(){
        console.log("[Cylinder-wizard-modal] previousTab");
        this.hideError();
        $(".sscw-message-error").addClass("hidden");
        $("#wizard-error-message").text("");
        if (this.$backButton.hasClass("disabled")){
            return;
        }
        var currentTab = getCurrentTab();
        var previousTabId  = getPreviousTabId(currentTab);
        this.checkWizardButtonsVisibility(previousTabId);
        if (previousTabId !== "" && previousTabId !== "cancel"){
            removeActive(currentTab.id);
            addActive(previousTabId);
            if (previousTabId === "sscw__customer_selection"){
                if ($("#sscw__customer__list").is(":empty")){
                    disableElement(this.$backButton);
                }else {
                    var checked = false;
                    $("#sscw__customer__list .sscw__radio").each(function(){
                        if ($(this).is(":checked")){
                            selectedCustomer = $(this).val();
                            console.log("[checkIfTabInfoCompleted] something checked!");
                            checked = true;
                        }
                    });
                    if (checked){
                        enableElement(this.$nextButton);
                    }else  {
                        disableElement(this.$nextButton);
                    }
                }
            }else {
                this.$backButton.removeClass("disabled");
                this.$nextButton.removeClass("disabled");
                enableElement(this.$nextButton);
                enableElement(this.$backButton);
            }
        }else if (previousTabId === "finish"){
            this.$backButton.addClass("disabled");
            disableElement(this.$backButton);
        }/*else if (previousTabId === "sscw__alias"){
            if (this.$aliasInput.val() === ""){
                disableElement(this.$nextButton);
            }else {
                enableElement(this.$nextButton);
            }
        }*/
    }

    function searchCustomers(){
        console.log("[Cylinder-wizard-modal] searchCustomers");
        var _self = this;
        _self.$searchCustomerButton.prop("disabled",true);
        _self.hideError();
        addSearchingSpinner("sscw__customer_selection");
        var customerNumber = $("#customer_number").val();
        var customerName = $("#customer_name").val();
        $(".sscw__customer__list").empty();
        $(".sscw__customer__list_header").addClass("hidden");
        var url = globalConfig.CylinderWizardModal.urls.searchCustomer;
        var data = {
            customerNumber: customerNumber,
            customerName: customerName
        };
        $.get(url, data)
            .then(function (response) {
                if (response !== ""){
                    $(".sscw__customer__list_header").removeClass("hidden");
                    $(".sscw__customer__list").html(response);
                }else {
                    $("#wizard-error-message").text($("#sscw_modal_general_error").text());
                    $(".sscw-message-error").removeClass("hidden");
                    _self.showError();
                }
                emptySearchingSpinner("sscw__customer_selection");
                _self.$searchCustomerButton.prop("disabled",false);
            })
            .catch(function (error) {
                console.debug("searchCustomers error" + error);
                $("#wizard-error-message").text($("#sscw_modal_general_error").text());
                $(".sscw-message-error").removeClass("hidden");
                _self.showError();
                emptySearchingSpinner("sscw__customer_selection");
                _self.$searchCustomerButton.prop("disabled",false);
            });
    }

    function acceptSimplePartNumberCreation(){
        console.log("[Cylinder-wizard-modal] acceptSimplePartNumberCreation");
        this.hideError();
        addSearchingSpinner("sscw__create_simple_special__new_button_container");
        var _self = this;
        $("#new_version_label").addClass("hidden");
        $("#new_ss_label").addClass("hidden");
        $(".sscw-message-error").addClass("hidden");
        $("#wizard-error-message").text("");
        var mounted = $("#mounted").is(":checked") || $("#mounted_summary").is(":checked");
        var newCheck = $("#new").is(":checked");
        var newVersionCheck = $("#new_version").is(":checked");
        var simpleSpecialPartNumber = $("#simple_special_part_number").val();
        var partNumber = getUrlParameter("partNumber");
        var rodEndConf = getUrlParameter("rodEndConf");
        if (rodEndConf === undefined){
            rodEndConf = "";
        }
        var seriesCode = $("#product_series_code").val();
        if (simpleSpecialPartNumber === "" && newVersionCheck){
            $("#wizard-error-message").text($("#sscw_modal_simple_special_error").text());
            $(".sscw-message-error").removeClass("hidden");
            return;
        }
        var selectedCustomer = "";
        // var customerName = "";
        // var customerAddress = "";
        // var customerPostalCode = "";
        // var $customerName=$("#project-customer-contact-form input[name='name']");
        // var $customerAddress=$("#project-customer-contact-form input[name='address']");
        // var $customerZip=$("#project-customer-contact-form input[name='zip']");


        $(".sscw__customer_selection_radio").each(function(){
            if ($(this).is(":checked")){
                // var currentIndex =  $(this).attr("currentIndex");
                selectedCustomer = $(this).attr("customerId");
                // customerName = $(this).attr("customerName");
                // customerAddress = $("#accessory_customerAddress_text_"+currentIndex+"_complete").text();
                // customerPostalCode = $(this).attr("customerAddress");
                //
                // if (!$customerName.val()) {
                //     $customerName.val(customerName);
                // }
                // if (!$customerAddress.val()) {
                //     $customerAddress.val(customerAddress);
                // }
                // if (!$customerZip.val()) {
                //     $customerZip.val(customerPostalCode);
                // }
            }
        });
        var accessories = this.parseAccesories();
        var rodEnd = getRodEndCode()+"##"+getRodEndPosition();
        var data = {
            productId : this.productId,
            rodEndConf : rodEndConf,
            rodEnd : rodEnd,
            partNumberSel : partNumber,
            customerNumber: selectedCustomer,
            mounted: mounted,
            newCheck: newCheck,
            newVersionCheck: newVersionCheck,
            simpleSpecialPartNumber: simpleSpecialPartNumber,
            seriesCode: seriesCode,
            accessories: JSON.stringify(accessories),
            viewMode: isMobile ? 'mobile' : 'desktop',
            specialOption: "CC",
            projectDescription : $("#projectDescription").val(),
            solicitorName : $("#project-designer-contact-form input[name='name']").val(),
            solicitorCompany : $("#project-designer-contact-form input[name='company']").val(),
            solicitorEmail : $("#project-designer-contact-form input[name='email']").val(),
            solicitorAddress : $("#project-designer-contact-form input[name='address']").val(),
            solicitorPhone : $("#project-designer-contact-form input[name='phone']").val(),
            solicitorTown : $("#project-designer-contact-form input[name='town']").val(),
            solicitorFax: $("#project-designer-contact-form input[name='fax']").val(),
            solicitorZip : $("#project-designer-contact-form input[name='zip']").val(),
            customerName : $("#project-customer-contact-form input[name='name']").val(),
            customerCompany : $("#project-customer-contact-form input[name='company']").val(),
            customerEmail : $("#project-customer-contact-form input[name='email']").val(),
            customerAddress : $("#project-customer-contact-form input[name='address']").val(),
            customerPhone : $("#project-customer-contact-form input[name='phone']").val(),
            customerTown : $("#project-customer-contact-form input[name='town']").val(),
            customerFax: $("#project-customer-contact-form input[name='fax']").val(),
            customerZip : $("#project-customer-contact-form input[name='zip']").val()
        };
        var url = globalConfig.CylinderWizardModal.urls.acceptSimplePartNumberCreation;
        $.get(url, data)
            .then(function (response) {
                if (response !== ""){
                    //TODO mount true response to method
                    $("#sscw__create_simple_special_configuration").addClass("hidden");
                    $("#sscw__create_simple_special_created").removeClass("hidden");
                    if (response === "ERROR"){
                        // $("#wizard-error-message").text($("#sscw_modal_simple_special_error").text());
                        // $(".sscw-message-error").removeClass("hidden");
                        $("#sscw__create_simple_special_configuration").addClass("hidden");
                        $("#sscw__create_simple_special_creation_failed").removeClass("hidden");
                        _self.$backButton.addClass("hidden");
                        _self.$nextButton.addClass("hidden");
                        _self.$closeButton.removeClass("hidden");
                    }else if (newCheck){
                        $("#new_ss_label").removeClass("hidden");
                    }else if (newVersionCheck){
                        $("#new_version_label").removeClass("hidden");
                    }
                    $("#new_version_text").text(response);
                    $("#sscw__create_simple_special_created_simpleSpecialCode").text(response);
                    enableElement(_self.$nextButton);
                    _self.$backButton.addClass("hidden");
                }
                emptySearchingSpinner("sscw__create_simple_special__new_button_container");
            })
            .catch(function (error) {
                console.debug("acceptSimplePartNumberCreation error" + error);
                // $("#wizard-error-message").text($("#sscw_modal_general_error").text());
                // $(".sscw-message-error").removeClass("hidden");
                _self.showError();
                $("#sscw__create_simple_special_configuration").addClass("hidden");
                $("#sscw__create_simple_special_creation_failed").removeClass("hidden");
                _self.$backButton.addClass("hidden");
                _self.$nextButton.addClass("hidden");
                _self.$closeButton.removeClass("hidden");
                emptySearchingSpinner("sscw__create_simple_special__new_button_container");
            });
    }

    //TODO IS THIS BEING USED?
    function getCadOptions(){
        console.log("[Cylinder-wizard-modal] getCadOptions");
        this.hideError();
        var _self = this;
        var url = globalConfig.CylinderWizardModal.urls.getCadOptions;
        var data = {
            productId : this.productId,
            partNumber : this.partNumber,
            rodEndConf : this.rodEndConf
        };
        $.get(url, data)
            .then(function (response) {
                if (response !== ""){
                    $("#cad__formats__container").html(response);
                }
            })
            .catch(function (error) {
                console.debug("getCadOptions error" + error);
                $("#wizard-error-message").text($("#sscw_modal_general_error").text());
                $(".sscw-message-error").removeClass("hidden");
                _self.showError();
            });
    }

    function finishWizard(){
        //TODO finish actions
        console.log("[Cylinder-wizard-modal] finishWizard");
        var _self = this;
        // var newCheck = $("#new").is(":checked");
        // if (newCheck){
        //     this.acceptSimplePartNumberCreation(this);
        // }else {
        //     this.finishActions();
        // }
        this.finishActions();
    }

    function finishActions(){
        this.hideError();
        $("#cylinder-info-container__simple_special_title__cylinder").text($("#new_version_text").text());
        $("#series_hto_simple_special").text($("#new_version_text").text());
        $(".cylinder-info-container__content__actions").removeClass("hidden");
        var selectedCustomer = "";
        $(".sscw__radio[name='accesory_customerName']:checked").each(function () {
            selectedCustomer = this.id;
        });
        var errorMessages = "";
        if (selectedCustomer === ""){
            errorMessages+=$("#sscw_modal_customer_error").text();
        }
        // if ($("#sscw__info_table_simpleSpecialReference").text() === ""){
        //     if (errorMessages !== ""){
        //         errorMessages += "<br/>" ;
        //     }
        //     errorMessages+=$("#sscw_modal_simple_special_error").text();
        // }
        if (errorMessages !== ""){
            $("#wizard-error-message").html(errorMessages);
            $(".sscw-message-error").removeClass("hidden");
        }else {
            //If cadError
            if (this.zipError) {
                $("#createdNoError").hide();
                $("#createdCadError").show();
                this.zipError = false;
            }
            //we can update HTO elements
            $("#cylinder-info-container__simple_special_title__cylinder").text($("#new_version_text").text());
            $("#sscw__info_table__simple_special_code").text($("#new_version_text").text());
            $("#series_hto_simple_special").text($("#new_version_text").text());
            $(".cylinder-info-container__content__actions").removeClass("hidden");
            $(".cylinder-info-container__content_simple_special").removeClass("hidden");
            $("#cylinder-info-container__simple_special__title").removeClass("hidden");
            $("#configuration_details__simpleSpecial_value").text($("#new_version_text").text());
            if ($("#mounted").is(":checked")) {
                $("#configuration_details__mounted_value").removeClass("hidden");
            } else {
                $("#configuration_details__mounted_value").addClass("hidden");
            }
            $(".cylinder-info-container__configuration_details__info").removeClass("hidden");
            this.disableConfiguratorOptions();
            selectedCustomer = "";
            var customerName = "";
            var customerAddress = "";
            var customerPostalCode = "";
            $(".sscw__customer_selection_radio").each(function(){
                if ($(this).is(":checked")){
                    var currentIndex =  $(this).attr("currentIndex");
                    selectedCustomer = $(this).attr("customerId");
                    customerName = $(this).attr("customerName");
                    customerAddress = $("#accessory_customerAddress_text_"+currentIndex+"_complete").text();
                    customerPostalCode = $(this).attr("customerAddress");
                }
            });

            $("#configuration_details__customerNumber_value").text(selectedCustomer);
            $("#configuration_details__customerName_value").text(customerName);
            $("#sscw__info_table__customer_code").text(selectedCustomer);
            $("#sscw__info_table__customer_name").text(customerName);

            //now we close after confirmation div
            // var confirm = $("#simpleSpecialCreationWizardModal");
            // confirm.modal('hide');
            if ($("#cylinder-info-container__toggle_switch") !== undefined && !$("#cylinder-info-container__toggle_switch").is(":checked")){
                $("#cylinder-info-container__toggle_switch").click();
                if ($("#cylinder-info-container__partnumber_switch") !== undefined && !$("#cylinder-info-container__partnumber_switch").is(":checked")){
                    $("#cylinder-info-container__partnumber_switch").click();
                }
            }
            var url = new URL(window.location.href);
            url.searchParams.set('simpleSpecialCode', window.smc.StringTools.encodeForUrl($("#new_version_text").text()));
            window.history.pushState({}, window.document.title, url.toString());
            $("#series_hto_simple_special").text($("#new_version_text").text());
            $(".cylinder-info-container__content__actions").removeClass("hidden");
            this.loadSummaryBySimpleSpecial();
            $("#idbl_hto_wrapper .idbl_hto").removeClass("idbl_hto--cc");
            $("#idbl_hto_wrapper .idbl_hto").addClass("idbl_hto--ccss");
        }
    }

    function closeWizard(){
        var confirm = $("#simpleSpecialCreationWizardModal");
        confirm.modal('hide');
    }

    function skipTab(){
        //TODO skip tab  actions
        this.hideError();
        console.log("[Cylinder-wizard-modal] skipTab");
        $(".sscw-message-error").addClass("hidden");
        $("#wizard-error-message").text("");
        var currentTab = getCurrentTab();
        this.changeTab(currentTab);
    }
    function changeTab(currentTab){
        console.log("[Cylinder-wizard-modal] changeTab");
        this.hideError();
        var nextTabId  = getNextTabId(currentTab);
        this.checkWizardButtonsVisibility(nextTabId);
        if (nextTabId !== "" && nextTabId !== "finish"){
            disableElement(this.$finishButton);
            removeActive(currentTab.id);
            addActive(nextTabId);
            if (nextTabId === "sscw__zip_file"){
                disableElement(this.$nextButton);
                enableElement(this.$finishButton);
                // loadSummary();
            }/*else if (nextTabId === "sscw__alias"){
                if (this.$aliasInput.val() === ""){
                    disableElement(this.$nextButton);
                }else {
                    enableElement(this.$nextButton);
                }
            } */else if (nextTabId === "sscw__create_simple_special" && $("#new_version_text").text() === "") {
                disableElement(this.$nextButton);
                if ($("#new").is(":checked") || $("#new_version").is(":checked")) {
                    enableElement(this.$nextButton);
                }
                enableElement(this.$backButton);
            } else {
                enableElement(this.$nextButton);
                enableElement(this.$backButton);
            }
        }else if (nextTabId === "finish"){
            disableElement(this.$nextButton);
        }
    }

    function checkWizardButtonsVisibility(showingTabId){
        console.log("[Cylinder-wizard-modal] checkWizardButtonsVisibility ",showingTabId);
        if (showingTabId === "sscw__customer_selection" ){
            this.$backButton.addClass("hidden");
            this.$skipButton.addClass("hidden");
            this.$finishButton.addClass("hidden");
            this.$nextButton.removeClass("hidden");
            this.$cancelButton.removeClass("hidden");
        }else if (showingTabId === "sscw__create_simple_special" ){
            this.$backButton.removeClass("hidden");
            this.$nextButton.removeClass("hidden");
            this.$cancelButton.addClass("hidden");
            this.$finishButton.addClass("hidden");
            this.$skipButton.addClass("hidden");
        }else if (showingTabId === "sscw__zip_file" ){
            this.$cancelButton.addClass("hidden");
            this.$finishButton.removeClass("hidden");
            this.$backButton.removeClass("hidden");
            this.$nextButton.addClass("hidden");
            this.$skipButton.addClass("hidden");
        }else if (showingTabId === "sscw__summary_confirmation" ){
            this.$cancelButton.addClass("hidden");
            this.$nextButton.addClass("hidden");
            this.$skipButton.addClass("hidden");
            this.$finishButton.removeClass("hidden");
            this.$backButton.removeClass("hidden");
        }
    }


    function checkIfTabInfoCompleted(current){
        var currentTab = $(current).attr("id");
        console.log("[checkIfTabInfoCompleted]",currentTab);
        $("#wizard-error-message").text('');
        $(".sscw-message-error").addClass("hidden");
        if (currentTab === "sscw__customer_selection"){
            var selectedCustomer = "";
            if ($("#sscw__customer__list").is(":empty")){
                console.log("[checkIfTabInfoCompleted] emtpy");
                $("#wizard-error-message").text($("#sscw_modal_customer_error").text());
                $(".sscw-message-error").removeClass("hidden");
                return false;
            }else {
                var checked = false;
                $("#sscw__customer__list .sscw__radio").each(function(){
                    if ($(this).is(":checked")){
                        selectedCustomer = $(this).val();
                        console.log("[checkIfTabInfoCompleted] something checked!");
                        checked =  true;
                    }
                });
                if (!checked){
                    $("#wizard-error-message").text($("#sscw_modal_customer_error").text());
                    $(".sscw-message-error").removeClass("hidden");
                }
                return checked;
            }
        }else if (currentTab === "sscw__create_simple_special"){
            // if ($("#new_version_text").text() !== "" ){
            //     return true;
            // }else {
            //     $("#wizard-error-message").text($("#sscw_modal_simple_special_not_found_error").text());
            //     $(".sscw-message-error").removeClass("hidden");
            // }
            return true;
        }else if (currentTab === "sscw__zip_file"){
            //TODO add validation. Is neccesary? You must select something? or is optional?
            return true;
        }/*else if (currentTab === "sscw__alias"){
            if (this.$aliasInput.val().toString().trim() !== ""){
                return true;
            }
        }*/else if (currentTab === "sscw__summary_confirmation"){
            //TODO add validation. Is neccesary?
            return true;
        }
        return false;
    }


    function removeActive(tabId){
        $("#"+tabId).addClass("hidden");
        $("#"+tabId+"_tab").removeClass("active");
    }

    function addActive(tabId){
        $("#"+tabId).removeClass("hidden");
        $("#"+tabId+"_tab").addClass("active");
    }

    function getCurrentTab(){
        var curTab = undefined;
        $(".wizard_article").each(function(){
            if (curTab === undefined && !$(this).hasClass("hidden")){
                curTab = this;
            }
        });
        return curTab;
    }

    function getNextTabId(currentTab){
        if (currentTab === undefined){
            return;
        }
        var curTabId = currentTab.id;
        if (curTabId === "sscw__customer_selection"){
            return "sscw__create_simple_special";
        }else if (curTabId === "sscw__create_simple_special"){
            return "sscw__zip_file";
        }else if (curTabId === "sscw__zip_file"){
            /*return "sscw__alias";
        }else if (curTabId === "sscw__alias"){*/
            return "sscw__summary_confirmation";
        }else if (curTabId === "sscw__summary_confirmation"){
            return "finish";
        }
    }

    function getPreviousTabId(currentTab){
        if (currentTab === undefined){
            return;
        }
        var curTabId = currentTab.id;
        if (curTabId === "sscw__customer_selection"){
            return "cancel";
        }else if (curTabId === "sscw__create_simple_special"){
            return "sscw__customer_selection";
        }else if (curTabId === "sscw__zip_file"){
            return "sscw__create_simple_special";
        }/*else if (curTabId === "sscw__alias"){
            return "sscw__zip_file";
        }else if (curTabId === "sscw__summary_confirmation"){
            // return "sscw__alias";
            return "sscw__zip_file";
        }*/
    }

    function createSimpleSpecialOptions(){
        $(".sscw__create_simple_special__option :checked").each(function(){
            enableElement($(".btn-new-simple-special"));
            if (this.id === "new"){
                $("#new_version").removeAttr("checked");
            }else if (this.id === "new_version"){
                $("#new").removeAttr("checked");
            }
        });
    }

    // function loadSummary(){
    //     //Load this info from selected customer in step 1
    //     console.log("[loadSummary]");
    //     $(".sscw__radio[name='accesory_customerName']:checked").each(function (){
    //         var selectedItemId = this.id;
    //         console.log("selected: ",selectedItemId);
    //         var selectedIndex = selectedItemId.replace("accessory_customer_","");
    //         if (selectedIndex !== ""){
    //             $("#sscw__info_table_customerNumber").text($("#accessory_customerNumber_text_"+selectedIndex).text());
    //             $("#sscw__info_table_customerName").text($("#accessory_customerName_text_"+selectedIndex).text());
    //             $("#sscw__info_table_customerAddress").text($("#accessory_customerAddress_text_"+selectedIndex).text());
    //         }
    //         $("#sscw__info_table_simpleSpecialReference").text($("#new_version_text").text());
    //         if ($("#mounted").is(":checked")){
    //             $("#sscw_summary_mounted_no").addClass("hidden");
    //             $("#sscw_summary_mounted_yes").removeClass("hidden")
    //         }else {
    //             $("#sscw_summary_mounted_yes").addClass("hidden");
    //             $("#sscw_summary_mounted_no").removeClass("hidden")
    //         }
    //     });
    //     loadSummaryZipContent();
    // }

    // function loadSummaryZipContent(){
    //     console.log("[loadSummaryZipContent]");
    //     $(".sscw__summary_confirmation__zip_file__content li").addClass("hidden");
    //     $("#sscw__summary_confirmation__zip_file_container .sscw__summary_confirmation__content__title").addClass("hidden");
    //     $(".sscw__summary_confirmation__content__actions").addClass("hidden");
    //     $(".sscw_summary_configurationCAD_container").addClass("hidden");
    //
    //     var somethingClicked = false;
    //     $(".documentation-option-checkbox").each(function(){
    //         if ($(this).is(":checked")){
    //             if ($(this).hasClass("documentation-option-checkbox-list-parent")){
    //                 //then its a header of a list, we have to check if any of its children is checked
    //                 var anyIsChecked = false;
    //                 $("#sscw_summary_fields_include_list_"+this.id+" input[type='checkbox']").each(function(){
    //                     if ($(this).is(":checked")){
    //                         anyIsChecked = true;
    //                     }
    //                 });
    //                 if (anyIsChecked){
    //                     $(".sscw_summary_"+this.id+"_container").removeClass("hidden");
    //                     somethingClicked = true;
    //                 }
    //             }else {
    //                 $(".sscw_summary_"+this.id+"_container").removeClass("hidden");
    //                 somethingClicked = true;
    //             }
    //
    //         }
    //     });
    //     var selectedCad = "";
    //     $(".cad__format__item .smc-radio-input").each(function(){
    //        if ($(this).is(":checked")){
    //            selectedCad  = $(this).attr("data-label");
    //        }
    //     });
    //     if ($("#cad").is(":checked") && selectedCad !== ""){
    //         somethingClicked = true;
    //         $(".sscw_summary_configurationCAD_container").removeClass("hidden");
    //         $("#sscw_summary_selected_cad").text(selectedCad);
    //         $("#sscw_summary_selected_cad").removeClass("hidden");
    //     }else {
    //         $(".sscw_summary_configurationCAD_container").addClass("hidden");
    //         $("#sscw_summary_selected_cad").text("");
    //     }
    //
    //     if (somethingClicked){
    //         $(".sscw__summary_confirmation__zip_file").removeClass("hidden");
    //         $(".sscw__summary_confirmation__content__actions").removeClass("hidden");
    //     }else {
    //         $(".sscw__summary_confirmation__zip_file").addClass("hidden");
    //     }
    // }

    function checkCustomerInputStatus(){
        if ((this.$customerNameInput.val()!== "" && this.$customerNameInput.val().length >=3)
            || (this.$customerNumberInput.val()!== "" && this.$customerNumberInput.val().length >=3)){
            enableElement(this.$searchCustomerButton);
        }else {
            disableElement(this.$searchCustomerButton);
        }
    }

    function checkForSubmit(e){
        if (e.which === 13 ) { //ENTER
            if (!this.$searchCustomerButton.is(':disabled')) {
                this.$searchCustomerButton.click();
            }
        }
    }

    function downloadAndFinish(){
        var _self = this;
        console.debug("[CylinderWizard - downloadAndFinish]");
        $("#sscw__summary_confirmation_zip_creation_failed").addClass("hidden");
        $("#sscw__summary_confirmation_zip_created").addClass("hidden");
        let currentTab = getCurrentTab();
        _self.changeTab(currentTab);
        addSearchingSpinner("sscw__summary_confirmation__content__actions");
        _self.hideError();
        var $spinner = $('.loading-container-js');
        disableElement(_self.$finishButton);
        // _prepareLoading.call(_self, _self.$zipDownloadButton, $spinner);
        var selectedCad = "";
        if ($("#cad").is(":checked")){
            $(".cad__format__item .smc-radio-input").each(function(){
                if ($(this).is(":checked")){
                    selectedCad  = $(this).attr("value");
                }
            });
        }
        var selectedCustomer = "";
        var customerName = "";
        var customerAddress = "";
        var customerPostalCode = "";
        $(".sscw__customer_selection_radio").each(function(){
            if ($(this).is(":checked")){
                var currentIndex =  $(this).attr("currentIndex");
                selectedCustomer = $(this).attr("customerId");
                customerName = $(this).attr("customerName");
                customerAddress = $("#accessory_customerAddress_text_"+currentIndex+"_complete").text().trim();
                customerPostalCode = $(this).attr("customerAddress");
            }
        });
        // var partNumber = getUrlParameter("partNumber");
        // var rodEnd = getRodEndCode();
        //
        // var rodEndConf = this.config.productConfiguratorComponent.getRodEndModificationConfigurationValuesInString();
        var simpleSpecialCode = $("#new_version_text").text();
        var data = {
            // productId: this.productId,
            // partNumber: partNumber,
            // rodEnd: rodEnd,
            // customerNumber: selectedCustomer,
            // customerName : customerName,
            // customerAddress : customerAddress,
            // customerPostalCode: customerPostalCode,
            simpleSpecialCode : simpleSpecialCode,
            selectedCad : selectedCad,
            documentationOptions : getDocumentationOptions()
        };
        var openReference = window.open(smc.channelPrefix + '/loading-page', '_blank');
        var url = globalConfig.CylinderWizardModal.urls.getZipFile;

        url = getURLRemoveParam(url, "simpleSpecialCode");
        url = getURLRemoveParam(url, "partNumber");
        url = getURLRemoveParam(url, "rodEnd");

        $.get(url, data)
            .then(function (response) {
                if (response.url && response.url !== undefined && response.url !== null && response.url !== "") {
                    //Remove spinner & set File Ready
                    _self.$finishButton.addClass("hidden");
                    if (response.error) {
                        console.debug("Error found during zipGeneration: " + response.errorCause);
                        _self.zipError = true;
                    }
                    $('.loading', openReference.document).hide();
                    $('.loaded ', openReference.document).show();
                    openReference.location = response.url;
                    _self.finishActions();
                    //$("#sscw__summary_confirmation_data_container").addClass("hidden");
                    $("#sscw__summary_confirmation_zip_created").removeClass("hidden");
                    _self.$closeButton.removeClass("hidden");
                    $(document).trigger("smc.reload.summary");
                }
                // _self.enableElement(_self.$finishButton);
            })
            .catch(function (error) {
                console.debug("zipDownload error" + error);
                _self.$finishButton.addClass("hidden");
                //$("#sscw__summary_confirmation_data_container").addClass("hidden");
                $("#sscw__summary_confirmation_zip_creation_failed").removeClass("hidden");
                _self.$closeButton.removeClass("hidden");
                if (!(window.isIOS || window.isIE || window.isEdge)) openReference.close();
                // _self.enableElement(_self.$zipDownloadButton);
                _self.showError();
            }).always(function () {
            // _prepareUnloading.call(_self, _self.$zipDownloadButton, $spinner);
            // _self.enableElement(_self.$finishButton);
            setTimeout(function () {
                if (!(window.isIOS || window.isIE || window.isEdge)) openReference.close();
            }, 1500);
            emptySearchingSpinner("sscw__summary_confirmation__content__actions");
        }.bind(this));
    }


    // function zipDownload (){
    //     console.debug("[CylinderWizard - zipDownload]");
    //     addSearchingSpinner("sscw__summary_confirmation__content__actions");
    //     this.hideError();
    //     var _self = this;
    //     var $spinner = $('.loading-container-js');
    //     disableElement(_self.$zipDownloadButton);
    //     // _prepareLoading.call(_self, _self.$zipDownloadButton, $spinner);
    //     var selectedCad = "";
    //     if ($("#cad").is(":checked")){
    //         $(".cad__format__item .smc-radio-input").each(function(){
    //             if ($(this).is(":checked")){
    //                 selectedCad  = $(this).attr("value");
    //             }
    //         });
    //     }
    //     var selectedCustomer = "";
    //     var customerName = "";
    //     var customerAddress = "";
    //     var customerPostalCode = "";
    //     $(".sscw__customer_selection_radio").each(function(){
    //         if ($(this).is(":checked")){
    //             var currentIndex =  $(this).attr("currentIndex");
    //             selectedCustomer = $(this).attr("customerId");
    //             customerName = $(this).attr("customerName");
    //             customerAddress = $("#accessory_customerAddress_text_"+currentIndex+"_complete").text();
    //             customerPostalCode = $(this).attr("customerAddress");
    //         }
    //     });
    //     var partNumber = getUrlParameter("partNumber");
    //     var rodEnd = getRodEndCode();
    //
    //     var rodEndConf = this.config.productConfiguratorComponent.getRodEndModificationConfigurationValuesInString();
    //     var simpleSpecialCode = $("#sscw__info_table_simpleSpecialReference").text();
    //     var data = {
    //         productId: this.productId,
    //         partNumber: partNumber,
    //         rodEndConf: rodEndConf,
    //         rodEnd: rodEnd,
    //         simpleSpecialCode : simpleSpecialCode,
    //         customerNumber: selectedCustomer,
    //         customerName : customerName,
    //         customerAddress : customerAddress,
    //         customerPostalCode: customerPostalCode,
    //         selectedCad : selectedCad,
    //         documentationOptions : getDocumentationOptions()
    //     };
    //     var openReference = window.open(smc.channelPrefix + '/loading-page', '_blank');
    //     var url = globalConfig.CylinderWizardModal.urls.getZipFile;
    //     $.get(url, data)
    //         .then(function (response) {
    //             if (response.url && response.url !== undefined && response.url !== null && response.url !== "") {
    //                 //Remove spinner & set File Ready
    //                 $('.loading', openReference.document).hide();
    //                 $('.loaded ', openReference.document).show();
    //                 openReference.location = response.url;
    //             }
    //             _self.enableElement(_self.$zipDownloadButton);
    //         })
    //         .catch(function (error) {
    //             console.debug("zipDownload error" + error);
    //             if (!(window.isIOS || window.isIE || window.isEdge)) openReference.close();
    //             _self.enableElement(_self.$zipDownloadButton);
    //             _self.showError();
    //         }).always(function () {
    //             // _prepareUnloading.call(_self, _self.$zipDownloadButton, $spinner);
    //                 _self.enableElement(_self.$zipDownloadButton);
    //                 setTimeout(function () {
    //                     if (!(window.isIOS || window.isIE || window.isEdge)) openReference.close();
    //                 }, 1500);
    //                 emptySearchingSpinner("sscw__summary_confirmation__content__actions");
    //         }.bind(this));
    // }

    function loadSummaryBySimpleSpecial(){
        console.debug("[loadSummaryBySimpleSpecial] init");
        var simpleSpecialCode = $("#configuration_details__simpleSpecial_value").text();
        if (simpleSpecialCode !== undefined && simpleSpecialCode !== ""){
            var data = {
                simpleSpecialCode : simpleSpecialCode
            };
            addSearchingSpinner("sscw__selection_table_summary_wrapper");
            var url = globalConfig.CylinderWizardModal.urls.getCylinderSummaryTableBySimpleSpecial;
            $.get(url, data)
                .then(function (response) {
                    if (response!== undefined && response !== ""){
                        $(".sscw__selection_table").html(response);
                        $("#sscw__selection_table_pricesConfirm").html(response);
                    }
                    emptySearchingSpinner("sscw__selection_table_summary_wrapper");
                }).catch(function (error) {
                    console.debug("CylinderWizard - loadSummaryBySimpleSpecial error" + error);
                    emptySearchingSpinner("sscw__selection_table_summary_wrapper");
            });
        }
    }

    function getRodEndCode(){
        //we have to check if there is rod End to separate it from the partNumber
        var rodEnd = "";
        if ($("#rodEndOptionsSwitchToggle").is(":checked")){
            //we have to check if there is rod End to separate it from the partNumber
            var selectedImage = $(".XRodImage.image_sel_class_selected").first();
            if (selectedImage !== undefined && selectedImage.length > 0){
                // rodEnd = partNumber.substr(partNumber.lastIndexOf("-")+1);
                rodEnd = $(selectedImage).attr("re_code");
                // partNumber = partNumber.replace("-"+rodEnd,"");
            }
        }
        return rodEnd;
    }

    function getRodEndPosition(){
        if ($(".aareo__cylinder__part_rodEnd .btn") !== undefined && $(".aareo__cylinder__part_rodEnd .btn").length > 0){
            return $(".aareo__cylinder__part_rodEnd .btn").first().attr("data-value");
        }
        return "";
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

    function disableConfiguratorOptions(){
        configuratorOptionsEnabled = false;
        $(".configurationRow select").prop('disabled', true);
        $(".configurationRow select").addClass("noactive");
        $(".configurationRow .select2-selection").addClass("noactive");
        $(".configurationRow .select2-selection__rendered").addClass("noactive_text");
        $(".configurationRow input").prop('disabled', true);
        $(".configurationRow input").addClass("noactive");
        $(".configurationRow .select2-selection").addClass("disabled");
        $(".configurationRow .select2-selection").attr("disabled",true);
        $("#xRodFormArea .rodInputValue input").attr("disabled",true);
        $("#xRodFormArea .rodInputValue input").addClass("disabled");
        $("#ccSubmitFileButton").prop("disabled",true);
        $("#rodEndOptionsSwitchToggle").addClass("disabled");
        $("#rodEndOptionsSwitchToggle").prop('disabled', true);
        $(".rod_sel_images_container").hide();
        $(".pickImageLabel").hide();
        $(".row aareo__create-single-special").addClass("hidden");
        $(".configurationRow input").css("color","#ccc!important");
        $(".cylinder-series .show-cylinder-wizard-btn-js").addClass("disabled");
        $(".cylinder-series .show-cylinder-wizard-btn-js").prop("disabled",true);
        $("#create-simple-special-button").addClass("disabled");
        $("#create-simple-special-button").prop("disabled",true);
        $("#create-simple-special-button").addClass("hidden");
        $(".show-cylinder-wizard-btn-js").addClass("disabled");
        $(".show-cylinder-wizard-btn-js").prop("disabled",true);
        $(".show-cylinder-wizard-btn-js").addClass("hidden");
        $(".open-closed-configuration-js").removeClass("hidden");
        // $("#cylindersConfigurator_beforeRodEnd").addClass("hidden");
        $("#cylindersConfigurator_beforeRodEnd .aareo_configuration_part .alert").addClass("hidden");
        $(".aareo__cylinder__part_position_js.btn").css("pointer-events", "none");
        $("#aareo__choose-accesory").addClass("hidden");
        $(".aareo__another-reference").addClass("hidden");
        $(".aareo_accesory_summary_data .btn-danger-outline").addClass("hidden");
        $(".aareo__create-single-special").addClass("hidden");
        $(".aareo__choose-add-modify").addClass("hidden");
        $(".aareo__cylinder aareo_configuration_part").addClass("hidden");
        $(".aareo_accesory_summary_row_buttons_delete_container").addClass("hidden");

        $("#accesoriesAndRodEndOptionsSwitchToggle").prop("disabled", true);

        showSimpleSpecialHTO();

    }

    function enableConfiguratorOptions() {
        configuratorOptionsEnabled = true;

        var userHasAccessoriesPermission = $("#accessoriesPermission").val() == "true";

        $(".configurationRow select").prop('disabled', false);
        $(".configurationRow select").removeClass("noactive");
        $(".configurationRow .select2-selection").removeClass("noactive");
        $(".configurationRow .select2-selection__rendered").removeClass("noactive_text");
        $(".configurationRow input").prop('disabled', false);
        $(".configurationRow input").removeClass("noactive");
        $(".configurationRow .select2-selection").removeClass("disabled");
        $(".configurationRow .select2-selection").attr("disabled",false);
        $("#xRodFormArea .rodInputValue input").attr("disabled",false);
        $("#xRodFormArea .rodInputValue input").removeClass("disabled");
        $("#ccSubmitFileButton").prop("disabled",false);
        $("#rodEndOptionsSwitchToggle").removeClass("disabled");
        $("#rodEndOptionsSwitchToggle").prop('disabled', false);
        $(".rod_sel_images_container").show();
        $(".pickImageLabel").show();
        $(".row aareo__create-single-special").removeClass("hidden");
        $(".configurationRow input").css("color","#000!important");
        $(".cylinder-series .show-cylinder-wizard-btn-js").removeClass("disabled");
        $(".cylinder-series .show-cylinder-wizard-btn-js").prop("disabled",false);
        $("#create-simple-special-button").removeClass("disabled");
        $("#create-simple-special-button").prop("disabled",false);
        $("#create-simple-special-button").removeClass("hidden");
        $(".show-cylinder-wizard-btn-js").removeClass("disabled");
        $(".show-cylinder-wizard-btn-js").prop("disabled",false);
        $(".show-cylinder-wizard-btn-js").removeClass("hidden");
        $(".open-closed-configuration-js").addClass("hidden");
        if (userHasAccessoriesPermission) {
            $("#cylindersConfigurator_beforeRodEnd").removeClass("hidden");
            $("#cylindersConfigurator_beforeRodEnd .aareo_configuration_part .alert").removeClass("hidden");
        } else {
            $("#aareo_configuration_part_modifyRodEnd").click();
        }
        $(".cylinder-info-container__content__actions").addClass("hidden");
        $(".aareo__cylinder__part_position_js.btn").css("pointer-events", "auto");
        // $("#aareo__choose-accesory").removeClass("hidden");
        $(".aareo__another-reference").removeClass("hidden");
        $(".aareo_accesory_summary_data .btn-danger-outline").removeClass("hidden");
        $(".aareo__create-single-special").removeClass("hidden");
        $(".aareo__choose-add-modify").removeClass("hidden");
        // $(".aareo__cylinder aareo_configuration_part").removeClass("hidden");
        $(".aareo_accesory_summary_row_buttons_delete_container").removeClass("hidden");

        $("#accesoriesAndRodEndOptionsSwitchToggle").prop("disabled", false)
    }

    function getDocumentationOptions(){
        return $('.documentation-option-checkbox:checkbox:checked').map(function() {
            return this.id;
        }).get().join();
    }

    function parseAccesories(){
        console.debug("[CylinderWizard - parseAccesories]");
        var accessories = [];
        $("#aareo_configuration-summary_accesory_summary-list .aareo_accesory_summary_element").each(function(){
            var partNumber = $(this).attr("partnumber-value");
            var currentZone = $(this).attr("zone-value");
            var itemGroup = $(this).attr("group-value");
            var currentDescription = $(this).find(".aareo_accesory_summary_row_description").text();
            var accessory = {partNumber : partNumber, position : currentZone, description : currentDescription, itemGroup:itemGroup, quantity: 1};
            accessories.push(accessory);
        });
        $("#aareo_configuration-summary_accesory_no_position_summary-list .aareo_accesory_no_position_row").each(function(){
            var partNumber = $(this).attr("partnumber-value");
            var currentZone = $(this).attr("zone-value");
            var itemGroup = $(this).attr("group-value");
            var currentDescription = $(this).find(".aareo_accesory_summary_row_description").text();
            var currentQuantity = $(this).find(".aareo_accesory_summary_row_quantity").text();
            for (i = 0 ; i < parseInt(currentQuantity); i++){
                var accessory = {partNumber : partNumber, position : currentZone, description : currentDescription, itemGroup:itemGroup, quantity: 1};
                accessories.push(accessory);
            }
        });
        return accessories;
    }

    function _prepareLoading(wizard, $zipDownloadButton, $spinner) {
        //Show Spinner
        $spinner.html(wizard.templates.spinnerTemplateHTML);

        $zipDownloadButton.addClass('is-downloading');
        $('span',$zipDownloadButton).css('display', 'none');
    }
    function _prepareUnloading(wizard, $zipDownloadButton, $spinner) {
        $spinner.html('');

        $zipDownloadButton.removeClass('is-downloading');
        $('span', $zipDownloadButton).css('display', 'inline');
    }

    function enableElement(element){
        element.removeClass("disabled");
        element.removeAttr("disabled");
    }

    function disableElement(element){
        element.addClass("disabled");
        element.attr("disabled","disabled");
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

    function hideAlert() {
        $('.alert-wizard-text').addClass("hidden");
        $('#alert-wizard-text-message').text("");
    }

    function showAlert(message) {
        $('#alert-wizard-text-message').text(message);
        $('.alert-wizard-text').removeClass("hidden");
    }

    function hideError() {
        $('.error-wizard-text').addClass("hidden");
        // $('#alert-wizard-text-message').text("");
        $(".sscw-message-error").addClass("hidden");
        $("#wizard-error-message").text("");
    }

    function showError() {
        // $('#alert-wizard-text-message').text(message);
        $('.error-wizard-text').removeClass("hidden");
    }

    function addSearchingSpinner(containerId) {
        if ($("#"+containerId+" .sscw__loading_spinner").is(":empty")){
            $("#"+containerId+" .sscw__loading_spinner").append(getSearchingSpinner());
        }
    }

    function getSearchingSpinner() {
        return document.getElementById('spinner-template').innerHTML;
    }

    function emptySearchingSpinner(containerId){
        $("#"+containerId+" .sscw__loading_spinner").empty();
    }

    function showMainHTO() {
        $(".idbl_hto.container").removeClass("idbl_hto--ccss");
        $("#series_hto_simple_special").html("");
        $(".cylinder-info-container__content__actions").addClass("hidden");
        $(".idbl_hto__content__info").hide();
        $(".idbl_hto.container").addClass("idbl_hto--cc");
    }

    function showSimpleSpecialHTO() {
        $(".idbl_hto.container").removeClass("idbl_hto--cc");
        $(".idbl_hto__content__info").show();
        $(".idbl_hto.container").addClass("idbl_hto--ccss");
    }

    window.smc.CylinderWizardModal = CylinderWizardModal;
})(window.smc);
$("#sscw__info_table_simpleSpecialReference").text("");
