var FormValidator = (function () {

    var _conf = {
        formRow: '.form-group__inputWrapper',
        validClass: 'is-valid',
        invalidClass: 'is-invalid',
        requiredFields: ':required',
        datepickerField: 'input[name="date"]',
        requiredRadios: '.smc-radio input:required',
        requiredChecks: '.smc-checkboxes-required',
        radio: '.smc-radio',
        checkbox: '.smc-checkbox',
        checkValidation: '.check-validation'
    }

    var setUnsetValidationClass = function(el, cssClass, set) {
        if( set === true) {
            $(el).parent().addClass(cssClass);
            $(el).addClass(cssClass);
        } else {
            $(el).parent().removeClass(cssClass);
            $(el).removeClass(cssClass);
        }
    };

    var clearRadiosAndCheckboxes = function() {
        setUnsetValidationClass($('.smc-radio'), _conf.invalidClass, false);
        setUnsetValidationClass($('.smc-checkbox'), _conf.invalidClass, false);
    };

    function onFieldExit(e) {
        if(this.checkValidity() === true) {
            setUnsetValidationClass(this, _conf.validClass, true);
            setUnsetValidationClass(this, _conf.invalidClass, false);
        }
    }

    function onFieldInvalid(e) {
        setUnsetValidationClass(this, _conf.invalidClass, true);
        setUnsetValidationClass(this, _conf.validClass, false);
    }

    return {

        init: function() {

            $(_conf.requiredFields).on('invalid', onFieldInvalid);
            $(_conf.checkValidation).on('invalid', onFieldInvalid);

            $('body').on('click focus',  '.'+_conf.invalidClass, function(e) {
                setUnsetValidationClass(this, _conf.invalidClass, !!this.value);
                setUnsetValidationClass(this, _conf.validClass, !!this.value);
            });

            $(_conf.requiredFields).on('blur', onFieldExit);
            $(_conf.checkValidation).on('blur', onFieldExit);

            if($(_conf.datepickerField)){
                $(_conf.datepickerField).on('change', onFieldExit);
            }


            $(_conf.requiredRadios).on('change', function(e) {
                var s = $('input[name=' + $(this).attr('name') + ']').closest(_conf.radio);
                for(var i=0; i<s.length; i++) {
                    setUnsetValidationClass(s[i], _conf.invalidClass, false);
                }
            });

            $(_conf.requiredChecks).on('change', 'input[type=checkbox]', function(e) {
                var requiredOk = ($(this).closest(_conf.requiredChecks).find("input[type=checkbox]:checked").length > 0);
                var $items = $('input[type=checkbox][name=' + $(this).attr('name') + ']');
                $items.each(function( index ) {
                    var $chk = $(this);
                    setUnsetValidationClass($chk, _conf.invalidClass, false);
                    if (requiredOk === true) {
                        $chk.removeAttr("required");
                    } else {
                        $chk.attr("required", "required");
                    }
                });
            });

            $('button[type="submit"]').on('click', function() {
                clearRadiosAndCheckboxes();
            });
        },

        refresh: function () {
            $(_conf.requiredFields).each(onFieldExit);
            $(_conf.checkValidation).each(onFieldExit);
        }

    };

}());