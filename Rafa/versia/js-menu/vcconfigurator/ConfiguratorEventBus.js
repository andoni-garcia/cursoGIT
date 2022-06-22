var ConfiguratorEventBus = EventBus
		.extend({
			init : function(debug) {
				// State machine events
				this.eventList['onStateChange'] = new Event('onStateChange');
				this.eventList['onSetStatusChanged'] = new Event('onSetStatusChanged');

				if (typeof debug === 'boolean')
					this.debug = debug;

				// Graphical tools events
				this.eventList['onBrushClick'] = new Event('onBrushClick');
				this.eventList['onDisabledPanel'] = new Event('onDisabledPanel');
				this.eventList['onEnabledPanel'] = new Event('onEnabledPanel');
				this.eventList['afterBrushClick'] = new Event('afterBrushClick');
				this.eventList['onMeassuresClick'] = new Event('onMeassuresClick');
				this.eventList['afterMeassuresClick'] = new Event('afterMeassuresClick');
				this.eventList['onConfigurationChange'] = new Event('onConfigurationChange');
				this.eventList['afterConfigurationChange'] = new Event('afterConfigurationChange');
				this.eventList['onMoveLeftClick'] = new Event('onMoveLeftClick');
				this.eventList['afterMoveLeftClick'] = new Event('afterMoveLeftClick');
				this.eventList['onMoveRightClick'] = new Event('onMoveRightClick');
				this.eventList['afterMoveRightClick'] = new Event('afterMoveRightClick');
				this.eventList['onAddStationClick'] = new Event('onAddStationClick');
				this.eventList['afterAddStationClick'] = new Event('afterAddStationClick');
				this.eventList['onDeleteStationClick'] = new Event('onDeleteStationClick');
				this.eventList['afterDeleteStationClick'] = new Event('afterDeleteStationClick');
				this.eventList['onDeleteProductClick'] = new Event('onDeleteProductClick');
				this.eventList['afterDeleteProductClick'] = new Event('afterDeleteProductClick');
				this.eventList['onUndoActionClick'] = new Event('onUndoActionClick');
				this.eventList['afterUndoActionClick'] = new Event('afterUndoActionClick');
				this.eventList['onRedoActionClick'] = new Event('onRedoActionClick');
				this.eventList['afterRedoActionClick'] = new Event('afterRedoActionClick');
				this.eventList['onCheckClick'] = new Event('onCheckClick');
				this.eventList['afterCheckClick'] = new Event('afterCheckClick');
				this.eventList['afterUncommitedBrushClick'] = new Event('afterUncommitedBrushClick');

				// Graphical editor events
				this.eventList['onGraphicalElementClick'] = new Event('onGraphicalElementClick');
				this.eventList['afterGraphicalElementClick'] = new Event('afterGraphicalElementClick');
				this.eventList['graphicalEditorRefreshed'] = new Event('graphicalEditorRefreshed');

				// Tabs events
				this.eventList['onTabClick'] = new Event('onTabClick');
				this.eventList['afterTabClick'] = new Event('afterTabClick');
				this.eventList['onReportSpecificationClick'] = new Event('onReportSpecificationClick');
				this.eventList['afterReportSpecificationClick'] = new Event('afterReportSpecificationClick');
				this.eventList['onCharacteristicChange'] = new Event('onCharacteristicChange');
				this.eventList['afterCharacteristicChange'] = new Event('afterCharacteristicChange');
				this.eventList['onAddProductClick'] = new Event('onAddProductClick');
				this.eventList['afterAddProductClick'] = new Event('afterAddProductClick');
				this.eventList['onDeleteProductClick'] = new Event('onDeleteProductClick');
				this.eventList['afterDeleteProductClick'] = new Event('afterDeleteProductClick');
				this.eventList['onFreeReferenceEntered'] = new Event('onFreeReferenceEntered');
				this.eventList['afterFreeReferenceEntered'] = new Event('afterFreeReferenceEntered');
				this.eventList['onFreeReferenceMeasuresClick'] = new Event('onFreeReferenceMeasuresClick');
				this.eventList['afterFreeReferenceMeasuresClick'] = new Event('afterFreeReferenceMeasuresClick');
				this.eventList['onResetClick'] = new Event('onResetClick');
				this.eventList['afterResetClick'] = new Event('afterResetClick');
				this.eventList['onFreeReferencePartDeleted'] = new Event('onFreeReferencePartDeleted');
				this.eventList['afterFreeReferencePartDeleted'] = new Event('afterFreeReferencePartDeleted');
				this.eventList['onFreeReferencePartAdded'] = new Event('onFreeReferencePartAdded');
				this.eventList['afterFreeReferencePartAdded'] = new Event('afterFreeReferencePartAdded');
				this.eventList['onFreeReferencePartModified'] = new Event('onFreeReferencePartModified');
				this.eventList['afterFreeReferencePartModified'] = new Event('afterFreeReferencePartModified');
				this.eventList['aftermanifoldSpecialButtonClick'] = new Event('aftermanifoldSpecialButtonClick');

				// SMC tools (basket, favourites...) events
				this.eventList['onAddToBasketClick'] = new Event('onAddToBasketClick');
				this.eventList['afterAddToBasketClick'] = new Event('afterAddToBasketClick');
			},
			eventList : {},
			events : {},
			sortEventSubscribers : function() {
				for ( var key in this.events) {
					var _subs = _
							.sortBy(
									this.events[key].subscribers,
									function(elem) {
										return (typeof elem.priority == 'undefined') ? 99
												: elem.priority;
									});
					this.events[key].subscribers = _subs;
				}
			}
		});