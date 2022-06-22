ko.bindingHandlers.submit = {
    init: function (element, valueAccessor, allBindingsAccessor, viewModel) {
    	var func = ko.utils.unwrapObservable(valueAccessor());    	
    	$(element).keyup(function (e) {
			 if (!e) e = window.event;		 
			 if (e.keyCode == 13) {
				func.call(viewModel);
				return false;
			}
		});
    }
};