var TabsController = Class
		.extend({
			init : function(stMach, sessionState) {
				this.stateMachine = stMach;
				var self = this;
				$(window).bind('beforeunload', function() {
					if ($('.projectInformationField:visible').length > 0) {
						self.loadSolicitorData({
							data : {
								object : self
							}
						});
					}
				});

				stMach.jQueryCache['tabs'].bind('click', {
					object : this
				}, this.onTabClicked);
				stMach.jQueryCache['configuratorPanel'].on('click', '.ik_report_panel_element', {
					object : this
				}, this.onReportSpecificationClicked);
				stMach.jQueryCache['configuratorPanel'].on('change', '.interval_selection, .event', {
					object : this
				}, this.onCharacteristicChanged);
				stMach.jQueryCache['configuratorPanel'].on('click', '.link_product', {
					object : this
				}, this.onAddProductClick);
				stMach.jQueryCache['configuratorPanel'].on('click', '.delete_product', {
					object : this
				}, this.onDeleteProductClick);
				stMach.jQueryCache['configuratorPanel'].on('keyup', '.ik_free_reference_input', {
					object : this
				}, this.loadReferenceFreeProduct);
				stMach.jQueryCache['configuratorPanel'].on('click', '.ik_free_element_hidde_meassures', {
					object : this
				}, this.loadHideMeasuresFreeProduct);
				stMach.jQueryCache['configuratorPanel'].on('click', '#ik_reset_default', {
					object : this
				}, this.onResetClicked);
				stMach.jQueryCache['configuratorPanel'].on('click', '.free_elements_button_add', {
					object : this
				}, this.onPartAddClicked);
				stMach.jQueryCache['configuratorPanel'].on('click', '.free_elements_button_modify', {
					object : this
				}, this.onPartModifyClicked);
				stMach.jQueryCache['configuratorPanel'].on('click', '.free_elements_button_delete', {
					object : this
				}, this.onPartDeleteClicked);
				stMach.jQueryCache['configuratorPanel'].on('click', '.element_part_row', {
					object : this
				}, this.onPartElementClicked);
				stMach.jQueryCache['configuratorPanel'].on('keypress', '#element_part_quantity', {
					object : this
				}, this.onPartQuantityEdited);
				stMach.jQueryCache['configuratorPanel'].on('keypress', '#quantityRef', {
					object : this
				}, this.onPartQuantityEdited);
				stMach.jQueryCache['configuratorPanel'].on('keypress', '#quantityBom', {
					object : this
				}, this.onPartQuantityEdited);

				// Manifold Special Product Events
				stMach.jQueryCache['configuratorPanel'].on('click', '#manifoldSpecialButton', {
					object : this
				}, this.onRefreshManifoldSpecialVisibility);
				stMach.jQueryCache['configuratorPanel'].on('click', '#addReferenceButton', {
					object : this
				}, this.onAddReference);
				stMach.jQueryCache['configuratorPanel'].on('click', '#modifyReferenceButton', {
					object : this
				}, this.onModifyReference);
				stMach.jQueryCache['configuratorPanel'].on('click', '#deleteReferenceButton', {
					object : this
				}, this.onDeleteReference);
				stMach.jQueryCache['configuratorPanel'].on('click', '#addBomButton', {
					object : this
				}, this.onAddBom);
				stMach.jQueryCache['configuratorPanel'].on('click', '#modifyBomButton', {
					object : this
				}, this.onModifyBom);
				stMach.jQueryCache['configuratorPanel'].on('click', '#deleteBomButton', {
					object : this
				}, this.onDeleteBom);
				stMach.jQueryCache['configuratorPanel'].on('click', '#dimensionCheck', {
					object : this
				}, this.onDimensionCheck);
				stMach.jQueryCache['configuratorPanel'].on('click', '#resetButton', {
					object : this
				}, this.onResetSpecialManifold);
				stMach.jQueryCache['configuratorPanel'].on('click', '.manifoldReferenceRow', {
					object : this
				}, this.onMarkeReference);
				stMach.jQueryCache['configuratorPanel'].on('click', '.manifoldBomRow', {
					object : this
				}, this.onMarkeBom);

				// Project information events
				stMach.jQueryCache['configuratorPanel'].on('click', '#loadContact', {
					object : this
				}, this.onLoadContactClicked);
				stMach.jQueryCache['configuratorPanel'].on('click', '#saveContact', {
					object : this
				}, this.onSaveContactClicked);
				stMach.jQueryCache['configuratorPanel'].on('click', '#loadDefaultContact', {
					object : this
				}, this.onLoadDefaultClicked);
				stMach.jQueryCache['configuratorPanel'].on('click', '#saveDesignerAsDefault', {
					object : this
				}, this.onSaveAsDefaultClicked);
				stMach.jQueryCache['configuratorPanel'].on('click', '#check_price_button', {
					object : this
				}, this.onCheckPriceClicked);
				stMach.jQueryCache['configuratorPanel'].on('click', '#close_configuration_button', {
					object : this
				}, this.onCloseConfigurationClicked);
				stMach.jQueryCache['configuratorPanel'].on('click', '#create_ss_button', {
					object : this
				}, this.onCreateSSClicked);
				stMach.jQueryCache['configuratorPanel'].on('focusout',
						'.projectInformationField input, .projectInformationField textarea', {
							object : this
						}, this.loadSolicitorData);
				stMach.jQueryCache['configuratorPanel'].on('focusout', '#solicitorInformationD input', {
					object : this
				}, this.cleanValidationMessage);
				stMach.jQueryCache['configuratorPanel'].on('focusout',
						'.projectInformationFieldGroup input, .projectInformationFieldGroup textarea', {
							object : this
						}, this.loadSolicitorData);

				stMach.jQuery("body").on('click', '.contactLine', {
					object : this
				}, this.onContactClicked);
				// stMach.jQuery("body").on('click', '.messageLine', {
				// object : this
				// }, this.onNoContactClicked);
				stMach.jQuery("body").on('click', '.deleteContact', {
					object : this
				}, this.onDeleteContactClicked);

				// Subscribe to events
				stMach.eventBus.subscribeTo(stMach.eventBus.eventList.afterGraphicalElementClick, {
					object : this,
					callback : this.afterGraphicalElementClick
				});
				stMach.eventBus.subscribeTo(stMach.eventBus.eventList.afterBrushClick, {
					object : this,
					callback : this.afterBrushClick
				});
				stMach.eventBus.subscribeTo(stMach.eventBus.eventList.afterMoveLeftClick, {
					object : this,
					callback : this.afterMove
				});
				stMach.eventBus.subscribeTo(stMach.eventBus.eventList.afterMoveRightClick, {
					object : this,
					callback : this.afterMove
				});
				stMach.eventBus.subscribeTo(stMach.eventBus.eventList.afterAddStationClick, {
					object : this,
					callback : this.afterAddDeleteStationClick
				});
				stMach.eventBus.subscribeTo(stMach.eventBus.eventList.afterDeleteStationClick, {
					object : this,
					callback : this.afterAddDeleteStationClick
				});
				stMach.eventBus.subscribeTo(stMach.eventBus.eventList.afterDeleteProductClick, {
					object : this,
					callback : this.afterAddDeleteStationClick
				});
				stMach.eventBus.subscribeTo(stMach.eventBus.eventList.afterUndoActionClick, {
					object : this,
					callback : this.afterUndoRedo
				});
				stMach.eventBus.subscribeTo(stMach.eventBus.eventList.afterRedoActionClick, {
					object : this,
					callback : this.afterUndoRedo
				});
				// stMach.eventBus.subscribeTo(
				// stMach.eventBus.eventList.afterAddToBasketClick, {
				// object : this,
				// callback : this.afterAddToBasket
				// });

				stMach.eventBus.subscribeTo(stMach.eventBus.eventList.afterUncommitedBrushClick, {
					object : this,
					callback : this._hideCopyPlaceholder
				});

				this._selectedTab = stMach.jQueryCache['tabs'][0];
				if (typeof sessionState.selectedTab !== 'undefined' && sessionState.selectedTab != "-1") {
					this._selectedTab = stMach.jQueryCache['tabs'][sessionState.selectedTab];
					stMach.jQueryCache['tabs'].eq(sessionState.selectedTab).removeClass('normal_tab').addClass(
							'selected_tab').end().not(':eq(' + sessionState.selectedTab + ')').addClass('normal_tab')
							.removeClass('selected_tab');
				}

				if (sessionState["tabsCount"] == sessionState["selectedTab"] + 1) {
					// Project information
					this.loadProjectInformationPanel();
				} else if (sessionState["tabsCount"] == sessionState["selectedTab"] + 2) {
					this.loadReportPanel();
				} else {
					this.loadConfiguratorPanel("", true, stMach.isSelectingForCopying());
				}
				//this.refreshTabsStatus(sessionState["actname"]);
			},
			/*
			 * 'ASYNCHRONOUSITY' SETTINGS BY METHOD
			 */
			_ajaxAsyncSettings : {
				onAddProductClick : false,
				onDeleteProductClick : false,
				loadReportPanel : false,
				loadBOMPanel : false,
				loadConfiguratorPanel : false,
				loadReferenceFreeProduct : false,
				loadHideMeasuresFreeProduct : false,
				refreshTabsStatus : false,
				resetDefault : false,
				onPartAddClicked : true,
				onPartModifyClicked : true,
				onPartDeleteClicked : true,
				loadProjectInformation : false,
				saveAsDefault : false,
				loadContact : false,
				saveContact : false,
				loadSolicitorData : false,
				checkPrice : false,
				closeConfiguration : false,
				createSS : false,
				_refreshPanel : false
			},
			/*
			 * HANDLERS
			 */
			onResetClicked : function(e) {
				var self = e.data.object;

				self.stateMachine.eventBus.fireEvent('onResetClick');
				self._removeTooltips();

				var $this = self.stateMachine.jQuery(this);
				var type = $this.data('product-type');
				var groupId = $this.data('group-id');
				var prodId = $this.data('product-id');
				var rn = Math.floor(Math.random() * 10000);

				self.stateMachine.jQuery.ajax({
					url : "reset/reset_default.jsp?rn=" + rn,
					async : self._ajaxAsyncSettings.resetDefault,
					type : 'POST',
					data : {
						type : type,
						groupId : groupId,
						product_id : prodId
					},
					success : function(data) {
						self.stateMachine.eventBus.fireEvent('afterResetClick');
					},
					error : function(objeto, quepaso, otroobj) {
						self.stateMachine._ajaxError('TabsController', 'onResetClicked', objeto, quepaso, otroobj);
					}
				});

				self.loadConfiguratorPanel('', false);
				//self.refreshTabsStatus();
			},
			onTabClicked : function(e) {
				var self = e.data.object;

				if (self.stateMachine._hasClass(this, 'selected_tab'))
					return false;

				jQuery1_6_4('#solicitorInformationD').validationEngine("hideAll");

				var tabIndex = this.id;
				var firstCellId = this.getAttribute("firstCellId");
				var message = this.getAttribute("message");
				var tabs_number = this.getAttribute("tabs_number");
				var id_text_temp = this.getAttribute("id_text_temp");

				var configuration_summary = (id_text_temp == "01_09");
				var bom = (id_text_temp == "01_10" || id_text_temp == "26_09");
				var project_information = (id_text_temp == "01_11");
				var manifold = self.stateMachine._hasClass(this, 'manifold');
				var stations = self.stateMachine._hasClass(this, 'stations');
				var no_click = self.stateMachine._hasClass(this, 'no_click');

				self.stateMachine.eventBus.fireEvent('onTabClick', [ manifold, stations, configuration_summary, bom,
						no_click, project_information ]);
				self._removeTooltips();

				var oldtab = self._selectedTab;
				// Remove the currently selected tab if current accepts clicking
				if (!self.stateMachine._hasClass(this, 'no_click')) {
					self.stateMachine._removeClass(self._selectedTab, 'selected_tab')._addClass(self._selectedTab,
							'normal_tab');
					self.stateMachine._addClass(this, 'selected_tab')._removeClass(this, 'normal_tab');
					self._selectedTab = this;
				} else {
					alert(message);
				}

				var tabChanged = true;
				if (configuration_summary || bom || project_information) {
					// Configuration summary
					tabChanged = true;
					if (configuration_summary)
						self.loadReportPanel();
					else if (project_information) {
						if (window["user_type"] && window["user_type"] == "0") {
							self.stateMachine._removeClass(this, 'selected_tab')._addClass(this, 'normal_tab');
							self.stateMachine._addClass(oldtab, 'selected_tab')._removeClass(oldtab, 'normal_tab');
							window["action"] = "sy_project_information";
							show_login_dialog();
							tabChanged = false;
							self._selectedTab = oldtab;
						} else {
							self.loadProjectInformationPanel();
						}
					} else
						self.loadBOMPanel();
				} else if (!self.stateMachine._hasClass(this, 'no_click')) {
					// Resto de pesta�as
					tabChanged = true;
					self.loadConfiguratorPanel(firstCellId, true);
				}

				if (tabChanged) {
					// self.refreshTabsStatus();
					self.stateMachine.eventBus.fireEvent('afterTabClick', [ firstCellId, tabIndex, tabChanged ]);
				}

				e.stopPropagation();
				e.preventDefault();
				return false;
			},
			onReportSpecificationClicked : function(e) {
				var self = e.data.object;

				self.stateMachine.eventBus.fireEvent('onReportSpecificationClick');
				self._removeTooltips();

				var minimize = this.getAttribute("minimize");
				var selected_ref = this.id;
				if (minimize == "true") {
					this.setAttribute("minimize", "false");
					self.stateMachine.jQuery(".ik_hidden_specifications").each(
							function(index, value) {
								if (selected_ref == value.id)
									self.stateMachine._removeClass(this, 'ik_hidden_specifications')._addClass(this,
											'ik_show_specifications');
							});
				} else {
					this.setAttribute("minimize", "true");
					self.stateMachine.jQuery(".ik_show_specifications").each(
							function(index, value) {
								if (selected_ref == value.id)
									self.stateMachine._removeClass(this, 'ik_show_specifications')._addClass(this,
											'ik_hidden_specifications');
							});
				}

				self.stateMachine.eventBus.fireEvent('afterReportSpecificationClick');
			},
			onCharacteristicChanged : function(e) {
				console.log("Entra en TabsController.js @ onCharacteristicChanged: Se han hecho cambios que habrá que deshacer ")
				/*
				 * cambios realizados:
				 * 
				 * isRed comprueba si data-status == with_errors en vez de mirar si contiene la clase ik_option_red ( es lo mismo )
				 */
				var self = e.data.object;

				var idCharacteristic = (this.nodeName == 'INPUT') ? this.name : this.id;
				var idOption = this.value;
				var isRed = ( this.data-status == 'with_errors');

				//self._removeTooltips(); //se ha comentado para la nueva version, será necesario solucionarlo en el futuro 29/06/2018

				self.stateMachine.eventBus.fireEvent('onCharacteristicChange', [ idCharacteristic, idOption, isRed ]);

				self.loadConfiguratorPanel('', false);
				self._refreshPanel(-1);// -1 para indicar que no estamos trabajando con una celda nueva, sino con la configuracion actual
				
				//self.refreshTabsStatus();  //se ha comentado para la nueva version, será necesario solucionarlo en el futuro 29/06/2018

				self.stateMachine.eventBus.fireEvent('afterCharacteristicChange');
				$(this).addClass($(this).find("option[value='"+e.target.value+"']").attr("class"));
			},
			afterGraphicalElementClick : function(firstCellId, wasSelected, tab) {
				if (!wasSelected && !this.stateMachine.isSelectingForCopying()) {
					//this._selectTab(this.stateMachine.jQueryCache['tabs'].eq(tab)[0]);// se ha comentado para la nueva version, será necesario solucionarlo en el futuro 02/07/2018
					this.loadConfiguratorPanel(firstCellId, true);
					this._refreshPanel(firstCellId);
					//this.refreshTabsStatus();// se ha comentado para la nueva version, será necesario solucionarlo en el futuro 02/07/2018
				}
			},
			afterBrushClick : function() {
				if (!this.stateMachine.isSelectingForCopying()) {
					this._hideCopyPlaceholder();
					this.loadConfiguratorPanel('', true);
					//this.refreshTabsStatus();
				} else {
					this._showCopyPlaceholder();
				}
			},
			afterMove : function() {
				this.loadConfiguratorPanel('', true);
			},
			afterAddDeleteStationClick : function() {
				if (!this.stateMachine.isSelectingForCopying()) {
					this.loadConfiguratorPanel('', true);
					//this._refreshPanel(-1);// -1 para indicar que no estamos trabajando con una celda nueva, sino con la configuracion actual.
					console.log("**** afterAddDeleteStationClick @ TabsController.js ****")
					//this.refreshTabsStatus();
				}
			},
			afterUndoRedo : function() {
				this.loadConfiguratorPanel('', true);
				//this.refreshTabsStatus();
				this._refreshPanel(-1);
			},
			
			
			/*
			 * Se usa al añadir un producto. la informacion tendrá que ser enviada codificada para evitar problemas con tomcat 
			 * 
			 * Se llama al serveResource : addProduct
			 */
			
			onAddProductClick : function(e) {
				var self = e.data.object;

				var cell_id = this.getAttribute("idCell");
				var product_id = this.getAttribute("idProduct");
				var other_cell_product = this.getAttribute("otherCellProduct");
				var product_tab = this.getAttribute("productTab");
				var product_type = this.getAttribute("productType");
				var cell_type = this.getAttribute("cellType");
				var baseId = this.getAttribute("baseProductId");

				product_tab = product_tab - 1;
				var randomnumber = Math.floor(Math.random() * 10000);
				self.stateMachine.jQuery.ajax({
					url : addProduct,
					async : self._ajaxAsyncSettings.onAddProductClick,
					data : "idCell=" + encodeURI(cell_id) + "&idProduct=" + encodeURI(product_id) + "&otherCellProduct=" + encodeURI(other_cell_product)
							+ "&productType=" + encodeURI(product_type),
							dataType: 'html',
					success : function(data) {
						//self.refreshTabsStatus();
						self.loadConfiguratorPanel(cell_id, true);
						self._refreshPanel(cell_id);
						
						self.stateMachine._check();
						self.stateMachine.eventBus.fireEvent('afterAddProductClick');
						self.stateMachine.eventBus.fireEvent('onAddProductClick', [ product_id, cell_id, cell_type, baseId ]);
					},
					error : function(objeto, quepaso, otroobj) {
						self.stateMachine.controllers['graphical_tools']._refresh();
						self.stateMachine._ajaxError('TabsController', 'onAddProductClick', objeto, quepaso, otroobj);
						smc.NotifyComponent.error(globalError);
					}
				});

				e.stopPropagation();
				return false;
			},
			onDeleteProductClick : function(e) {
				var self = e.data.object;
				self.stateMachine.eventBus.fireEvent('onDeleteProductClick');

				var randomnumber = Math.floor(Math.random() * 10000);
				self.stateMachine.jQuery.ajax({
					url : "actions/delete_product.jsp?rn=" + randomnumber,
					async : self._ajaxAsyncSettings.onAddProductClick,
					beforeSend : function(objeto) {
						self.stateMachine.jQuery(this).text("PROCESANDO");
					},
					success : function(data) {
						self.loadConfiguratorPanel("", true);

						// if (self._selectedTab.id != 0)
						//	self.refreshTabsStatus();

						self.stateMachine.eventBus.fireEvent('afterDeleteProductClick');
					},
					error : function(objeto, quepaso, otroobj) {
						self.stateMachine
								._ajaxError('TabsController', 'onDeleteProductClick', objeto, quepaso, otroobj);
					}
				});
			},
			afterAddToBasket : function() {
				this.loadReportPanel();
				this.stateMachine.eventBus.fireEvent('onTabClick', [ false, false, true, false, false ]);
				var tabElem = this.stateMachine.jQueryCache['tabs'].eq('-2')[0];
				this._selectTab(tabElem);
				this.stateMachine.eventBus.fireEvent('afterTabClick', [ tabElem.getAttribute('firstCellId'),
						tabElem.id, true ]);
			},
			onPartAddClicked : function(e) {
				var self = e.data.object;
				var ref = self.stateMachine.jQuery.trim(self.stateMachine.jQueryCache['configuratorPanel'].find(
						'#element_part_reference').val());
				var qty = window.parseDecimalInt(self.stateMachine.jQueryCache['configuratorPanel'].find(
						'#element_part_quantity').val());

				if (ref != '' && !isNaN(qty)) {
					self.stateMachine.eventBus.fireEvent('onFreeReferencePartAdded');

					$.ajaxHippo({
						url : addFreeElementPartUrl,
						async : self._ajaxAsyncSettings.onPartAddClicked,
						data : "ref=" + encodeURIComponent(ref) + "&qty=" + qty,
						dataType : 'json',
						stateMachine : self.stateMachine,
						type : "POST",
						success : function(data) {
							data.status = data.reference != '' && data.elements.length > 0 ? "correct" : "incomplete";
							self._updateReference(data);

							if (typeof data['elements'] != 'undefined') {
								self._rebuildElementPartsTable(data['elements']);
							}
							self.stateMachine.jQueryCache['configuratorPanel'].find('#element_part_reference').val('');
							self.stateMachine.jQueryCache['configuratorPanel'].find('#element_part_quantity').val('');

							// self.refreshTabsStatus();

							self.stateMachine.eventBus.fireEvent('afterFreeReferencePartAdded');

						}
					});
				}
			},
			onPartModifyClicked : function(e) {
				var self = e.data.object;

				if (self.stateMachine.jQueryCache['configuratorPanel'].find('.element_part_selected').length > 0) {
					var ref = self.stateMachine.jQuery.trim(self.stateMachine.jQueryCache['configuratorPanel'].find(
							'#element_part_reference').val());
					var qty = window.parseDecimalInt(self.stateMachine.jQueryCache['configuratorPanel'].find(
							'#element_part_quantity').val());
					var old_ref = self.stateMachine.jQueryCache['configuratorPanel'].find(
							'.element_part_selected .free_elements_table_left').html();

					if (ref != '' && !isNaN(qty)) {
						self.stateMachine.eventBus.fireEvent('onFreeReferencePartModified');

						$.ajaxHippo({
							url : modifyFreeElementPartUrl,
							async : self._ajaxAsyncSettings.onPartModifyClicked,
							data : "ref=" + encodeURIComponent(ref) + "&qty=" + qty + "&old_ref=" + old_ref,
							dataType : 'json',
							type : "POST",
							stateMachine : self.stateMachine,
							success : function(data) {
								if (typeof data['elements'] != 'undefined') {
									self._rebuildElementPartsTable(data['elements']);
								}
								self.stateMachine.jQueryCache['configuratorPanel'].find('#element_part_reference').val(
										'');
								self.stateMachine.jQueryCache['configuratorPanel'].find('#element_part_quantity').val(
										'');

								self.stateMachine.eventBus.fireEvent('afterFreeReferencePartModified');
							}
						});
					}
				}
			},
			onPartDeleteClicked : function(e) {
				var self = e.data.object;

				if (self.stateMachine.jQueryCache['configuratorPanel'].find('.element_part_selected').length > 0) {
					self.stateMachine.eventBus.fireEvent('onFreeReferencePartDeleted');

					var selected = self.stateMachine.jQueryCache['configuratorPanel']
							.find('.free_element_parts_body .element_part_selected');

					var ref = selected.find('.free_elements_table_left').html();
					var qty = selected.find('.free_elements_table_right').html();
					var pos = selected.prev().length;

					$.ajaxHippo({
						url : deleteFreeElementPartUrl,
						async : self._ajaxAsyncSettings.onPartDeleteClicked,
						data : "ref=" + ref + "&qty=" + qty + "&pos=" + pos,
						dataType : 'json',
						type : "POST",
						stateMachine : self.stateMachine,
						success : function(data) {
							data.status = data.reference != '' && data.elements.length > 0 ? "correct" : "incomplete";
							self._updateReference(data);

							if (typeof data['elements'] != 'undefined') {
								self._rebuildElementPartsTable(data['elements']);
							}
							self.stateMachine.jQueryCache['configuratorPanel'].find('#element_part_reference').val('');
							self.stateMachine.jQueryCache['configuratorPanel'].find('#element_part_quantity').val('');

							// self.refreshTabsStatus();

							self.stateMachine.eventBus.fireEvent('afterFreeReferencePartDeleted');
						}
					});
				}
			},
			onPartElementClicked : function(e) {
				var self = e.data.object;

				var $row = self.stateMachine.jQuery(this);
				if ($row.hasClass('element_part_selected')) {
					$row.removeClass('element_part_selected');
				} else {
					self.stateMachine.jQueryCache['configuratorPanel'].find('.element_part_selected').removeClass(
							'element_part_selected');
					$row.addClass('element_part_selected');
					self.stateMachine.jQueryCache['configuratorPanel'].find('#element_part_reference').val(
							$row.find('.free_elements_table_left').html());
					self.stateMachine.jQueryCache['configuratorPanel'].find('#element_part_quantity').val(
							$row.find('.free_elements_table_right').html());
				}
			},
			onPartQuantityEdited : function(e) {
				if ((e.charCode > 31 && (e.charCode < 48 || e.charCode > 57))
						|| ($(this).val() == "" && e.charCode == 48)) {
					e.preventDefault();
				}

			},
			onRefreshManifoldSpecialVisibility : function(e) {
				if (!$(this).hasClass('disabled')) {
					var self = e.data.object;
					var randomnumber = Math.floor(Math.random() * 10000);
					var mode = $(this).attr('mode');
					var free_product_enabled = $(this).attr('free_product_enabled');
					self.stateMachine.jQuery.ajax({
						url : "save/change_standar_customized.jsp?rn=" + randomnumber,
						data : {
							'mode' : mode
						},
						stateMachine : self.stateMachine,
						success : function(data) {
							if ($.trim(data) != '') {
								$('#manifoldSpecialContainer').html(data);
							}
							if (mode == 'disabled') {
								$('#characteristic_option_div input').removeAttr('disabled');
								$('#characteristic_option_div select').removeAttr('disabled');
								$('#manifoldSpecialContainer').hide();
								$('#manifoldSpecialButton').attr('mode', 'enabled');
								$('#manifoldSpecialButton').text($('#manifoldSpecialButton').attr('enabled_text'));
								if (free_product_enabled == 'false')
									$('#manifoldSpecialButton').css('display', 'none');
							} else {
								$('#characteristic_option_div input').attr('disabled', 'disabled');
								$('#characteristic_option_div select').attr('disabled', 'disabled');
								$('#manifoldSpecialContainer').show();
								$('#manifoldSpecialButton').attr('mode', 'disabled');
								$('#manifoldSpecialButton').text($('#manifoldSpecialButton').attr('disabled_text'));
								if (free_product_enabled == 'false')
									$('#manifoldSpecialButton').css('display', 'none');
							}

							self.stateMachine.eventBus.fireEvent('aftermanifoldSpecialButtonClick');
						}
					});
				}
			},
			onAddReference : function(e) {
				var self = e.data.object;

				var description = $('#descriptionRef').val();
				var reference = $('#referenceRef').val();
				var quantity = $('#quantityRef').val();
				var price = $('#priceRef').val();

				if (description == '' || reference == '' || quantity == '' || price == '') {
				} else {
					$.ajaxHippo({
						url : addCustomizedManifoldReferenceUrl,
						data : {
							'description' : description,
							'reference' : reference,
							'quantity' : quantity
						},
						type : "POST",
						stateMachine : self.stateMachine,
						success : function(data) {
							$('#manifoldReferenceTable').append(
									'<tr class=\"manifoldReferenceRow\"><td><div class=\"td_content text description\">'
											+ description + '</div></td>'
											+ '<td><div class=\"td_content text reference\">' + reference + '</div>'
											+ '<td><div class=\"td_content text quantity numeric\">' + quantity
											+ '</div>' + '</tr>');
							$('#manifoldReferenceInput input').val('');
							$('#manifoldReferenceTable tr').removeClass('selected');
						}
					});
				}
			},
			onModifyReference : function(e) {
				var self = e.data.object;

				var newDescription = $('#descriptionRef').val();
				var newReference = $('#referenceRef').val();
				var newQuantity = $('#quantityRef').val();
				var newPrice = $('#priceRef').val();
				var old_reference_index = $('#manifoldReferenceTable tr.selected').index();

				if (old_reference_index == '-1'
						|| (newDescription == '' || newReference == '' || newQuantity == '' || newPrice == '')) {
				} else {
					$.ajaxHippo({
						url : modifyCustomizedManifoldReferenceUrl,
						data : {
							'newDescription' : newDescription,
							'newReference' : newReference,
							'newQuantity' : newQuantity,
							'newPrice' : newPrice,
							'old_reference_index' : old_reference_index
						},
						type : "POST",
						stateMachine : self.stateMachine,
						success : function(data) {
							$('#manifoldReferenceTable tr.selected div.description').text(newDescription);
							$('#manifoldReferenceTable tr.selected div.reference').text(newReference);
							$('#manifoldReferenceTable tr.selected div.quantity').text(newQuantity);
							$('#manifoldReferenceTable tr.selected div.price').text(newPrice);

							$('#manifoldReferenceInput input').val('');
							$('#manifoldReferenceTable tr').removeClass('selected');
						}
					});
				}
			},
			onDeleteReference : function(e) {
				var self = e.data.object;

				var old_reference_index = $('#manifoldReferenceTable tr.selected').index();

				if (old_reference_index == '-1') {
				} else {
					$.ajaxHippo({
						url : deleteCustomizedManifoldReferenceUrl,
						data : {
							'old_reference_index' : old_reference_index
						},
						stateMachine : self.stateMachine,
						success : function(data) {
							$('#manifoldReferenceTable tr.selected').remove();
							$('#manifoldReferenceInput input').val('');
							$('#manifoldReferenceTable tr').removeClass('selected');
						}
					});
				}
			},
			onAddBom : function(e) {
				var self = e.data.object;

				var reference = $('#referenceBom').val();
				var quantity = $('#quantityBom').val();

				if (reference == '' || quantity == '') {
				} else {
					$.ajaxHippo({
						url : addCustomizedManifoldPartUrl,
						data : {
							'reference' : reference,
							'quantity' : quantity
						},
						type : "POST",
						stateMachine : self.stateMachine,
						success : function(data) {
							$('#manifoldBomTable').append(
									'<tr class=\"manifoldBomRow\">' + '<td><div class=\"td_content text reference\">'
											+ reference + '</div>'
											+ '<td><div class=\"td_content text quantity numeric\">' + quantity
											+ '</div>' + '</tr>');
							$('#manifoldBomInput input').val('');
							$('#manifoldBomTable tr').removeClass('selected');
						}
					});
				}
			},
			onModifyBom : function(e) {
				var self = e.data.object;

				var reference = $('#referenceBom').val();
				var quantity = $('#quantityBom').val();
				var old_reference_index = $('#manifoldBomTable tr.selected').index();

				if (old_reference_index == '-1' || (reference == '' || quantity == '')) {
				} else {
					$.ajaxHippo({
						url : modifyCustomizedManifoldPartUrl,
						data : {
							'reference' : reference,
							'quantity' : quantity,
							'old_reference_index' : old_reference_index
						},
						type : "POST",
						stateMachine : self.stateMachine,
						success : function(data) {
							$('#manifoldBomTable tr.selected div.reference').text(reference);
							$('#manifoldBomTable tr.selected div.quantity').text(quantity);

							$('#manifoldBomInput input').val('');
							$('#manifoldBomTable tr').removeClass('selected');
						}
					});
				}
			},
			onDeleteBom : function(e) {
				var self = e.data.object;

				var old_reference_index = $('#manifoldBomTable tr.selected').index();

				if (old_reference_index == '-1') {
				} else {
					$.ajaxHippo({
						url : deleteCustomizedManifoldPartUrl,
						data : {
							'old_reference_index' : old_reference_index
						},
						stateMachine : self.stateMachine,
						success : function(data) {
							$('#manifoldBomTable tr.selected').remove();
							$('#manifoldBomInput input').val('');
							$('#manifoldBomTable tr').removeClass('selected');
						}
					});
				}
			},
			onDimensionCheck : function(e) {
				var self = e.data.object;
				var afectDimension = $('#dimensionCheck').attr('checked');

				$.ajaxHippo({
					url : setDimensionsUrl,
					data : {
						'afect_dimension' : afectDimension
					},
					stateMachine : self.stateMachine,
					success : function(data) {
						self.stateMachine.eventBus.fireEvent('afterFreeReferenceMeasuresClick');
					}
				});
			},
			onResetSpecialManifold : function(e) {
				var self = e.data.object;
				var $this = self.stateMachine.jQuery(this);
				var message = $this.attr('message');
				var randomnumber = Math.floor(Math.random() * 10000);

				if (message != "") {
					result = window.confirm(message);
					if (result) {
						$.ajaxHippo({
							url : resetCustomizedManifoldUrl,
							stateMachine : self.stateMachine,
							success : function(data) {
								if ($.trim(data) != '') {
									$('#manifoldSpecialContainer').html(data);
									self.stateMachine.eventBus.fireEvent('aftermanifoldSpecialButtonClick');
								}
							}
						});
					}
				}
			},
			onMarkeReference : function(e) {
				var self = e.data.object;
				$(this).siblings().removeClass('selected')
				$(this).addClass('selected');
				$('#descriptionRef').val($(this).find('.description').text());
				$('#referenceRef').val($(this).find('.reference').text());
				$('#quantityRef').val($(this).find('.quantity').text());
				$('#priceRef').val($(this).find('.price').text());
			},
			onMarkeBom : function(e) {
				var self = e.data.object;
				$(this).siblings().removeClass('selected');
				$(this).addClass('selected');
				$('#referenceBom').val($(this).find('.reference').text());
				$('#quantityBom').val($(this).find('.quantity').text());
			},
			onSaveAsDefaultClicked : function(e) {
				var rn = Math.floor(Math.random() * 10000);
				var solicitorName = document.getElementById("solicitorNameInput").value;
				var solicitorCompany = document.getElementById("solicitorCompanyInput").value;
				var errorMessage = document.getElementById("solicitorErrorMessage").value;
				var valid = jQuery1_6_4('#solicitorInformationD').validationEngine("hideAll").validationEngine(
						"validate");
				if (valid) {
					var self = e.data.object;
					self.stateMachine.jQuery.ajax({
						url : "project_information/save_as_default.jsp?rn=" + rn,
						async : self._ajaxAsyncSettings.saveAsDefault,
						type : "POST",
						data : $("#designerContact input").serializeArray(),
						// beforeSend: self._showConfiguratorPanelPlaceholder,
						dataType : "html",
						stateMachine : self.stateMachine,
						success : function(data) {
							$("#solicitorNameInput").focus();
							alert($("#solicitorSavedMessage").val());
						}
					});
				} else {
					alert(errorMessage);
				}

			},
			onCheckPriceClicked : function(e) {
				var rn = Math.floor(Math.random() * 10000);
				var self = e.data.object;
				var isDisabled = self.stateMachine._hasClass(this, 'sy_proccess_gray');
				var $this = self.stateMachine.jQuery(this);
				var message = $this.attr('message');
				if (isDisabled == false) {
					self.stateMachine.jQuery.ajax({
						url : "movex/check_price.jsp?rn=" + rn,
						async : self._ajaxAsyncSettings.checkPrice,
						type : 'POST',
						success : function(data) {
							if ($.trim(data) == 'novalid') {
								window.alert(message);
							}
							self.loadBOMPanel();
						},
						error : function(objeto, quepaso, otroobj) {
							self.stateMachine._ajaxError('TabsController', 'onCheckPriceClicked', objeto, quepaso,
									otroobj);
						}
					});
				}
			},
			onCloseConfigurationClicked : function(e) {
				var rn = Math.floor(Math.random() * 10000);
				var self = e.data.object;
				var $this = self.stateMachine.jQuery(this);
				var message1 = $this.attr('message1');
				var message2 = $this.attr('message2');
				var isDisabled = self.stateMachine._hasClass(this, 'sy_proccess_gray');
				if (isDisabled == false) {
					if (message1 != "") {
						result = window.confirm(message1);
						if (result) {
							window.alert(message2);
							self.stateMachine.jQuery.ajax({
								url : "movex/close_configuration.jsp?rn=" + rn,
								async : self._ajaxAsyncSettings.closeConfiguration,
								type : 'POST',
								success : function(data) {
									self.loadBOMPanel();
									self.stateMachine.closedConfiguration = 'true';
								},
								error : function(objeto, quepaso, otroobj) {
									self.stateMachine._ajaxError('TabsController', 'onCloseConfigurationClicked',
											objeto, quepaso, otroobj);
								}
							});
						}
					}
				}
			},
			onCreateSSClicked : function(e) {
				var rn = Math.floor(Math.random() * 10000);
				var self = e.data.object;
				var isDisabled = self.stateMachine._hasClass(this, 'sy_proccess_gray');
				if (isDisabled == false) {
					SYAssistantViewModel.launchAssistant();
				}
			},
			cleanValidationMessage : function(e) {
				$(this).validationEngine('hide').validationEngine('validate');
			},
			onLoadDefaultClicked : function(e) {
				var rn = Math.floor(Math.random() * 10000);
				var self = e.data.object;
				self.stateMachine.jQuery.ajax({
					url : "project_information/load_contact.jsp?rn=" + rn,
					async : self._ajaxAsyncSettings.loadContact,
					data : {
						name : "default"
					},
					stateMachine : self.stateMachine,
					dataType : "JSON",
					type : "POST",
					success : function(data) {
						var errorMessage = data["aviso"];
						var cts = data && data["contactN"] ? window.parseDecimalInt(data["contactN"]) : 0;
						var cPanel = $("#designerContact");
						if (cts == 1) {
							jQuery1_6_4('#solicitorInformationD').validationEngine("hideAll");
							cPanel.find("#solicitorAddressInput").val(data["contacts"][0]["address"]).end().find(
									"#solicitorCompanyInput").val(data["contacts"][0]["company"]).end().find(
									"#solicitorEmailInput").val(data["contacts"][0]["email"]).end().find(
									"#solicitorFaxInput").val(data["contacts"][0]["fax"]).end().find(
									"#solicitorNameInput").val(data["contacts"][0]["name"]).end().find(
									"#solicitorPhoneInput").val(data["contacts"][0]["phone"]).end().find(
									"#solicitorTownInput").val(data["contacts"][0]["town"]).end().find(
									"#solicitorZIPInput").val(data["contacts"][0]["zip"]).end();
							var dataInput = $.merge($("#designerContact input, #projDescInput").serializeArray(), $(
									"#customerContact input").serializeArray());
							self.stateMachine.jQuery.ajax({
								url : "project_information/save_project_information.jsp?rn=" + rn,
								async : self._ajaxAsyncSettings.saveContact,
								dataType : "JSON",
								type : "POST",
								data : dataInput,
								stateMachine : self.stateMachine,
							});
						} else {
							alert(data["aviso"], data["titulo_ventana"]);
						}
					}
				});
			},
			onLoadContactClicked : function(e) {
				var rn = Math.floor(Math.random() * 10000);
				var self = e.data.object;
				self.stateMachine.jQuery.ajax({
					url : "project_information/load_contact.jsp?rn=" + rn,
					async : self._ajaxAsyncSettings.loadContact,
					data : {
						name : $("#customerNameInput").val()
					},
					stateMachine : self.stateMachine,
					dataType : "JSON",
					type : "POST",
					success : function(data) {
						var errorMessage = data["aviso"];
						var cts = data && data["contactN"] ? window.parseDecimalInt(data["contactN"]) : 0;
						var cPanel = $("#customerContact");
						if (cts == 1) {
							jQuery1_6_4('#solicitorInformationD').validationEngine("hideAll");
							cPanel.find("#customerAddressInput").val(data["contacts"][0]["address"]).end().find(
									"#customerCompanyInput").val(data["contacts"][0]["company"]).end().find(
									"#customerEmailInput").val(data["contacts"][0]["email"]).end().find(
									"#customerFaxInput").val(data["contacts"][0]["fax"]).end().find(
									"#customerNameInput").val(data["contacts"][0]["name"]).end().find(
									"#customerPhoneInput").val(data["contacts"][0]["phone"]).end().find(
									"#customerTownInput").val(data["contacts"][0]["town"]).end().find(
									"#customerZIPInput").val(data["contacts"][0]["zip"]).end().find("#customerId").val(
									data["contacts"][0]["id"]).end();
							self.stateMachine.jQuery.ajax({
								url : "project_information/save_project_information.jsp?rn=" + rn,
								async : self._ajaxAsyncSettings.saveContact,
								dataType : "JSON",
								type : "POST",
								data : $("#customerContact input").serializeArray(),
								stateMachine : self.stateMachine,
							});
						} else if (cts > 1) {
							self._showContacts(data["contacts"], data["titulo_ventana"], data["maxima_anchura"]);
						} else {
							self._showMessage(data["aviso"], data["titulo_ventana"]);
						}
					}
				});
			},
			onSaveContactClicked : function(e) {
				var rn = Math.floor(Math.random() * 10000);
				var customerName = document.getElementById("customerNameInput").value;
				var valid = jQuery1_6_4('#solicitorInformationC').validationEngine("validate");
				var errorMessage = document.getElementById("customerErrorMessage").value;
				if (valid) {
					var self = e.data.object;
					self.stateMachine.jQuery.ajax({
						url : "project_information/save_contact.jsp?rn=" + rn,
						async : self._ajaxAsyncSettings.saveContact,
						dataType : "html",
						type : "POST",
						data : $("#customerContact input").serializeArray(),
						// beforeSend: self._showConfiguratorPanelPlaceholder,
						stateMachine : self.stateMachine,
						success : function(data) {
							$("#customerNameInput").focus();
							alert($("#customerSavedMessage").val());
						}
					});
				} else {
					alert(errorMessage);
				}
			},
			onContactClicked : function(e) {
				var rn = Math.floor(Math.random() * 10000);
				var self = e.data.object;
				var cPanel = $("#customerContact");
				var anchor = $("#mockAnchor");
				var contacts = anchor.data("contacts");
				var index = $(this).attr("data-index");
				var id = this.id.replace("contact_", "");

				var cont = _.filter(contacts, function(e) {
					return e.id == id;
				})[0];

				jQuery1_6_4('#solicitorInformationD').validationEngine("hideAll");

				cPanel.find("#customerAddressInput").val(cont["address"]).end().find("#customerCompanyInput").val(
						cont["company"]).end().find("#customerEmailInput").val(cont["email"]).end().find(
						"#customerFaxInput").val(cont["fax"]).end().find("#customerNameInput").val(cont["name"]).end()
						.find("#customerPhoneInput").val(cont["phone"]).end().find("#customerTownInput").val(
								cont["town"]).end().find("#customerZIPInput").val(cont["zip"]).end()
						.find("#customerId").val(cont["id"]).end();
				$(this).parents(".ui-tooltip-content:first").parent().find(".ui-icon-close").click();

				self.stateMachine.jQuery.ajax({
					url : "project_information/save_project_information.jsp?rn=" + rn,
					async : self._ajaxAsyncSettings.saveContact,
					dataType : "JSON",
					type : "POST",
					data : $("#customerContact input").serializeArray(),
					// beforeSend:
					// self._showConfiguratorPanelPlaceholder,
					stateMachine : self.stateMachine,
				// success: function(data) {
				// self._hideConfiguratorPanelPlaceholder();
				// self.stateMachine.jQueryCache['configuratorPanel'].html(data);
				// }
				});

				return false;
			},
			onNoContactClicked : function(e) {
				$(this).parents(".ui-tooltip-content:first").parent().find(".ui-icon-close").click();
			},
			onDeleteContactClicked : function(e) {
				var randomnumber = Math.floor(Math.random() * 10000);
				var self = e.data.object;
				var anchor = $("#mockAnchor");
				var contacts = anchor.data("contacts");
				var index = $(this).attr("data-index");
				var that = this;
				var container = $(that).parents("#multipleContactWrapper");

				self.stateMachine.jQuery.ajax({
					url : "project_information/delete_contact.jsp?rn=" + randomnumber,
					async : self._ajaxAsyncSettings.deleteContact,
					dataType : "JSON",
					type : "POST",
					data : {
						id : this.id.replace("contact_", "")
					},
					stateMachine : self.stateMachine,
					success : function(data) {
						$(that).parent().remove();
						if (container.find("div").length == 0) {
							container.parents(".ui-tooltip-content:first").parent().find(".ui-icon-close").click();
						}
					}
				});
			},
			/*
			 * METHODS
			 */
			loadReportPanel : function() {
				var randomnumber = Math.floor(Math.random() * 10000);
				var self = this;
				this._removeTooltips();

				var ajaxFunc = function() {
					self.stateMachine.jQuery.ajax({
						url : self.drawingPath + "draw_report_panel.jsp?rn=" + randomnumber,
						async : self._ajaxAsyncSettings.loadReportPanel,
						data : "toBasket=false",
						stateMachine : self.stateMachine,
						success : function(data) {
							self._updatePanelContent(data);
						}
					});
				};

				self._loadPanelViaAjax(ajaxFunc);
			},
			loadBOMPanel : function() {
				var randomnumber = Math.floor(Math.random() * 10000);
				var self = this;
				this._removeTooltips();
				var ajaxFunc = function() {
					self.stateMachine.jQuery.ajax({
						url : self.drawingPath + "draw_bom_panel.jsp?rn=" + randomnumber,
						async : self._ajaxAsyncSettings.loadBOMPanel,
						stateMachine : self.stateMachine,
						success : function(data) {
							self._updatePanelContent(data);
						}
					});
				};

				self._loadPanelViaAjax(ajaxFunc);
			},
			loadProjectInformationPanel : function() {
				var randomnumber = Math.floor(Math.random() * 10000);
				var self = this;
				this._removeTooltips();
				var ajaxFunc = function() {
					self.stateMachine.jQuery.ajax({
						url : self.drawingPath + "draw_project_information_panel.jsp?rn=" + randomnumber,
						async : self._ajaxAsyncSettings.loadProjectInformation,
						data : "toBasket=false",
						stateMachine : self.stateMachine,
						success : function(data) {
							self._updatePanelContent(data, function() {
								jQuery1_6_4.validationEngineLanguage = $.validationEngineLanguage;
								jQuery1_6_4('#solicitorInformationD').validationEngine({
									promptPosition : 'topRight:-10'
								});
								jQuery1_6_4('#solicitorInformationC').validationEngine({
									promptPosition : 'topRight:-10'
								});
							});
						}
					});
				};

				self._loadPanelViaAjax(ajaxFunc);
			},

			loadConfiguratorPanel : function(firstCellId, showAjax, isCopying) {
				
				
				console.log("inicio loadConfiguratorPanel");
				
				
				var randomnumber = Math.floor(Math.random() * 10000);
				var self = this;
				var selected_cell = (typeof firstCellId != 'undefined' && firstCellId != '') ? 'selectedIdCell='
						+ firstCellId : '';
				//this._removeTooltips(); // se ha comentado para la nueva version, será necesario solucionarlo en el futuro 29/06/2018

				var options = {
					url : resourceUrl1 , //this.drawingPath + "draw_cell_configuration.jsp?rn=" + randomnumber,
					async : self._ajaxAsyncSettings.loadConfiguratorPanel,
					data : encodeURI(selected_cell) + "&scripts=false",
					success : function(data) {
						var callback = function() {
							/*  se ha comentado para la nueva version, será necesario solucionarlo en el futuro 29/06/2018
							 *
							*/
							 $('.ik_state_image.with_errors').simpleTooltip({
									tooltipType : 'error',
									tooltipOnHover : false,
									tooltipOnClick : true
								});
							self.initializeCharacteristicVisibility();
							self.apply_mask();
							/*
							 *  //se ha comentado para la nueva version, será necesario solucionarlo en el futuro 29/06/2018
							 *  self.redrawReference();
							 */
							if (isCopying)
								self._showCopyPlaceholder();
						};
						/* /se ha comentado para la nueva version, será necesario solucionarlo en el futuro 04/07/2018
						if (showAjax) {
							self._updatePanelContent(data, callback);
						} else {
							self.stateMachine.jQueryCache['configuratorPanel'].html(data);
							self._hideConfiguratorPanelPlaceholder();
							callback();
						}
						*/
						
						
						//self._refreshPanel(selected_cell);
					}
				};

				var ajaxFunc = function() {
					self.stateMachine.jQuery.ajax(options);
				};

				if (showAjax) {
					// options['beforeSend'] =
					// self._showConfiguratorPanelPlaceholder;
					// options['complete'] =
					// self._hideConfiguratorPanelPlaceholder;
					options['stateMachine'] = self.stateMachine;
				}
				
				/*
				if (showAjax) {
					//Da error ya que se intenta cargar un gif que no existe.
					//se ha comentado para la nueva version, será necesario solucionarlo en el futuro 29/06/2018
					
					// self._loadPanelViaAjax(ajaxFunc);
					
				} else {
					//se ha comentado para la nueva version, será necesario solucionarlo en el futuro 29/06/2018
					// si se deja descomentado, al cambiar de valor la opcion/caracteristica, la parte inferior del configurador no se verá
					 ajaxFunc();
				}
				*/
				if ( showAjax ){
					ajaxFunc();
				}
				
				console.log("fin loadConfiguratorPanel , showAjax : " + showAjax);
				
			},
			/*
			 * Metodo creado para redibujar configurator_panel_div
			 */
			_refreshPanel : function(data) {
				var self = this;
				console.log("entra en StateMachine.js @ _refreshPanel corregido:" + data ) ;	
				
				self.stateMachine.jQuery.ajax({
					url :refreshPanel,
					async : self._ajaxAsyncSettings._refreshPanel,
					data : "selectedIdCell="+encodeURI(data),
					dataType : "html",
					success : function(data) {
						data = $.parseHTML(data)[1]
						
						$("#configurator_panel_div").html($(data).html());
						$('#products_div > fieldset:nth-child(2) > h3' ).remove();
					}
				});			
				
			},
			loadReferenceFreeProduct : function(e) {
				var self = e.data.object;

				self.stateMachine.eventBus.fireEvent('onFreeReferenceEntered');

				var ref = this.value;
				if (ref != self.stateMachine.jQuery(this).data('text')) {
					self.stateMachine.jQuery(this).data('text', ref);
					$.ajaxHippo({
						url : saveFreeElementReferenceUrl,
						async : self._ajaxAsyncSettings.loadReferenceFreeProduct,
						data : "ref=" + encodeURIComponent(ref),
						dataType : "JSON",
						success : function(data) {
							data.status = data.reference != ''
									&& self.stateMachine.jQuery(".element_part_row").length > 0 ? "correct"
									: "incomplete";
							self._updateReference(data);

							// self.refreshTabsStatus();

							self.stateMachine.eventBus.fireEvent('afterFreeReferenceEntered');
						}
					});
				}
			},
			loadHideMeasuresFreeProduct : function(e) {
				var self = e.data.object;

				self.stateMachine.eventBus.fireEvent('onFreeReferenceMeasuresClick');

				var checked = this.checked;
				$.ajaxHippo({
					url : saveFreeHiddenMeassuresUrl,
					type : "POST",
					async : self._ajaxAsyncSettings.loadHideMeasuresFreeProduct,
					data : "hidde=" + checked,
					success : function(data) {
						self.stateMachine.eventBus.fireEvent('afterFreeReferenceMeasuresClick');
					}
				});
			},
			loadSolicitorData : function(e) {
				var self = e.data.object;
				var randomnumber = Math.floor(Math.random() * 10000);
				var dataInput = $.merge($("#designerContact input, #projDescInput").serializeArray(), $(
						"#customerContact input").serializeArray());
				self.stateMachine.jQuery.ajax({
					url : "project_information/save_project_information.jsp?rn=" + randomnumber,
					async : self._ajaxAsyncSettings.loadSolicitorData,
					data : dataInput,
					dataType : "JSON",
					type : "POST",
					stateMachine : self.stateMachine,
				});
				return false;
			},
			refreshTabsStatus : function(actname) {
				actname = actname ? actname : "";
				var self = this;
				var rn = Math.floor(Math.random() * 10000);
				var seeingReport = self.stateMachine.jQueryCache['tabs'].slice(-2).filter('.selected_tab').length > 0;
				this.stateMachine.jQuery.ajax({
					url : this.refreshPath + 'refresh_tabs.jsp?rn=' + rn + '&act=' + actname,
					dataType : 'json',
					async : self._ajaxAsyncSettings.refreshTabsStatus,
					success : function(json) {
						for ( var index in json.tabs) {
							var $elem = self.stateMachine.jQueryCache['tabs'].filter(':eq(' + index + ')');
							$elem.attr("firstCellId", json.tabs[index].firstCellId).attr("message",
									json.tabs[index].message).removeClass("click").removeClass("no_click").addClass(
									json.tabs[index].click).find('span.tabsSprite').removeClass("amarillo")
									.removeClass("verde").removeClass("rojo").addClass(json.tabs[index].productState);
							/*
							 * if (!seeingReport) { if
							 * (json.tabs[index].selected_tab)
							 * $elem.addClass('selected_tab'); else
							 * $elem.removeClass('selected_tab'); }
							 */
						}
						self.stateMachine.jQueryCache['tabs'].each(function() {
							this.className += " tabn_" + this.getAttribute("tabs_number");
						});
						if (json.tabs[0].productState == 'verde') {
							$('#manifoldSpecialButton').removeClass('disabled');
						} else {
							$('#manifoldSpecialButton').addClass('disabled');
						}
						self.stateMachine.updateGroupState(json["group_state"]);
					}
				});
			},
			redrawReference : function() {
				var that = this;
				this.stateMachine.jQuery.getJSON(this.drawingPath + "draw_product_reference.jsp?rn="
						+ Math.floor(Math.random() * 10000), function(data) {
					that._updateReference(data);
				});
				this.stateMachine.controllers['graphical_tools']._refresh();
			},
			initializeCharacteristicVisibility : function() {
				if ($('#characteristic_option_div').attr('is_special_free_product') == 'true'
						|| $('#characteristic_option_div').attr('is_closed_configuration') == 'true') {
					$('#characteristic_option_div input').attr('disabled', 'disabled');
					$('#characteristic_option_div select').attr('disabled', 'disabled');
					$('#manifoldSpecialContainer').show();
					$('#manifoldSpecialButton').text($('#manifoldSpecialButton').attr('disabled_text'));
				} else {
					$('#characteristic_option_div input').removeAttr('disabled');
					$('#characteristic_option_div select').removeAttr('disabled');
					$('#manifoldSpecialContainer').hide();
					$('#manifoldSpecialButton').text($('#manifoldSpecialButton').attr('enabled_text'));
				}
			},
			apply_mask : function() {
				this.stateMachine.jQuery('.quantity_mask').autoNumeric('init', {
					vMin : '0',
					vMax : '999',
					aSep : '',
					aPad : false
				});
				this.stateMachine.jQuery('.price_mask').autoNumeric('init', {
					vMin : '0',
					vMax : '99999999',
					mDec : '2',
					aSep : '',
					aPad : false
				});
			},
			/*
			 * "PRIVATE" METHODS
			 */
			_showConfiguratorPanelPlaceholder : function() {
				var self = this.stateMachine;
				// var width = _.reduce(self.jQueryCache['tabs'].map(function(){
				// return this.offsetWidth;}).toArray(),function(memo,elem){
				// return memo + elem;},0);
				// //self.stateMachine.jQueryCache['configuratorPanel'].width();
				// var height = 70;
				// var offset = self.jQueryCache['configuratorPanel'].offset();
				// if (typeof offset !== 'undefined') offset.left = 0;
				// self.jQueryCache['configuratorPanelPlaceholder'].width(width);
				// self.jQueryCache['configuratorPanelPlaceholder'].height(height);
				// if (typeof offset !== 'undefined')
				// self.jQueryCache['configuratorPanelPlaceholder'].css(offset);
				// self.jQueryCache['configuratorPanel'].html('');
				// self.jQueryCache['configuratorPanelPlaceholder'].toggleClass('hidden');
				self.jQueryCache['configuratorPanel'].addClass("loading");
			},
			_hideConfiguratorPanelPlaceholder : function() {
				var self = this.stateMachine;
				// self.jQueryCache['configuratorPanelPlaceholder'].toggleClass('hidden');
				self.jQueryCache['configuratorPanel'].removeClass("loading");
			},
			_showCopyPlaceholder : function() {
				var self = this.stateMachine;
				var h = 40 + self.jQueryCache['ptabsDiv'].height() + self.jQueryCache['configuratorPanel'].height()
						+ self.jQueryCache['noticesDiv'].height();
				var w = 760;
				self.jQueryCache['copyPlaceholder'].height(h).width(w).show();
			},
			_hideCopyPlaceholder : function() {
				var self = this.stateMachine;
				self.jQueryCache['copyPlaceholder'].hide();
			},
			_selectTab : function(tabElem) {
				this.stateMachine._removeClass(this._selectedTab, 'selected_tab')._addClass(this._selectedTab,
						'normal_tab');
				this.stateMachine._addClass(tabElem, 'selected_tab')._removeClass(tabElem, 'normal_tab');
				this._selectedTab = tabElem;
			},
			_rebuildElementPartsTable : function(elemMatrix) {
				var $table = this.stateMachine.jQueryCache['configuratorPanel']
						.find('.free_element_parts_table .free_element_parts_body');
				$table.find('.element_part_row').remove();
				for (var i = 0; i < elemMatrix.length; i++) {
					var markup = '<div class="element_part_row"><div class="free_elements_table_left">'
							+ elemMatrix[i]['reference'] + '</div><div class="free_elements_table_right">'
							+ elemMatrix[i]['qty'] + '</div></div>';
					$table.append(markup);
				}
			},
			_removeTooltips : function() {
				$('.simple-tooltip.simple-tooltip-error').hide();
				$('.ik_state_image.with_errors').simpleTooltip({
					unbind : true
				});
			},
			_updateReference : function(data) {
				this.stateMachine.jQuery("#reference_panel").show();
				if (data.hasProduct) {
					if(this.stateMachine.jQuery("#sy_product_status")[0]) {
						this.stateMachine.jQuery("#sy_product_status")[0].className = "sy_status_" + data.status;
					}
					this.stateMachine.jQuery("#sy_product_reference").html(data.reference).parent()[0].className = "sy_ref"
							+ data.reference;
					if(this.stateMachine.jQuery("#sy_product_reference_placeholder")[0]) {
						this.stateMachine.jQuery("#sy_product_reference_placeholder")[0].className = data.reference == '' ? "no_ref"
								: "";
					}
				} else {
					this.stateMachine.jQuery("#sy_product_reference").parent()[0].className = "sy_ref";
					if(this.stateMachine.jQuery("#sy_product_reference_placeholder")[0]) {
						this.stateMachine.jQuery("#sy_product_reference_placeholder")[0].className = "no_elem";
					}
				}
				if(this.stateMachine.jQuery("#ss_reference_panel")[0]) {
					this.stateMachine.jQuery("#ss_reference_panel")[0].className = "sy_ref" + data["simple_special"];
				}
				this.stateMachine.jQuery("#sy_ss_reference").html(data["simple_special"]);
			},
			_showContacts : function(contArr, titulo_ventana, maxima_anchura) {
				var location_temp = "bottom left";
				var style_temp = "style=\"min-width: 248px;\"";
				if (maxima_anchura > 248) {
					location_temp = "bottom right";
					maxima_anchura = maxima_anchura + 10;
					style_temp = "style=\"min-width:" + maxima_anchura + "px;\"";
				}
				var html = "<div id='multipleContactWrapper' class='multipleContactWrapperSYContacts'>"
						+ _.chain(contArr).map(
								function(contact, index) {
									var contact_data = contact["name"];
									if (contact["company"] != "")
										contact_data = contact_data + " (" + contact["company"] + ")";
									return "<div class='contactWrapper'" + style_temp + ">" + "<span id='contact_"
											+ contact["id"] + "' data-index='" + index
											+ "' class='deleteContact'></span>" + "<a id='contact_" + contact["id"]
											+ "' data-index='" + index + "' class='contactLine dc_link' href='#'>"
											+ contact_data + "</a>" + "</div>";
								}).reduce(function(memo, c) {
							return memo + c;
						}).value() + "</div>";

				var anchor = $("#mockAnchor");
				anchor.unbind("click");
				anchor.qtip({
					suppress : false,
					content : {
						title : {
							text : titulo_ventana,
							button : true
						},
						text : html
					},
					position : {
						at : location_temp,
						my : "top right",
						target : $("#loadContact"),
						effect : false, // Disable positioning animation
						adjust : {
							method : "shift none"
						}
					},
					show : {
						event : "click",
						solo : true
					// Only show one tooltip at a time
					},
					hide : "unfocus",
					style : {
						classes : "ui-tooltip-wiki ui-tooltip-light ui-tooltip-shadow"
					}
				});
				anchor.click();
				anchor.data("contacts", contArr);
			},
			_showMessage : function(message, titulo_ventana) {
				var html = "<div id='multipleContactWrapperSYContacts' class='multipleContactWrapperSYContacts'>"
						+ "<div class='contactWrapper'>" + "<span id='contactMessage" + "' data-index='0" + "'></span>"
						+ "<id='contactText" + "' data-index='0" + "' class='messageLine'>" + message + "</a>"
						+ "</div>";
				+"</div>";

				var anchor = $("#mockAnchor");
				anchor.unbind("click");
				anchor.qtip({
					suppress : false,
					content : {
						title : {
							text : titulo_ventana,
							button : true
						},
						text : html
					},
					position : {
						at : "bottom left",
						my : "top right",
						target : $("#loadContact"),
						effect : false, // Disable positioning animation
						adjust : {
							method : "shift none"
						}
					},
					show : {
						event : "click",
						solo : true
					// Only show one tooltip at a time
					},
					hide : "unfocus",
					style : {
						classes : "ui-tooltip-wiki ui-tooltip-light ui-tooltip-shadow"
					}
				});
				anchor.click();
				// anchor.data("contacts", contArr);
			},
			_updatePanelContent : function(html, callback) {
				$("body").addClass("hide_jqv_errors");
				this.stateMachine.jQueryCache['hiddenPanel'].html(html);
				var h = this.stateMachine.jQueryCache['hiddenPanel'].height();
				this.stateMachine.jQueryCache['hiddenPanel'].html("");
				var that = this;
				this.stateMachine.jQueryCache['configuratorPanel'].animate({
					height : h + "px"
				}, 1000, function() {
					that.stateMachine.jQueryCache['configuratorPanel'].html(html);
					that.stateMachine.jQueryCache['configuratorPanel'].css({
						height : "auto"
					});
					that._hideConfiguratorPanelPlaceholder();
					if (callback)
						callback();
					$("body").removeClass("hide_jqv_errors");
				});
			},
			_loadPanelViaAjax : function(ajaxFunc) {
				this._showConfiguratorPanelPlaceholder();
				ajaxFunc();
			},
			/*
			 * ATTRIBUTES
			 */
			refreshPath : 'refresh/',
			drawingPath : 'drawing/'
		});