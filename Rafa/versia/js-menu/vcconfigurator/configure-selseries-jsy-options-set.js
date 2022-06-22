var idGroup = "",
	selSeries;

function path() {
	var filepath = $(".file").val();
	$(".fake_file input:eq(1)").val(filepath);
	$("#ik_sy_open_form").submit();
}

$(document).ready(function () {
	open_information();
	$(".file").change(path);

	$("#ik_sy_open_form").submit(function (e) {
		if ($(".fake_file input:eq(1)").val() == '') return false;
	});

	$("#browse_button, #sy_submit_file_newx").click(function (e) {
		$("#file_input").click();
		e.preventDefault();
	});

	selSeries = selSeries || new SelSeries($).addConfigurationDoneHandler(configurationFinished);
	addConjuntos();
	addIncompatibilidades();

	checkIE();
});

function configurationFinished() {
	$("#sy_layout").show();
	var conjunto = selSeries.getConjunto();
	var serie = conjunto['serie'];
	var showMeassures = true;
	idGroup = conjunto['id'];
	refresh_serie_and_redirect(serie, showMeassures, idGroup);
}

function addConjuntos() {

	selSeries.addConjunto("IP40", "SIDE", "EX600", "SY3000", "CJ_2005", "EX600_JSY3");

	selSeries.addConjunto("IP40", "SIDE", "EX260", "SY3000", "CJ_2008", "EX260_JSY3");

	selSeries.addConjunto("IP40", "SIDE", "EX250", "SY3000", "CJ_2009", "EX250_JSY3");

	selSeries.addConjunto("IP40", "SIDE", "DSUB", "SY3000", "CJ_2010", "DSub_JSY3");

	selSeries.addConjunto("IP40", "SIDE", "EX600", "SY5000", "CJ_2012", "EX600_JSY5");

	selSeries.addConjunto("IP40", "SIDE", "EX260", "SY5000", "CJ_2013", "EX260_JSY5");

	selSeries.addConjunto("IP40", "SIDE", "EX250", "SY5000", "CJ_2014", "EX250_JSY5");

	selSeries.addConjunto("IP40", "SIDE", "DSUB", "SY5000", "CJ_2015", "DSub_JSY5");

	selSeries.addConjunto("IP40", "SIDE", "EX120", "SY5000", "CJ_2038", "EX120_JSY5");

	selSeries.addConjunto("IP40", "SIDE", "EX120", "SY3000", "CJ_2042", "EX120_JSY3");

	selSeries.addConjunto("IP40", "SIDE", "FLATRIBBON", "SY3000", "CJ_2053", "FlatRibbon_JSY3");

	selSeries.addConjunto("IP40", "SIDE", "FLATRIBBON", "SY5000", "CJ_2054", "FlatRibbon_JSY5");

	selSeries.addConjunto("IP40", "SIDE", "LEADWIRE", "SY3000", "CJ_2058", "LeadWire_JSY3");

	selSeries.addConjunto("IP40", "SIDE", "LEADWIRE", "SY5000", "CJ_2059", "LeadWire_JSY5");

	selSeries.addConjunto("IP40", "SIDE", "TERMINALBLOCK", "SY3000", "CJ_2068", "Terminal_JSY3");

	selSeries.addConjunto("IP40", "SIDE", "TERMINALBLOCK", "SY5000", "CJ_2069", "Terminal_JSY5");

	selSeries.addConjunto("IP40", "SIDE", "FLATRIBBON", "SY1000", "CJ_2139", "FlatRibbon_JSY1");

	selSeries.addConjunto("IP40", "SIDE", "LEADWIRE", "SY1000", "CJ_2140", "LeadWire_JSY1");

	selSeries.addConjunto("IP40", "SIDE", "TERMINALBLOCK", "SY1000", "CJ_2142", "Terminal_JSY1");

	selSeries.addConjunto("IP40", "SIDE", "DSUB", "SY1000", "CJ_2143", "DSub_JSY1");

	selSeries.addConjunto("IP40", "SIDE", "EX120", "SY1000", "CJ_2144", "EX120_JSY1");

	selSeries.addConjunto("IP40", "SIDE", "EX250", "SY1000", "CJ_2146", "EX250_JSY1");

	selSeries.addConjunto("IP40", "SIDE", "EX260", "SY1000", "CJ_2147", "EX260_JSY1");

	selSeries.addConjunto("IP40", "SIDE", "EX600", "SY1000", "CJ_2149", "EX600_JSY1");


	selSeries.addConjunto("IP67", "SIDE", "BLANK", "SY3000", "CJ_2034", "Dsub_SY3_Type50");
	selSeries.addConjunto("IP67", "BOTTOM", "BLANK", "SY3000", "CJ_2035", "Dsub_SY3_Type51");
	selSeries.addConjunto("IP67", "SIDE", "BLANK", "SY5000", "CJ_2032", "Dsub_SY5_Type50");
	selSeries.addConjunto("IP67", "BOTTOM", "BLANK", "SY5000", "CJ_2033", "Dsub_SY5_Type51");
	selSeries.addConjunto("IP67", "SIDE", "BLANK", "SY1000", "CJ_2209", "Dsub_SY7_Type50");
	selSeries.addConjunto("IP67", "BOTTOM", "BLANK", "SY1000", "CJ_2213", "Dsub_SY7_Type51");

}

function addIncompatibilidades() {
	var incompTypes = selSeries.incompatibilities.type;

	selSeries.addIncompatibility(incompTypes.PIPING, "IP40","BOTTOM"," "," ");

	selSeries.addIncompatibility(incompTypes.CONNECTOR, "IP67"," ","DSUB"," ");
	selSeries.addIncompatibility(incompTypes.CONNECTOR, "IP67"," ","LEADWIRE"," ");
	selSeries.addIncompatibility(incompTypes.CONNECTOR, "IP67"," ","FLATRIBBON"," ");
	selSeries.addIncompatibility(incompTypes.CONNECTOR, "IP67"," ","TERMINALBLOCK"," ");
	selSeries.addIncompatibility(incompTypes.CONNECTOR, "IP67"," ","EX120"," ");
	selSeries.addIncompatibility(incompTypes.CONNECTOR, "IP67"," ","EX250"," ");
	selSeries.addIncompatibility(incompTypes.CONNECTOR, "IP67"," ","EX260"," ");
	selSeries.addIncompatibility(incompTypes.CONNECTOR, "IP67"," ","EX600"," ");
	selSeries.addIncompatibility(incompTypes.CONNECTOR, "IP40"," ","BLANK"," ");
}