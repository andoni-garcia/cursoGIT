var barcodeReader;
var ua = navigator.userAgent;
var is_ie = ua.indexOf("MSIE ") > -1 || ua.indexOf("Trident/") > -1;
$('#livestream_scanner').on('shown.bs.modal', function (e) {
    $('#scanner .modal-body .error').text('');
    if(!is_ie){
        barcodeReader = scan_barcode();
    }    
})

$('#livestream_scanner').on('hide.bs.modal', function (e) {
    $('#livestream_scanner .modal-body .error').remove();
    if(!is_ie){
		barcodeReader.reset();
		console.log('Reset.')
	}
})

//Add product from scan
function addToBasketScan(source, barcode) {
	let clave1 = "/J";
	let clave2 = "*";
	let clave = "no_clave"
	let index = 1;
	const numMax=999;

	if (barcode.includes(clave1)){
		clave=clave1;
		index=2;
	}
	if (barcode.includes(clave2)){
		clave=clave2;
		index=1;
	}
	let barcodeFin;
	if (clave !== "no_clave") {
	  barcode=barcode.trim();
	  number=barcode.substring(barcode.indexOf(clave)+index) ;
	  barcodeFin=barcode.substring(0,barcode.indexOf(clave));
	  if(isNaN(number) ||(number===""))  {
		 number=1;
	  }else{
		if (number>numMax)  number=numMax
	  }  
	}else{
		barcodeFin=barcode;
		number=1;
	}
    basketViewModel.addToBasket([new BasketPartnumberToAdd(barcodeFin, number)], source).done(function () {
        basketViewModel.boxInputPartnumberLayer('');
    });
}

function scan_barcode() {
    var selectedDeviceId = undefined;
	var codeReader = new ZXing.BrowserBarcodeReader();
	codeReader.getVideoInputDevices().then(function (videoInputDevices) {
		if (videoInputDevices.length > 1) {
			selectedDeviceId = videoInputDevices[1].deviceId;
		} else {
			selectedDeviceId = videoInputDevices[0].deviceId;
		}
		codeReader.decodeOnceFromVideoDevice(false, 'bsk-scan-video').then(function (result) {
			console.log(result);
			//document.getElementById('result').textContent = result.text
			addToBasketScan('BASKET LAYER', result.text);
			$('#livestream_scanner').modal('hide');
		})['catch'](function (err) {
			console.error(err);
			$('#livestream_scanner .modal-body .error').html('<div class="alert alert-danger"><strong><i class="fa fa-exclamation-triangle"></i> ' + err.name + '</strong>: ' + err.message + '</div>');
		});
		console.log('Started continous decode from camera with id', selectedDeviceId);
	})['catch'](function (err) {
		console.error(err);
	});
	return codeReader;	
}