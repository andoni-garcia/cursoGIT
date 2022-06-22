(function(ko){
	var self = {};
	var log = function(){
		if ('PROD' === 'EDIT'){
			var args = Array.prototype.slice.call(arguments);
			console.log(args);
		}
	};
	if (ko.di){
		ko.di.require({PERMISSIONS : "Permissions"},self);
	}
	ko.iketek = {
		decodeHTML : function(t){
			return $('<div/>').html(t).text();
		},
		modelMapper : function(mapObj,opts,ext,afterMap){
			var obj;
			if ($.isArray(mapObj)){
				obj = ko.iketek._arrayMapper(mapObj,opts,ext,afterMap);
			} else {
				obj = ko.iketek._objectMapper(mapObj,opts,ext);
				if (typeof afterMap === 'function') obj = afterMap(obj);
			}
			return obj;
		},
		_arrayMapper : function(mapArr,opts,ext,afterMap){
			obj = ko.observableArray();
			for (var i = 0; i < mapArr.length; i++){
				var elem = ko.iketek._objectMapper(mapArr[i],opts,ext);
				if (typeof afterMap === 'function') elem = afterMap(elem);
				obj.push(elem);
			}
			return obj;
		},
		_objectMapper : function(cObj,opts,ext){
			var elem = {};
			var keys = Object.keys(cObj);
			for (var j = 0; j < keys.length; j++){
				elem[keys[j]] = ko.observable(cObj[keys[j]]);
			}
			if (opts && $.isPlainObject(opts) && Object.keys(opts).length > 0){
				elem = $.extend(elem,ko.iketek._objectMapper(opts,{},{}));
			}
			if (ext && $.isPlainObject(ext) && Object.keys(ext).length > 0){
				keys = Object.keys(ext);
				for (var j = 0; j < keys.length; j++){
					elem[keys[j]] = ko.computed(ext[keys[j]].bind(elem));
				}
			}
			return elem;
		},
		_objectPartialMapper : function(cObj, keysArray){
			for(var j = 0; j < keysArray.length; j++){
				cObj[keysArray[j]] = ko.observable(cObj[keysArray[j]]);
			}
			return cObj;
		},
		withSelectAll : function(viewModel, selectArray){
			viewModel.allChecked = ko.observable(false);
			viewModel.selectAll = function(){
				var elems = viewModel[selectArray]();
				for (var i = 0; i < elems.length; i++){
					elems[i].checked(viewModel.allChecked());
				}
				return true;
			};
			viewModel.checkedElements = function(){
				var checkedElems = [];
				var elems = viewModel[selectArray]();
				for (var i = 0; i < elems.length; i++){
					if (elems[i].checked())
						checkedElems.push(elems[i]);
				}
				return checkedElems;
			};
		},
		fireEvent : function(element,event){
			$(element).trigger(event);
		},
		// http://stackoverflow.com/questions/105034/create-guid-uuid-in-javascript
		guid : function(){
			function s4() {
			    return Math.floor((1 + Math.random()) * 0x10000)
			      .toString(16)
			      .substring(1);
			  }
			  return s4() + s4() + '-' + s4() + '-' + s4() + '-' +
			    s4() + '-' + s4() + s4() + s4();
		},
		_singletons: {},
		register: function(name,value){
			ko.iketek._singletons[name] = value;
		},
		instance: function(name){
			return ko.iketek._singletons[name];
		},
		secure : function(actionCode, success, executeBeforeReload,elems){
			return function(){
				if (self.PERMISSIONS["ANONYMOUS"]){
					window.from ="Basket";
					window.action = "callback";
					window.callbackFunction = function(loged){
						var url = location.href;
						url = url.split("#")[0];
						if (!executeBeforeReload){
							try{
								var code = 'bpc=' + actionCode + (new Date().getTime()) + "p" + elems.filteredProducts().map(function(x,i){ return i; }).join(",");
								if (/(&|\?)bpc=[^&]?/.test(url)){
									url = url.replace(/(&|\?)bpc=[^&]?/,code);
								} else if (url.indexOf('?') > -1 ){
									url = url + "&" + code;
								} else {
									url = url + "?" + code;
								}
							}catch(err) {}
						} else {
							success(loged);
						}
						location.href = url;
					};
					window.login_dialog();
				} else {
					success(true);
				}
			};
		},
		transaction : function(fn){
			var lock = ko.observable(false);
			var context = {
				done : function(){
					lock(false);
				}
			};
			var newFN = function(){
				if (!lock()){
					lock(true);
					fn.call(context, {thisArg : this});
				} else if ("PROD" == 'EDIT'){
					console.log("Function was locked!");
				}
			};
			newFN.locked = ko.pureComputed(function(){ return lock() });
			return newFN;
		},
		debounce : function(fn,tm){
			var timeout = tm || 500;
			var timeoutObj = false;
			return function(){
				var that = this;
				var args = Array.prototype.slice.call(arguments);
				clearTimeout(timeoutObj);
				timeoutObj = setTimeout(function(){
					fn.call(that,args);
				},timeout);
			};
		},
		patternReplacer : function(pattern){
			var variables = pattern.match(/\{.*?\}/g);
			return {
				replace : function(obj){
					var txt = pattern;
					for (var i = 0; i < variables.length; i++){
						var name = variables[i].replace(/^\{(.*?)\}$/g,"$1");
						if (typeof obj[name] !== 'undefined')
							txt = txt.replace(variables[i],obj[name]);
					}
					return txt;
				}
			};
		},
		syncPoint : function(fn,counter){
			var that = this;
			var cnt = counter;
			var _args = [];
			return function(){
				cnt--;
				var args = Array.prototype.slice.call(arguments);
				_args.push(args);
				if (cnt == 0){
					fn.call(that,_args);
				} else if ("PROD" == 'EDIT'){
					console.log(cnt + " participants left");
				}
			};
		}
	};	

	// Loaders
	var templateLoader = {
		_loaded: {},
		_unresolved: {},
	    loadTemplate: function(name, templateConfig, callback) {
			var l = templateLoader._loaded, ur = templateLoader._unresolved;
	        if (templateConfig.name) {
	            var fullUrl = knockoutTemplates + '/' + templateConfig.name + '.html';
				l[templateConfig.name] = false;
				var doLoad = function(){
		            $.get(fullUrl, function(markupString) {
						log('[KO TEMPLATE] ' + templateConfig.name + ' loaded');
						ko.components.defaultLoader.loadTemplate(name, markupString, callback);
						l[templateConfig.name] = true;
						if ($.isArray(ur[templateConfig.name])){
							for (var i = 0; i < ur[templateConfig.name].length; i++){
								ur[templateConfig.name][i]();
							}
						}
		            });
				};
				if (templateConfig.requires){
					var isLoaded = !!l[templateConfig.requires];
					if (isLoaded){
						doLoad();
					} else {
						log('[KO TEMPLATE] ' + templateConfig.name + ' waiting for ' + templateConfig.requires);
						if (typeof ur[templateConfig.requires] === 'undefined')
							ur[templateConfig.requires] = [];
						ur[templateConfig.requires].push(doLoad);
					}
				} else {
					doLoad();
				}
	        } else {
	            callback(null);
	        }
	    }
	};
	ko.components.loaders.unshift(templateLoader);

	ko.subscribable.fn.subscribeChanged = function (callback) {
	    var oldValue;
	    this.subscribe(function (_oldValue) {
	        oldValue = _oldValue;
	    }, this, 'beforeChange');
	    var subscription = this.subscribe(function (newValue) {
	        callback(newValue, oldValue);
	    });
	    return subscription;
	};
	ko.subscribable.fn.subscribeTimeout = function (callback, ms) {
	    var timer = false;
		if (timer) clearTimeout(timer);
	    var subscription = this.subscribe(function (newValue) {
			timer = setTimeout(function(){
				callback(newValue);
			},ms);
	    });
	    return subscription;
	};
	
	// http://www.knockmeout.net/2011/03/guard-your-model-accept-or-cancel-edits.html
	ko.protectedObservable = function(initialValue) {
	    var _actualValue = ko.observable(initialValue), _tempValue = ko.observable(initialValue);
	    var result = ko.computed({
	        read: function() {
				return _actualValue();
			},
	        write: function(newValue) {
				_tempValue(newValue);
			}
	    }).extend({ notify: "always" });
	    result.commit = function() {
			if (_tempValue !== _actualValue())
				_actualValue(_tempValue());
		};
	    result.reset = function() {
	        _actualValue.valueHasMutated();
	        _tempValue(_actualValue());
	    };
		result.change = function(){
			return _tempValue.subscribe.apply(_tempValue,arguments);
		};
	    return result;
	};
})(ko);