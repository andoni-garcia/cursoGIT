var GraphicalToolsController = Class
		.extend({
			init : function(stMach, sessionState) {
				this.stateMachine = stMach;

				// Subscribe to events
				stMach.eventBus.subscribeTo(
						stMach.eventBus.eventList.onStateChange, {
							object : this,
							callback : this._refresh
						});
				stMach.eventBus.subscribeTo(
						stMach.eventBus.eventList.afterCharacteristicChange, {
							object : this,
							callback : this._refresh
						});
				stMach.eventBus.subscribeTo(
						stMach.eventBus.eventList.afterGraphicalElementClick, {
							object : this,
							callback : this.afterGraphicalElementClick
						});
				stMach.eventBus.subscribeTo(
						stMach.eventBus.eventList.afterTabClick, {
							object : this,
							callback : this._refresh
						});
				stMach.eventBus.subscribeTo(
						stMach.eventBus.eventList.graphicalEditorRefreshed, {
							object : this,
							callback : this._refresh
						});
				stMach.eventBus.subscribeTo(
						stMach.eventBus.eventList.afterAddProductClick, {
							object : this,
							callback : this.afterAddProductClick
						});
				stMach.eventBus.subscribeTo(
						stMach.eventBus.eventList.graphicalEditorRefreshed, {
							object : this,
							callback : this._refresh
						});
				stMach.eventBus.subscribeTo(
						stMach.eventBus.eventList.onResetClick, {
							object : this,
							callback : this._resetChanges
						});

				// Set all click handlers
				stMach.jQueryCache['brushTool'].bind('click', {
					object : this
				}, this.onBrushClicked);
				stMach.jQueryCache['meassuresTool'].bind('click', {
					object : this
				}, this.onMeassuresClicked);
				stMach.jQueryCache['configurationPanelInputs'].bind('change', {
					object : this
				}, this.onConfigurationChanged);
				stMach.jQueryCache['moveLeftTool'].bind('click', {
					object : this
				}, this.onMoveLeftClicked);
				stMach.jQueryCache['moveRightTool'].bind('click', {
					object : this
				}, this.onMoveRightClicked);
				stMach.jQueryCache['addStationTool'].bind('click', {
					object : this
				}, this.onAddStationClicked);
				stMach.jQueryCache['deleteStationTool'].bind('click', {
					object : this
				}, this.onDeleteStationClicked);
				stMach.jQueryCache['deleteProductTool'].bind('click', {
					object : this
				}, this.onDeleteProductClicked);
				stMach.jQueryCache['undoActionTool'].bind('click', {
					object : this
				}, this.onUndoActionClicked);
				stMach.jQueryCache['redoActionTool'].bind('click', {
					object : this
				}, this.onRedoActionClicked);
				stMach.jQueryCache['saveConfigurationTool'].bind('click', {
					object : this
				}, this.onSaveConfigurationClick);
				stMach.jQueryCache['exportSpecificationsTool'].bind('click', {
					object : this
				}, this.onExportSpecificationsClick);
				stMach.jQueryCache['checkTool'].bind('click', {
					object : this
				}, this.onCheckClicked);

				this.actions = sessionState.changesList.actions;
				this.currActionIndex = sessionState.changesList.current_index;
				if (sessionState.currentState == 'selecting_for_copy') {
					this.cellFromCopyId = sessionState.copyingCellId;
					if (sessionState.selectedTab == '2') {
						if (sessionState.copyingElem == 'input_element') {
							this.stateMachine.jQueryCache["sprGraphEditor"]
									.find("div.input_element").addClass(
											"copy_active");
						} else if (sessionState.copyingElem == 'output_element') {
							this.stateMachine.jQueryCache["sprGraphEditor"]
									.find("div.output_element").addClass(
											"copy_active");
						} else {
							this.stateMachine.jQueryCache["sprGraphEditor"]
									.find(
											"div[tab='"
													+ sessionState.selectedTab
													+ "']").addClass(
											"copy_active");
						}
					} else {
						this.stateMachine.jQueryCache["sprGraphEditor"].find(
								"div[tab='" + sessionState.selectedTab + "']")
								.addClass("copy_active");
					}
				}
				this._refresh();
			},
			/*
			 * 'ASYNCHRONOUSITY' SETTINGS BY METHOD
			 */
			_ajaxAsyncSettings : {
				_refreshCopyingGraphicEditorTools : false,
				_meassures : false,
				_cleanMeassures : false,
				_copy : false,
				_move : false,
				_addCell : false,
				_deleteCell : false,
				_deleteProductCell : false,
				_undoAction : false,
				_redoAction : false
			},
			/*
			 * GRAPHIC TOOLS REFRESHING FUNCTIONS
			 */
			_resetChanges : function() {
				this.actions = [];
				this.currActionIndex = 0;
			},
			afterAddProductClick : function() {
				this.addAction('addProduct');
			},
			afterGraphicalElementClick : function(id) {
				if (this.stateMachine.isSelectingForCopying()) {
					var _id = id;
					var _elem = document.getElementById(id);
					if (_elem.hasAttribute('copy_id'))
						_id = _elem.getAttribute('copy_id');
					var elemIndex = _.indexOf(this.copyBuffer.toIds, _id);
					if (elemIndex == -1) {
						this.copyBuffer.fromIds.push(this.cellFromCopyId);
						this.copyBuffer.toIds.push(_id);
					} else {
						this.copyBuffer.fromIds.splice(elemIndex, 1);
						this.copyBuffer.toIds.splice(elemIndex, 1);
					}
				} else {
					this._refresh();
				}
			},
			refreshButtons : function() {
				this._refresh();
			},
			_refresh : function(selectedIsFirst, selectedIsLast, deleteActive) {
				console.log("_refresh");
				var currGraphToolsActions = this.stateMachine
						.getCurrentActions('graphical_tools');
				var myTools = this.stateMachine.constants.actionGroups.graphical_tools.actions;
				var removeStation = true;
				var addStation = true;
				if (typeof selectedIsFirst != 'boolean'
						|| typeof selectedIsLast != 'boolean') {
					var _selectedElem = this.stateMachine.jQuery('.'
							+ this.stateMachine.selClass + ':first');
					selectedIsFirst = _selectedElem.data('first');
					selectedIsLast = _selectedElem.data('last');
					deleteActive = _selectedElem.data('remGrp');
				}

				var minMax = this.stateMachine._getMaxMin();

				var sel = this.stateMachine.jQuery('.selected');

				if (sel.hasClass('valves') || sel.hasClass('base_plate')
						|| sel.hasClass('base_plate')
						|| sel.hasClass('block_disk')
						|| sel.hasClass('intermediate_level')) {
					var visible = this.stateMachine.jQueryCache['sprGraphEditor']
							.data('stations');
					if (minMax.minStations >= visible)
						removeStation = false;
					if (minMax.maxStations <= visible)
						addStation = false;
				} else if (sel.hasClass('input_element')) {
					var visible = this.stateMachine.jQueryCache['sprGraphEditor']
							.data('inputs');
					if (minMax.minInputs >= visible)
						removeStation = false;
					if (minMax.maxInputs <= visible)
						addStation = false;
				} else if (sel.hasClass('output_element')) {
					var visible = this.stateMachine.jQueryCache['sprGraphEditor']
							.data('outputs');
					if (minMax.minOutputs >= visible)
						removeStation = false;
					if (minMax.maxOutputs <= visible)
						addStation = false;
				} else if (sel.hasClass('mixed_element')) {
					var visible = this.stateMachine.jQueryCache['sprGraphEditor']
							.data('mixeds');
					if (minMax.minMixed >= visible)
						removeStation = false;
					if (minMax.maxMixed <= visible)
						addStation = false;
				}

				if (this.stateMachine.closedConfiguration == 'false') {
					for (var index = 0; index < myTools.length; index++) {
						var refreshed = false;
						if (this.stateMachine.currentElement != 'manifold') {
							// Special actions
							if (myTools[index] == 'moveLeft' && selectedIsFirst) {
								this._doRefresh(myTools[index], false);
								refreshed = true;
							}
							if (myTools[index] == 'moveRight' && selectedIsLast) {
								this._doRefresh(myTools[index], false);
								refreshed = true;
							}
							if (myTools[index] == 'deleteProduct'
									&& !deleteActive) {
								this._doRefresh(myTools[index], false);
								refreshed = true;
							}
						}
						if (myTools[index] == 'meassures'&& this.stateMachine.currentState != 'selecting_for_copy') {
							this._doRefresh(myTools[index], true);
							refreshed = true;
						} else if (myTools[index] == 'meassures') {
							this._doRefresh(myTools[index], false);
							refreshed = true;
							$("#meassures_div").html("");
						}
						if (myTools[index] == 'undoAction'
								&& (this.currActionIndex <= 0 || this.actions.length == 0)) {
							this._doRefresh(myTools[index], false);
							refreshed = true;
						}
						if (myTools[index] == 'redoAction'
								&& (this.currActionIndex < 0 || this.currActionIndex >= this.actions.length)) {// 'moveLeft','moveRight'
							this._doRefresh(myTools[index], false);
							refreshed = true;
						}
						if (myTools[index] == 'addStation' && !addStation) {
							this._doRefresh(myTools[index], false);
							refreshed = true;
						}
						if (myTools[index] == 'deleteStation' && !removeStation) {
							this._doRefresh(myTools[index], false);
							refreshed = true;
						}
						if (myTools[index] == 'brush' && typeof currGraphToolsActions !== typeof true) {	
							refreshed = true;
						}
						// Rest of actions
						if (!refreshed) {
							if (typeof currGraphToolsActions[myTools[index]] != 'undefined')
								this._doRefresh(myTools[index],
										currGraphToolsActions[myTools[index]]);
							else if (typeof currGraphToolsActions['_default'] != 'undefined')
								this._doRefresh(myTools[index],
										currGraphToolsActions['_default']);
							else
								this._doRefresh(myTools[index],
										currGraphToolsActions);
						}
					}
				}
			},

			_doRefresh : function(name, value) {
				var fn = value ? '_enable' : '_disable';
				fn += name.charAt(0).toUpperCase() + name.substring(1);
				this[fn].call(this);
			},
			/*
			 * HANDLERS
			 */
			onBrushClicked : function(e) {
				var self = e.data.object;

				if (self.stateMachine._hasClass(this, 'disabled'))
					return false;

				// Activa desactiva resto de opciones
				self.stateMachine.eventBus.fireEvent('onBrushClick');

				// Qu� tipo de elemento se va a copiar
				var selectedTab = self.stateMachine.jQuery(
						"." + self.stateMachine.selClass).attr("tab");

				// Saber si se est� o no copiando
				var copying = self.stateMachine.isSelectingForCopying();

				var selectedId = self.stateMachine.jQuery(
						"." + self.stateMachine.selClass).attr("id");

				// Actualizar la variable 'copying' y la
				// habilitaci�n/deshabilitaci�n de las herramientas gr�ficas
				// self._refreshCopyingGraphicEditorTools(selectedTab, copying,
				// selectedId);

				var copyCommited = true;

				if (!copying) {
					self.stateMachine.jQuery('#brush').removeClass('active');
					self.stateMachine.jQuery('#sy-simple-especial').removeClass('disabled');
					valveConfigurationViewModel.copying(false);
					bufferLength = self.copyBuffer.toIds.length;
					self.cellFromCopyId = null;
					self.stateMachine.jQueryCache['sprGraphEditor'].find(
							'.copy_active').removeClass("copy_active");
					if (self.copyBuffer.toIds.length > 0) {
						self._copy();
					} else {
						copyCommited = false;
					}
				} else {
					self.stateMachine.jQuery('#brush').addClass('active');
					self.stateMachine.jQuery('#sy-simple-especial').addClass('disabled');
					valveConfigurationViewModel.copying(true);
					// Obtener la celda en caso de tener que copiar
					self.cellFromCopyId = selectedId;
					if (selectedTab == '2') {
						var $elem = self.stateMachine.jQuery(document
								.getElementById(self.cellFromCopyId));
						if ($elem.hasClass('input_element')) {
							self.stateMachine.jQueryCache["sprGraphEditor"]
									.find("div.input_element").addClass(
											"copy_active");
						} else if ($elem.hasClass('output_element')) {
							self.stateMachine.jQueryCache["sprGraphEditor"]
									.find("div.output_element").addClass(
											"copy_active");
						} else {
							self.stateMachine.jQueryCache["sprGraphEditor"]
									.find("div[tab='" + selectedTab + "']")
									.addClass("copy_active");
						}
					} else {
						self.stateMachine.jQueryCache["sprGraphEditor"].find(
								"div[tab='" + selectedTab + "']").addClass(
								"copy_active");
					}
				}

				if (copyCommited) {
					self.stateMachine.eventBus.fireEvent('afterBrushClick');
					self._refresh();
				} else {
					self.stateMachine.eventBus
							.fireEvent('afterUncommitedBrushClick');
				}
			},
			onMeassuresClicked : function(e) {
				var self = e.data.object;

				if (self.stateMachine._hasClass(this, 'disabled'))
					return false;

				self.stateMachine.eventBus.fireEvent('onMeassuresClick');

				self._meassures(true);

				self.stateMachine.eventBus.fireEvent('afterMeassuresClick');
				self._refresh();
			},
			onConfigurationChanged : function(e) {
				var self = e.data.object;

				if (self.stateMachine._hasClass(this, 'disabled'))
					return false;

				self.stateMachine.eventBus.fireEvent('onConfigurationChange');
				self.stateMachine.eventBus
						.fireEvent('afterConfigurationChange');
				self._refresh();
			},
			onMoveLeftClicked : function(e) {
				var self = e.data.object;

				if (self.stateMachine._hasClass(this, 'disabled'))
					return false;

				var cellToMoveId = self.stateMachine.jQuery(
						"." + self.stateMachine.selClass).attr("id");

				var move = self._move(cellToMoveId, true)
				if(move) {
					console.log("if _move");

					self.stateMachine.eventBus.fireEvent('onMoveLeftClick', [
						cellToMoveId, true ]);

					self.stateMachine.eventBus.fireEvent('afterMoveLeftClick', [
							cellToMoveId, true ]);
					self._refresh();
				}
			},
			onMoveRightClicked : function(e) {
				var self = e.data.object;

				if (self.stateMachine._hasClass(this, 'disabled'))
					return false;

				var cellToMoveId = self.stateMachine.jQuery(
						"." + self.stateMachine.selClass).attr("id");
				
				var move = self._move(cellToMoveId, false);
				if(move) {
					console.log("if _move");

					self.stateMachine.eventBus.fireEvent('onMoveRightClick', [
						cellToMoveId, false ]);

					self.stateMachine.eventBus.fireEvent('afterMoveRightClick', [
							cellToMoveId, false ]);
					self._refresh();
				}
			},
			onAddStationClicked : function(e) {
				var self = e.data.object;

				if (self.stateMachine._hasClass(this, 'disabled'))
					return false;

				self.stateMachine.eventBus.fireEvent('onAddStationClick');

				var cellToAddId = self.stateMachine.jQuery(
						"." + self.stateMachine.selClass).attr("id");
				var d = self._addCell(cellToAddId);

				self.stateMachine.eventBus.fireEvent('afterAddStationClick',
						[ d ]);
				self._refresh();
			},
			onDeleteStationClicked : function(e) {
				var self = e.data.object;

				if (self.stateMachine._hasClass(this, 'disabled'))
					return false;

				self.stateMachine.eventBus.fireEvent('onDeleteStationClick');

				self.stateMachine.deleting = true;

				var selectedItem = self.stateMachine.jQuery("."
						+ self.stateMachine.selClass);
				var cellToDeleteId = selectedItem.attr("id");
				var data = self._deleteCell(cellToDeleteId);
				console.log("cellToDeleteId");
				console.log(cellToDeleteId)
				console.log(data)

				self.stateMachine.eventBus.fireEvent('afterDeleteStationClick',
						[ data ]);
				self.stateMachine.deleting = false;
				self._refresh();
			},
			onDeleteProductClicked : function(e) {
				var self = e.data.object;

				if (self.stateMachine._hasClass(this, 'disabled'))
					return false;

				self.stateMachine.eventBus.fireEvent('onDeleteProductClick');

				self._deleteProductCell();

				self.stateMachine.eventBus.fireEvent('afterDeleteProductClick');
				self._refresh();
			},
			onUndoActionClicked : function(e) {
				var self = e.data.object;

				if (self.stateMachine._hasClass(this, 'disabled'))
					return false;

				self.stateMachine.eventBus.fireEvent('onUndoActionClick');

				var data = self._undoAction();

				self.stateMachine.eventBus.fireEvent('afterUndoActionClick',
						[ data ]);
				self._refresh();
			},
			onRedoActionClicked : function(e) {
				var self = e.data.object;

				if (self.stateMachine._hasClass(this, 'disabled'))
					return false;

				self.stateMachine.eventBus.fireEvent('onRedoActionClick');

				var data = self._redoAction();

				self.stateMachine.eventBus.fireEvent('afterRedoActionClick',
						[ data ]);
				self._refresh();
			},
			onSaveConfigurationClick : function(data) {
				// TODO ....
				this.stateMachine.jQuery.ajax({
					url : saveConfigurationURL,
					data : data,
					dataType : 'json',
					success : function(data) {
						alert("sucess");
					},
					error : function(err) {
						console.log(err)
					}

				});

			},
			_check : function(data) {
				var self = this;

				console.log("Entra en funcion _check @ StateMachine.js ");
				this.jQuery
						.ajax({
							url : checkValveConfiguration,
							async : this._ajaxAsyncSettings._check,
							data : data,
							dataType : 'json',
							success : function(data) {
								if (typeof data !== 'undefined'
										&& typeof data['ERRORES_CONFIGURACION'] !== 'undefined') {
									self.messages['ERRORES_CONFIGURACION'] = data['ERRORES_CONFIGURACION'];
								}
								self.stateMachine.isIncompatible = data['group_state_incomplete'];
							}
						});
			},
			onCheckClicked : function(e) {
				var self = e.data.object;

				if (self.stateMachine._hasClass(this, 'disabled'))
					return false;

				self.stateMachine.eventBus.fireEvent('onCheckClick');

				// TODO Do stuff...

				self.stateMachine.eventBus.fireEvent('afterCheckClick');
			},
			/*
			 * ACTION METHODS
			 */

			// @Xabier:
			// Esta funcion en un principio ya no es necesaria, ya que su unica
			// funcion en la version vieja era setear en session variables.
			// El servicio nuevo no requiere de esta funcionalidad, ya que no es
			// necesario hacer ningun tipo de set en sesion.
			// Las funciones que he hecho en el servicio están parametrizadas
			// para evitar hacer uso de esta funcion.
			_refreshCopyingGraphicEditorTools : function(selectedTab, copying,
					selectedId) {
				var $elem = this.stateMachine.jQuery(document
						.getElementById(selectedId));
				var clazz = '';
				if ($elem.hasClass('input_element'))
					clazz = 'input_element';
				else if ($elem.hasClass('output_element'))
					clazz = 'output_element';
				else if ($elem.hasClass('stations'))
					clazz = 'stations';
				else if ($elem.hasClass('mixed_element'))
					clazz = 'mixed_element';

				var randomnumber = Math.floor(Math.random() * 10000);
				var self = this;
				$j
						.ajax({
							url : this.graphToolsBasePath
									+ "update_copying.jsp?rn=" + randomnumber,
							async : this._ajaxAsyncSettings._refreshCopyingGraphicEditorTools,
							data : "copying=" + copying + "&copyingTab="
									+ selectedTab + "&sy_copying_cell_id="
									+ selectedId + "&copying_elem=" + clazz,
							success : function(data) {
							},
							error : function(objeto, quepaso, otroobj) {
								self.stateMachine._ajaxError(
										'GraphicalToolsController',
										'_refreshCopyingGraphicEditorTools',
										objeto, quepaso, otroobj);
							}
						});
			},

			// es necesario codificar para evitar el error the valid characters
			// are defined in rfc 7230 and rfc 3986
			// ya que se están pasando simbolos que no acepta []
			_copy : function() {

				var self = this;
				self._cleanMeassures();
				if (this.copyBuffer.fromIds.length > 0) {
					var data = {
						cellFromCopyId : (this.copyBuffer.fromIds.join(";")),
						cellToCopyId : (this.copyBuffer.toIds.join(";")),

					};
					this.stateMachine.jQuery.ajax({
						url : copyURL,// graphToolsBasePath + "copy.jsp?rn=" +
										// randomnumber,
						data : data,
						type : 'POST',
						async : this._ajaxAsyncSettings._copy,
						beforeSend : function(xhr) {
							xhr.setRequestHeader('X-CSRF-Token', csrfToken)
						},
						success : function(data) {
							self.stateMachine._check();

							if(data && data != "") {
								var list = JSON.parse(data);

								if(list && list.length > 0) {
									var info = modalErrorCopyingLabels.message;
									list.forEach(element => info += "<p>" + modalErrorCopyingLabels.station + ": " + element + "</p>");

									createConfirmDialog('modal-component',
									modalErrorCopyingLabels.title,
									info,
									modalSaveConfirmationLabels.close, null, false).then(function() {console.log("message")});							
								}
							}
						},
						error : function(objeto, quepaso, otroobj) {
							self._refresh();
							self.stateMachine._ajaxError(
									'GraphicalToolsController', '_copy',
									objeto, quepaso, otroobj);
							smc.NotifyComponent.error(globalError);
						}
					});
					var copiedElems = this.copyBuffer.toIds.length;
					this.copyBuffer.fromIds = [];
					this.copyBuffer.toIds = [];
					this.addAction('copy');
				}
			},
			_meassures : function() {

				console.log("_meassures");
				var self = this;
				this.stateMachine.jQuery.ajax({
					url : drawMeassuresURL,
					async : this._ajaxAsyncSettings._meassures,
					dataType : 'html',
					success : function(data) {
						$("#meassures_div").html(data);
					},
					error : function(objeto, quepaso, otroobj) {
						self.stateMachine._ajaxError(
								'GraphicalToolsController', '_meassures',
								objeto, quepaso, otroobj);
					}
				});
				this.addAction('meassures');
			},
			_cleanMeassures : function(){
				console.log("_cleanMeassures");
				$("#meassures_div").html("");
			},
			// es necesario codificar para evitar el error the valid characters
			// are defined in rfc 7230 and rfc 3986
			// ya que se están pasando simbolos que no acepta []
			_move : function(cellToMoveId, rightToLeft) {
				console.log("entra en GraphicalToolsController.js @ _move");

				var moveDone = true;

				var self = this;
				self._cleanMeassures();
				this.stateMachine.jQuery.ajax({
					url : move,// graphToolsBasePath + "move.jsp?rn=" +
								// randomnumber,
					data : "cellToMoveId=" + encodeURI(cellToMoveId)
							+ "&rightToLeft=" + encodeURI(rightToLeft),
					async : this._ajaxAsyncSettings._move,
					success : function(data) {
						self.stateMachine._check();
						self.addAction('move');
					},
					error : function(objeto, quepaso, otroobj) {
						self._refresh();
						self.stateMachine._ajaxError(
								'GraphicalToolsController', '_move', objeto,
								quepaso, otroobj);
						smc.NotifyComponent.error(globalError);
						moveDone = false;
					}
				});
				return moveDone;
			},

			// es necesario codificar para evitar el error the valid characters
			// are defined in rfc 7230 and rfc 3986
			// ya que se están pasando simbolos que no acepta []
			_addCell : function(cellToAdd) {

				var d = '';
				var self = this;
				self._cleanMeassures();
				this.stateMachine.jQuery.ajax({
					url : addStation,// graphToolsBasePath + "add.jsp?rn=" +
										// randomnumber,
					data : "cellToAdd=" + encodeURI(cellToAdd),
					async : this._ajaxAsyncSettings._addCell,
					success : function(data) {
						d = data;
						
						self._refresh();
					},
					error : function(objeto, quepaso, otroobj) {
						self._refresh();
						self.stateMachine._ajaxError(
								'GraphicalToolsController', '_addCell', objeto,
								quepaso, otroobj);
						smc.NotifyComponent.error(globalError);
					}
				});
				this.addAction('add');
				return d;
			},

			// es necesario codificar para evitar el error the valid characters
			// are defined in rfc 7230 and rfc 3986
			// ya que se están pasando simbolos que no acepta []
			_deleteCell : function(cellToDeleteId) {

				var d = '';
				var self = this;
				self._cleanMeassures();
				this.stateMachine.jQuery.ajax({
					url : deleteStationURL,// graphToolsBasePath +
											// "delete.jsp?rn=" + randomnumber,
					data : "cellToDeleteId=" + encodeURI(cellToDeleteId),
					async : this._ajaxAsyncSettings._deleteCell,
					success : function(data) {
						d = data;
						//self.stateMachine._check();
						self._refresh();
					},
					error : function(objeto, quepaso, otroobj) {
						self._refresh();
						self.stateMachine._ajaxError(
								'GraphicalToolsController', '_deleteCell',
								objeto, quepaso, otroobj);
						smc.NotifyComponent.error(globalError);
					}
				});
				this.addAction('delete');
				return d;
			},
			_deleteProductCell : function() {

				var self = this;
				self._cleanMeassures();
				this.stateMachine.jQuery
						.ajax({
							url : deleteProductURL,// graphToolsBasePath +
													// "delete_product.jsp?rn="
													// + randomnumber,
							async : this._ajaxAsyncSettings._deleteProductCell,
							success : function(data) {
								self._refresh();
							},
							error : function(objeto, quepaso, otroobj) {
								self._refresh();
								self.stateMachine._ajaxError(
										'GraphicalToolsController',
										'_deleteProductCell', objeto, quepaso,
										otroobj);
								smc.NotifyComponent.error(globalError);
							}
						});
				this.addAction('deleteProduct');
			},
			_undoAction : function() {

				var self = this;
				self._cleanMeassures();
				var d;
				this.stateMachine.jQuery.ajax({
					url : undoURL,// graphToolsBasePath + "undo.jsp?rn=" +
									// randomnumber,
					async : this._ajaxAsyncSettings._undoAction,
					success : function(characteristic_option) {
						d = characteristic_option;
						self._refresh();
					},
					error : function(objeto, quepaso, otroobj) {
						self._refresh();
						self.stateMachine._ajaxError(
								'GraphicalToolsController', '_undoAction',
								objeto, quepaso, otroobj);
						smc.NotifyComponent.error(globalError);
					}
				});
				this.currActionIndex--;
				return d;
			},
			_redoAction : function() {
				var self = this;
				self._cleanMeassures();
				var d;
				this.stateMachine.jQuery.ajax({
					url : redoURL,// graphToolsBasePath + "redo.jsp?rn=" +
									// randomnumber,
					async : this._ajaxAsyncSettings._redoAction,
					success : function(characteristic_option) {
						d = characteristic_option;
						self._refresh();
					},
					error : function(objeto, quepaso, otroobj) {
						self._refresh();
						self.stateMachine._ajaxError(
								'GraphicalToolsController', '_redoAction',
								objeto, quepaso, otroobj);
						smc.NotifyComponent.error(globalError);
					}
				});
				this.currActionIndex++;
				return d;
			},
			_saveConfigurationAction : function() {
				var self = this;
				var d;
				this.stateMachine.jQuery.ajax({
					url : saveConfigurationURL,// graphToolsBasePath +
												// "redo.jsp?rn=" +
												// randomnumber,
					async : this._ajaxAsyncSettings._saveConfigurationAction,
					success : function(characteristic_option) {
						d = characteristic_option;
						self._refresh();
					},
					error : alert("Error")
				});
				this.currActionIndex++;
				return d;
			},
			copyLimitReached : function() {
				return this.copyBuffer.toIds.length >= this.copyLimit;
			},
			/*
			 * ENABLING/DISABLING/ACTIVATING METHODS
			 */
			_enableElement : function(elem) {
				elem.removeClass('disabled').removeClass('active').addClass(
						'enabled').attr('title', elem.data('title'));
			},
			_disableElement : function(elem) {
				elem.removeClass('enabled').removeClass('active').addClass(
						'disabled').attr('title', '');
			},
			_activateElement : function(elem) {
				elem.removeClass('enabled').addClass('active').removeClass(
						'disabled').attr('title', '');
			},
			_enableBrush : function() {
				if (this.stateMachine.isSelectingForCopying())
					this._activateBrush();
				else
					this
							._enableElement(this.stateMachine.jQueryCache['brushTool']);
				return this;
			},
			_disableBrush : function() {
				this
						._disableElement(this.stateMachine.jQueryCache['brushTool']);
				return this;
			},
			_activateBrush : function() {
				this._activateElement(this.stateMachine.jQueryCache['brushTool']);
				return this;
			},
			_enableMeassures : function() {
				if(valveConfigurationViewModel!=null&&valveConfigurationViewModel.enabledSimpleSpecial()){
				    this._enableElement(this.stateMachine.jQueryCache['meassuresTool']);
				}
				return this;
			},
			_disableMeassures : function() {
				this
						._disableElement(this.stateMachine.jQueryCache['meassuresTool']);
				return this;
			},
			_enableMoveLeft : function() {
				this
						._enableElement(this.stateMachine.jQueryCache['moveLeftTool']);
				return this;
			},
			_disableMoveLeft : function() {
				this
						._disableElement(this.stateMachine.jQueryCache['moveLeftTool']);
				return this;
			},
			_enableMoveRight : function() {
				this
						._enableElement(this.stateMachine.jQueryCache['moveRightTool']);
				return this;
			},
			_disableMoveRight : function() {
				this
						._disableElement(this.stateMachine.jQueryCache['moveRightTool']);
				return this;
			},
			_enableAddStation : function() {
				this
						._enableElement(this.stateMachine.jQueryCache['addStationTool']);
				return this;
			},
			_disableAddStation : function() {
				this
						._disableElement(this.stateMachine.jQueryCache['addStationTool']);
				return this;
			},
			_enableDeleteStation : function() {
				this
						._enableElement(this.stateMachine.jQueryCache['deleteStationTool']);
				return this;
			},
			_disableDeleteStation : function() {
				this
						._disableElement(this.stateMachine.jQueryCache['deleteStationTool']);
				return this;
			},
			_enableDeleteProduct : function() {
				this
						._enableElement(this.stateMachine.jQueryCache['deleteProductTool']);
				return this;
			},
			_disableDeleteProduct : function() {
				this
						._disableElement(this.stateMachine.jQueryCache['deleteProductTool']);
				return this;
			},
			_enableUndoAction : function() {
				this
						._enableElement(this.stateMachine.jQueryCache['undoActionTool']);
				return this;
			},
			_disableUndoAction : function() {
				this
						._disableElement(this.stateMachine.jQueryCache['undoActionTool']);
				return this;
			},
			_enableRedoAction : function() {
				this
						._enableElement(this.stateMachine.jQueryCache['redoActionTool']);
				return this;
			},
			_disableRedoAction : function() {
				this
						._disableElement(this.stateMachine.jQueryCache['redoActionTool']);
				return this;
			},
			_enableCheckAction : function() {
				this._enableElement(this.stateMachine.jQueryCache['checkTool']);
				return this;
			},
			_disableCheckAction : function() {
				this
						._disableElement(this.stateMachine.jQueryCache['checkTool']);
				return this;
			},
			/*
			 * ATTRIBUTE
			 */
			graphToolsBasePath : 'actions/',
			cellFromCopyId : null,
			actions : [],
			currActionIndex : -1,
			copyLimit : 24,
			copyBuffer : {
				fromIds : [],
				toIds : []
			},
			addAction : function(name) {
				var refresh = false;
				if (this.currActionIndex < this.actions.length) {
					this.actions = this.actions.slice(0, this.currActionIndex);
					refresh = true;
				}
				this.actions.push(name);
				this.currActionIndex++;
				this._refresh();
			}
		});

// Método externo para ejecutar
function downloadFile(fileName, fileContent) {
	/*
	 * var element = document.createElement('a'); element.setAttribute('href',
	 * 'data:text/plain;charset=utf-8,' + encodeURIComponent(fileContent));
	 * element.setAttribute('download', fileName); element.style.display =
	 * 'none'; document.body.appendChild(element); element.click();
	 * document.body.removeChild(element);
	 */

	var blob = new Blob([ fileContent ], {
		type : 'text/plain;charset=utf-8'
	});
	if (window.navigator.msSaveOrOpenBlob) {
		window.navigator.msSaveBlob(blob, fileName);
	} else {
		var elem = window.document.createElement('a');
		elem.href = window.URL.createObjectURL(blob);
		elem.download = fileName;
		document.body.appendChild(elem);
		elem.click();
		document.body.removeChild(elem);
	}
}

const saveConfigurationEvent = function saveConfigurationEvent() {
	let contactListData = [];
	let designer = {
		id : 1,
		name : $('#name').val(),
		company : $('#company').val(),
		email : $('#inputEmail4').val(),
		address : $('#adress').val(),
		phone : $('#phone').val(),
		town : $('#town').val(),
		fax : $('#fax').val(),
		zipCode : $('#zip').val(),
		isDesigner : true
	};

	let customer = {
		id : 2,
		name : $('#contactName').val(),
		company : $('#contactCompany').val(),
		email : $('#contactInputEmail4').val(),
		address : $('#contactAdress').val(),
		phone : $('#contactPhone').val(),
		town : $('#contactTown').val(),
		fax : $('#contactFax').val(),
		zipCode : $('#contactZip').val(),
		isDesigner : false
	};

	contactListData.push(designer);
	contactListData.push(customer);

	return $.ajax({
		url : saveConfigurationURL,
		data : {
			contactList : JSON.stringify(contactListData)
		},
		dataType : 'json',
		success : function(data) {
			downloadFile(data.name, data.value)
		},
		error : function(err) {
			console.log(err);
		}
	});
}

$('#saveConfiguration').on(
		'click',
		function() {

			createConfirmDialog('modal-component',
					modalSaveConfirmationLabels.title,
					modalSaveConfirmationLabels.message,
					modalSaveConfirmationLabels.close, null, false).then(
					saveConfigurationEvent);

		});
	
$('#back-btn').on('click', function(){
	//
	createConfirmAsyncDialog('modal-selseries-back', null, null, cancelBtn, noBtnText, true, 'error-dialog-load', function (confirm) {

		if(confirm){
			window.location = selseriesUrl;
		}
		return $.Deferred().resolve();
	});
});


$('#btnBackToSelectionSave').on('click', function(e){

	$('#modal-selseries-back').modal('hide');
	saveConfigurationEvent()
		.then(function(){
			window.location = selseriesUrl;
		})

});


const isExportEnabled = function(e){
	return e.target && e.target.getAttribute('data-configuration') === 'valid';
}
$('#exportSpecifications').on('click', function(e) {

	if(!isExportEnabled(e)){
		return;
	}

	$.ajaxHippo({
		type : 'POST',
		url : exportSpecificationsURL,
		dataType : 'text',
		success : function(data) {
			window.open(data, '_blank');
		},
		error : function(err) {
			console.log(err);
			smc.NotifyComponent.error("")
		}
	});
});

const createCellJsonObject = function (rowIdx, rows, cells) {

	try {
		var cellJson = {};
		var nextCells = [];

		for (var i = 0; i < cells.length; i++) {
			const currentCell = cells[i];
			nextCells.push({
				idx: i,
				class: currentCell.className,
				text: currentCell.innerText,
				html: currentCell.outerHtml
			});
		}
        
        const nextRowIsHidden = (rows[rowIdx + 1] && rows[rowIdx + 1].getAttribute('class') === 'ik_hidden_specifications');

        if(nextRowIsHidden) {
            cellJson.hidden = rows[rowIdx + 1];
        }     
		cellJson.cells = nextCells;

		return cellJson;
	} catch (e) {
		console.error(e);
		return {};
	}
}

const updateCellQty = function (cells, qtyCell) {

	var currentQty = parseInt(cells[2].innerText);
	var storedQty = parseInt(qtyCell.text);
	qtyCell.text = currentQty + storedQty;
}

const updateRowPositions = function (cells, rowToUpdate) {
	for (var i = 3; i < cells.length; i++) { //Skips firsts columns
		var currentCell = cells[i];
		var isEmpty = currentCell.className && currentCell.className === 'ik_position_column_empty';

		if (!isEmpty && rowToUpdate.cells.length >= i) {
			var positionNumber = currentCell.innerText;
			var cellToUpdate = rowToUpdate.cells[i];
			cellToUpdate.class = 'ik_position_column';
			cellToUpdate.text = positionNumber;
			rowToUpdate.cells[i] = cellToUpdate;
		}

	}
}
const convertHtmlDataToJson = function (data) {

	if (data && data.length === 4) { //3th object is the table to update
		var tableToUpdate = data[3];
		var rows = tableToUpdate.getElementsByTagName('tr');

		var jsonData = {};

		if (rows && rows.length > 1) { // First row is the header


			var idx = 1; //Skips the header

			while (idx < rows.length) {
				var currentRow = rows[idx];
				var className = currentRow.getAttribute('class');
				var isHiddenRow = (className === 'ik_hidden_specifications');
				if (!isHiddenRow) {
					var cells = currentRow.getElementsByTagName('td');
					var partNumber = cells[1].innerText;
					var description = cells[0].innerText;
					var key = partNumber + '#' + description;
					if (!jsonData[key]) { //Create Object
						jsonData[key] = createCellJsonObject(idx, rows, cells);
					} else { //Update Object
						var qtyCell = jsonData[key].cells[2]
						updateCellQty(cells, qtyCell);
						updateRowPositions(cells, jsonData[key]);
					}
				} else {}
				idx++;
			}
			return jsonData;
		} else {
			return {};
		}
	}

}


const createCell = function(className, text) {
	let td = document.createElement('td');
	td.className = className;
	td.innerHTML = text;
	return td;
}


const createRow = function(partNumber, cells) {
	let tr = document.createElement('tr');
	tr.setAttribute('minimize', 'true');
	tr.setAttribute('data-collapsable-id', partNumber.split('#')[0]);
	tr.className = 'eliminar-ik_report_panel_element';

	
	for (var index = 0; index < cells.length; index++) {
		const cell = cells[index];
		const cellClassName = cell.class;
		const text = cell.text;
		if(cellClassName === 'ik_position_column' && text && text.length) {
			const div = document.createElement('div');
			div.innerText = cell.text;
			div.className = 'ik_positions_circle';
			tr.appendChild(createCell(cellClassName, div.outerHTML));

		} else {
			tr.appendChild(createCell(cellClassName, cell.text));
		}
	
	}
	return tr;
}

const drawTable = function(data) {
	let htmlData = $.parseHTML(data);
	const json = convertHtmlDataToJson(htmlData);
	$('#configuration_summary_div').empty(); //CLEAN TABLE BEFORE LOADING

	if (htmlData && htmlData.length === 4) {
		const header = $(htmlData[3]).find('tr').eq(0);

		$(htmlData[3]).empty();
		$(htmlData[3]).append(header);

		for (var key in json) {
			if (json.hasOwnProperty(key)) {
			  
				var row = json[key];
				console.log(row.cells)
				$(htmlData[3]).append(createRow(key, row.cells));
				$(htmlData[3]).append(row.hidden);
			}
		 }


	}

	$('#configuration_summary_div').html(htmlData);
}

$('#sy-summary')
		.on(
				'click',
				function() {
					console.log("configuration_summary_div");
					$
							.ajaxHippo({
								type : 'POST',
								url : showConfigurationSummaryURL,
								dataType : 'html',
								success : function(data) {
									if (typeof data !== 'undefined'
											&& typeof data['ERRORES_CONFIGURACION'] !== 'undefined') {
										self.messages['ERRORES_CONFIGURACION'] = data['ERRORES_CONFIGURACION'];
									}
									drawTable(data);
									$('.eliminar-ik_report_panel_element').unbind("click");
                                    $('.eliminar-ik_report_panel_element').bind("click", enableDisableSummarySectionDetails);
								}
							});
				});

$('#exportBom').on('click', function(e) {

	if(!isExportEnabled(e)){
		return;
	}

	$.ajaxHippo({
		type : 'POST',
		url : exportBomURL,
		dataType : 'text',
		success : function(data) {
			console.log(data);
			window.open(data, '_blank');
		},
		error : function(err) {
			console.log(err);
		}
	});
});

$('#exportValvePDF').on('click', function(e) {

	if(!isExportEnabled(e)){
		return;
	}
	valveConfigurationViewModel.creatingPdf(true);
	let syImageData = valveConfigurationViewModel.getImageData();

    $.ajaxHippo({
        type : 'POST',
        url : showConfigurationSummaryURL,
            dataType : 'html',
            success : function(data) {
                console.log("//TODO get_reference_list when PDF clicked");
        }
    });

	$.ajaxHippo({
		type : 'POST',
		url : exportValvePDFURL,
		dataType : 'text',
		data : {
			syImage : syImageData
		},
		success : function(data) {
			console.log(data);
			window.open(data, '_blank');
			valveConfigurationViewModel.creatingPdf(false);
		},
		error : function(err) {
			console.log(err);
			valveConfigurationViewModel.creatingPdf(false);
		}
	});

});

$('#deleteCustomer').on('click', function(data) {
	this.stateMachine.jQuery.ajax({
		url : deleteCustomerByIdURL,
		data : data,
		dataType : 'json',
		success : function(data) {
			alert("sucess");
		},
		error : function(err) {
			console.log(err)
		}
	});
});

function enableDisableSummarySectionDetails() {
	var element = document.getElementById($(this).attr("data-collapsable-id"));
	if (element != null && element.className == 'ik_hidden_specifications') {
		$(element).removeClass('ik_hidden_specifications').addClass(
				"ik_show_specifications");
	} else {
		$(element).removeClass('ik_show_specifications').addClass(
				"ik_hidden_specifications");
	}

}

function enableDisableSummarySectionDetails() {

	var element = document.getElementById($(this).attr("data-collapsable-id"));
	if (element != null && element.className == 'ik_hidden_specifications') {
		$(element).removeClass('ik_hidden_specifications').addClass(
				"ik_show_specifications");
	} else {
		$(element).removeClass('ik_show_specifications').addClass(
				"ik_hidden_specifications");
	}

}

$("#save-as-default-btn").submit();

$('#wizard-simple-special').on('click', function(e) {
	e.preventDefault();
	wizardSimpleSpecialViewModel.showWizard();
});

$(document).on('vc-disable-pannel', function() {
	stateMachine.eventBus.fireEvent('onDisabledPanel');
});

$(document).on('vc-enable-pannel', function() {
	stateMachine.eventBus.fireEvent('onEnabledPanel');
});