(function(ko){
    ko.components.register('ik-alias-form', {
		viewModel: function(params) {
			var self = this;

			ko.di.require({REPOSITORY : "BasketProductRepository"},self);

			var reference_exist = function (part_number){
				var return_text="";
				$.ajax( {
					type : "POST",
					url : "https://www.smc.eu/portal_ssl/WebContent/basket_v2/alias/alias_functions.jsp",
					dataType : "html",
					async : false,
					data : "refs="+part_number+"&func=product_exist",
					success : function(msg) {
						return_text = msg.replace(/^\s*|\s*$/g,"");
					}
				});
				return return_text;
			}
		},
		template: { name: 'alias_form' }
	});
})(ko);