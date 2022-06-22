var SelSeries = Class
		.extend({
			init : function($) {
				this.jQuery = $;

				this.selection.manyfold._default = this.manyfold_type.IP40;
				this.selection.piping._default = this.piping_redirection.SIDE;
				this.selection.connection._default = this.connection_type.DSUB;
				this.selection.valve._default = this.valve_size.SY3000;

				this.jQueryCache.manyfolds = this.jQuery('.manyfold');
				this.jQueryCache.manyfoldField = this.jQuery('#manyfoldField');
				this.jQueryCache.pipings = this.jQuery('.piping');
				this.jQueryCache.pipingField = this.jQuery('#pipingField');
				this.jQueryCache.connections = this.jQuery('.connection');
				this.jQueryCache.connectionField = this
						.jQuery('#connectionField');
				this.jQueryCache.valves = this.jQuery('.valve');
				this.jQueryCache.valveField = this.jQuery('#valveField');
				this.jQueryCache.boton = this.jQuery('#boton');

				this.jQueryCache.manifoldInfo = this.jQuery('#manifoldInfo');
				this.jQueryCache.pipingInfo = this.jQuery('#pipingInfo');
				this.jQueryCache.parallelConnectionInfo = this
						.jQuery('#parallelConnectionInfo');
				this.jQueryCache.serialConnectionInfo = this
						.jQuery('#serialConnectionInfo');
				this.jQueryCache.valveInfo = this.jQuery('#valveInfo');

				var params = {
					object : this
				};
				this.jQueryCache.manyfolds.parent().bind('click', params,
						this.onManyfoldClicked);
				this.jQueryCache.pipings.parent().bind('click', params,
						this.onPipingClicked);
				this.jQueryCache.connections.parent().bind('click', params,
						this.onConnectionClicked);
				this.jQueryCache.valves.parent().bind('click', params,
						this.onValveClicked);
				this.jQueryCache.boton.bind('click', params,
						this.onBotonClicked);
				
//				this.jQueryCache.manyfolds.bind('click', params,
//						this.onManyfoldClicked);
//				this.jQueryCache.pipings.bind('click', params,
//						this.onPipingClicked);
//				this.jQueryCache.connections.bind('click', params,
//						this.onConnectionClicked);
//				this.jQueryCache.valves.bind('click', params,
//						this.onValveClicked);
//				this.jQueryCache.boton.bind('click', params,
//						this.onBotonClicked);

				this.jQueryCache.manifoldInfo.bind('click', params,
						this.onManifoldInfoClicked);
				this.jQueryCache.pipingInfo.bind('click', params,
						this.onPipingInfoClicked);
				this.jQueryCache.parallelConnectionInfo.bind('click', params,
						this.onParallelConnectionInfoClicked);
				this.jQueryCache.serialConnectionInfo.bind('click', params,
						this.onSerialConnectionInfoClicked);
				this.jQueryCache.valveInfo.bind('click', params,
						this.onValveInfoClicked);

				return this;
			},
			/*
			 * 'SETTER' METHODS
			 */
			addIncompatibility : function(type, manyfoldName, pipingName,
					connectorName, valveName) {
				var icmp = this.incompatibilities;
				var it = icmp.type;
				if (type == it.MANYFOLD)
					icmp.manyfold[manyfoldName] = [
							this.jQuery.trim(pipingName),
							this.jQuery.trim(connectorName),
							this.jQuery.trim(valveName) ];
				if (type == it.PIPING)
					icmp.piping[pipingName] = [ this.jQuery.trim(manyfoldName),
							this.jQuery.trim(connectorName),
							this.jQuery.trim(valveName) ];
				if (type == it.CONNECTOR)
					icmp.connection[connectorName] = [
							this.jQuery.trim(manyfoldName),
							this.jQuery.trim(pipingName),
							this.jQuery.trim(valveName) ];
				if (type == it.VALVE)
					icmp.valve[valveName] = [ this.jQuery.trim(manyfoldName),
							this.jQuery.trim(pipingName),
							this.jQuery.trim(connectorName) ];

				return this;
			},
			addConjunto : function(manyfold, piping, valve, connection,
					conjunto, nombreConjunto) {
				if (typeof this.conjuntos[manyfold] == 'undefined')
					this.conjuntos[manyfold] = {};
				if (typeof this.conjuntos[manyfold][piping] == 'undefined')
					this.conjuntos[manyfold][piping] = {};
				if (typeof this.conjuntos[manyfold][piping][valve] == 'undefined')
					this.conjuntos[manyfold][piping][valve] = {};
				if (typeof this.conjuntos[manyfold][piping][valve][connection] == 'undefined')
					this.conjuntos[manyfold][piping][valve][connection] = {};
				this.conjuntos[manyfold][piping][valve][connection] = {
					id : conjunto,
					serie : nombreConjunto
				};

				return this;
			},
			addConfigurationDoneHandler : function(fn) {
				this._onConfigFinished = fn;

				return this;
			},
			/*
			 * GETTER METHODS
			 */
			getSelectedManyfold : function() {
				return this.selection.manyfold.selected;
			},
			getSelectedPiping : function() {
				return this.selection.piping.selected;
			},
			getSelectedConnection : function() {
				return this.selection.connection.selected;
			},
			getSelectedValve : function() {
				return this.selection.valve.selected;
			},
			getConjunto : function() {
				var m = this.getSelectedManyfold();
				var p = this.getSelectedPiping();
				var c = this.getSelectedConnection();
				var v = this.getSelectedValve();
				if (typeof m == 'undefined' || typeof p == 'undefined'
						|| typeof c == 'undefined' || typeof v == 'undefined')
					return;
				return this.conjuntos[m.name][p.name][c.name][v.name];
			},
			getAllowedManyfolds : function() {
				return this.jQuery.map(this.manyfold_type, function(val, i) {
					return val['id'];
				});
			},
			getAllowedPipings : function() {
				var incomp = this.incompatibilities.piping;
				var pipingNames = this.jQuery.map(this.piping_redirection,
						function(val, i) {
							return val['id'];
						});
				var finalIncomp = [];
				for ( var pipingName in incomp) {
					if (this.conditionCheckers.checkManyfold(this,
							incomp[pipingName][0])) {
						finalIncomp.push('#p_' + pipingName.toLowerCase());
					}
				}
				return _.difference(pipingNames, finalIncomp);
			},
			getAllowedConnections : function() {
				var incomp = this.incompatibilities.connection;
				var connectionNames = this.jQuery.map(this.connection_type,
						function(val, i) {
							return val['id'];
						});
				var finalIncomp = [];
				for ( var connectionName in incomp) {
					if (typeof incomp[connectionName] !== 'function'
							&& this.conditionCheckers.checkManyfold(this,
									incomp[connectionName][0])
							&& this.conditionCheckers.checkPiping(this,
									incomp[connectionName][1])) {
						finalIncomp.push('#c_' + connectionName.toLowerCase());
					}
				}
				return _.difference(connectionNames, finalIncomp);
			},
			getAllowedValves : function() {
				var incomp = this.incompatibilities.valve;
				var valveNames = this.jQuery.map(this.valve_size, function(val,
						i) {
					return val['id'];
				});
				var finalIncomp = [];
				for ( var valveName in incomp) {
					if (typeof incomp[valveName] !== 'function'
							&& this.conditionCheckers.checkManyfold(this,
									incomp[valveName][0])
							&& this.conditionCheckers.checkPiping(this,
									incomp[valveName][1])
							&& this.conditionCheckers.checkConnection(this,
									incomp[valveName][2])) {
						finalIncomp.push('#v_' + valveName.toLowerCase());
					}
				}
				return _.difference(valveNames, finalIncomp);
			},
			/*
			 * FIELDSET ACTIVATOR/DESACTIVATOR METHODS
			 */
			activatePipingField : function() {
				this.desactivatePipingField();
				var allPipings = this.getAllowedPipings();
				for ( var idx in allPipings){
					if (typeof allPipings[idx] !== 'function'){
						this.jQueryCache.pipings.filter(allPipings[idx]).removeClass('noactive').addClass('active');
						this.jQueryCache.pipings.filter(allPipings[idx]).parent().removeClass('noactive').addClass('active');
					}
				}
				
				this.jQueryCache.pipingField.removeClass('noactive');
				// this.jQueryCache.pipingInfo.removeClass('noactive').addClass('active');

				return this;
			},
			activateConnectionField : function() {
				this.desactivateConnectionField();
				var allConnections = this.getAllowedConnections();
				for ( var idx in allConnections){
					if (typeof allConnections[idx] !== 'function'){
						this.jQueryCache.connections.filter(allConnections[idx]).removeClass('noactive').addClass('active');
						this.jQueryCache.connections.filter(allConnections[idx]).parent().removeClass('noactive').addClass('active');
					}
				}
				this.jQueryCache.connectionField.removeClass('noactive');
				
				// this.jQueryCache.parallelConnectionInfo.removeClass('noactive').addClass('active');
				// this.jQueryCache.serialConnectionInfo.removeClass('noactive').addClass('active');

				return this;
			},
			activateValveField : function() {
				this.desactivateValveField();
				var allValves = this.getAllowedValves();
				for ( var idx in allValves){
					if (typeof allValves[idx] !== 'function'){
						this.jQueryCache.valves.filter(allValves[idx]).removeClass('noactive').addClass('active');
						this.jQueryCache.valves.filter(allValves[idx]).parent().removeClass('noactive').addClass('active');
					}					
				}
				this.jQueryCache.valveField.removeClass('noactive');
				
				// this.jQueryCache.valveInfo.removeClass('noactive').addClass('active');

				return this;
			},
			activateBoton : function() {
				this.jQueryCache.boton.addClass('active').removeClass(
						'noactive');

				return this;
			},
			desactivatePipingField : function() {
				this.jQueryCache.pipings.removeClass('selected').removeClass('active').addClass('noactive');
				this.jQueryCache.pipings.parent().removeClass('selected').removeClass('active').addClass('noactive');
				this.jQueryCache.pipingField.addClass('noactive');
				this.jQueryCache.pipingField.parent().addClass('noactive');
				delete this.selection.piping.selected;
				
				// this.jQueryCache.pipingInfo.addClass('noactive').removeClass('active');

				return this;
			},
			desactivateConnectionField : function() {
				this.jQueryCache.connections.removeClass('selected').removeClass('active').addClass('noactive');
				this.jQueryCache.connections.parent().removeClass('selected').removeClass('active').addClass('noactive');
				this.jQueryCache.connectionField.parent().addClass('noactive');
				delete this.selection.connection.selected;
				// this.jQueryCache.parallelConnectionInfo.removeClass('active').addClass('noactive');
				// this.jQueryCache.serialConnectionInfo.removeClass('active').addClass('noactive');

				return this;
			},
			desactivateValveField : function() {
				this.jQueryCache.valves.removeClass('selected').removeClass('active').addClass('noactive');
				this.jQueryCache.valves.parent().removeClass('selected').removeClass('active').addClass('noactive');
				this.jQueryCache.valveField.addClass('noactive');
				this.jQueryCache.valveField.parent().addClass('noactive');
				delete this.selection.valve.selected;
				// this.jQueryCache.valveInfo.removeClass('active').addClass('noactive');

				return this;
			},
			desactivateBoton : function() {
				this.jQueryCache.boton.removeClass('active').addClass(
						'noactive');

				return this;
			},
			/*
			 * CLICK HANDLERS
			 */
			onManyfoldClicked : function(e) {
				var self = e.data.object;
				var mName = this.children[0].id.replace('m_', '').toUpperCase();
				if (self._hasClass(this, 'active')) {
					// A manyfold has been selected
					self.jQueryCache.manyfolds.filter('.selected').removeClass('selected').addClass('active');
					self.jQueryCache.manyfolds.parent().removeClass('selected').addClass('active');	
					
					this.className = (' ' + this.className + ' ').replace(' active ', ' selected ');					
					this.children[0].className = (' ' + this.children[0].className + ' ').replace(' active ', ' selected ');
					
					self.selection.manyfold.selected = self.manyfold_type[mName];
					self.activatePipingField();
					self.desactivateConnectionField();
					self.desactivateValveField();
					self.desactivateBoton();
				} else if (self._hasClass(this, 'selected')) {
					// A manyfold has been de-selected
					this.className = (' ' + this.className + ' ').replace(' selected ', ' active ');
					this.children[0].className = (' '+this.children[0].className + ' ').replace(' selected ', ' active ');
					
					delete self.selection.manyfold.selected;
					self.desactivatePipingField();
					self.desactivateConnectionField();
					self.desactivateValveField();
					self.desactivateBoton();
				}
			},
			onPipingClicked : function(e) {
				var self = e.data.object;
				var pName = this.children[0].id.replace('p_', '').toUpperCase();
				if (self._hasClass(this, 'active')) {
					// A piping has been selected
					self.jQueryCache.pipings.filter('.selected').removeClass('selected').addClass('active');
					self.jQueryCache.pipings.parent().removeClass('selected').addClass('active');	
										
					this.className = (' ' + this.className + ' ').replace(' active ', ' selected ');					
					this.children[0].className = (' ' + this.children[0].className + ' ').replace(' active ', ' selected ');
					
					self.selection.piping.selected = self.piping_redirection[pName];
					self.activateConnectionField();
					self.desactivateValveField();
					self.desactivateBoton();
				} else if (self._hasClass(this, 'selected')) {
					// A piping has been de-selected
					this.className = (' ' + this.className + ' ').replace(' selected ', ' active ');
					this.children[0].className = (' '+this.children[0].className + ' ').replace(' selected ', ' active ');
					
					delete self.selection.piping.selected;
					self.desactivateConnectionField();
					self.desactivateValveField();
					self.desactivateBoton();
				}
			},
			onConnectionClicked : function(e) {
				var self = e.data.object;
				var cName = this.children[0].id.replace('c_', '').toUpperCase();
				if (self._hasClass(this, 'active')) {
					// A connection has been selected
					self.jQueryCache.connections.filter('.selected').removeClass('selected').addClass('active');
					self.jQueryCache.connections.parent().removeClass('selected').addClass('active');	
					
					this.className = (' ' + this.className + ' ').replace(' active ', ' selected ');					
					this.children[0].className = (' ' + this.children[0].className + ' ').replace(' active ', ' selected ');
					
					self.selection.connection.selected = self.connection_type[cName];
					self.activateValveField();
					self.desactivateBoton();
				} else if (self._hasClass(this, 'selected')) {
					// A connection has been de-selected
					this.className = (' ' + this.className + ' ').replace(' selected ', ' active ');
					this.children[0].className = (' '+this.children[0].className + ' ').replace(' selected ', ' active ');
					
					delete self.selection.connection.selected;
					self.desactivateValveField();
					self.desactivateBoton();
				}
			},
			onValveClicked : function(e) {
				var self = e.data.object;
				var vName = this.children[0].id.replace('v_', '').toUpperCase();
				if (self._hasClass(this, 'active')) {
					// A valve has been selected
					self.jQueryCache.valves.filter('.selected').removeClass(
							'selected').addClass('active');
					
					this.className = (' ' + this.className + ' ').replace(' active ', ' selected ');					
					this.children[0].className = (' ' + this.children[0].className + ' ').replace(' active ', ' selected ');
					
					self.selection.valve.selected = self.valve_size[vName];
					self.activateBoton();
				} else if (self._hasClass(this, 'selected')) {
					// A valve has been de-selected
					this.className = (' ' + this.className + ' ').replace(' selected ', ' active ');
					this.children[0].className = (' '+this.children[0].className + ' ').replace(' selected ', ' active ');
					
					delete self.selection.valve.selected;
					self.desactivateBoton();
				}
			},
			onBotonClicked : function(e) {
				var self = e.data.object;
				if (self._hasClass(this, 'active')) {
					if (typeof self['_onConfigFinished'] == 'function')
						self['_onConfigFinished'].call(this);
				}
			},
			onManifoldInfoClicked : function(e) {
				var self = e.data.object;

				if (self._hasClass(this, 'active')) {
					window.open(baseInfoURL + 'Manifold_Types.pdf');
				}
			},
			onPipingInfoClicked : function(e) {
				var self = e.data.object;

				if (self._hasClass(this, 'active')) {
					window.open(baseInfoURL + 'Piping_redirection.pdf');
				}
			},
			onParallelConnectionInfoClicked : function(e) {
				var self = e.data.object;

				if (self._hasClass(this, 'active')) {
					window.open(baseInfoURL
							+ 'Connection_type_Parallel_wiring.pdf');
				}
			},
			onSerialConnectionInfoClicked : function(e) {
				var self = e.data.object;

				if (self._hasClass(this, 'active')) {
					window.open(baseInfoURL
							+ 'Connection_types_Serial_wiring.pdf');
				}
			},
			onValveInfoClicked : function(e) {
				var self = e.data.object;

				if (self._hasClass(this, 'active')) {
					window.open(baseInfoURL + 'Valve_size.pdf');
				}
			},
			/*
			 * EXTRA METHODS
			 */
			_hasClass : function(domE, clss) {
				return (' ' + domE.className + ' ').indexOf(' ' + clss + ' ') > -1;
			},
			conditionCheckers : {
				checkManyfold : function(self, manyfoldName) {
					var m = self.getSelectedManyfold();
					var result = (typeof m != 'undefined' && (manyfoldName == '' || m.name == manyfoldName));
					return result;
				},
				checkPiping : function(self, pipingName) {
					var p = self.getSelectedPiping();
					var result = (typeof p != 'undefined' && (pipingName == '' || p.name == pipingName));
					return result;
				},
				checkConnection : function(self, connectionName) {
					var c = self.getSelectedConnection();
					var result = (typeof c != 'undefined' && (connectionName == '' || c.name == connectionName));
					return result;
				},
				checkValve : function(self, valveName) {
					var v = self.getSelectedValve();
					var result = (typeof v != 'undefined' && (valveName == '' || v.name == valveName));
					return result;
				}
			},
			/*
			 * CLASS ATTRIBUTES
			 */
			jQueryCache : {},
			valve_size : {
				SY3000 : {
					name : 'SY3000',
					id : '#v_sy3000'
				},
				SY5000 : {
					name : 'SY5000',
					id : '#v_sy5000'
				},
				SY7000 : {
					name : 'SY7000',
					id : '#v_sy7000'
				},
				MIXED : {
					name : 'MIXED',
					id : '#v_mixed'
				},
				MIXED7000 : {
					name : 'MIXED7000',
					id : '#v_mixed7000'
				}
			},
			connection_type : {
				DSUB : {
					name : 'DSUB',
					id : '#c_dsub'
				},
				FLATRIBBON : {
					name : 'FLATRIBBON',
					id : '#c_flatribbon'
				},
				PCWIRING : {
					name : 'PCWIRING',
					id : '#c_pcwiring'
				},
				EX120 : {
					name : 'EX120',
					id : '#c_ex120'
				},
				EX126 : {
					name : 'EX126',
					id : '#c_ex126'
				},
				EX250 : {
					name : 'EX250',
					id : '#c_ex250'
				},
				EX260 : {
					name : 'EX260',
					id : '#c_ex260'
				},
				EX500 : {
					name : 'EX500',
					id : '#c_ex500'
				},
				EX510 : {
					name : 'EX510',
					id : '#c_ex510'
				},
				EX600 : {
					name : 'EX600',
					id : '#c_ex600'
				},
				TERMINALBLOCK : {
					name : 'TERMINALBLOCK',
					id : '#c_terminalblock'
				},
				LEADWIRE : {
					name : 'LEADWIRE',
					id : '#c_leadwire'
				},
				CIRCULAR : {
					name : 'CIRCULAR',
					id : '#c_circular'
				}
			},
			piping_redirection : {
				SIDE : {
					name : 'SIDE',
					id : '#p_side'
				},
				BOTTOM : {
					name : 'BOTTOM',
					id : '#p_bottom'
				},
				TOP : {
					name : 'TOP',
					id : '#p_top'
				}
			},
			manyfold_type : {
				IP40 : {
					name : 'IP40',
					id : '#m_ip40'
				},
				IP67 : {
					name : 'IP67',
					id : '#m_ip67'
				}
			},
			conjuntos : {},
			selection : {
				manyfold : {},
				piping : {},
				connection : {},
				valve : {}
			},
			incompatibilities : {
				type : {
					MANYFOLD : 0,
					PIPING : 1,
					CONNECTOR : 2,
					VALVE : 3
				},
				manyfold : {},
				piping : {},
				connection : {},
				valve : {}
			}
		});