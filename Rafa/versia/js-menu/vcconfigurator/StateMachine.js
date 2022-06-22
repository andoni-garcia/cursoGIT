var StateMachine = Class
		.extend({
			init : function($, sessionState, showMeasures, showNotices, syPath, messages) {
				window.parseDecimalInt = function(val) {
					return parseInt(val, 10);
				};

				this.jQuery = $;

				this.messages = messages;

				this.selClass = 'selected';

				this.syPath = syPath;

				this.deleting = false;

				this.isIncompatible = true;

				this.minStations = sessionState.minStations;
				this.maxStations = sessionState.maxStations;

				// Set default state
				this.withFreeElements = sessionState.withFreeElements;
				this.setStatus = sessionState.groupState.replace('with_errors', 'incomplete');
				this.currentState = sessionState.currentState;
				this.currentElement = sessionState.currentElement;
				this.closedConfiguration = sessionState.closedConfiguration;

				var syAction = false, actname = "";
				if (sessionState["syAction"] != "") {
					var timestamp = parseInt(sessionState["syAction"].split("_")[1]);
					var currTime = new Date().getTime();
					if (currTime - timestamp <= 10000) {
						syAction = true;
						actname = sessionState["syAction"].split("_")[0];
					}
				}
				if (syAction && actname == 'projinf') {
					sessionState["selectedTab"] = sessionState["tabsCount"] - 1;
					sessionState["actname"] = actname;
					this.jQuery("#reference_panel").show().find("#sy_product_reference_placeholder").removeClass(
							"no_elem").removeClass("no_ref");
				}
				if (sessionState["selectedTab"] == sessionState["tabsCount"] - 1
						|| sessionState["selectedTab"] == sessionState["tabsCount"] - 2) {
					this.currentState = this.constants.possibleStates.set_information;
				}

				// Create event bus
				this.eventBus = new ConfiguratorEventBus(false);

				// Subscribe to events
				this.eventBus.subscribeTo(this.eventBus.eventList.onBrushClick, {
					object : this,
					callback : this.onBrushClick
				});
				this.eventBus.subscribeTo(this.eventBus.eventList.onDisabledPanel, {
					object : this,
					callback : this.onDisabledPanel
				});
				this.eventBus.subscribeTo(this.eventBus.eventList.onEnabledPanel, {
					object : this,
					callback : this.onEnabledPanel
				});
				this.eventBus.subscribeTo(this.eventBus.eventList.onTabClick, {
					object : this,
					callback : this.onTabClick
				});
				this.eventBus.subscribeTo(this.eventBus.eventList.onCharacteristicChange, {
					object : this,
					callback : this.onCharacteristicChange
				});
				this.eventBus.subscribeTo(this.eventBus.eventList.afterCharacteristicChange, {
					object : this,
					callback : this.afterCharacteristicChange
				});
				this.eventBus.subscribeTo(this.eventBus.eventList.onGraphicalElementClick, {
					object : this,
					callback : this.onGraphicalElementClick
				});
				this.eventBus.subscribeTo(this.eventBus.eventList.afterAddStationClick, {
					object : this,
					callback : this.afterAddDeleteStationClick
				});
				this.eventBus.subscribeTo(this.eventBus.eventList.afterDeleteStationClick, {
					object : this,
					callback : this.afterAddDeleteStationClick
				});
				this.eventBus.subscribeTo(this.eventBus.eventList.afterUndoActionClick, {
					object : this,
					callback : this.afterUndoRedo
				});
				this.eventBus.subscribeTo(this.eventBus.eventList.afterRedoActionClick, {
					object : this,
					callback : this.afterUndoRedo
				});
				this.eventBus.subscribeTo(this.eventBus.eventList.afterAddToBasketClick, {
					object : this,
					callback : this.afterAddToBasket
				});
				this.eventBus.subscribeTo(this.eventBus.eventList.afterDeleteProductClick, {
					object : this,
					callback : this.afterDeleteProduct
				});
				this.eventBus.subscribeTo(this.eventBus.eventList.onUndoActionClick, {
					object : this,
					callback : this.onUndoAction,
					priority : 1
				});
				this.eventBus.subscribeTo(this.eventBus.eventList.afterAddProductClick, {
					object : this,
					callback : this.afterAddProductClick,
				});

				// Create jQuery cache
				this._createJQueryCache();

				this._check();

				// Create different controllers
				this.controllers['graphical_editor'] = new GraphicalEditorController(this, sessionState);
				this.controllers['graphical_editor'].firstLoad = false;
				this.controllers['tabs'] = new TabsController(this, sessionState);
				this.controllers['graphical_tools'] = new GraphicalToolsController(this, sessionState);
				

				if (sessionState.currentState == 'selecting_for_copy') {
					this._copyingElement = {};
					this._copyingElement.id = sessionState.copyingCellId;
				}

				this.jQuery('#path_div').on('click', '#sy_path_link', {
					object : this
				}, this.onReturnToSelSeriesNew);
				this.jQuery('#backLink a').bind('click', {
					object : this
				}, this.onReturnToSelSeriesNew);

				this.eventBus.sortEventSubscribers();

				var that = this;
				window.setTimeout(function() {
					that.eventBus.fireEvent('onSetStatusChanged');
				}, 2000);
				
				return this;
			},
			_createJQueryCache : function() {
				this.jQueryCache['graphicalToolsContainer'] = this.jQuery('#graphicalToolsContainer');
				this.jQueryCache['meassuresTool'] = this.jQuery('#meassures');
				this.jQueryCache['configurationPanelInputs'] = this.jQuery('#configuration select,#configuration input');
				this.jQueryCache['brushTool'] = this.jQuery('#brush');
				this.jQueryCache['moveLeftTool'] = this.jQuery('#moveLeft');
				this.jQueryCache['moveRightTool'] = this.jQuery('#moveRight');
				this.jQueryCache['addStationTool'] = this.jQuery('#addStation');
				this.jQueryCache['deleteStationTool'] = this.jQuery('#deleteStation');
				this.jQueryCache['deleteProductTool'] = this.jQuery('#deleteProduct');
				this.jQueryCache['undoActionTool'] = this.jQuery('#undoAction');
				this.jQueryCache['redoActionTool'] = this.jQuery('#redoAction');
				this.jQueryCache['saveConfigurationTool'] = this.jQuery('#saveConfiguration');
				this.jQueryCache['exportSpecificationsTool'] = this.jQuery('#exportSpecifications');
				this.jQueryCache['checkTool'] = this.jQuery('#check');
				this.jQueryCache['tabsDiv'] = this.jQuery('#tabsContainer');
				this.jQueryCache['tabs'] = this.jQuery('div.tabsDiv');
				this.jQueryCache['configuratorPanel'] = this.jQuery('#configurator_panel_div');
				this.jQueryCache['configuratorPanelPlaceholder'] = this.jQuery('#configurator_panel_placeholder');
				this.jQueryCache['measuresDiv'] = this.jQuery('#meassures_div');
				this.jQueryCache['noticesDiv'] = this.jQuery('#notices_div');
				this.jQueryCache['graphicalEditorDiv'] = this.jQuery('#graphical_editor_div');
				this.jQueryCache['downButtonsContainer'] = this.jQuery('#downButtonsContainer');
				this.jQueryCache['ikPDF'] = this.jQuery('#ikPDF');
				this.jQueryCache['ikPreviewCADenas'] = this.jQueryCache['downButtonsContainer']
						.find('#ikPreviewCADenas');
				this.jQueryCache['ikDownloadCADenas'] = this.jQueryCache['downButtonsContainer']
						.find('#ikDownloadCADenas');
				this.jQueryCache['ikEmailCADenas'] = this.jQueryCache['downButtonsContainer'].find('#ikEmailCADenas');
				this.jQueryCache['ikPreview3D'] = this.jQuery('#ik_preview_3D');
				this.jQueryCache['ikDownloadCAD'] = this.jQuery('#ik_download_CAD');
				this.jQueryCache['ikAskSMC'] = this.jQueryCache['downButtonsContainer'].find('#ikAskSMC');
				this.jQueryCache['ikStatus'] = this.jQuery('#ik_status');
				this.jQueryCache['ikAddToBasketDiv'] = this.jQuery('#ikAddToBasketDiv');
				this.jQueryCache['ikAddToFavoriteDiv'] = this.jQuery('#ikAddToFavoriteDiv');
				this.jQueryCache['ikSaveSYFDiv'] = this.jQuery('#ikSaveSYFDiv');
				this.jQueryCache['ikUpdateBasketDiv'] = this.jQuery('#ikUpdateBasketDiv');
				this.jQueryCache['ikActionFrom'] = this.jQuery('#ik_action_from');
				this.jQueryCache['ikPartNumber'] = this.jQuery('#ik_part_number');
				this.jQueryCache['ikPathCatalogue'] = this.jQuery('#ik_path_catalogue');
				this.jQueryCache['ikDocument'] = this.jQuery('#ik_document');
				this.jQueryCache['ikConfiguratorLanguage'] = this.jQuery('#ik_configurator_language');
				this.jQueryCache['ikSerieDescription'] = this.jQuery('#ik_serie_description');
				this.jQueryCache['ikDescription'] = this.jQuery('#ik_description');
				this.jQueryCache['ikActionFrom'] = this.jQuery('#ik_action_from');
				this.jQueryCache['ikFormTo'] = this.jQuery('#ikFormTo');
				this.jQueryCache['sprGraphEditor'] = this.jQuery('.graphical_editor');
				this.jQueryCache['hiddenPanel'] = this.jQuery('#hiddenPanel');
				this.jQueryCache['sy_overlay'] = this.jQuery('#sy_overlay');
				this.jQueryCache['copyPlaceholder'] = this.jQuery('#configurator_copy_placeholder');
				this.jQueryCache['ptabsDiv'] = this.jQuery('#tabs_div');
				this.jQueryCache['ikUpdateFavoriteDiv'] = this.jQuery('#ikUpdateFavoriteDiv');
			},
			/*
			 * 'ASYNCHRONOUSITY' SETTINGS BY METHOD
			 */
			_ajaxAsyncSettings : {
				_refreshGroupGlobalVariable : false,
				_check : false,
				_checkOptimized : false,
				_meassures:true
			},
			/*
			 * CALLED WHEN SOMETHING HAPPENS
			 */
			onUndoAction : function() {
				var elements = this.constants.elements;
				this.currentElement = elements.manifold;
				this._check();
			},
			onBrushClick : function() {
				var states = this.constants.possibleStates;
				if (this.currentState == states.configuring) {
					this.currentState = states.selecting_for_copy;
					this._copyingElement = this.jQuery("." + this.selClass)[0];
				} else if (this.currentState == states.selecting_for_copy) {
					this.currentState = states.configuring;
				}
				this.eventBus.fireEvent('onStateChange');
			},
			onDisabledPanel: function() {
				var states = this.constants.possibleStates;
				if (this.currentState == states.configuring) {
					this.currentState = states.disabled_panel;
				}
				this.eventBus.fireEvent('onStateChange');
			},
			onEnabledPanel: function() {
				var states = this.constants.possibleStates;
				if(this.currentState == states.disabled_panel) {
					this.currentState = states.configuring;
				}
				this.eventBus.fireEvent('onStateChange');
			},
			onTabClick : function(isManyfold, isStation, isConfigurationSummary, isBOM, noClick, isProjectInformation) {
				var states = this.constants.possibleStates;
				var elements = this.constants.elements;
				if (this.currentState == states.selecting_for_copy || this.currentState == states.set_information)
					this.currentState = states.configuring;
				if (isManyfold)
					this.currentElement = elements.manifold;
				else if (isStation && !noClick)
					this.currentElement = elements.valves;
				else if (isConfigurationSummary || isBOM || isProjectInformation)
					this.currentState = states.set_information;
				if (!(noClick && isStation))
					this.eventBus.fireEvent('onStateChange');
			},
			onCharacteristicChange : function(idCharacteristic, idOption) {
				this._check("idCharacteristic=" + idCharacteristic + "&idOption=" + idOption);
				
				console.log("Entra en funcion drawSolenoids ") ;
				var self = this;
				
				this.jQuery.ajax({
					url : drawSolenoidsURL,
					async : this._ajaxAsyncSettings._meassures,
					data : "idCharacteristic=" + idCharacteristic + "&idOption=" + idOption,
					dataType : 'html',
					success : function(data) {
						if (typeof data !== 'undefined' && typeof data['ERRORES_CONFIGURACION'] !== 'undefined') {
							self.messages['ERRORES_CONFIGURACION'] = data['ERRORES_CONFIGURACION'];
						}
						$('#solenoids_div').html(data);
						console.log("Entra en funcion configuration Summary ") ;
					}
				});
				
			},
			onGraphicalElementClick : function(elementId, tabN) {
				if (!this.isCopying() && !this.isSelectingForCopying())
					this._checkOptimized("idElement=" + elementId);
				var elem = document.getElementById(elementId);

				var states = this.constants.possibleStates;
				var elements = this.constants.elements;
				if (tabN == "0")
					this.currentElement = elements.manifold;
				else if (tabN == "1" && this.currentState != states.selecting_for_copy) {
					this.currentElement = elements.valves;
					if (this._hasClass(elem, 'intermediate_level'))
						this.currentElement = elements.intermediate_level;
					else if (this._hasClass(elem, 'base_plate') && this._hasClass(elem, 'customized'))
						this.currentElement = elements.customized_base_plate;
					else if (this._hasClass(elem, 'base_plate'))
						this.currentElement = elements.base_plate;
					else if (this._hasClass(elem, 'block_disk'))
						this.currentElement = elements.block_disk;
				} else if (tabN == "2")
					this.currentElement = elements.input_output;

				if (this.currentState == states.set_information && (tabN == "0" || tabN == "1" || tabN == "2"))
					this.currentState = states.configuring;

					$('a[href="#configuration"]').click();
				this.eventBus.fireEvent('onStateChange');
			},
			afterAddDeleteStationClick : function(data) {
				this._check(data);
			},
			afterUndoRedo : function(charOption) {
				if (charOption != "") {
					this._check(charOption);
				} else {
					this._check(null);
				}
			},
			afterAddToBasket : function() {
				this._refreshStatusFormToBasket();
			},
			afterCharacteristicChange : function() {
				this._refreshStatusFormToBasket();
				this.eventBus.fireEvent('onStateChange');
			},
			afterDeleteProduct : function(data) {
				this._check(data);
				this.controllers.tabs._refreshPanel(-1);
			},
			
			/*
			 * FUNCTIONS
			 */
			_refreshStatusFormToBasket : function() {
				var status = [ "correct", "Complete" ];
				var statusObj = _.chain(this.jQuery('.tabsSprite')).map(function(elem) {
					return elem.className.replace('tabsSprite', '');
				}).reduce(function(memo, src) {
					if (src.indexOf("amarillo") > -1)
						memo['yellow'] = true;
					else if (src.indexOf("rojo") > -1)
						memo['red'] = true;
					return memo;
				}, {
					yellow : false,
					red : false
				}).value();

				if (statusObj.red)
					status = [ "with_errors", "Invalid" ];
				else if (statusObj.yellow)
					status = [ "incomplete", "Partial" ];

				this.jQueryCache['ikStatus'] = status[1];

				this.setStatus = status[0];
				// this._refreshGroupGlobalVariable(); se ha comentado para la nueva version, será necesario solucionarlo en el futuro 29/06/2018
			},
			_refreshGroupGlobalVariable : function() {
				var status = this.setStatus;
				var randomnumber = Math.floor(Math.random() * 10000);
				var self = this;
				this.jQuery.ajax({
					url : self.updatesBasePath + "update_status.jsp",
					async : this._ajaxAsyncSettings._refreshGroupGlobalVariable,
					data : "status=" + status + "&number=" + randomnumber,
					success : function() {
					}
				});
			},
			_check : function(data) {
				var self = this;
				
				console.log("Entra en funcion _check @ StateMachine.js ") ;
				this.jQuery.ajax({
					url : checkValveConfiguration,
					async : this._ajaxAsyncSettings._check,
					data : data,
					dataType : 'json',
					success : function(data) {
						if (typeof data !== 'undefined' && typeof data['ERRORES_CONFIGURACION'] !== 'undefined') {
							self.messages['ERRORES_CONFIGURACION'] = data['ERRORES_CONFIGURACION'];
						}
						self.isIncompatible = data['group_state_incomplete'];
					}
				});
			},
			_checkOptimized : function(data) {
				var self = this;
				console.log("entra en StateMachine.js @ _checkOptimized") ;
				// es necesario codificar para evitar el error the valid characters are defined in rfc 7230 and rfc 3986
				// ya que se están pasando simbolos que no acepta []				
				this.jQuery.ajax({
					url : checkValveConfiguration, //"check_optimized.jsp",
					async : this._ajaxAsyncSettings._checkOptimized,
					data : encodeURI(data), 
					dataType : 'json',
					success : function(data) {
						if (typeof data !== 'undefined' && typeof data['ERRORES_CONFIGURACION'] !== 'undefined') {
							self.messages['ERRORES_CONFIGURACION'] = data['ERRORES_CONFIGURACION'];
						}
						self.isIncompatible = data['group_state_incomplete'];
					}
				});
			},
			getCurrentActions : function(key) {
				// DEPRECATED
				var currActions = this._getCurrentActions();
				var _cAc = currActions[key];
				if (typeof _cAc == 'object') {
					if (typeof _cAc[this.currentElement] !== 'undefined')
						_cAc = _cAc[this.currentElement];
					else
						_cAc = _cAc['_default'];
				}
				return _cAc;
			},
			updateGroupState : function(state) {
				if (typeof state !== 'undefined') {
					this.setStatus = state;
					this.eventBus.fireEvent('onSetStatusChanged');
				}

			},
			/*
			 * SETTERS/GETTERS
			 */
			setFreeElements : function(freeElem) {
				this.withFreeElements = this.constants.freeElements[freeElem + ''];
			},
			setCompleted : function(isComplete) {
				this.setStatus = this.constants.setStatus[isComplete + ''];
			},
			_getCurrentActions : function() {
				var obj = this.stateMachineTable["without_free_elements"]["incomplete"]["configuring"];
				try {
					obj = this.stateMachineTable[this.withFreeElements][this.setStatus.replace('with_errors',
							'incomplete')][this.currentState];
				} catch (Except) {
				}
				return obj;
			},
			getCurrentStatusDefinition : function() {
				return {
					currentState : this.currentState,
					withFreeElements : this.withFreeElements,
					setStatus : this.setStatus,
					currentElement : this.currentElement
				};
			},
			setClosedConfiguration : function(closedConfig) {
				this.closedConfiguration = this.constants.closedConfiguration[closedConfig + ''];
			},
			getClosedConfiguration : function() {
				return this.closedConfiguration;
			},
			isSelectingForCopying : function() {
				return this.currentState == this.constants.possibleStates.selecting_for_copy;
			},
			isConfiguring : function() {
				return this.currentState == this.constants.possibleStates.configuring;
			},
			isCopying : function() {
				return this.currentState == this.constants.possibleStates.copying;
			},
			isViewingSetInformation : function() {
				return this.currentState == this.constants.possibleStates.set_information;
			},
			_copyingElement : null,
			/*
			 * CLASS ATTRIBUTES
			 */
			constants : {
				freeElements : {
					'true' : 'with_free_elements',
					'false' : 'without_free_elements'
				},
				setStatus : {
					'true' : 'correct',
					'false' : 'incomplete'
				},
				possibleStates : {
					configuring : 'configuring',
					selecting_for_copy : 'selecting_for_copy',
					copying : 'copying',
					set_information : 'set_information',
					disabled_panel : 'disabled_panel'
				},
				actionGroups : {
					computations : {
						name : 'computations',
						actions : [ 'measures', 'bom', 'info', 'notices' ]
					},
					graphical_tools : {
						name : 'graphical_tools',
						actions : [ 'meassures', 'brush', 'moveLeft', 'moveRight', 'addStation', 'deleteStation',
								'deleteProduct', 'undoAction', 'redoAction' ]
					}
				},
				elements : {
					manifold : 'manifold',
					base_plate : 'base_plate',
					intermediate_level : 'intermediate_level',
					valves : 'valves',
					block_disk : 'block_disk',
					input_output : 'input_output',
					customized_base_plate : 'customized_base_plate'
				}
			},
			currentState : 'configuring',
			withFreeElements : 'with_free_elements',
			setStatus : 'incomplete',
			currentElement : 'manifold',
			closedConfiguration : 'false',
			jQueryCache : {},
			controllers : {},
			stateMachineTable : {
				without_free_elements : {
					incomplete : {
						configuring : {
							computations : true,
							graphical_tools : {
								manifold : {
									_default : false
								},
								base_plate : {
									deleteProduct : false,
									_default : true
								},
								input_output : {
									deleteProduct : true
								},
								_default : true
							}
						},
						/*
						disabled_panel : {
							computations : false,
							graphical_tools : {
								_default : false
							}
						},*/
						selecting_for_copy : {
							computations : false,
							graphical_tools : {
								manifold : {
									_default : false
								},
								valves : {
									brush : true,
									_default : false
								},
								base_plate : {
									brush : true,
									_default : false
								},
								intermediate_level : {
									brush : true,
									_default : false
								},
								input_output : {
									brush : true,
									_default : false
								},
								block_disk : {
									brush : true,
									_default : false
								},
								_default : false
							}
						},
						copying : {
							computations : false,
							graphical_tools : false
						},
						set_information : {
							computations : true,
							graphical_tools : false
						}
					},
					correct : {
						configuring : {
							computations : true,
							graphical_tools : {
								manifold : {
									_default : false
								},
								base_plate : {
									deleteProduct : false,
									_default : true
								},
								_default : true
							}
						},
						disabled_panel : {
							computations : false,
							graphical_tools : {
								_default : false
							}
						},
						selecting_for_copy : {
							computations : false,
							graphical_tools : {
								manifold : {
									_default : false
								},
								valves : {
									brush : true,
									_default : false
								},
								base_plate : {
									brush : true,
									_default : false
								},
								intermediate_level : {
									brush : true,
									_default : false
								},
								input_output : {
									brush : true,
									_default : false
								},
								block_disk : {
									brush : true,
									_default : false
								},
								_default : false
							}
						},
						copying : {
							computations : false,
							graphical_tools : false
						},
						set_information : {
							computations : true,
							graphical_tools : false
						}
					}
				},
				with_free_elements : {
					incomplete : {
						configuring : {
							computations : {
								_default : {
									measures : false,
									_default : true
								}
							},
							graphical_tools : {
								manifold : {
									_default : false
								},
								base_plate : {
									deleteProduct : false,
									_default : true
								},
								_default : true
							}
						},
						/*
						disabled_panel : {
							computations : false,
							graphical_tools : {
								_default : false
							}
						},*/
						selecting_for_copy : {
							computations : {
								_default : {
									measures : false,
									_default : true
								}
							},
							graphical_tools : {
								manifold : {
									_default : false
								},
								valves : {
									brush : true,
									_default : false
								},
								base_plate : {
									brush : true,
									_default : false
								},
								intermediate_level : {
									brush : true,
									_default : false
								},
								input_output : {
									brush : true,
									_default : false
								},
								block_disk : {
									brush : true,
									_default : false
								},
								_default : false
							}
						},
						copying : {
							computations : {
								_default : {
									measures : false,
									_default : true
								}
							}
						},
						set_information : {
							computations : {
								_default : {
									measures : false,
									_default : true
								}
							},
							graphical_tools : false
						}
					},
					correct : {
						configuring : {
							computations : {
								_default : {
									measures : false,
									_default : true
								}
							},
							graphical_tools : {
								manifold : {
									_default : false
								},
								base_plate : {
									deleteProduct : false,
									_default : true
								},
								_default : true
							}
						},/*
						disabled_panel : {
							computations : false,
							graphical_tools : {
								_default : false
							}
						},*/
						selecting_for_copy : {
							computations : {
								_default : {
									measures : false,
									_default : true
								}
							},
							graphical_tools : {
								manifold : {
									_default : false
								},
								valves : {
									brush : true,
									_default : false
								},
								base_plate : {
									brush : true,
									_default : false
								},
								intermediate_level : {
									brush : true,
									_default : false
								},
								input_output : {
									brush : true,
									_default : false
								},
								block_disk : {
									brush : true,
									_default : false
								},
								_default : false
							}
						},
						copying : {
							computations : {
								_default : {
									measures : false,
									_default : true
								}
							}
						},
						set_information : {
							computations : {
								_default : {
									measures : false,
									_default : true
								}
							},
							graphical_tools : false
						}
					}
				}
			},
			/*
			 * EXTRA METHODS
			 */
			_hasClass : function(domE, clss) {
				return (' ' + domE.className + ' ').indexOf(' ' + clss + ' ') > -1;
			},
			_addClass : function(ele, cls) {
				if (!this._hasClass(ele, cls))
					ele.className += " " + cls;
				return this;
			},
			_removeClass : function(ele, cls) {
				if (this._hasClass(ele, cls)) {
					var reg = new RegExp('(\\s|^)' + cls + '(\\s|$)');
					ele.className = ele.className.replace(reg, ' ');
				}
				return this;
			},
			_changeElementSize : function(elem, size) {
				var w = Math.round(this.jQuery(elem).width());
				this.jQuery(elem).width(w + size);
				var h = Math.round(this.jQuery(elem).height());
				this.jQuery(elem).height(h + size);
				return this;
			},
			_moveBackgroundImage : function(elem, move) {
				var $elem = this.jQuery(elem);
				var backgroundArr = $elem.backgroundPosition().replace(/px/g, '').split(' ');

				var backgroundStr = '';
				for (var i = 0; i < backgroundArr.length; i++)
					backgroundStr += window.parseDecimalInt(backgroundArr[i]) + move + 'px ';
				$elem.backgroundPosition(backgroundStr);

				return this;
			},
			_resetStyle : function(elem, excluded) {
				if (typeof excluded === 'undefined')
					excluded = [ '' ];
				else
					excluded.push('');
				var inlineStyles = elem.getAttribute('style').toLowerCase().replace(/([^\s:;]+):[^;:]+/g, '$1')
						.replace(/\s+/g, '').split(';');
				var toRemove = _.difference(inlineStyles, excluded);
				for (var i = 0; i < toRemove.length; i++) {
					var name = this.jQuery.trim(toRemove[i]).replace(/(-[a-z])/, function(v) {
						return v.charAt(1).toUpperCase();
					});
					elem.style[name] = '';
					if (name === 'backgroundPosition') {
						elem.style['backgroundPositionX'] = '';
						elem.style['backgroundPositionY'] = '';
					}
				}
			},
			_getMaxMin : function() {
				var manifold = this.jQuery('.manifold_d');

				var minMax = {
					minStations : 0,
					maxStations : 99,
					minInputs : 0,
					maxInputs : 99,
					minOutputs : 0,
					maxOutputs : 99,
					minMixed : 0,
					maxMixed : 99
				};

				var minS = manifold.data('min_stations');
				var maxS = manifold.data('max_stations');
				var minI = manifold.data('min_input');
				var maxI = manifold.data('max_input');
				var minO = manifold.data('min_output');
				var maxO = manifold.data('max_output');
				var minM = manifold.data('min_mixed');
				var maxM = manifold.data('max_mixed');

				try {
					minMax.minStations = window.parseDecimalInt(minS);
				} catch (Except) {
				}
				try {
					minMax.maxStations = window.parseDecimalInt(maxS);
				} catch (Except) {
				}
				try {
					minMax.minInputs = window.parseDecimalInt(minI);
				} catch (Except) {
				}
				try {
					minMax.maxInputs = window.parseDecimalInt(maxI);
				} catch (Except) {
				}
				try {
					minMax.minOutputs = window.parseDecimalInt(minO);
				} catch (Except) {
				}
				try {
					minMax.maxOutputs = window.parseDecimalInt(maxO);
				} catch (Except) {
				}
				try {
					minMax.minMixed = window.parseDecimalInt(minM);
				} catch (Except) {
				}
				try {
					minMax.maxMixed = window.parseDecimalInt(maxM);
				} catch (Except) {
				}

				if (isNaN(minMax.minStations))
					minMax.minStations = this.minStations;
				if (isNaN(minMax.maxStations))
					minMax.maxStations = this.maxStations;
				if (isNaN(minMax.minInputs))
					minMax.minInputs = 0;
				if (isNaN(minMax.maxInputs))
					minMax.maxInputs = 99;
				if (isNaN(minMax.minOutputs))
					minMax.minOutputs = 0;
				if (isNaN(minMax.maxOutputs))
					minMax.maxOutputs = 99;
				if (isNaN(minMax.minMixed))
					minMax.minMixed = 0;
				if (isNaN(minMax.maxMixed))
					minMax.maxMixed = 99;

				return minMax;
			},
			_ajaxError : function(clazz, method, jqXHR, error, exception) {

			},
			onReturnToSelSeries : function(e) {
				var self = e.data.object;
				var that = this;
				if (self.showMessage('AVISO_SALVADO')) {
					var w = window.open('save/save_document.jsp');
					var tm = setTimeout(function() {
						if (w.closed) {
							clearTimeout(tm);
							location.href = self.jQuery(that).attr('aref');
						}
					}, 1000);
				} else {
					location.href = self.jQuery(this).attr('aref');
				}
			},
			onReturnToSelSeriesNew : function(e) {
				var self = e.data.object;
				var that = this;
				var cancelText = that.getAttribute("cancelText");
				var noText = that.getAttribute("noText");
				var yesText = that.getAttribute("yesText");
				var message = "<p>" + self.messages['AVISO_SALVADO']['msg'] + "</p>";
				var url = that.getAttribute("aref");
				e.preventDefault();
				try {
					var dialog = $(message).dialog({
						resizable : false,
						height : "auto",
						width : 500,
						title : "SMC SY Configurator",
						modal : true,
						closeOnEscape : false,
						position : {
							my : "top",
							at : "top",
							of : window
						},
						buttons : {
							"Yes" : function() {
								var w = window.open('save/save_document.jsp');
								var tm = setTimeout(function() {
									if (w.closed) {
										clearTimeout(tm);
										location.href = url;
									}
								}, 1000);

							},
							"No" : function() {
								location.href = url;
							},
							"Cancel" : function() {
								dialog.dialog('close');
							}
						}
					});
					// $(".ui-dialog-titlebar").hide();
					$(".ui-button").removeClass("ui-widget");
					$(".ui-button").removeClass("ui-state-default");
					$(".ui-button").removeClass("ui-corner-all");
					$(".ui-button").removeClass("ui-button-text-only");
					$('.ui-button').unbind('mouseover mouseenter mouseleave');
					$(".ui-button").addClass("dialog_submit_button");
					$(".ui-button").addClass("sy_dialog_button");
					$(".ui-dialog-content").addClass("sy_dialog_text");
					$(".ui-dialog-buttonpane").removeClass("ui-widget-content");
					$('.ui-dialog .ui-button-text:contains(Cancel)').text(cancelText);
					$('.ui-dialog .ui-button-text:contains(No)').text(noText);
					$('.ui-dialog .ui-button-text:contains(Yes)').text(yesText);
					$('.ui-dialog').dialog('widget').find(".ui-dialog-titlebar-close").hide();
					$('.ui-dialog').dialog('widget').find('.ui-icon ui-icon-closethick').hide();

				} catch (Except) {
				}
			},
			showMessage : function(name) {
				if (typeof this.messages[name] == 'undefined') {
					return false;
				} else if (this.messages[name]['msg'] == '') {
					return true;
				} else {
					return this._showMessage(this.messages[name]['msg'], this.messages[name]['type']);
				}
			},
			_showMessage : function(msg, type) {
				var result = false;
				if (type == 'D') {
					result = window.confirm(msg);
				} else {
					window.alert(msg);
				}
				return result;
			},
			_showWait : function() {
				this.jQueryCache['sy_overlay'].show();
			},
			_hideWait : function() {
				this.jQueryCache['sy_overlay'].hide();
			},
			afterAddProductClick : function() {
				this.controllers.tabs._refreshPanel(-1);
			},
			/*
			 * VARIABLES
			 */
			updatesBasePath : 'updates/'
		});