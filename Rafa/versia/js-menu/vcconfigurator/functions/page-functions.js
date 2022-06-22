                                                                                                                                                                                                                                                               
/**
 * Redirecciona la pagina
 * 
 * @param url a la que redireccionar
 */
function redir(url) {
	window.location.href = url;
}

/**
 * funciones empleadas en el nuevo desarrollo de smc
 */

/**
 * Refresca el tipo de serie
 * @serie  
 * @showMeassures
 * @idGroup id del conjunto
 */
function refresh_serie_and_redirect(serie, showMeassures, idGroup) {
	console.log( "function refresh_serie_and_redirect" );	
	
	$('#form-selseries input#idGroup').val(idGroup);
	$('#form-selseries input#showMeassures').val(showMeassures);
	$('#form-selseries input#showNotices').val(true);
	$('#form-selseries input#serie').val(serie);
	$('#form-selseries').submit();
	
//	$.ajax({
//		url : actionUrl, // se llama a doAction		
//		data : {			
//			"idGroup" : idGroup,
//			"showMeassures" : showMeassures,
//			"showNotices" : true,
//			"serie" : serie			
//			},
//		success : function(data) {
//			console.log("SUCCESSSSSS");
//			//initial_load(showMeassures, idGroup);
//		}
//	});
}


/**
 * funciones NO empleadas de momento en el nuevo desarrollo de smc
 */

function initial_load(showMeassures, idGroup) {
	var randomnumber = Math.floor(Math.random() * 10000);
	$
			.ajax({
				url : "init/initial_load.jsp?idGroup=" + idGroup
						+ "&showMeassures=" + showMeassures
						+ "&showNotices=true" + "&rn=" + randomnumber,
				success : function(data) {
					var randomnumber = Math.floor(Math.random() * 10000);
					redir("configurator.jsp?showMeassures=" + showMeassures + "&showNotices=true&rn="
							+ randomnumber);
					// load_configurator(showMeassures);
				}
			});
}

function load_configurator(showMeassures) {
	var randomnumber = Math.floor(Math.random() * 10000);
	$.ajax({
		url : "configurator.jsp?showMeassures=" + showMeassures
				+ "&showNotices=true" + "&rn=" + randomnumber,
		success : function(data) {
			document.body.innerHTML = data;
		}
	});
}

function open_information() {
	$('.sel_series_information').click(function() {
		// Obtener info_source
		var info_source = $j(this).attr("info_source");
		open_pdf(info_source, "");
	});
}

function product_information() {
	$('.product_information').click(function() {
		// Obtener info_source
		var info_source = $j(this).attr("info_source").replace(/\s/g, "_");
		var folder = $j(this).attr("folder");
		open_pdf(info_source, folder);
	});
}

function open_pdf(info_source, folder) {
	var randomnumber = Math.floor(Math.random() * 10000);
	$.ajax({
		url : "open_information.jsp",
		data : "infoSource=" + info_source + "&folder=" + folder + "&number="
				+ randomnumber,
		success : function(url) {
			window.open(url, '_blank');
		}
	});
}

function checkIE() {
	try {
		var isIe8 = new RegExp("MSIE ([0-8])");
		if (navigator && navigator.userAgent
				&& isIe8.exec(navigator.userAgent) != null) {
			document.body.className += " ie";
		} else {
			document.body.className += " not_ie";
		}
	} catch (Except) {
	}
}

checkIE();