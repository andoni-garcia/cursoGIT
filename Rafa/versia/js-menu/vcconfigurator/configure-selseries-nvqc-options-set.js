var idGroup = "", selSeries;

function path() {
	var filepath = $(".file").val();
	$(".fake_file input:eq(1)").val(filepath);
	$("#ik_sy_open_form").submit();
}

$(document).ready(function(){
	open_information();
	$(".file").change(path);

	$("#ik_sy_open_form").submit(function(e){
	if ($(".fake_file input:eq(1)").val() == '') return false;
	});

	$("#browse_button, #sy_submit_file_newx").click(function(e){
		$("#file_input").click();
		e.preventDefault();
	});

	selSeries = selSeries || new SelSeries($).addConfigurationDoneHandler(configurationFinished);
	addConjuntos();
	addIncompatibilidades();

	checkIE();
});

function configurationFinished(){
	$("#sy_layout").show();
	var conjunto = selSeries.getConjunto();
	var serie = conjunto['serie'];
	var showMeassures = true;
	idGroup = conjunto['id'];
	refresh_serie_and_redirect(serie, showMeassures, idGroup);
}

function addConjuntos(){

selSeries.addConjunto("NewVQC","VC","EX126","1000","CJ_1001","NewVQC_1000_EX126");

selSeries.addConjunto("NewVQC","VC","EX250","1000","CJ_1002","NewVQC_1000_EX250");

selSeries.addConjunto("NewVQC","VC","EX500","1000","CJ_1003","NewVQC_1000_EX500");

selSeries.addConjunto("NewVQC","VC","EX600","1000","CJ_1004","NewVQC_1000_EX600");

selSeries.addConjunto("NewVQC","VC","DSUB","1000","CJ_1005","NewVQC_1000_dsub_F");

selSeries.addConjunto("NewVQC","VC","FLATRIBBON","1000","CJ_1006","NewVQC_1000_flat_P");

selSeries.addConjunto("NewVQC","VC","TERMINALBLOCK","1000","CJ_1007","NewVQC_1000_terminal_T");

selSeries.addConjunto("NewVQC","VC","LEADWIRE","1000","CJ_1008","NewVQC_1000_lead_L");

selSeries.addConjunto("NewVQC","VC","CIRCULAR","1000","CJ_1009","NewVQC_1000_circular_M");

selSeries.addConjunto("NewVQC","VC","EX126","2000","CJ_1010","NewVQC_2000_EX126");

selSeries.addConjunto("NewVQC","VC","EX250","2000","CJ_1011","NewVQC_2000_EX250");

selSeries.addConjunto("NewVQC","VC","EX500","2000","CJ_1012","NewVQC_2000_EX500");

selSeries.addConjunto("NewVQC","VC","EX600","2000","CJ_1013","NewVQC_2000_EX600");

selSeries.addConjunto("NewVQC","VC","DSUB","2000","CJ_1014","NewVQC_2000_dsub_F");

selSeries.addConjunto("NewVQC","VC","FLATRIBBON","2000","CJ_1015","NewVQC_2000_flat_P");

selSeries.addConjunto("NewVQC","VC","TERMINALBLOCK","2000","CJ_1016","NewVQC_2000_terminal_T");

selSeries.addConjunto("NewVQC","VC","LEADWIRE","2000","CJ_1017","NewVQC_2000_lead_L");

selSeries.addConjunto("NewVQC","VC","CIRCULAR","2000","CJ_1018","NewVQC_2000_circular_M");

selSeries.addConjunto("NewVQC","VC","EX260","1000","CJ_1070","NewVQC_1000_EX260");

selSeries.addConjunto("NewVQC","VC","EX260","2000","CJ_1071","NewVQC_2000_EX260");

selSeries.addConjunto("NewVQC","VC","EX126","4000","CJ_1072","NewVQC_4000_EX126");

selSeries.addConjunto("NewVQC","VC","EX250","4000","CJ_1073","NewVQC_4000_EX250");

selSeries.addConjunto("NewVQC","VC","EX500","4000","CJ_1074","NewVQC_4000_EX500");

selSeries.addConjunto("NewVQC","VC","EX600","4000","CJ_1075","NewVQC_4000_EX600");

selSeries.addConjunto("NewVQC","VC","DSUB","4000","CJ_1076","NewVQC_4000_dsub_F");

selSeries.addConjunto("NewVQC","VC","FLATRIBBON","4000","CJ_1077","NewVQC_4000_flat_P");

selSeries.addConjunto("NewVQC","VC","TERMINALBLOCK","4000","CJ_1078","NewVQC_4000_terminal_T");

selSeries.addConjunto("NewVQC","VC","LEADWIRE","4000","CJ_1079","NewVQC_4000_lead_L");

selSeries.addConjunto("NewVQC","VC","CIRCULAR","4000","CJ_1080","NewVQC_4000_circular_M");

selSeries.addConjunto("NewVQC","VC","EX260","4000","CJ_1081","NewVQC_4000_EX260");

selSeries.addConjunto("NewVQC","VC","EX250","5000","CJ_1083","NewVQC_5000_EX250");

selSeries.addConjunto("NewVQC","VC","EX600","5000","CJ_1085","NewVQC_5000_EX600");

selSeries.addConjunto("NewVQC","VC","DSUB","5000","CJ_1086","NewVQC_5000_dsub_F");

selSeries.addConjunto("NewVQC","VC","FLATRIBBON","5000","CJ_1087","NewVQC_5000_flat_P");

selSeries.addConjunto("NewVQC","VC","TERMINALBLOCK","5000","CJ_1088","NewVQC_5000_terminal_T");

selSeries.addConjunto("NewVQC","VC","LEADWIRE","5000","CJ_1089","NewVQC_5000_lead_L");

selSeries.addConjunto("NewVQC","VC","CIRCULAR","5000","CJ_1090","NewVQC_5000_circular_M");

selSeries.addConjunto("NewVQC","VC","EX260","5000","CJ_1091","NewVQC_5000_EX260");

selSeries.addConjunto("NewVQC","VC","EX126","5000","CJ_1092","NewVQC_5000_EX126");

selSeries.addConjunto("NewVQC","VC","EX500","5000","CJ_1093","NewVQC_5000_EX500");

}

function addIncompatibilidades(){
var incompTypes = selSeries.incompatibilities.type;

}