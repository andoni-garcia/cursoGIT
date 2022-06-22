function OrderStatusViewModel(){
	var self = this;

	ko.di.require({CONFIGURATION : "OrderStatusConfigurationVariables", MESSAGES : "OrderStatusMessages"},self);

	self.today = new Date();
	self.ago = new Date();
	self.agoYear = new Date();

	self.ago = new Date();
	self.ago.setDate(self.today.getDate() - 60);
	self.agoYear.setFullYear(self.today.getFullYear() - 1);
	self.failure = ko.observable(false);

	const REPOSITORY = new OrderStatusRepository();
	// ORDERING
	// DONE: Sorting columns
	var ORDER_CONSTANTS = {
		STATUS_ASCENDING : 'BY_STATUS_ASC',
		STATUS_DESCENDING : 'BY_STATUS_DESC',
		ORDER_DATE_ASCENDING : 'BY_PERIOD_ASC',
		ORDER_DATE_DESCENDING : 'BY_PERIOD_DESC'
	};

	// TABLE
	self.toggleDetails = function(elem){
		elem.showDetails(!elem.showDetails());
	};

	self.lastNDays = function(days){
		//self.datatable.resetFilters();
		//self.datatable.refresh();

		var find = '/';
        var re = new RegExp(find, 'g');

		var fromDateTime =  self.ago.getFullYear() + "/" + ("0" + (self.ago.getMonth() +　1)).slice(-2) + "/" + ("0" + (self.ago.getDate())).slice(-2);
		fromDateTime = fromDateTime.replace(re, '-');

		var toDateTime =  self.today.getFullYear() + "/" + ("0" + (self.today.getMonth() +　1)).slice(-2) + "/" + ("0" + (self.today.getDate())).slice(-2);
		toDateTime = toDateTime.replace(re, '-');

        self.datatable.filter.filterDateFrom( fromDateTime );
        self.datatable.filter.filterDateFrom.commit();
        self.datatable.filter.filterDateTo( toDateTime );
        self.datatable.filter.filterDateTo.commit();

		self.datatable.refresh();

		self.formDateFrom( window.koDate.dateToFormat(self.ago) );
		self.formDateTo( window.koDate.dateToFormat(self.today) );
	};

	self.search = function(){

        // DATE_FROM_AND_TO NULL VALIDATION
        if( !$("#inputDateFrom").val() || !$("#inputDateTo").val() ){
            smc.NotifyComponent.error(self.MESSAGES["invalidFormat"]);
            return;
        }

        // DATE_FROM FORMAT VALIDATION
        try {
          $.datepicker.parseDate( $("#inputDateFrom").datepicker('option', 'dateFormat'), $("#inputDateFrom").val() );
        }
        catch(error) {
            smc.NotifyComponent.error(self.MESSAGES["invalidFormat"]);
            return;
        }

        // DATE_TO FORMAT VALIDATION
        try {
          $.datepicker.parseDate( $("#inputDateTo").datepicker('option', 'dateFormat'), $("#inputDateTo").val() );
        }
        catch(error) {
            smc.NotifyComponent.error(self.MESSAGES["invalidFormat"]);
            return;
        }

        var find = '/';
        var re = new RegExp(find, 'g');

        var dateTime_dpFrom = new Date($("#inputDateFrom").datepicker("getDate"));
        var fromDateTime =  dateTime_dpFrom.getFullYear() + "/" + ("0" + (dateTime_dpFrom.getMonth() +　1)).slice(-2) + "/" + ("0" + (dateTime_dpFrom.getDate())).slice(-2);
        fromDateTime = fromDateTime.replace(re, '-');

        var dateTime_dpTo = new Date($("#inputDateTo").datepicker("getDate"));
        var toDateTime =  dateTime_dpTo.getFullYear() + "/" + ("0" + (dateTime_dpTo.getMonth() +　1)).slice(-2) + "/" + ("0" + (dateTime_dpTo.getDate())).slice(-2);
        toDateTime = toDateTime.replace(re, '-');

        // FROM_BIGGER_THAN_TO VALIDATION
        if(dateTime_dpFrom > dateTime_dpTo){
            smc.NotifyComponent.error(self.MESSAGES["fromBiggerThanTo"]);
            return;
        }

        // TO_LESS_THAN_TODAY VALIDATION
        if(dateTime_dpTo > self.today){
            smc.NotifyComponent.error(self.MESSAGES["lessThanToday"]);
            return;
        }

        // RANGE_SURPASSED VALIDATION
        var diffTime = Math.abs(dateTime_dpFrom - dateTime_dpTo);
        var diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
        if (diffDays > 365){
            smc.NotifyComponent.error(self.MESSAGES["onlyLastYear"]);
            return;
        }

        self.datatable.filter.filterDateFrom( fromDateTime );
        self.datatable.filter.filterDateFrom.commit();
        self.datatable.filter.filterDateTo( toDateTime );
        self.datatable.filter.filterDateTo.commit();
        // the rest of the DataTable filters are binded to their own inputs/selects in ftl template: 'statusFrom', 'statusTo', 'searchBy' and 'value'

        // Load table information
        self.datatable.refresh();
	};

	self.exportOrderStatus = function(type){

        var find = '/';
        var re = new RegExp(find, 'g');

        var dateTime_dpFrom = new Date($("#inputDateFrom").datepicker("getDate"));
        var fromDateTime =  dateTime_dpFrom.getFullYear() + "/" + ("0" + (dateTime_dpFrom.getMonth() +　1)).slice(-2) + "/" + ("0" + (dateTime_dpFrom.getDate())).slice(-2);
        fromDateTime = fromDateTime.replace(re, '-');

        var dateTime_dpTo = new Date($("#inputDateTo").datepicker("getDate"));
        var toDateTime =  dateTime_dpTo.getFullYear() + "/" + ("0" + (dateTime_dpTo.getMonth() +　1)).slice(-2) + "/" + ("0" + (dateTime_dpTo.getDate())).slice(-2);
        toDateTime = toDateTime.replace(re, '-');

        var statusFrom = $("#statusFrom").val();
        var statusTo = $("#statusTo").val();
        var searchBy = $("#searchBy").val(); //  ITEM_NAME(0), CUSTOMER_ORDER_NUMBER(1), ORDER_NUMBER(2);
        var search = $("#inputValue").val();
        var sortCol = $("#ikSelect")[0].options.selectedIndex; //  0-BY_PERIOD_DESC, 1-BY_PERIOD_ASC, 2-BY_STATUS_DESC, 3-BY_STATUS_ASC
        var sortCol_0;

        switch (sortCol) {
        case 0:
            sortCol_0 = "BY_PERIOD_DESC";
            break;
        case 1:
            sortCol_0 = "BY_PERIOD_ASC";
            break;
        case 2:
            sortCol_0 = "BY_STATUS_DESC";
            break;
        case 3:
            sortCol_0 = "BY_STATUS_ASC";
            break;
        default:
            sortCol_0 = "BY_PERIOD_DESC";
            break;
        }

        REPOSITORY.doExportOrderStatus(fromDateTime, toDateTime, statusFrom, statusTo, searchBy, search, sortCol_0, type).then(
            function(res){
                window.open(res);
            }
        )
        .catch(function(err){
            console.error(JSON.stringify(err))
            smc.NotifyComponent.error('can not export current order');
        })
    }

	self.getStatusTitle = function(stat){
		var statusCode = typeof this.status === "function" ? this.status() : null;
		var status = stat || ko.unwrap(statusCode).split("");
		var title = self.MESSAGES["statusLbl"] + ": " + self.MESSAGES["statusTitles"][parseInt(status[0])];
		if (status[0] != status[1]) title += " - " +  self.MESSAGES["statusTitles"][parseInt(status[1])];
		return title;
	};
	
	self.getStatusTitleDesc = function(stat){
		var statusCode = typeof this.status === "function" ? this.status() : null;
		var status = stat || ko.unwrap(statusCode).split("");
		var titleDesc = self.MESSAGES["statusTitles"][parseInt(status[0])];
		if (status[0] != status[1]) titleDesc += " - " +  self.MESSAGES["statusTitles"][parseInt(status[1])];
		return titleDesc;
	};

	self.formattedGrandTotal = function(){
		var items = ko.unwrap(this).items(), cucd = this.currency();
		return _.reduce(items, function(acc,curr){ return acc + parseFloat(curr.total); },0).toFixed(2) + " " + cucd;
	};

	self.formattedData = function() {
		var items = ko.unwrap(this).items();

		if(this.confirmedDate()) {
			this.confirmedDate(window.koDate.requestDateStringToFormat(this.confirmedDate()));
		}

		if(this.customerDate()) {
			this.customerDate(window.koDate.requestDateStringToFormat(this.customerDate()));
		}

		if(this.confirmedDeliveryDate()) {
			this.confirmedDeliveryDate(window.koDate.requestDateStringToFormat(this.confirmedDeliveryDate()));
		}

		for(var i=0; i < items.length; i++) {

			if(items[i].requestedDeliveryDate) {
				items[i].requestedDeliveryDate = window.koDate.requestDateStringToFormat(items[i].requestedDeliveryDate);
			}

			if(items[i].confirmedDeliveryDate) {
				items[i].confirmedDeliveryDate = window.koDate.requestDateStringToFormat(items[i].confirmedDeliveryDate);
			}

			if(items[i].total) {
				items[i].total = items[i].total.toFixed(2);
			}

		}

	}

	ko.iketek.withDatatable(self,{
		container : "orderStatusTable",
		extras : {showDetails: false},
		fnExtras : {statusTitle: self.getStatusTitle, formattedGrandTotal : self.formattedGrandTotal, formattedData: self.formattedData, statusTitleDesc: self.getStatusTitleDesc},
		filters : [
			"filterValue",
			{name : "filterDateTo", defaultValue : window.koDate.dateToJavaStringDate(self.today), protected : true},
			{name : "filterDateFrom", defaultValue : window.koDate.dateToJavaStringDate(self.ago), protected : true},
			{name : "filterStatusFrom", defaultValue : "20"},
			{name : "filterStatusTo", defaultValue : "99"},
			{name : "filterSearchBy", defaultValue : "0"}
		],
		data : "elements",
		url : orderStatusServerListUrl,
		info : self.MESSAGES["datatableInfoMessage"],
		recordsPerPage : self.MESSAGES["recordsPerPage"],
		recordsSelector : [10,20,50],
		noElementsMsg : self.MESSAGES["noProductsAvailable"],
		inPlacePaging : true,
		refreshOnFilterUpdate : false,
		orderColumns : [
			{ id : ORDER_CONSTANTS.ORDER_DATE_DESCENDING, text: "&#9660; " + self.MESSAGES["orderDateLbl"], selectedText : self.MESSAGES["orderByVarLbl"].replace("{$0}","&#9660; " + self.MESSAGES["orderDateLbl"]), singleDir : true },
		 	{ id : ORDER_CONSTANTS.ORDER_DATE_ASCENDING, text: "&#9650; " + self.MESSAGES["orderDateLbl"], selectedText : self.MESSAGES["orderByVarLbl"].replace("{$0}","&#9650; " + self.MESSAGES["orderDateLbl"]), singleDir : true },
		 	{ id : ORDER_CONSTANTS.STATUS_DESCENDING, text: "&#9660; " + self.MESSAGES["statusLbl"], selectedText : self.MESSAGES["orderByVarLbl"].replace("{$0}","&#9660; " + self.MESSAGES["statusLbl"]), singleDir : true },
			{ id : ORDER_CONSTANTS.STATUS_ASCENDING, text: "&#9650; " + self.MESSAGES["statusLbl"], selectedText : self.MESSAGES["orderByVarLbl"].replace("{$0}","&#9650; " + self.MESSAGES["statusLbl"]), singleDir : true }
		],
		detaultOrderColumn : ORDER_CONSTANTS.ORDER_DATE_DESCENDING
	});

    /*
	self.datatable.filter.filterDateFrom.change(ko.iketek.DateRange({
		minDate : window.koDate.dateToJavaStringDate(self.agoYear),
		maxDate : window.koDate.dateToJavaStringDate(self.today),
		lessThan : self.datatable.filter.filterDateTo,
		javaFormat: true,
		callback : function(code){
			self.fromPreventCallLoop = true;
			if (code == ko.iketek.DateRangeErrors.OK){
				self.datatable.filter.filterDateFrom.commit();
			} else if (code == ko.iketek.DateRangeErrors.NOT_LESS_THAN_MIN_OBS || code == ko.iketek.DateRangeErrors.MORE_THAN_MAX_OBS){
				self.datatable.filter.filterDateFrom.reset();
				alert(self.MESSAGES["fromBiggerThanTo"]);
			} else if (code == ko.iketek.DateRangeErrors.INVALID){
				self.datatable.filter.filterDateFrom.reset();
				alert(self.MESSAGES["invalidFormat"]);
			} else if (code == ko.iketek.DateRangeErrors.LESS_THAN_MIN){
				self.datatable.filter.filterDateFrom.reset();
				alert(self.MESSAGES["onlyLastYear"]);
			} else if (code == ko.iketek.DateRangeErrors.MORE_THAN_MAX){
				self.datatable.filter.filterDateFrom.reset();
				alert(self.MESSAGES["lessThanToday"]);
			}
		}
	}));

	self.datatable.filter.filterDateTo.change(ko.iketek.DateRange({
		minDate : window.koDate.dateToJavaStringDate(self.agoYear),
		maxDate : window.koDate.dateToJavaStringDate(self.today),
		moreThan : self.datatable.filter.filterDateFrom,
		javaFormat: true,
		callback : function(code){
			self.toPreventCallLoop = true;
			if (code == ko.iketek.DateRangeErrors.OK){
				self.datatable.filter.filterDateTo.commit();
			} else if (code == ko.iketek.DateRangeErrors.LESS_THAN_MIN_OBS || code == ko.iketek.DateRangeErrors.NOT_MORE_THAN_MAX_OBS){
				self.datatable.filter.filterDateTo.reset();
				alert(self.MESSAGES["fromBiggerThanTo"]);
			} else if (code == ko.iketek.DateRangeErrors.INVALID){
				self.datatable.filter.filterDateTo.reset();
				alert(self.MESSAGES["invalidFormat"]);
			} else if (code == ko.iketek.DateRangeErrors.LESS_THAN_MIN){
				self.datatable.filter.filterDateTo.reset();
				alert(self.MESSAGES["onlyLastYear"]);
			} else if (code == ko.iketek.DateRangeErrors.MORE_THAN_MAX){
				self.datatable.filter.filterDateTo.reset();
				alert(self.MESSAGES["lessThanToday"]);
			}
		}
	}));

	self.fromPreventCallLoop = false;
	self.toPreventCallLoop = false;
	*/

	self.formDateFrom = ko.observable(window.koDate.dateToFormat(self.ago));
	self.formDateTo = ko.observable(window.koDate.dateToFormat(self.today));

    /*
	self.formDateFrom.subscribe(function (newValue) {
		if(!self.fromPreventCallLoop) {
			self.datatable.filter.filterDateFrom(window.koDate.requestDateStringFormatted(newValue));
		} else {
			self.fromPreventCallLoop = false;
		}
	});

	self.formDateTo.subscribe(function (newValue) {
		if(!self.toPreventCallLoop) {
			var toDate = window.koDate.requestDateFormatted(newValue);
			self.datatable.filter.filterDateTo( window.koDate.dateToJavaStringDate(toDate));
		} else {
			self.toPreventCallLoop = false;
		}
	});

	self.datatable.filter.filterDateFrom.subscribe(function(newValue){
		self.formDateFrom(window.koDate.requestDateStringToFormat(newValue));
	});

	self.datatable.filter.filterDateTo.subscribe(function(newValue){
		var toDate = window.koDate.requestDateToFormat(newValue);
		self.formDateTo(window.koDate.dateToFormat(toDate));
	});
    */

	self.formatDate = function(date, javaFormat) {
		if(!date) '';
		var originFormat = javaFormat ? 'yy-mm-dd' : 'dd/mm/yy';
		var destFormat = javaFormat ? 'dd/mm/yy' : 'yy-mm-dd';
		var dateOfOrig = $.datepicker.parseDate(originFormat, date);
		return $.datepicker.formatDate(destFormat, dateOfOrig);
	}

	self.normalizeDatatable = function (obj) {

		var arrLength = 0;
		if(obj) {
			arrLength = obj.length;
		} else {
			self.failure(true);
		}

		return {
			content: obj || [],
			iTotalDisplayRecords: arrLength,
			foundElements: arrLength
		};

	};


	// Load table information
	self.datatable.refresh();

	self.datatable.pages.subscribe(function(newValue){
		if(newValue === 0) {
			$('.export-order-status').attr('disabled', 'disabled');
		} else {
			$('.export-order-status').removeAttr('disabled');
		}
	});
}
