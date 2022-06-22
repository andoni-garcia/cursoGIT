(function(globalConfig) {
    function AskSmc(config) {
        this.id = config.id;
        this.config = config;
    }

    AskSmc.prototype.init = init;

    function init() {
        console.debug('[AskSmc]', 'init id=', this.id);
        if (!this.config.container) {
            throw new Error('"Container" is required');
        }

        _initialWorkflow.call(this);
        $(document).trigger('smc.registercomponent', [this.id, this]);
    }

    function _initialWorkflow() {
        if (window.parent) {
            //Emit event when the page is ready.
            window.parent.postMessage('page-loaded', '*');
        }

        _applyCountrySelectorFixes.call(this);
        _fillData.call(this);
        _enableAddCopyButton.call(this);
        _enableRemoveCopyButton.call(this);
    }

    function _fillData() {
        var userCountry = this.config.userCountry;
        var countryFragment = document.createDocumentFragment();
        this.config.countryList && this.config.countryList.forEach(function (countryData) {
            countryFragment.appendChild($('<option>', {
                value: countryData.value,
                text: countryData.text,
                selected: countryData.value === userCountry
            })[0]);
        });
        //Other country
        countryFragment.appendChild($('<option>', {
            value: this.config.messages['other_country_key'],
            text: this.config.messages['other_country_text']
        })[0]);

        var $askSmcCountryDropdown = $('.ask-smc-country-dropdown-js', this.config.container);
        //Remove the first empty <option>
        var emptyOptions = $('option[value=""]', $askSmcCountryDropdown);
        if (emptyOptions && emptyOptions[1]) {
            $(emptyOptions[1]).remove();
        }

        //[SMCD-492]
        $askSmcCountryDropdown.append(countryFragment.childNodes);
    }

    function _enableAddCopyButton() {
        var $sendCopyButton = $('<a>', {
            html: '<i class="fas fa-plus-circle fa-3x blue"></i>',
            class: 'icon-button'
        });

        var $sendCopyBtnContainer = $('.send-copy-add-btn-js', this.config.container);
        $sendCopyBtnContainer.parent().addClass('form-group').empty().append($sendCopyButton);

        $sendCopyButton.click(_onAddSendCopyButtonClick.bind(this));
    }

    function _enableRemoveCopyButton() {
        $('.send-copy-remove-btn-js', this.config.container).each(function (i, removeButtonElement) {
            var $removeCopyButton = $('<a>', {
                html: '<i class="fas fa-minus-circle fa-3x blue"></i>',
                class: 'icon-button'
            });

            var $removeButton = $(removeButtonElement);
            $removeButton.parent().addClass('form-group').empty().append($removeCopyButton);
            $removeCopyButton.click(_onRemoveSendCopyButtonClick.bind(this));
        });
    }

    function _applyCountrySelectorFixes() {
        var $countrySelector = $('.smc-select', this.config.container);
        $countrySelector.removeClass('col-md-7').removeClass('form-group');

        //Replace the paragraph into a simple div
        var $paragraphElement = $('p', $countrySelector);
        $paragraphElement.replaceWith($('<div>').html($paragraphElement.html()));
    }

    function _onAddSendCopyButtonClick(event) {
        if (event) event.preventDefault();

        var numberOfSendCopyInputs = 20;
        var alreadyShowedAnInput = false;
        for (var i = 2; i < numberOfSendCopyInputs; i++) {
            if (alreadyShowedAnInput) continue;
            var $sendCopyContainer = $('div[name="group_send_copy_to_' + i + '"]', this.config.container);
            if ($sendCopyContainer && !$sendCopyContainer.is(':visible')) {
                $sendCopyContainer.css('display', 'flex');//SHOW
                alreadyShowedAnInput = true;
            }
        }
    }

    function _onRemoveSendCopyButtonClick(event) {
        if (event) event.preventDefault();

        $(event.currentTarget).parents('.eforms-fieldgroup').hide();
    }

    window.smc.AskSmc = AskSmc;
})(window.smc);