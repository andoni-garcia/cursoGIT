(function($){

	window.extend = {};

	/*
	 * Queue for deferred executions
	 */
	$.nqueue = {
	    _timer: null,
	    _queue: [],
	    _ids: {},
	    _batchCount : 1,
	    add: function(fn, context, time, identifier) {
	        var setTimer = function(time) {
	            $.nqueue._timer = setTimeout(function() {
	                time = $.nqueue.add();
	                if ($.nqueue._queue.length) {
	                    setTimer(time);
	                }
	            }, time || 2);
	        }

	        if (fn) {
	        	if (typeof identifier === 'undefined' || typeof $.nqueue._ids[identifier] === 'undefined'){
	        		$.nqueue._ids[identifier] = true;
		            $.nqueue._queue.push([fn, context, time, identifier]);
	        	}
	            if ($.nqueue._queue.length == 1) {
	                setTimer(time);
	            }
	            return;
	        }

	        var next = [0,0,0];
	        for (var i = 0; i < $.nqueue._batchCount; i++){
	        	next = $.nqueue._queue.shift();
	        	if (!next) {
		            return 0;
		        }
	        	if (next[3]) delete $.nqueue._ids[next[3]];
	        	next[0].call(next[1] || window);
	        }
	        return next[2];
	    },
	    clear: function() {
	        clearTimeout($.nqueue._timer);
	        $.nqueue._queue = [];
	        $.nqueue._ids = {};
	    }
	};

	window.extend.nqueue = $.nqueue;

	/*
	 * Allow partial application on functions
	 */
	if (!Function.prototype.curry){
		Function.prototype.curry = function() {
			var fn = this, args = Array.prototype.slice.call(arguments);
			return function() {
				return fn.apply(this, args.concat(Array.prototype.slice.call(arguments)));
			};
		};
	}

	/*
	 * Easily fold arrays
	 */
	if (!Array.prototype.reduce) {
		  Array.prototype.reduce = function(callback /*, initialValue*/) {
		    'use strict';
		    if (this == null) {
		      throw new TypeError('Array.prototype.reduce called on null or undefined');
		    }
		    if (typeof callback !== 'function') {
		      throw new TypeError(callback + ' is not a function');
		    }
		    var t = Object(this), len = t.length >>> 0, k = 0, value;
		    if (arguments.length == 2) {
		      value = arguments[1];
		    } else {
		      while (k < len && ! k in t) {
		        k++;
		      }
		      if (k >= len) {
		        throw new TypeError('Reduce of empty array with no initial value');
		      }
		      value = t[k++];
		    }
		    for (; k < len; k++) {
		      if (k in t) {
		        value = callback(value, t[k], k, t);
		      }
		    }
		    return value;
		  };
	}

	/*
	 * Combine arrays
	 */
	if (!Array.prototype.zipWith) {
		Array.prototype.zipWith = function(arr,callback){
			var t = Object(this), len = t.length, k = 0;
			var retArr = [];
			while (k < len){
				retArr.push(callback(t[k], arr[k], retArr));
				k++;
			}
			return retArr;
		};
	}

	/*
	 * Map arrays
	 */
	if (!Array.prototype.map) {
		Array.prototype.map= function(mapper, that /*opt*/) {
	        var other= new Array(this.length);
	        for (var i= 0, n= this.length; i<n; i++)
	            if (i in this)
	                other[i]= mapper.call(that, this[i], i, this);
	        return other;
	    };
	}
   if (!Array.prototype.flatMap) {
	   Array.prototype.flatMap= function(mapper, that /*opt*/) {
		   var result = this.map(mapper,that);
		   return [].concat.apply([],result);
	   };
   }

	/*
	 * Filter arrays
	 */
	if (!Array.prototype.filter) {
		Array.prototype.filter= function(filter, that /*opt*/) {
	        var other= [], v;
	        for (var i=0, n= this.length; i<n; i++)
	            if (i in this && filter.call(that, v= this[i], i, this))
	                other.push(v);
	        return other;
	    };
	}

	/*
	 * Bind context to function
	 */
	if (!Function.prototype.bind) {
		Function.prototype.bind= function(owner) {
	        var that= this;
	        if (arguments.length<=1) {
	            return function() {
	                return that.apply(owner, arguments);
	            };
	        } else {
	            var args= Array.prototype.slice.call(arguments, 1);
	            return function() {
	                return that.apply(owner, arguments.length===0? args : args.concat(Array.prototype.slice.call(arguments)));
	            };
	        }
	    };
	}

	/*
	 * Trim whitespaces
	 */
	if (!String.prototype.trim) {
		String.prototype.trim= function() {
	        return this.replace(/^\s+/, '').replace(/\s+$/, '');
	    };
	}

	/*
	 * Execute given function for each element in the array
	 */
	if (!Array.prototype.forEach) {
		Array.prototype.forEach= function(action, that /*opt*/) {
	        for (var i= 0, n= this.length; i<n; i++)
	            if (i in this)
	                action.call(that, this[i], i, this);
	    };
	}

	/*
	 * Test if every element satisfies given constraint
	 */
	if (!Array.prototype.every) {
	    Array.prototype.every= function(tester, that /*opt*/) {
	        for (var i= 0, n= this.length; i<n; i++)
	            if (i in this && !tester.call(that, this[i], i, this))
	                return false;
	        return true;
	    };
	}

	/*
	 * Test if some element satisfies given constraint
	 */
	if (!Array.prototype.some) {
	    Array.prototype.some= function(tester, that /*opt*/) {
	        for (var i= 0, n= this.length; i<n; i++)
	            if (i in this && tester.call(that, this[i], i, this))
	                return true;
	        return false;
	    };
	}

	if (!Object.keys) {
		  Object.keys = (function() {
		    'use strict';
		    var hasOwnProperty = Object.prototype.hasOwnProperty,
		        hasDontEnumBug = !({ toString: null }).propertyIsEnumerable('toString'),
		        dontEnums = [
		          'toString',
		          'toLocaleString',
		          'valueOf',
		          'hasOwnProperty',
		          'isPrototypeOf',
		          'propertyIsEnumerable',
		          'constructor'
		        ],
		        dontEnumsLength = dontEnums.length;

		    return function(obj) {
		      if (typeof obj !== 'object' && (typeof obj !== 'function' || obj === null)) {
		        throw new TypeError('Object.keys called on non-object');
		      }

		      var result = [], prop, i;

		      for (prop in obj) {
		        if (hasOwnProperty.call(obj, prop)) {
		          result.push(prop);
		        }
		      }

		      if (hasDontEnumBug) {
		        for (i = 0; i < dontEnumsLength; i++) {
		          if (hasOwnProperty.call(obj, dontEnums[i])) {
		            result.push(dontEnums[i]);
		          }
		        }
		      }
		      return result;
		    };
		  }());
	}

	/*
	 * Get the index of a given element in the array
	 */
	if (!Array.prototype.indexOf) {
		  Array.prototype.indexOf = function(searchElement, fromIndex) {
		    var k;
		    if (this == null) {
		      throw new TypeError('"this" is null or not defined');
		    }
		    var O = Object(this);
		    var len = O.length >>> 0;
		    if (len === 0) {
		      return -1;
		    }
		    var n = +fromIndex || 0;
		    if (Math.abs(n) === Infinity) {
		      n = 0;
		    }
		    if (n >= len) {
		      return -1;
		    }
		    k = Math.max(n >= 0 ? n : len - Math.abs(n), 0);
		    while (k < len) {
		      if (k in O && O[k] === searchElement) {
		        return k;
		      }
		      k++;
		    }
		    return -1;
		  };
	}

	/*
	 * Grab nth element from an array
	 */
	window.nth = function(n,elem){
		return elem[n];
	};

	/*
	 * Allow partial application on functions
	 */
	if (!Function.prototype.name){
		Function.prototype.name = function() {
			var str = this.toString();
			str = str.substring(0,str.indexOf("("));
			str = str.replace("function ","");
			return str;
		};
	}

    // https://tc39.github.io/ecma262/#sec-array.prototype.find
    if (!Array.prototype.find) {
        Object.defineProperty(Array.prototype, 'find', {
            value: function(predicate) {
                // 1. Let O be ? ToObject(this value).
                if (this == null) {
                    throw new TypeError('"this" is null or not defined');
                }

                var o = Object(this);

                // 2. Let len be ? ToLength(? Get(O, "length")).
                var len = o.length >>> 0;

                // 3. If IsCallable(predicate) is false, throw a TypeError exception.
                if (typeof predicate !== 'function') {
                    throw new TypeError('predicate must be a function');
                }

                // 4. If thisArg was supplied, let T be thisArg; else let T be undefined.
                var thisArg = arguments[1];

                // 5. Let k be 0.
                var k = 0;

                // 6. Repeat, while k < len
                while (k < len) {
                    // a. Let Pk be ! ToString(k).
                    // b. Let kValue be ? Get(O, Pk).
                    // c. Let testResult be ToBoolean(? Call(predicate, T, « kValue, k, O »)).
                    // d. If testResult is true, return kValue.
                    var kValue = o[k];
                    if (predicate.call(thisArg, kValue, k, o)) {
                        return kValue;
                    }
                    // e. Increase k by 1.
                    k++;
                }

                // 7. Return undefined.
                return undefined;
            },
            configurable: true,
            writable: true
        });
    }

	/*
	 * Easily allow off-dom manipulations
	 */
	$.fn.detachTemp = function() {
        this.data('dt_placeholder',$('<span />').insertAfter( this ));
        return this.detach();
    };

    $.fn.reattach = function() {
        if(this.data('dt_placeholder')){
            this.insertBefore( this.data('dt_placeholder') );
            this.data('dt_placeholder').remove();
            this.removeData('dt_placeholder');
        }
        else if(window.console && console.error)
        console.error("Unable to reattach this element "
        + "because its placeholder is not available.");
        return this;
    };

    var requestAnimationFrame = window.requestAnimationFrame || window.mozRequestAnimationFrame ||
    						    window.webkitRequestAnimationFrame || window.msRequestAnimationFrame;
    window.requestAnimationFrame = requestAnimationFrame;

    //Device detection
    if (navigator && navigator.userAgent) {
        window.isIOS = /iPad|iPhone|iPod/.test(navigator.userAgent) && !window.MSStream;
        window.isIE = navigator.userAgent.indexOf("Trident") > -1;
        window.isIE8 = navigator.userAgent.indexOf("MSIE 8") > -1 && navigator.userAgent.indexOf("Trident/4.0") > -1;
        window.isEdge = window.navigator.userAgent.indexOf("Edge") > -1;
        window.isMobile = navigator.userAgent.indexOf("Mobile") > -1;
	}

    if (document && document.body){
	    if (window.isIE) document.body.className += " ie ";
		else  document.body.className += " not_ie ";

		if (window.isIE8) document.body.className += " ie8 ";
		else  document.body.className += " not_ie8 ";

        if (window.isMobile) document.body.className += " mobile ";
    }

	/*
	 * Allow function composition via disjunction
	 */
	if (!Function.prototype.disjunction){
		Function.prototype.disjunction = function() {
			var args = Array.prototype.slice.call(arguments);
			args.unshift(this);
			return function() {
				return args.map(function(x){ return x(); }).some(function(v){ return v; });
			};
		};
	}

	/*
	 * Allow function composition via conjunction
	 */
	if (!Function.prototype.conjunction){
		Function.prototype.conjunction = function() {
			var args = Array.prototype.slice.call(arguments);
			return function() {
				var arr = args.map(function(x){ return x(); });
				return arr.filter(function(v){ return v; }).length == arr.length;
			};
		};
	}

	window.IK =  {
		repeat : function(elem,n) {
			if (typeof n !== 'number')
				throw new TypeError('"n" must be a number or a function');
			if (n < 1)
				throw new TypeError('"n" must be a positive integer');
			var start = $.isArray(elem) ? elem : [elem];
			var result = start;
			while (n > 1){
				result = result.concat(start);
				n = n - 1;
			}
			return result;
		},
		pluck : function(arrObj,prop){
			if (!$.isArray(arrObj))
				throw new TypeError('You must specify an array as the first parameter');
			return arrObj.map(function(x){
				if (typeof x[prop] == 'function')
					return x[prop]();
				return x[prop];
			});
		}
	};

	if (!Array.prototype.pluck){
		Array.prototype.pluck = function(){
			var args = Array.prototype.slice.call(arguments);
			args.unshift(this);
			return IK.pluck.apply(IK,args)
		};
	}

    /*
	 * jQuery throttle / debounce - v1.1 - 3/7/2010
	 * http://benalman.com/projects/jquery-throttle-debounce-plugin/
	 *
	 * Copyright (c) 2010 "Cowboy" Ben Alman
	 * Dual licensed under the MIT and GPL licenses.
	 * http://benalman.com/about/license/
	 */
    (function(b,c){var $=b.jQuery||b.Cowboy||(b.Cowboy={}),a;$.throttle=a=function(e,f,j,i){var h,d=0;if(typeof f!=="boolean"){i=j;j=f;f=c}function g(){var o=this,m=+new Date()-d,n=arguments;function l(){d=+new Date();j.apply(o,n)}function k(){h=c}if(i&&!h){l()}h&&clearTimeout(h);if(i===c&&m>e){l()}else{if(f!==true){h=setTimeout(i?k:l,i===c?e-m:e)}}}if($.guid){g.guid=j.guid=j.guid||$.guid++}return g};$.debounce=function(d,e,f){return f===c?a(d,e,false):a(d,f,e!==false)}})(this);

	const appendError = function(xhr, textStatus, errorThrown, originalErrorFunc) {

		let haveError = false;

		if (textStatus == 'timeout') {
			this.tryCount++;
			if (this.tryCount <= this.retryLimit) {
				//try again
				$.ajax(this);
				return;
			}
			return;
		}
		if (xhr.status == 401) {
			haveError = true;
			window.location.reload(true);
		}

		if(!haveError && typeof originalErrorFunc !== 'undefined') {
			originalErrorFunc(errorThrown);
		}

	}

	// This function need global variable token defined with CSRF token
	$.ajaxHippo = function(opts) {

		if(!opts) opts = {};

		opts.beforeSend = function(xhr) {
			xhr.setRequestHeader('X-CSRF-Token', token);
		}

		var originalErrorFunction;
		if(typeof opts.error !== 'undefined') {
			originalErrorFunction = opts.error;
			opts.error = appendError;
		}

		let deferred = $.ajax($.extend({
			tryCount : 0,
			retryLimit : 3,
			error : function(xhr, textStatus, errorThrown ) {
				appendError(xhr, textStatus, errorThrown, originalErrorFunction);
			}
		},opts));

		return deferred;

	};

	//Removes the focus from the pressed button (Only on bootstrap buttons)
	$(document).on('click', '.btn', function(e){
		$(this).blur();
	});
	
})(jQuery);
