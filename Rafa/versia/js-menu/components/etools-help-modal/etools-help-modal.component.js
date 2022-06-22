(function (globalConfig) {

    function EtoolsHelpModal(config) {
        this.id = config.id;
        this.config = config;
    }

    EtoolsHelpModal.prototype.init = init;
    EtoolsHelpModal.prototype.initializeEvents = initializeEvents;
    EtoolsHelpModal.prototype.showModal = showModal;
    EtoolsHelpModal.prototype.initLoading = initLoading;
    EtoolsHelpModal.prototype.endLoading = endLoading;
    EtoolsHelpModal.prototype.askForHelp = askForHelp;
    EtoolsHelpModal.prototype.updateContact = updateContact;
    EtoolsHelpModal.prototype.initModalButtons = initModalButtons;

    function init() {
        console.debug('[EtoolsHelpModal]', 'init id=', this.id);
        if (!this.config.container) {
            throw new Error('"Container" is required');
        }
        this.templates = {
            spinnerTemplateHTML: document.getElementById('spinner-template').innerHTML
        };
        this.links = {
            showModalLink: $('.show-etools-help-modal', this.config.container)
        };

        this.initializeEvents();
    }

    function initializeEvents() {
        var _self = this;
        $('.show-etools-help-modal', this.config.container).on('click', function () {
            _self.showModal();
        });


    }

    function initModalButtons() {
        this.$updateContactButton = $("#help_form_updateContactButton");
        this.$askForHelpButton = $("#help_form_btn_send");
        this.$updateContactButton.click(this.updateContact.bind(this));
        this.$askForHelpButton.click(this.askForHelp.bind(this));
    }

    function showModal() {
        var _self = this;
        if ($('.show-etools-help-modal', this.config.container).attr("disabled") !== undefined) {
            console.log("already disabled");
            return;
        }
        $(".etools-help-message").addClass("hidden");
        $(".show-etools-help-modal").attr("disabled", "disabled");
        console.debug("[EtoolsHelpModal] showModal init", _self.config.container);
        $('.etools-help-modal').remove();
        $("#etoolsHelpModal_main_container").empty();
        this.initLoading(_self.links.showModalLink);
        var data = {};
        $.get(_self.config.urls.getEtoolsHelpModal, data)
            .then(function (response) {
                console.debug("[EtoolsHelpModal] showModal response");
                $("#etoolsHelpModal_main_container").html(response);
                $("#_showEtoolsHelpModal").modal('show');
                _self.endLoading(_self.links.showModalLink);
                _self.initModalButtons();
                $(".show-etools-help-modal").removeAttr("disabled");
            })
            .catch(function (error) {
                console.log("[EtoolsHelpModal] error", error);
                _self.endLoading(_self.links.showModalLink);
                $(".show-etools-help-modal").removeAttr("disabled");
            });
    }

    function initLoading($container) {
        $container.attr('disabled', 'disabled');
        $('.loading-container-js', $container)
            .addClass('loading-container')
            .html(this.templates.spinnerTemplateHTML);
    }

    function endLoading($container) {
        $container.removeAttr('disabled');
        $('.loading-container-js', $container)
            .removeClass('loading-container')
            .html('');
    }

    function updateContact() {
        console.log("[EtoolsHelpModal] updateContact");
        var _self = this;
        $(".etools-help-message").addClass("hidden");
        _self.$updateContactButton.attr("disabled", true);
        var newSMCContact = $("#help_form_contactPerson").val();
        var data = {
            newSMCContact: newSMCContact
        };
        var url = _self.config.urls.updateEtoolsHelpContact;
        $.get(url, data)
            .then(function (response) {
                if (response !== "") {

                }
                _self.$updateContactButton.removeAttr("disabled");
                $(".etools-help-update-contact-success").removeClass("hidden");
            })
            .catch(function (error) {
                console.log("[EtoolsHelpModal] updateContact error", error);
                _self.$updateContactButton.removeAttr("disabled");
                $(".etools-help-update-contact-error").removeClass("hidden");
            });
    }

    function askForHelp() {
        console.log("[EtoolsHelpModal] askForHelp");
        var _self = this;
        $(".etools-help-message").addClass("hidden");
        _self.$askForHelpButton.attr("disabled", true);
        _self.initLoading($("#_showEtoolsHelpModal"));

        var complete = true;
        $("#etools-help-contact-form input.required").each(function () {
            if (this.value.trim() === "") {
                complete = false;
                $(this).addClass("is-invalid");
            } else {
                $(this).removeClass("is-invalid");
            }
        });
        if (!complete) {
            _self.endLoading($("#_showEtoolsHelpModal"));
            _self.$askForHelpButton.removeAttr("disabled");
            return;
        }
        var data = {
            contactPerson: $("#help_form_contactPerson").val(),
            nameSurname: $("#help_form_nameSurname").val(),
            email: $("#help_form_email").val(),
            company: $("#help_form_company").val(),
            country: $("#help_form_country").val(),
            phone: $("#help_form_phone").val(),
            yourMessage: $("#help_form_yourMessage").val(),
            acceptCommercial: $("#help_form_acceptCommercial").is(":checked"),
            frlUrl: "",
            installationSheetUrl: ""
        };
        window.etoolsHelpRequested = true;
        window.eToolsFileUrl = "";
        GetConfig();
        ensureEtoolsFileUrlIsSet().then(function () {
            data.frlUrl = window.eToolsFileUrl;
            window.eToolsFileUrl = "";
            GetPDF();
            ensureEtoolsFileUrlIsSet().then(function () {
                data.installationSheetUrl = window.eToolsFileUrl;
                window.eToolsFileUrl = "";
                window.etoolsHelpRequested = false;
                var url = _self.config.urls.sendEtoolsHelpModal;
                console.log("[EtoolsHelpModal] ask for help", url, data);
                $.get(url, data)
                    .then(function (response) {
                        if (response !== "") {

                            $(".etools-help-contact-success").removeClass("hidden");
                        }
                        _self.$askForHelpButton.removeAttr("disabled");
                        _self.endLoading($("#_showEtoolsHelpModal"));
                    })
                    .catch(function (error) {
                        console.log("[EtoolsHelpModal] askForHelp error", error);
                        $(".etools-help-contact-error").removeClass("hidden");
                        _self.$askForHelpButton.removeAttr("disabled");
                        _self.endLoading($("#_showEtoolsHelpModal"));
                    });
            });
        })
    }

    function ensureEtoolsFileUrlIsSet() {
        return new Promise(function (resolve, reject) {
            waitForEtoolsFileUrl(resolve);
        });
    }

    function waitForEtoolsFileUrl(resolve) {
        if (!window.eToolsFileUrl) {
            setTimeout(waitForEtoolsFileUrl.bind(this, resolve), 200);
        } else {
            resolve();
        }
    }

    window.smc.EtoolsHelpModal = EtoolsHelpModal;
})(window.smc);
