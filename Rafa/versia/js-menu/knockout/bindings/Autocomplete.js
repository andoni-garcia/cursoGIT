ko.bindingHandlers.autocomplete = {
    init: function (element, valueAccessor, allBindingsAccessor, viewModel) {
	    var disable = function(element){
	    	$(element).ikAutocomplete("destroy");
	    };
    	var enable = function(element,opts){
    	    disable(element);
	    	$(element).ikAutocomplete(opts);
	    };
	    //disable(element);
    	var opts = ko.utils.unwrapObservable(valueAccessor()); 
        if (typeof opts["source"] === 'string'){
            var url = opts["source"];
			opts["source"] = function( request, response ) {
                var $this = $(this);
                var $element = $(this.element);
                $.ajaxHippo({
                    type: "POST",
                    url: url,
                    dataType: "json",
                    data: request,
                    success: function( data ){
                        if ($element.val() == request.term) 
                            response( data );
                        else {
                            $element.removeClass( "ui-autocomplete-loading" );
                        }
                    }
                });
			};
        }
    	if (opts["enable"]){
    		opts["enable"].subscribe(function(newValue) { newValue ? enable(element,opts) : disable(element); });
    		if (opts["enable"]()) enable(element,opts);
    	} else {
    		enable(element,opts);
    	}
    	if (opts["name"]){
            if (typeof viewModel[opts["name"] + "AutocompleteClose"] === 'undefined'){
                viewModel[opts["name"] + "AutocompleteClose"] = function(){
                    var elems = viewModel[opts["name"] + "AutocompleteClose"]["elems"];
                    for (var i = 0; i < elems.length; i++)
                        elems[i].ikAutocomplete("close");
                };
                viewModel[opts["name"] + "AutocompleteClose"]["elems"] = [];
            }
            viewModel[opts["name"] + "AutocompleteClose"]["elems"].push($(element));
        }    		
    }
};