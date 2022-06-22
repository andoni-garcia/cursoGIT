ko.bindingHandlers.datepicker = {
    init: function(element, valueAccessor, allBindings, viewModel, bindingContext) {
        var $element = $(element);
        var opts = $.extend({ dateFormat: "dd/mm/yy"}, allBindings().datepickerOptions, valueAccessor());
        $element.datepicker(opts);
        $.datepicker.regional[ basket_lang ] = $.extend($.datepicker.regional[ basket_lang ], valueAccessor());
        $element.datepicker( "option" , $.datepicker.regional[ basket_lang ] );
    }
};
