ko.bindingHandlers.dataTablesForEach = {
	page: 0,
	init: function(element, valueAccessor, allBindingsAccessor, viewModel, bindingContext) {
		var binding = ko.utils.unwrapObservable(valueAccessor());

		ko.unwrap(binding.data);
		
		if (binding.options.paging) {
			binding.data.subscribe(function(changes) {
				var table = $(element).closest('table').DataTable();
				ko.bindingHandlers.dataTablesForEach.page = table.page();
				table.destroy();
			}, null, 'arrayChange');
		}

		var nodes = Array.prototype.slice.call(element.childNodes, 0);
		ko.utils.arrayForEach(nodes, function(node) {
			if (node && node.nodeType !== 1) {
				node.parentNode.removeChild(node);
			}
		});

		return ko.bindingHandlers.foreach.init(element, valueAccessor, allBindingsAccessor, viewModel, bindingContext);
	},
	update: function(element, valueAccessor, allBindings, viewModel, bindingContext) {
		var binding = ko.utils.unwrapObservable(valueAccessor()),
			key = 'DataTablesForEach_Initialized';

		ko.unwrap(binding.data);
		
		var table;
		if (!binding.options.paging) {
			table = $(element).closest('table').DataTable();
			table.destroy();
		}

		ko.bindingHandlers.foreach.update(element, valueAccessor, allBindings, viewModel, bindingContext);

		table = $(element).closest('table').DataTable(binding.options);

		if (binding.options.paging) {
			if (table.page.info().pages - ko.bindingHandlers.dataTablesForEach.page === 0) {
				table.page(--ko.bindingHandlers.dataTablesForEach.page).draw(false);
			} else {
				table.page(ko.bindingHandlers.dataTablesForEach.page).draw(false);
			}
		}

		if (!ko.utils.domData.get(element, key) && (binding.data || binding.length)) {
			ko.utils.domData.set(element, key, true);
		}

		return {
			controlsDescendantBindings: true
		};
	}
};
var itemFunctionality = function(jsonItem) {
  this.Partnumber = ko.observable(jsonItem.partNumber);
  this.Description = ko.observable(jsonItem.description);
  this.Price = ko.observable(jsonItem.price);
  this.Delivery = ko.observable(jsonItem.delivery);
  this.Image = ko.observable(jsonItem.image);
  this.Type = ko.observable(jsonItem.type);
  this.Summary = ko.observable(jsonItem.summary);
  this.IsDisabled=ko.observable(jsonItem.isDisabled);
};
function ProductsSolutionsFinderByFuntionalityViewModel() {
    //Self as 'this' reference
    var self = this;
    /*self.table=$('#table_id').DataTable({
        "columnDefs": [
            { "orderable": false, "targets": 0 }
        ],
        "language" : {
            "zeroRecords": " "             
        },
        "order": [],
        "columns": [
            { "orderable": false },
            { "orderable": false },
            { "orderable": true },
            { "orderable": true },
            { "orderable": true },
            { "orderable": true }
        ],
        "searching": false,
        "paging": false,
        "info":false
    } );*/
    self.applicationGeneral = ko.observable();
    self.applicationDetail = ko.observable();
    self.applicationConditions = ko.observable();
    self.applicationLateralLoad=ko.observable();
    self.applicationOutpuForce=ko.observable();
    self.applicationSpeed=ko.observable();
    self.funtionalityItems=ko.observableArray([]);
    self.aplicationItems=ko.observableArray([]);
    self.isSummary=ko.observable();
    self.isSummary(false);
    self.handleApplication=function(model,e){
        console.log("event application",model);
        console.log("event application",$(e.currentTarget).attr("data-btn"));
        switch($(e.currentTarget).attr("data-target")){
            case '#collapseOne':
                self.applicationGeneral($(e.currentTarget).attr("data-btn"));
                 //$('#collapseOne').collapse('hide');
                 //$('#collapseTwo').collapse('show');
                setTimeout(function(){
                    $('#btn_collapseTwo').show();
                }, 400); 
                 setTimeout(function(){
                    $('#collapseTwo').collapse('show');
                }, 500);
                break;
            case '#collapseTwo':
                self.applicationDetail($(e.currentTarget).attr("data-btn"));
                 //$('#collapseOne').collapse('hide');
                 //$('#collapseTwo').collapse('show');
                setTimeout(function(){
                    $('#btn_collapseThree').show();
                }, 400); 
                setTimeout(function(){
                    $('#collapseThree').collapse('show');
                }, 500);
                break;
            case '#collapseThree':
                self.applicationConditions($(e.currentTarget).attr("data-btn"));
                setTimeout(function(){
                    $('#btn_collapseFour').show();
                }, 400); 
                setTimeout(function(){
                    $('#collapseFour').collapse('show');
                }, 500);
                break;
            case '#collapseFour':
                self.applicationLateralLoad($(e.currentTarget).attr("data-btn"));
                setTimeout(function(){
                    $('#btn_collapseFive').show();
                }, 400); 
                setTimeout(function(){
                    $('#collapseFive').collapse('show');
                }, 500);
                break;
            case '#collapseFive':
                self.applicationOutpuForce($(e.currentTarget).attr("data-btn"));
                setTimeout(function(){
                    $('#btn_collapseSix').show();
                }, 400); 
                setTimeout(function(){
                    $('#collapseSix').collapse('show');
                }, 500);
                break;
             case '#collapseSix':
                 self.applicationSpeed($(e.currentTarget).attr("data-btn"));
                setTimeout(function(){
                    $('#container_additionalParameters').fadeIn("slow");
                    $('html,body').animate({
                        scrollTop:$('#container_additionalParameters').offset().top-135
                    }, 1000);
                }, 700);
                 break;
        }
    };
    self.handleBestItems=function(){
        var itemsAdapted=[];
        itemsAdapted=[
                        {
                            "partNumber":"CD55B50-20",
                            "description":"Compact ISO cylinder",
                            "price":"76,23 €",
                            "delivery":"In stock",
                            "image":"http://content2.smcetech.com/image/medium/2128Em.jpg",
                            "type":"A",
                            "summary":0,
                            "isDisabled":true
                        },
                        {
                            "partNumber":"CD55B50-20M",
                            "description":"Compact ISO cylinder",
                            "price":"76,92 €",
                            "delivery":"In stock",
                            "image":"http://content2.smcetech.com/image/medium/2128Em.jpg",
                            "type":"A",
                            "summary":0,
                            "isDisabled":true
                        },
                        {
                            "partNumber":"CDQ2B50TF-20DZ",
                            "description":"Compact cylinder",
                            "price":"67,37 €",
                            "delivery":"3 days",
                            "image":"http://content2.smcetech.com/image/medium/2031M.jpg",
                            "type":"A",
                            "summary":0,
                            "isDisabled":true
                        },
                        {
                            "partNumber":"CQ2B50TF-20DZ",
                            "description":"Compact cylinder",
                            "price":"52,89 €",
                            "delivery":"3 days",
                            "image":"http://content2.smcetech.com/image/medium/2031M.jpg",
                            "type":"A",
                            "summary":0,
                            "isDisabled":true
                        },
                        {
                            "partNumber":"JCDQA50TF-20",
                            "description":"Compact cylinder – J series",
                            "price":"67,37 €",
                            "delivery":"17 days",
                            "image":"http://content2.smcetech.com/image/medium/2143Cm.jpg",
                            "type":"A",
                            "summary":0,
                            "isDisabled":true
                        },
                        {
                            "partNumber":"JCQA50TF-20",
                            "description":"Compact cylinder – J series",
                            "price":"52,89 €",
                            "delivery":"17 days",
                            "image":"http://content2.smcetech.com/image/medium/2143Cm.jpg",
                            "type":"A",
                            "summary":0,
                            "isDisabled":true
                        },
                        {
                            "partNumber":"MDUB50TF-20DMZ",
                            "description":"Plate cylinder",
                            "price":"97,52 €",
                            "delivery":"17 days",
                            "image":"http://content2.smcetech.com/image/medium/2042D.jpg",
                            "type":"A",
                            "summary":0,
                            "isDisabled":true
                        }
                ];
                $('#psf-select-action').selectpicker('toggle');
                var itemsFuntionality = ko.utils.arrayMap(itemsAdapted, function(item) {
                    return new itemFunctionality(item)
                });
                self.aplicationItems(itemsFuntionality);
                $('#container_bestItems').fadeIn("slow");
        $('html,body').animate({
                scrollTop:$('#container_bestItems').offset().top-135
        }, 1000);
    };
    self.handleBestItems2=function(){
        var itemsAdapted=[];
        itemsAdapted=[
                        {
                            "partNumber":"CDQ2B50TF-20DZ",
                            "description":"Compact cylinder",
                            "price":"67,37 €",
                            "delivery":"3 days",
                            "image":" http://content2.smcetech.com/image/medium/2031M.jpg",
                            "type":"B",
                            "summary":0,
                            "isDisabled":false
                        },
                        {
                            "partNumber":"JCDQA50TF-20",
                            "description":"Compact cylinder – J series",
                            "price":"67,37 €",
                            "delivery":"17 days",
                            "image":"http://content2.smcetech.com/image/medium/2143Cm.jpg",
                            "type":"B",
                            "summary":0,
                            "isDisabled":true
                        },
                        {
                            "partNumber":"CD55B50-20",
                            "description":"Compact ISO cylinder",
                            "price":"76,23 €",
                            "delivery":"In stock",
                            "image":"http://content2.smcetech.com/image/medium/2128Em.jpg",
                            "type":"B",
                            "summary":0,
                            "isDisabled":true
                        }
                ];

                var itemsFuntionality = ko.utils.arrayMap(itemsAdapted, function(item) {
                    return new itemFunctionality(item)
                });
                self.aplicationItems(itemsFuntionality);
                $('#psf-select-rodEndThread').selectpicker('toggle');
                $('#container_bestItems').fadeIn("slow");
                $('html,body').animate({
                        scrollTop:$('#container_bestItems').offset().top-135
                }, 1000);
    };
    self.handleCheckboxItem = function (e,item) {
        var checkboxes = $('#spares-accessories-result-container').find(':checkbox');
        //checkboxes.prop('checked', $(this).is(':checked'));
        if(checkboxes.length>0){
            for (var i = 0; i < checkboxes.length; i++) {
                if (checkboxes[i].checked) {
                    $( "#btn_summary" ).prop( "disabled", false );
                    $( "#btn_addBasket" ).prop( "disabled", false );
                }
            }
        }
        return true;
    };
    
    self.handleSummary=function(){
        self.isSummary(true);
        var itemsAdapted=[];
        itemsAdapted=[
            {
                "partNumber":"CDQ2B50TF-20DZ",
                "description":"Compact cylinder",
                "price":"67,37 €",
                "delivery":"3 days",
                "image":" http://content2.smcetech.com/image/medium/2031M.jpg",
                "type":"C",
                "summary":0,
                "isDisabled":false
            }
        ];
        var itemsFuntionality = ko.utils.arrayMap(itemsAdapted, function(item) {
                    return new itemFunctionality(item)
                });
        self.aplicationItems(itemsFuntionality);
        $("#btn_disabled_dowload").prop( "disabled", false );
    }
}
(function (window) {
    var vmpsf = new ProductsSolutionsFinderByFuntionalityViewModel();
    ko.applyBindings(vmpsf, document.getElementById("psfFuntionalitycontenedor"));   
}(window));