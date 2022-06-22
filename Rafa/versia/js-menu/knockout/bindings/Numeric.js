ko.bindingHandlers.numeric = {
    init: function (element, valueAccessor, allBindingsAccessor, viewModel) {
    	
    	$(element).bind("keydown", function (event) {
    		var txt = '';
			if (window.getSelection) txt = window.getSelection();
			else if (document.getSelection) txt = document.getSelection();
			else if (document.selection) txt = document.selection.createRange().text;
            if (event.keyCode == 46 || event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 27 || event.keyCode == 13 ||
                (event.keyCode == 65 && event.ctrlKey === true) ||
                (event.keyCode == 188 || event.keyCode == 190 || event.keyCode == 110) ||
                (event.keyCode >= 35 && event.keyCode <= 39)) {
                return;
            } else {
            	var maxLength = allBindingsAccessor().maxLength ? allBindingsAccessor().maxLength : 10;
                if ((this.value.length >= maxLength && txt == '') || event.shiftKey || (event.keyCode < 48 || event.keyCode > 57) && (event.keyCode < 96 || event.keyCode > 105)) {
                    event.preventDefault();
                }
            }
        });
    }
};