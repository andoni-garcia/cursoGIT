ko.bindingHandlers.stopBindings = {
    init: function(element, valueAccessor, allBindingsAccessor, viewModel, bindingContent) {
        var value = valueAccessor();
        var valueUnwrapped = ko.unwrap(value);
        return { controlsDescendantBindings: valueUnwrapped };
    }  
};