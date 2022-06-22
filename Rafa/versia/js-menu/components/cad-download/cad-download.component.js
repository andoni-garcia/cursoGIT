(function(globalConfig) {
    function CadDownloadComponent(config) {
        this.id = config.id;
        this.config = config;
    }

    CadDownloadComponent.prototype.init = function () {
        console.debug('[CadDownloadComponent]', 'init id=', this.id);
        if (!this.config.container) {
            throw new Error('"Container" is required');
        }

        this.$form = $('form', this.config.container);
        this.templates = {
            spinnerTemplateHTML: document.getElementById('spinner-template').innerHTML
        };

        _initialWorkflow.call(this);
        _initializeEvents.call(this);
        $(document).trigger('smc.registercomponent', [this.id, this]);
    };

    function _initialWorkflow() {
        var lastUsedFormat = window.localStorage.getItem('cadDownload.lastUsedFormat');
        if (lastUsedFormat) {
            _selectFormatByValue.call(this, this.$form, lastUsedFormat);
        }
    }

    function _initializeEvents() {
        $('.cad-download-btn-js', this.config.container).on('click', downloadCadFile.bind(this));
        $('.cad-format-option-js', this.config.container).on('change', onChangeFormatOption.bind(this));
    }

    function hideCadDownloadAlert() {
        $('.alert-text').hide();
    }

    function showCadDownloadAlert() {
        $('.alert-text').show();
    }

    function getUrlParameter(sParam) {
        var sPageURL = window.location.search.substring(1),
            sURLVariables = sPageURL.split('&'),
            sParameterName,
            i;
        for (i = 0; i < sURLVariables.length; i++) {
            sParameterName = sURLVariables[i].substring(0,sURLVariables[i].indexOf("="));
            if (sParameterName === sParam) {
                return sURLVariables[i].replace(sParam+"=","");
            }
        }
    }

    function downloadCadFile(event) {
        $(".cad-download-error").addClass("hidden");
        if (event) event.preventDefault();
        if (this.isDownloading) return;
        var $cadDownloadBtn = $('.cad-download-btn-js', this.config.container);
        var $form = this.$form;
        var format = getFormatValue($form);
        if (!(format && format.value)) {
            showCadDownloadAlert();
            return;
        }
        var $spinner = $('.loading-container-js', this.config.container);
        _prepareLoading.call(this, $cadDownloadBtn, $spinner);
        var accesories = getUrlParameter("accesories");
        var data = {};
        data = {
            componentId: this.id,
            productId: this.config.productId,
            partNumber: this.config.partNumber,
            rodEndConf: this.config.rodEndConf.replace("%20"," ").replace("%2520"," "),
            accesories: (this.config.inConfigurationPage ? JSON.stringify(accesories) : ""),
            simpleSpecialCode: (this.config.inConfigurationPage && $("#aareo_switch_container")!=undefined && $("#aareo_switch_container").is(":visible")) ? $("#series_hto_simple_special").text() : ""

        };

        //Add form inputs
        var formParams = $form.serializeArray();
        formParams.forEach(function (param) {
            data[param.name] = param.value;
        });
        var openReference = window.open(smc.channelPrefix + '/loading-page', '_blank');
        $.getJSON(globalConfig.cadDownloadComponent.urls.downloadCadFile, data)
            .then(function (response) {
                console.log('[CadDownloadComponent]', 'downloadCadFile', response);

                if (response.url && response.url !== undefined && response.url !== null && response.url !== "") {
                    //Remove spinner & set File Ready
                    $('.loading', openReference.document).hide();
                    $('.loaded ', openReference.document).show();
                    openReference.location = response.url;
                }else {
                    console.error('[CadDownloadComponent]', 'Error downloading CAD file NO URL found',response);
                    if (!(window.isIOS || window.isIE || window.isEdge)) openReference.close();
                    smc.NotifyComponent && smc.NotifyComponent.error(globalConfig.messages.generalError);
                    $(".cad-download-error").removeClass("hidden");
                    $("#cad-download-error-message").attr("style","display:block");
                }
            })
            .catch(function (error) {
                console.error('[CadDownloadComponent]', 'Error downloading CAD file=', error);
                if (!(window.isIOS || window.isIE || window.isEdge)) openReference.close();
                smc.NotifyComponent && smc.NotifyComponent.error(globalConfig.messages.generalError);
                $(".cad-download-error").removeClass("hidden");
                $("#cad-download-error-message").attr("style","display:block");
            })
            .always(function () {
                _prepareUnloading.call(this, $cadDownloadBtn, $spinner);
                setTimeout(function () {
                    if (!(window.isIOS || window.isIE || window.isEdge)) openReference.close();
                }, 1500);
            }.bind(this));
    }

    function _prepareLoading($cadDownloadBtn, $spinner) {
        //Show Spinner
        $spinner.html(this.templates.spinnerTemplateHTML);

        this.isDownloading = true;
        $cadDownloadBtn.addClass('is-downloading');
        $('span', $cadDownloadBtn).css('display', 'none');
    }

    function _prepareUnloading($cadDownloadBtn, $spinner) {
        $spinner.html('');

        this.isDownloading = false;
        $cadDownloadBtn.removeClass('is-downloading');
        $('span', $cadDownloadBtn).css('display', 'inline');
    }

    function onChangeFormatOption(event) {
        if (event) event.preventDefault();

        var $form = this.$form;
        var format = getFormatValue($form);

        if (format && format.value) {
            if (this.config.cookieConsentComponent !== undefined && this.config.cookieConsentComponent.functionalCookiesAllowed()){
                window.localStorage.setItem('cadDownload.lastUsedFormat', format.value);
            }
            $('.cad-download-format-js', $form).text(smc.cadDownloadComponent.formats[format.value]);
            hideCadDownloadAlert();
        }
    }

    function getFormatValue($form) {
        var formParams = $form.serializeArray();
        if (!formParams.length) return null;

        var format;
        formParams.forEach(function (param) {
            if (param.name === 'format') format = param;
        });
        return format;
    }

    function _selectFormatByValue($form, lastUsedFormat) {
        var $formatInput = $('input[value="' + lastUsedFormat + '"]', $form);
        $formatInput.attr('checked', 'checked');

        //Needed to wait for screen refresh
        setTimeout(function () {
            $formatInput.trigger('change');
        }, 0);
    }


    window.smc.CadDownloadComponent = CadDownloadComponent;
})(window.smc);