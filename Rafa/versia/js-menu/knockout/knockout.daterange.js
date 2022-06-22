(function(ko){
    if (!ko.iketek) ko.iketek = {};

    // Date Range functionality
	var dateRangeMethods = {
		validDate : function(d, format){
			try {
				var dateFormat = 'dd/mm/yy';
				if(format)
					dateFormat = 'yy-mm-dd';
				$.datepicker.parseDate(dateFormat, d);
				return true;
			} catch(e){
				return false;
			}
		},
		formatDate : function(d, format){
			if(format)
				return d.replace(/^([0-9]+)\-([0-9]+)\-([0-9]+)$/g,'$1$2$3');
			return d.replace(/^([0-9]+)\/([0-9]+)\/([0-9]+)$/g,'$3$2$1');
		}
	};

  self.parseDate = function(dateString){
		return $.datepicker.parseDate('dd/mm/yy', dateString);
	};

	ko.iketek.DateRange = function(opts){
		var minDate = opts["minDate"] && dateRangeMethods.validDate(opts["minDate"], opts["javaFormat"]) ? dateRangeMethods.formatDate(opts.minDate, opts["javaFormat"]) : "19700101";
	    var maxDate = opts["maxDate"] && dateRangeMethods.validDate(opts["maxDate"], opts["javaFormat"]) ? dateRangeMethods.formatDate(opts.maxDate, opts["javaFormat"]) : "300001231";
		var callback = typeof opts["callback"] === 'function' ? opts["callback"] : $.noop;
		return function(nv){
			if (!dateRangeMethods.validDate(nv, opts["javaFormat"])){
				callback.call(opts,ko.iketek.DateRangeErrors.INVALID);
				return;
			}
			var newFormatted = dateRangeMethods.formatDate(nv, opts["javaFormat"]);
			if (newFormatted < minDate){
				callback.call(opts,ko.iketek.DateRangeErrors.LESS_THAN_MIN);
				return;
			}
			if (newFormatted > maxDate){
				callback.call(opts,ko.iketek.DateRangeErrors.MORE_THAN_MAX);
				return;
			}
			if (typeof opts["lessThan"] !== 'undefined' && dateRangeMethods.validDate(ko.unwrap(opts["lessThan"]), opts["javaFormat"])){
				var lt = dateRangeMethods.formatDate(ko.unwrap(opts["lessThan"]), opts["javaFormat"]);
				if (newFormatted > lt){
					callback.call(opts,ko.iketek.DateRangeErrors.NOT_LESS_THAN_MIN_OBS);
					return;
				}
			}
			if (typeof opts["moreThan"] !== 'undefined' && dateRangeMethods.validDate(ko.unwrap(opts["moreThan"]), opts["javaFormat"])){
				var mt = dateRangeMethods.formatDate(ko.unwrap(opts["moreThan"]), opts["javaFormat"]);
				if (newFormatted < mt){
					callback.call(opts,ko.iketek.DateRangeErrors.NOT_MORE_THAN_MAX_OBS);
					return;
				}
			}
			callback.call(opts,ko.iketek.DateRangeErrors.OK);
		};
	};
	ko.iketek.DateRangeErrors = {
		OK : 0,
		LESS_THAN_MIN : 1,
		MORE_THAN_MAX : 2,
		NOT_LESS_THAN_MIN_OBS : 3,
		NOT_MORE_THAN_MAX_OBS : 4,
		INVALID : 5
	};
})(ko);
