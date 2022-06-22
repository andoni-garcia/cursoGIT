var EventBus = Class.extend({
	events : {},
	debug : false,
	init: function(){
		
	},
	subscribeTo : function(event,callbackObj){
		if (!this.isObject(this.events[event.name])){
			this.events[event.name] = {};
			this.events[event.name].data = event.data;
			this.events[event.name].subscribers = [];
		}
		if (this.isFunction(callbackObj)){
			this.events[event.name].subscribers.push({callback : callbackObj});
		} else if (this.isObject(callbackObj)){
			this.events[event.name].subscribers.push(callbackObj);
		}
	},
	fireEvent : function(eventName,args){
		if (this.isObject(this.events[eventName])){
			var evt = this.events[eventName];
			if (typeof evt.data == 'undefined') evt.data = [];
			args = this._mergeArguments(args, evt.data);
			if (this.debug) console.log('Firing subscribers of "' + eventName + '" with arguments "' + args + '"');
			for (var idx in evt.subscribers){
				var subscriber = evt.subscribers[idx];
				var _args = args;
				if (this.isArray(subscriber.args)) _args = this._mergeArguments(args, subscriber.args);
				if (this.isFunction(subscriber.callback)){
					if (this.isObject(subscriber.object)){
						subscriber.callback.apply(subscriber.object,_args);
					} else {
						subscriber.callback.apply(window,_args);
					}
				}
			}
		}
	},
	isFunction : function(elem){
		return this._getType(elem) === 'Function';
	},
	isArray : function(elem){
		return this._getType(elem) === 'Array';
	},
	isObject : function(elem){
		return this._getType(elem) === 'Object';
	},
	isNumber : function(elem){
		return this._getType(elem) === 'Number';
	},
	isString : function(elem){
		return this._getType(elem) === 'String';
	},
	_mergeArguments : function(arg,data){
		return this._toArray(arg).concat(this._toArray(data));
	},
	_toArray : function(elem){
		if (this.isArray(elem))
			return elem;
		else if (this.isObject(elem)){
			var arr = [];
			for (var key in elem){
				arr.push(elem[key]);
			}
			return arr;
		} else if (this.isNumber(elem) || this.isString(elem)){
			return [elem];
		} else {
			return [];
		}
	},
	_getType : function(elem){
		try {
			if (typeof elem === 'undefined') return "Undefined"; // IE8 fix
			return Object.prototype.toString.call(elem).replace(/^\[object ([^\]]+)\]$/,'$1');
		} catch(Exception){
			return "Undefined";
		}
	}
});