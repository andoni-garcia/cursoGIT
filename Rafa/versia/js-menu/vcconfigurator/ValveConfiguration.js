$(document).ready(function() {

    $.ajaxHippo({
        type : 'POST',
        url : showConfigurationSummaryURL,
            dataType : 'html',
            success : function(data) {
                console.log("//TODO get_reference_list");
        }
    });

	$("#btnA").click(function() {
		console.log("boton A");
		$.ajax({
			url : getCellConfigurationBySelectedIdCell,// se llama a doBeforeServeResource
			type : "POST",
			//data: {"product_reference":$(productReference).val(), "action":"POST"},
			data: {"visualStructureId":"1985", "action":"POST"},
			success : function(result) {//rsult devuelve JSON en formato string
				var parsedJson =JSON.parse(result);
				console.log(result.min_stations);
				console.log("botn a successssss");
				console.log( result );
			}
		});
	});

	$("#btnB").click(function() {
		console.log("boton B");
		$.ajax({
			url : resourceUrl2,// se llama a
			type : "POST",
			//data: {"product_reference":$(productReference).val(), "action":"POST"},
			data: {"visualStructureId":"2020", "action":"POST"},
			success : function(result) {//rsult devuelve JSON
				console.log("botn b success");
				console.log( result );
				$("#mensajeJSON").html(result);
			}
		});
	});

	if(!isAuthenticated){
		$("#sy-product-information").click(function() {
			window.location.replace(hippoBaseUrlTemplate + "/sso/login");
		});
	}

	$('#products_div > fieldset:nth-child(2) > h3' ).remove()




	let productIndformationInputs = document.getElementsByClassName('product-information-form');
	const updateProductInformation = function(e, type) {
		var requestData = {};

		for (var i = 0; i < productIndformationInputs.length; i++) {
			const requestKey = productIndformationInputs[i].getAttribute('data-key');
			const requestKeys = requestKey.split('.');
			const value = productIndformationInputs[i].value;

			const node = requestKeys[0];
			const child = requestKeys[1];

			if(!requestData[node]) {
				requestData[node] = {};
			}

			if(child && child.length > 0) {
				requestData[node][child] = value;
			} else {
				requestData[node] = value;
			}
		}

		return $.ajaxHippo({
			type: 'POST',
			url: updateContactsUrl,
			data: {
				node : JSON.stringify(requestData),
				saveType: type
			},
			async: true
		});
	};

	const addAliasRequest = function(alias) {
		return $.ajaxHippo({
			type: 'POST',
			url: addAliasUrl,
			dataType: 'json',
			data: {
				alias: alias
			},
			async: true
		});
	};


	for (var i = 0; i < productIndformationInputs.length; i++) {
		productIndformationInputs[i].addEventListener('blur', updateProductInformation, false)
	}

	const saveButtonFn = function(e) {

		const type = e.target.getAttribute('data-key');

		updateProductInformation(e, type)
			.then(function(res){
				smc.NotifyComponent.info(labelSavedContactSuccess);
			})
			.catch(function(err){
				console.error(err);
				smc.NotifyComponent.error(labelSavedContactError);
			})
	};

	const showModal = function(){
		$('#vcSSReference').val(valveConfigurationViewModel.simpleSpecialCode().simpleSpecialCode());
		let customerCode = valveConfigurationViewModel.customerCode() !== null ? valveConfigurationViewModel.customerCode() : aliasCustomerCode;
		let customerName = valveConfigurationViewModel.customerName() !== null ? valveConfigurationViewModel.customerName() : aliasCustomerName;
		$('#vcCustomerCodeInput').val(customerCode);
    	$('#vcCustomerNameInput').val(customerName);
		$("#modal-edit-alias").modal('show');
	}

	const closeModal = function(){
		$("#modal-edit-alias").modal('hide');
	}

	const startSpinner = function(){

	};

	const stopSpinner = function(){

	}

	const isBlankInput = function(element){
		return !element|| !element.value || element.value.length === 0;
	}

	const addAliasModalInit = function(){
		showModal();

	};

	const editAliasEvent = function() {
		const aliasField = document.getElementById('vcAliasInput');

		if(isBlankInput(aliasField)){
			return smc.NotifyComponent.error(labelAliasMandatoryField);
		}


		const nextAlias = aliasField.value;
		startSpinner();

		return addAliasRequest(nextAlias)
			.then(function(res){
				closeModal();
				stopSpinner();
				return smc.NotifyComponent.info(labelAliasSuccessMessage);
			})
			.catch(function(err){
				console.error(err);
				stopSpinner();
				return smc.NotifyComponent.error(labelAliasErrorMessage);
			});

	}

	document.getElementById('save-as-default-btn--designer').onclick = saveButtonFn;
	document.getElementById('save-as-default-btn--contact').onclick = saveButtonFn;
	document.getElementById('addAliasOption').onclick = addAliasModalInit;
	document.getElementById('aliasModalCancelBtn').onclick = closeModal;
	document.getElementById('aliasModalAcceptBtn').onclick = editAliasEvent;
});