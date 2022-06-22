var activated_meassures = true;
var activated_notices = true;
var selected_tab = 0;
var copying = false;
var cell_from_copy_id = "";
var from = "null";

var drawingsBasePath = 'drawing/';
var graphToolsBasePath = 'graphical_tools/';
var updatesBasePath = 'updates/';

var execAnalysis = {
	funcsExecuting : 0,
	analysis : '',
	funcStart : function(funcName) {
		var indent = this.funcsExecuting * 5;
		this.analysis += '<p style="text-indent:' + indent + 'px;">' + funcName
				+ ' started... (' + new Date().toGMTString() + ')</p>';
		this.funcsExecuting = this.funcsExecuting + 1;
	},
	funcEnd : function(funcName) {
		this.funcsExecuting = this.funcsExecuting - 1;
		var indent = this.funcsExecuting * 5;
		this.analysis += '<p style="text-indent:' + indent + 'px;">' + funcName
				+ ' finished(' + new Date().toGMTString() + ')</p>';
	}
};

/**
 * Refresca las variables dependiendo del valor que se introduzca
 * 
 * @param showMeassures
 *            si est�n visible las medidas
 * @param showNotices
 *            si est�n visible los avisos
 */
function refresh_show_variables(showMeassures, showNotices) {
	activated_meassures = showMeassures;
	activated_notices = showNotices;
}

function refresh_current_browser() {
	var randomnumber = Math.floor(Math.random() * 10000);
	$j.ajax({
		url : "current_browser_ie.jsp",
		data : "isIE=" + $j.browser.msie + "&number=" + randomnumber,
		success : function(data) {

		},
		error : function(objeto, quepaso, otroobj) {
			alert("Pas� lo siguiente: refresh_graphical_editor -->" + objeto
					+ " " + quepaso + " " + otroobj);
		}
	});
}

/**
 * Refresca el editor gr�fico, las im�genes
 * 
 * @param url
 *            en la que se refrescan las im�genes
 */
function refresh_graphical_editor(recalculate_size_positions) {
	var randomnumber = Math.floor(Math.random() * 10000);
	$j.ajax({
		url : drawingsBasePath + "draw_images.jsp",
		data : recalculate_size_positions + "&number=" + randomnumber,
		success : function(data) {
			$j('#graphical_editor_div').html(data);
			eventos_ikGraphicElement();
		},
		error : function(objeto, quepaso, otroobj) {
			alert("Pas� lo siguiente: refresh_graphical_editor -->" + objeto
					+ " " + quepaso + " " + otroobj);
		}
	});
}

/**
 * Evento asociado a las im�genes que representan los productos
 * (ikGraphicElement)
 */
function eventos_ikGraphicElement() {
	$j(".ikGraphicElement").click(
			function() {
				if (!$j(this).hasClass("graphicSelected")) {

					var currentTime = new Date();
					$j('#debug_panel').append(
							'<p>START event_ikGraphicElement.deselected: '
									+ currentTime + '</p>');

					// Deseleccionar el resto de elementos seleccionados
					// if (!$j.browser.msie) {
					$j(".graphicSelected").each(function(index, value) {
						var width = $j(value).width();
						width = width + 2;
						$j(value).width(width);
						var height = $j(value).height();
						height = height + 2;
						$j(value).height(height);
					});
					// }
					$j(".graphicSelected").removeClass("graphicSelected");
					// Quitar el elemento 'enfocado'
					if ($j(this).hasClass("ikGraphicHover")) {
						var width = $j(this).width();
						width = width + 4;
						$j(this).width(width);
						var height = $j(this).height();
						height = height + 4;
						$j(this).height(height);
						$j(".ikGraphicHover").removeClass("ikGraphicHover");
					}
					// Seleccionar el elemento actual
					$j(this).addClass("graphicSelected");
					var width = $j(this).width();
					width = width - 2;
					$j(this).width(width);
					var height = $j(this).height();
					height = height - 2;
					$j(this).height(height);

					// Obtener el id del elemento
					var id = $j(this).attr("id");
					// Cargar posibilidades de productos y cargar
					// caracter�sticas/opciones del producto
					refresh_configurator_panel("selectedIdCell=" + id);
					// Refrescar botones
					refresh_graphical_editor_tools(false);

					currentTime = new Date();
					$j('#debug_panel').append(
							'<p>END event_ikGraphicElement.deselected: '
									+ currentTime + '</p>');

				}
				if (copying) {

					var currentTime = new Date();
					$j('#debug_panel').append(
							'<p>START event_ikGraphicElement.copy: '
									+ currentTime + '</p>');

					var cell_to_copy_id = $j(".graphicSelected").attr("id");
					copy(cell_from_copy_id, cell_to_copy_id);

					currentTime = new Date();
					$j('#debug_panel').append(
							'<p>END event_ikGraphicElement.copy: '
									+ currentTime + '</p>');

				} else {

					var currentTime = new Date();
					$j('#debug_panel').append(
							'<p>START event_ikGraphicElement: ' + currentTime
									+ '</p>');

					var tab = $j(this).attr("tab");
					selected_tab = tab;
					// Calcular la referencia
					refresh_reference();
					// refrescar pesta�as
					refresh_tabs(tab);

					currentTime = new Date();
					$j('#debug_panel').append(
							'<p>END event_ikGraphicElement: ' + currentTime
									+ '</p>');

				}
			});

	$j(".ikGraphicElement").mouseenter(
			function() {

				var currentTime = new Date();
				$j('#debug_panel').append(
						'<p>START event_ikGraphicElement.mouseenter: '
								+ currentTime + '</p>');

				if (!$j(this).hasClass("graphicSelected")) {
					$j(this).addClass("ikGraphicHover");
					var width = $j(this).width();
					width = width - 4;
					$j(this).width(width);
					var height = $j(this).height();
					height = height - 4;
					$j(this).height(height);
				}

				currentTime = new Date();
				$j('#debug_panel').append(
						'<p>END event_ikGraphicElement.mouseenter: '
								+ currentTime + '</p>');

			}).mouseleave(
			function() {

				var currentTime = new Date();
				$j('#debug_panel').append(
						'<p>START event_ikGraphicElement.mouseleave: '
								+ currentTime + '</p>');

				if (!$j(this).hasClass("graphicSelected")) {
					var width = $j(this).width();
					width = width + 4;
					$j(this).width(width);
					var height = $j(this).height();
					height = height + 4;
					$j(this).height(height);
					$j(".ikGraphicHover").removeClass("ikGraphicHover");
				}

				currentTime = new Date();
				$j('#debug_panel').append(
						'<p>END event_ikGraphicElement.mouseleave: '
								+ currentTime + '</p>');

			});
}

/**
 * Refresca el editor gr�fico, las im�genes
 * 
 * @param url
 *            en la que se refrescan las im�genes
 */
function refresh_graphical_editor_tools(disable) {
	var randomnumber = Math.floor(Math.random() * 10000);
	$j.ajax({
		url : drawingsBasePath + "draw_graphic_tools.jsp",
		async : false,
		data : "disable=" + disable + "&number=" + randomnumber,
		success : function(data) {
			$j('#graphical_editor_tools_div').html(data);
			event_ikGraphicTools();
		},
		error : function(objeto, quepaso, otroobj) {
			alert("Pas� lo siguiente: refresh_graphical_editor_tools -->"
					+ objeto + " " + quepaso + " " + otroobj);
		}
	});
}

function refresh_copying_graphic_editor_tools(selected_tab) {
	var randomnumber = Math.floor(Math.random() * 10000);
	$j.ajax({
		url : graphToolsBasePath + "update_copying.jsp",
		async : false,
		data : "copying=" + copying + "&copyingTab=" + selected_tab
				+ "&number=" + randomnumber,
		success : function(data) {
			if (!copying) {
				cell_from_copy_id = null;
				$j(".ikGraphicElement").each(function(index, value) {
					$j(value).removeClass("ikCopying");
				});
			} else {
				// Obtener la celda en caso de tener que copiar
				cell_from_copy_id = $j(".graphicSelected").attr("id");
				$j(".ikGraphicElement").each(function(index, value) {
					var tab = $j(value).attr("tab");
					if (tab == selected_tab) {
						$j(value).addClass("ikCopying");
					}
				});
			}
			// Si es configuration summary que no haga el refresco que se
			// encarga de ello cuando entra al evento de cambio de pesta�a
			var tabs = $j(".SY_tab_image_name");
			if (selected_tab != tabs.size() - 1)
				refresh_graphical_editor_tools(false);
		},
		error : function(objeto, quepaso, otroobj) {
			alert("Pas� lo siguiente: refresh_copying_graphic_editor_tools -->"
					+ objeto + " " + quepaso + " " + otroobj);
		}
	});
}

function event_ikGraphicTools() {
	$j(".ikCopyTool").click(
			function() {

				var currentTime = new Date();
				$j('#debug_panel').append(
						'<p>START event_ikGraphicTools.ikCopyTool: '
								+ currentTime + '</p>');

				var activated = $j(this).attr("activated");
				if (activated == "true") {
					// Qu� tipo de elemento se va a copiar
					var selected_tab = $j(".graphicSelected").attr("tab");
					// Saber si se est� o no copiando
					copying = !copying;
					// Actualizar la variable 'copying' y la
					// habilitaci�n/deshabilitaci�n de las herramientas gr�ficas
					refresh_copying_graphic_editor_tools(selected_tab);
				}

				currentTime = new Date();
				$j('#debug_panel').append(
						'<p>END event_ikGraphicTools.ikCopyTool: '
								+ currentTime + '</p>');
			});
	$j(".ikAddTool").click(
			function() {

				var currentTime = new Date();
				$j('#debug_panel').append(
						'<p>START event_ikGraphicTools.ikAddTool: '
								+ currentTime + '</p>');

				var activated = $j(this).attr("activated");
				if (activated == "true") {
					var cell_to_add_id = $j(".graphicSelected").attr("id");
					add(cell_to_add_id);
				}

				currentTime = new Date();
				$j('#debug_panel').append(
						'<p>END event_ikGraphicTools.ikAddTool: ' + currentTime
								+ '</p>');

			});
	$j(".ikDeleteTool").click(
			function() {

				var currentTime = new Date();
				$j('#debug_panel').append(
						'<p>START event_ikGraphicTools.ikDeleteTool: '
								+ currentTime + '</p>');

				var activated = $j(this).attr("activated");
				if (activated == "true") {
					var cell_to_delete_id = $j(".graphicSelected").attr("id");
					delete_cell(cell_to_delete_id);
				}

				currentTime = new Date();
				$j('#debug_panel').append(
						'<p>END event_ikGraphicTools.ikDeleteTool: '
								+ currentTime + '</p>');

			});
	$j(".ikMoveRightTool").click(
			function() {

				var currentTime = new Date();
				$j('#debug_panel').append(
						'<p>START event_ikGraphicTools.ikMoveRightTool: '
								+ currentTime + '</p>');

				var activated = $j(this).attr("activated");
				if (activated == "true") {
					var cell_to_move_id = $j(".graphicSelected").attr("id");
					move(cell_to_move_id, false);
				}

				currentTime = new Date();
				$j('#debug_panel').append(
						'<p>END event_ikGraphicTools.ikMoveRightTool: '
								+ currentTime + '</p>');

			});
	$j(".ikMoveLeftTool").click(
			function() {

				var currentTime = new Date();
				$j('#debug_panel').append(
						'<p>START event_ikGraphicTools.ikMoveLeftTool: '
								+ currentTime + '</p>');

				var activated = $j(this).attr("activated");
				if (activated == "true") {
					var cell_to_move_id = $j(".graphicSelected").attr("id");
					move(cell_to_move_id, true);
				}

				currentTime = new Date();
				$j('#debug_panel').append(
						'<p>END event_ikGraphicTools.ikMoveLeftTool: '
								+ currentTime + '</p>');

			});
	$j(".ikUndoTool").click(
			function() {

				var currentTime = new Date();
				$j('#debug_panel').append(
						'<p>START event_ikGraphicTools.ikUndoTool: '
								+ currentTime + '</p>');

				var activated = $j(this).attr("activated");
				if (activated == "true")
					undo();

				currentTime = new Date();
				$j('#debug_panel').append(
						'<p>END event_ikGraphicTools.ikUndoTool: '
								+ currentTime + '</p>');

			});
	$j(".ikRedoTool").click(
			function() {

				var currentTime = new Date();
				$j('#debug_panel').append(
						'<p>START event_ikGraphicTools.ikRedoTool: '
								+ currentTime + '</p>');

				var activated = $j(this).attr("activated");
				if (activated == "true")
					redo();

				currentTime = new Date();
				$j('#debug_panel').append(
						'<p>END event_ikGraphicTools.ikRedoTool: '
								+ currentTime + '</p>');

			});
	$j(".ikDeleteProductTool").click(
			function() {

				var currentTime = new Date();
				$j('#debug_panel').append(
						'<p>START event_ikGraphicTools.ikDeleteProductTool: '
								+ currentTime + '</p>');

				var activated = $j(this).attr("activated");
				if (activated == "true")
					delete_product_cell();

				currentTime = new Date();
				$j('#debug_panel').append(
						'<p>END event_ikGraphicTools.ikDeleteProductTool: '
								+ currentTime + '</p>');

			});
}

function copy(cell_from_copy_id, cell_to_copy_id) {
	var randomnumber = Math.floor(Math.random() * 10000);
	$j.ajax({
		url : graphToolsBasePath + "copy.jsp",
		data : "cellFromCopyId=" + cell_from_copy_id + "&cellToCopyId="
				+ cell_to_copy_id + "&number=" + randomnumber,
		success : function(data) {
			// Refrescar avisos
			refresh_notices();
			// Refrescar medidas
			//refresh_meassures(); DESHABILITADO PARA MOSTRAR UNICAMENTE SOLENOIDES
			// Refrescar solenoides
			refresh_solenoids();
			// Refrescar panel
			refresh_configurator_panel();
			// Refrescar editor gr�fico
			refresh_graphical_editor("recalculate=1");
			// Refrescar herramientas gr�ficas
			refresh_graphical_editor_tools(false);
			// Refrescar pesta�as
			refresh_tabs("0");
		},
		error : function(objeto, quepaso, otroobj) {
			alert("Pas� lo siguiente: copy -->" + objeto + " " + quepaso + " "
					+ otroobj);
		}
	});
}

function move(cell_to_move_id, right_to_left) {
	var randomnumber = Math.floor(Math.random() * 10000);
	$j.ajax({
		url : graphToolsBasePath + "move.jsp",
		data : "cellToMoveId=" + cell_to_move_id + "&rightToLeft="
				+ right_to_left + "&number=" + randomnumber,
		success : function(data) {
			// Refrescar avisos
			refresh_notices();
			// Refrescar panel
			refresh_configurator_panel();
			// Refrescar editor gr�fico
			refresh_graphical_editor("recalculate=1");
			// Refrescar herramientas gr�ficas
			refresh_graphical_editor_tools(false);
		},
		error : function(objeto, quepaso, otroobj) {
			alert("Pas� lo siguiente: move -->" + objeto + " " + quepaso + " "
					+ otroobj);
		}
	});
}

function add(cell_to_add) {
	var randomnumber = Math.floor(Math.random() * 10000);
	$j.ajax({
		url : graphToolsBasePath + "add.jsp",
		data : "cellToAdd=" + cell_to_add + "&number=" + randomnumber,
		success : function(data) {
			// Chequear, para cambiar el n�mero de elementos
			check(data);
			// Refrescar avisos
			refresh_notices();
			// Refrescar medidas
			//refresh_meassures(); DESHABILITADO PARA MOSTRAR UNICAMENTE SOLENOIDES
			// Refrescar solenoides
			refresh_solenoids();
			// Refrescar editor gr�fico
			refresh_graphical_editor("recalculate=1");
			// Refrescar herramientas gr�ficas
			refresh_graphical_editor_tools(false);
			// Refrescar panel
			refresh_configurator_panel();
		},
		error : function(objeto, quepaso, otroobj) {
			alert("Pas� lo siguiente: add -->" + objeto + " " + quepaso + " "
					+ otroobj);
		}
	});
}

function delete_cell(cell_to_delete_id) {
	var randomnumber = Math.floor(Math.random() * 10000);
	$j.ajax({
		url : graphToolsBasePath + "delete.jsp",
		data : "cellToDeleteId=" + cell_to_delete_id + "&number="
				+ randomnumber,
		success : function(data) {
			// Chequear, para cambiar el n�mero de elementos
			check(data);
			// Refrescar avisos
			refresh_notices();
			// Refrescar medidas
			//refresh_meassures(); DESHABILITADO PARA MOSTRAR UNICAMENTE SOLENOIDES
			// Refrescar solenoides
			refresh_solenoids();
			// Refrescar editor gr�fico
			refresh_graphical_editor("recalculate=1");
			// Refrescar herramientas gr�ficas
			refresh_graphical_editor_tools(false);
			// Refrescar panel
			refresh_configurator_panel();
		},
		error : function(objeto, quepaso, otroobj) {
			alert("Pas� lo siguiente: delete -->" + objeto + " " + quepaso
					+ " " + otroobj);
		}
	});
}

function undo() {
	var randomnumber = Math.floor(Math.random() * 10000);
	$j.ajax({
		url : graphToolsBasePath + "undo.jsp",
		data : "number=" + randomnumber,
		success : function(characteristic_option) {
			// Refrescar medidas
			//refresh_meassures(); DESHABILITADO PARA MOSTRAR UNICAMENTE SOLENOIDES
			// Refrescar solenoides
			refresh_solenoids();
			// Refrescar avisos
			refresh_notices();
			// Refrescar panel para el caso de a�adir/borrar estaci�n
			if (characteristic_option != "") {
				check(characteristic_option);
			}
			// Actualizar pesta�as
			$j(".ikGraphicElement").each(function(index, value) {
				if ($j(this).hasClass("graphicSelected")) {
					var tab = $j(value).attr("tab");
					refresh_tabs(tab);
				}
			});
			refresh_configurator_panel();
			// Refrescar editor gr�fico
			refresh_graphical_editor("recalculate=1");
			// Refrescar herramientas gr�ficas
			refresh_graphical_editor_tools(false);
		},
		error : function(objeto, quepaso, otroobj) {
			alert("Pas� lo siguiente: undo -->" + objeto + " " + quepaso + " "
					+ otroobj);
		}
	});
}

function redo() {
	var randomnumber = Math.floor(Math.random() * 10000);
	$j.ajax({
		url : graphToolsBasePath + "redo.jsp",
		data : "number=" + randomnumber,
		success : function(characteristic_option) {
			// Refrescar medidas
			//refresh_meassures(); DESHABILITADO PARA MOSTRAR UNICAMENTE SOLENOIDES
			// Refrescar solenoides
			refresh_solenoids();
			// Refrescar avisos
			refresh_notices();
			// Refrescar panel para el caso de a�adir/borrar estaci�n
			if (characteristic_option != "") {
				check(characteristic_option);
			} else {
				check();
			}
			// Actualizar pesta�as
			$j(".ikGraphicElement").each(function(index, value) {
				if ($j(this).hasClass("graphicSelected")) {
					var tab = $j(value).attr("tab");
					refresh_tabs(tab);
				}
			});
			refresh_configurator_panel();
			// Refrescar herramientas gr�ficas
			refresh_graphical_editor_tools(false);
		},
		error : function(objeto, quepaso, otroobj) {
			alert("Pas� lo siguiente: redo -->" + objeto + " " + quepaso + " "
					+ otroobj);
		}
	});
}

function delete_product_cell() {
	var randomnumber = Math.floor(Math.random() * 10000);
	$j.ajax({
		url : graphToolsBasePath + "delete_product.jsp",
		data : "number=" + randomnumber,
		success : function(data) {
			// Refrescar avisos
			refresh_notices();
			// Refrescar medidas
			//refresh_meassures(); DESHABILITADO PARA MOSTRAR UNICAMENTE SOLENOIDES
			// Refrescar solenoides
			refresh_solenoids();
			// Refrescar panel
			refresh_configurator_panel();
			// Refrescar editor gr�fico
			refresh_graphical_editor("recalculate=1");
			// Refrescar herramientas gr�ficas
			refresh_graphical_editor_tools(false);
		},
		error : function(objeto, quepaso, otroobj) {
			alert("Pas� lo siguiente: delete_product -->" + objeto + " "
					+ quepaso + " " + otroobj);
		}
	});
}

/**
 * Refresca el panel de configuraci�n
 * 
 * @param url
 *            en la que se insertan los productos y las caracter�sticas y
 *            opciones
 */
function refresh_configurator_panel(selected_cell) {
	var randomnumber = Math.floor(Math.random() * 10000);
	$j.ajax({
		url : drawingsBasePath + "draw_cell_configuration.jsp",
		async : false,
		data : selected_cell + "&number=" + randomnumber,
		success : function(data) {
			refresh_tabs();
			var status = refresh_status_form_to_basket();
			refresh_group_global_variable(status);
			var buttons = refresh_down_buttons();
			data += buttons;
			$j('#configurator_panel_div').html(data);
			event_characteristic_option_panel();
			event_add_product();
			event_delete_product();
			event_ikFreeReference();
		}
	});
	// }
}

/**
 * Refresca los botones del panel de configuraci�n
 */
function refresh_down_buttons() {
	var randomnumber = Math.floor(Math.random() * 10000);
	var result = "";
	$j.ajax({
		url : drawingsBasePath + "draw_down_buttons.jsp",
		async : false,
		data : "number=" + randomnumber,
		success : function(data) {
			result = data;
		}
	});
	return result;
}

/**
 * Se utiliza para realizar los chequeos
 * 
 * @param url
 *            en la que se insertan los productos y las caracter�sticas y
 *            opciones
 */
function check(data) {
	var randomnumber = Math.floor(Math.random() * 10000);
	$j.ajax({
		url : "check.jsp",
		async : false,
		data : data + "&number=" + randomnumber,
		success : function(data) {
			// Refrescar medidas
			//refresh_meassures(); //DESHABILITADO PARA MOSTRAR UNICAMENTE SOLENOIDES
			// Refrescar solenoides
			refresh_solenoids();
			// Refrescar panel
			refresh_configurator_panel();
			// Refrescar botones de abajo
			refresh_down_buttons();

		}
	});
}

/**
 * Se ejecuta cuando se cambia una opci�n
 */
function event_characteristic_option_panel() {
	$j('.interval_selection').change(
			function() {
				var currentTime = new Date();
				$j('#debug_panel').append(
						'<p>START event_characteristic_option_panel: '
								+ currentTime + '</p>');

				var idCharacteristic = $j(this).attr("name");
				var idOption = $j(this).attr("value");
				check("idCharacteristic=" + idCharacteristic + "&idOption="
						+ idOption);
				refresh_configurator_panel();
				refresh_graphical_editor("recalculate=0");
				refresh_graphical_editor_tools(false);
				refresh_reference();
				refresh_tabs(0);
				// Comprobar los avisos
				if (activated_notices)
					refresh_notices();
				// Calcular medidas
				if (activated_meassures){
					// Refrescar medidas
					//refresh_meassures(); DESHABILITADO PARA MOSTRAR UNICAMENTE SOLENOIDES
					// Refrescar solenoides
					refresh_solenoids();
				}

				currentTime = new Date();
				$j('#debug_panel').append(
						'<p>END event_characteristic_option_panel: '
								+ currentTime + '</p>');
			});
	$j('.event').change(
			function() {
				var currentTime = new Date();
				$j('#debug_panel').append(
						'<p>START event_characteristic_option_panel: '
								+ currentTime + '</p>');

				var idCharacteristic = $j(this).attr("id");
				var idOption = $j(this).val();
				check("idCharacteristic=" + idCharacteristic + "&idOption="
						+ idOption);
				refresh_configurator_panel();
				refresh_graphical_editor("recalculate=0");
				refresh_reference();
				refresh_tabs();
				// Comprobar los avisos
				if (activated_notices)
					refresh_notices();
				// Calcular medidas
				if (activated_meassures){
					// Refrescar medidas
					//refresh_meassures(); DESHABILITADO PARA MOSTRAR UNICAMENTE SOLENOIDES
					// Refrescar solenoides
					refresh_solenoids();
					}

				currentTime = new Date();
				$j('#debug_panel').append(
						'<p>END event_characteristic_option_panel: '
								+ currentTime + '</p>');
			});
}

/**
 * Se ejecuta cuando se a�ade un producto
 */
function event_add_product() {
	$j('.link_product').click(
			function() {
				var currentTime = new Date();
				$j('#debug_panel').append(
						'<p>START event_add_product: ' + currentTime + '</p>');

				var cell_id = $j(this).attr("idCell");
				var product_id = $j(this).attr("idProduct");
				var other_cell_product = $j(this).attr("otherCellProduct");
				var product_tab = $j(this).attr("productTab");
				var product_type = $j(this).attr("productType");
				product_tab = product_tab - 1;
				var randomnumber = Math.floor(Math.random() * 10000);
				$j
						.ajax({
							url : "add_product.jsp",
							async : false,
							data : "idCell=" + cell_id + "&idProduct="
									+ product_id + "&otherCellProduct="
									+ other_cell_product + "&productType="
									+ product_type + "&number=" + randomnumber,
							success : function(data) {
								// A�adido el producto al conjunto de im�genes,
								// no hace falta recalcular posiciones
								refresh_graphical_editor("recalculate=0");
								// Refrescar la habilitaci�n de las herramientas
								// gr�ficas: para el caso en el que se ha
								// insertado cuando se hab�a hecho 'deshacer'
								refresh_graphical_editor_tools(false);
								// Calcular la referencia
								refresh_reference();
								// Refrescar pesta�as
								refresh_tabs(product_tab);
								// Refrescar botones de abajo
								refresh_configurator_panel("selectedIdCell="
										+ cell_id);
								// Comprobar los avisos
								if (activated_notices)
									refresh_notices();
								// Calcular medidas
								if (activated_meassures){
									// Refrescar medidas
									//refresh_meassures(); DESHABILITADO PARA MOSTRAR UNICAMENTE SOLENOIDES
									// Refrescar solenoides
									refresh_solenoids();
								}
							},
							error : function(objeto, quepaso, otroobj) {
								alert("Pas� lo siguiente: event_add_product");
							}
						});

				currentTime = new Date();
				$j('#debug_panel').append(
						'<p>END event_add_product: ' + currentTime + '</p>');
			});
}

/**
 * Se ejecuta cuando se borra un producto
 */
function event_delete_product() {
	$j('.delete_product')
			.click(
					function() {

						var currentTime = new Date();
						$j('#debug_panel').append(
								'<p>START event_delete_product: ' + currentTime
										+ '</p>');
						var randomnumber = Math.floor(Math.random() * 10000);
						$j
								.ajax({
									url : "delete_product.jsp",
									async : false,
									data : "number=" + randomnumber,
									beforeSend : function(objeto) {
										$j(this).text("PROCESANDO");
									},
									success : function(data) {
										refresh_configurator_panel();
										// Borrado el producto del conjunto de
										// im�genes, recalcular las posiciones
										// por si ha de desaparecer la casilla
										refresh_graphical_editor("recalculate=1");
										refresh_reference();
										if (selected_tab != 0)
											refresh_tabs(selected_tab);
										// Comprobar los avisos
										if (activated_notices)
											refresh_notices();
										// Calcular medidas
										if (activated_meassures){
											// Refrescar medidas
											//refresh_meassures(); DESHABILITADO PARA MOSTRAR UNICAMENTE SOLENOIDES
											// Refrescar solenoides
											refresh_solenoids();
										}
									},
									error : function(objeto, quepaso, otroobj) {
										alert("Pas� lo siguiente: event_delete_product");
									}
								});

						currentTime = new Date();
						$j('#debug_panel').append(
								'<p>END event_delete_product: ' + currentTime
										+ '</p>');

					});
}

/**
 * Recalcula y redibuja la referencia
 * 
 * @param data
 */
function refresh_reference(data) {
	var randomnumber = Math.floor(Math.random() * 10000);
	$j.ajax({
		url : drawingsBasePath + "draw_reference.jsp",
		data : data + "&number=" + randomnumber,
		success : function(data) {
			$j('#reference_div').html(data);
		}
	});
}

/**
 * Recalcula y redibuja los avisos
 * 
 * @param data
 */
function refresh_notices(data) {
	var randomnumber = Math.floor(Math.random() * 10000);
	$j.ajax({
		url : drawingsBasePath + "draw_notices.jsp",
		data : data + "&number=" + randomnumber,
		success : function(data) {
			$j('#notices_div').html(data);
		},
		error : function(objeto, quepaso, otroobj) {
			alert("Pas� lo siguiente: refresh_notices");
		}
	});
}

/**
 * Recalcula y redibuja las medidas
 * 
 * @param data
 */
function refresh_meassures(data) {
	var randomnumber = Math.floor(Math.random() * 10000);
	$j.ajax({
		url : drawingsBasePath + "draw_meassures.jsp",
		data : data + "&number=" + randomnumber,
		success : function(data) {
			$j('#meassures_div').html(data);
			refresh_negative();
		},
		error : function(objeto, quepaso, otroobj) {
			alert("Pas� lo siguiente: refresh_meassures");
		}
	});
}

/**
 * Recalcula y redibuja los solenoides
 * 
 * @param data
 */
function refresh_solenoids(data) {
	var randomnumber = Math.floor(Math.random() * 10000);
	$j.ajax({
		url : drawingsBasePath + "draw_solenoids.jsp",
		data : data + "&number=" + randomnumber,
		success : function(data) {
			$j('#meassures_div').html(data);
			refresh_negative();
		},
		error : function(objeto, quepaso, otroobj) {
			alert("Pas� lo siguiente: draw_solenoids");
		}
	});
}

function refresh_negative() {
	$j.getJSON(updatesBasePath + 'update_negative.jsp', function(json) {
		var negativeSolenoids = "false";
		var negativeInputs = "false";
		var negativeOutputs = "false";
		$j.each(json, function(key, val) {
			if (key == "solenoids")
				negativeSolenoids = val;
			if (key == "inputs")
				negativeInputs = val;
			if (key == "outputs")
				negativeOutputs = val;
		});
		if (negativeSolenoids == "true" || negativeInputs == "true"
				|| negativeOutputs == "true") {
			refresh_notices();
		}
	});
}

/**
 * Refresca las pesta�as
 * 
 * @param selected_tab
 *            indica la pesta�a seleccionada
 */
function refresh_tabs(selected_tab) {
	var randomnumber = Math.floor(Math.random() * 10000);
	$j.ajax({
		url : drawingsBasePath + "draw_tabs.jsp",
		async : false,
		data : "number=" + randomnumber + "&selectedTab=" + selected_tab,
		success : function(data) {
			$j('#tabs_div').html(data);
			event_select_tab();
			var status = refresh_status_form_to_basket();
			refresh_group_global_variable(status);
		}
	});
}

function event_select_tab() {
	$j('.SY_tab_image_name')
			.click(
					function() {

						var currentTime = new Date();
						$j('#debug_panel').append(
								'<p>START event_select_tab: ' + currentTime
										+ '</p>');

						var tabIndex = $j(this).attr("id");
						var tabClass = $j(this).attr("class");
						var firstCellId = $j(this).attr("firstCellId");
						var message = $j(this).attr("message");
						var tabs_number = $j(this).attr("tabs_number");
						var configuration_summary = (tabs_number == 6 && tabIndex == 3)
								|| (tabs_number == 5 && tabIndex == 2);
						var bom = (tabs_number == 6 && tabIndex == 4)
								|| (tabs_number == 5 && tabIndex == 3);
						var project_information = (tabs_number == 6 && tabIndex == 5)
								|| (tabs_number == 5 && tabIndex == 4);
						if (copying) {
							copying = false;
							refresh_copying_graphic_editor_tools(tabIndex);
						}
						// Siempre que la pesta�a se pueda clicar
						if (tabClass.indexOf("no_click") == -1) {
							// Quitar la seleccionada
							$j(".selected").each(function(index, value) {
								$j(value).removeClass("selected");
							});
						}
						// A�adir la actual como seleccionada
						if (tabClass.indexOf("no_click") == -1)
							$j(this).addClass("selected");
						else
							alert(message);
						// Configuration summary
						if (configuration_summary || bom || project_information) {
							if (configuration_summary)
								load_report_panel();
							else if (project_information)
								load_project_information_panel();
							else
								load_bom_panel();
							// Deseleccionar
							$j(".graphicSelected").each(function(index, value) {
								var width = $j(value).width();
								width = width + 2;
								$j(value).width(width);
								var height = $j(value).height();
								height = height + 2;
								$j(value).height(height);
								$j(value).removeClass("graphicSelected");
							});
							// Refrescar pesta�as
							refresh_tabs(tabIndex);
							// Desactivar editor gr�fico
							refresh_graphical_editor_tools(true);
						}
						// Resto de pesta�as
						else if (tabClass.indexOf("no_click") == -1) {
							refresh_configurator_panel("selectedIdCell="
									+ firstCellId);
							select_first_element(firstCellId, tabIndex);
						}

						currentTime = new Date();
						$j('#debug_panel').append(
								'<p>END event_select_tab: ' + currentTime
										+ '</p>');
					});
}

/**
 * Selecciona en el editor grafico el primer elemento cuando hacemos click en la
 * pesta�a
 */
function select_first_element(id, tab) {
	$j(".graphicSelected").each(function(index, value) {
		var width = $j(value).width();
		width = width + 2;
		$j(value).width(width);
		var height = $j(value).height();
		height = height + 2;
		$j(value).height(height);
	});
	$j(".graphicSelected").removeClass("graphicSelected");

	$j(".ikGraphicElement").each(function(index, value) {
		var id_temp = $j(value).attr("id");
		if (id_temp == id) {
			$j(value).addClass("graphicSelected");
			var width = $j(value).width();
			width = width - 2;
			$j(value).width(width);
			var height = $j(value).height();
			height = height - 2;
			$j(value).height(height);
		}
	});
	// Cargar posibilidades de productos y cargar caracter�sticas/opciones de
	// producto
	refresh_configurator_panel("selectedIdCell=" + id);
	// Calcular la referencia
	refresh_reference();
	// Refrescar pesta�as
	refresh_tabs(tab);
}

/**
 * Carga el panel del reporte
 */
function load_report_panel() {
	var randomnumber = Math.floor(Math.random() * 10000);
	$j.ajax({
		url : drawingsBasePath + "draw_report_panel.jsp",
		async : false,
		data : "toBasket=false&number=" + randomnumber,
		success : function(data) {
			var buttons = refresh_down_buttons();
			data += buttons;
			$j('#configurator_panel_div').html(data);
			show_hidde_report_specifications();
		}
	});
}

function show_hidde_report_specifications() {
	$j(".ik_report_panel_element").click(function() {
		var minimize = $j(this).attr("minimize");
		var selected_ref = $j(this).attr("id");
		if (minimize == "true") {
			$j(this).attr("minimize", "false");
			$j(".ik_hidden_specifications").each(function(index, value) {
				var ref = $j(value).attr("id");
				if (selected_ref == ref) {
					$j(value).removeClass("ik_hidden_specifications");
					$j(value).addClass("ik_show_specifications");
				}
			});
		} else {
			$j(this).attr("minimize", "true");
			$j(".ik_show_specifications").each(function(index, value) {
				var ref = $j(value).attr("id");
				if (selected_ref == ref) {
					$j(value).removeClass("ik_show_specifications");
					$j(value).addClass("ik_hidden_specifications");
				}
			});
		}
	});
}

/**
 * Carga el panel de bom
 */
function load_bom_panel() {
	var randomnumber = Math.floor(Math.random() * 10000);
	$j.ajax({
		url : drawingsBasePath + "draw_bom_panel.jsp",
		data : "number=" + randomnumber,
		async : false,
		success : function(data) {
			var buttons = refresh_down_buttons();
			data += buttons;
			$j('#configurator_panel_div').html(data);
		}
	});
}

/**
 * Carga el panel de project information
 */
function load_project_information_panel() {
	var randomnumber = Math.floor(Math.random() * 10000);
	$j.ajax({
		url : drawingsBasePath + "draw_project_information_panel.jsp",
		data : "number=" + randomnumber,
		async : false,
		success : function(data) {
			var buttons = refresh_down_buttons();
			data += buttons;
			$j('#configurator_panel_div').html(data);
		}
	});
}

function event_ikFreeReference() {
	$j(".ik_free_reference_input").keyup(function() {
		var ref = $j(this).val();
		load_reference_free_product(ref);
	});
	$j(".ik_free_element_hidde_meassures").click(function() {
		var checked = $j(this).attr("checked");
		load_hidde_meassures_free_product(checked);
	});
}

function load_reference_free_product(ref) {
	var randomnumber = Math.floor(Math.random() * 10000);
	$j.ajax({
		url : "save_free_reference.jsp",
		async : false,
		data : "number=" + randomnumber + "&ref=" + ref,
		success : function(data) {
			refresh_graphical_editor("recalculate=0");
		}
	});
}

/**
 * Oculta las medidas de los 'free product'
 * 
 * @param hidde_meassures
 *            si est� seleccionado el elemento
 */
function load_hidde_meassures_free_product(hidde_meassures) {
	var randomnumber = Math.floor(Math.random() * 10000);
	$j.ajax({
		url : "save_free_hidde_meassures.jsp",
		async : false,
		data : "number=" + randomnumber + "&hidde=" + hidde_meassures,
		success : function(data) {
			// Refrescar medidas
			//refresh_meassures(); DESHABILITADO PARA MOSTRAR UNICAMENTE SOLENOIDES
			// Refrescar solenoides
			refresh_solenoids();
			refresh_graphical_editor("recalculate=0");
		}
	});
}

/**
 * Refresca los botones para a�adir a favoritos/basket
 */
function refresh_add_to_buttons() {
	var randomnumber = Math.floor(Math.random() * 10000);
	$j.ajax({
		url : drawingsBasePath + "draw_add_to_buttons.jsp",
		async : false,
		data : "from=" + from + "&number=" + randomnumber,
		success : function(data) {
			$j('#add_to_div').html(data);
			event_add_to();
		}
	});
}

function event_add_to() {
	$j('.ikAddToBasket').click(function() {
		$j('#ik_action_from').val('basket');
		refresh_form_to_basket();
	});

	$j('.ikAddToFavorite').click(function() {
		from = "SY";
		action = "favourites_sy";
		login_dialog();
	});
}

function enviar_a_favoritos_sy() {
	$j('#ik_action_from').val('selectFolder');
	get_image_to_db();
}

function save_document() {
	var randomnumber = Math.floor(Math.random() * 10000);
	$j.ajax({
		url : "save_document.jsp",
		async : false,
		data : "number=" + randomnumber,
		success : function(path) {
			// Tratar string recibido
			force_download(path);
		}
	});
}

function force_download(dir) {
	var randomnumber = Math.floor(Math.random() * 10000);
	window.open("force_download.jsp?file=" + dir + "&number=" + randomnumber,
			'_blank');
}

function refresh_form_to_basket() {
	var randomnumber = Math.floor(Math.random() * 10000);
	$j.ajax({
		url : "get_basket.jsp",
		async : false,
		data : "number=" + randomnumber,
		success : function(add_to_info) {
			var add_to_info_list = add_to_info.split("@hurrengoa@");
			// Tratar string recibido
			$j('#ik_part_number').val(add_to_info_list[0]);
			$j('#ik_path_catalogue').val(add_to_info_list[1]);
			$j('#ik_document').val(add_to_info_list[2]);
			$j('#ik_configurator_language').val(add_to_info_list[3]);
			// Resto de cosas
			var status = refresh_status_form_to_basket();
			refresh_group_global_variable(status);
			refresh_CADenas_to_form();
			refresh_details_form_to_basket();
		}
	});
}

/**
 * Detalles de basket
 */
function refresh_details_form_to_basket() {
	var randomnumber = Math.floor(Math.random() * 10000);
	$j.ajax({
		url : drawingsBasePath + "draw_report_panel.jsp",
		async : false,
		data : "toBasket=true&number=" + randomnumber,
		success : function(data) {
			$j('#ik_details').val(data);
			show_hidde_report_specifications();
			refresh_description_form_to_basket();
		},
		error : function(objeto, quepaso, otroobj) {
			alert("Pas� lo siguiente: refresh_details_form_to_basket -->"
					+ objeto + " " + quepaso + " " + otroobj);
		}
	});
}

function refresh_description_form_to_basket() {
	var serie_description = $j('#ik_serie_description').html();
	$j('#ik_description').val(serie_description);
	var from = $j('#ik_action_from').val();
	if (from == "basket") {
		$j('#ikFormTo')
				.attr(
						'action',
						'{VIPDEPLOYMENT_URL}/WebContent/corporative/modules/software/sy/sy_to_basket.jsp');
		$j("#ikFormTo").submit();
	} else {
		window
				.open(
						"",
						"favoritesFoldersPopUp",
						"toolbar=0,scrollbars=1,location=0,statusbar=0,menubar=0,titlebar=0,resizable=0,directories=0,width=420,height=450,left="
								+ (screen.width - 420)
								/ 2
								+ ",top="
								+ (screen.height - 450) / 2);
		$j('#ikFormTo').attr("target", "favoritesFoldersPopUp");
		$j('#ikFormTo')
				.attr(
						'action',
						'{VIPDEPLOYMENT_URL}/WebContent/corporative/modules/software/sy/sy_to_basket.jsp');
		$j("#ikFormTo").submit();
	}
}

function refresh_status_form_to_basket() {
	var yellow = false;
	var red = false;
	var status = "correct";
	$j('.ik_tab_state_image').each(function(index, value) {
		var src = $j(value).attr("src");
		if (src.indexOf("amarillo") > -1)
			yellow = true;
		else if (src.indexOf("rojo") > -1)
			red = true;
	});
	if (red) {
		$j('#ik_status').val('Invalid');
		status = "with_errors";
	} else if (yellow) {
		$j('#ik_status').val('Partial');
		status = "incomplete";
	} else
		$j('#ik_status').val('Complete');
	return status;
}

function refresh_group_global_variable(status) {
	var randomnumber = Math.floor(Math.random() * 10000);
	$j.ajax({
		url : updatesBasePath + "update_status.jsp",
		async : false,
		data : "status=" + status + "&number=" + randomnumber,
		success : function() {
			refresh_add_to_buttons();
		}
	});
}

function refresh_CADenas_to_form() {
	var CADenas_3D = $j("#ikPreviewCADenas").attr("data-dir");
	var CADenas_download = $j("#ikDownloadCADenas").attr("data-dir");
	$j('#ik_preview_3D').val(CADenas_3D);
	$j('#ik_download_CAD').val(CADenas_download);
}

function open_configuration(file) {
	var randomnumber = Math.floor(Math.random() * 10000);
	$j.ajax({
		type : 'POST',
		url : "open_configuration.jsp",
		async : false,
		data : "fConf=" + file + "&number=" + randomnumber,
		success : function() {
			refresh_graphical_editor("recalculate=1");
			refresh_graphical_editor_tools(false);
			refresh_reference();
			refresh_tabs("0");
			refresh_configurator_panel("selectedIdCell=null");
			// Comprobar avisos
			if (activated_notices)
				refresh_notices();
			// Calcular medidas
			if (activated_meassures){
				// Refrescar medidas
				//refresh_meassures(); DESHABILITADO PARA MOSTRAR UNICAMENTE SOLENOIDES
				// Refrescar solenoides
				refresh_solenoids();
			}
		}
	});
}

function crear_carpeta_popup(origen, id_producto) {
	// Si se ha elegigo m�s de una carpeta no se puede crear nueva carpeta
	if (document.getElementById("txtCheckSelect").value.indexOf(',') != -1) {
		alert(txt_45_lbl_010);
	} else {
		// El id viene asi: 8-0 (id_carpeta-id_carpeta_padre)
		var id_tmp = document.getElementById("txtCheckSelect").value;
		// Si es carpeta hijo no se puede crear otra carpeta dentro de ella
		if ((id_tmp.indexOf('-0') == -1)
				&& (document.getElementById("txtCheckSelect").value != "")) {
			alert(txt_45_lbl_011);
		}
		// Se quiere crear una carpeta padre o una carpeta hijo dentro de un
		// padre
		else {
			// Se quiere crear una carpeta padre
			var idCarpeta = -1;
			var idPadre = -1;
			// Se quiere crear una carpeta hijo debajo de padre
			if (id_tmp != '') {
				var idFolder = id_tmp.split('-');
				idCarpeta = idFolder[0];
				idPadre = idFolder[1];
				// Dentro de carpeta Default no se pueden crear hijos
				if ((idCarpeta == 0) && (idPadre == 0)) {
					idCarpeta = -1;
					idPadre = -1;
					alert(txt_45_lbl_024);
				} else {
					if (idPadre == 0)
						idPadre = idCarpeta;
				}
			}
			self.location.href = 'popup_new_folder_sy.jsp?idCarpeta='
					+ idCarpeta + '&idPadre=' + idPadre + '&idProducto='
					+ id_producto + '&origen=' + origen;
		}
	}
}

function enviarDatosPopSY(idProd) {
	if (document.getElementById("txtCheckSelect").value == "") {
		alert(txt_48_lbl_010);
	} else {
		if (document.getElementById("txtCheckSelect").value.indexOf(',') != -1) {
			alert(txt_48_lbl_011);
		} else {
			var operacion = "carpetasPopup";
			var elemOperacion = document.getElementById("txtOperacion");
			elemOperacion.value = operacion;
			var id_tmp = document.getElementById("txtCheckSelect").value;
			var idFolder = id_tmp.split('-');
			var idCarpeta = idFolder[0];
			var elemCarpeta = document.getElementById("txtIdCarpetaGuardar");
			elemCarpeta.value = idCarpeta;
			var elemIdProd = document.getElementById("txtIdProducto");
			elemIdProd.value = idProd;
			document.form1.submit();
		}
	}
}

function cerrarVentana(source, id) {
	window.close();
}

function onCheckCheckedCarpetas(CheckID) {

	var elemento = document.getElementById(CheckID);
	if (elemento.checked) {
		var lista = document.getElementById("txtCheckSelect");
		var cadena = lista.value;
		var id = CheckID.toString();
		id = id.replace("check", "");
		if (cadena == "")
			cadena = cadena + id;
		else
			cadena = cadena + "," + id;
		lista.value = cadena;
	}
	if (!elemento.checked) {
		var lista = document.getElementById("txtCheckSelect");
		var cadena = lista.value;
		var id = CheckID.toString();
		id = id.replace("check", "");
		cadena = cadena.replace(id, "");
		cadena = cadena.replace(",,", ",");
		var inicio = cadena.substring(0, 1);
		if (inicio == ",")
			cadena = cadena.substring(1);
		var fin = cadena.substring(cadena.length - 1, cadena.length);
		if (fin == ",")
			cadena = cadena.substring(0, cadena.length - 1);
		lista.value = cadena;
	}
}

function open_select_folder() {
	$j('#ik_action_from').val('selectFolder');
	refresh_form_to_basket();
}

function get_image_to_db() {
	var randomnumber = Math.floor(Math.random() * 10000);
	$j.ajax({
		url : "getImage2.jsp",
		async : false,
		data : "number=" + randomnumber,
		success : function(data) {
			data = data.replace(/(^\s*)|(\s*$)/g, ""); // Quitar espacios
			$j('#ik_product_specifications').val(data);
			refresh_form_to_basket();
		},
		error : function(objeto, quepaso, otroobj) {
			alert("Pas� lo siguiente: get_image_to_db -->" + objeto + " "
					+ quepaso + " " + otroobj);
		}
	});
}

/* iFrame */
function initialize_configuration_summary() {
	$("#ik_show_configuration_summary").overlay({
		onBeforeLoad : function(event) {
			// grab wrapper element inside content
			var wrap = this.getOverlay().find(".contentWrap");
			// load the page specified in the trigger
			wrap.load("configuration_summary.jsp");
		},
		top : "center",
		mask : {
			color : "#ebecff",
			loadSpeed : 200,
			opacity : 0.4
		},
		closeOnClick : false
	});
}

function get_configuration_summary() {
	$j.ajax({
		type : "POST",
		url : "configuration_summary.jsp",
		dataType : "html",
		async : false,
		success : function(msg) {
			$j("#configurationSummaryContainer").contents().find(
					".configuration_summary_request").html(msg);
		},
		error : function(objeto, quepaso, otroobj) {
			alert("ERROR en get_configuration_summary: " + quepaso);
		}
	});
}

/* Reset */
function reset() {
	$j("#ik_reset_default").click(function() {
		var product = $j(this);
		var type = product.attr("data-product-type");
		reset_product(type);
	});
}

function reset_product(type) {
	var randomnumber = Math.floor(Math.random() * 10000);
	$j.ajax({
		url : "reset_default.jsp",
		async : false,
		data : "type=" + type + "&number=" + randomnumber,
		success : function() {
			refresh_tabs();
			refresh_graphical_editor("recalculate=true");
			refresh_graphical_editor_tools();
			refresh_add_to_buttons();
			// Refrescar medidas
			//refresh_meassures(); DESHABILITADO PARA MOSTRAR UNICAMENTE SOLENOIDES
			// Refrescar solenoides
			refresh_solenoids();
			refresh_negative();
			refresh_notices();
			refresh_reference();
			refresh_configurator_panel();
		},
		error : function(objeto, quepaso, otroobj) {
			alert("Pas� lo siguiente: reset_product -->" + objeto + " "
					+ quepaso + " " + otroobj);
		}
	});
}

// CADenas
function CADenas() {
	$j("#ikPreviewCADenas").click(
			function() {
				var current = $j(this);
				if (!current.hasClass('dc_disabledIcon')) {
					var url = $j(this).attr("data-dir");
					window.open(url, "preview3D_CADENAS",
							"scrollbars=no,resizable=no,status=yes,width=440,height=315,left="
									+ (screen.width - 440) / 2 + ",top="
									+ (screen.height - 315) / 2);
				}
			});
	$j("#ikDownloadCADenas").click(function() {
		var current = $j("#ikDownloadCADenas img");
		if (!current.hasClass('dc_disabledIcon')) {
			var url = $j(this).attr("data-dir");
			$j(this).attr("href", url);
		}
	});
	$j("#ikEmailCADenas").click(function() {
		var current = $j("#ikEmailCADenas img");
		if (!current.hasClass('dc_disabledIcon')) {
			var url = $j(this).attr("data-dir");
			$j(this).attr("href", url);
		}
	});
}

// Ask SMC
function askSMC() {
	$("img[src*=ask_SMC_about_btn.gif].dc_productToolbarBtn").click(
			function() {
				$("#askSMCAboutContainer").contents().find(
						".askSMCAboutResponse").html("");
				$("#askSMCAboutContainer").contents().find(
						".askSMCAboutResponse").hide();
				$("#askSMCAboutContainer").contents().find(
						".askSMCAboutRequest").show();

			});

	$("img[src*=ask_SMC_about_btn.gif].dc_productToolbarBtn").overlay(
			{
				onBeforeLoad : function(event) {
					var event_trigger = getEventTrigger(event);
					var product_img = $(event_trigger).attr("product_img");
					var product_name = $(event_trigger).attr("product_name");
					var part_number = "";

					if (product_img != undefined)
						$("#askSMCAboutContainer").contents().find(
								".askSMCAboutImg").html(
								'<img src="' + product_img + '"/>');
					$("#askSMCAboutContainer").contents().find(
							":input[name='askSMCAbout_product_img']",
							".askSMCAboutForm").val(product_img);
					if (part_number == "") {
						$("#askSMCAboutContainer").contents().find(
								".askSMCAboutTitle").html(
								"<h3>" + ask_SMC_about_lbl + "<br/>"
										+ product_name + "</h3>");
						$("#askSMCAboutContainer").contents().find(
								":input[name='askSMCAbout_product_name']",
								".askSMCAboutForm").val(product_name);
					} else {
						$("#askSMCAboutContainer").contents().find(
								".askSMCAboutTitle").html(
								"<h3>" + ask_SMC_about_lbl + "<br/>"
										+ product_name + " - " + partnumber_lbl
										+ ": " + part_number + "</h3>");
						$("#askSMCAboutContainer").contents().find(
								":input[name='askSMCAbout_product_name']",
								".askSMCAboutForm").val(
								product_name + " - " + partnumber_lbl + ": "
										+ part_number);
					}

				},
				top : "center",
				mask : {
					color : "#ebecff",
					loadSpeed : 200,
					opacity : 0.4
				},
				closeOnClick : false
			});
}

function getEventTrigger(event) {
	var event_trigger = null;
	if (event.srcElement != undefined) {
		event_trigger = event.srcElement;
	} else if (event.originalEvent.originalTarget != undefined) {
		event_trigger = event.originalEvent.originalTarget;
	}
	return event_trigger;
}

function PDF() {
	$j("#ikPDF").click(function() {
		export_to_pdf();
	});
}

function Esheet() {
	$j("#ikEsheet").click(function() {
		export_to_excel();
	});
}

function export_to_pdf() {
	var randomnumber = Math.floor(Math.random() * 10000);
	$j.ajax({
		url : "export_to_pdf.jsp",
		async : false,
		data : "number=" + randomnumber,
		success : function(url) {
			window.open(url, '_blank');
		},
		error : function(objeto, quepaso, otroobj) {
			alert("Pas� lo siguiente: export_to_pdf -->" + objeto + " "
					+ quepaso + " " + otroobj);
		}
	});
}

function export_to_excel() {
	var randomnumber = Math.floor(Math.random() * 10000);
	$j.ajax({
		url : "export_to_excel.jsp",
		async : false,
		data : "number=" + randomnumber,
		success : function(url) {
			window.open(url, '_blank');
		},
		error : function(objeto, quepaso, otroobj) {
			alert("Pas� lo siguiente: export_to_excel -->" + objeto + " "
					+ quepaso + " " + otroobj);
		}
	});
}