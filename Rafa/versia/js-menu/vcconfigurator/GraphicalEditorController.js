var GraphicalEditorController = Class.extend({
	
	init : function(stMach, sessionState) {
		this.stateMachine = stMach;

		this.noCSS = sessionState.noCSS.split(';');
		this.compiledCSS = [ "DPR_095", "DPR_107", "DPR_108", "DPR_096", "DPR_109", "DPR_110" ];

		
		
//		stMach.jQueryCache['btnA'].on('click', {
//			object : this
//		}, this.onGraphicalElementClick);
		
		stMach.jQueryCache['sprGraphEditor'].on('click', '.selectable', {
			object : this
		}, this.onGraphicalElementClick);
 
		// Subscribe to events
		stMach.eventBus.subscribeTo(stMach.eventBus.eventList.afterTabClick, {
			object : this,
			callback : this._selectFirstElement
		});
		stMach.eventBus.subscribeTo(stMach.eventBus.eventList.afterCharacteristicChange, {
			object : this,
			callback : this.refreshGraphicalEditor,
			args : [ "recalculate=0" ]
		});
		stMach.eventBus.subscribeTo(stMach.eventBus.eventList.afterAddProductClick, {
			object : this,
			callback : this.refreshGraphicalEditor,
			args : [ "recalculate=0" ]
		});
		stMach.eventBus.subscribeTo(stMach.eventBus.eventList.afterDeleteProductClick, {
			object : this,
			callback : this.refreshGraphicalEditor,
			args : [ "recalculate=0" ]
		});
		stMach.eventBus.subscribeTo(stMach.eventBus.eventList.afterFreeReferenceEntered, {
			object : this,
			callback : this.refreshGraphicalEditor,
			args : [ "recalculate=0" ]
		});
		stMach.eventBus.subscribeTo(stMach.eventBus.eventList.afterFreeReferenceMeasuresClick, {
			object : this,
			callback : this.refreshGraphicalEditor,
			args : [ "recalculate=0" ]
		});
		stMach.eventBus.subscribeTo(stMach.eventBus.eventList.afterBrushClick, {
			object : this,
			callback : this.afterBrushClick
		});
		stMach.eventBus.subscribeTo(stMach.eventBus.eventList.afterAddStationClick, {
			object : this,
			callback : this.afterAddDeleteStation,
			args : [ "recalculate=1" ]
		});
		stMach.eventBus.subscribeTo(stMach.eventBus.eventList.afterDeleteStationClick, {
			object : this,
			callback : this.afterAddDeleteStation,
			args : [ "recalculate=1" ]
		});
		stMach.eventBus.subscribeTo(stMach.eventBus.eventList.afterDeleteProductClick, {
			object : this,
			callback : this.afterAddDeleteStation,
			args : [ "recalculate=1" ]
		});
		stMach.eventBus.subscribeTo(stMach.eventBus.eventList.afterUndoActionClick, {
			object : this,
			callback : this.refreshGraphicalEditor,
			priority : 1,
			args : [ "recalculate=1" ]
		});
		stMach.eventBus.subscribeTo(stMach.eventBus.eventList.afterRedoActionClick, {
			object : this,
			callback : this.refreshGraphicalEditor,
			priority : 1,
			args : [ "recalculate=1" ]
		});
		stMach.eventBus.subscribeTo(stMach.eventBus.eventList.afterMoveLeftClick, {
			object : this,
			callback : this.refreshGraphicalEditor,
			priority : 1,
			args : [ "recalculate=1" ]
		});
		stMach.eventBus.subscribeTo(stMach.eventBus.eventList.afterMoveRightClick, {
			object : this,
			callback : this.refreshGraphicalEditor,
			priority : 1,
			args : [ "recalculate=1" ]
		});
		stMach.eventBus.subscribeTo(stMach.eventBus.eventList.onMeassuresClick, {
			object : this,
			callback : this.onMeassures
		});
		stMach.eventBus.subscribeTo(stMach.eventBus.eventList.afterMeassuresClick, {
			object : this,
			callback : this.afterMeassuresClick
		});
		stMach.eventBus.subscribeTo(stMach.eventBus.eventList.onConfigurationChange, {
			object : this,
			callback : this.onConfigurationChange
		});
		stMach.eventBus.subscribeTo(stMach.eventBus.eventList.afterConfigurationChange, {
			object : this,
			callback : this.afterConfigurationChange
		});
		stMach.eventBus.subscribeTo(stMach.eventBus.eventList.onMoveLeftClick, {
			object : this,
			callback : this.onMoveElement
		});
		stMach.eventBus.subscribeTo(stMach.eventBus.eventList.onMoveRightClick, {
			object : this,
			callback : this.onMoveElement
		});

		stMach.eventBus.subscribeTo(stMach.eventBus.eventList.onResetClick, {
			object : this,
			callback : this._resetGrid
		});
		stMach.eventBus.subscribeTo(stMach.eventBus.eventList.afterResetClick, {
			object : this,
			callback : this.refreshGraphicalEditor,
			priority : 1,
			args : [ "recalculate=1" ]
		});

		stMach.eventBus.subscribeTo(stMach.eventBus.eventList.onDeleteProductClick, {
			object : this,
			callback : this.onDeleteProductClick
		});

		stMach.eventBus.subscribeTo(stMach.eventBus.eventList.onAddProductClick, {
			object : this,
			callback : this.onAddProduct
		});

		stMach.eventBus.subscribeTo(stMach.eventBus.eventList.afterFreeReferencePartDeleted, {
			object : this,
			callback : this.refreshGraphicalEditor,
			args : [ "recalculate=0" ]
		});
		stMach.eventBus.subscribeTo(stMach.eventBus.eventList.afterFreeReferencePartAdded, {
			object : this,
			callback : this.refreshGraphicalEditor,
			args : [ "recalculate=0" ]
		});
		stMach.eventBus.subscribeTo(stMach.eventBus.eventList.afterFreeReferencePartModified, {
			object : this,
			callback : this.refreshGraphicalEditor,
			args : [ "recalculate=0" ]
		});

		this.refreshGraphicalEditor("recalculate=1", true);
	},
	/*
	 * 'ASYNCHRONOUSITY' SETTINGS BY METHOD
	 */
	_ajaxAsyncSettings : {
		refreshGraphicalEditor : true,
		getGraphicalEditorJSON : true
	},
	/*
	 * OTHER CONSTANTS
	 */
	_constants : {
		sizeChangeOnHover : -2,
		backgroundMoveOnHover : -1,
		sizeChangeOnSelect : -2,
		backgroundMoveOnSelect : -1,
		sizeChangeOnDehover : 2,
		backgroundMoveOnDehover : 1,
		sizeChangeOnDeselect : 2,
		backgroundMoveOnDeselect : 1
	},
	/*
	 * HANDLERS
	 */
	afterAddDeleteStation : function(data, recalculateSizePositions) {
		this.refreshGraphicalEditor(recalculateSizePositions);
	},
	afterBrushClick : function() {
		var self = this;
		this.stateMachine.jQueryCache['sprGraphEditor'].find('.onBuffer').each(
				function() {
					var $this = self.stateMachine.jQuery(this);

					$this.removeData('old-class').removeData('old-first').removeData('old-last').removeData(
							'old-cellType').removeData('old-deleteActive').removeData('old-currentImg').removeData(
							'old-currentProd').removeData('old-currentStatus').removeClass('onBuffer');
				});

		var controller = this.stateMachine.controllers.tabs;

		var idCharacteristic = (controller.nodeName == 'INPUT') ? controller.name : controller.id;
		var idOption = controller.value;
		var isRed = ( controller.data-status == 'with_errors');

		this.stateMachine.eventBus.fireEvent('onCharacteristicChange', [ idCharacteristic, idOption, isRed ]);
		this.refreshGraphicalEditor("recalculate=1");
	},
	refreshGraphicalEditor : function(recalculateSizePositions, initialLoad, ignoreDoReload) {
		console.log("ENTRA AQUI refreshGraphicalEditor");
		if (!this.stateMachine.isSelectingForCopying() || (typeof initialLoad != 'undefined')) {
			var self = this;
			var rn = Math.floor(Math.random() * 10000);
			this.stateMachine.jQuery.ajax({
				url : resourceUrl1, //this.refreshBasePath + "refresh_graphical_editor.jsp?rn=" + rn,
				data : recalculateSizePositions,
				async : self._ajaxAsyncSettings.refreshGraphicalEditor,
				dataType : 'json',
				success : function(json) {	
					console.log("success refreshGraphicalEditor ")
//					jsonprueba = {"min_stations" : "2", "max_stations" : "12", "min_mixed" : "1", "max_mixed" : "24", "min_input" : "1", "max_input" : "24", "min_output" : "1", "max_output" : "24", "CJ_034|BL_009[01,01]" : {"selected" : true, "image" : "IMG_454", "status" : "bw", "isFirst" : false, "isLast" : false, "deleteActive" : false, "cellType" : "manifoldD", "productId" : "DPR_064", "copying" : false, "tab" : 0, "removableGroup" : false, "xDisplace" : 0, "yDisplace" : 0, "isCustomized" : false, "labels" : 1, "label_0" : "D side"}, "CJ_034|BL_009[01,03]" : {"selected" : false, "image" : "IMG_800", "status" : "bw", "isFirst" : false, "isLast" : false, "deleteActive" : false, "cellType" : "manifoldU", "productId" : "DPR_062", "copying" : false, "tab" : 0, "removableGroup" : false, "xDisplace" : 0, "yDisplace" : 0, "isCustomized" : false, "labels" : 1, "label_0" : "U side"}}
//					jsonprueba = {"min_stations" : "2", "max_stations" : "12", "min_mixed" : "1", "max_mixed" : "24", "min_input" : "1", "max_input" : "24", "min_output" : "1", "max_output" : "24", "copying_element" : "", "CJ_034|BL_009[01,01]" : {"selected" : true, "image" : "IMG_454", "status" : "bw", "isFirst" : false, "isLast" : false, "deleteActive" : false, "cellType" : "manifoldD", "productId" : "DPR_064", "copying" : false, "tab" : 0, "removableGroup" : false, "xDisplace" : 0, "yDisplace" : 0, "isCustomized" : false, "labels" : 1, "label_0" : "D side"}, "CJ_034|BL_009[01,02]|BL_001[01,01]|BL_002[02,01]" : {"selected" : false, "image" : "IMG_404", "status" : "bw", "isFirst" : true, "isLast" : false, "deleteActive" : false, "cellType" : "station", "productId" : "PR_011", "copying" : false, "tab" : 1, "removableGroup" : false, "xDisplace" : 0, "yDisplace" : 0, "isCustomized" : false, "labels" : 1, "label_0" : "=#[base_plate_text] (*)", "basePlateText" : "( D )"}, "CJ_034|BL_009[01,02]|BL_001[01,01]|BL_002[04,01]" : {"selected" : false, "image" : "", "isFirst" : true, "isLast" : false, "deleteActive" : false, "cellType" : "station", "copying" : false, "tab" : "1", "xDisplace" : 1, "yDisplace" : 0}, "CJ_034|BL_009[01,02]|BL_001[01,02]|BL_002[02,01]" : {"selected" : false, "image" : "IMG_404", "status" : "bw", "isFirst" : false, "isLast" : false, "deleteActive" : false, "cellType" : "station", "productId" : "PR_011", "copying" : false, "tab" : 1, "removableGroup" : false, "xDisplace" : 0, "yDisplace" : 0, "isCustomized" : false, "labels" : 1, "label_0" : "=#[base_plate_text] (*)", "basePlateText" : "( D )"}, "CJ_034|BL_009[01,02]|BL_001[01,02]|BL_002[04,01]" : {"selected" : false, "image" : "", "isFirst" : false, "isLast" : false, "deleteActive" : false, "cellType" : "station", "copying" : false, "tab" : "1", "xDisplace" : 1, "yDisplace" : 0}, "CJ_034|BL_009[01,02]|BL_001[01,03]|BL_002[02,01]" : {"selected" : false, "image" : "IMG_404", "status" : "bw", "isFirst" : false, "isLast" : false, "deleteActive" : false, "cellType" : "station", "productId" : "PR_011", "copying" : false, "tab" : 1, "removableGroup" : false, "xDisplace" : 0, "yDisplace" : 0, "isCustomized" : false, "labels" : 1, "label_0" : "=#[base_plate_text] (*)", "basePlateText" : "( D )"}, "CJ_034|BL_009[01,02]|BL_001[01,03]|BL_002[04,01]" : {"selected" : false, "image" : "", "isFirst" : false, "isLast" : false, "deleteActive" : false, "cellType" : "station", "copying" : false, "tab" : "1", "xDisplace" : 1, "yDisplace" : 0}, "CJ_034|BL_009[01,02]|BL_001[01,04]|BL_002[02,01]" : {"selected" : false, "image" : "IMG_404", "status" : "bw", "isFirst" : false, "isLast" : false, "deleteActive" : false, "cellType" : "station", "productId" : "PR_011", "copying" : false, "tab" : 1, "removableGroup" : false, "xDisplace" : 0, "yDisplace" : 0, "isCustomized" : false, "labels" : 1, "label_0" : "=#[base_plate_text] (*)", "basePlateText" : "( D )"}, "CJ_034|BL_009[01,02]|BL_001[01,04]|BL_002[04,01]" : {"selected" : false, "image" : "", "isFirst" : false, "isLast" : false, "deleteActive" : false, "cellType" : "station", "copying" : false, "tab" : "1", "xDisplace" : 1, "yDisplace" : 0}, "CJ_034|BL_009[01,02]|BL_001[01,05]|BL_002[02,01]" : {"selected" : false, "image" : "IMG_404", "status" : "bw", "isFirst" : false, "isLast" : false, "deleteActive" : false, "cellType" : "station", "productId" : "PR_011", "copying" : false, "tab" : 1, "removableGroup" : false, "xDisplace" : 0, "yDisplace" : 0, "isCustomized" : false, "labels" : 1, "label_0" : "=#[base_plate_text] (*)", "basePlateText" : "( D )"}, "CJ_034|BL_009[01,02]|BL_001[01,05]|BL_002[04,01]" : {"selected" : false, "image" : "", "isFirst" : false, "isLast" : false, "deleteActive" : false, "cellType" : "station", "copying" : false, "tab" : "1", "xDisplace" : 1, "yDisplace" : 0}, "CJ_034|BL_009[01,02]|BL_001[01,06]|BL_002[02,01]" : {"selected" : false, "image" : "IMG_404", "status" : "bw", "isFirst" : false, "isLast" : false, "deleteActive" : false, "cellType" : "station", "productId" : "PR_011", "copying" : false, "tab" : 1, "removableGroup" : false, "xDisplace" : 0, "yDisplace" : 0, "isCustomized" : false, "labels" : 1, "label_0" : "=#[base_plate_text] (*)", "basePlateText" : "( D )"}, "CJ_034|BL_009[01,02]|BL_001[01,06]|BL_002[04,01]" : {"selected" : false, "image" : "", "isFirst" : false, "isLast" : false, "deleteActive" : false, "cellType" : "station", "copying" : false, "tab" : "1", "xDisplace" : 1, "yDisplace" : 0}, "CJ_034|BL_009[01,02]|BL_001[01,07]|BL_002[02,01]" : {"selected" : false, "image" : "IMG_404", "status" : "bw", "isFirst" : false, "isLast" : false, "deleteActive" : false, "cellType" : "station", "productId" : "PR_011", "copying" : false, "tab" : 1, "removableGroup" : false, "xDisplace" : 0, "yDisplace" : 0, "isCustomized" : false, "labels" : 1, "label_0" : "=#[base_plate_text] (*)", "basePlateText" : "( D )"}, "CJ_034|BL_009[01,02]|BL_001[01,07]|BL_002[04,01]" : {"selected" : false, "image" : "", "isFirst" : false, "isLast" : false, "deleteActive" : false, "cellType" : "station", "copying" : false, "tab" : "1", "xDisplace" : 1, "yDisplace" : 0}, "CJ_034|BL_009[01,02]|BL_001[01,08]|BL_002[02,01]" : {"selected" : false, "image" : "IMG_404", "status" : "bw", "isFirst" : false, "isLast" : false, "deleteActive" : false, "cellType" : "station", "productId" : "PR_011", "copying" : false, "tab" : 1, "removableGroup" : false, "xDisplace" : 0, "yDisplace" : 0, "isCustomized" : false, "labels" : 1, "label_0" : "=#[base_plate_text] (*)", "basePlateText" : "( D )"}, "CJ_034|BL_009[01,02]|BL_001[01,08]|BL_002[04,01]" : {"selected" : false, "image" : "", "isFirst" : false, "isLast" : false, "deleteActive" : false, "cellType" : "station", "copying" : false, "tab" : "1", "xDisplace" : 1, "yDisplace" : 0}, "CJ_034|BL_009[01,02]|BL_001[01,09]|BL_002[02,01]" : {"selected" : false, "image" : "IMG_404", "status" : "bw", "isFirst" : false, "isLast" : false, "deleteActive" : false, "cellType" : "station", "productId" : "PR_011", "copying" : false, "tab" : 1, "removableGroup" : false, "xDisplace" : 0, "yDisplace" : 0, "isCustomized" : false, "labels" : 1, "label_0" : "=#[base_plate_text] (*)", "basePlateText" : "( D )"}, "CJ_034|BL_009[01,02]|BL_001[01,09]|BL_002[04,01]" : {"selected" : false, "image" : "", "isFirst" : false, "isLast" : false, "deleteActive" : false, "cellType" : "station", "copying" : false, "tab" : "1", "xDisplace" : 1, "yDisplace" : 0}, "CJ_034|BL_009[01,02]|BL_001[01,10]|BL_002[02,01]" : {"selected" : false, "image" : "IMG_404", "status" : "bw", "isFirst" : false, "isLast" : false, "deleteActive" : false, "cellType" : "station", "productId" : "PR_011", "copying" : false, "tab" : 1, "removableGroup" : false, "xDisplace" : 0, "yDisplace" : 0, "isCustomized" : false, "labels" : 1, "label_0" : "=#[base_plate_text] (*)", "basePlateText" : "( D )"}, "CJ_034|BL_009[01,02]|BL_001[01,10]|BL_002[04,01]" : {"selected" : false, "image" : "", "isFirst" : false, "isLast" : false, "deleteActive" : false, "cellType" : "station", "copying" : false, "tab" : "1", "xDisplace" : 1, "yDisplace" : 0}, "CJ_034|BL_009[01,02]|BL_001[01,11]|BL_002[02,01]" : {"selected" : false, "image" : "IMG_404", "status" : "bw", "isFirst" : false, "isLast" : false, "deleteActive" : false, "cellType" : "station", "productId" : "PR_011", "copying" : false, "tab" : 1, "removableGroup" : false, "xDisplace" : 0, "yDisplace" : 0, "isCustomized" : false, "labels" : 1, "label_0" : "=#[base_plate_text] (*)", "basePlateText" : "( D )"}, "CJ_034|BL_009[01,02]|BL_001[01,11]|BL_002[04,01]" : {"selected" : false, "image" : "", "isFirst" : false, "isLast" : false, "deleteActive" : false, "cellType" : "station", "copying" : false, "tab" : "1", "xDisplace" : 1, "yDisplace" : 0}, "CJ_034|BL_009[01,02]|BL_001[01,12]|BL_002[02,01]" : {"selected" : false, "image" : "IMG_404", "status" : "bw", "isFirst" : false, "isLast" : true, "deleteActive" : false, "cellType" : "station", "productId" : "PR_011", "copying" : false, "tab" : 1, "removableGroup" : false, "xDisplace" : 0, "yDisplace" : 0, "isCustomized" : false, "labels" : 1, "label_0" : "=#[base_plate_text] (*)", "basePlateText" : "( D )"}, "CJ_034|BL_009[01,02]|BL_001[01,12]|BL_002[04,01]" : {"selected" : false, "image" : "", "isFirst" : false, "isLast" : true, "deleteActive" : false, "cellType" : "station", "copying" : false, "tab" : "1", "xDisplace" : 1, "yDisplace" : 0}, "CJ_034|BL_009[01,03]" : {"selected" : false, "image" : "IMG_800", "status" : "bw", "isFirst" : false, "isLast" : false, "deleteActive" : false, "cellType" : "manifoldU", "productId" : "DPR_062", "copying" : false, "tab" : 0, "removableGroup" : false, "xDisplace" : 0, "yDisplace" : 0, "isCustomized" : false, "labels" : 1, "label_0" : "U side"}}
//					self._doRefreshGraphicalEditor(jsonprueba);
					if(!ignoreDoReload) {
						self._doRefreshGraphicalEditor(json);
					}
					toggleConfigurationProperties(json);

                    if(SYSerie == 'SY' && (userCountry == 'ES' || userCountry == 'PT')){ // SYSerie y userCountry vienen de 'selseries-configurator.ftl'
                        updateProjectDescription(json, userCountry); // Add a text when I/O stations > 1
                    }

					// Show notices
					noticeRender(json.notices);
					//$('#configurator_panel_div_notices').html(json.notices);

					self.stateMachine.eventBus.fireEvent('graphicalEditorRefreshed');
				},
				error : function(objeto, quepaso, otroobj) {
					self.stateMachine._ajaxError('GraphicalEditorController', 'refreshGraphicalEditor', objeto,
							quepaso, otroobj);
				},
				complete : function() {
					if (initialLoad && self.stateMachine.isViewingSetInformation()) {
						self.stateMachine.jQuery('.graphical_editor .selected').removeClass('selected').addClass(
								'unselected');
					}
				}
			});
		}
	},
	onAddProduct : function(prodId, cellId, cellType, baseId) {
		var decomposedId = this._decomposeId(cellId);
		if (decomposedId.length == 4) {
			// Station element
			var row = decomposedId[3].row.replace(/^0([0-9]+)/, '$1');
			var column = decomposedId[2].column.replace(/^0([0-9]+)/, '$1');
			if (column == "24")
				row = row - 1;
			var elem = this.stateMachine.jQueryCache['sprGraphEditor'].find(
					'.station_' + column + ' div:eq(' + (row == 1 ? 0 : row) + ')').show();

			elem.css('background-position', '');

			var _pId = this._getSprite([ prodId, baseId ]);

			_pId = _pId == "" ? baseId : _pId;

			elem.addClass('product_' + _pId + '_sprite').addClass('yellow');

			if (elem.hasClass('intermediate_level'))
				elem.removeClass('no_image').show().parent().removeClass('no_intermediate').parent().addClass(
						'any_has_intermediate');
			else if (elem.hasClass('block_disk'))
				elem.show().parent().removeClass('no_configured_block_disk');

			elem[0].id = cellId; // + '_temp';
		} else if (decomposedId.length == 3) {
		}
	},
	_doRefreshGraphicalEditor : function(json) {
		console.log("entra en _doRefreshGraphicalEditor");
		var self = this;
		var cleanElement = function(elem) {
			if (elem instanceof self.stateMachine.jQuery)
				elem = elem[0];
			elem.className = elem.className.replace(/product_[^\s]+_sprite/g, "").replace(/IMG_[0-9]+/g, "").replace(
					"no_image", "");
		};

		var stations = 0;
		var inputs = _.chain(json).map(function(val, key) {
			if (typeof val == 'object')
				return (val.cellType == 'input') ? 1 : 0;
			return 0;
		}).reduce(function(memo, num) {
			return memo + num;
		}).value();
		var outputs = _.chain(json).map(function(val, key) {
			if (typeof val == 'object')
				return (val.cellType == 'output') ? 1 : 0;
			return 0;
		}).reduce(function(memo, num) {
			return memo + num;
		}).value();
		var mixeds = _.chain(json).map(function(val, key) {
			if (typeof val == 'object')
				return (val.cellType == 'mixed') ? 1 : 0;
			return 0;
		}).reduce(function(memo, num) {
			return memo + num;
		}).value();
		var manifoldU = false;
		var manifoldD2 = false;

		var recalculateAfterTimeout = [];

		var modifiedSelection = false;

		var copyingElem = json.copying_element;

		for ( var elemId in json) {
			var obj = json[elemId];
			if (typeof obj == 'object') {
				var elem;
				var col, row;
				var type = '';
				if (obj.cellType == 'manifoldU') {
					elem = this.stateMachine.jQueryCache['sprGraphEditor'].find('.manifold_u');
					manifoldU = true;
				} else if (obj.cellType == 'manifoldD') {
					elem = this.stateMachine.jQueryCache['sprGraphEditor'].find('.manifold_d');
					elem.data('min_stations', json.min_stations).data('max_stations', json.max_stations).data(
							'min_mixed', json.min_mixed).data('max_mixed', json.max_mixed).data('min_input',
							json.min_input).data('max_input', json.max_input).data('min_output', json.min_output).data(
							'max_output', json.max_output);
				} else if (obj.cellType == 'station') {
					var decomposedId = this._decomposeId(elemId);
					col = decomposedId[2].column.replace(/^0([0-9]+)/, '$1'), row = decomposedId[3].row.replace(
							/^0([0-9]+)/, '$1');
					var myDivPos = row;
					if (row == 1)
						myDivPos = 0;
					else if (col == 24)
						myDivPos = row - 1;
					elem = this.stateMachine.jQueryCache['sprGraphEditor'].find('.station_' + col + ' div:eq('
							+ myDivPos + ')');
					try {
						if (elem.hasClass('valves')) {
							var inter = elem.prev();
							if (inter[0] && inter[0].id && !json[inter[0].id])
								elem.parent().addClass('no_intermediate');
						}
					} catch (Except) {
					}
					stations = Math.max(stations, col);
				} else if (obj.cellType == 'input') {
					type = 'input_element';
					var decomposedId = this._decomposeId(elemId);
					var col = window.parseDecimalInt(decomposedId[2].column.replace(/^0([0-9]+)/, '$1'));
					elem = this.stateMachine.jQueryCache['sprGraphEditor'].find('.input_' + (inputs - col + 1)
							+ ' .input_element');
				} else if (obj.cellType == 'output') {
					type = 'output_element';
					var decomposedId = this._decomposeId(elemId);
					var col = window.parseDecimalInt(decomposedId[2].column.replace(/^0([0-9]+)/, '$1'));
					elem = this.stateMachine.jQueryCache['sprGraphEditor']
							.find('.output_' + (col) + ' .output_element');
				} else if (obj.cellType == 'mixed') {
					var decomposedId = this._decomposeId(elemId);
					var col = window.parseDecimalInt(decomposedId[2].column.replace(/^0([0-9]+)/, '$1'));
					elem = this.stateMachine.jQueryCache['sprGraphEditor'].find('.mixed_' + (col) + ' .mixed_element');
				} else if (obj.cellType == 'manifoldD2') {
					manifoldD2 = true;
					elem = this.stateMachine.jQueryCache['sprGraphEditor'].find('.manifold_d2');
					elem.show();
					this.stateMachine.jQueryCache['sprGraphEditor'].data('d2_manifold', true);
				}

				if (typeof elem != 'undefined' && typeof elem[0] != 'undefined') {
					if (typeof obj.isCustomized != 'undefined' && obj.isCustomized)
						elem.addClass('customized');

					try {
						var excluded = [ 'left' ];
						if (obj.selected && !elem.hasClass('selected')) {
							this.stateMachine.jQueryCache['sprGraphEditor'].find('.selected').removeClass('selected')
									.addClass('unselected');
							modifiedSelection = true;
						} else if (obj.selected && elem.hasClass('selected')) {
							excluded.push('width');
							excluded.push('height');
							excluded.push('z-index');
						}
						this.stateMachine._resetStyle(elem[0], excluded);
					} catch (Except) {
					}

					var currImg = elem.data('current-img');
					if (typeof currImg != 'undefined')
						elem.removeClass(currImg);
					var currProd = elem.data('current-prod');
					if (typeof currProd != 'undefined')
						elem.removeClass('product_' + currProd + '_sprite');
					var currStatus = elem.data('current-status');
					elem.removeClass('yellow').removeClass('red').removeClass('bw');

					if (typeof obj.productId != 'undefined' && obj.image != '') {
						this._getSprite(obj.productId);
						cleanElement(elem);
						elem.addClass('product_' + obj.productId + '_sprite').addClass(obj.image).addClass(obj.status);

						if (obj.cellType == 'station' && row == 1)
							elem.addClass('selectable');

						if (obj.cellType == 'station' && row == 4)
							recalculateAfterTimeout.push({
								elem : elem,
								type : 'valve'
							});

						if (obj.cellType == 'manifoldU' || obj.cellType == 'manifoldD') {
							recalculateAfterTimeout.push({
								elem : elem,
								type : obj.cellType
							});
						}
						if (obj.cellType == 'station' && row == 1) {
							elem.parent().removeClass('no_configured_block_disk');
						}
					} else if (obj.image != '') {
						elem.css('backgroundImage', obj.image);
						if (obj.cellType == 'station' && row == 1) {
							elem.parent().removeClass('no_block_disk').addClass('no_configured_block_disk');
							elem.addClass('selectable');
						}

					} else {
						elem.addClass('no_image');
						elem.addClass('selectable');
						if (obj.cellType == 'station' && row == 3)
							elem.parent().addClass('no_intermediate');
						elem.removeClass('big_valve');
					}
					if (obj.selected) {
						elem.addClass('selected').removeClass('unselected');
						if (!(obj.cellType == 'manifoldU' || obj.cellType == 'manifoldD'))
							recalculateAfterTimeout.push({
								elem : elem,
								type : obj.cellType
							});
					}
					if (obj.copying) {
						if (copyingElem == type) {
							elem.addClass('copy_active');
						}
					}
					elem[0].id = elemId; // + '_temp';

					if (typeof obj.basePlateText != 'undefined' && obj.basePlateText != '') {
						elem.parent().find('.station_wiring label').html(obj.basePlateText);
					}

					var xDisplace = obj.xDisplace;
					var yDisplace = obj.yDisplace;
					var remGrp = obj.removableGroup;
					if (typeof xDisplace === 'undefined')
						xDisplace = 0;
					if (typeof yDisplace === 'undefined')
						yDisplace = 0;
					if (typeof remGrp === 'undefined')
						remGrp = false;

					elem.data('first', obj.isFirst).data('last', obj.isLast).data('cell-type', obj.cellType).data(
							'delete-active', obj.deleteActive).data('current-img', obj.image + '').data('current-prod',
							obj.productId + '').data('current-status', obj.status).data('xDisplace', xDisplace).data(
							'yDisplace', yDisplace).data('remGrp', remGrp);

					elem.attr('tab', obj.tab);

					if (obj.cellType.indexOf('manifold') > -1 && typeof obj.labels !== 'undefined' && obj.labels > 0) {
						elem.parent().find('.label').text(obj.label_0);
					}
				}
				if (obj.cellType == 'station' && obj.image != '' && row == 3) {
					elem.parent().removeClass('no_intermediate').show();
					elem.removeClass('no_image');
					this.stateMachine.jQueryCache['sprGraphEditor'].addClass('any_has_intermediate');
				}
			}
		}

		var jQuery = this.stateMachine.jQuery;
		var anyInter = !(_.reduce(this.stateMachine.jQueryCache['sprGraphEditor'].find('.stations:visible').map(
				function() {
					return jQuery(this).hasClass('no_intermediate');
				}).toArray(), function(m, e) {
			return m && e;
		}, true));
		if (anyInter)
			this.stateMachine.jQueryCache['sprGraphEditor'].addClass('any_has_intermediate');
		else
			this.stateMachine.jQueryCache['sprGraphEditor'].removeClass('any_has_intermediate');

		var self = this;

		if (recalculateAfterTimeout.length > 0) {
			window.setTimeout(function() {
				self.recalculateHeights(recalculateAfterTimeout, modifiedSelection);
			}, 500);
		}

		this.stateMachine.jQueryCache['sprGraphEditor'].data('stations', stations).data('inputs', inputs).data(
				'outputs', outputs).data('mixeds', mixeds).data('u_manifold', manifoldU)
				.data('d2_manifold', manifoldD2);

		if (!manifoldD2)
			this.stateMachine.jQueryCache['sprGraphEditor'].find('.manifold_d2').hide();

		window.setTimeout(function() {
			self.recalculateLeftOffsets();

			self.stateMachine.jQueryCache['sprGraphEditor'].find('.stations:visible .label').show().end().find(
					'.manifold_d_label').show().end().find('.mixeds:visible .label').show().end().find(
					'.inputs:visible .label').show().end().find('.outputs:visible .label').show();
		}, 250);

		window.setTimeout(function() {
			self._fixEditor();
		}, 1000);

		if(!self.firstLoad) {
			this.stateMachine.controllers['graphical_editor'].refreshGraphicalEditor();
			self.firstLoad = true;
		}
	},
	_getSprite : function(prodId) {
		var _defProdId = '';
		if (typeof prodId === 'string')
			prodId = [ prodId ];
		try {
			for (var i = 0; i < prodId.length; i++) {
				if (!_.contains(this.noCSS, prodId[i])) {
					/*
					 * START OF IE FIX (31 stylesheets max!!!)
					 */
					var isSpecialProduct = _.contains(this.compiledCSS, prodId[i]);
					var isIE = false ; // this.stateMachine.jQuery.browser.msie;
					if (isIE && isSpecialProduct) {
						if (this.stateMachine.jQuery('#ie_io_merged_css').length == 0) {
							var css = document.createElement("link");
							css.onload = function() {
								if (window["console"] && window["console"]["log"])
									console.log("Special CSS loaded!!");
							};
							css.setAttribute("rel", "stylesheet");
							css.setAttribute("type", "text/css");
							css.id = 'ie_io_merged_css';
							css.setAttribute("href", itemsetsPath +"/EX600_IO.css");
							document.getElementsByTagName("head")[0].appendChild(css);
						}
						_defProdId = prodId[i];
						break;
						/*
						 * END OF IE FIX
						 */
					} else if (this.stateMachine.jQuery('#css_' + prodId[i]).length == 0) {
						var css = document.createElement("link");
						css.onload = function() {
							if (window["console"] && window["console"]["log"])
								console.log("CSS " + prodId[i] + " loaded!!");
						};
						css.setAttribute("rel", "stylesheet");
						css.setAttribute("type", "text/css");
						css.id = 'css_' + prodId[i];
						css.setAttribute("href", itemsetsPath +"/" + prodId[i] + ".css");
						
						document.getElementsByTagName("head")[0].appendChild(css);
						_defProdId = prodId[i];
						break;
					}
				}
			}
		} catch (Except) {
		}
		return _defProdId;
	},
	_selectFirstElement : function(id, tab, changeMade) {
		if (changeMade) {
			this.stateMachine.jQuery("." + this.stateMachine.selClass).removeClass(this.stateMachine.selClass);

			var self = this;
			var elems = this.stateMachine.jQuery('.selectable').toArray();
			for (var index = 0; index < elems.length; index++) {
				if (id == elems[index].id) {
					self.stateMachine._addClass(elems[index], self.stateMachine.selClass);
					break;
				}
			}
		}
	},
	/*
	 * EVENT HANDLERS
	 */
	onGraphicalElementClick : function(e) {
		var self = e.data.object;

		self.stateMachine.eventBus.fireEvent('onGraphicalElementClick', [ this.id, this.getAttribute('tab') ]);

		var wasSelected = true;

		// Element is not selected
		if (!self.stateMachine._hasClass(this, self.stateMachine.selClass)
				&& !self.stateMachine.isSelectingForCopying()) {
			wasSelected = false;

			var previous = self.stateMachine.jQuery('.graphical_editor .selected');
			previous.removeClass('selected').addClass('unselected');
			try {
				previous[0].style.zIndex = 'auto';
			} catch (Except) {
			}

			var current = self.stateMachine.jQuery(this);
			current.addClass('selected').removeClass('unselected');
			this.style.zIndex = 1000;
		}

		if (self.stateMachine.isSelectingForCopying() && self.stateMachine._hasClass(this, 'copy_active')) {
			var elem = document.getElementById(this.id);
			var changeMade = true;
			if (self.stateMachine._hasClass(elem, 'station_element'))
				changeMade = self._doCopyNew(this.id, 'station');
			if (self.stateMachine._hasClass(elem, 'mixed_element'))
				changeMade = self._doCopyNew(this.id, 'mixed');
			if (self.stateMachine._hasClass(elem, 'input_element'))
				changeMade = self._doCopyNew(this.id, 'input');
			if (self.stateMachine._hasClass(elem, 'output_element'))
				changeMade = self._doCopyNew(this.id, 'output');
			if (!changeMade)
				return;
		}

		self.stateMachine.eventBus.fireEvent('afterGraphicalElementClick', [ this.id, wasSelected,
				this.getAttribute('tab') ]);
	},
	onGraphicalElementMouseEnter : function(e) {
		var self = e.data.object;
		self.stateMachine._addClass(this, 'hovered')._changeElementSize(this, self._constants.sizeChangeOnHover)
				._moveBackgroundImage(this, self._constants.backgroundMoveOnHover);
	},
	onGraphicalElementMouseLeave : function(e) {
		var self = e.data.object;
		self.stateMachine._removeClass(this, 'hovered')._changeElementSize(this, self._constants.sizeChangeOnDehover)
				._moveBackgroundImage(this, self._constants.backgroundMoveOnDehover);
	},
	onMoveElement : function(cellToMoveId, rightToLeft) {
		var elem = $(document.getElementById(cellToMoveId).parentNode);

		if (elem.hasClass('stations')) {
			var myIndex = window.parseDecimalInt(cellToMoveId.split('|')[2].split(',')[1].replace(']', ''));
			var myNewIndex = rightToLeft ? myIndex - 1 : myIndex + 1;
			var strNewIndex = (myNewIndex / 10 < 1) ? '0' + myNewIndex : myNewIndex + '';
			var newCellId = cellToMoveId.replace(/([^\|]+)\|([^\|]+)\|([^,]+),[0-9]+\]\|([^\|]+)/, '$1|$2|$3,'
					+ strNewIndex + ']|$4');

			var _newElm = document.getElementById(newCellId)
			if (typeof _newElm === 'undefined' || _newElm == null) {
				if (rightToLeft)
					newElem = elem.prev();
				else
					newElem = elem.next();
			} else {
				var newElem = $(document.getElementById(newCellId).parentNode);
			}
			this._swapStations(elem, newElem);
		} else if (elem.hasClass('outputs') || elem.hasClass('inputs') || elem.hasClass('mixeds')) {
			var myIndex = window.parseDecimalInt(cellToMoveId.split('|')[2].split(',')[1].replace(']', ''));
			var myNewIndex = rightToLeft ? myIndex - 1 : myIndex + 1;
			var strNewIndex = (myNewIndex / 10 < 1) ? '0' + myNewIndex : myNewIndex + '';
			var newCellId = cellToMoveId.replace(/([^\|]+)\|([^\|]+)\|([^,]+),[0-9]+\]/, '$1|$2|$3,' + strNewIndex
					+ ']');

			var newElem = $(document.getElementById(newCellId).parentNode);
			var div1 = elem.find('div');
			var div2 = newElem.find('div');
			this._swapElements(div1, div2);
		}
	},
	onDeleteProductClick : function() {
		var $selElem = this.stateMachine.jQuery('.selected:first');

		$selElem.addClass('no_image').removeClass('product_' + $selElem.data('currentProd') + '_sprite').removeClass(
				$selElem.data('currentImg')).removeClass($selElem.data('currentStatus')).removeClass('big_valve');

		if ($selElem.hasClass('intermediate_level'))
			$selElem.parent().addClass('no_intermediate');
		if ($selElem.hasClass('block_disk'))
			$selElem.parent().addClass('no_configured_block_disk');

		$selElem.data('deleteActive', false);
		this.stateMachine.controllers.tabs.afterUndoRedo();
	},
	_doCopy : function(station) {
		var self = this;

		var copyingElemId = this.stateMachine._copyingElement.id;
		var elems = this._getElems(station, copyingElemId);

		var copyingElemIndex = window.parseDecimalInt(copyingElemId.split('|')[2].split(',')[1].replace(']', ''));
		var strCopyingElemIndex = (copyingElemIndex / 10 < 1) ? '0' + copyingElemIndex : copyingElemIndex + '';
		for (var index = 0; index < elems.length; index++) {
			var _currElem = elems[index][0];
			if (_currElem != null) {
				var myModelId = _currElem.id.replace(/([^\|]+)\|([^\|]+)\|([^,]+),[0-9]+\]\|([^\|]+)/, '$1|$2|$3,'
						+ strCopyingElemIndex + ']|$4');
				var currModelElem = document.getElementById(myModelId);
				_currElem.style.backgroundImage = currModelElem.style.backgroundImage;
				_currElem.style.backgroundColor = currModelElem.style.backgroundColor;
			} else {
				var attrs = this._getAttributesFromStation(station);

				var myRow = copyingElemId.split('|')[3].split(',')[0].split('[')[1];

				_currElem = elems[index][1].cloneNode();
				_currElem.id = attrs['id'].replace(
						/([^\|]+)\|([^\|]+)\|([^\|]+)\|([^\|]+)\|([^\|]+)\|([^\|]+)\|([^\[]+)[[0-9]+([^z]+)/,
						'$1|$2|$3|$4[' + myRow + '$5');
				_currElem.className = "ikGraphicElement";
				_currElem.setAttribute('data-delete-active', attrs['data-delete-active']);
				_currElem.setAttribute('data-cell-type', attrs['data-cell-type']);
				_currElem.setAttribute('data-last', attrs['data-last']);
				_currElem.setAttribute('data-first', attrs['data-first']);
				_currElem.setAttribute('tab', attrs['tab']);
				_currElem.style.left = attrs['left'];

				document.getElementById('graphical_editor_div').appendChild(_currElem);
			}
		}
	},
	_doCopyNew : function(elemId, cellType) {
		var self = this;

		var ctrls = self.stateMachine.controllers;
		var copyLimitReached = ctrls.graphical_tools.copyLimitReached();

		var changeMade = false;

		var backupAttributes = function(elem) {
			var $elem = self.stateMachine.jQuery(elem);
			$elem.data('visible', $elem.is(':visible')).data('old-class', elem.className).data('old-first',
					$elem.data('first')).data('old-last', $elem.data('last')).data('old-cellType',
					$elem.data('cellType')).data('old-deleteActive', $elem.data('deleteActive')).data('old-currentImg',
					$elem.data('currentImg')).data('old-currentProd', $elem.data('currentProd')).data(
					'old-currentStatus', $elem.data('currentStatus'));
		};
		var restoreAttributes = function(elem) {
			var $elem = self.stateMachine.jQuery(elem);
			if (!$elem.data('visible')) {
				$elem.hide();
			}
			elem.className = $elem.data('old-class');
			$elem.data('first', $elem.data('old-first')).data('last', $elem.data('old-last')).data('cellType',
					$elem.data('old-cellType')).data('deleteActive', $elem.data('old-deleteActive')).data('currentImg',
					$elem.data('old-currentImg')).data('currentProd', $elem.data('old-currentProd')).data(
					'currentStatus', $elem.data('old-currentStatus'));
			$elem.removeData('old-class').removeData('old-first').removeData('old-last').removeData('old-cellType')
					.removeData('old-deleteActive').removeData('old-currentImg').removeData('old-currentProd')
					.removeData('old-currentStatus').removeClass('onBuffer');
		};
		var copyAttributes = function(to, from) {
			var $to = self.stateMachine.jQuery(to);
			var $from = self.stateMachine.jQuery(from);
			if (!$from.is(':visible'))
				$to.hide();
			else
				$to.show();
			to.className = from.className;
			$to.data('first', $from.data('first')).data('last', $from.data('last')).data('cellType',
					$from.data('cellType')).data('deleteActive', $from.data('deleteActive')).data('currentImg',
					$from.data('currentImg')).data('currentProd', $from.data('currentProd')).data('currentStatus',
					$from.data('currentStatus')).addClass('onBuffer');
			$to.removeClass('selected').addClass('unselected');
			if (to.id == '' || to.id == 'undefined')
				// to.id = 'id'
				// + Math.random().toString().replace('.', '');
				to.id = elemId;
		};

		var copyingElemId = this.stateMachine._copyingElement.id; // +
		//var copyMessage = document.getElementById("copyErrorMessage").value;
		// '_temp';

		if (copyLimitReached) {
			alert(copyMessage);
		} else {
			if (cellType == 'station') {
				var copyingFromStation = document.getElementById(copyingElemId).parentNode;
				var copyingToStation = document.getElementById(elemId).parentNode;

				var onBuffer = false;

				// Copy block disk
				var fromElem = this.stateMachine.jQuery(copyingFromStation).find('.block_disk')[0];
				var toElem = this.stateMachine.jQuery(copyingToStation).find('.block_disk')[0];
				if (typeof toElem != 'undefined' && typeof fromElem != 'undefined') {
					if (this.stateMachine.jQuery(toElem).hasClass('onBuffer')) {
						onBuffer = true;
						restoreAttributes(toElem);
						changeMade = true;
					} else if (!copyLimitReached) {
						backupAttributes(toElem);
						copyAttributes(toElem, fromElem);
						toElem.setAttribute('copy_id', elemId);
						if (!this.stateMachine.jQuery(copyingFromStation).hasClass('no_configured_block_disk'))
							this.stateMachine.jQuery(copyingToStation).removeClass('no_configured_block_disk');
						changeMade = true;
					}
				}

				// Copy base plate
				fromElem = this.stateMachine.jQuery(copyingFromStation).find('.base_plate')[0];
				toElem = this.stateMachine.jQuery(copyingToStation).find('.base_plate')[0];
				if (this.stateMachine.jQuery(toElem).hasClass('onBuffer')) {
					onBuffer = true;
					restoreAttributes(toElem);
					changeMade = true;
				} else if (!copyLimitReached) {
					backupAttributes(toElem);
					copyAttributes(toElem, fromElem);
					toElem.setAttribute('copy_id', elemId);
					changeMade = true;
				}

				// Copy intermediate level
				fromElem = this.stateMachine.jQuery(copyingFromStation).find('.intermediate_level')[0];
				toElem = this.stateMachine.jQuery(copyingToStation).find('.intermediate_level')[0];
				if (this.stateMachine.jQuery(toElem).hasClass('onBuffer')) {
					onBuffer = true;
					restoreAttributes(toElem);
					changeMade = true;
				} else if (!copyLimitReached) {
					backupAttributes(toElem);
					copyAttributes(toElem, fromElem);
					toElem.setAttribute('copy_id', elemId);
					var xDispl = this.stateMachine.jQuery(fromElem).data('xDisplace');
					if (typeof xDispl !== 'undefined' && window.parseDecimalInt(xDispl) > 0) {
						this.stateMachine.jQuery(toElem).data('xDisplace', xDispl);
					}
					changeMade = true;
				}

				// Copy valve
				fromElem = this.stateMachine.jQuery(copyingFromStation).find('.valves')[0];
				toElem = this.stateMachine.jQuery(copyingToStation).find('.valves')[0];
				if (this.stateMachine.jQuery(toElem).hasClass('onBuffer')) {
					onBuffer = true;
					restoreAttributes(toElem);
					changeMade = true;
				} else if (!copyLimitReached) {
					backupAttributes(toElem);
					copyAttributes(toElem, fromElem);
					toElem.setAttribute('copy_id', elemId);
					changeMade = true;
				}

				if (onBuffer) {
					if ($(copyingToStation).data('old-noInt'))
						this.stateMachine._addClass(copyingToStation, 'no_intermediate');
					else
						this.stateMachine._removeClass(copyingToStation, 'no_intermediate');
				} else if (!copyLimitReached && this.stateMachine._hasClass(copyingFromStation, 'no_intermediate')) {
					$(copyingToStation).data('old-noInt',
							this.stateMachine._hasClass(copyingToStation, 'no_intermediate'));
					this.stateMachine._addClass(copyingToStation, 'no_intermediate');
				} else if (!copyLimitReached) {
					$(copyingToStation).data('old-noInt',
							this.stateMachine._hasClass(copyingToStation, 'no_intermediate'));
					this.stateMachine._removeClass(copyingToStation, 'no_intermediate');
				}
			} else if (cellType == 'mixed' || cellType == 'input' || cellType == 'output') {
				var copyingFromStation = document.getElementById(copyingElemId);
				var copyingToStation = document.getElementById(elemId);

				if (this.stateMachine.jQuery(copyingToStation).hasClass('onBuffer')) {
					onBuffer = true;
					restoreAttributes(copyingToStation);
					changeMade = true;
				} else if (!copyLimitReached) {
					backupAttributes(copyingToStation);
					copyAttributes(copyingToStation, copyingFromStation);
					copyingToStation.setAttribute('copy_id', elemId);
					changeMade = true;
				}
			}
		}

		if (changeMade)
			this.recalculateLeftOffsets();

		return changeMade;
	},
	_getElems : function(station, copyingElemId) {
		var decomposedCopyingElemId = this._decomposeId(copyingElemId);
		if (typeof station[decomposedCopyingElemId[3].row] != 'undefined')
			return [ [ station[decomposedCopyingElemId[3].row], document.getElementById(copyingElemId) ] ];
		else
			return [];
	},
	/*
	 * ID UTILS
	 */
	_decomposeId : function(elemId) {
		var objArr = [];
		var elems = elemId.split('|');
		for (var i = 0; i < elems.length; i++) {
			var elem = elems[i];
			var obj = {};
			obj.name = elem.split('[')[0];
			if (elem.split('[').length > 1) {
				var indices = elem.split('[')[1].replace(']', '').split(',');
				obj.row = indices[0];
				obj.column = indices[1];
			}
			objArr.push(obj);
		}
		return objArr;
	},
	_recomposeId : function(decomposedId) {
		var id = "";
		for (var idx = 0; idx < decomposedId.length; idx++) {
			id += decomposedId[idx].name;
			if (typeof decomposedId[idx].row !== 'undefined') {
				id += '[' + decomposedId[idx].row + ',' + decomposedId[idx].column + ']';
			}
			id += "|";
		}
		return (id.length > 0) ? id.substring(0, id.length - 1) : id;
	},
	_getAllStation : function(decomposedId) {
		var result = {};

		// 1. Block disk
		decomposedId[3].row = "01";
		var id = this._recomposeId(decomposedId);
		result["01"] = document.getElementById(id);

		// 2. Base plate
		decomposedId[3].row = "02";
		var id = this._recomposeId(decomposedId);
		result["02"] = document.getElementById(id);

		// 3. Intermediate level
		decomposedId[3].row = "03";
		var id = this._recomposeId(decomposedId);
		result["03"] = document.getElementById(id);

		// 4. Valves
		decomposedId[3].row = "04";
		var id = this._recomposeId(decomposedId);
		result["04"] = document.getElementById(id);

		return result;
	},
	_areOnSameStation : function(a, b) {
		return this._areEqual(a[0], b[0]) && this._areEqual(a[1], b[1]) && this._areEqual(a[2], b[2]);
	},
	_areEqual : function(a, b) {
		if (typeof a == 'undefined' || typeof b == 'undefined')
			return false;
		return a.toSource() == b.toSource();
	},
	_getAttributesFromStation : function(station) {
		var elem;
		var attributes = {};
		for ( var key in station) {
			if (typeof station[key] != 'undefined') {
				elem = station[key];
				break;
			}
		}
		if (typeof elem != 'undefined') {
			attributes['id'] = elem.id;
			attributes['data-delete-active'] = elem.getAttribute('data-delete-active');
			attributes['data-cell-type'] = elem.getAttribute('data-cell-type');
			attributes['data-last'] = elem.getAttribute('data-last');
			attributes['data-first'] = elem.getAttribute('data-first');
			attributes['left'] = elem.style.left;
			attributes['tab'] = elem.getAttribute('tab');
		}
		return attributes;
	},
	/*
	 * ATTRIBUTES
	 */
	drawingsBasePath : 'drawing/',
	refreshBasePath : 'refresh/',
	/*
	 * FUNCTIONS FOR FUTURE SPRITE-DRIVEN EDITOR
	 */
	recalculateLeftOffsets : function() {
		var elementsMargin = 0;

		var getXDisplace = function($elem) {
			var xDispFactor = 1;
			var xDisp = $elem.data('xDisplace');
			if (typeof xDisp === 'undefined')
				xDisp = 0;
			return xDisp * xDispFactor;
		};

		var mainDiv = this.stateMachine.jQueryCache['sprGraphEditor'];
		var config = this._getGroupConfig(mainDiv);

		// Hide unnecesary elements
		if (config.mixeds == 0)
			mainDiv.find('.mixeds').hide();
		else
			mainDiv.find('.mixeds').show().filter(':gt(' + (config.mixeds - 1) + ')').hide();
		mainDiv.find('.inputs').show().filter(':lt(' + (12 - config.inputs) + ')').hide();
		if (config.outputs == 0)
			mainDiv.find('.outputs').hide();
		else
			mainDiv.find('.outputs').show().filter(':gt(' + (config.outputs - 1) + ')').hide();
		if (config.stations == 0)
			mainDiv.find('.stations').hide();
		else
			mainDiv.find('.stations').show().find('.block_disk').show().end().filter(
					':gt(' + (config.stations - 1) + ')').hide().end().find('.block_disk').filter(
					':gt(' + Math.max(config.stations - 2, 0) + ')').hide().end().filter(
					':eq(' + Math.max(config.stations - 1, 0) + ')').hide().end();
		if (!config.d2_manifold)
			mainDiv.find('.manifold_d2').hide();
		else
			mainDiv.find('.manifold_d2').show();
		if (!config.u_manifold)
			mainDiv.find('.manifold_u, .manifold_u_label').hide();
		else
			mainDiv.find('.manifold_u, .manifold_u_label').show();
		if (config.si_manifold)
			mainDiv.find('.manifold_d').addClass('si_unit');
		else
			mainDiv.find('.manifold_d').removeClass('si_unit');

		/*
		 * Start giving left offset
		 */
		var offset = 0;

		// 0. Mixeds
		var $visMixeds = mainDiv.find('.mixeds:visible');
		var total = $visMixeds.length;
		var current = 0;
		$visMixeds.each(function() {
			var $elem = $(this);
			offset += getXDisplace($elem);
			$elem.find('div').css({
				left : offset
			});
			offset += $elem.find('.mixed_element').outerWidth() + elementsMargin;
			// $elem.find('.mixed_number label').html(total - current);
			current++;
		});

		// 1. Inputs
		mainDiv.find('.inputs:visible').each(function() {
			var $elem = $(this);
			offset += getXDisplace($elem);
			$elem.find('div').css({
				left : offset
			});
			offset += $elem.find('.input_element').outerWidth() + elementsMargin;
		});

		// 2. D2 manifold
		if (config.d2_manifold) {
			var $elem = mainDiv.find('.manifold_d2');
			offset += getXDisplace($elem);
			$elem.css({
				left : offset
			});
			offset += $elem.outerWidth() + elementsMargin;
		}

		// 3. Outputs
		var $visOutputs = mainDiv.find('.outputs:visible');
		$visOutputs.each(function() {
			var $elem = $(this);
			offset += getXDisplace($elem);
			$elem.find('div').css({
				left : offset
			});
			offset += $elem.find('.output_element').outerWidth() + elementsMargin;
		});

		// 4. D manifold
		var $elem = mainDiv.find('.manifold:first div:first');
		offset += getXDisplace($elem);
		$elem.css({
			left : offset
		});
		mainDiv.find('.manifold:first div:eq(1)').width($elem.width());
		mainDiv.find('.manifold:first div:eq(1)').css({
			left : offset
		});
		offset += $elem.outerWidth() + elementsMargin;

		// 5. Stations
		mainDiv.find('.stations:visible').each(function() {
			var $elem = $(this);
			$elem.find('div').css({
				left : offset
			});
			var valve = $elem.find('.valves');

			var oh = valve[0].offsetHeight;
			if (oh > 69)
				valve.addClass('big_valve');
			else
				valve.removeClass('big_valve');

			valve.css({
				left : (offset + getXDisplace(valve))
			});
			var inter = $elem.find('.intermediate_level');
			inter.css({
				left : (offset + getXDisplace(inter))
			});
			var base = $elem.find('.base_plate');
			base.css({
				left : (offset + getXDisplace(base))
			});
			offset += base.outerWidth() + elementsMargin;
			if ($elem.find('.intermediate_level').hasClass('no_image'))
				$elem.addClass('no_intermediate');
		});

		// 6. U manifold
		mainDiv.find('.manifold:eq(1) div').css({
			left : offset
		});
		offset += mainDiv.find('.manifold:eq(1) div:eq(1)').outerWidth() + elementsMargin;

		window.setTimeout(function() {
			if (mainDiv.find('.no_intermediate').length == 24)
				mainDiv.removeClass('any_has_intermediate');
			else
				mainDiv.addClass('any_has_intermediate');

			if (mainDiv.find('.big_valve').length == 0)
				mainDiv.removeClass('any_has_big_valve');
			else
				mainDiv.addClass('any_has_big_valve');
		}, 200);

		return this;
	},
	recalculateHeights : function(recalculateAfterTimeout, modifiedSelection) {
		for (var i = 0; i < recalculateAfterTimeout.length; i++) {
			var elem = recalculateAfterTimeout[i].elem;
			if (recalculateAfterTimeout[i].type.indexOf('manifold') > -1) {
				var oh = elem[0].offsetHeight;
				if (oh < 90) {
					if (oh <= 55)
						elem.removeClass('medium_manifold').removeClass('large_manifold').removeClass('short_manifold')
								.removeClass('xmedium_manifold').addClass('xshort_manifold');
					else if (oh <= 80)
						elem.removeClass('xshort_manifold').removeClass('large_manifold')
								.removeClass('medium_manifold').removeClass('xmedium_manifold').addClass(
										'short_manifold');
					else
						elem.removeClass('xshort_manifold').removeClass('large_manifold').removeClass('short_manifold')
								.removeClass('xmedium_manifold').addClass('medium_manifold');
				} else if (oh > 90 && oh < 115) {
					elem.removeClass('xshort_manifold').removeClass('large_manifold').removeClass('short_manifold')
							.removeClass('medium_manifold').addClass('xmedium_manifold');
				} else if (oh > 115) {
					elem.removeClass('medium_manifold').removeClass('xmedium_manifold').removeClass('short_manifold')
							.removeClass('xshort_manifold').addClass('large_manifold');
				}
			} else if (recalculateAfterTimeout[i].type.indexOf('valve') > -1) {
				var oh = elem[0].offsetHeight;
				if (oh > 69)
					elem.addClass('big_valve');
				else
					elem.removeClass('big_valve');
			}
			if (modifiedSelection && self.stateMachine._hasClass(elem[0], 'selected')) {
				elem[0].style.zIndex = 1000;
			}
		}
	},
	_setStations : function(stationsNumber) {
		this.stateMachine.jQueryCache['sprGraphEditor'].data('stations', stationsNumber);
		return this;
	},
	_setInputs : function(inputNumber) {
		this.stateMachine.jQueryCache['sprGraphEditor'].data('inputs', inputNumber);
		return this;
	},
	_setOutputs : function(outputNumber) {
		this.stateMachine.jQueryCache['sprGraphEditor'].data('outputs', outputNumber);
		return this;
	},
	_setSIManifold : function(siManifold) {
		this.stateMachine.jQueryCache['sprGraphEditor'].data('si_manifold', siManifold);
		return this;
	},
	_setD2Manifold : function(d2Manifold) {
		this.stateMachine.jQueryCache['sprGraphEditor'].data('d2_manifold', d2Manifold);
		return this;
	},
	_getGroupConfig : function(div) {
		var groupConfig = {};

		// Number of mixeds
		groupConfig.mixeds = div.data('mixeds');

		// Number of inputs
		groupConfig.inputs = div.data('inputs');

		// Number of outputs
		groupConfig.outputs = div.data('outputs');

		// Number of stations
		groupConfig.stations = div.data('stations');

		// d2 manifold
		groupConfig.d2_manifold = div.data('d2_manifold');

		// si manifold
		groupConfig.si_manifold = div.data('si_manifold');

		groupConfig.u_manifold = div.data('u_manifold');

		return groupConfig;

	},
	_swapStations : function(station1, station2) {
		var _hasIntermediate = !station1.hasClass('no_intermediate');
		var _hasBlockDisk = !station1.hasClass('no_block_disk');
		var _blockDiskClass = station1.find('.block_disk')[0].className;
		var _wiring = station1.find('.station_wiring label').html();
		var _basePlateClass = station1.find('.base_plate')[0].className;
		var _intermediateLevelClass = station1.find('.intermediate_level')[0].className;
		var _valvesClass = station1.find('.valves')[0].className;
		var _intermediateIsVisible = station1.find('.intermediate_level').is(':visible');
		var _intermediate2IsVisible = station2.find('.intermediate_level').is(':visible');

		var station1Idx = window.parseDecimalInt(station1[0].className.replace(/.*station_([0-9]+).*/, '$1'));
		var station2Idx = window.parseDecimalInt(station2[0].className.replace(/.*station_([0-9]+).*/, '$1'));

		this._convertIds(station1.find('.block_disk'), station2.find('.block_disk'), station2Idx - station1Idx);
		this._convertIds(station1.find('.base_plate'), station2.find('.base_plate'), station2Idx - station1Idx);
		this._convertIds(station1.find('.intermediate_level'), station2.find('.intermediate_level'), station2Idx
				- station1Idx);
		this._convertIds(station1.find('.valves'), station2.find('.valves'), station2Idx - station1Idx);

		if (station2.hasClass('no_intermediate'))
			station1.addClass('no_intermediate');
		else
			station1.removeClass('no_intermediate');
		if (station2.hasClass('no_block_disk'))
			station1.addClass('no_block_disk');
		else
			station1.removeClass('no_block_disk');
		station1.find('.block_disk')[0].className = station2.find('.block_disk')[0].className;
		station1.find('.station_wiring label').html(station2.find('.station_wiring label').html());
		station1.find('.base_plate')[0].className = station2.find('.base_plate')[0].className;
		station1.find('.intermediate_level')[0].className = station2.find('.intermediate_level')[0].className;
		station1.find('.valves')[0].className = station2.find('.valves')[0].className;

		if (_intermediate2IsVisible) {
			station1.find('.intermediate_level').show();
			var offset = station1.find('.intermediate_level').offset();
			var offsetValve = station1.find('.valves').offset();
			offset.left = offsetValve.left;
			station1.find('.intermediate_level').offset(offset);
		} else {
			station1.find('.intermediate_level').hide();
		}

		if (_intermediateIsVisible) {
			station2.find('.intermediate_level').show();
			var offset = station2.find('.intermediate_level').offset();
			var offsetValve = station2.find('.valves').offset();
			offset.left = offsetValve.left;
			station2.find('.intermediate_level').offset(offset);
		} else {
			station2.find('.intermediate_level').hide();
		}

		if (!_hasIntermediate)
			station2.addClass('no_intermediate');
		else
			station2.removeClass('no_intermediate');
		if (!_hasBlockDisk)
			station2.addClass('no_block_disk');
		else
			station2.removeClass('no_block_disk');
		station2.find('.block_disk')[0].className = _blockDiskClass;
		station2.find('.station_wiring label').html(_wiring);
		station2.find('.base_plate')[0].className = _basePlateClass;
		station2.find('.intermediate_level')[0].className = _intermediateLevelClass;
		station2.find('.valves')[0].className = _valvesClass;
		if (_intermediateIsVisible)
			station2.find('.intermediate_level').show();
		else
			station2.find('.intermediate_level').hide();

		this._copyData(station1.find('.block_disk'), station2.find('.block_disk'));
		this._copyData(station1.find('.base_plate'), station2.find('.base_plate'));
		this._copyData(station1.find('.intermediate_level'), station2.find('.intermediate_level'));
		this._copyData(station1.find('.valves'), station2.find('.valves'));

		var station2Last = !(station2.next('.stations').is(':visible'));
		station2.find('.block_disk').data('last', station2Last);
		station2.find('.base_plate').data('last', station2Last);
		station2.find('.intermediate_level').data('last', station2Last);
		station2.find('.valves').data('last', station2Last);

		var station1Last = !(station1.next('.stations').is(':visible'));
		station1.find('.block_disk').data('last', station1Last);
		station1.find('.base_plate').data('last', station1Last);
		station1.find('.intermediate_level').data('last', station1Last);
		station1.find('.valves').data('last', station1Last);

		var station2First = !(station2.prev('.stations').is(':visible'));
		station2.find('.block_disk').data('first', station2First);
		station2.find('.base_plate').data('first', station2First);
		station2.find('.intermediate_level').data('first', station2First);
		station2.find('.valves').data('first', station2First);

		var station1First = !(station1.prev('.stations').is(':visible'));
		station1.find('.block_disk').data('first', station1First);
		station1.find('.base_plate').data('first', station1First);
		station1.find('.intermediate_level').data('first', station1First);
		station1.find('.valves').data('first', station1First);
	},
	_swapElements : function(elem1, elem2) {
		var _class = elem1[0].className;
		elem1[0].className = elem2[0].className;
		elem2[0].className = _class;
		this._copyData(elem1, elem2);

		var clazz = '.inputs';
		if (elem1.hasClass('output_element'))
			clazz = '.outputs';
		else if (elem1.hasClass('mixed_element'))
			clazz = '.mixeds';

		var elem1IsFirst = !(elem1.parent().prev(clazz).is(':visible'));
		elem1.data('first', elem1IsFirst);
		var elem2IsFirst = !(elem2.parent().prev(clazz).is(':visible'));
		elem2.data('first', elem2IsFirst);
		var elem1IsLast = !(elem1.parent().next(clazz).is(':visible'));
		elem1.data('last', elem1IsLast);
		var elem2IsLast = !(elem2.parent().next(clazz).is(':visible'));
		elem2.data('last', elem2IsLast);
	},
	_convertIds : function(elem1, elem2, diff) {
		var elem1Id = elem1[0].id, elem2Id = elem2[0].id;

		var schemaIdx = window.parseDecimalInt(elem1Id.replace(/.*\|BL_[0-9]+\[[0-9]+,([0-9]+)\]\|[^\|]+/, '$1'));
		var newIdx = (schemaIdx + diff >= 10) ? (schemaIdx + diff) + '' : '0' + (schemaIdx + diff);
		var elem2NewId = elem1Id.replace(/(.*)\|BL_([0-9]+)\[([0-9]+),[0-9]+\]\|([^\|]+)/, '$1|BL_$2[$3,' + newIdx
				+ ']|$4');

		schemaIdx = window.parseDecimalInt(elem2Id.replace(/.*\|BL_[0-9]+\[[0-9]+,([0-9]+)\]\|[^\|]+/, '$1'));
		newIdx = (schemaIdx - diff >= 10) ? (schemaIdx - diff) + '' : '0' + (schemaIdx - diff);
		var elem1NewId = elem2Id.replace(/(.*)\|BL_([0-9]+)\[([0-9]+),[0-9]+\]\|([^\|]+)/, '$1|BL_$2[$3,' + newIdx
				+ ']|$4');

		elem1[0].id = elem1NewId;
		elem2[0].id = elem2NewId;
	},
	_copyData : function(elem1, elem2) {
		var elem1_first = elem1.data('first');
		var elem1_last = elem1.data('last');
		var elem1_cellType = elem1.data('cellType');
		var elem1_deleteActive = elem1.data('deleteActive');
		var elem1_currentImg = elem1.data('currentImg');
		var elem1_currentProd = elem1.data('currentProd');
		var elem1_currentStatus = elem1.data('currentStatus');
		var elem1_remGrp = elem1.data('remGrp');
		var elem1_xDisplace = elem1.data('xDisplace');
		var elem1_yDisplace = elem1.data('yDisplace');

		var elem2_first = elem2.data('first');
		var elem2_last = elem2.data('last');
		var elem2_cellType = elem2.data('cellType');
		var elem2_deleteActive = elem2.data('deleteActive');
		var elem2_currentImg = elem2.data('currentImg');
		var elem2_currentProd = elem2.data('currentProd');
		var elem2_currentStatus = elem2.data('currentStatus');
		var elem2_remGrp = elem2.data('remGrp');
		var elem2_xDisplace = elem2.data('xDisplace');
		var elem2_yDisplace = elem2.data('yDisplace');

		elem1.data('first', elem2_first);
		elem1.data('last', elem2_last);
		elem1.data('cellType', elem2_cellType);
		elem1.data('deleteActive', elem2_deleteActive);
		elem1.data('currentImg', elem2_currentImg);
		elem1.data('currentProd', elem2_currentProd);
		elem1.data('currentStatus', elem2_currentStatus);
		elem1.data('remGrp', elem2_remGrp);
		elem1.data('xDisplace', elem2_xDisplace);
		elem1.data('yDisplace', elem2_yDisplace);

		elem2.data('first', elem1_first);
		elem2.data('last', elem1_last);
		elem2.data('cellType', elem1_cellType);
		elem2.data('deleteActive', elem1_deleteActive);
		elem2.data('currentImg', elem1_currentImg);
		elem2.data('currentProd', elem1_currentProd);
		elem2.data('currentStatus', elem1_currentStatus);
		elem2.data('remGrp', elem1_remGrp);
		elem2.data('xDisplace', elem1_xDisplace);
		elem2.data('yDisplace', elem1_yDisplace);
	},
	_pushRight : function($elems, amount) {
		$elems.each(function() {
			var $elem = $(this);
			try {
				var current = window.parseDecimalInt($elem.css('left').replace('px', ''));
				$elem.css({
					left : (current + amount)
				});
			} catch (Except) {
				console.log(Except);
			}
		});
	},
	_resetGrid : function() {
		var _$ = this.stateMachine.jQuery;

		var mixeds = this.stateMachine.jQueryCache['sprGraphEditor'].find('.mixeds .mixed_element');
		var inputs = this.stateMachine.jQueryCache['sprGraphEditor'].find('.inputs .input_element');
		var manifold_d2 = this.stateMachine.jQueryCache['sprGraphEditor'].find('.manifold_d2');
		var outputs = this.stateMachine.jQueryCache['sprGraphEditor'].find('.outputs .output_element');
		var manifolds = this.stateMachine.jQueryCache['sprGraphEditor'].find('.manifold');
		var stations = this.stateMachine.jQueryCache['sprGraphEditor'].find('.stations');

		mixeds.each(function() {
			this.className = 'mixed_element selectable unselected';
		});
		inputs.each(function() {
			this.className = 'input_element selectable unselected';
		});
		manifold_d2[0].className = 'manifold_d2 selectable';
		outputs.each(function() {
			this.className = 'output_element selectable unselected';
		});
		stations.each(function() {
			var $this = _$(this);
			$this.addClass('no_intermediate').addClass('no_configured_block_disk');
		});
	},
	_fixEditor : function() {
		this.recalculateLeftOffsets();
		var elems = this.stateMachine.jQueryCache['sprGraphEditor'].find(".manifold div:not(.label)").map(function() {
			return {
				elem : $(this),
				type : 'manifold'
			};
		}).toArray();
		elems.concat(this.stateMachine.jQueryCache['sprGraphEditor'].find(".valves:visible").map(function() {
			return {
				elem : $(this),
				type : 'valve'
			};
		}).toArray());
		this.recalculateHeights(elems, false);
	}
});



$(document).ready(function() {
	
	
	console.log("document readu graphicaleditorcontroller");
	
});

const toggleExportButtons = function(isValid) {
	const attributeValue = isValid ? 'valid' : 'invalid';
	const elements = ['exportBom', 'exportSpecifications', 'exportValvePDF', 'sendVcToBasket', 'sendVcToFavourites'];

	for(var i = 0; i < elements.length; i++) {
		var element = document.getElementById(elements[i]);
		if(element){
			element.setAttribute('data-configuration', attributeValue);
		}
	}

	const internalUsersElements = ['sendVcToBasket', 'sendVcToFavourites'];
	if(window.valveConfigurationViewModel.isOpenedGroup() && isInternalUser) {
		for(var i = 0; i < internalUsersElements.length; i++) {
			var element = document.getElementById(internalUsersElements[i]);
			if(element){
				element.setAttribute('data-configuration', 'invalid');
			}
		}
	}

}

const toggleConfigurationProperties = function(json){

	$('#valve_external_pdSummary').hide();

    let notice = json.notices;
    var redMessages = false;
	if(notice) {

        // 'notice' format:
        // [ type<Type>message<br>, type<Type>message<br>, (...) ]

        let notices = notice.split('<br>');
        notices.pop(); // remove last [""] generated by split '<br>'

        var htmlMessageFinal = "";
        for (var i = 0; i < notices.length; i++) {
            let splitedNotice = notices[i].split('<Type>');
            let type =  splitedNotice[0];
            let message = splitedNotice[1];

            if (type === 'standard') {
               redMessages = true;
               break;
            }
        }
    }

    console.log("[GraphicalEditorController] stateMachine.isIncompatible: " + stateMachine.isIncompatible);
    console.log("[GraphicalEditorController] redMessages: " + redMessages);

	let enabledSimpleSpecial = false;
	if(!stateMachine.isIncompatible && !redMessages){
		console.log("[GraphicalEditorController] valid");

		// Enable create simple special
		enabledSimpleSpecial = true;
		toggleExportButtons(true);
		document.getElementById('meassures').className = 'enabled';
		

        var isCustomizedConf = isCustomizedConfiguration(json);
        var isCustomizedMnf = isCustomizedManifold(json);

        // Check if custom items in configuration
        if( isCustomizedConf ) {
            if( $(".show-3d-preview").length > 0){
                $(".show-3d-preview")[0].classList.add("customConf");
            }
            if( $(".show-cad-download").length > 0){
                $(".show-cad-download")[0].classList.add("customConf");
            }

        } else {
            if( $(".show-3d-preview").length > 0){
                $(".show-3d-preview")[0].classList.remove("customConf");
            }
            if( $(".show-cad-download").length > 0){
                $(".show-cad-download")[0].classList.remove("customConf");
            }
        }

        // Check if custom manifold(s) in configuration
        if( isCustomizedMnf ) {
            if( $(".show-3d-preview").length > 0){
                $(".show-3d-preview")[0].classList.add("customManifold");
            }
            if( $(".show-cad-download").length > 0){
                $(".show-cad-download")[0].classList.add("customManifold");
            }

        } else {
            if( $(".show-3d-preview").length > 0){
                $(".show-3d-preview")[0].classList.remove("customManifold");
            }
            if( $(".show-cad-download").length > 0){
                $(".show-cad-download")[0].classList.remove("customManifold");
            }
        }

        // Enable '3D preview'?
        if( !isCustomizedConf && !isCustomizedMnf){
		    $(document).trigger('smc.productToolbar.3dPreview.enable');
		    $(document).trigger('smc.productToolbar.cadDownload.enable');
        } else {
			$(document).trigger('smc.productToolbar.3dPreview.disable');
		    $(document).trigger('smc.productToolbar.cadDownload.disable');
		}

	} else {
		toggleExportButtons(false);
		console.log("[GraphicalEditorController] invalid");
        document.getElementById('meassures').className = 'disabled';

		$(document).trigger('smc.productToolbar.3dPreview.disable');
		$(document).trigger('smc.productToolbar.cadDownload.disable');

	}

	valveConfigurationViewModel.enabledSimpleSpecial(enabledSimpleSpecial);

}

// copied from _doRefreshGraphicalEditor
const isCustomizedConfiguration = function(json){
	var isCustomized = false;
	for (var elemId in json) {
		var obj = json[elemId];
		if (typeof obj == 'object') {
			var notUndefined = false;
			if (obj.cellType == 'manifoldU') {
				notUndefined = true;
			} else if (obj.cellType == 'manifoldD') {
				notUndefined = true;
			} else if (obj.cellType == 'station') {
				notUndefined = true;
			} else if (obj.cellType == 'input') {
				notUndefined = true;
			} else if (obj.cellType == 'output') {
				notUndefined = true;
			} else if (obj.cellType == 'mixed') {
				notUndefined = true;
			} else if (obj.cellType == 'manifoldD2') {
				notUndefined = true;
			}
			if (notUndefined) {
			    console.log( " > isCustomizedConfiguration: " + elemId + " - obj.isCustomized -> " + obj.isCustomized);
				if(obj.isCustomized){
					isCustomized = true;
				}
			}
		}
	}
	return isCustomized;
}

// copied from _doRefreshGraphicalEditor
const isCustomizedManifold = function(json){
	var isCustomized = false;
	for (var elemId in json) {
		var obj = json[elemId];
		if (typeof obj == 'object') {
			var notUndefined = false;
			if (obj.cellType == 'manifoldU' || obj.cellType == 'manifoldD' || obj.cellType == 'manifoldD2') {

				if(obj.isCustomized) {
					isCustomized = true;
				}
			}
		}
	}
	return isCustomized;
}

const isValidConfiguration = function(json){
	let valid;

    // 'messages['ERRORES_CONFIGURACION']' comes from StateMachine.js _check()
    if( window.stateMachine.messages.ERRORES_CONFIGURACION.mensaje ){
        return false;
    }

	var lastReach = false;
	for(let property in json){
		if(json.hasOwnProperty(property) && json[property] && typeof json[property] === typeof {}){
			if(json[property].isLast) {
				lastReach = true;
			}
			valid = (typeof valid === typeof foo || valid) ? isValidItemConfiguration(json[property], lastReach) : valid;
		}
	}

	console.log("valid");
	console.log(valid);
	return valid;
};

const isValidItemConfiguration = function(item, lastReach) {
	return item && (item.status === 'bw' || item.image.toLowerCase().includes('block_disk') || (item.cellType === 'station' && item.image === '' && lastReach));
}

const noticeRender = function(notice) {

	console.log('noticeRender');
	if(notice) {

		console.log('noticeRender notice');
		$('#configurator_panel_div_notices label').removeClass("valve_notices valve_notices_info")

        // 'notice' format:
        // [ type<Type>message<br>, type<Type>message<br>, (...) ]

        let notices = notice.split('<br>');
        notices.pop(); // remove last [""] generated by split '<br>'

        var htmlMessageFinal = "";
        for (var i = 0; i < notices.length; i++) {
            let splitedNotice = notices[i].split('<Type>');
            let type =  splitedNotice[0];
            let message = splitedNotice[1];

            let classToAdd = '';
            if(type === 'informativo') {
                    classToAdd = 'valve_notices_info';
            } else if (type === 'standard') {
                classToAdd = 'valve_notices';
            }

            let htmlMessage = "<li><label class='" + classToAdd +"'>" + message + "</label></li>";
            htmlMessageFinal = htmlMessageFinal + htmlMessage;
        }

        $('#configurator_panel_div_notices label').html( htmlMessageFinal );

	} else {
		console.log('noticeRender notice not notice');
		$('#configurator_panel_div_notices label').html('');
	}
}

const updateProjectDescription = function(json, userCountry){
    var mixeds = _.chain(json).map(function(val, key) {
        if (typeof val == 'object')
            return (val.cellType == 'mixed') ? 1 : 0;
        return 0;
    }).reduce(function(memo, num) {
        return memo + num;
    }).value();

    var text = "";
    var description_text = $('#projectDescription').val();

    var text_es = "Bloque de válvulas SY con módulo EX600 y unidades de entrada/salida.\nFabricación local.";
    var text_pt = "Bloco de válvulas SY com módulo EX600 e unidades de entrada/saída.\nFabricação local.";
    if( userCountry == 'ES'){
        text = text_es;
    } else {
        text = text_pt;
    }

    if( mixeds != 0 && isValidConfiguration(json) ){ // Agregar texto si no está, cuando estaciones > 0 y la config es válida
        if( description_text.indexOf(text) == -1 ){
            $('#projectDescription').val(text + "\n" + description_text);
            updateProductInformation();
        }
    } else { // Eliminar texto si estuviera, cuando estaciones = 0 o config es inválida
        if( (description_text).indexOf(text + "\n") !== -1 ){
            $('#projectDescription').val( (description_text).replace(text + "\n", "") );
            updateProductInformation();

        } else if( description_text.indexOf(text) !== -1 ){
                $('#projectDescription').val( description_text.replace(text, "") );
                updateProductInformation();

        }
    }
}

let productIndformationInputs = document.getElementsByClassName('product-information-form');
const updateProductInformation = function(e, type) {
	var requestData = {};

	for (var i = 0; i < productIndformationInputs.length; i++) {
		const requestKey = productIndformationInputs[i].getAttribute('data-key');
		const requestKeys = requestKey.split('.');
		const value = productIndformationInputs[i].value;

		const node = requestKeys[0];
		const child = requestKeys[1];

		if(!requestData[node]) {
			requestData[node] = {};
		}

		if(child && child.length > 0) {
			requestData[node][child] = value;
		} else {
			requestData[node] = value;
		}
	}

	return $.ajaxHippo({
		type: 'POST',
		url: updateContactsUrl,
		data: {
			node : JSON.stringify(requestData),
			saveType: type
		},
		async: true
	});
};