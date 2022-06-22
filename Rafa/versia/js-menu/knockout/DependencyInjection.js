ko.di = {
	_services: {},
	_delayed: {},
	register: function(service,name,self,args){
		this._services[name] = {
			service: service,
			self: self,
			args: args
		};
		if (ko.di._delayed[name]){
			var unresolved = ko.di._delayed[name].filter(function(x){ return !x.resolved });
			for (var i = 0; i < unresolved.length; i++){
				var vName = unresolved[i]["varName"];
				var services = {};
				services[vName] = name;
				ko.di.require(services,unresolved[i]["self"]);
				if (typeof unresolved[i]["callback"] === 'function')
					unresolved[i]["callback"].call(unresolved[i]["self"]);
				unresolved[i]["resolved"] = true;
			}
		}
	},
	require: function(services,thisObj,delayedCallbacks){
		// TODO:0 Add delayed callback functionality
		var addPending = function(self,hisName,myName){
			if (!ko.di._delayed[myName]) ko.di._delayed[myName] = [];
			ko.di._delayed[myName].push({self: self, varName: hisName, resolved: false});
		};
		if ($.isPlainObject(services)){
			var keys = Object.keys(services);
			for (var i = 0; i < keys.length; i++){
				if (this._services[services[keys[i]]])
					thisObj[keys[i]] = this._services[services[keys[i]]].service;
				else
					addPending(thisObj,keys[i],services[keys[i]]);
			}
		} else {
			var services = $.isArray(services) ? services : services.split(/\s+/);
			for (var i = 0; i < services.length; i++){
				if (this._services[services[i]])
					thisObj[services[i]] = this._services[services[i]].service;
				else
					addPending(thisObj,services[i],services[i]);
			}
		}
	}
};