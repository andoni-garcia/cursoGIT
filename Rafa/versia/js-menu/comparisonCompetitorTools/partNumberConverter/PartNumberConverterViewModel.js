function PartNumberConverterViewModel() {
    var data = {
        registryPerPage: 10,
        registryIndex: 1,
        registryToIndex: 10,
        numbersTotalResults: [1],
        totalResults: 1,
        expanded: true
    };
    var REPOSITORY = new BasketProductRepository();
    //Self as 'this' reference
    var self = this;
    //Searching List of Part Numbers 
    self.CompetitorPartNumberRefList = ko.observable();
    //List of result of searching 
    self.CompetitorPartNumberResults = ko.observableArray();
    //Results per page 10|20|50|100
    self.RegistryPerPage = ko.observable();
    //Number of current page pagination
    self.RegistryIndex = ko.observable();
    //First number of current page showing
    self.RegistryIndexFrom = ko.observable();
    //Last number to current page showing
    self.RegistryIndexTo = ko.observable();
    //Number of total results
    self.TotalResults = ko.observable();
    //Numbers list of total results
    self.NumbersTotalResults = ko.observableArray();
    //Status btn expanded
    self.isExpanded = ko.observable();
    //Searching List of Part Numbers to excell
    self.CompetitorPartNumberRefListExcell = ko.observableArray();
    // Suggested search part number
    self.SuggestedSearch=ko.observableArray([]);
    // Result suggested search part number
    self.ResultSuggestedSearch=ko.observableArray([]);
    // Suggested stated
    self.isSuggestedSearch = ko.observable(false);
    //Iniatilize values
    self.initialize = function () {
        self.RegistryIndex(data.registryIndex);
        self.RegistryPerPage(data.registryPerPage);
        self.TotalResults(data.totalResults);
        self.NumbersTotalResults(data.numbersTotalResults);
        self.isExpanded(data.expanded);
    };
//------------------ Search ----------------------------------------------//
    self.searchCompetitorPartNumberResults=function(){
        self.initialize();
        self.getCompetitorPartNumberResults(true);
    }
//------------------ Suggested Part Number ------------------------------------//
    self.getSuggestedPartNumbers=function(partNumberSuggested){
        console.log("PartNumber", partNumberSuggested.length);
        if(partNumberSuggested.length>2){
         $.ajax({
                url: window.suggestedPartNumbers,
                cache: false,
                type: 'POST',
                dataType: "json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('X-CSRF-Token', window.csrfToken)
                },
                data: {
                    suggestionParam:partNumberSuggested
                },
                success: function (result) {
                    if (result != null) {
                        self.ResultSuggestedSearch(result);
                        $('#selectPickerSuggested').selectpicker('refresh');
                        console.log("list suggested partnumberconverter", self.ResultSuggestedSearch());
                    }  
                }
            }).done(function() {
            }).fail(
                function (xhr, textStatus, err) {
                    //$('#pnc-loading-container').hide();
                    //$('#notificationPartnumberconverterCodes').removeClass('d-none');
                    console.log("Erros",err);
            });
        }
    }

    self.suggestedGetCompetitorPartNumberResults=function(){
        console.log("Suggested search", self.SuggestedSearch());
        self.getCompetitorPartNumberResults();
    }
//------------------ Results ----------------------------------------------//
    self.getCompetitorPartNumberResultsSuggested = function (isInitialize) {
        $('#pnc-loading-container').show();
        $('#pn-notResults').hide();
        self.SuggestedSearch($('#selectPickerSuggested').val());
        if (self.SuggestedSearch() != '' && typeof self.SuggestedSearch() != 'undefined') {
            $.ajax({
                url: window.competitorAllResultsUrl,
                cache: false,
                type: 'POST',
                dataType: "json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('X-CSRF-Token', window.csrfToken)
                },
                data: {
                    competitorRefList: self.SuggestedSearch(),
                    registryPerPage: self.RegistryPerPage(),
                    registryIndex: self.RegistryIndex()
                },
                success: function (result) {
                    if (result != null) {
                        self.TotalResults(result.numTotalElements);
                        if (result.currentPage == 1) {
                            self.RegistryIndexFrom(result.currentPage);
                        }
                        else {
                            self.RegistryIndexFrom(((result.currentPage - 1) * self.RegistryPerPage()) + 1);
                        }
                        self.RegistryIndexTo(((result.currentPage - 1) * self.RegistryPerPage()) + result.numElements)
                        self.RegistryIndex(result.currentPage);
                        if (result.content != null) {
                            if (result.content.length > 0) {
                                $('#pn-notResults').hide();
                            } else {
                                $('#pn-notResults').show();
                            }
                            self.CompetitorPartNumberResults(result.content);
                        } else {
                            $('#pn-notResults').show();
                            self.CompetitorPartNumberResults([]);
                        }
                        self.handleTotalPages(result.totalPages);
                        
                    }else{
                        $('#pn-notResults').show();
                    }
                    self.handleSubTabs();
                    self.handleCheckboxAll();
                    self.refreshAddFavouriteButtons();
                    $('#pnc-loading-container').hide();
                    console.log("list partnumberconverter", self.CompetitorPartNumberResults());
                    
                }
            }).done(function() {
                self.isSuggestedSearch(true);
                self.clearSuggestedSearch();
                if(isInitialize!=true){
                    $('html,body').animate({
                        scrollTop:$('#ssi-container').offset().top-135
                    }, 1000);
                }
            }).fail(
                function (xhr, textStatus, err) {
                    $('#pnc-loading-container').hide();
                });
        }
        else {
            $('#pnc-loading-container').hide();
        }
    };

    self.getCompetitorPartNumberResults = function (isInitialize) {
        self.clearAll();
        $('#pnc-loading-container').show();
        $('#pn-notResults').hide();
        if (self.CompetitorPartNumberRefList() != '' && typeof self.CompetitorPartNumberRefList() != 'undefined') {
        	//references search limited to 50
        	pnList = self.CompetitorPartNumberRefList().split("\n");
        	if(pnList.length <= 50){
	        	$.ajax({
	                url: window.competitorAllResultsUrl,
	                cache: false,
	                type: 'POST',
	                dataType: "json",
	                beforeSend: function (xhr) {
	                    xhr.setRequestHeader('X-CSRF-Token', window.csrfToken)
	                },
	                data: {
	                    competitorRefList: self.CompetitorPartNumberRefList(),
	                    registryPerPage: self.RegistryPerPage(),
	                    registryIndex: self.RegistryIndex()
	                },
	                success: function (result) {
	                    if (result != null) {
	                        self.TotalResults(result.numTotalElements);
	                        if (result.currentPage == 1) {
	                            self.RegistryIndexFrom(result.currentPage);
	                        }
	                        else {
	                            self.RegistryIndexFrom(((result.currentPage - 1) * self.RegistryPerPage()) + 1);
	                        }
	                        self.RegistryIndexTo(((result.currentPage - 1) * self.RegistryPerPage()) + result.numElements)
	                        self.RegistryIndex(result.currentPage);
	                        if (result.content != null) {
	                            if (result.content.length > 0) {
	                                $('#pn-notResults').hide();
	                            } else {
	                                $('#pn-notResults').show();
	                            }
	                            self.CompetitorPartNumberResults(result.content);
	                        } else {
	                            $('#pn-notResults').show();
	                            self.CompetitorPartNumberResults([]);
	                        }
	                        self.handleTotalPages(result.totalPages);
	                        
	                    }else{
	                        $('#pn-notResults').show();
	                    }
	                    self.handleSubTabs();
	                    self.handleCheckboxAll();
	                    self.refreshAddFavouriteButtons();
	                    $('#pnc-loading-container').hide();
	                    console.log("list partnumberconverter", self.CompetitorPartNumberResults());
	                    
	                }
	            }).done(function() {
	                self.isSuggestedSearch(false);
	                if(isInitialize!=true){
	                    $('html,body').animate({
	                        scrollTop:$('#ssi-container').offset().top-135
	                    }, 1000);
	                }
	            }).fail(
	                function (xhr, textStatus, err) {
	                    $('#pnc-loading-container').hide();
	                    $('#notificationPartnumberconverterCodes').removeClass('d-none');
	                });
        	}else{ 
        		$('#pnc-loading-container').hide();
                $('#notificationPartnumberconverterExcessCodes').removeClass('d-none');
        	}
        }
        else {
            $('#pnc-loading-container').hide();
            $('#notificationPartnumberconverterCodes').removeClass('d-none');
        }
    };
//------------------ Tabs --------------------------------------------------------//
    self.handleSubTabs = function () {
        var tabs = $(".subHeading-0a");
        tabs.click(function () {
            // delete active class all elements
            $(this.parentElement).children().removeClass("smc-tabs__head--active"); 
            // activation current element
            $(this).addClass("smc-tabs__head--active");
        });
    };
//------------------ Clear --------------------------------------------------------//
    self.clearCompetitorPartNumberSearch = function () {
        self.CompetitorPartNumberRefList('');
        self.initialize();
        $('#notificationError').removeClass('d-none');
        $('#notificationError').addClass('d-none');
        self.CompetitorPartNumberResults.removeAll();
        self.isSuggestedSearch(false);
        self.clearSuggestedSearch();
        self.clearAll();
    };
    self.clearAll = function () {
        $('#notificationPartnumberconverterCodes').removeClass('d-none');
        $('#notificationPartnumberconverterCodes').addClass('d-none');
        $('#notificationPartnumberconverterExcessCodes').removeClass('d-none'); 
        $('#notificationPartnumberconverterExcessCodes').addClass('d-none');
        $('#notificationError').removeClass('d-none');
        $('#notificationError').addClass('d-none');
        $('#btn_partnumberconverterExpand').prop('disabled', true);
        $('#btn_partnumberconverterDownload').prop('disabled', true);
        $('#iconExpand').removeClass('collapse');
        $('#iconExpand').removeClass('show');
        $('#pn-notResults').hide();
        var checkboxes = $('.form-check-input');
        checkboxes.prop('checked', false);
    }
    self.clearSuggestedSearch=function(){
        if(self.isSuggestedSearch()==false){
            self.SuggestedSearch([]);
        }
        self.ResultSuggestedSearch([]);
        $(".selectpicker").val('default');
        $(".selectpicker").selectpicker("refresh");
        self.clearAll();
    }
//------------------ Pagination ---------------------------------------------//
    self.handleTotalPages = function (totalPages) {
        var arrayEmpty = [];
        self.NumbersTotalResults(arrayEmpty);
        for (var i = 1; i <= totalPages; i++) {
            self.NumbersTotalResults.push(i);
        }
    };
    self.updateRegistryPerPage = function (model, event) {
        self.RegistryPerPage(event.currentTarget.innerText);
        self.RegistryIndex(1);
        self.getCompetitorPartNumberResults();
    };
    self.showCurrentPage = function (paginationPerPage, event) {
        self.RegistryIndex(paginationPerPage);
        self.getCompetitorPartNumberResults();
    };
    self.showPreviousPage = function () {
        if (self.RegistryIndex() > 1) {
            var previousPage = self.RegistryIndex() - 1;
            self.RegistryIndex(previousPage);
        }
        self.getCompetitorPartNumberResults();
    };
    self.showNextPage = function () {
        if (self.RegistryIndex() < self.TotalResults()) {
            var nextPage = self.RegistryIndex() + 1;
            self.RegistryIndex(nextPage);
        }
        self.getCompetitorPartNumberResults();
    };
    self.showFirstPage = function () {
        var previousPage = 1;
        self.RegistryIndex(previousPage);
        self.getCompetitorPartNumberResults();
    };
    self.showLastPage = function () {
        var lastPage = self.NumbersTotalResults().length;
        self.RegistryIndex(lastPage);
        self.getCompetitorPartNumberResults();
    };
//------------------ checkbox list --------------------------------------------//
    self.handleCheckboxAll = function () {
        $('#select_all').change(function () {
            var checkboxes = $(this).closest('#pn-spares-accessories-result-container').find(':checkbox');
            checkboxes.prop('checked', $(this).is(':checked'));
            for (var i = 0; i < checkboxes.length; i++) {
                $('#btn_partnumberconverterExpand').prop('disabled', true);
                $('#btn_partnumberconverterDownload').prop('disabled', true);
                if (checkboxes[i].checked) {
                    $('#btn_partnumberconverterExpand').prop('disabled', false);
                    $('#btn_partnumberconverterDownload').prop('disabled', false);
                }
            }
        });
    };

    self.handleCheckboxItem = function (e) {
        var checkboxes = $('#pn-spares-accessories-result-container').find(':checkbox');
        for (var i = 0; i < checkboxes.length; i++) {
            $('#btn_partnumberconverterExpand').prop('disabled', true);
            $('#btn_partnumberconverterDownload').prop('disabled', true);
            if (checkboxes[i].checked) {
                $('#btn_partnumberconverterExpand').prop('disabled', false);
                $('#btn_partnumberconverterDownload').prop('disabled', false);
                break;
            }
        }
        return true;
    };
//------------------ Expand Items --------------------------------------------------------//
    self.handleExpandItems = function () {
        var checkboxes = $('#pn-spares-accessories-result-container').find(':checkbox');
        for (var i = 0; i < checkboxes.length; i++) {
            if (checkboxes[i].checked && checkboxes[i].id !== "select_all") {
                $('#iconExpand').removeClass('collapse');
                $('#iconExpand').removeClass('show');
                if (self.isExpanded()) {
                    $('#iconExpand').addClass('show');
                    $('#collapsedDetails_' + checkboxes[i].id.split('_')[1]).collapse('show');
                } else {
                    $('#iconExpand').addClass('collapse');
                    $('#collapsedDetails_' + checkboxes[i].id.split('_')[1]).collapse('hide');
                }
            }
        }
        self.isExpanded(!self.isExpanded());
    };
//------------------ Excell --------------------------------------------------------//
    self.getCompetitorPartNumberResultsExcell = function () {
        var checkboxes = $('#pn-spares-accessories-result-container').find(':checkbox');
        $('#notificationError').removeClass('d-none');
        $('#notificationError').addClass('d-none');
        self.CompetitorPartNumberRefListExcell([]);
        for (var i = 0; i < checkboxes.length; i++) {
            if (checkboxes[i].checked && checkboxes[i].id !== "select_all") {
                self.CompetitorPartNumberRefListExcell.push(checkboxes[i].getAttribute('data-partnumber'));
            }
        }
        var competitorPartNumberRefListExcell;
        if($('#select_all').is(':checked')){
            if(self.isSuggestedSearch()){
                competitorPartNumberRefListExcell=self.SuggestedSearch();
            }else{
                competitorPartNumberRefListExcell=self.CompetitorPartNumberRefList();
            }
        }else{
            competitorPartNumberRefListExcell=self.CompetitorPartNumberRefListExcell();
        }
        if (self.CompetitorPartNumberRefListExcell().length > 0 && typeof self.CompetitorPartNumberRefListExcell() != 'undefined') {
            $('#pnc-loading-container').show();
            $.ajax({
                url: window.competitorAllResultsExcellUrl,
                cache: false,
                type: 'POST',
                dataType: "json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('X-CSRF-Token', window.csrfToken)
                },
                data: {
                    partNumbersToExport:competitorPartNumberRefListExcell
                },
                success: function (result) {
                    $('#pnc-loading-container').hide();
                    console.log("Excell", result);
                    window.open(result, '_blank');
                }
            }).fail(
                function (xhr, textStatus, err) {
                    $('#pnc-loading-container').hide();
                    $('#notificationError').removeClass('d-none');
                }
            );
        }
        else {
            $('#notificationError').removeClass('d-none');
        }
    };
//------------------ LOGS --------------------------------------------------------//
    self.logActionPNC = function (e) {
		var $element = $(e.target);	
		$.ajax({
                url: window.logActionUrl,
                cache: false,
                type: 'POST',
                dataType: "json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('X-CSRF-Token', window.csrfToken)
                },
                data: {
                    action:$element.attr('smc-pncLog-action'),
                    type:$element.attr('smc-pncLog-type'),
                    dataList:[
							$element.attr('smc-pncLog-data1'),
							$element.attr('smc-pncLog-data2'),
							$element.attr('smc-pncLog-data3')
					]
                },
                success: function (result) {
                }
            })
    };
//------------------ Favourites --------------------------------------------------------//
    self.refreshAddFavouriteButtons = function () {
        $(".add-to-favourites").click(function () {
            var partnumber = $(this).attr("data-partnumber");
            self.addProductToFavourite(partnumber);
        });
    };
    self.addProductToFavourite = function (favourites) {
        var deferred = $.Deferred();
        //If no loged in page redirect to login and reload with requested action
        if (typeof favouritesFoldersViewModel === 'undefined') {
            var originUrl = new URL(window.location.href);
            originUrl.searchParams.set('componentId', 'SsiViewModel');
            originUrl.searchParams.set('action', 'addToFavourites');
            originUrl.searchParams.set('actionParams', favourites);
            var url = new URL(originUrl.origin + window.smc.channelPrefix + '/secured-resource');
            url.searchParams.set('resource', originUrl.toString().replace(originUrl.origin, ''));
            window.location = url;
            deferred.reject();
        } else {
            //Check if favourites isnt array
            if (!($.isArray(favourites))) {
                favourites = favourites.split(',');
            }
            var modalDeferred = favouritesFoldersViewModel.show();
            modalDeferred.then(function (selectedFolder) {
                REPOSITORY.doAddToFavourite(favourites, selectedFolder, 'BASKET', {
                    success: function (res) {
                        deferred.resolve();
                        window.smc.NotifyComponent.info(BASKET_MESSAGES.favouritesSuccess);
                    }, error: function (err) {
                        deferred.reject();
                        window.smc.NotifyComponent.error(BASKET_MESSAGES.favouritesError);
                    }
                });
            }).catch(function (err) {
                deferred.reject(new BasketError(BASKET_ERROR_CODES.UI_MODAL_REJECTED));
            });
        }
        return deferred.promise();
    };
//----------------------- Formatter ---------------------------------------------------------//
    self.removeSpecials=function(code){
    	return code.replace(/[&\/\\#\s,+()$~%.'":*?<>{}-]/g, '');
    }
}
(function (window) {
    var vm = new PartNumberConverterViewModel();
    ko.applyBindings(vm, document.getElementById("PNcontenedor"));
    vm.initialize();
    $(window).click(function(e) {
        if(e.target.id=="pnc"){
            vm.clearCompetitorPartNumberSearch();
        } 
		if(e.target.getAttribute("smc-pncLog-action")!=undefined){
            vm.logActionPNC(e);
        }     
    });
    $('#selectPickerSuggested').on('loaded.bs.select', function () {
        $(".bs-searchbox input").on('keyup',function(e){
            vm.getSuggestedPartNumbers(e.currentTarget.value);
        })
    });
    $('#selectPickerSuggested').on('show.bs.select', function () {
        $('#btn_searchCompetitorPartNumberResults').prop( "disabled", true );
        $('#btn_clearCompetitorPartNumberSearch').prop( "disabled", true );
    });
    $('#selectPickerSuggested').on('hide.bs.select', function () {
        $('#btn_searchCompetitorPartNumberResults').prop( "disabled", false );
        $('#btn_clearCompetitorPartNumberSearch').prop( "disabled", false );
       vm.getCompetitorPartNumberResultsSuggested();
    });
    	
   
}(window));