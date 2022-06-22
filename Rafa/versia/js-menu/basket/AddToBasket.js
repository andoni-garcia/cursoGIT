function AddToBasket(smc){
	var self = this;
	
	ko.di.register(self,"AddToBasket");
	ko.di.require(["BasketViewModel","BasketProductRepository","BasketMessages"],self);
	
	self.addToBasketMessage = ko.observable(null);
	self.valueUpdate = "afterkeydown";
	self.type = ko.observable(smc != '' ? smc : 'smc');
	self.boxInputPartnumber = ko.observable("");//.extend({"toUpperCase" : true});
	self.boxInputQuantity = ko.observable("1").extend({"regexp" : "^[0-9]*$"});
	self.suggestionsEnabled = ko.computed(function(){
		return self.BasketViewModel.erp == 'mvx' && self.type() == 'smc';
	});
	
	self.BasketViewModel.opened.subscribe(function(newValue){
		if (self.addToBasketMessage() != null) self.addToBasketMessage().destroy();
		self.addToBasketMessage(null);
		self.boxInputPartnumber("");
		self.boxInputQuantity("1");
		if (self.boxAutocompleteClose) self.boxAutocompleteClose();
	});
	
	self.type.subscribe(function(newValue) {
		self.BasketProductRepository.changeOption(newValue);
		$("#activeBtn").val(newValue);
	});
	var lastms = 0;
	var threshold = 500;
	self.doAddToBasket = function(vm,e){
		//self.boxAutocompleteClose();
		var now = new Date().getTime();
		if (Math.abs(now - lastms) < threshold){
			return;
		}
		lastms = now;
		if (self.addToBasketMessage() != null) self.addToBasketMessage().destroy();
		self.addToBasketMessage(null);
		var pn, qty = "1";
		var pn = self.boxInputPartnumber().toUpperCase();
		var qty = self.boxInputQuantity();
		if (!/^[1-9][0-9]*$/g.test(qty.trim())){
			self.addToBasketMessage(new IK_Message(self.BasketMessages["enterValidQuantity"],IK_Message.ERROR));
			//$('.inputContainer input')[1].focus();
		} else if (pn.trim() != '') {
			self._addToBasket(pn,qty,vm);
			//$('.inputContainer input')[0].focus();
		}
		if (self.boxAutocompleteClose) self.boxAutocompleteClose();
	};
	
	self._addToBasket = function(pn,qty, from){
		var add = function(pn,alias,plId,noCompMode){
			if (typeof noCompMode === 'undefined') noCompMode = false;
			self.BasketProductRepository.addToBasket(pn,alias,qty,"0",{
				success: function(resp){
					/*if (resp.success === 'true'){
						self.BasketViewModel.updateId(resp,plId);
						self.boxInputPartnumber("");
						self.boxInputQuantity("1");
						if (noCompMode){
							self.BasketProductRepository.getErpInfo(resp.prodId);
							self.BasketProductRepository.getWSInfo(resp.prodId);
						}
					}
					if (self.boxAutocompleteClose) self.boxAutocompleteClose();
					//COMPATIBILITY_FUNCTIONS.PART_NUMBER_ADDED(pn,"",plId,resp);
					if (resp.success === 'false'){
						self.BasketViewModel.deleteProduct(plId);
						self.addToBasketMessage(new IK_Message(self.BasketMessages["productAlreadyInBasket"],IK_Message.ERROR));
					}*/
					setTimeout(function(){location.reload();},1000);
					
				}
				//error: COMPATIBILITY_FUNCTIONS.PART_NUMBER_ADD_ERROR.bind(window,pn,"",plId),
		    	//complete: COMPATIBILITY_FUNCTIONS.PART_NUMBER_ADD_COMPLETED.bind(window,pn,"",plId)
			});
		};
		var sanitizeInput = function(text){
			return text.replace(/'/g,"&#39;");
		};
		var sanitizeSelector = function(text){
			return text.replace(/[!"#$%&'()*+,.\/:;<=>?@[\\\]^`{|}~]/g, "\\$&");
		};
		var plId = ko.iketek.guid();
		add(pn,"",plId);
		/*if (self.type() == 'customer'){
			var prod = self.BasketViewModel.getProductByCustomPartNumber(pn);
			if (self.boxAutocompleteClose) self.boxAutocompleteClose();
			if (prod){
				self.addToBasketMessage(new IK_Message(self.BasketMessages["productAlreadyInBasket"],IK_Message.ERROR));
			} else {
				if (from == 'basketProcess'){
					var plId = ko.iketek.guid();
					self.BasketProductRepository.getPartNumberForAlias(pn,{
						success: function(ref){
							ref = ref.replace(/^\s*|\s*$/g,"");			
							if (ref == ""){
								if (confirm(self.BasketMessages["createNewCustomerPartNumber"])){ // DONE:0 Are you sure you want to associate an alias
									AliasObject.openOverlay(pn,function(ref,alias){
										 self.BasketViewModel.addPlaceholder(ref,pn,plId);
										 add(ref,pn,plId,true);
									},function(){ 
										self.BasketViewModel.deleteProduct(plId); 
									});
								} else {
									self.BasketViewModel.deleteProduct(plId); 
								}
							} else {		
								self.BasketViewModel.addPlaceholder("",pn,plId);
								add(ref,pn,plId,true);
							}						
						}
					});			
				} else {
					self.BasketProductRepository.getPartNumberForAlias(pn,{
						success: function(ref){
							ref = ref.replace(/^\s*|\s*$/g,"");			
							if (ref == ""){
								self.addToBasketMessage(new IK_Message(self.BasketMessages["customerPartNumberNotExists"],IK_Message.ERROR));
								self.BasketViewModel.deleteProduct(plId);
								COMPATIBILITY_FUNCTIONS.CPN_INSERTION_FAILED(plId);	
							} else {		
								var plId = COMPATIBILITY_FUNCTIONS.MANUAL_PRODUCT_INSERTION_START("",sanitizeInput(pn));
								self.BasketViewModel.addPlaceholder("",pn,plId);
								COMPATIBILITY_FUNCTIONS.PART_NUMBER_GOT(ref,pn,plId);
								add(ref,pn,plId);
							}						
						}
					});
				}
			}
		} else {
			var p1 = self.BasketViewModel.getProductByPartNumber(pn), p2 = self.BasketViewModel.getProductByReplaced(pn);
			if (p1){
				self.boxInputPartnumber("");
				if (self.boxAutocompleteClose) self.boxAutocompleteClose();
				self.addToBasketMessage(new IK_Message(self.BasketMessages["productAlreadyInBasket"],IK_Message.ERROR));
			} else if (p2){
				self.boxInputPartnumber("");
				if (self.boxAutocompleteClose) self.boxAutocompleteClose();
				self.addToBasketMessage(new IK_Message(self.BasketMessages["productReplacedAlreadyInBasket"].replace("{0}",p2.oldPartNumber()).replace("{1}",p2.partNumber()),IK_Message.ERROR));
			} else {
				var plId = COMPATIBILITY_FUNCTIONS.MANUAL_PRODUCT_INSERTION_START(sanitizeInput(pn),"");
				self.BasketViewModel.addPlaceholder(pn,"",plId);
				add(pn,"",plId);
			}
		}*/
	};
	
/*	self.autcompSource = "https://www.smc.eu/portal_ssl/WebContent/basket_v2/basket_process/includes/get_matches.jsp";
	self.autcompOpen = function( event, ui ) {
		if (self.suggestionsEnabled()){
			var list = $(this).data("ikAutocomplete").menu.element;
			if (list.length > 0){
				var o = list.offset();
				o.left = o.left - 3;
				list.offset(o);
				list.append('<li style="line-height: normal; background-color: #F3F3F3; clear: left; float: left; margin: 2px 0 0 0; padding: 0; width: 100%;">' + 
							'<a style="font-size: 9px;" class="ui-corner-all" tabindex="-1" class="suggestion-text"><b style="font-size:10px">'
							+ self.BasketMessages["suggestionsText1"] + '</b> ' + self.BasketMessages["suggestionsText2"] + '</a></li>');
			}
		}
	};
	self.autcompSelect = function(event, ui){
		self.boxInputPartnumber(ui.item.value);
		if (event.which != 9)
			self.doAddToBasket();
		return false;
	};*/
}