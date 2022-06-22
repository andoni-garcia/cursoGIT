(function(ko){
    ko.components.register('ik-checkbox', {
	    viewModel: function(params) {
	    	var self = this;
	    	this.context = params.viewModel;
	    	this.checked = params.checked && params.viewModel[params.checked] ? params.viewModel[params.checked] : params.viewModel.checked;
	    	if (!this.context.id && !this.context.checkboxId) this.context.checkboxId = ko.iketek.guid();
	    	else if (!this.context.checkboxId) this.context.checkboxId = (typeof this.context.id === 'function') ? this.context.id() : this.context.id;
	    	if (!this.context.labelText) this.context.labelText = "";
	    	this.cssClass = params.cssClass ? params.cssClass : "";
	    	if (params.click && params.viewModel[params.click]) this.clickFN = params.viewModel[params.click];
	    	else this.clickFN = function(){ return true; };
	    	this.isFocused = ko.observable(false);
	    	this._cssClass = ko.computed(function(){
	    		var plus = self.isFocused() ? ' focused' : '';
	    		var otherPlus = self.context.labelText == '' ? ' ikWithoutText' : '';
	    		return self.cssClass + plus + otherPlus;
	    	});
	    },
	    template: { name : 'checkbox'}
	});
})(ko);