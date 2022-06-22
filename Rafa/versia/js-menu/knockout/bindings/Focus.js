ko.bindingHandlers.focus = {
    init: function (element, valueAccessor, allBindingsAccessor, viewModel) {
    	var funcs = ko.utils.unwrapObservable(valueAccessor());    	
    	$(element).focus(funcs["on"]).blur(funcs["off"]);
    }
};