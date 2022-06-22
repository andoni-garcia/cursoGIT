(function(globalConfig) {

    function ProjectInformationModule(config) {
        this.config = config;
    }

    ProjectInformationModule.prototype.init = init;
    ProjectInformationModule.prototype.initialWorkflow = initialWorkflow;
    ProjectInformationModule.prototype.activateTabs = activateTabs;
    ProjectInformationModule.prototype.loadProjectInfoFromParams = loadProjectInfoFromParams;
    ProjectInformationModule.prototype.initializeEvents = initializeEvents;

    function init() {
        console.log('[ProjectInformationModule]', 'init');

        this.templates = {};

        window.FormValidator.init();
        this.initialWorkflow();
        this.initializeEvents();

        $('#projectDescription')
            .on('keypress', function (event) {
                var textarea = $(this),
                    text = textarea.val(),
                    numberOfLines = (text.match(/\n/g) || []).length + 1,
                    maxRows = parseInt(textarea.attr('max-rows'));

                if (event.which === 13 && numberOfLines === maxRows ) {
                    return false;
                }
            });
        $(document).trigger('smc.registercomponent', [this.config.id, this]);
    }

    function initialWorkflow() {
        this.activateTabs();
        this.loadProjectInfoFromParams();
    }

    function activateTabs() {
        var _self = this;

        var $tabsLinks = $('.navigation-links-js', _self.config.container);
        $($tabsLinks).on('click', 'a', function (e) {
            e.preventDefault();
            var $this = $(this);

            if (_self.config.device !== 'DESKTOP') {
                //Remove all active nav links
                $('a', $tabsLinks).not($this).removeClass('active');

                $this.toggleClass('active');

                var target = $this.data("target");
                $(target).collapse('toggle');
            }
        });
    }

    function loadProjectInfoFromParams() {
        var currentUrl = new URL(window.location.href);

        var projectInfoData = {};
        var keysIterator = currentUrl.searchParams.keys();
        var key = keysIterator.next();
        while (key && key.value) {
            var value = currentUrl.searchParams.get(key.value);
            projectInfoData[key.value] = (value && value !== 'null') ? value : '';
            key = keysIterator.next();
        }

        if (projectInfoData && Object.keys(projectInfoData).length) {
            _loadProjectInfoData(projectInfoData);
        }
    }

    function initializeEvents() {
        var $document = $(document);

        this.$projectDesignerContactForm = this.$projectDesignerContactForm || $('#project-designer-contact-form');
        _loadDefaultDesigner.call(this);
        this.$projectDesignerContactForm.on('submit', _saveDesignerContact.bind(this));

        this.$projectCustomerContactForm = this.$projectCustomerContactForm || $('#project-customer-contact-form');
        this.$projectCustomerContactForm.on('submit', _saveCustomerContact.bind(this));

        this.$loadContactBtn = this.$loadContactBtn || $('#load-contact-btn', this.$projectCustomerContactForm);
        this.$loadContactBtn.on('click', _loadCustomerContact.bind(this));

        this.$pdfReportBtn = this.$pdfReportBtn || $('#pdfReportBtn');
        this.$pdfReportBtn.on('click', _generatePDFReport.bind(this));

        this.$saveProjectBtn = this.$saveProjectBtn || $('#saveProjectBtn');
        this.$saveProjectBtn.on('click', _saveProject.bind(this));

        $document.on('smc.productConfiguratorComponent.loadProjectFile', _loadProject.bind(this));
        $document.on('smc.partNumber.changed', _onPartNumberUpdated.bind(this));
        $document.on('smc.rodEndModificationConfig.changed', _onRodEndModificationConfigUpdated.bind(this))
    }

    function _loadDefaultDesigner() {
        var _self = this;
        var url = smc.projectInformationModule.urls.getDefaultDesigner;

        $.getJSON(url)
            .then(function (response) {
                _fillContactData(response, _self.$projectDesignerContactForm);
            })
            .catch(function (error) {
                console.error('[ProjectInformationModule]', '_getDefaultDesigner', error);
            });
        return false;
    }

    function _saveDesignerContact() {
        var _self = this;

        if (!smc.isAuthenticated){
            smc.NotifyComponent && smc.NotifyComponent.error(_self.config.messages.notLogged);
            return false;
        }

        var url = smc.projectInformationModule.urls.updateDesigner;
        var formData = this.$projectDesignerContactForm.serialize();

        $.getJSON(url, formData)
            .then(function (response) {
                _fillContactData(response, _self.$projectDesignerContactForm);
                smc.NotifyComponent && smc.NotifyComponent.info(_self.config.messages.designerCreated);
            })
            .catch(function (error) {
                console.error('[ProjectInformationModule]', '_saveDesignerContact', error);
                smc.NotifyComponent && smc.NotifyComponent.error(globalConfig.messages.generalError);
            });
        return false;
    }

    function _saveCustomerContact() {
        var _self = this;

        if (!smc.isAuthenticated){
            smc.NotifyComponent && smc.NotifyComponent.error(_self.config.messages.notLogged);
            return false;
        }

        var url = smc.projectInformationModule.urls.updateCustomer;
        var formData = this.$projectCustomerContactForm.serialize();

        $.getJSON(url, formData)
            .then(function (response) {
                _fillContactData(response, _self.$projectCustomerContactForm);
                smc.NotifyComponent && smc.NotifyComponent.info(_self.config.messages.customerCreated);
            })
            .catch(function (error) {
                console.error('[ProjectInformationModule]', '_saveCustomerContact', error);
                smc.NotifyComponent && smc.NotifyComponent.error(globalConfig.messages.generalError);
            });
        return false;
    }

    function _loadCustomerContact() {
        var _self = this;

        if (!smc.isAuthenticated){
            smc.NotifyComponent && smc.NotifyComponent.error(_self.config.messages.notLogged);
            return false;
        }

        //Trigger form validations
        if (!_self.$projectCustomerContactForm[0].checkValidity()) {
            _self.$projectCustomerContactForm[0].reportValidity();
            return false;
        }

        var url = smc.projectInformationModule.urls.getCustomerByName;
        var name = $('input[name="name"]', _self.$projectCustomerContactForm).val();

        $.getJSON(url, { name: name })
            .then(function (contacts) {
                _createCustomerContactModal.call(_self, contacts);
            })
            .catch(function (error) {
                console.error('[ProjectInformationModule]', '_loadCustomerContact', error);
                smc.NotifyComponent && smc.NotifyComponent.error(globalConfig.messages.generalError);
            });
        return false;
    }

    function _createCustomerContactModal(contacts) {
        var _self = this;
        var $list = $('<ul>', {
            class: 'list-items empty-list'
        });

        var customerContactPopoverTemplate = this.templates.customerContactPopoverTemplate || document.getElementById('customerContactPopoverTemplate').innerHTML;
        var customerContactItemTemplate = this.templates.customerContactItemTemplate || document.getElementById('customerContactItemTemplate').innerHTML;

        //Fill the Form when we have only one result
        if (contacts.length === 1) {
            _fillContactData(contacts[0], _self.$projectCustomerContactForm);
            window.FormValidator.refresh();
            disposePopover();
            return false;
        }

        contacts.forEach(function (customer) {
            var customerItem = customerContactItemTemplate
                .replace('{{customer_fullname}}', customer.name)
                .replace('{{customer_id}}', customer.id);
            $list.append($(customerItem));
        });

        this.$loadContactBtn.popover({
            title: 'Customer contacts',
            content: contacts.length > 0 ? $list[0].outerHTML : this.config.messages.noResultsToDisplay,
            placement: 'left',
            template: customerContactPopoverTemplate,
            html: true
        }).popover('show');

        var $popoverContainer = $('.customer-contact-popover-js');

        $('.customer-contact-item-name-js', $popoverContainer).click(function () {
            var contactId = $(this).parents('.customer-contact-item').data('contactid');
            var contactData = contacts.find(function (contact) {
                return contact.id === contactId;
            });
            _fillContactData(contactData, _self.$projectCustomerContactForm);
            disposePopover();
            window.FormValidator.refresh();
        });

        $('.remove-contact-btn-js', $popoverContainer).click(function () {
            var $customerContactItem = $(this).parents('.customer-contact-item');
            var contactId = $customerContactItem.data('contactid');
            _removeCustomerContact.call(_self, contactId, $customerContactItem);
        });

        function disposePopover(event) {
            //Avoid close when the element is the Popover
            if (event) {
                if ($(event.target).closest('.customer-contact-popover').length) {
                    return;
                }
            }

            _self.$loadContactBtn && _self.$loadContactBtn.popover('dispose');
            $(document).off('click', disposePopover);
        }

        $('.close-btn-js', $popoverContainer).click(function () {
            disposePopover();
        });

        //Close popover on outside click
        $(document).on('click', disposePopover);
    }

    function _fillContactData(contactData, $form) {
        if (contactData) {
            $('input[name="id"]', $form).val(contactData.id);
            $('input[name="name"]', $form).val(contactData.name);
            $('input[name="company"]', $form).val(contactData.company);
            $('input[name="email"]', $form).val(contactData.email);
            $('input[name="address"]', $form).val(contactData.address);
            $('input[name="phone"]', $form).val(contactData.phone);
            $('input[name="town"]', $form).val(contactData.town);
            $('input[name="fax"]', $form).val(contactData.fax);
            $('input[name="zip"]', $form).val(contactData.zip);
        }
    }

    function _removeCustomerContact(contactId, $customerContactItem) {
        var _self = this;
        var url = smc.projectInformationModule.urls.deleteCustomerById;

        $.getJSON(url, { id: contactId })
            .then(function (id) {
                $customerContactItem.fadeOut();
                smc.NotifyComponent && smc.NotifyComponent.info(_self.config.messages.contactRemoved);
            })
            .catch(function (error) {
                console.error('[ProjectInformationModule]', '_loadCustomerContact', error);
                smc.NotifyComponent && smc.NotifyComponent.error(globalConfig.messages.generalError);
            });
        return false;
    }

    function _generatePDFReport() {
        console.info('[ProjectInformationModule]', '_generatePDFReport');
        var _self = this;

        var checkRodEndConfig = true;
        if (configuratorOptionsEnabled && !smc.productConfiguratorComponent.isValidConfiguration(checkRodEndConfig)) {
            smc.NotifyComponent && smc.NotifyComponent.error(_self.config.messages.completeRodEndConfiguration);
            return;
        }

        var url = new URL(smc.projectInformationModule.urls.generatePDFReport);
        url.search = url.search.split("rid=generatePDFReport")[0]+"rid=generatePDFReport";
        var simpleSpecialCode = ($("#aareo_switch_container")!=undefined)? $("#series_hto_simple_special").text() : "";
        if (simpleSpecialCode !== undefined && simpleSpecialCode !== ""){
            url.searchParams.set("simpleSpecialCode",simpleSpecialCode);
        }
        if (!configuratorOptionsEnabled && (Object.keys(rodendUserValues).length > 0)) {
            url.searchParams.set("rodEndConf", window.smc.productConfiguratorComponent.getRodEndModificationConfigurationValuesInString());
        }
        var data = _getProjectInfoData.call(this);
        var openReference = window.open(smc.channelPrefix + '/loading-page', '_blank');
        $.getJSON(url, data)
            .then(function (response) {
                if (response && response.url) {
                    //Remove spinner & set File Ready
                    $('.loading', openReference.document).hide();
                    $('.loaded ', openReference.document).show();
                    openReference.location = response.url;

                } else {
                    console.error('[ProjectInformationModule]', '_generatePDFReport', 'URL a null=', response);
                    smc.NotifyComponent && smc.NotifyComponent.error(globalConfig.messages.generalError);
                }
                $("#pdfReportBtn").removeAttr("disabled");
            })
            .catch(function (error) {
                console.error('[ProjectInformationModule]', '_generatePDFReport', error);
                openReference.close();
                smc.NotifyComponent && smc.NotifyComponent.error(globalConfig.messages.generalError);
            });
    }

    function _loadProject(event, file) {
        console.info('[ProjectInformationModule]', '_loadProject');
        var _self = this;

        var data = {
            filename: file.name,
            content: file.content
        };

        var url = smc.projectInformationModule.urls.loadProject;
        $.getJSON(url, data)
            .then(function (response) {
                // For simple specials, take the code and redirect
                if (response && response.projectInfo && response.projectInfo.apiSimpleSpecial && response.projectInfo.apiSimpleSpecial.simpleSpecialCode) {
                    var url = new URL(location.href);
                    url.searchParams.set('simpleSpecialCode', response.projectInfo.apiSimpleSpecial.simpleSpecialCode);
                    location.href = url.href;
                } else {
                    //Redirect after load the data
                    if (response && response.productData) {
                        console.log('[ProjectInformationModule]', '_loadProject');

                        var projectUrl = new URL(window.location.origin + response.productData.nodeData.url);
                        projectUrl.searchParams.set('partNumber', response.projectInfo.partNumber);

                        var locationHrefUrl = new URL(location.href);
                        if (locationHrefUrl.searchParams.get('cylinderConfig')) {
                            projectUrl.searchParams.set('cylinderConfig', locationHrefUrl.searchParams.get('cylinderConfig'));
                        }

                        if (locationHrefUrl.searchParams.get('cylinderConfigComplete')) {
                            projectUrl.searchParams.set('cylinderConfigComplete', locationHrefUrl.searchParams.get('cylinderConfigComplete'));
                        }

                        if (response.projectInfo) {
                            for (var key in response.projectInfo) {
                                projectUrl.searchParams.set(key, response.projectInfo[key]);
                            }
                            if(response.projectInfo.accessories) {
                                var accessories = encodeURIComponent(JSON.stringify(response.projectInfo.accessories));
                                projectUrl.searchParams.set('accessories', accessories);
                            }
                        }

                        location.href = projectUrl;

                    } else {
                        console.error('[ProjectInformationModule]', '_loadProject', 'No "product" in the response object');
                        smc.NotifyComponent && smc.NotifyComponent.error(globalConfig.messages.generalError);
                    }
                }

            })
            .catch(function (error) {
                console.error('[ProjectInformationModule]', '_loadProject', error);
                smc.NotifyComponent && smc.NotifyComponent.error(globalConfig.messages.generalError);
            });
        return false;
    }

    function _saveProject() {
        console.info('[ProjectInformationModule]', '_saveProject');
        var url = new URL(smc.projectInformationModule.urls.saveProject);
        //required params
        //      _hn:type
        //        _hn:ref
        //        _hn:rid
        url.search = url.search.split("rid=saveProject")[0]+"rid=saveProject";

        var simpleSpecialCode = ($("#aareo_switch_container")!=undefined)? $("#series_hto_simple_special").text() : "";
        if (simpleSpecialCode !== undefined && simpleSpecialCode !== ""){
            url.searchParams.set("simpleSpecialCode",simpleSpecialCode);
        }
        var data = _getProjectInfoData.call(this);
        var openReference = window.open(smc.channelPrefix + '/loading-page', '_blank');

        $.getJSON(url, data)
            .then(function (response) {
                //Remove spinner & set File Ready
                $('.loading', openReference.document).hide();
                $('.loaded ', openReference.document).show();
                openReference.location = response.url;
            })
            .catch(function (error) {
                console.error('[ProjectInformationModule]', '_saveProject', error);
                if (!(window.isIOS || window.isIE || window.isEdge)) openReference.close();
                smc.NotifyComponent && smc.NotifyComponent.error(globalConfig.messages.generalError);
            })
            .always(function () {
                setTimeout(function () {
                    if (!(window.isIOS || window.isIE || window.isEdge)) openReference.close();
                }, 500);
            });
        return false;
    }

    function _getProjectInfoData() {
        var selectedRodEndValue = '';
        var rodEndConf = '';
        var rodEnd = "";
        if (smc.productConfiguratorComponent) {
            var productConfig = smc.productConfiguratorComponent.getProductConfiguration(true);

            var rodEndDomain = productConfig.find(function (configAttribute) {
                return configAttribute.code === 'XROD_ENDS';
            });
            var selectedValue = rodEndDomain['aDSV'][0];
            selectedRodEndValue = rodEndDomain.getMember(selectedValue);

            var rodEndModificationConfiguration = smc.productConfiguratorComponent.getRodEndModificationConfigurationValues();
            for (var propertyName in rodEndModificationConfiguration) {
                rodEndConf += propertyName.toUpperCase() + '=' + rodEndModificationConfiguration[propertyName] + ';';
            }
            rodEnd = selectedRodEndValue.code;
        }

        if (rodEndConf === undefined){
            rodEndConf = "";
        }

        if (rodEnd === undefined){
            rodEnd = "";
        }

        if (this.partNumber === undefined) {
            // try to get it from partNumberString or URL
            if (partNumberString) {
                this.partNumber = partNumberString;
            } else {
                var locationHrefUrl = new URL(location.href);
                if (locationHrefUrl.searchParams.get('partNumber')) {
                    this.partNumber = locationHrefUrl.searchParams.get('partNumber');
                }
            }
        }

        var simpleSpecialCode = ($("#aareo_switch_container")!=undefined)? $("#series_hto_simple_special").text() : "";
        var data = {
            productId: this.config.productId,
            // partNumber: (simpleSpecialCode !== undefined && simpleSpecialCode !== "")? simpleSpecialCode : this.partNumber,
            simpleSpecialCode: simpleSpecialCode,
            partNumber: this.partNumber,
            "viewMode": isMobile ? 'mobile' : 'desktop',
            "specialOption": "CC",
            "rodEnd": rodEnd,
            "rodEndConf": rodEndConf,
            "projectDescription": $('#projectDescription').val(),
            "solicitorName": $('input[name="name"]', this.$projectDesignerContactForm).val(),
            "solicitorCompany": $('input[name="company"]', this.$projectDesignerContactForm).val(),
            "solicitorEmail": $('input[name="email"]', this.$projectDesignerContactForm).val(),
            "solicitorAddress": $('input[name="address"]', this.$projectDesignerContactForm).val(),
            "solicitorPhone": $('input[name="phone"]', this.$projectDesignerContactForm).val(),
            "solicitorTown": $('input[name="town"]', this.$projectDesignerContactForm).val(),
            "solicitorFax": $('input[name="fax"]', this.$projectDesignerContactForm).val(),
            "solicitorZip": $('input[name="zip"]', this.$projectDesignerContactForm).val(),
            "customerName": $('input[name="name"]', this.$projectCustomerContactForm).val(),
            "customerCompany": $('input[name="company"]', this.$projectCustomerContactForm).val(),
            "customerEmail": $('input[name="email"]', this.$projectCustomerContactForm).val(),
            "customerAddress": $('input[name="address"]', this.$projectCustomerContactForm).val(),
            "customerPhone": $('input[name="phone"]', this.$projectCustomerContactForm).val(),
            "customerTown": $('input[name="town"]', this.$projectCustomerContactForm).val(),
            "customerFax": $('input[name="fax"]', this.$projectCustomerContactForm).val(),
            "customerZip": $('input[name="zip"]', this.$projectCustomerContactForm).val(),
            "mounted": $("#mounted").is(":checked") || $("#mounted_summary").is(":checked"),
            "accessories" : ($("#aareo_switch_container")!=undefined && $("#aareo_switch_container").is(":visible")) ? encodeURIComponent(JSON.stringify(parseAccessories())) : ""
        };
        return data;
    }

    function parseAccessories(){
        console.debug("[ProjectInformation - parseAccessories]");
        var accessories = [];
        $("#aareo_configuration-summary_accesory_summary-list .aareo_accesory_summary_element").each(function(){
            var partNumber = $(this).attr("partnumber-value");
            var currentZone = $(this).attr("zone-value");
            var itemGroup = $(this).attr("group-value");
            var currentDescription = $(this).find(".aareo_accesory_summary_row_description").text();
            var accessory = {partNumber : partNumber, position : currentZone, description : currentDescription, quantity: 1, itemGroup:itemGroup};
            accessories.push(accessory);
        });
        $("#aareo_configuration-summary_accesory_no_position_summary-list .aareo_accesory_no_position_row").each(function(){
            var partNumber = $(this).attr("partnumber-value");
            var currentZone = $(this).attr("zone-value");
            var currentDescription = $(this).find(".aareo_accesory_summary_row_description").text();
            // var currentQuantity = $(this).find(".aareo_accesory_summary_row_quantity").text();
            // for (i = 0 ; i < parseInt(currentQuantity); i++){
                var accessory = {partNumber : partNumber, position : currentZone, description : currentDescription, quantity: 1, itemGroup:""};
                accessories.push(accessory);
            // }
        });
        return accessories;
    }


    function _loadProjectInfoData(projectInfoData) {
        if (projectInfoData.projectDescription) {
            _setValueInField($('#projectDescription'), projectInfoData.projectDescription);
        } else {
            _setValueInField($('#projectDescription'), projectInfoData.projDesc);
        }
        _setValueInField($('input[name="name"]', this.$projectDesignerContactForm), projectInfoData.solicitorName);
        _setValueInField($('input[name="company"]', this.$projectDesignerContactForm), projectInfoData.solicitorCompany);
        _setValueInField($('input[name="email"]', this.$projectDesignerContactForm), projectInfoData.solicitorEmail);
        _setValueInField($('input[name="address"]', this.$projectDesignerContactForm), projectInfoData.solicitorAddress);
        _setValueInField($('input[name="phone"]', this.$projectDesignerContactForm), projectInfoData.solicitorPhone);
        _setValueInField($('input[name="town"]', this.$projectDesignerContactForm), projectInfoData.solicitorTown);
        _setValueInField($('input[name="fax"]', this.$projectDesignerContactForm), projectInfoData.solicitorFax);
        _setValueInField($('input[name="zip"]', this.$projectDesignerContactForm), projectInfoData.solicitorZip);
        _setValueInField($('input[name="name"]', this.$projectCustomerContactForm), projectInfoData.customerName);
        _setValueInField($('input[name="company"]', this.$projectCustomerContactForm), projectInfoData.customerCompany);
        _setValueInField($('input[name="email"]', this.$projectCustomerContactForm), projectInfoData.customerEmail);
        _setValueInField($('input[name="address"]', this.$projectCustomerContactForm), projectInfoData.customerAddress);
        _setValueInField($('input[name="phone"]', this.$projectCustomerContactForm), projectInfoData.customerPhone);
        _setValueInField($('input[name="town"]', this.$projectCustomerContactForm), projectInfoData.customerTown);
        _setValueInField($('input[name="fax"]', this.$projectCustomerContactForm), projectInfoData.customerFax);
        _setValueInField($('input[name="zip"]', this.$projectCustomerContactForm), projectInfoData.customerZip);
    }

    function _setValueInField($input, value) {
        $input.val(value && value !== 'null' ? value : '');
    }

    function _onPartNumberUpdated(e, partNumber) {
        this.partNumber = partNumber;
    }

    function _onRodEndModificationConfigUpdated() {
        //If the Standard rodend configuration is selected, the PDF_Report button is disabled
        if (smc.productConfiguratorComponent && smc.productConfiguratorComponent.hasDefaultRodEndModificationConfiguration()) {
            var ccAccesoriesContainer = $(".cylinder-info-container__partnumber_title__accesories");
            if (ccAccesoriesContainer.size() == 0 || ccAccesoriesContainer.is(":empty")) {
                this.$pdfReportBtn.attr('disabled', 'disabled');
            }
        } else {
            this.$pdfReportBtn.removeAttr('disabled');
        }
    }

    window.smc.ProjectInformationModule = ProjectInformationModule;
})(window.smc);
