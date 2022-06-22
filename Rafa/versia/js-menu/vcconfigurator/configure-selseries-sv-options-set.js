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

selSeries.addConjunto("SV","VC","EX120","1000","CJ_1028","SV_1000_EX120");

selSeries.addConjunto("SV","VC","EX250","1000","CJ_1029","SV_1000_EX250");

selSeries.addConjunto("SV","VC","EX500","1000","CJ_1030","SV_1000_EX500");

selSeries.addConjunto("SV","VC","EX600","1000","CJ_1031","SV_1000_EX600");

selSeries.addConjunto("SV","VC","DSUB","1000","CJ_1032","SV_1000_dsub_F");

selSeries.addConjunto("SV","VC","FLATRIBBON","1000","CJ_1033","SV_1000_flat_P");

selSeries.addConjunto("SV","VC","CIRCULAR","1000","CJ_1036","SV_1000_circular_C");

selSeries.addConjunto("SV","VC","EX120","2000","CJ_1037","SV_2000_EX120");

selSeries.addConjunto("SV","VC","EX250","2000","CJ_1038","SV_2000_EX250");

selSeries.addConjunto("SV","VC","EX500","2000","CJ_1039","SV_2000_EX500");

selSeries.addConjunto("SV","VC","EX600","2000","CJ_1040","SV_2000_EX600");

selSeries.addConjunto("SV","VC","DSUB","2000","CJ_1041","SV_2000_dsub_F");

selSeries.addConjunto("SV","VC","FLATRIBBON","2000","CJ_1042","SV_2000_flat_P");

selSeries.addConjunto("SV","VC","CIRCULAR","2000","CJ_1045","SV_2000_circular_C");

selSeries.addConjunto("SV","VC","EX120","3000","CJ_1046","SV_3000_EX120");

selSeries.addConjunto("SV","VC","EX250","3000","CJ_1047","SV_3000_EX250");

selSeries.addConjunto("SV","VC","EX500","3000","CJ_1048","SV_3000_EX500");

selSeries.addConjunto("SV","VC","EX600","3000","CJ_1049","SV_3000_EX600");

selSeries.addConjunto("SV","VC","DSUB","3000","CJ_1050","SV_3000_dsub_F");

selSeries.addConjunto("SV","VC","FLATRIBBON","3000","CJ_1051","SV_3000_flat_P");

selSeries.addConjunto("SV","VC","CIRCULAR","3000","CJ_1052","SV_3000_circular_C");

selSeries.addConjunto("SV","VC","EX120","4000","CJ_1053","SV_4000_EX120");

selSeries.addConjunto("SV","VC","EX500","4000","CJ_1055","SV_4000_EX500");

selSeries.addConjunto("SV","VC","DSUB","4000","CJ_1057","SV_4000_dsub_F");

selSeries.addConjunto("SV","VC","FLATRIBBON","4000","CJ_1058","SV_4000_flat_P");

selSeries.addConjunto("SV","VC","CIRCULAR","4000","CJ_1059","SV_4000_circular_C");

selSeries.addConjunto("SV","VC","EX260","1000","CJ_1060","SV_1000_EX260");

selSeries.addConjunto("SV","VC","EX260","2000","CJ_1061","SV_2000_EX260");

selSeries.addConjunto("SV","VC","EX260","3000","CJ_1062","SV_3000_EX260");

selSeries.addConjunto("SV","VC","EX126","1000","CJ_1063","SV_1000_EX126");

selSeries.addConjunto("SV","VC","EX126","2000","CJ_1064","SV_2000_EX126");

selSeries.addConjunto("SV","VC","EX126","3000","CJ_1065","SV_3000_EX126");

selSeries.addConjunto("SV","VC","PCWIRING","1000","CJ_1066","SV_1000_wiring_G");

selSeries.addConjunto("SV","VC","PCWIRING","2000","CJ_1067","SV_2000_wiring_G");

selSeries.addConjunto("SV","VC","PCWIRING","3000","CJ_1068","SV_3000_wiring_G");

selSeries.addConjunto("SV","VC","PCWIRING","4000","CJ_1069","SV_4000_wiring_G");

selSeries.addConjunto("SV","VC","WIRING","1000","CJ_1066","SV_1000_wiring_G");

selSeries.addConjunto("SV","VC","EX260","1000","CJ_1060","SV_1000_EX260");

selSeries.addConjunto("SV","VC","EX126","1000","CJ_1063","SV_1000_EX126");

selSeries.addConjunto("SV","VC","WIRING","2000","CJ_1067","SV_2000_wiring_G");

selSeries.addConjunto("SV","VC","EX260","2000","CJ_1061","SV_2000_EX260");

selSeries.addConjunto("SV","VC","EX126","2000","CJ_1064","SV_2000_EX126");

selSeries.addConjunto("SV","VC","WIRING","3000","CJ_1068","SV_3000_wiring_G");

selSeries.addConjunto("SV","VC","EX260","3000","CJ_1062","SV_3000_EX260");

selSeries.addConjunto("SV","VC","EX126","3000","CJ_1065","SV_3000_EX126");

selSeries.addConjunto("SV","VC","WIRING","4000","CJ_1069","SV_4000_wiring_G");

}

function addIncompatibilidades(){
var incompTypes = selSeries.incompatibilities.type;

selSeries.addIncompatibility(incompTypes.VALVE, "SV","  ","EX600","4000A");

selSeries.addIncompatibility(incompTypes.VALVE, "SV","  ","EX260","4000B");

selSeries.addIncompatibility(incompTypes.VALVE, "SV","  ","EX126","4000C");

selSeries.addIncompatibility(incompTypes.VALVE, "SV","  ","EX250","4000");

}