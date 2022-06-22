function ProductRepository(){
	var self = this;

	ko.di.register(self,"ProductRepository");
	ko.di.require({jq : "jQuery"},self);
    
	self.getProductWSInfo = function(prod, callbacks, async){
		
		
		if(prod.hasSpecial_option()){
			
			let rod_end_conf_encoded = null;
			if(rod_end_conf != ""){
				
				let json = JSON.parse ( prod.configurator_document() )
				
				var rod_end_conf = json.rod_end_conf ;
				
				rod_end_conf_encoded =  encodeURIComponent(rod_end_conf) ;
			}
			
			
			
			$.ajax($.extend({
				type: "POST",
				url: "https://www.smc.eu/portal_ssl/WebContent/basket_v2/core/servlets/get_product_ws_info.jsp",
				data: {"part_number": prod.partNumber(), "sourceProgram": prod.sourceProgram(), "rod_end_conf": rod_end_conf_encoded},
	            async: (typeof async != "undefined" && async),
				dataType: "json"
			},callbacks));
		}else{
			$.ajax($.extend({
				type: "POST",
				url: "https://www.smc.eu/portal_ssl/WebContent/basket_v2/core/servlets/get_product_ws_info.jsp",
				data: {"part_number": prod.partNumber(), "sourceProgram": prod.sourceProgram()},
	            async: (typeof async != "undefined" && async),
				dataType: "json"
			},callbacks));
		}
	};
	
	self.updateWsInfo = function(prod, updatedProd){
		if(updatedProd.etechId != ''){
    		prod.etechId(updatedProd.etechId);
    		prod.pathCadenas(updatedProd.pathCadenas);
    		prod.path3DPreview(updatedProd.path3DPreview);
    		prod.serie(updatedProd.serie);
    		prod.pathCatalogue(updatedProd.pathCatalogue);
    		prod.imms_ids(updatedProd.imms_ids);
    		prod.opms_names(updatedProd.opms_names);
    		if($.trim(updatedProd.pathCatalogue) == '') prod.pathCatalogue('-');
    		if($.trim(updatedProd.imms_ids) == '' && $.trim(updatedProd.opms_names) == '') prod.imms_ids('-');
    		if(prod.sourceProgram() != 'SY') prod.details = updatedProd.details;                            			
		} else{
			if($.trim(prod.imms_ids()) == '' && $.trim(prod.opms_names()) == '') prod.imms_ids('-');
			if($.trim(prod.pathCatalogue()) == '') prod.pathCatalogue('-');
		}
		prod.wsCached(true);
	};
	self.insertLog = function (callback, action, from, part_number, serie){
		$.ajax( {
			type : "POST",
			url : "https://www.smc.eu/portal_ssl/WebContent/basket_v2/insertLog.jsp",
			dataType : "html",
			data : {
				"action=" : action,
				"&description=" : from,
				"&data1=" : part_number,
				"&data2=" : serie	
			},
			complete: function(){
				if (typeof callback === 'function')
					callback();
			}
		});	
	};
}