
var idGroup = "", selSeries;

function path() {
var filepath = $(".file").val();
$(".fake_file input:eq(1)").val(filepath);
$("#ik_sy_open_form").submit();
}

$(document ).ready(function() {
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

selSeries.addConjunto("IP67","SIDE","EX600","SY3000","CJ_005","EX600_SY3_Type10");

selSeries.addConjunto("IP67","SIDE","EX260","SY3000","CJ_008","EX260_SY3_Type10");

selSeries.addConjunto("IP67","SIDE","EX250","SY3000","CJ_009","EX250_SY3_Type10");

selSeries.addConjunto("IP67","SIDE","DSUB","SY3000","CJ_010","DSub_SY3_Type10");

selSeries.addConjunto("IP67","SIDE","CIRCULAR","SY3000","CJ_011","CircularConnector_SY3_Type10");

selSeries.addConjunto("IP67","SIDE","EX600","SY5000","CJ_012","EX600_SY5_Type10");

selSeries.addConjunto("IP67","SIDE","EX260","SY5000","CJ_013","EX260_SY5_Type10");

selSeries.addConjunto("IP67","SIDE","EX250","SY5000","CJ_014","EX250_SY5_Type10");

selSeries.addConjunto("IP67","SIDE","DSUB","SY5000","CJ_015","DSub_SY5_Type10");

selSeries.addConjunto("IP67","SIDE","CIRCULAR","SY5000","CJ_016","CircularConnector_SY5_Type10");

selSeries.addConjunto("IP67","BOTTOM","EX600","SY5000","CJ_017","EX600_SY5_Type11");

selSeries.addConjunto("IP67","BOTTOM","EX260","SY5000","CJ_018","EX260_SY5_Type11");

selSeries.addConjunto("IP67","BOTTOM","EX250","SY5000","CJ_019","EX250_SY5_Type11");

selSeries.addConjunto("IP67","BOTTOM","DSUB","SY5000","CJ_020","DSub_SY5_Type11");

selSeries.addConjunto("IP67","BOTTOM","CIRCULAR","SY5000","CJ_021","CircularConnector_SY5_Type11");

selSeries.addConjunto("IP67","SIDE","EX600","MIXED","CJ_022","EX600_Mixed_Type10");

selSeries.addConjunto("IP67","SIDE","EX260","MIXED","CJ_023","EX260_Mixed_Type10");

selSeries.addConjunto("IP67","SIDE","EX250","MIXED","CJ_024","EX250_Mixed_Type10");

selSeries.addConjunto("IP67","SIDE","DSUB","MIXED","CJ_025","DSub_Mixed_Type10");

selSeries.addConjunto("IP67","SIDE","CIRCULAR","MIXED","CJ_026","CircularConnector_Mixed_Type10");

selSeries.addConjunto("IP67","BOTTOM","EX600","MIXED","CJ_027","EX600_Mixed_Type11");

selSeries.addConjunto("IP67","BOTTOM","EX260","MIXED","CJ_028","EX260_Mixed_Type11");

selSeries.addConjunto("IP67","BOTTOM","EX250","MIXED","CJ_029","EX250_Mixed_Type11");

selSeries.addConjunto("IP67","BOTTOM","DSUB","MIXED","CJ_030","DSub_Mixed_Type11");

selSeries.addConjunto("IP67","BOTTOM","CIRCULAR","MIXED","CJ_031","CircularConnector_Mixed_Type11");

selSeries.addConjunto("IP40","BOTTOM","DSUB","SY5000","CJ_033","DSub_SY5_Type51");

selSeries.addConjunto("IP40","SIDE","DSUB","SY3000","CJ_034","DSub_SY3_Type50");

selSeries.addConjunto("IP40","BOTTOM","DSUB","SY3000","CJ_035","DSub_SY3_Type51");

selSeries.addConjunto("IP67","SIDE","EX120","MIXED","CJ_040","EX120_Mixed_Type10");

selSeries.addConjunto("IP67","SIDE","EX120","SY5000","CJ_038","EX120_SY5_Type10");

selSeries.addConjunto("IP67","SIDE","EX120","SY3000","CJ_042","EX120_SY3_Type10");

selSeries.addConjunto("IP67","SIDE","EX126","SY5000","CJ_044","EX126_SY5_Type10");

selSeries.addConjunto("IP67","SIDE","EX126","MIXED","CJ_045","EX126_Mixed_Type10");

selSeries.addConjunto("IP67","SIDE","EX500","SY5000","CJ_049","EX500_SY5_Type10");

selSeries.addConjunto("IP67","SIDE","EX500","MIXED","CJ_050","EX500_Mixed_Type10");

selSeries.addConjunto("IP67","SIDE","FLATRIBBON","SY3000","CJ_053","FlatRibbon_SY3_Type10");

selSeries.addConjunto("IP67","SIDE","FLATRIBBON","SY5000","CJ_054","FlatRibbon_SY5_Type10");

selSeries.addConjunto("IP67","SIDE","FLATRIBBON","MIXED","CJ_055","FlatRibbon_Mixed_Type10");

selSeries.addConjunto("IP67","BOTTOM","FLATRIBBON","SY5000","CJ_056","FlatRibbon_SY5_Type11");

selSeries.addConjunto("IP67","BOTTOM","FLATRIBBON","MIXED","CJ_057","FlatRibbon_Mixed_Type11");

selSeries.addConjunto("IP67","SIDE","LEADWIRE","SY3000","CJ_058","LeadWire_SY3_Type10");

selSeries.addConjunto("IP67","SIDE","LEADWIRE","SY5000","CJ_059","LeadWire_SY5_Type10");

selSeries.addConjunto("IP67","SIDE","LEADWIRE","MIXED","CJ_060","LeadWire_Mixed_Type10");

selSeries.addConjunto("IP67","BOTTOM","LEADWIRE","SY5000","CJ_061","LeadWire_SY5_Type11");

selSeries.addConjunto("IP67","BOTTOM","LEADWIRE","MIXED","CJ_062","LeadWire_Mixed_Type11");

selSeries.addConjunto("IP67","SIDE","PCWIRING","SY3000","CJ_063","PcWiring_SY3_Type10");

selSeries.addConjunto("IP67","SIDE","PCWIRING","SY5000","CJ_064","PcWiring_SY5_Type10");

selSeries.addConjunto("IP67","SIDE","PCWIRING","MIXED","CJ_065","PcWiring_Mixed_Type10");

selSeries.addConjunto("IP67","BOTTOM","PCWIRING","SY5000","CJ_066","PcWiring_SY5_Type11");

selSeries.addConjunto("IP67","BOTTOM","PCWIRING","MIXED","CJ_067","PcWiring_Mixed_Type11");

selSeries.addConjunto("IP67","SIDE","TERMINALBLOCK","SY3000","CJ_068","Terminal_SY3_Type10");

selSeries.addConjunto("IP67","SIDE","TERMINALBLOCK","SY5000","CJ_069","Terminal_SY5_Type10");

selSeries.addConjunto("IP67","SIDE","TERMINALBLOCK","MIXED","CJ_070","Terminal_Mixed_Type10");

selSeries.addConjunto("IP67","BOTTOM","TERMINALBLOCK","SY5000","CJ_071","Terminal_SY5_Type11");

selSeries.addConjunto("IP67","BOTTOM","TERMINALBLOCK","MIXED","CJ_072","Terminal_Mixed_Type11");

selSeries.addConjunto("IP40","SIDE","FLATRIBBON","SY3000","CJ_073","FlatRibbon_SY3_Type50");

selSeries.addConjunto("IP40","SIDE","FLATRIBBON","SY5000","CJ_074","FlatRibbon_SY5_Type50");

selSeries.addConjunto("IP40","SIDE","DSUB","SY5000","CJ_032","DSub_SY5_Type50");

selSeries.addConjunto("IP40","SIDE","PCWIRING","SY3000","CJ_076","PcWiring_SY3_Type50");

selSeries.addConjunto("IP40","SIDE","PCWIRING","SY5000","CJ_077","PcWiring_SY5_Type50");

selSeries.addConjunto("IP40","SIDE","EX510","SY3000","CJ_078","EX510_SY3_Type50");

selSeries.addConjunto("IP40","SIDE","EX510","SY5000","CJ_079","EX510_SY5_Type50");

selSeries.addConjunto("IP40","BOTTOM","FLATRIBBON","SY3000","CJ_080","FlatRibbon_SY3_Type51");

selSeries.addConjunto("IP40","BOTTOM","PCWIRING","SY3000","CJ_081","PcWiring_SY3_Type51");

selSeries.addConjunto("IP40","BOTTOM","EX510","SY3000","CJ_082","EX510_SY3_Type51");

selSeries.addConjunto("IP40","BOTTOM","FLATRIBBON","SY5000","CJ_083","FlatRibbon_SY5_Type51");

selSeries.addConjunto("IP40","BOTTOM","PCWIRING","SY5000","CJ_084","PcWiring_SY5_Type51");

selSeries.addConjunto("IP40","BOTTOM","EX510","SY5000","CJ_085","EX510_SY5_Type51");

selSeries.addConjunto("IP67","SIDE","EX126","SY3000","CJ_086","EX126_SY3_Type10");

selSeries.addConjunto("IP67","SIDE","EX500","SY3000","CJ_087","EX500_SY3_Type10");

selSeries.addConjunto("IP67","TOP","CIRCULAR","SY3000","CJ_088","CircularConnector_SY3_Type12");

selSeries.addConjunto("IP67","TOP","FLATRIBBON","SY3000","CJ_089","FlatRibbon_SY3_Type12");

selSeries.addConjunto("IP67","TOP","LEADWIRE","SY3000","CJ_090","LeadWire_SY3_Type12");

selSeries.addConjunto("IP67","TOP","PCWIRING","SY3000","CJ_091","PcWiring_SY3_Type12");

selSeries.addConjunto("IP67","TOP","TERMINALBLOCK","SY3000","CJ_092","Terminal_SY3_Type12");

selSeries.addConjunto("IP67","TOP","DSUB","SY3000","CJ_093","DSub_SY3_Type12");

selSeries.addConjunto("IP67","TOP","EX120","SY3000","CJ_094","EX120_SY3_Type12");

selSeries.addConjunto("IP67","TOP","EX126","SY3000","CJ_095","EX126_SY3_Type12");

selSeries.addConjunto("IP67","TOP","EX260","SY3000","CJ_096","EX260_SY3_Type12");

selSeries.addConjunto("IP67","TOP","EX500","SY3000","CJ_097","EX500_SY3_Type12");

selSeries.addConjunto("IP67","TOP","EX250","SY3000","CJ_098","EX250_SY3_Type12");

selSeries.addConjunto("IP67","TOP","EX600","SY3000","CJ_099","EX600_SY3_Type12");

selSeries.addConjunto("IP67","TOP","CIRCULAR","SY5000","CJ_100","CircularConnector_SY5_Type12");

selSeries.addConjunto("IP67","TOP","FLATRIBBON","SY5000","CJ_101","FlatRibbon_SY5_Type12");

selSeries.addConjunto("IP67","TOP","LEADWIRE","SY5000","CJ_102","LeadWire_SY5_Type12");

selSeries.addConjunto("IP67","TOP","PCWIRING","SY5000","CJ_103","PcWiring_SY5_Type12");

selSeries.addConjunto("IP67","TOP","TERMINALBLOCK","SY5000","CJ_104","Terminal_SY5_Type12");

selSeries.addConjunto("IP67","TOP","DSUB","SY5000","CJ_105","DSub_SY5_Type12");

selSeries.addConjunto("IP67","TOP","EX120","SY5000","CJ_106","EX120_SY5_Type12");

selSeries.addConjunto("IP67","TOP","EX126","SY5000","CJ_107","EX126_SY5_Type12");

selSeries.addConjunto("IP67","TOP","EX260","SY5000","CJ_108","EX260_SY5_Type12");

selSeries.addConjunto("IP67","TOP","EX500","SY5000","CJ_109","EX500_SY5_Type12");

selSeries.addConjunto("IP67","TOP","EX250","SY5000","CJ_110","EX250_SY5_Type12");

selSeries.addConjunto("IP67","TOP","EX600","SY5000","CJ_111","EX600_SY5_Type12");

selSeries.addConjunto("IP67","TOP","CIRCULAR","MIXED","CJ_112","CircularConnector_Mixed_Type12");

selSeries.addConjunto("IP67","TOP","FLATRIBBON","MIXED","CJ_113","FlatRibbon_Mixed_Type12");

selSeries.addConjunto("IP67","TOP","LEADWIRE","MIXED","CJ_114","LeadWire_Mixed_Type12");

selSeries.addConjunto("IP67","TOP","PCWIRING","MIXED","CJ_115","PcWiring_Mixed_Type12");

selSeries.addConjunto("IP67","TOP","TERMINALBLOCK","MIXED","CJ_116","Terminal_Mixed_Type12");

selSeries.addConjunto("IP67","TOP","DSUB","MIXED","CJ_117","DSub_Mixed_Type12");

selSeries.addConjunto("IP67","TOP","EX120","MIXED","CJ_118","EX120_Mixed_Type12");

selSeries.addConjunto("IP67","TOP","EX126","MIXED","CJ_119","EX126_Mixed_Type12");

selSeries.addConjunto("IP67","TOP","EX500","MIXED","CJ_120","EX500_Mixed_Type12");

selSeries.addConjunto("IP67","TOP","EX260","MIXED","CJ_121","EX260_Mixed_Type12");

selSeries.addConjunto("IP67","TOP","EX250","MIXED","CJ_122","EX250_Mixed_Type12");

selSeries.addConjunto("IP67","TOP","EX600","MIXED","CJ_123","EX600_Mixed_Type12");

selSeries.addConjunto("IP40","TOP","DSUB","SY3000","CJ_124","DSub_SY3_Type52");

selSeries.addConjunto("IP40","TOP","FLATRIBBON","SY3000","CJ_125","FlatRibbon_SY3_Type52");

selSeries.addConjunto("IP40","TOP","PCWIRING","SY3000","CJ_126","PcWiring_SY3_Type52");

selSeries.addConjunto("IP40","TOP","EX510","SY3000","CJ_127","EX510_SY3_Type52");

selSeries.addConjunto("IP40","TOP","DSUB","SY5000","CJ_128","DSub_SY5_Type52");

selSeries.addConjunto("IP40","TOP","FLATRIBBON","SY5000","CJ_129","FlatRibbon_SY5_Type52");

selSeries.addConjunto("IP40","TOP","PCWIRING","SY5000","CJ_130","PcWiring_SY5_Type52");

selSeries.addConjunto("IP40","TOP","EX510","SY5000","CJ_131","EX510_SY5_Type52");

selSeries.addConjunto("IP67","BOTTOM","EX120","MIXED","CJ_132","EX120_Mixed_Type11");

selSeries.addConjunto("IP67","BOTTOM","EX126","MIXED","CJ_133","EX126_Mixed_Type11");

selSeries.addConjunto("IP67","BOTTOM","EX500","MIXED","CJ_134","EX500_Mixed_Type11");

selSeries.addConjunto("IP67","BOTTOM","EX500","SY5000","CJ_135","EX500_SY5_Type11");

selSeries.addConjunto("IP67","BOTTOM","EX126","SY5000","CJ_136","EX126_SY5_Type11");

selSeries.addConjunto("IP67","BOTTOM","EX120","SY5000","CJ_137","EX120_SY5_Type11");

selSeries.addConjunto("IP67","SIDE","CIRCULAR","SY7000","CJ_138","CircularConnector_SY7_Type10");

selSeries.addConjunto("IP67","SIDE","FLATRIBBON","SY7000","CJ_139","FlatRibbon_SY7_Type10");

selSeries.addConjunto("IP67","SIDE","LEADWIRE","SY7000","CJ_140","LeadWire_SY7_Type10");

selSeries.addConjunto("IP67","SIDE","PCWIRING","SY7000","CJ_141","PcWiring_SY7_Type10");

selSeries.addConjunto("IP67","SIDE","TERMINALBLOCK","SY7000","CJ_142","Terminal_SY7_Type10");

selSeries.addConjunto("IP67","SIDE","DSUB","SY7000","CJ_143","DSub_SY7_Type10");

selSeries.addConjunto("IP67","SIDE","EX120","SY7000","CJ_144","EX120_SY7_Type10");

selSeries.addConjunto("IP67","SIDE","EX126","SY7000","CJ_145","EX126_SY7_Type10");

selSeries.addConjunto("IP67","SIDE","EX250","SY7000","CJ_146","EX250_SY7_Type10");

selSeries.addConjunto("IP67","SIDE","EX260","SY7000","CJ_147","EX260_SY7_Type10");

selSeries.addConjunto("IP67","SIDE","EX500","SY7000","CJ_148","EX500_SY7_Type10");

selSeries.addConjunto("IP67","SIDE","EX600","SY7000","CJ_149","EX600_SY7_Type10");

selSeries.addConjunto("IP67","SIDE","CIRCULAR","MIXED7000","CJ_150","CircularConnector_SY7_Mixed_Type10");

selSeries.addConjunto("IP67","SIDE","FLATRIBBON","MIXED7000","CJ_151","FlatRibbon_SY7_Mixed_Type10");

selSeries.addConjunto("IP67","SIDE","LEADWIRE","MIXED7000","CJ_152","LeadWire_SY7_Mixed_Type10");

selSeries.addConjunto("IP67","SIDE","PCWIRING","MIXED7000","CJ_153","PcWiring_SY7_Mixed_Type10");

selSeries.addConjunto("IP67","SIDE","TERMINALBLOCK","MIXED7000","CJ_154","Terminal_SY7_Mixed_Type10");

selSeries.addConjunto("IP67","SIDE","DSUB","MIXED7000","CJ_155","DSub_SY7_Mixed_Type10");

selSeries.addConjunto("IP67","SIDE","EX120","MIXED7000","CJ_156","EX120_SY7_Mixed_Type10");

selSeries.addConjunto("IP67","SIDE","EX126","MIXED7000","CJ_157","EX126_SY7_Mixed_Type10");

selSeries.addConjunto("IP67","SIDE","EX250","MIXED7000","CJ_158","EX250_SY7_Mixed_Type10");

selSeries.addConjunto("IP67","SIDE","EX260","MIXED7000","CJ_159","EX260_SY7_Mixed_Type10");

selSeries.addConjunto("IP67","SIDE","EX500","MIXED7000","CJ_160","EX500_SY7_Mixed_Type10");

selSeries.addConjunto("IP67","SIDE","EX600","MIXED7000","CJ_161","EX600_SY7_Mixed_Type10");

selSeries.addConjunto("IP67","BOTTOM","CIRCULAR","SY7000","CJ_162","CircularConnector_SY7_Type11");

selSeries.addConjunto("IP67","BOTTOM","FLATRIBBON","SY7000","CJ_163","FlatRibbon_SY7_Type11");

selSeries.addConjunto("IP67","BOTTOM","LEADWIRE","SY7000","CJ_164","LeadWire_SY7_Type11");

selSeries.addConjunto("IP67","BOTTOM","PCWIRING","SY7000","CJ_165","PcWiring_SY7_Type11");

selSeries.addConjunto("IP67","BOTTOM","TERMINALBLOCK","SY7000","CJ_166","Terminal_SY7_Type11");

selSeries.addConjunto("IP67","BOTTOM","DSUB","SY7000","CJ_167","DSub_SY7_Type11");

selSeries.addConjunto("IP67","BOTTOM","EX120","SY7000","CJ_168","EX120_SY7_Type11");

selSeries.addConjunto("IP67","BOTTOM","EX126","SY7000","CJ_169","EX126_SY7_Type11");

selSeries.addConjunto("IP67","BOTTOM","EX250","SY7000","CJ_170","EX250_SY7_Type11");

selSeries.addConjunto("IP67","BOTTOM","EX260","SY7000","CJ_171","EX260_SY7_Type11");

selSeries.addConjunto("IP67","BOTTOM","EX500","SY7000","CJ_172","EX500_SY7_Type11");

selSeries.addConjunto("IP67","BOTTOM","EX600","SY7000","CJ_173","EX600_SY7_Type11");

selSeries.addConjunto("IP67","BOTTOM","CIRCULAR","MIXED7000","CJ_174","CircularConnector_SY7_Mixed_Type11");

selSeries.addConjunto("IP67","BOTTOM","FLATRIBBON","MIXED7000","CJ_175","FlatRibbon_SY7_Mixed_Type11");

selSeries.addConjunto("IP67","BOTTOM","LEADWIRE","MIXED7000","CJ_176","LeadWire_SY7_Mixed_Type11");

selSeries.addConjunto("IP67","BOTTOM","PCWIRING","MIXED7000","CJ_177","PcWiring_SY7_Mixed_Type11");

selSeries.addConjunto("IP67","BOTTOM","TERMINALBLOCK","MIXED7000","CJ_178","Terminal_SY7_Mixed_Type11");

selSeries.addConjunto("IP67","BOTTOM","DSUB","MIXED7000","CJ_179","DSub_SY7_Mixed_Type11");

selSeries.addConjunto("IP67","BOTTOM","EX120","MIXED7000","CJ_180","EX120_SY7_Mixed_Type11");

selSeries.addConjunto("IP67","BOTTOM","EX126","MIXED7000","CJ_181","EX126_SY7_Mixed_Type11");

selSeries.addConjunto("IP67","BOTTOM","EX250","MIXED7000","CJ_182","EX250_SY7_Mixed_Type11");

selSeries.addConjunto("IP67","BOTTOM","EX260","MIXED7000","CJ_183","EX260_SY7_Mixed_Type11");

selSeries.addConjunto("IP67","BOTTOM","EX500","MIXED7000","CJ_184","EX500_SY7_Mixed_Type11");

selSeries.addConjunto("IP67","BOTTOM","EX600","MIXED7000","CJ_185","EX600_SY7_Mixed_Type11");

selSeries.addConjunto("IP67","TOP","CIRCULAR","SY7000","CJ_186","CircularConnector_SY7_Type12");

selSeries.addConjunto("IP67","TOP","FLATRIBBON","SY7000","CJ_187","FlatRibbon_SY7_Type12");

selSeries.addConjunto("IP67","TOP","LEADWIRE","SY7000","CJ_188","LeadWire_SY7_Type12");

selSeries.addConjunto("IP67","TOP","PCWIRING","SY7000","CJ_189","PcWiring_SY7_Type12");

selSeries.addConjunto("IP67","TOP","TERMINALBLOCK","SY7000","CJ_190","Terminal_SY7_Type12");

selSeries.addConjunto("IP67","TOP","DSUB","SY7000","CJ_191","DSub_SY7_Type12");

selSeries.addConjunto("IP67","TOP","EX120","SY7000","CJ_192","EX120_SY7_Type12");

selSeries.addConjunto("IP67","TOP","EX126","SY7000","CJ_193","EX126_SY7_Type12");

selSeries.addConjunto("IP67","TOP","EX260","SY7000","CJ_194","EX260_SY7_Type12");

selSeries.addConjunto("IP67","TOP","EX500","SY7000","CJ_195","EX500_SY7_Type12");

selSeries.addConjunto("IP67","TOP","EX600","SY7000","CJ_196","EX600_SY7_Type12");

selSeries.addConjunto("IP67","TOP","CIRCULAR","MIXED7000","CJ_197","CircularConnector_SY7_Mixed_Type12");

selSeries.addConjunto("IP67","TOP","FLATRIBBON","MIXED7000","CJ_198","FlatRibbon_SY7_Mixed_Type12");

selSeries.addConjunto("IP67","TOP","LEADWIRE","MIXED7000","CJ_199","LeadWire_SY7_Mixed_Type12");

selSeries.addConjunto("IP67","TOP","PCWIRING","MIXED7000","CJ_200","PcWiring_SY7_Mixed_Type12");

selSeries.addConjunto("IP67","TOP","TERMINALBLOCK","MIXED7000","CJ_201","Terminal_SY7_Mixed_Type12");

selSeries.addConjunto("IP67","TOP","DSUB","MIXED7000","CJ_202","DSub_SY7_Mixed_Type12");

selSeries.addConjunto("IP67","TOP","EX120","MIXED7000","CJ_203","EX120_SY7_Mixed_Type12");

selSeries.addConjunto("IP67","TOP","EX126","MIXED7000","CJ_204","EX126_SY7_Mixed_Type12");

selSeries.addConjunto("IP67","TOP","EX500","MIXED7000","CJ_205","EX500_SY7_Mixed_Type12");

selSeries.addConjunto("IP67","TOP","EX260","MIXED7000","CJ_206","EX260_SY7_Mixed_Type12");

selSeries.addConjunto("IP67","TOP","EX250","MIXED7000","CJ_207","EX250_SY7_Mixed_Type12");

selSeries.addConjunto("IP67","TOP","EX600","MIXED7000","CJ_208","EX600_SY7_Mixed_Type12");

selSeries.addConjunto("IP40","SIDE","DSUB","SY7000","CJ_209","DSub_SY7_Type50");

selSeries.addConjunto("IP40","SIDE","FLATRIBBON","SY7000","CJ_210","FlatRibbon_SY7_Type50");

selSeries.addConjunto("IP40","SIDE","PCWIRING","SY7000","CJ_211","PcWiring_SY7_Type50");

selSeries.addConjunto("IP40","SIDE","EX510","SY7000","CJ_212","EX510_SY7_Type50");

selSeries.addConjunto("IP40","BOTTOM","DSUB","SY7000","CJ_213","DSub_SY7_Type51");

selSeries.addConjunto("IP40","BOTTOM","FLATRIBBON","SY7000","CJ_214","FlatRibbon_SY7_Type51");

selSeries.addConjunto("IP40","BOTTOM","PCWIRING","SY7000","CJ_215","PcWiring_SY7_Type51");

selSeries.addConjunto("IP40","BOTTOM","EX510","SY7000","CJ_216","EX510_SY7_Type51");

selSeries.addConjunto("IP40","TOP","DSUB","SY7000","CJ_217","DSub_SY7_Type52");

selSeries.addConjunto("IP40","TOP","FLATRIBBON","SY7000","CJ_218","FlatRibbon_SY7_Type52");

selSeries.addConjunto("IP40","TOP","PCWIRING","SY7000","CJ_219","PcWiring_SY7_Type52");

selSeries.addConjunto("IP40","TOP","EX510","SY7000","CJ_220","EX510_SY7_Type52");

selSeries.addConjunto("IP67","TOP","EX250","SY7000","CJ_221","EX250_SY7_Type12");
	
}

function addIncompatibilidades(){
var incompTypes = selSeries.incompatibilities.type;

selSeries.addIncompatibility(incompTypes.CONNECTOR, "IP40","  ","CIRCULAR"," ");

selSeries.addIncompatibility(incompTypes.CONNECTOR, "IP40","  ","EX120"," ");

selSeries.addIncompatibility(incompTypes.CONNECTOR, "IP40","  ","EX126"," ");

selSeries.addIncompatibility(incompTypes.CONNECTOR, "IP40","  ","EX250"," ");

selSeries.addIncompatibility(incompTypes.CONNECTOR, "IP40","  ","EX260"," ");

selSeries.addIncompatibility(incompTypes.CONNECTOR, "IP40","  ","EX500"," ");

selSeries.addIncompatibility(incompTypes.CONNECTOR, "IP40","  ","EX600"," ");

selSeries.addIncompatibility(incompTypes.CONNECTOR, "IP40","  ","LEADWIRE"," ");

selSeries.addIncompatibility(incompTypes.CONNECTOR, "IP40","  ","TERMINALBLOCK"," ");

selSeries.addIncompatibility(incompTypes.CONNECTOR, "IP67","  ","EX510"," ");

selSeries.addIncompatibility(incompTypes.VALVE, "IP40","  "," ","MIXED");

selSeries.addIncompatibility(incompTypes.VALVE, "IP67","BOTTOM"," ","SY3000");

selSeries.addIncompatibility(incompTypes.VALVE, "IP40","  "," ","MIXED7000");
	
}
